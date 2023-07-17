Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407D755B86
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGQGYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjGQGYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:24:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AFBE59;
        Sun, 16 Jul 2023 23:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSgKj/ZxCk4dRHpVQaE8PvIg/xdgemPOI6QdQeEEqyLD2hhlI+VSPoCjkfjcD0J/pRyJAzPGkcNvSrdudI4J4NUS7QWOrUV4CfGS8fi0OhipkB4oKlLCxK+RctPBjmRNf+irb8grJrkAi9uqJFyLWvUAVNWgYVWZJhBRBOiog5/qEeYxcIxr+hkLR2I8hroBU/EY+p4C+zfUrnhFaFImHrHYdKZejeQKF+CMoGawFW2YS0jyUelHQrVc4+Nuw187ED2qskijzkJdwCFCFoBZt07y4Tqkk4AcZHPqmASgBWQFluWb+GR5kL3dB3sI9hUA2ObFcyPwsZFQxhvNu40igA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9Qb6nPqmsVPuyZY9PDebDW8K3vG/KYaiE90RhsyiuQ=;
 b=R7H5hjt7M7cHaRmrIg0QfJ8FEgkt59b2kbL0oPN13KuJ6HLSzcxS64KlR3tCAOa9efRJbJohQswmTXt4ybTR0CDEQ+bBuWPlIGKqjBouqL1xgf6p8ng8vH4B999a71EBihPoXLS00vSwR+W/03TWh3nHjOhD4rzH+vB7/JZLGkPa5lBFaox5QdwXGFvJCAC7ClnNNqWwYzvEegSBD0v5W7Xqmi+x/Ofa+KiZ+0lUZupV2Pmt4tOPAkovji2gy6zIJyrC8yioXxUCuk77AKJHIhky5q8lic2TkwnIYS9QkmWKHJiLh+tSiGdhlfFewFqE1QccSQ3qyzAqITBIyS1WMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=linux-watchdog.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9Qb6nPqmsVPuyZY9PDebDW8K3vG/KYaiE90RhsyiuQ=;
 b=g0k3bNWNKpdQMMY9Z0QaC7v1QBPxtzRFqNdWmSWsBWUReQfP2uCUabIK5a8mKV+qEPjxNXwYvXREMMCUaAmzCwbLXneSpLaBmkQJMoOU6HLUxXtrc+13uFSrYp+uWkUINSNWZamGR5R6EGoJnmU5xGVytBwYrwskfcTwK1olI1oDyB87y1E7qAzO+Iuy/c2DB1teYcPxvrxUMHu3Gm9migIQX1Lxpnan7Stx8CV+KnuLgH6+eNhYI520pIJM7zy7ximVZw89TV0+d1yMKRXJcuy8HWSCH5wdQbtMIB8JqDeC6owszgxEyPjXgT6UuT7G6e5NxSVGycLbqrFIhLBClg==
Received: from FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::11)
 by AS1PR10MB7958.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 06:24:05 +0000
Received: from VE1EUR01FT082.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:4a:cafe::d2) by FR3P281CA0039.outlook.office365.com
 (2603:10a6:d10:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.20 via Frontend
 Transport; Mon, 17 Jul 2023 06:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT082.mail.protection.outlook.com (10.152.3.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.22 via Frontend Transport; Mon, 17 Jul 2023 06:24:05 +0000
Received: from CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1118.30; Mon, 17 Jul 2023 08:24:02 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M10MSX.ad011.siemens.net (139.24.237.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 14:24:00 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Mon, 17 Jul 2023 14:24:00 +0800
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
Thread-Index: AQHZuGQ+yWzLgdq38k6AjTC46fileq+89ZKAgAACDgA=
Date:   Mon, 17 Jul 2023 06:24:00 +0000
Message-ID: <e57e5d8efc3107b5f2c4e66492650b9d0c17b898.camel@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
         <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
In-Reply-To: <f5ff9616-c71c-f71e-ce4a-7b9fa7055bb4@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E95286F8D046C4F91391E9383BB2651@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT082:EE_|AS1PR10MB7958:EE_
X-MS-Office365-Filtering-Correlation-Id: 116ae190-4acb-4022-60ed-08db868e6bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONbt2x5ZehuCTw8hLKWYW0W+iq1tHWKZY3UNcjOYD931r/y5EyPdidH8PhKMBTeCHRRmfVT3AaHXwVXCfLIzmLD5HioPvbMbtduEynt6g+3m5CVCejljnQlaSswcGXN6DfTeUzNcZmsDXHAQ0wfPzp1+5wITFfgVnQ83PsK/GdmeELzKIRz3Hr0UDIIW2HM81yTQw0Npju7ynOzQNFzP81/Bdhfk38JmwidHHXwE/sCyJUc7qr7jLnaXSsEN4e6nchLKWmJh3KX6hUbu/P0yYNXIBt5rRVZ+XJjOBhLH4IssV79p9nfX+0qs8y97IrS/zwsUAVk6NhkEKYTnHH+gaz5hzN3Kns7kExoOJKN9eJM4+6cTZUagHgv8KSDZvV4G5JtSEhBd47s9gcgcORb9WIhb5e50nDNOdlicp4zhI1CsGdw8vu70epUE6lpO29bNtC3Gs5r0Gaj/FLUupArFTtrqUNc73ggU2paSuJJcDdywj1Zoxg/Mrep2ES/7JjHroVRASV4nWv8JU4pC2LCpdnMRPFR/tKn4ypcW9hmISLS6GKyfNPD4tUfgQYVM4+r3qryV3E0g/umLjs9tYb0gYmMBi75OK9vJDyZVJdyw5PsrU5dons5oZQrleNDhp1KRKEowqP3+79AMVnRiR5+xBGO2dF2eyVogNmjpCSYp4SI8QGh9tSzKvLTXo+ECJiygjHwTVaiCCUmEMW8l8izsgs/JukJXclNkkcVM3JwTPvm6GPTote1082LxTboZagNNXEL07N+6DcHKuisgDgAhig==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(26005)(53546011)(966005)(36756003)(36860700001)(47076005)(2616005)(336012)(86362001)(356005)(81166007)(82960400001)(82740400003)(186003)(956004)(40480700001)(8676002)(8936002)(2906002)(41300700001)(478600001)(7416002)(4326008)(5660300002)(316002)(70586007)(70206006)(54906003)(110136005)(45080400002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 06:24:05.4425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116ae190-4acb-4022-60ed-08db868e6bd1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT082.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7958
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTE3IGF0IDA4OjE2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNy8wNy8yMDIzIDA2OjA3LCBodWFxaWFuLmxpQHNpZW1lbnMuY29twqB3cm90
ZToNCj4gPiBGcm9tOiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4NCj4gPiAN
Cj4gPiBUaGUgd2F0Y2hkb2cgaGFyZHdhcmUgb2YgVEkgQU02NVggcGxhdGZvcm0gZG9lcyBub3Qg
c3VwcG9ydA0KPiA+IFdESU9GX0NBUkRSRVNFVCBmZWF0dXJlLCBhZGQgYSByZXNlcnZlZCBtZW1v
cnkgdG8gc2F2ZSB0aGUgd2F0Y2hkb2cNCj4gPiByZXNldCBjYXVzZSwgdG8ga25vdyBpZiB0aGUg
Ym9hcmQgcmVib290IGlzIGR1ZSB0byBhIHdhdGNoZG9nDQo+ID4gcmVzZXQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+DQo+ID4g
LS0tDQo+ID4gQ2hhbmdlcyBpbiB2NDoNCj4gPiAtIEZpeCB0aGUgY29kaW5nIHN0eWxlLg0KPiA+
IC0gQWRkIHVzYWdlIG5vdGUgZm9yIHRoZSByZXNlcnZlZCBtZW1vcnkuDQo+ID4gLSBMaW5rIHRv
IHYzOg0KPiA+IMKgDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2F0Y2hkb2cv
MjAyMzA3MTMwOTUxMjcuMTIzMDEwOS0xLWh1YXFpYW4ubGlAc2llbWVucy5jb20NCj4gDQo+IE11
Y2ggbW9yZSBjaGFuZ2VkLiBZb3UgYWRkZWQgZXhhbXBsZSBpbiB0aGUgYmluZGluZ3Mgd2hpY2gg
bm8gb25lDQo+IGFza2VkDQo+IGZvci4gVGhlbiB5b3UgYWRkZWQgbXVsdGlwbGUgZmFrZSByZXZp
ZXcgdGFncyB0byBhbGwgdGhlIHBhdGNoZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KPiANCkhpLA0KDQpTb3JyeSBmb3IgdGhlIHdyb25nIHN0YXRlbWVudC4gSSBtaXNzZWQg
c29tZSBrZXkgaW5mb3JtYXRpb24gYW5kDQptaXNzdW5kZXJzdG9vZCBgUmV2aWV3ZWQtYnlgLCBJ
IHRyZWF0ZWQgYFJldmlld2VkLWJ5YCBhcyBgV2hvDQpoYXMgcmV2aWV3ZWRgLg0KDQpCZXN0IHJl
Z2FyZHMsDQpMaSBIdWEgUWlhbg0K
