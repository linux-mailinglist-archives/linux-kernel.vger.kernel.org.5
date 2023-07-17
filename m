Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D40F755CC2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGQHYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQHYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:24:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA32188;
        Mon, 17 Jul 2023 00:24:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1Nr3o2dR8D4cOrHIs9iy+U/HnIZ2nOw1yNVZY9oh634ulhZpCKPMzdl803bJJbCG0cQ7Z7uFm1cJk87SbiugttHtIH4B6as+PO6jQ1exJuYDXHLr8tCjQMCZpachhGZvmrLzLINaTcPLJRmKy/Tpj0kyBNteHs1jTTavRBlY13glPnqlYHt+V5NWVdoRKLA7CuDOI11Cvh6A079Mw+s3JLHr4nrlsbyZ7LTKXiIh6wBvwN6aM05HK6QDyi6tXr23pMkakW637g1HZmXt8eqQLxtz6FRm6B4Kcp9yswIEvN7iBGZiMvZP9lop02YWvrcjwWwYmS2pGoXUNLGU46drA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J0suTqy6jwkZagohEwRfHjhnhqEKxkOZ92odvKXHPs=;
 b=BBQo/BqhhkD8Dhwg+wh1/dRYFQqvSs1pWFHw1zQj3UBYbDWm0dLB1c+JHTJPZ1R0xUuMXWTQ3s9kaSsSq04spgB2WkvXWRLPRnpSQQnI4a3Me4TNqqO1ZXFpjGMmiBd2RY+jOjWzNgjg1se7bKi1v4/E9s0IFv+tw7MvQxENZzv6/f1NpzdrcmQN9K9qe6R8VPAst2TzAB1awi4VFcoLNW7DTv0v/GUJVhFtUlF+GU6t8l/valLWMPEbFeXfCDQbGQ/NWzC0jnVaGHja9gMpYDCQ9nWTNnRttURfIL1+nVpDANJk0H0OAuPXL2/sBt7g+8RprWxbuEmAduoRjt+OPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=microchip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J0suTqy6jwkZagohEwRfHjhnhqEKxkOZ92odvKXHPs=;
 b=b/OuGymZydHd8WdYcgpZBPaT5K36ZXYtdruylUn0DBn7ibfAOVfYtlqNBBkDu8tFFkKQgF6D05iLo9kAotCdwnRcPda1byqz3pAAnbF2+WAnGdbbNfH60tSKp0D/NYdUzke65I0mXVzS5n2qdedkxTGm/QNznB3LfHiY7MxL9KXL2PvPwmUaspoIUVjBUoiSA2ksz9B3iHIh04lKy18PvMC58tCCfgpLXNWhlNC5/+nILc5v7hJ0T3c8UT9D3CX5GhOcX65WFJq8T4lK6ZO+RLhnOQi223sENXzXAs+8RygCpdSb7KOfYrbZnDyWo5ZynjuMQ/f7WMX6YVUYjfkV5g==
Received: from GV3P280CA0102.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::27) by
 GVXPR10MB5791.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Mon, 17 Jul 2023 07:24:32 +0000
Received: from HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::f) by GV3P280CA0102.outlook.office365.com
 (2603:10a6:150:8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 07:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT075.mail.protection.outlook.com (10.152.1.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.20 via Frontend Transport; Mon, 17 Jul 2023 07:24:32 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.30; Mon, 17 Jul 2023 09:24:30 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 15:23:58 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Mon, 17 Jul 2023 15:23:57 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "conor.dooley@microchip.com" <conor.dooley@microchip.com>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "conor@kernel.org" <conor@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, "nm@ti.com" <nm@ti.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Thread-Topic: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support
 for WDIOF_CARDRESET
Thread-Index: AQHZuGRCLgFX7MXJIkCy/VyJlzKtc6+9BoQAgAAB3oA=
Date:   Mon, 17 Jul 2023 07:23:57 +0000
Message-ID: <0fae6c10e6574533b45e59a194b00012db075be0.camel@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
         <20230717040723.1306374-2-huaqian.li@siemens.com>
         <20230717-napped-resample-b4891bedd913@wendy>
In-Reply-To: <20230717-napped-resample-b4891bedd913@wendy>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2C305979EBACF4CA5A49CA16369740E@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT075:EE_|GVXPR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bd970f-8f96-4eea-0190-08db8696dd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQvrcEDLsvo21Kth3v4kUIc99/SK6L1WmCHxyfZDU9/fogjEMK2LCCy0eq2WhUuq723vXN2lPI0yH4DxsmuograKwbrm4+q/dbtIDnavM/u8/ELmgbudITx83PG/GmQocZuz839c7pAMxTergwS01W4aAeHcXM4LyD27NvrB1ZEkt862/6JJ438FlARvn2qLzNHVUJyxLi1B7cuhwO2V52PIZPoQVkBNPB2XpGcNZ7jef6zTCjCCfK9c9zVnMzfhemC5remBq8hgWYZMR0QtvSwX7vmpWfi19I4fqSK9Kx9hqUpYyjRa7Uj6jYUykIvognPWFmdX16YK6OtBrskcaWytgQqCVu+kRrMR2WtXEjTZgcf3XP7yJgoi9MBoIa+NSHnhbdT8GV5szMig9eadw8VpmNu5SnN2gOR/4byXd2gGzAXrdUGOIwBDiReZ8aEGlxyf+vf4j+TAbGdBBA1V0gL+fvyqJMlxBIFWc+VykrShYD/9Fsw1qzROZjHgMHAeR5V74N6l+9UaD7Ka24yX/7hkQVao0Nf+aJGQTzCRinqGjtNlXDYd4V7c/0H4wjKL3hiwISADwT6JcxAacG1XkT4vqoNSK2Ign1NSnHtkiEm6w9Xfy09jAIKtZ4oG96pFXMcKAmmyVQxBiyN5o4Y9zorpHIO0BNU5j1Lx0CiklcGNiO8RuIvZTpvRv9k4ix9ecNonwxcXEp/pEf7KqpXQrmyjlow9DvR0eAQdsewaU28GaxcLO2ZJ8eLDDPB2PrJE
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(316002)(41300700001)(336012)(186003)(956004)(2616005)(26005)(47076005)(7596003)(356005)(7636003)(40460700003)(82740400003)(478600001)(82960400001)(54906003)(4326008)(6916009)(70206006)(70586007)(40480700001)(7416002)(86362001)(8676002)(5660300002)(8936002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:24:32.2644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bd970f-8f96-4eea-0190-08db8696dd94
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT075.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5791
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDA4OjE3ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDE3LCAyMDIzIGF0IDEyOjA3OjIxUE0gKzA4MDAsDQo+IGh1YXFpYW4ubGlA
c2llbWVucy5jb23CoHdyb3RlOg0KPiA+IEZyb206IExpIEh1YSBRaWFuIDxodWFxaWFuLmxpQHNp
ZW1lbnMuY29tPg0KPiA+IA0KPiA+IFRJIFJUSSAoUmVhbCBUaW1lIEludGVycnVwdCkgV2F0Y2hk
b2cgZG9lc24ndCBzdXBwb3J0IHRvIHJlY29yZCB0aGUNCj4gPiB3YXRjaGRvZyBjYXVzZS4gQWRk
IGEgcmVzZXJ2ZWQgbWVtb3J5IHRvIGtub3cgdGhlIGxhc3QgcmVib290IHdhcw0KPiA+IGNhdXNl
ZA0KPiA+IGJ5IHRoZSB3YXRjaGRvZyBjYXJkLiBJbiB0aGUgcmVzZXJ2ZWQgbWVtb3J5LCBzb21l
IHNwZWNpZmljIGluZm8NCj4gPiB3aWxsIGJlDQo+ID4gc2F2ZWQgdG8gaW5kaWNhdGUgd2hldGhl
ciB0aGUgd2F0Y2hkb2cgcmVzZXQgd2FzIHRyaWdnZXJlZCBpbiBsYXN0DQo+ID4gYm9vdC4NCj4g
PiANCj4gPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxv
d3NraUBsaW5hcm8ub3JnPg0KPiANCj4gPiBSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ckBrZXJuZWwub3JnPg0KPiANCj4gSSBkb24ndCByZWNhbGwgYWN0dWFsbHkgcmVwbHlpbmcgdG8g
dGhlIGVhcmxpZXIgcmV2aXNpb25zIG9mIHRoaXMNCj4gcGF0Y2hzZXQsIGxldCBhbG9uZSBwcm92
aWRpbmcgYSByZXZpZXcsIGJ1dCB0aGlzIGlzIG5vdCB0aGUgZW1haWwNCj4gYWRkcmVzcyBJIHdv
dWxkIGhhdmUgdXNlZCwgaGFkIEkgZG9uZSBzby4NCj4gDQo+ID4gUmV2aWV3ZWQtYnk6IFJvYiBI
ZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogTGkgSHVhIFFpYW4g
PGh1YXFpYW4ubGlAc2llbWVucy5jb20+DQpCZWNhdXNlIG9mIG15IG1pc3Rha2UgaW4gdjQsIEkg
ZmVlbCB2ZXJ5IHNhZCBhbmQgc29ycnkuIA0KDQpJIHdhcyB0cnlpbmcgdG8gZml4IGl0IGluIHY1
LCBwbGVhc2UgaWdub3JlIHRoZSB2NCBhbmQganVtcCB0byB2NS4gTWFueQ0KdGhhbmtzIQ0KDQpC
ZXN0IHJlZ2FyZHMsDQpMaSBIdWEgUWlhbg0K
