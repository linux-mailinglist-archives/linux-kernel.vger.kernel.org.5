Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AA7A4569
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjIRJD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbjIRJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:03:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF6EC5;
        Mon, 18 Sep 2023 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695027783; x=1726563783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HcJlynocU9Dzr6zO1dFYSlva1zQ2MY3gTcAQu+uF4FI=;
  b=2rtqsQzSLfVBWd5ZcZ6jdjKfNm6Ya+hOY2sQFg0dNeeCeGeuJ7POcPdK
   Sj03YkzWtq78MdtDAFdE5yS7s2JxTOeXCEc7CYtNHjXg9uqAN5O/x8igp
   mjXad4B0NADvgEiFdq/DRC2hNSx/niHGfAtRNN9w51Yi0g2eSWQGb1HT/
   Hz4/z84O337ZpEfSCJEYPZ7cRHMynKhJIzyf1sXFopZyIoYv+HOiUsL4G
   xZfy37EWqLZg9rlyOqY9u2uX6UEJz9UivcjRwwZ98LOOYVMQq8JKmVAjI
   jegcRXw5BXhbjnSQASxJEVARSyRpszb87H14ChbtJRvcTrlUQ2sPkS30S
   g==;
X-CSE-ConnectionGUID: EwPA8vVrRQiocfoFCZ1U3g==
X-CSE-MsgGUID: A+L+u5tPS/mE4kb/vBggaw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="5354679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 02:03:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 18 Sep 2023 02:02:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 18 Sep 2023 02:02:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtbU2E7KvoCYlWM2AUl2dNjZm6+IGsX0Fy9rjMLdkDGfeYNm88lduQlZgLEKDcVQYSq/1Xiz4fH5IeUZf/UasnNEYtB9o0fTpEOJrs/wEP96/uaTAdM73baYtinxRrBYjaV+Wf4qfaad96Bf88QXpK3kP+WXgYil18UsUqfRJKzsRoCkJVXSRKKAelse3oUjFX8Vq2lCxNfSffHtmBlqQ2QS1y9xdZL+KBTZXaIicHd/fZWB/8vekzZRXnWEdHfraCseFV0vIT4rsgixRHBlNfv4jQxRqSZ/4a4THufvuy4BzZ/wZuOnrbV9w0xyyoDcZa6X5LmYe0f1HXiZ+J2YTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcJlynocU9Dzr6zO1dFYSlva1zQ2MY3gTcAQu+uF4FI=;
 b=Un3pfBG3irFQarz2YuQpiRN0zEkwD47IBnusYcmNAXUVHmklIokRpY9Z+Cfz7kE9LVLx9VEOsyvYI5TPfHbXFpU3lOXu6uyLDsqiHLbWhP+YrM3Ig2BJ/rdX2tsRx/zXau4EbbZWEiFT9RaD91SSuHeBxseo8E6qWelO7lYkG3aCpmKO/x7nzyqqpXzaFLbkx3sVNDw8lbSve7d5YcV7wdrp0qSx4Ra9d0YRGbKTeJfaXmq9w3l+BQDpmPUOnXDQkJDQ8DhFzk2qj0NX2m5bEskgVjrmMSizetFkdZ/V6aGD03dFtLovLOru2AyjwF07MyqunPwub0GAW66HyBiSdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcJlynocU9Dzr6zO1dFYSlva1zQ2MY3gTcAQu+uF4FI=;
 b=Af5KlyeFvcHNC+b76S8DyAMvxZK4nkKBSjOizAVHoRZUfuAufN/j98NJstS9AV0a063I1lrb1nBP47zTyxjrTfSvtnsvBwAskZK/IYn0+NJFaBn+0VKaF2lsN/J0OrNp5y2IZFWd1RoDSGnFvT8BHRYUxBhPFo4ztapJqWMzYKU=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.24; Mon, 18 Sep 2023 09:02:48 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:02:47 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <lennart@lfdomain.com>, <ada@thorsis.com>, <andrew@lunn.ch>
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
Subject: Fwd: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Topic: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHZ4mDzB/QUuCJz5U6/cDo3W2/tF7Ab9DuAgAQ1PICAAC90AA==
Date:   Mon, 18 Sep 2023 09:02:47 +0000
Message-ID: <f6858856-53c4-5eb8-ab52-350aab280735@microchip.com>
References: <79a32553-3926-e3b8-980d-351d94fc063b@microchip.com>
In-Reply-To: <79a32553-3926-e3b8-980d-351d94fc063b@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SA0PR11MB4654:EE_
x-ms-office365-filtering-correlation-id: 11a0d347-2d90-4d20-f13c-08dbb826077c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FA0sHJYF7FKWQeXAy8CHKEIF4YC6M2nlj/PqfhrNH1yqsxJqazphPg0ACgydaO9kkcZhQr1z/Mmtjh6xQaM+MtyKKpMgtSXx2yNCoNjj2325IV9Iwihtxz/tgXmCQFV2R+s3r2QuUwbQmCgypezyE6Sb1Lh5ES0O2HoOIazw4B7p3EW4uy885bx2zXWg1Fol+Uph0MYYEuc+2Wyvec0qEerxTpXASY0oLyk0ref1ipKsWxBNR+3xr4us22bZZxiqEkzca2YKo7wQSMslvM0Z/OXEhlVk+fNyrr/w5BLyzuLo4P8tToGBgvKg/uIZkQiqG2DdF2KAGaPJAsxTwiXAP1oGZ7/i05z1vBISaOqZc1sMuf5OiisCe6SQ3uw7Y7eEu447wCoh0VW5o5jQkjMq6zize5QHqkiVgyNe+jGz7t+no4JfIokUXtOVPQHmyDnNo2zJJnYFSpsCok+IKpMi3gjmCPcaSS06f4zf4wL/KTlXi03e0I0TwztjqONPJMWvyK1NALdqjmtOg0sUcCE8427mhRmNNCSaZjnPiA+mA1mnslh51/WZXTFtmTjB8MrlJQOCPpy+7OwC8w+VVhowb3y+5/dB9xaoxWKMLB891C0V/OBR73OCUm+13u4eVsbmLOWup7HFkV/4Gz544CTwZWLNFOlWPFubOHmTRSTy9Pw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(1800799009)(186009)(451199024)(2906002)(31686004)(91956017)(7416002)(5660300002)(8676002)(41300700001)(4326008)(8936002)(107886003)(316002)(83380400001)(54906003)(66476007)(64756008)(66446008)(66946007)(66556008)(76116006)(110136005)(6506007)(478600001)(6486002)(966005)(71200400001)(53546011)(36756003)(26005)(2616005)(6512007)(38070700005)(122000001)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWpBWHBKeEY4dUlRbGd3QnRIdHNYS3o2VDVsOGVPU1JtSnFDdVkycGlEbjFp?=
 =?utf-8?B?T2ZqLzZMbXluWkE1WSszYlNiZ0dZWnJOQ1lIZVBOdXE4bWJUNlEySnVjVVRO?=
 =?utf-8?B?Z1VXbDcwN0pMWmxORlpSU0Vsd2x3TUJzUlNoT094SHVPeEpVU29mTi8vNFhW?=
 =?utf-8?B?V01UTDhVaUVFZ2hIOHlRcUZub2pIWlhLaElUeC9naUhtakdYbnJQdkxWcUlS?=
 =?utf-8?B?MFlBcUJHaUI5bTY5ZFFWVnVuaVFORjhURUlrUFQva0RCUis0RzJwU3FBZjA4?=
 =?utf-8?B?SU9GVGRMajJ2VmFMU04yTW94emRXS3F6M2lqaDZjVUlqdko4L3NrVEFNaVI2?=
 =?utf-8?B?YUl3RnhleXN5QW1SVS9NMXhzOXoyREtQbUFnY25FVklQT2JYZXkwTUQvMnhH?=
 =?utf-8?B?YlhkaDFDdzljeE12WFVKYXByMm9vd0MzVmdKTk0zQlpzbm1iaVlLbTJaQXJX?=
 =?utf-8?B?eXdyYlFrM2czd1BVaUlqMEJNd3NUd0J1NHZHUU43M1NoNEdETEw2SURsVHVs?=
 =?utf-8?B?TDZOMGdEeUVTcHROdjZzMU5jL2UwcDNDbE9TS2FPTnRuakY5ZUUvZmk5Q2xR?=
 =?utf-8?B?dkF4aElURWNjQW5ubm5GVHdZRHhuRys3VktYT3ZpWG9rTzlPRTZpRWdsVUFT?=
 =?utf-8?B?bHVtUGZkU05UODRBVXg2L3hzU3hxL3hWa2d1Si9hMzZVdEJ4VERJa0RERy9W?=
 =?utf-8?B?Mldlb0hXRStSM2x0akdXbDFWT1VOaXQya1FsQVFSUTErZFE2bmw2RGNFeXQx?=
 =?utf-8?B?VFEzK3pwV3NMZENhWndFeDZwQnhNQXovVHRBL1Rva0xiM1dhT3JCbTRIK3A5?=
 =?utf-8?B?NTdNN3VhenN3MVd4Nk5ST20rT3N6bC9BQWF6T0c4cC9DM1N2UWhZeld1RmxR?=
 =?utf-8?B?NXd1bDhnMFlHak9FVXdtWFJPTHhiNGp3NnkwVENNMFZ6NkN5RlVRKzRCa1VY?=
 =?utf-8?B?NDhsRkYwQ1RkSHdEcFBoK2dmVng4blZlYW45Wjl2STNUOWoxTTFPQU14d2hr?=
 =?utf-8?B?ZUhya21NeUdLdTY0L2xjUjNvd3E5a3lzTzNLc2FIZjFhREs5d0EzUVVxWm14?=
 =?utf-8?B?RVhQUVRmYm9nRFdNQmdaQklNMzZvRVJtbkV2SUJ6VHlDTnZVdFRkYkR1YU9E?=
 =?utf-8?B?QVN1enRRbG1hNktCTkh3Y2ZZYlBmTnZWM0dWRUpmQmN6UzVjb3J5cEJUUFJh?=
 =?utf-8?B?UkJLU21ENXV4UEc2dkplT1dRcndmNlFxazVFRWhQSmNHQ2x2WEtLOVBSMzFL?=
 =?utf-8?B?T05SbGtqdWxkRHBMamUxUTRiWGRCalQ4MDBINDIya1VSZTVBSW9PSVU4b0xB?=
 =?utf-8?B?amJqaDMxOUhNbVlFT3lGRWhPZ0tuUDJmRDFHaTNRaDNzT2QxKzYwWTVLaDV2?=
 =?utf-8?B?OFBZbjRuQVhBRmJra05SUlN5WlNWaUd5ZWkvemh3d2JNeWZtTVdVLzFLM3Nm?=
 =?utf-8?B?elRUNjJSTytraGVrejBKVkVUZ0ZnS0tpNHp4cFh6QTVPNjRuMGRwTTBUaG8x?=
 =?utf-8?B?elFSRVlFRDAyalhTbVpDdzUzVzVCRkdZNjY2RjdoaURNd3pxWEZXYTRqYTlZ?=
 =?utf-8?B?MW1FVDlab21JcXNMSFowWnlyaVY2UnJIUFk5dVhETlpDTE1FdHNYYXppQkhw?=
 =?utf-8?B?ZE9HeWJSVnpHY0lPeFFZWTZZSTVDWE51b1NxU3M0MFJMQ0RVSS9KSEtSeWJK?=
 =?utf-8?B?bHV2NGlrWFk0QUoySVhxQTFNRXgzVzl4VmZTclFUUHFXVE1QSGxuTmdoMERt?=
 =?utf-8?B?TzhRSDQ1Zi9iWWJwSENrYVZ5RDBNSzQrOU81SU5OendjNk1QQ3p0SGFmbHhH?=
 =?utf-8?B?OWJZWlE1NVYxQXpza2NrZjB3YmJNcGd4NXhwclBTaE5IbEJldFg4OUVablFq?=
 =?utf-8?B?bWpubnRTZXpPY1JRQmp5NXJCRGlodkM3RXFNNUxjcUFyWHRsVHF6RytBenJk?=
 =?utf-8?B?bUxrWG5ycFJIMStaK1BUNVUrTWl5aG1Rb0hsZkdFNXR4QmxVOXlJVTQvM2FZ?=
 =?utf-8?B?a1RmYi9SMEVvOGhLT0ljTzBKSFRJWUxWRWpxME52VGxkYTY3UExBbytWK3dV?=
 =?utf-8?B?VEtGNi9PZkJjYWE3S01KQTdjeXZhcURRL2x1UkxiZDRhNWxua3paQ0h4QUJU?=
 =?utf-8?B?WDhmYlFUQ05zSHROWTZITTBhZ3NxRmZMSEk1K1lmVldqSzNLbWFJb0JFWWJh?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AB3503540C71648B068DBE8663F246E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a0d347-2d90-4d20-f13c-08dbb826077c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:02:47.6791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lcUHnv4DA9+yRKWTrPhpZi64eldH8UnZ2ZslpAdsafXVPk7i/D9qEexiVAd6KmUHfnRTrtwgHxoGImgxMp3hZrZ0PlbOEl1nhlrkfzXw/bS9/t5o4XCx8s9q5l2W9lu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVubmFydCwNCg0KSSBhbSBmb3J3YXJkaW5nIHRoaXMgZW1haWwgdG8geW91IGFzIHdlIGFy
ZSBub3QgYWJsZSB0byByZWFjaCB0aGUgbW9kdWxlIA0KYXV0aG9yIEFsZXhhbmRydSBUYWNoaWNp
IDxhbGV4YW5kcnUudGFjaGljaUBhbmFsb2cuY29tPiBhbmQgZ2V0dGluZyB0aGUgDQpiZWxvdyBl
bWFpbCBkZWxpdmVyeSBlcnJvci4NCg0KLS0tLWN1dCBoZXJlLS0tLS0NCkRlbGl2ZXJ5IGhhcyBm
YWlsZWQgdG8gdGhlc2UgcmVjaXBpZW50cyBvciBncm91cHM6DQoNCmFsZXhhbmRydS50YWNoaWNp
QGFuYWxvZy5jb208bWFpbHRvOmFsZXhhbmRydS50YWNoaWNpQGFuYWxvZy5jb20+DQpUaGUgZW1h
aWwgYWRkcmVzcyB5b3UgZW50ZXJlZCBjb3VsZG4ndCBiZSBmb3VuZC4gUGxlYXNlIGNoZWNrIHRo
ZQ0KcmVjaXBpZW50J3MgZW1haWwgYWRkcmVzcyBhbmQgdHJ5IHRvIHJlc2VuZCB0aGUgbWVzc2Fn
ZS4gSWYgdGhlIHByb2JsZW0NCmNvbnRpbnVlcywgcGxlYXNlIGNvbnRhY3QgeW91ciBlbWFpbCBh
ZG1pbi4NCi0tLS1jdXQgaGVyZS0tLS0tLQ0KDQpXZSBnb3QgeW91ciB5b3VyIGVtYWlsIGFkZHJl
c3MgZnJvbSB0aGUgY29tbWl0IA0KYmM5M2UxOWQwODhiYjE0ZTExNjc1NmFiMjcwZGVlYTZlZTYy
ZDc4Mi4gUmVnYXJkaW5nIHRoZSBiZWxvdyB0b3BpYywgYXJlIA0KeW91IHRoZSByaWdodCBjb250
YWN0IHBhcnNvbiB0byBjb250aW51ZSBmdXJ0aGVyIG9uIHRoaXMgdG9waWMgb3IgZWxzZSANCmRv
IHlvdSBoYXZlIGFueSBvdGhlciBjb250YWN0IHRvIGFwcHJvYWNoPyBQbGVhc2UgbGV0IHVzIGtu
b3cuDQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQotLS0tLS0tLSBGb3J3YXJkZWQgTWVz
c2FnZSAtLS0tLS0tLQ0KU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggbmV0LW5leHQgMC82XSBBZGQg
c3VwcG9ydCBmb3IgT1BFTiBBbGxpYW5jZSANCjEwQkFTRS1UMXggTUFDUEhZIFNlcmlhbCBJbnRl
cmZhY2UNCkRhdGU6IE1vbiwgMTggU2VwIDIwMjMgMTE6NDI6MzMgKzA1MzANCkZyb206IFBhcnRo
aWJhbiBWZWVyYXNvb3JhbiA8UGFydGhpYmFuLlZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQpU
bzogYWRhQHRob3JzaXMuY29tLCBBbGV4YW5kcnUgVGFjaGljaSA8YWxleGFuZHJ1LnRhY2hpY2lA
YW5hbG9nLmNvbT4sIA0KQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPg0KQ0M6IGRhdmVtQGRh
dmVtbG9mdC5uZXQsIGVkdW1hemV0QGdvb2dsZS5jb20sIGt1YmFAa2VybmVsLm9yZywgDQpwYWJl
bmlAcmVkaGF0LmNvbSwgcm9iaCtkdEBrZXJuZWwub3JnLCANCmtyenlzenRvZi5rb3psb3dza2kr
ZHRAbGluYXJvLm9yZywgY29ub3IrZHRAa2VybmVsLm9yZywgY29yYmV0QGx3bi5uZXQsIA0Kc3Rl
ZW4uaGVnZWx1bmRAbWljcm9jaGlwLmNvbSwgcmR1bmxhcEBpbmZyYWRlYWQub3JnLCBob3Jtc0Br
ZXJuZWwub3JnLCANCmNhc3Blci5jYXNhbkBnbWFpbC5jb20sIG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmcsIA0KZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcsIGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcsIA0KbGludXgtZG9jQHZnZXIua2VybmVsLm9yZywgaG9yYXRpdS52dWx0dXJAbWljcm9j
aGlwLmNvbSwgDQpXb29qdW5nLkh1aEBtaWNyb2NoaXAuY29tLCBOaWNvbGFzLkZlcnJlQG1pY3Jv
Y2hpcC5jb20sIA0KVU5HTGludXhEcml2ZXJAbWljcm9jaGlwLmNvbSwgVGhvcnN0ZW4uS3VtbWVy
bWVockBtaWNyb2NoaXAuY29tDQoNCkhpIEFsZXhhbmRlciwNCg0KVGhhbmtzIGZvciB0aGUgaW5m
b3JtYXRpb24uIFBsZWFzZSBzZWUgbXkgcmVwbHkgYmVsb3cuDQoNCk9uIDE1LzA5LzIzIDc6MjYg
cG0sIEFsZXhhbmRlciBEYWhsIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRo
aXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBhZGFAdGhvcnNpcy5jb20uIExl
YXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2Vu
ZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBz
YWZlDQo+IA0KPiBIZWxsbywNCj4gDQo+IHRoaXMgaXMgaW50ZXJlc3RpbmcsIGJ5IGNoYW5jZSBJ
IGp1c3QgbG9va2VkIGF0IGEgY2hpcCBjbGFpbWluZw0KPiBzaW1pbGFyIGZlYXR1cmVzIHRvZGF5
LCB3aGljaCBhbHJlYWR5IGhhcyBhIGRyaXZlciBpbiBrZXJuZWw6IEFuYWxvZw0KPiBEZXZpY2Vz
IEFESU4xMTEwLg0KTWljcm9jaGlwJ3MgTEFOODY1eCBpcyBhIDEwQkFTRS1UMVMgTUFDUEhZIGFu
ZCBBbmFsb2cgRGV2aWNlcydzIEFESU4xMTEwIA0KaXMgYSAxMEJBU0UtVDFMIE1BQ1BIWS4gU28g
YXMgeW91IHNhaWQgMTBCQVNFLVQxeCBNQUNfUEhZIFNlcmlhbCANCkludGVyZmFjZSBTcGVjaWZp
Y2F0aW9uIGRlZmluZWQgYnkgT1BFTiBBbGxpYW5jZSBUQzYgZ3JvdXAgY2FuIGJlIA0KYXBwbGlj
YWJsZSBmb3IgYm90aCBvZiB0aGUgZGV2aWNlcy4gSSBhbHNvIG5vdGljZWQgdGhhdCBBREkncyBk
YXRhc2hlZXQgDQpzYXlzIEFESU4xMTEwIHN1cHBvcnRzIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQx
eCBNQUMtUEhZIHNlcmlhbA0KaW50ZXJmYWNlLg0KaHR0cHM6Ly93d3cuYW5hbG9nLmNvbS9tZWRp
YS9lbi90ZWNobmljYWwtZG9jdW1lbnRhdGlvbi9kYXRhLXNoZWV0cy9hZGluMTExMC5wZGYNCg0K
QnV0IGluIG15IGZpcnN0IGdsYW5jZSBpbiB0aGVpciBkcml2ZXIgY29kZSwgSSBkb24ndCBzZWUg
YW55IGNvZGUgYmxvY2sgDQp3aGljaCBpbXBsZW1lbnRzIDEwQkFTRS1UMXggTUFDX1BIWSBTZXJp
YWwgSW50ZXJmYWNlIFNwZWNpZmljYXRpb24gDQpkZWZpbmVkIGJ5IE9QRU4gQWxsaWFuY2UgVEM2
IGdyb3VwLiBPciBkbyBJIG1pc3MgYW55dGhpbmcgaGVyZT8uIE15IGNvZGUgDQpyZWZlcmVuY2Ug
aXMgYmVsb3cgRllSLA0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNi1yYzIv
c291cmNlL2RyaXZlcnMvbmV0L2V0aGVybmV0L2FkaS9hZGluMTExMC5jDQoNCk9QRU4gQWxsaWFu
Y2UgMTBCQVNFLVQxeCBNQUNfUEhZIFNlcmlhbCBJbnRlcmZhY2UgU3BlY2lmaWNhdGlvbiBjYWIg
YmUgDQpkb3dubG9hZGVkIGZyb20gdGhlIGJlbG93IGxpbmssDQpodHRwczovL29wZW5zaWcub3Jn
L2F1dG9tb3RpdmUtZXRoZXJuZXQtc3BlY2lmaWNhdGlvbnMvDQoNCkkgdGhpbmsgQWxleGFuZHJ1
IFRhY2hpY2kgZnJvbSBBREkgd291bGQgYmUgYWJsZSB0byBnaXZlIHVzIG1vcmUgDQppbmZvcm1h
dGlvbiBvbiB0aGlzIGRpcmVjdGlvbi4NCj4gDQo+IEFtIEZyaSwgU2VwIDA4LCAyMDIzIGF0IDA3
OjU5OjEzUE0gKzA1MzAgc2NocmllYiBQYXJ0aGliYW4gVmVlcmFzb29yYW46DQo+PiBUaGlzIHBh
dGNoIHNlcmllcyBjb250YWluIHRoZSBiZWxvdyB1cGRhdGVzLA0KPj4gLSBBZGRzIHN1cHBvcnQg
Zm9yIE9QRU4gQWxsaWFuY2UgMTBCQVNFLVQxeCBNQUNQSFkgU2VyaWFsIEludGVyZmFjZSBpbiB0
aGUNCj4+ICAgIG5ldC9ldGhlcm5ldC9vYV90YzYuYy4NCj4gDQo+IFNvIHRoaXMgaW1wbGVtZW50
cyB0aGUgIjEwQkFTRS1UMXggTUFDLVBIWSBTZXJpYWwgSW50ZXJmYWNlDQo+IFNwZWNpZmljYXRp
b24iIHdoaWNoIGlzIEV0aGVybmV0IG92ZXIgU1BJIGlmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHk/
DQo+IFRoZSBhYm92ZSBtZW50aW9uZWQgY2hpcCBjbGFpbXMgZG8gdXNlIHRoZSBzYW1lIGludGVy
ZmFjZSBhbmQgdGhlIHNhbWUNCj4gc3RhbmRhcmQuICBIb3cgZG9lcyBpdHMgZHJpdmVyIHdvcmsg
dGhlbj8gIERvIHlvdSBhZGQgY29kZSBmb3IgYSB0aGluZw0KPiBhbHJlYWR5IHByZXNlbnQgaW4g
dGhlIGtlcm5lbCBvciBkb2VzIHRoZSBvdGhlciBkcml2ZXIgZG8gc29tZXRoaW5nDQo+IGNvbXBs
ZXRlbHkgZGlmZmVyZW50IGFuZCBJIGp1c3QgbWlzdW5kZXJzdG9vZD8NCkFzIEkgbWVudGlvbmVk
IGFib3ZlLCBpbiBteSBmaXJzdCBnbGFuY2UgaW4gdGhlaXIgZHJpdmVyIGNvZGUsIEkgZG9uJ3Qg
DQpzZWUgYW55IGNvZGUgYmxvY2sgd2hpY2ggaW1wbGVtZW50cyAxMEJBU0UtVDF4IE1BQ19QSFkg
U2VyaWFsIEludGVyZmFjZSANClNwZWNpZmljYXRpb24gZGVmaW5lZCBieSBPUEVOIEFsbGlhbmNl
IFRDNiBncm91cC4gTGV0J3MgQWxleGFuZHJ1IA0KVGFjaGljaSBmcm9tIEFESSBnaXZlcyB1cyBt
b3JlIGluZm8gb24gdGhpcy4NCj4gDQo+IENhbiB0aGUgZHJpdmVycyBmb3IgQURJTjExMTAgYW5k
IGZvciBMQU44NjVYIHNoYXJlIGNvZGUgYmVjYXVzZSB0aGV5DQo+IHVzZSB0aGUgc2FtZSBzcGVj
aWZpZWQgaW50ZXJmYWNlPyAgVGhlIHBhdGNoIHNldCBkb2VzIG5vdCBsb29rIGxpa2UNCj4gaXQ/
DQpPZiBjb3Vyc2UsIGlmIHRoZWlyIGRldmljZSBzdXBwb3J0cyBPUEVOIEFsbGlhbmNlIHRoZW4g
d2UgY2FuIHVzZSB0aGlzIA0Kb2FfdGM2LmMgZnJhbWV3b3JrIHRvIHN1cHBvcnQgb3RoZXIgMTBC
QVNFLVQxeCBNQUNQSFkncyBhcyB3ZWxsLg0KPiANCj4gKEFkZGVkIHRoZSBvdGhlciBkcml2ZXIg
YXV0aG9yIHRvIENjLikNCk9rIHRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzLA0KUGFydGhpYmFuIFYN
Cj4gDQo+IEdyZWV0cw0KPiBBbGV4DQo+IA0KPj4gLSBBZGRzIGRyaXZlciBzdXBwb3J0IGZvciBN
aWNyb2NoaXAgTEFOODY1MC8xIFJldi5CMCAxMEJBU0UtVDFTIE1BQ1BIWQ0KPj4gICAgRXRoZXJu
ZXQgZHJpdmVyIGluIHRoZSBuZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXguYy4NCj4+DQo+
PiBQYXJ0aGliYW4gVmVlcmFzb29yYW4gKDYpOg0KPj4gICAgbmV0OiBldGhlcm5ldDogaW1wbGVt
ZW50IE9QRU4gQWxsaWFuY2UgY29udHJvbCB0cmFuc2FjdGlvbiBpbnRlcmZhY2UNCj4+ICAgIG5l
dDogZXRoZXJuZXQ6IGFkZCBtYWMtcGh5IGludGVycnVwdCBzdXBwb3J0IHdpdGggcmVzZXQgY29t
cGxldGUNCj4+ICAgICAgaGFuZGxpbmcNCj4+ICAgIG5ldDogZXRoZXJuZXQ6IGltcGxlbWVudCBP
QSBUQzYgY29uZmlndXJhdGlvbiBmdW5jdGlvbg0KPj4gICAgbmV0OiBldGhlcm5ldDogaW1wbGVt
ZW50IGRhdGEgdHJhbnNhY3Rpb24gaW50ZXJmYWNlDQo+PiAgICBtaWNyb2NoaXA6IGxhbjg2NXg6
IGFkZCBkcml2ZXIgc3VwcG9ydCBmb3IgTWljcm9jaGlwJ3MgTEFOODY1WCBNQUNQSFkNCj4+ICAg
IG1pY3JvY2hpcDogbGFuODY1eDogYWRkIGRldmljZS10cmVlIHN1cHBvcnQgZm9yIE1pY3JvY2hp
cCdzIExBTjg2NVgNCj4+ICAgICAgTUFDUEhZDQo+Pg0KPj4gICAuLi4vYmluZGluZ3MvbmV0L21p
Y3JvY2hpcCxsYW44NjV4LnlhbWwgICAgICAgfCAgNTQgKysNCj4+ICAgRG9jdW1lbnRhdGlvbi9u
ZXR3b3JraW5nL29hLXRjNi1mcmFtZXdvcmsucnN0IHwgMjMxICsrKysrDQo+PiAgIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNSArDQo+PiAgIGRyaXZl
cnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9LY29uZmlnICAgICAgICB8ICAxMCArDQo+PiAgIGRy
aXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9NYWtlZmlsZSAgICAgICB8ICAgMyArDQo+PiAg
IGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3JvY2hpcC9sYW44NjV4LmMgICAgICB8IDU4OSArKysr
KysrKysrKysrDQo+PiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L29hX3RjNi5jICAgICAgICAgICAg
ICAgICB8IDgwNyArKysrKysrKysrKysrKysrKysNCj4+ICAgaW5jbHVkZS9saW51eC9vYV90YzYu
aCAgICAgICAgICAgICAgICAgICAgICAgIHwgMTMwICsrKw0KPj4gICA4IGZpbGVzIGNoYW5nZWQs
IDE4MzkgaW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9taWNyb2NoaXAsbGFuODY1eC55YW1sDQo+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2EtdGM2LWZyYW1ld29y
ay5yc3QNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVybmV0L21pY3Jv
Y2hpcC9sYW44NjV4LmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L2V0aGVy
bmV0L29hX3RjNi5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L29hX3Rj
Ni5oDQo+Pg0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCj4+DQoNCg==
