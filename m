Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD69755C14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGQGtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGQGts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:49:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF9218F;
        Sun, 16 Jul 2023 23:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2D0vpWNg8SONvv8OiTJ1D9riL6Zewab5KqeiFtQ8UIV77JWT9fEV9gEIUc1FTkyXEN9/kdwxNfQUzvqtORrhPW7XI4swdD5k2DnHAKdC6Jjwht5Rb+hE36q8pqVfJc3hw4hZ1RTqXc/dG+JZ18Kjh1vCm2STRifIL1Ct7wlUmo5Y0CbIt4kttBsbEfgVNednj0BZmaslC7a9Osbl+nl9P0aISbLSBHpRE5shq6oswQLvYxiQaEhwTwJwMkpnCHvrO0Nd5RL6ttZQ+pmY5o6baPwyCPheRtK8l3hYsywWfc6NhlGEUEjD4O4fcV7k7n6ZD/J3iqL0KAtYYF1NkdpiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwZe0dhrvtZK8p8PmTGv5HC4owXeByAGa/bofy4j1h8=;
 b=AiutylPU+0GKFjRbzN7qrbB6aj7RWcHTCLrbjzQe4Z24VZvGUAgsuu5P/KpAP0yEStIMlMZavMH5+k3pjDKALOMWV1tdxkwKFhRAhHRfe5magXtbxF6Bc0OhpUDzbsANlQI/VnTIw9efHoJ/7m30h17BFpVw353+Gc2mimBn7V/IpRXULfpAJ5bqOpEYnPycFlX0aNuI05w8hIP6YSazoWGnK7rqriI3tQ0wdryG3oUP8t18mrsZPRifJe2GBwN21lB5SvnlWMYkQIFCubb686mR1BQG8eGCbIz0H4X5WCB0xBW6nLc8Ez5s4FyicE5t+IsP6/XMU5RbZyaoRAY2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwZe0dhrvtZK8p8PmTGv5HC4owXeByAGa/bofy4j1h8=;
 b=whpLYZCu9ag/mqDu0mlcQO7ATwac5AQF/UsalHXTAveU2lNY7v1AauVTxaIQzoVCxer3nZUmQHyRxqkv4u2gqbnDZvYM9mN4qj8IDzOYHldbFSsfI/DkNeqjo9PSyCWFrLJZbeMEkCYJuY366BvC5Xkstl/pl9b2P+HNRWxqndDHJ/ZhjV7SzNQyWa/w2ymD570XCCoZmeB1YsDKgkTl/L36Ucgp/OWY/0nAkTNUvLurtDw10qBIL3IE9vir4RCUBTqPqa0KIvq+xj/nyO24h8Nb4/Elzvu999vW+Nx9JoQeWsvL+viEfMSEqNK+E4590XhqTbgAl5AuX6tT7x7vgA==
Received: from DB9PR06CA0009.eurprd06.prod.outlook.com (2603:10a6:10:1db::14)
 by AS8PR10MB5901.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:526::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 06:49:45 +0000
Received: from DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1db:cafe::e2) by DB9PR06CA0009.outlook.office365.com
 (2603:10a6:10:1db::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 06:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT028.mail.protection.outlook.com (10.152.4.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.22 via Frontend Transport; Mon, 17 Jul 2023 06:49:44 +0000
Received: from CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 08:49:41 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M09MSX.ad011.siemens.net (139.24.237.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 14:49:39 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Mon, 17 Jul 2023 14:49:39 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Topic: [PATCH v4 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Index: AQHZuGQ+yWzLgdq38k6AjTC46fileq+89ZKAgAACDgCAAAEkgIAAAcyAgAACkwCAAAGqgA==
Date:   Mon, 17 Jul 2023 06:49:39 +0000
Message-ID: <e31f837c71bcee9ae993b805d373964558e9910d.camel@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
         <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
         <e57e5d8efc3107b5f2c4e66492650b9d0c17b898.camel@siemens.com>
         <625a92b8-b629-a4ef-6176-635e1b7885db@linaro.org>
         <b82847f51ec00d873a38eab21b7ada885593aeb8.camel@siemens.com>
         <c266f810-6fb3-2fcd-1c44-163f9b0a0dbc@linaro.org>
In-Reply-To: <c266f810-6fb3-2fcd-1c44-163f9b0a0dbc@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3577BB0E7DDAC4B94F8C87C73CD1EE7@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT028:EE_|AS8PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: fa83291d-33a0-4561-3acd-08db8692013e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L56uQUVTDbPMyhYL3uCXWdqGQTW5PamCIYGOLsQVwgoysoXc7lgHcNBxv5ewxNF8bLqBZ/aov9u3zq3hQOhJoIjPnjdeIYr77qPCwzTWB3vxomEP9eagBIK8dvlF7g8ElqHE/fPbDvsE7HygB6mnIZI7T4UJjLUWtksttGoi0Uf3effPv2q5NVK3HeQg/xKgGxuhD9RiQf13Youqsuyo0miT9mf941Zz/SjdeGMw47E1YBkFp3AvFL50u6rWrBKaUJ6t8W9bWZkZZ65fvBXGk33mPbOsHfrJSGyY/lOZUjJsFbD39RjDSe/jAAir/8vbLp2b32tUeTBscC/TCXWGhdAf9SLpqSCrbhqeqXkUx43EMsV24s6N/PlGEuDnTaavzQdAi1DKNzCXDTFkgIy6myKdfSPcdOCUGPvQ9T7Nr+bK3WO4vHfjZJ/+K+APzl7rppzCElGlsAEVA4buz7NdbXFabyPz3GPhqg30sm8mJ65GvqasQ/88rtBYaMpDPphuqIOC+50fHcVEvpRZYfKO/cExOH513uiSOK/ugxVDrFD9DSwMftDOEj541LSZCu291zsl2+k8+bTGYqvfqAmdR2Qu2Ir73Eps79R3xmcs1tJBLTIWWflEN6B6y26Kv55NyJDu1B4pjA86G3T3B5Svsmv5GC0cK+5ZQmv2Xtox120bQt1GHPtr3ESDuXhhHr6C10VRznYNVKLQTUBPSI4DquOqhikN06eoTgh/IiEVK6BfcAE5uZKXFzZkxTMxMB77bFbrGHc6itYCrqYdB6Uwlg==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(82960400001)(82740400003)(40460700003)(336012)(26005)(186003)(53546011)(110136005)(478600001)(45080400002)(54906003)(966005)(7416002)(8676002)(41300700001)(8936002)(2906002)(70206006)(70586007)(316002)(36860700001)(4326008)(5660300002)(36756003)(956004)(2616005)(47076005)(81166007)(86362001)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:49:44.6478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa83291d-33a0-4561-3acd-08db8692013e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDA4OjQzICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNy8wNy8yMDIzIDA4OjM0LCBMaSwgSHVhIFFpYW4gd3JvdGU6DQo+ID4gT24g
TW9uLCAyMDIzLTA3LTE3IGF0IDA4OjI3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3Rl
Og0KPiA+ID4gT24gMTcvMDcvMjAyMyAwODoyNCwgTGksIEh1YSBRaWFuIHdyb3RlOg0KPiA+ID4g
PiBPbiBNb24sIDIwMjMtMDctMTcgYXQgMDg6MTYgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kg
d3JvdGU6DQo+ID4gPiA+ID4gT24gMTcvMDcvMjAyMyAwNjowNywgaHVhcWlhbi5saUBzaWVtZW5z
LmNvbcKgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBz
aWVtZW5zLmNvbT4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIHdhdGNoZG9nIGhhcmR3
YXJlIG9mIFRJIEFNNjVYIHBsYXRmb3JtIGRvZXMgbm90IHN1cHBvcnQNCj4gPiA+ID4gPiA+IFdE
SU9GX0NBUkRSRVNFVCBmZWF0dXJlLCBhZGQgYSByZXNlcnZlZCBtZW1vcnkgdG8gc2F2ZSB0aGUN
Cj4gPiA+ID4gPiA+IHdhdGNoZG9nDQo+ID4gPiA+ID4gPiByZXNldCBjYXVzZSwgdG8ga25vdyBp
ZiB0aGUgYm9hcmQgcmVib290IGlzIGR1ZSB0byBhDQo+ID4gPiA+ID4gPiB3YXRjaGRvZw0KPiA+
ID4gPiA+ID4gcmVzZXQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IExpIEh1YSBRaWFuIDxodWFxaWFuLmxpQHNpZW1lbnMuY29tPg0KPiA+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gPiBDaGFuZ2VzIGluIHY0Og0KPiA+ID4gPiA+ID4gLSBGaXggdGhlIGNvZGluZyBz
dHlsZS4NCj4gPiA+ID4gPiA+IC0gQWRkIHVzYWdlIG5vdGUgZm9yIHRoZSByZXNlcnZlZCBtZW1v
cnkuDQo+ID4gPiA+ID4gPiAtIExpbmsgdG8gdjM6DQo+ID4gPiA+ID4gPiDCoA0KPiA+ID4gPiA+
ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2F0Y2hkb2cvMjAyMzA3MTMwOTUxMjcu
MTIzMDEwOS0xLWh1YXFpYW4ubGlAc2llbWVucy5jb20NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBN
dWNoIG1vcmUgY2hhbmdlZC4gWW91IGFkZGVkIGV4YW1wbGUgaW4gdGhlIGJpbmRpbmdzIHdoaWNo
IG5vDQo+ID4gPiA+ID4gb25lDQo+ID4gPiA+ID4gYXNrZWQNCj4gPiA+ID4gPiBmb3IuIFRoZW4g
eW91IGFkZGVkIG11bHRpcGxlIGZha2UgcmV2aWV3IHRhZ3MgdG8gYWxsIHRoZQ0KPiA+ID4gPiA+
IHBhdGNoZXMuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gPiA+
IEtyenlzenRvZg0KPiA+ID4gPiA+IA0KPiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4gPiA+IFNv
cnJ5IGZvciB0aGUgd3Jvbmcgc3RhdGVtZW50LiBJIG1pc3NlZCBzb21lIGtleSBpbmZvcm1hdGlv
bg0KPiA+ID4gPiBhbmQNCj4gPiA+ID4gbWlzc3VuZGVyc3Rvb2QgYFJldmlld2VkLWJ5YCwgSSB0
cmVhdGVkIGBSZXZpZXdlZC1ieWAgYXMgYFdobw0KPiA+ID4gPiBoYXMgcmV2aWV3ZWRgLg0KPiA+
ID4gDQo+ID4gPiBCdXQgeW91IGRvbid0IGhhdmUgZXZlbiB0aGF0IGluZm9ybWF0aW9uIHdobyBo
YXMgcmV2aWV3ZWQhIFdoZXJlDQo+ID4gPiBkbw0KPiA+ID4geW91DQo+ID4gPiBzZWUgYW55IHJl
dmlld3MgY29taW5nIGZyb20gbWUgZm9yIHBhdGNoICMyPyBXaGVyZSBkbyB5b3Ugc2VlDQo+ID4g
PiByZXZpZXdzDQo+ID4gPiBmcm9tIFJvYiBmb3IgcGF0Y2ggIzM/DQo+ID4gPiANCj4gPiA+IEJl
c3QgcmVnYXJkcywNCj4gPiA+IEtyenlzenRvZg0KPiA+ID4gDQo+ID4gSSBnb3QgdGhlc2UgaW5m
b3JtYXRpb24gZnJvbSBteSBlbWFpbCB0aHJlYWQuIEFueXdheSBJIG1hZGUgYQ0KPiA+IHN0dXBp
ZA0KPiA+IG1pc3Rha2UsIHNvcnJ5IGZvciB3YXN0aW5nIHlvdXIgdGltZS4NCj4gPiANCj4gPiBC
eSB0aGUgd2F5LCB3aGVuIHlvdSB3cm90ZSB0aGUgZm9sbG93aW5nIGluICdbUEFUQ0ggdjMgMS8z
XSBkdC0NCj4gPiBiaW5kaW5nczogd2F0Y2hkb2c6IHRpLHJ0aS13ZHQ6IEFkZCBzdXBwb3J0IGZv
ciBXRElPRl9DQVJEUkVTRVQnLA0KPiA+IHlvdQ0KPiA+IHdlcmUga2luZCBvZiBzYXlpbmcgdGhh
dCBpdCBsb29rcyBnb29kIHRvIHlvdSBpZiBJIHJlbW92ZSB0aGUgZXh0cmENCj4gPiBlbXB0eSBs
aW5lLCByaWdodD8NCj4gPiANCj4gPiBJbiBhbnkgY2FzZToNCj4gPiBSZXZpZXdlZC1ieTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiANCj4g
VGhpcyB3YXMgcGF0Y2ggMS4gQnV0IHlvdSBhZGRlZCBteSByZXZpZXcgdG8gcGF0Y2ggMiBhbHNv
LiBXaHkgdGhlbg0KPiBub3QNCj4gYWRkaW5nIHRvIHBhdGNoIDM/IFdoYXQgbG9naWMgaXMgZHJp
dmluZyB0aGlzPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQpNdWNoIHNv
cnJ5IGFnYWluLCBwbGVhc2UgZm9yZ2V0IHRoZSB3cm9uZyBpbmZvIGluIHY0LiBJIHdyb25nbHkg
YWRkZWQNCnlvdSB0byBwYXRjaCAyIG9ubHkgYmVjYXVzZSBJIGZvdW5kIHlvdSBjb21tZW50ZWQg
b24gcGF0Y2ggMiBvbmNlLg0KDQpCZXN0IHJlZ2FyZHMsDQpMaSBIdWEgUWlhbg0K
