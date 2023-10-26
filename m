Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AD7D85F2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjJZPY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjJZPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:24:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8688C187;
        Thu, 26 Oct 2023 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698333859; x=1729869859;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OufQGj9Nx/4oyNheeJtMS2/FIoZ7GuyYAsF2vnzhl94=;
  b=I0NaaZHscm6Ev1DWMk9jUrHp7EDMknnG7GT86gOS0ksq6IvOKX0Ek+P4
   /dFrIC6PBeRDz4u7vV/3x9QLBypcdPdkty1kt9FQJCtcoTjpHGHeJOntx
   5igOyT5QgBzJKcSOA1U8jmL4UUAck1Bcap8SN56GfQ7fBD7a2jGYr79U6
   jTAxiONAPY7X6oEADMgyoGXJGAsrLvfILGahKvUosu8oR39uHcgr3WMPk
   ioJtXhUELse4gs7G53faRDBL7/vMzsajcB1R6A8nwnUQj+7YkClDF1dhZ
   Fy1Td2gTuRpHkXAv5Eu/AtT+sKnJRwO+9GDfGRcWHOf6bTZ6AIEm7elNK
   g==;
X-CSE-ConnectionGUID: mnYGqr+LRdS8TDsC4XikMQ==
X-CSE-MsgGUID: YEC4EKH6TfC960Z8Kffg2g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="241406395"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 08:24:18 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 08:23:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 26 Oct 2023 08:23:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzQceVSEdunCgtNj8mHkik0GkSZyQFNt9iJnGHT5VgTt+WKST93m8z6ph6MDe3iAsBf3lYvGCRK0vdKL85htyY+/IouA/XMupEww6/owaC4gu7zP+eAZF8CSC8DIeFOJjR48AdTP7rKPQgz13ENlRVIy9RkmaA2Xgk73xH9j/jTJRSt2WWaMLA+xhUl7VIFRpvqZ/SMkQKYsOPnFWpEl51Hd8qbic/nsJlgrVOLxMchCzkWj2edZVKrgqV96NnBJf0+NtfnTTFud7ZL8PPFqHnMj8ilKyWO8hrOpxWCbRwYtyuNuPJOD/0cYcpnsinyS/wU3zMMdgLqvAVdmgR989w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OufQGj9Nx/4oyNheeJtMS2/FIoZ7GuyYAsF2vnzhl94=;
 b=mUg3Rr7PhWhUMbRWT3QWveQSamWVas0S17CeOhz+MJixj0sw0CB+PRdFqKknJRcmi1Vyx9H+/TuqTdkfII7+XnvxDrDFAuZYuqshkN/H8HeDaTJHkqn5sl54gtLw/xhXpcFh9TVwaG3+jipOpuvcD43Oql0EYhk3RfY8muNxguwrJJnbzRWGlyqh89iMiVti3aT2RZl+a81/71DJlnF5NdFnwDWfWjq3y4AKvfi+tyh6crpSUZ4ZGZ/8yn/NXoyglHHNjDCVV/kGyk41dZMInBXdLIKolsq2+xxwJyrJRLjClL7UbISzv+kHlboIkJc5oe5bcWivN6BTXaNRoJChSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OufQGj9Nx/4oyNheeJtMS2/FIoZ7GuyYAsF2vnzhl94=;
 b=sEKgbw0T4QvZbo44guoeAxtOE9sQAio4bB0vm7+0CCGCU2g/g4aTwiFFpaK1W7a3tqIwq6YdHYRhQ8EMcdY/uEv7X+rVu96o73fKw13jonrC91zuYlKMZQQ3gE0Y4kXWcMy82lGWl0U3qdlXdE6BU/t+kr2aCYcf6vSP+Z0Z6Kk=
Received: from IA1PR11MB6395.namprd11.prod.outlook.com (2603:10b6:208:3ac::14)
 by CY8PR11MB7685.namprd11.prod.outlook.com (2603:10b6:930:73::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 15:23:47 +0000
Received: from IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b]) by IA1PR11MB6395.namprd11.prod.outlook.com
 ([fe80::1268:3f:8109:622b%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 15:23:47 +0000
From:   <Marius.Cristea@microchip.com>
To:     <conor@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <lars@metafoo.de>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Topic: [PATCH v2 1/2] dt-bindings: iio: adc: adding dt-bindings for
 PAC193X
Thread-Index: AQHaB0lj9PO1FMJaPku3xMkF5R2gP7Bam5gAgAGWpIA=
Date:   Thu, 26 Oct 2023 15:23:46 +0000
Message-ID: <937af3ec4012c6ec1d66285660d8c56dcf356703.camel@microchip.com>
References: <20231025134404.131485-1-marius.cristea@microchip.com>
         <20231025134404.131485-2-marius.cristea@microchip.com>
         <20231025-cheddar-tucking-b2ea777ed4f9@spud>
In-Reply-To: <20231025-cheddar-tucking-b2ea777ed4f9@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6395:EE_|CY8PR11MB7685:EE_
x-ms-office365-filtering-correlation-id: d8d72538-6930-45c4-5da0-08dbd6378c5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xiatvIZtXL8iep72rBS/BQGXipQ1nnvpgcUm96saR/+wx+cmbiFQJ+Yt1AWpviwsLow9iTaYUnc8Tl1o4pWKB0AlQrO7YtkfBZHg5k8jQtPjp8Q8N0EochDw1jEGC67zUpC0QMk1T4uUpjTnXcz5iFDXNBHUw/wNmazM+MWj5ZOReTN8S9/5eLSEqOuzeCPlAkY7DL3u2TuHbkGBqwDoWx7SBP0mboHIPHUY4iD62hMmDrs94vQlTWtCZPhSmXqTftD11/nQyCYmiTnGnrvRy0RHn5Nvi/hWK8LfZ9AE1clBp9MN2nCRj5mfa7esCjvjKSuqAlIw7Z5XqY1//F40Fct+DsT1iNXegAhrPcO9cakDPv1HFtyCvQOZJ1Mpq4E7IJ+ZUIp2mxE4JU051Ue48fTnAGzbrn0cjNCtYtB9LMR5blhlaFh76G849thWC33M1xdt9W/L1XatgfqQYeCJFYGuRHucJsDFbvZIFPlt2dqVWpGPH1/HN9m0+mnsjil/xAx4lkS6SMQtUwDvkioZCJ5l6gjurfHpUjyOl/suB6LcYIqcveSJFTDchHomh76vpKAfAOD4Oyp68ReMQSVoZZHxdEtaSE77PpKoyhd4V+oPsRU+/L57HyzCkKC6fug6DwiypajXnAQerUjJQh4SgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6395.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(316002)(38100700002)(64756008)(122000001)(6512007)(66446008)(66946007)(76116006)(66476007)(66556008)(54906003)(2616005)(91956017)(6916009)(8936002)(83380400001)(4326008)(8676002)(966005)(478600001)(6486002)(6506007)(71200400001)(41300700001)(4001150100001)(2906002)(38070700009)(5660300002)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGRMSWVBeW9pcklWZkNMOEFOMlEwY0h4MjAzTTMxWEZ2RmM5bUVJcVlvTTJw?=
 =?utf-8?B?K2pMY0dBems3M0x2elBGNzhjb2FqdStKb2dEUXIzYlJVWGx1d3U0TnN2RjVY?=
 =?utf-8?B?WnlIN3IvbWJBSUtveTExN0dmdFQ4ZW5vSENTZGdNUDZ4QkNzY3hvTjlDRnlL?=
 =?utf-8?B?RmtDS2I2eTJ6YzE2NDRZdGNzU0EzdWxaSWxGcEhKZHdmUEZYRWlUSXdCTXdo?=
 =?utf-8?B?c0dqeFEyb3ZjeHhHeVkyV0VKeEJ6R0lNUmE4aWFNekI0L0I0U0VkY2V5VVQw?=
 =?utf-8?B?My92RFRGNlJHYmtWL3QvS3dnd25SU3RNeFllUHBheW5oZ1FCa21qRXMyTC9O?=
 =?utf-8?B?K1V6UmRicUluc2M5M3FiV2ptK2ZNODJETHQrOEVDRXVDcWkrS1N5UHF2MmVm?=
 =?utf-8?B?NXM3UjFNeUV3VFRCOVc2Vkgrem5pYVE1MG5TV0NhTGlPMmZ4QWtlaEhid1BD?=
 =?utf-8?B?dG5JcFdyc2M3YXZxMVFsZmlSNTd5THpuQ2YySzZaMjRvYmkranRBbEhJSm9j?=
 =?utf-8?B?Qzk1Y3JQa1pJKzRpRFY3SjdVYy9TRVNnb0pBYWdiMW9VWW5mNlFsbjhIeTNi?=
 =?utf-8?B?S1k4R01RZm8wUHhNbWxYaGdtU05KbjhKQUoyMFVPb0w5bDEyLzJRYXVhQi80?=
 =?utf-8?B?RVlEelA3OVZLSEUzaHpOWU1TM3FIUDhyM3FsR1RIRk96clBUQTdxTVU0ZEs5?=
 =?utf-8?B?SWtUc2VTeVA0d01TVTlpM3Bhc0xWYUdxL0xKRE5WQmR4a0djQnlLSFZmZkdJ?=
 =?utf-8?B?SzZKVmF5WDBYd21nUGVsWm1GenJBZEdwK2FQejdiMDRFU3EyUlFTcGY4QzZS?=
 =?utf-8?B?UVRGL3J3TTFnRUJGV3lNZGxDR3V1YVcyd3RYR2VxYlhsTjNYR292TnZRYVdi?=
 =?utf-8?B?L0FFTVNIQUtFSDVDUmVUd1o2VXBYaEl5WUlPamwrazNoUXJqZjRHazduQjBZ?=
 =?utf-8?B?NG52SjB4aW9YMWJNNUM2ZkZWd0ZCaHpwSnZKNHdta2lvdHF2MmhqamNqeWlD?=
 =?utf-8?B?YmJYZk51bXRFWXVvQks0UkJXU01UV1BmRnlIZDVRZ0JQODZWMkFaWGZXbWJ6?=
 =?utf-8?B?Qis4eGZ4b3JMVHVyQ3pzd2xJZnBuUzRlek5WZVh3RzdKWVhYOTJmaVFNeE5L?=
 =?utf-8?B?VkI1YTFsZGJvUWdGTGRlblRWNjVWMmw5N2NaTnptVmViMmkrUTRJcjR4cVR5?=
 =?utf-8?B?Zm9xUS8xczR5UUtieVV2elduU3hYUVNnb2hpN0VscTUvYVFnSDFzMlEyYzBR?=
 =?utf-8?B?Zlo1dDM3M0crVWtIaWNaSERya3g3eFBaandxd24zaVRRQitRTzFvTFRpc3Fi?=
 =?utf-8?B?Titzd255bU91SEZKSVlacTVtUGVjc1JnZDI1SUNmVDdNK2d1enZPb2FCcUFa?=
 =?utf-8?B?WXN3UVNPamJ5aUVLc0hDZHA0Szc0Uy8zMXJueGltSkpwNHpFc0RyRHlkelFT?=
 =?utf-8?B?TGFjVUx1NlBRV0RJN0RyZkYrSExIeUYwVGNjTVRHWWtQb2hlay9OdmpucHB4?=
 =?utf-8?B?emllK01XVEtWUUdCc0dQSUhIMEJTemJwemdiV0ZROFBIOWdFeVZKK3lFZ1Ey?=
 =?utf-8?B?OVdvR3A2SDJaVkNsQ1VqQ2pjVnVaVXBiK3phMC9FMWd0NkZOenlHT1FvQ3Bj?=
 =?utf-8?B?djRFWHdpTDRqUnQ4NjNjVnNIU2krVkEweW5URHpadFB6WTcxVExaMkFZVTZI?=
 =?utf-8?B?L3dmSU5xdWFMSGFOUStJKys2V2lHOEg0bmQ5Sm9jaWdLdUh3bHd0MGZObnZM?=
 =?utf-8?B?aUhkZnBOMDMxT0lpZ3RWZUFmVW1CN0F0cHlZaGpTc3BCenNPdkFiVmhIc2hU?=
 =?utf-8?B?Tmc2SUs3T2N1Sk14YWhXUjYvL3dFaGZPYmYweStVRmpjVWZTdUw3RjEvNTF5?=
 =?utf-8?B?cE9uVDltQVFRYWNZYjVYalNvcFFaWWpjK05BbmlHWTJMN3E4RHgzbzlRaWRB?=
 =?utf-8?B?OTVPZENabzhUV29BMjlvYVZOeTl0a2NsRTJsbmgySGF4SGxKdGJQWVpTeVli?=
 =?utf-8?B?R0hvNWViNjdlaDZHRlVIditmUGxLdzloN0hWREtSdk1nWHQzRXo0N3c3aUhm?=
 =?utf-8?B?UXBicXNzZFhXSUVWazdJM2lSbVY2TFFoWng3aXlTNGFyaW1OUHY0eHdkdTJh?=
 =?utf-8?B?STM4d2lyUWxHUDgrenZHWlU0eUJSYXVRY0xQT1RLSGFycDBieVE3d2xwMzk5?=
 =?utf-8?Q?cEflG6+DabVeD3xr+TAruXs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F0FAE95B119242BE8FC95F3EEF0830@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6395.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d72538-6930-45c4-5da0-08dbd6378c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 15:23:46.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9GZxRLgfcLTlxU5e6hnvenWyxwQ+itjAfBB1WmRuT51/6ayJP//xBDOdr2Q0ersWeOb9hYc10tNoSRH2oz5u6VEINJbbEwq/O41eH3gdiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7685
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29ub3IsDQoNCk9uIFdlZCwgMjAyMy0xMC0yNSBhdCAxNjowOCArMDEwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiBIZXkgTWFyaXVzLA0KPiANCj4gT24gV2VkLCBPY3QgMjUsIDIwMjMgYXQg
MDQ6NDQ6MDNQTSArMDMwMCwNCj4gbWFyaXVzLmNyaXN0ZWFAbWljcm9jaGlwLmNvbcKgd3JvdGU6
DQo+ID4gRnJvbTogTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVhQG1pY3JvY2hpcC5jb20+
DQo+ID4gDQo+ID4gVGhpcyBpcyB0aGUgZGV2aWNlIHRyZWUgc2NoZW1hIGZvciBpaW8gZHJpdmVy
IGZvcg0KPiA+IE1pY3JvY2hpcCBQQUMxOTNYIHNlcmllcyBvZiBQb3dlciBNb25pdG9ycyB3aXRo
IEFjY3VtdWxhdG9yLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcml1cyBDcmlzdGVhIDxt
YXJpdXMuY3Jpc3RlYUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+IMKgLi4uL2JpbmRpbmdz
L2lpby9hZGMvbWljcm9jaGlwLHBhYzE5MzQueWFtbMKgwqAgfCAxNDYNCj4gPiArKysrKysrKysr
KysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKQ0KPiA+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2lpby9hZGMvbWljcm9jaGlwLHBhYzE5MzQueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4g
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL21pY3JvY2hpcCxw
YWMxOTM0LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8v
YWRjL21pY3JvY2hpcCxwYWMxOTM0LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+
IGluZGV4IDAwMDAwMDAwMDAwMC4uODM3MDUzZWQ4YTcxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+
ICsrKw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvbWlj
cm9jaGlwLHBhYzE5MzQueWFtbA0KPiA+IEBAIC0wLDAgKzEsMTQ2IEBADQo+ID4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwg
MS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2lp
by9hZGMvbWljcm9jaGlwLHBhYzE5MzQueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWlj
cm9jaGlwIFBBQzE5MzQgUG93ZXIgTW9uaXRvcnMgd2l0aCBBY2N1bXVsYXRvcg0KPiA+ICsNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gK8KgIC0gTWFyaXVzIENyaXN0ZWEgPG1hcml1cy5jcmlzdGVh
QG1pY3JvY2hpcC5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICvCoCBCaW5k
aW5ncyBmb3IgdGhlIE1pY3JvY2hpcCBmYW1pbHkgb2YgUG93ZXIgTW9uaXRvcnMgd2l0aA0KPiA+
IEFjY3VtdWxhdG9yLg0KPiA+ICvCoCBUaGUgZGF0YXNoZWV0IGZvciBQQUMxOTMxLCBQQUMxOTMy
LCBQQUMxOTMzIGFuZCBQQUMxOTM0IGNhbiBiZQ0KPiA+IGZvdW5kIGhlcmU6DQo+ID4gK8KgwqDC
oA0KPiA+IGh0dHBzOi8vd3cxLm1pY3JvY2hpcC5jb20vZG93bmxvYWRzL2FlbURvY3VtZW50cy9k
b2N1bWVudHMvT1RIL1Byb2R1Y3REb2N1bWVudHMvRGF0YVNoZWV0cy9QQUMxOTMxLUZhbWlseS1E
YXRhLVNoZWV0LURTMjAwMDU4NTBFLnBkZg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiAr
wqAgY29tcGF0aWJsZToNCj4gPiArwqDCoMKgIGVudW06DQo+ID4gK8KgwqDCoMKgwqAgLSBtaWNy
b2NoaXAscGFjMTkzMQ0KPiA+ICvCoMKgwqDCoMKgIC0gbWljcm9jaGlwLHBhYzE5MzINCj4gPiAr
wqDCoMKgwqDCoCAtIG1pY3JvY2hpcCxwYWMxOTMzDQo+ID4gK8KgwqDCoMKgwqAgLSBtaWNyb2No
aXAscGFjMTkzNA0KPiA+ICsNCj4gPiArwqAgcmVnOg0KPiA+ICvCoMKgwqAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gK8KgICIjYWRkcmVzcy1jZWxscyI6DQo+ID4gK8KgwqDCoCBjb25zdDogMQ0K
PiA+ICsNCj4gPiArwqAgIiNzaXplLWNlbGxzIjoNCj4gPiArwqDCoMKgIGNvbnN0OiAwDQo+ID4g
Kw0KPiA+ICvCoCBpbnRlcnJ1cHRzOg0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246IElSUSBsaW5l
IG9mIHRoZSBBREMNCj4gPiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICvCoCBkcml2
ZS1vcGVuLWRyYWluOg0KPiA+ICvCoMKgwqAgZGVzY3JpcHRpb246IFRoZSBJUlEgc2lnbmFsIGlz
IGNvbmZpZ3VyZWQgYXMgb3Blbi1kcmFpbi4NCj4gPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4g
PiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICvCoCBtaWNyb2NoaXAsc2xvdy1pbzoN
Cj4gPiArwqDCoMKgIHR5cGU6IGJvb2xlYW4NCj4gPiArwqDCoMKgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gK8KgwqDCoMKgwqAgQSBHUElPIHVzZWQgdG8gdHJpZ2dlciBhIGNoYW5nZSBpcyBzYW1wbGlu
ZyByYXRlIChsb3dlcmluZw0KPiA+IHRoZSBjaGlwIHBvd2VyIGNvbnN1bXB0aW9uKS4NCj4gPiAr
wqDCoMKgwqDCoCBJbiBkZWZhdWx0IG1vZGUsIGlmIHRoaXMgcGluIGlzIGZvcmNlZCBoaWdoLCBz
YW1wbGluZyByYXRlDQo+ID4gaXMgZm9yY2VkIHRvIGVpZ2h0DQo+ID4gK8KgwqDCoMKgwqAgc2Ft
cGxlcy9zZWNvbmQuIFdoZW4gaXQgaXMgZm9yY2VkIGxvdywgdGhlIHNhbXBsaW5nIHJhdGUgaXMN
Cj4gPiAxMDI0IHNhbXBsZXMvc2Vjb25kIHVubGVzcw0KPiA+ICvCoMKgwqDCoMKgIGEgZGlmZmVy
ZW50IHNhbXBsZSByYXRlIGhhcyBiZWVuIHByb2dyYW1tZWQuDQo+IA0KPiBUaGlzIGRlc2NyaXB0
aW9uIGRvZXNuJ3QgcmVhbGx5IG1ha2Ugc2Vuc2UgdG8gbWUgLSBpZiBhIEdQSU8gaXMgdXNlZA0K
PiB0bw0KPiBkcml2ZSB0aGUgcGluIGxvdyBvciBoaWdoLCB3aHkgZG8gd2UgbmVlZCBhIHByb3Bl
cnR5PyBBIERUIHByb3BlcnR5DQo+IGltcGxpZXMgdGhhdCB0aGlzIGlzIGEgc3RhdGljIGNvbmZp
Z3VyYXRpb24gZGVwZW5kaW5nIG9uIHRoZSBib2FyZCwNCj4gYnV0DQo+IHJlYWRpbmcgdGhlIGRl
c2NyaXB0aW9uIHRoaXMgc2VlbXMgdG8gYmUgc29tZXRoaW5nIHRoYXQgY2FuIGJlDQo+IHRvZ2ds
ZWQNCj4gYXQgcnVudGltZS4NCj4gSSBkbyBub3RlIHRob3VnaCwgdGhhdCB0aGlzIEdQSU8gaXMg
bm90IGRvY3VtZW50ZWQgaW4gdGhlIGJpbmRpbmcsIHNvDQo+IEkNCj4gc3VwcG9zZSB3aGF0IHJl
YWxseSBuZWVkcyB0byBoYXBwZW4gaGVyZSBpcyBkb2N1bWVudCB0aGUgZ3BpbyBzbyB0aGF0DQo+
IHRoZSBkcml2ZXIgY2FuIGRldGVybWluZSBhdCBydW50aW1lIHdoYXQgc3RhdGUgdGhpcyBwaW4g
aXMgaW4/DQo+IA0KPiBBbHNvLCB5b3Ugc2F5ICJJbiBkZWZhdWx0IG1vZGUiLCBidXQgZG9uJ3Qg
bWVudGlvbiB3aGF0IHRoZSBub24tDQo+IGRlZmF1bHQNCj4gbW9kZSBpcy4gV2hhdCBoYXBwZW5z
IGluIHRoZSBvdGhlciBtb2RlPw0KPiANCj4gQ2hlZXJzLA0KPiBDb25vci4NCg0KVGhpcyBpcyBh
ICJkb3VibGUgZnVuY3Rpb24iIHBpbi4gT24gdGhlIFBBQzE5M3ggdGhlcmUgaXMgdGhlIFNMT1cv
QUxFUlQNCnBpbi4gQXQgcnVudGltZSB0aGlzIHBpbiBjb3VsZCBiZSBjb25maWd1cmVkIGFzIGFu
IGlucHV0IHRvIHRoZSBQQUMgYW5kDQp0aGUgZnVuY3Rpb25hbGl0eSB3aWxsIGJlICJTTE9XIiB0
aGF0IG1lYW5zIGlmIGl0IGlzIGZvcmNlZCBoaWdoLCB0aGUNClBBQyB3aWxsIHdvcmsgaW4gbG93
IHBvd2VyIG1vZGUgYnkgY2hhbmdpbmcgdGhlIHNhbXBsZSByYXRlIHRvIDggU1BTLg0KSWYgaXQn
cyBmb3JjZWQgbG93IHRoZSBQQUMgd2lsbCB3b3JrIGF0IGl0J3MgZnVsbCBzYW1wbGUgcmF0ZS4N
Cg0KIlNMT1ciIGlzIHRoZSBkZWZhdWx0IGZ1bmN0aW9uIG9mIHRoZSBwaW4gYnV0IGl0IG1heSBi
ZSBwcm9ncmFtbWVkIHRvDQpmdW5jdGlvbiBhcyBBTEVSVCBwaW4gKE9wZW4gQ29sbGVjdG9yIHdo
ZW4gZnVuY3Rpb25pbmcgYXMgQUxFUlQsDQpyZXF1aXJlcyBwdWxsLXVwIHJlc2lzdG9yIHRvIFZE
RCBJL08pLiBUaGlzIHRpbWUgdGhlIHBpbiB3aWxsIGJlIHNldCBhcw0Kb3V0cHV0IGZyb20gUEFD
IChBTEVSVCBmdW5jdGlvbmFsaXR5KSB0byB0cmlnZ2VyIGFuIGludGVycnVwdCB0byB0aGUNCnN5
c3RlbSAodGhpcyBpcyBjb3ZlcmVkIGJ5IHRoZSBpbnRlcnJ1cHRzIGFuZCBkcml2ZS1vcGVuLWRy
YWluKS4NCg0KVGhlIHN5c3RlbSBjb3VsZCB3b3JrIGZpbmUgd2l0aG91dCB0aGlzIHBpbi4gVGhl
IGRyaXZlciBkb2Vzbid0IHVzZQ0KaW50ZXJydXB0IGF0IHRoaXMgdGltZSwgYnV0IGl0IGNvdWxk
IGJlIGV4dGVuZGVkLg0KDQpUaGFua3MsDQpNYXJpdXMNCg0K
