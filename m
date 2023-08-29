Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0D78C02C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjH2IW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbjH2IWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:22:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAD4E9;
        Tue, 29 Aug 2023 01:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693297365; x=1724833365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ffxOonbk4uG5JZYQV2ZjACG6aGqN6tGf4oZ7Qpuck9U=;
  b=Xm0yB5KMe0hyp6ITVqHvkcDMA62f0+45oXfwCmhDjP/H4Sk02jZ+TWpu
   pUjpV6UZ4AvhRzGl72jQVJssyEnJNtqvslzPDfRLygBuclCXG7imeA0WO
   9uQS7atsev9Qi+qLdcUkkSRJrsmEaxYYgmx2pLmsqY6yeBvBB5N4o5K7t
   TAWQmfprgZRTXtuOM7+HGAYIFd1TIjVZQwsKISO2zoZxVjFH6SlJ9Z8Cf
   t3OaRuF4rjNOLrrRr9fuZOnrT1ba3VbVXA5gyyy680+/CZVAkWKfa7ARH
   lfHWSA4KFj9+X+MQCGjM3m22pD+wIOWNSf+/U+t8gsplC/QQxmuj4kMe0
   w==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1782156"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Aug 2023 01:22:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 29 Aug 2023 01:22:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 29 Aug 2023 01:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyOisIl5H0tePeugnFnlopkrEaInAOIzz85OEYBb+5rYtYGjgeGq0cVxEIwFnAVNJJGBXkLgzZvk2V7XWmrWFNojWmY53ZL78gSf5Sws6SUS0RqicSbUAxyLtheEVtReCaJAOfqn7mUdu91W7ipqWj9QN6+k9ZB8OGxJclpPdxmSO30GIJbzsbJTrbl0YAtXRkMmYGStyiFC5g0vk7Cb8jA5NkXWJtB+nvDtJQhdWjRWEQ+OYvD4yWThrHWUezwaAj3bGTBbUhLceoPBf+NE5WLi3hZro50UpmrYxbUvmLnq9lIV9G8N+kgOHEqiugdVQxOrLyLKwWZrJZQng8cexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffxOonbk4uG5JZYQV2ZjACG6aGqN6tGf4oZ7Qpuck9U=;
 b=MFsdCuAAxy5ZzTXu3lURUQFBhxExOGNfadCJQdKAg5wTEKPk8w5ftieG9ZJ98HW4gTmNaAmgRmq0vXJmdrCQUXtjAPha1eyUotDdSJJAQhYPRREkG2e35kAD9mQL86jnh10ZrRW2+BRFEB5AaS3Cpjz07daChx8Pu2FeE4OuLDdMfbUYAAo2hMHcf8iWkqHPAf0snBN10HFTVb0kKLH1KBNimf5jeH7fkaC5+bnscemMGFWFry2z+utHUrhl4HjxP8FIirvvHM4sL4OGlTOMCX3UUp+O2rWCoL3hzUw/puwWrElrIT66ojkBCr2k0p+v4RnAanSKlckHUcBxFFKOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffxOonbk4uG5JZYQV2ZjACG6aGqN6tGf4oZ7Qpuck9U=;
 b=ogoixvs3gfO5lycMQpC90TxyiQ0ldPEgkVFeZkWjz/2jFKQw1ltihcGU2/ZJ9sKuammYmyg94S2gJy6l8GGuIUK7rrjlNaDMjgpYWC7p4A0vxXpKSj0xyi2BnFDPoBWRBkBLjLv80eq90Mz/1X20Gw52XxzFJXiLpGMxdrzr11Q=
Received: from PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9)
 by DS0PR11MB7652.namprd11.prod.outlook.com (2603:10b6:8:14e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 08:22:15 +0000
Received: from PH7PR11MB6403.namprd11.prod.outlook.com
 ([fe80::aabe:19f9:915:b97e]) by PH7PR11MB6403.namprd11.prod.outlook.com
 ([fe80::aabe:19f9:915:b97e%4]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 08:22:15 +0000
From:   <Marius.Cristea@microchip.com>
To:     <jic23@kernel.org>
CC:     <devicetree@vger.kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: adc: adding support for MCP3564 ADC
Thread-Topic: [PATCH v4 2/2] iio: adc: adding support for MCP3564 ADC
Thread-Index: AQHZ0fUtS2GyhDbLdE6x3sxNs+CUNq//0JGAgAEvV4A=
Date:   Tue, 29 Aug 2023 08:22:15 +0000
Message-ID: <9e81a4bb1afcf5a36a0a0ec90a149020c9c0cbdf.camel@microchip.com>
References: <20230818165750.55406-1-marius.cristea@microchip.com>
         <20230818165750.55406-3-marius.cristea@microchip.com>
         <20230828151631.6a60282b@jic23-huawei>
In-Reply-To: <20230828151631.6a60282b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6403:EE_|DS0PR11MB7652:EE_
x-ms-office365-filtering-correlation-id: adc87b9b-2d90-4530-cd5f-08dba8690d43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c++oGOJ4LVDHMeCBUuFkQZlR/3wd/AviBjItlvbEZlFY+yZyfHKF/8U2ime/+7zjcd9y2Z1hRoAqRddqrqy079M3U7RJEydVpeYxbx8BwY+EA7JeZqpCFLhib4HDn8qH9qH0ihgblZRsg3lH+gDGqMgEVAaZtc029NkOGj9R3Lii/hwKHTSciQAzpF8jhFOSRoxdrCz5DZtM0dyd0KDb4DSaf5oE7WaKSkSRtuPE+nbfnLBcJJ7Nvyp7J9shbDyiJdBOSVnqXtb28WTvhgL5jLx+/4/OmFYaalcdpgL8qoOGZ+weQJ9qZCbmIcGoM7KHKssM6GEmbdG8gS7Hg/dcOC4N4qTrlsgPRESZzIHI6VnnG5oVCf7q4E0wf3lMuwIp4f+HT152yjKDbjT239dW1IMPZtuNxqBp8kxbHTuvYXd9ew1PCNlWunYIvDmzz1kOwFwO2yoqMfLmjc6KQxBNnUdaS4G0hcV0sdybDhKjcv7l2FHbQ2TwmekbxZ1/HxM9WqY1MpH3pmHPfQQZVcd21qFLDqxlOhrMnPzob+Aa5pjtSkJTr5BXQ6RibyzAT4OcsArJJ5iy+oPoXpzWfiUBJHlmbs8d7Nr8f4NGxTUMm1bz8+50Mo3fZXiozy+YgepD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6403.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(6512007)(6486002)(6506007)(71200400001)(478600001)(83380400001)(76116006)(26005)(2906002)(54906003)(2616005)(316002)(64756008)(6916009)(66446008)(66476007)(66946007)(66556008)(91956017)(41300700001)(8936002)(5660300002)(8676002)(4326008)(36756003)(122000001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXB3ZnJQQVVhTXE1QnQvNlB1N3FhT2RHR1YzOE1nRjcrUEE1b2Fid05JOCtC?=
 =?utf-8?B?eTIza3RtT1AvWDM1UitrVWdycjJIVm9UMmNFSk5rL20xOGJpOWt0dVBlVm1u?=
 =?utf-8?B?R0IzajBhaSt6cHp5VDU4SzhTUFBmVTZ6TUxSRDIyUitGVFQxb24wS1NOV3Ez?=
 =?utf-8?B?Q2lRTUF4YjlETGw3bUdMd2l4eTUwc0JVME1HSzJYUjM3YUVEdzJ0eWVjVDBp?=
 =?utf-8?B?L1pYTnpvQ0FET0sySHVXYmZEd0tFL05XUk1OcTh4T2tjdmNEVTlDL0NEUFND?=
 =?utf-8?B?SVR3aS9TL1UzQkc0S3Jsc1E1cWhwUEZJaGV3UU8vSk9mbXQyQkt1VEt6RnU5?=
 =?utf-8?B?SjZrRmRIRGRRdUZJVXBUTWFkWCsybVhQcm1WVzIwdExTZVhQTzQ0ODdwMWN0?=
 =?utf-8?B?SG5UREZyTytHM3djc1NIbFpWczhoTUt4QkJjdVA4WVMyR1NyenlCSVFGdlhV?=
 =?utf-8?B?amNBMTAzWEtxQjlQN3FHOTdSOXR5K1djbjlxMEhjMWl1dmRQUXN3N2xmVTFU?=
 =?utf-8?B?c1g0Q3RZall0TitacDFKTEVHUnA5VWZGdDhJaUJrM3dsdUZsRUQ0d3JhNVBZ?=
 =?utf-8?B?Z3B1ejZkL1ZrNjJWb1FLdWFoMkoxRHlyVENKeGJJcXpld0NXVUNGMTZqeXl1?=
 =?utf-8?B?cCswSXZ6YnJvczN4dy9tZWFZV1ZNUC9vTjl1bjRSZldBYjZhaVVQdjNQK2xj?=
 =?utf-8?B?T1JPcWZmN25mVnZRQmxTRUtWZy9kVkhZdGh2YVdzSHl5YnQ0Z0hTYjcyaTMx?=
 =?utf-8?B?VHVmMkxENE9PSWJsVGRra2preTZ4MWF2MUJwOE5BN1RhT2pOS3RrL3NhTXdF?=
 =?utf-8?B?VUlrM0pMNFdVcm93NHd3Yyt5ZE15NW1nRklMSStpdVlQbTZIYWhjN004UFN5?=
 =?utf-8?B?c2N4UDM5VjFCQUo5elZYVW5GWFd1WWZFQTZqN1c1QWNHaEJQVWhQUW5XT29F?=
 =?utf-8?B?ZzhaVCtHbGdpS2pJQ0VBQWppSUpPQzI5d2dvZHIrajdPY0FlajR1L0Uwb1Vk?=
 =?utf-8?B?QVc0ZnF4VnZsbVkvdXJjT3JOZ25KVXJCbjFndGNaNjVKS3MyQk9UQTRpK2FY?=
 =?utf-8?B?bHhqRDFtUmtSZHRnMXFmSnpkWUpYSDlIbXZsRWZNY3A4NFdkcjN1T0pWVGJV?=
 =?utf-8?B?Y1hKYnZUVG43OFdUYlpQWUlUaW9KZFhMemFBQ1JZclQwTFVFNkpaeTc5bFl3?=
 =?utf-8?B?c0loalJaelM5ZlR1R0x5NXZaN256TVcwTi9tdlNBZWtrdnROVUdSbVdpL2xj?=
 =?utf-8?B?anZxTm1sWm9BS2VzYlBlVTZvZjJiMk5UTGxXZDcrcG1iem5JNUF4V1pYVTdq?=
 =?utf-8?B?ODhMNjVhUXRpaTB6U1E2V3ZJNHhnOCtydEFseXBZNWF1TmFRYlJwL0RsNFBD?=
 =?utf-8?B?YlUyK2lsOEs4R090S2ZqbjlSM2JFYWc5aEN5ZzEzSmJBUjdrcUNwNVZWOC90?=
 =?utf-8?B?WDRjVkNVRy9HWnBTZjFjYkppVmJuTHBVM2MwSFU4dHppdXljaXNjOGI0b3VR?=
 =?utf-8?B?NDJRcWFkZzlxUS9CQVJ3QTBhZ2xMR1dERUFBTGVOYVdVMEU3TzE4ZnlrbFBx?=
 =?utf-8?B?a280cGRKMWNRcE9iUjcwNzRlNGVRcFRLVnBOd1dESnNqQzRwcGhrTWFLY2Zx?=
 =?utf-8?B?MVpIRWlvNDhCUmpabExJRmpXcFZQQmdQdndwMlpNbnoxS3VQaFRlS3pWeFhp?=
 =?utf-8?B?SkJTS0hnVEV2WTNFdW1iM1NsSWlYOTBublVNN3BJRVdCQWZYOU0rM1REaHZl?=
 =?utf-8?B?dUliNk5DZ0ZQNFRSMXJ4SnhJZFVicXdiTTd4NGtwZ2swTkNTNURjR2FqcWty?=
 =?utf-8?B?S0V4b1FzYWY1Q0ZaSlhYOHFKazFEb3hWVGNWNFVzUkUvUTZXQlRrNUtQdkNH?=
 =?utf-8?B?eEVUbzFodnR1Z1NRRjN2MDlGUVlxR2M4WFlQVWhEWDEzTXBmSUtSY0JpVUVQ?=
 =?utf-8?B?WE1qQTRoRGdnSTRua1hUcVBYZXV1c2YrbUM4S0RPRmx4K1ZmL3k0UHU1eFJY?=
 =?utf-8?B?V0RZaWEwdldJODRCb3F6YTAwUTFBanJDQkJ1bWJQcGtEMEQwdWk5d3FGdSt6?=
 =?utf-8?B?RmhNcDRiVGdWR1lsbXNQRzN6OHI4N1hNeDNRSCtDeXlhMms5NC9xZThsQy9W?=
 =?utf-8?B?YUhpVWRTS2xDUkpBaS94WlRTT0pYTC9tTzFJemw5bm9EN3NEekJlYVVKVTd0?=
 =?utf-8?Q?OKIRcb49W6WLZUCTioFfIpk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68FDF3D077D2B94899FBE2365A5A3E61@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6403.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc87b9b-2d90-4530-cd5f-08dba8690d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 08:22:15.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VhNFi7oA55U4XUMCqAzwA+xTYJzvvDl551/ir3jb/T/ZEK6aw2mu7G/S5TpUcoFeHDFWl5oOHXRDUyJzRO+tV4hnLvr5lqRjcc7luuOuU1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uYXRoYW4sDQoNClBsZWFzZSwgc2VlIGJlbG93Og0KDQoNCj4gPiArc3RhdGljIGludCBt
Y3AzNTY0X3VwZGF0ZV84Yml0cyhzdHJ1Y3QgbWNwMzU2NF9zdGF0ZSAqYWRjLCB1OCByZWcsDQo+
ID4gdTMyIG1hc2ssIHU4IHZhbCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoCB1OCB0bXA7DQo+ID4g
K8KgwqDCoMKgIGludCByZXQ7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoCByZXQgPSBtY3AzNTY0X3Jl
YWRfOGJpdHMoYWRjLCByZWcsICZ0bXApOw0KPiA+ICvCoMKgwqDCoCBpZiAocmV0IDwgMCkNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICvCoMKg
wqDCoCB2YWwgJj0gbWFzazsNCj4gVGhpcyBsb29rcyB3cm9uZyAtIHdvdWxkIGV4cGVjdCB0aGlz
IHRvIGJlDQo+IMKgwqDCoMKgwqDCoMKgIHZhbCAmPSB+bWFzazsgLy8gd2lwZSBvdXQgdGhlIGJp
dHMgaW4gbWFzay4NCj4gPiANCg0KQWN0dWFsbHkgYW0gZG9pbmcgdGhlIG9wcGVyYXRpb24gdHdp
Y2UgKHRoZSB2YWwgaXMgYWxyZWFkeSBjb3JyZWN0IGJ5DQp1c2luZyBGSUVMRF9QUkVQIHdoZW4g
Y2FsbGluZyBtY3AzNTY0X3VwZGF0ZV84Yml0cykuIEknbSBtYWtpbmcgc3VyZQ0KdGhhdCB0aGUg
dmFsdWUgcmVjZWl2ZWQgaGFzIG9ubHkgdGhlIG1hc2sgYml0cyB2YWxpZC4NCg0KDQo+ID4gK8Kg
wqDCoMKgIHZhbCB8PSB0bXAgJiB+bWFzazsNCj4gYW5kDQo+IMKgwqDCoMKgwqDCoMKgIHZhbCB8
PSB0bXAgJiBtYXNrO8KgIC8vd3JpdGUgdGhlIGJpdHNzIGluIG1hc2suDQo+IA0KPiBJcyB0aGUg
bWFzayB0aGUgaW52ZXJzZSA/wqAgQXQgZmlyc3QgZ2xhbmNlIGl0IGRvZXNuJ3Qgc2VlbSB0byBi
ZS4NCj4gDQo+IA0KDQpUaGUgdG1wIGlzIHRoZSB2YWx1ZSB0aGF0IHdhcyByZWFkIGZyb20gdGhl
IGhhcmR3YXJlIChJIG5lZWQgbm90IHRvDQp0b3VjaC9vdmVyd3JpdGUgKH5tYXNrKSBiaXRzKS4g
InRtcCAmIH5tYXNrIiB3aWxsIGNsZWFyIHRoZSBtYXNrIGJpdHMNCmZyb20gdGhlIGhhcmR3YXJl
LCBpbiBvcmRlciB0byBtYWtlIHRoZSAifCIgd2l0aCB0aGUgdmFsLg0KDQpBY3R1YWxseSBteSBs
b2dpYyBpcyBhIGxpdHRsZSBiaXQgdHdpc3RlZC4gSSBjYW4gcmV3cml0ZSBpdCB0byBiZSBtb3Jl
DQpjbGVhci4NCg0KDQoNClRoYW5rcywNCk1hcml1cw0K
