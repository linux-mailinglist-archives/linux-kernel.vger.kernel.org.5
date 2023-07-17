Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DE7755BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjGQG31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjGQG3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:29:16 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BD171C;
        Sun, 16 Jul 2023 23:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNgIuwH6xD54z7PZQxQC5goscMwDupaZDevA8UQ44L4w7OhVjCXn2cAius3WYd2Nlzprz5MYUxzh4NfulNpBdvypHr2/uG6M/wljR0bEDOTBSehl7Z8zivgx7RGUamQzp7sRG4LUZ4RjkXN3sCY9HvfyTq9ZU7vGap6c/WrwZRdrgiX314qT+2OxDTPiivLbB0TTaoap6eUJKVwtcoYewToJyGw+Z7YFL+vGVw16SW7CXpK6b+6TSCKKy31VHII735rZBkgxLnRcFZazFJ7TPUXGs588a1RNRMLt6jFS+KLTM/1h8EyD4XQmWVuvJ7e7fhJ6m0yTMcPUpNozNTTe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GmVPGtH4e1YXJDCQQsEar0X6NGP2LuPHeOB/uHZbyuc=;
 b=fgF7+vk6QRcB9eFBxcEIVz5AIxAwb21oLXt5p0Z7NRdm+h5urMQUxT4RxI5WAOvwSQv1ERN2l2eDYqMrWvifIcIJ40tB64JQgu6rsiA7+RQVJ5BiJXMurwGB8xbacyRkUL0XzwjhgbjmQZ3C5rVW+IOVdmqNlG86uMc3X4aP6LBYNki8PoB2MMesUg1+5z8PA1y8+ttx968p1Lj/FqLUhvV8Qo/5zCCVL+PzAwbka9Rrw9vu7hYcoUm6YjmodY8PDQUg/9rxb9nV75/A18h8Qmm/8+5K8n1SGYWljbV5R+TicAuPF45xHSeevY6Zr2UJH4GKgAT6lxCw3QDFjb7GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GmVPGtH4e1YXJDCQQsEar0X6NGP2LuPHeOB/uHZbyuc=;
 b=KZ6PqE/ZGatf8zlPxb1w550AI+T8TvCOobTii0w+tGlJwG6Ib4mccW/+i3i2RB1po9ukr7IExEKJUhKpXUn1JhN3aDkILVbcUFy0fiuPiH2m1uHhirS3bW55iUdjvhFwf+L0/4GO5lHI1nCWz/TVSnDl1GqGv73859rdVbm0xOaI4KA85LPUs0uftaGR0MMkHlLh2Mp1FhJHu/wk5fEDjzsClUGgTwcCo6d/bFsznthFw1t3zwi4ZyUppB4lOdiIE1YHkSChTuAeZWVWDDg9GdyOl9zZWWfuu7THe2hn+bPTH8KOPH6wt7m+I/U7wXuXofTRMszdyK1yYkNhuf96lA==
Received: from DUZPR01CA0158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::17) by DB9PR10MB5761.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:2ec::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 06:28:48 +0000
Received: from DB5EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4bd:cafe::fe) by DUZPR01CA0158.outlook.office365.com
 (2603:10a6:10:4bd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 06:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT079.mail.protection.outlook.com (10.152.5.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.22 via Frontend Transport; Mon, 17 Jul 2023 06:28:47 +0000
Received: from CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.30; Mon, 17 Jul 2023 08:28:46 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M04MSX.ad011.siemens.net (139.24.237.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 14:28:44 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Mon, 17 Jul 2023 14:28:44 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Topic: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Index: AQHZuGQ+yWzLgdq38k6AjTC46fileq+89ZKAgAACDgCAAAFVAA==
Date:   Mon, 17 Jul 2023 06:28:44 +0000
Message-ID: <33a1f28a68483bd8b0e91e8953490814bae4fe5d.camel@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
         <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
         <e57e5d8efc3107b5f2c4e66492650b9d0c17b898.camel@siemens.com>
In-Reply-To: <e57e5d8efc3107b5f2c4e66492650b9d0c17b898.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <96EE9BEFE776E449895CADE7185AF0AD@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT079:EE_|DB9PR10MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 99a41748-e3d4-4845-11e6-08db868f1426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3E7+Nz1cHCiOpluTeHuPrz5MlgFUiHLt0wwnwwkfceqwZmGdf65sm+A4fTiUZy6DsPtUj9yNMoRLQRcLh4MsyPq4JOAo4P8DcoorGQSYCV9ZppnDlSCum4GI4Hse08vYyqZzJaRbyJeJmL1g2U0Md8s5Dj/vvyRV6CZ0JEeNmJ0pVTy+MTMXCEvhhfqLYMn5TNxsMab71zmFv1L6gjooL7VHmKL/3qC5Hu/2vXiDcwiSJkxMouMwYLMLEoTSKsEiifSWwTKLhY27UuzdTkXE9KE6B3RcQXAXX6oOnajuBGdVsZzaiAWfX/QkgnW90qrPR7cWgw7YxeN7BswJ2YpZvnAbrc3h7NmMQc76WEc4NepBvdsdi3FGVCWDeKv+sXTBTWJcz9fzKjX0/vAahJWon43Q2EjaE8fnLG4Q8OCwiENdYnKDbk/Qjn7242NrUcr8SIKh7Vt4vNHlWEVyWmHw8bFuvfP8u8QrKSfwoS6ExK4/A6jwpKbTXKnPFoykgE3QYwJk3bbzsSGT2u95Od26afB2CXyZFaSPc8MynQakZ0mBtjzGU3d3fOC+NiYk/wUrP01hztxw4coEe+OogikNiebsDhsbRAh4nG3Bl4+UjKFe1+fHeTqNm7zOqY5TekuqA1qTHJlcyQVpvKazFbZZp0FUDHjYng3KZiELQOILpF2RlebU0eOoXysKRmGIwd7BtkokMcTTLEg80er+PhcOIS3gkQ+zf0ul3Tuhq+K3TGk=
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(47076005)(110136005)(54906003)(82740400003)(7596003)(7636003)(82960400001)(356005)(70206006)(478600001)(41300700001)(45080400002)(5660300002)(8936002)(8676002)(70586007)(316002)(4326008)(2616005)(956004)(336012)(186003)(36860700001)(83380400001)(966005)(53546011)(26005)(86362001)(36756003)(7416002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:28:47.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a41748-e3d4-4845-11e6-08db868f1426
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5761
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDE0OjIzICswODAwLCBIdWEgUWlhbiBMaSB3cm90ZToNCj4g
T24gTW9uLCAyMDIzLTA3LTE3IGF0IDA4OjE2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiA+IE9uIDE3LzA3LzIwMjMgMDY6MDcsIGh1YXFpYW4ubGlAc2llbWVucy5jb23CoHdy
b3RlOg0KPiA+ID4gRnJvbTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+DQo+
ID4gPiANCj4gPiA+IFRoZSB3YXRjaGRvZyBoYXJkd2FyZSBvZiBUSSBBTTY1WCBwbGF0Zm9ybSBk
b2VzIG5vdCBzdXBwb3J0DQo+ID4gPiBXRElPRl9DQVJEUkVTRVQgZmVhdHVyZSwgYWRkIGEgcmVz
ZXJ2ZWQgbWVtb3J5IHRvIHNhdmUgdGhlDQo+ID4gPiB3YXRjaGRvZw0KPiA+ID4gcmVzZXQgY2F1
c2UsIHRvIGtub3cgaWYgdGhlIGJvYXJkIHJlYm9vdCBpcyBkdWUgdG8gYSB3YXRjaGRvZw0KPiA+
ID4gcmVzZXQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExpIEh1YSBRaWFuIDxodWFx
aWFuLmxpQHNpZW1lbnMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+
ID4gLSBGaXggdGhlIGNvZGluZyBzdHlsZS4NCj4gPiA+IC0gQWRkIHVzYWdlIG5vdGUgZm9yIHRo
ZSByZXNlcnZlZCBtZW1vcnkuDQo+ID4gPiAtIExpbmsgdG8gdjM6DQo+ID4gPiDCoA0KPiA+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2F0Y2hkb2cvMjAyMzA3MTMwOTUxMjcuMTIz
MDEwOS0xLWh1YXFpYW4ubGlAc2llbWVucy5jb20NCj4gPiANCj4gPiBNdWNoIG1vcmUgY2hhbmdl
ZC4gWW91IGFkZGVkIGV4YW1wbGUgaW4gdGhlIGJpbmRpbmdzIHdoaWNoIG5vIG9uZQ0KPiA+IGFz
a2VkDQo+ID4gZm9yLiBUaGVuIHlvdSBhZGRlZCBtdWx0aXBsZSBmYWtlIHJldmlldyB0YWdzIHRv
IGFsbCB0aGUgcGF0Y2hlcy4NCj4gPiANCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gS3J6eXN6dG9m
DQo+ID4gDQo+IEhpLA0KPiANCj4gU29ycnkgZm9yIHRoZSB3cm9uZyBzdGF0ZW1lbnQuIEkgbWlz
c2VkIHNvbWUga2V5IGluZm9ybWF0aW9uIGFuZA0KPiBtaXNzdW5kZXJzdG9vZCBgUmV2aWV3ZWQt
YnlgLCBJIHRyZWF0ZWQgYFJldmlld2VkLWJ5YCBhcyBgV2hvDQo+IGhhcyByZXZpZXdlZGAuDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IExpIEh1YSBRaWFuDQpCeSB0aGUgd2F5LCBgTXVjaCBtb3Jl
IGNoYW5nZXNgIGNhbWUgZnJvbSB0aGUgZm9sbG93aW5nIG1lc3NhZ2Ugd2hpY2gNCndhcyBjb21t
ZW50ZWQgb24gW1BBVENIIHYzIDAvM10gQWRkIHN1cHBvcnQgZm9yIFdESU9GX0NBUkRSRVNFVCBv
biBUSQ0KQU02NXg6DQoNCg0KT25lIHRoaW5nIEkga2VlcCB3b25kZXJpbmcgYWJvdXQ6IFdoYXQg
cHJldmVudHMgdGhlIExpbnV4IGtlcm5lbCBmcm9tDQp0cmVhdGluZyB0aGUgc3BlY2lhbCBtZW1v
cnkgYXJlYSBsaWtlIG5vcm1hbCBtZW1vcnkgPyBJIHdvdWxkIGhhdmUNCmV4cGVjdGVkDQpzb21l
IHVzYWdlIG5vdGUsIHN1Y2ggYXMgdGhhdCB0aGUgbWVtb3J5IGFyZWEgbXVzdCBiZSByZXBvcnRl
ZCBhcw0KcmVzZXJ2ZWQNCnRvIHRoZSBrZXJuZWwsIGJ1dCBJIGRvbid0IHNlZSBhbnl0aGluZyBs
aWtlIHRoYXQuDQoNCkd1ZW50ZXINCg==
