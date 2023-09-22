Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6CC7AA7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjIVEj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjIVEjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:39:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C64197;
        Thu, 21 Sep 2023 21:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695357557; x=1726893557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LT/CAVx3gq3oUNmNRoRs/8vvfBHCdFvnq/O1vv3G7Uo=;
  b=SJ1KUhbuWxRm3fVoj8N7ud4jrlmQIS51alq74prj2w59fxs7DyRxhyMr
   oy1l3XzolrmX/vAimZAeaBYwezT47mzBGOp0Um2VKo2TiGzlZpQaVxD67
   w8n/yf9qXo7BfswW7hXW+SK2/06E1nKP05Pr/dA4JgeCcl12S+sv0uP9x
   B71aEnGVfoKbT3rZRSc9zs2/rnBPMWivV1T86NenNHxiConk5H1wrKv+g
   1/bZMFr82EQByTjlqqqqdin+3xer05tCy/3BLjaZLNYr3dk1N6dCJo+sv
   EG1isJH+M4YQ6iVpnao3L88iXhAS0XsU/c1BXlKjWhjgQAcb/NVACjmC5
   w==;
X-CSE-ConnectionGUID: hRZwjWP0TaCYDDShV5BdDg==
X-CSE-MsgGUID: IvvgAwXdT7WvLlptjGVMjQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="5868300"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 21:39:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 21:39:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 21:39:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvnfIEcTqOD06QOIIv3d3kg237k11FyzpjUECfL0g+acmdJUZpmuCAVFS1cChfELNGa+pn+dhsV6JNEEIeqbhiH1A3f8f32wys52MLcExR9BLGXQsT/SBa+Ky8xA/4D+NVqbE9bH7HwoW2V/pWxNdacE+XgdE57tB8xFWf533TxVY6eGYValbInXOrXil+OM5/bbLpjVhQ24u19YY79/fwAUUjtKBBXVtDg9g8laNAm2q+laGAGgnTn8hkNg1SkCg1QGLVwa5+a8a2Pov6GGoczk7v7he4BND98PDGn4NjxVd6a+pHpOQZX4rhqSlrJYT6q3UXZMrx5pk1AfS7Ar0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LT/CAVx3gq3oUNmNRoRs/8vvfBHCdFvnq/O1vv3G7Uo=;
 b=ckiyGI00S/ImIAklNiIU6+MwSEcs2br4rGSe5BJGJW+Z6IPBlmvb7kcTJBpN1sCWdDzQkGJN9y7vpzeFVoQvJK2hvloQKl87XWFiFaTUh0pgMZ07AVG7iI7egS9rkVtxF53pMg8anj7YBNX9+dX/Dl9NrTRiv8DviiK7IvispsmlBWh7JCUIMcSO3X8run3ovj5EuoYvO/hAMPvgCnNyWwdkVEo7RwVZCghVeTJv/TTaz8JY2F6iZbDJJW6xZUYlCcZmItJIr/iwaZCvjG3fKRkqktDigDkw7OnlwAAOKVFjztpnk71hEAcjUe7j+xuUvlarH77Zd5YdUmXHf2yp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LT/CAVx3gq3oUNmNRoRs/8vvfBHCdFvnq/O1vv3G7Uo=;
 b=ZrKT4jDm88EtDNSb4N4YMwHbbN7aYLdmSM6hVAHhui2K5xGtph0kcMnQOfl7Cu57HFM1th7FQJZNcA2P2sWkC3Scm+xlmr96O+EV8/bhZm37ErvIKTsGZUX04zSB8FDet5nt83AbVDlJhaYtWgLWpYEWpULqoMzPaiLN3cFBE1s=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 BL3PR11MB5681.namprd11.prod.outlook.com (2603:10b6:208:33c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 04:39:10 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 04:39:10 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYC/aAgAoD1gCAAB1qgIADHmQAgABwugCAAJxdgA==
Date:   Fri, 22 Sep 2023 04:39:09 +0000
Message-ID: <f10db291-dee8-e4b7-2f97-a3237122a2ad@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
 <9615b403-52c1-f24f-382f-8eea3ddfcf04@microchip.com>
 <4c1d0d38-c459-4722-bead-7660d85f4925@lunn.ch>
 <e037b12b-e592-f451-102e-61401c7ea5d0@microchip.com>
 <61e316c5-e504-4ad1-93a3-f2df5a16b654@lunn.ch>
In-Reply-To: <61e316c5-e504-4ad1-93a3-f2df5a16b654@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|BL3PR11MB5681:EE_
x-ms-office365-filtering-correlation-id: 2ed3881a-f0e9-49b3-1b81-08dbbb25dcb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q2sR3IeOZDC6lizNrWdlRptGjAR9hS6kdWcaBoaaw5x4/6VbnfqLb7ReQ7fVp6Y3Bp1v3/u5BClVxO2dBnIdCtKqnmSFMdhcKO0wb9+bc5jFpFS1N9w8GzvjgSBxpk4/n2xCDdO2/Ag+nRJXMQ6v3E2t4I+SBCPKjUJkzFWoyEvH5xAhls8c90401rzUe5KYAA5cpEc3VhOo71KiOgG+96Bz2qcmoFC7IBRfUUUNN+SG3tgfb9vSkCbcw4pmJ4n1qPIuigIKBw/Dsbps+1dTnoJ63uzd7pi9SDuXDFyGBBSaJpEWvZl+kzkjmpze2WgZDODWsDoHx6WW8mi1dSE7aIvXHOvB2klcd8EbDP3z2o6KOax1fZemU8XNsC5XqfX9Oxs2XgC4detgqXqhTsCM5PzRl2ZqHOTNVZ4g8gT49N0vJA1Zdtt0yUZm/kjnhif5UEvTntL9DacG9rM+bz6KgzRMs6CL5u94NzWFiy3DQhA1drRPIeOZeI58d24IHRGiZ6Y1A6nSDRye4uX9jVbdw4i+PWWop4BicaX8yeEXvtedcSFmo3DN+CylhO3KgnnK5Pde66UEoA8zEST0/82UWaxYfKZxEXmi93UPuqbsgaKpPVa+ZGQMRi8ofaeG/v35igwqsJgZPjvzW3WIr9HeqWtOVEN6h+xOOj8hdkr9UnzX2llW98cZ4UxeZ8qADtWM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(31686004)(8936002)(8676002)(4326008)(91956017)(5660300002)(7416002)(83380400001)(26005)(53546011)(6506007)(6512007)(316002)(66946007)(66556008)(6916009)(66446008)(64756008)(54906003)(66476007)(76116006)(38070700005)(38100700002)(122000001)(71200400001)(41300700001)(2616005)(86362001)(31696002)(6486002)(107886003)(4744005)(2906002)(36756003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFVaR2RQQ0dYTStWMXQyN0hZbUw0QWN3U3pzeXFINU5zQ1RrMzU3dkh2SXA0?=
 =?utf-8?B?WnIrK3VHQTlLZWtLK0xPZWU3MUdwR2E3M1BkSFdjaEVqSUhFM0phN3g1anNW?=
 =?utf-8?B?T2JEb1dPWC9aNkVMRkhBQ212Mlk4NDNFS1gvVGMxczRHUXk0YWxtM1JMUkVo?=
 =?utf-8?B?Z0JiY0hISEp4cXYzTWNvVDBLSUF1dmwrcUdsWjBvV21wd2ZGZTNOK21qckZ3?=
 =?utf-8?B?N3VRL0JTSWNneHE2SzRFOGhnb3VnOUdid21tVnNGMHdLM1ROWGJkYy8zSm9p?=
 =?utf-8?B?ZWQ0Z004dDZYSlZCSW9sN2RibjU5cTRQdSs0eHBYa2ZxVVhWNFpSdTVvdTVS?=
 =?utf-8?B?VmtodFZBVXZ1SzE5clNaTEVuaS9oWldyc1M4RHNLSlhOSkRkZk5qUloxcGVt?=
 =?utf-8?B?QVowcTBFb2lRVk9DYUFTbDFJY2NOQmgwcUx6dUd5YmgydHRvbWthbVNJRE41?=
 =?utf-8?B?MzVXVnJSanFXdXVGRisvb0RPdU52c2tYZnJpakxCaGUwVW9CRmJhUWM2NHpw?=
 =?utf-8?B?aHhFWEkvOFZWemtpU2JWbnlQUHZPNzV1a3pBM2lJRVpUeDJmNVlwOXBZcnBj?=
 =?utf-8?B?ckEvNXhHajduNXBQclhFVHNoaU1WbjdaY21hWVlJbkNYZ0VxMHUzVEN1R2hQ?=
 =?utf-8?B?VktUSkZqeklJR3BGa0FFZDNZNC9FR3Y1UERoRVdjc3NNb0NvaWpDOEdLa240?=
 =?utf-8?B?R2tia2k0aHcyMmZyKzN5VWZhV0ovTHh6U1RKaERleGJkVjgyRit0Q3V5djFD?=
 =?utf-8?B?eTU3RytHczhwOWYxWnpLTXNPYWtmemlZc3VTZytlRnJNaldtenpmS2tGSkxX?=
 =?utf-8?B?UG55NHgzQm9HVDFGdmc4YllwRmRIVlB1TVI3OHYrUWtuUFRWWlBqSWhRN2lR?=
 =?utf-8?B?Vm1ucUNaRkpwU2JqTTZIeVB4ZThiNlhXQWRxSGlmaDVrSVFEQVBjc2ttb2ZX?=
 =?utf-8?B?NDEzNHlIc2JqcEZ2NlREL3JFRFhiY3FiTG1IOHlLRjZZcWprdkNmSTk3aElD?=
 =?utf-8?B?WEltdldaWnFzRkprRzNReENLYmhTRlRoSk03MXhoYTlGTTB6czZtY0VWZnM0?=
 =?utf-8?B?bER2alNUOXZtbVdrY0tXOGVSK2ZEbXJZVjVmajZhQnpPUkVMSjNFRkF2NDFv?=
 =?utf-8?B?dUljYll1R3VCYk5FU0Y4TXFjajYzWW5KTGtVeDh2WXZqSzQvQ0ZTRHdoVHhQ?=
 =?utf-8?B?NUtlWUdVNE4xaEV2YmkyaTFGb3pCbDhIVkd3OUQ2SkJGOWF0eXFEbUNrcVJv?=
 =?utf-8?B?TG50YmFBRHd3UVBaRnlvUXJmZGYxYVoreUd2ZVRPcUtDUS8vSzFLdVRlSFg4?=
 =?utf-8?B?cEUyQ2JtL2wxUFRVOE1OU0RtUHNSUE9KaGlzNlltNjR4bmpKaTg1eFZUeWdP?=
 =?utf-8?B?cUg2MlBKRFk5Ri9SeUU3SjFFQTZNTlNHcGcrYXhrY2ZSQ3JKallYbkg0dEFP?=
 =?utf-8?B?YWxSdExaK1JWNDNlNVlwVkl6NE1LV3FibUJ3VkFaNnVXNVhLNElRVWdpb2pF?=
 =?utf-8?B?b25TQUZXVVpsV3c1VzNMK25nRWJLczArTDRGcG44Mm1MRGFTZytUTW1BODdN?=
 =?utf-8?B?TElEbnZoUXlXNFZMWkVwYTNTbVBSVGdJY3FiU1U5UHYrakIzUGp1VGgvNXA4?=
 =?utf-8?B?OXZPRjlKanM4aXV4MUNXN0taejhKNGJxWm1UMjUrbzV6Qkd5OGZsM3EvbXhV?=
 =?utf-8?B?dCtUZUVjRC9JOGEzM2o4Y25xNkVCSFU5Qnc4YkNvd2hTcjVjUFU1eHdlSmdx?=
 =?utf-8?B?UGIwWWRmZC9JbkNQMkxvV0hNWXJHU3lsTVJZQm9COTZ5Qlh2Mi9BeUN2RWVq?=
 =?utf-8?B?ODJCZXh2S1VFUFcxamxjeVpyN2xvd0ZDbW9OdmpSczBFNmFlWWxDaVN5YTEx?=
 =?utf-8?B?cUlEeEdzeUwvNnFWR1ZJeGw1cU8yVUNEbzQvQlJNeDgrRG1XUVl1WFJHSjdq?=
 =?utf-8?B?UUlNQ002RHJzbEFLdi91eWczNFJJVkdxZEZmaUs3N0JOd2xnT3NXWEVlYXgz?=
 =?utf-8?B?WjNXVW5QZkFKemdQWDNNRHNqTmtEeWx3eVNkZlVvQUQyKzltK2NsUXhQaGtR?=
 =?utf-8?B?dG4raG4wZmtFUi8rT2tha2lQV01jako3YmZsQ21Jb3JQVjJOZkplSGVqYjdF?=
 =?utf-8?B?c214YUVUVklyNURFcUw3T0FKQjlSVE9UNDh2eFp2bUFxM2orYkhEZHpGRFZ3?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F72A083B0D11BB4FB3ADAD955CC36674@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed3881a-f0e9-49b3-1b81-08dbbb25dcb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 04:39:09.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FKpssG3p5OJob1P3qAXRhk7Z/df/+5TZb/KfzDak4419JVJwTYhJwKTReiyrVXUw/ZJUo4kwQl4fDHh+QkM/dUxztNnuw4EHDppnY5GxvxcfzA9hLg6QTdACGj/Pxl5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5681
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyMi8wOS8yMyAxMjo0OSBhbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4+IFllcywgYXMgInN0cnVj
dCBvYV90YzYiIGFuZCBpdHMgbWVtYmVycyBhcmUgbm90IG9yIGdvaW5nIHRvIGJlIGFjY2Vzc2Vk
DQo+PiBpbiB0aGUgTUFDIGRyaXZlciwgSSB3aWxsIGNvbnNpZGVyIHRoaXMgYXMgYW4gb3BhcXVl
IHN0cnVjdHVyZSBhbmQNCj4+IGRlY2xhcmUgaXQgYXMgdm9pZCAqb3BhcXVlX29hX3RjNiBpbiB0
aGUgTUFDIGRyaXZlciBwcml2YXRlIHN0cnVjdHVyZQ0KPj4gInN0cnVjdCBsYW44NjV4X3ByaXYi
IGFuZCB3aWxsIHBhc3MgdG8gdGhlIEFQSXMgZXhwb3J0ZWQgZnJvbSBvYV90YzYuYyBsaWIuDQo+
Pg0KPj4gSXMgbXkgdW5kZXJzdGFuZGluZyBjb3JyZWN0Pw0KPiANCj4gWWVzLg0KPiANCj4gSWYg
dGhlIHN0cnVjdHVyZSBpcyBnb2luZyB0byBiZSB0cnVseSBvcGFxdWUsIGkgc3VnZ2VzdCBoYXZp
bmcgaXQgaW4NCj4gdGhlIEMgZmlsZSwgbm90IHRoZSBIIGZpbGUuDQoNClllcyBmb3Igc3VyZSwg
SSB3aWxsIG1vdmUgaXQgdG8gb2FfdGM2LmMgZmlsZS4NCg0KQW5kcmV3LCB0aGFua3MgYSBsb3Qg
Zm9yIGFsbCB5b3VyIGNvbW1lbnRzLiBUaGV5IGFyZSBhbGwgcmVhbGx5IGhlbHBpbmcgDQptZSB0
byBrbm93L2xlYXJuIG1hbnkgdGhpbmdzIHRvIGltcHJvdmUgbXkgcGF0Y2hlcyBhbmQgY29kaW5n
IHN0eWxlLiANClBsZWFzZSBrZWVwIHN1cHBvcnRpbmcuDQoNCkJlc3QgUmVnYXJkcywNClBhcnRo
aWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K
