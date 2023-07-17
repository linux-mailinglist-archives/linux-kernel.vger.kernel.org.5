Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DFA755C85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjGQHOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGQHOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:14:06 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2079.outbound.protection.outlook.com [40.107.249.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C02DE7F;
        Mon, 17 Jul 2023 00:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF8Ab9GrDHqX2cwFNy6u15HbSsEAUwsLiO8z9m5kF1U5ckRZRU68qFQe+4SuPhnBCan9NEQ8STrHxdTvQx7FZJPwil0XE8GVRkFJ0y4zd0YmkRrc1s2hamG/m76Li/cDR6X840V1cfjrsySxljPOEzGC79LEsVYUQaCXZhtv0bUx+hT0mxynpzfGuhcJrSkBzc+lhu2DS3TaGqlLGLnOYMdZFRjaHVzDaUNuo2PvZL03xwnYhEezfAf3/1JZKW1nHRVUsdewD5odRRhsdGldJZe1ygQ/CGA3+rYAslfyfVpjuO+WLx2LcwqHYojSafMK4RFHDRIhQcWGEcxmQIE+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKnxVdXo9InJ/MIwApRcLV1xxQeILOFQE+mGiHkqhmc=;
 b=dtBVcQ9iY9bJHTAKMev1KlOxbchwjXzFz0n7yfrfpaWPezyj+y4iZHZy7LRFuX+8V9bTgtyiDJG0fjOUjyF26N7p5mt4CfawzYm5ctZz8MTyWwNL3UEfX0srJdAIt0Musy305+juZ4jcJQxiAfvu0o1l0PKFfEJ8cTG6CZ3a77kwTOv2DP+iX6WN5hGuHyEvQPLn0JuEPFhazqXi/rVQj3oDN5sNIi7ar4oYeKFdZGS7jh6cjNiaz/lbIPqsDDBReQSdTg8s1I1gHYR0ZRQ7MkVy+Gpgwku42sowVLnjD1p8FwzqVh7abFmmY7FSRfMSBuvnFXnXPlGlF+er2Gi/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKnxVdXo9InJ/MIwApRcLV1xxQeILOFQE+mGiHkqhmc=;
 b=WLIds2BufB/G1Nz8tGSI3YH+IP/Wqs0Dp3reGLt7t78H1oaTrzhgMJIelogJzFFXkdUeCx7hl0oBqxhv2amgSL2nVwqzJH8zuFPnej1ODTlnQPNpa0y7g6MSndWNji/2+erYYXz2XTfnJoUVsF1TygLNlD3O65TW2n63s4fpaRbfL0TF7NJwBXs867l4o4RsplSviapPMJ0yCOmyqrJ8UhepgdElzz2697eQJ8j4NSCiyyfsFqmdjd7l7vY1D6/GgF4KU3fnHczqgYpYM596Jq8r2xSxnJnpze88JtL5qFvjGF8ko6n1QfctI560UX62MkrDw/7Y70X3gtNjTZPorA==
Received: from DBBPR09CA0025.eurprd09.prod.outlook.com (2603:10a6:10:d4::13)
 by PAVPR10MB7490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:14:02 +0000
Received: from DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::5f) by DBBPR09CA0025.outlook.office365.com
 (2603:10a6:10:d4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32 via Frontend
 Transport; Mon, 17 Jul 2023 07:14:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT085.mail.protection.outlook.com (10.152.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.22 via Frontend Transport; Mon, 17 Jul 2023 07:14:01 +0000
Received: from CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 09:13:55 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 15:13:53 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Mon, 17 Jul 2023 15:13:52 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "conor@kernel.org" <conor@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "kristo@kernel.org" <kristo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huaqianlee@gmail.com" <huaqianlee@gmail.com>,
        "nm@ti.com" <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Su, Bao Cheng" <baocheng.su@siemens.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support for
 WDIOF_CARDRESET
Thread-Topic: [PATCH v4 1/3] dt-bindings: watchdog: ti,rti-wdt: Add support
 for WDIOF_CARDRESET
Thread-Index: AQHZuGRCLgFX7MXJIkCy/VyJlzKtc6+85KAAgAAg8QA=
Date:   Mon, 17 Jul 2023 07:13:52 +0000
Message-ID: <5feeb3f46e135b95781a8db5774a9fb3ed5802bb.camel@siemens.com>
References: <20230717040723.1306374-1-huaqian.li@siemens.com>
         <20230717040723.1306374-2-huaqian.li@siemens.com>
         <43eea233-5024-bc0a-2872-8c037ec1db67@roeck-us.net>
In-Reply-To: <43eea233-5024-bc0a-2872-8c037ec1db67@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED6747995425D14AB5D4DD88CA0F0F2D@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT085:EE_|PAVPR10MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afd71ac-09fc-4982-5fd1-08db869565a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLJTnmCketZZnWCh66gFLsXatF0XRvttrUSkCHOy/j89YHmT3V2NLBYuLvDgtV1zB6rIXUPrx1KKSfaSqcy0rQPow1/0M+dxkH6pOcHBnVNE4C9fIiy36jKtuauYDDhwkXK2DLVjIE3dW9e3hMzA81ccekx83mfPbvGmLEMLQd3cWXeAC5jwOeYN4/RNn/My0nUzqI2BdeFNQCJcKU8Sxcrh8EAZJQOjP9Gl5YvNPDXUgp/V3iX2BEFwTrxdkGncFsVtPrJsrEmP6c2NTsSxUWX8QmxtDYVPuFzBe3CEXxz16WyYBEOI8tanpmTRFk96hQqYxAKzLZDSnzCfZK40sTRjhHcbzwCzndGjL5kMMZYqyRC+Fv23mHvcnfKKwDs6Y0iOXlDDkZhsfvP7v4UpD1/4Uc26WladF0oGziTn3PALSetHB6zN3ana4s6Nn2clAl8kSWD5ZiCuNar76u4Sq+X40XqFCQrkVWuX/CdrJtdBfZY89Ji4h0092026rf/qV7VpcYyrM85zpAjSb2d0DPKudJdqXaiWZ4UUKUlil32R50+swRgyrwDvAyobeEHh6HOGBiVJsvmCMj5v0j2DB8jSKBVp4lxayvicLigFUuzLAhu2y7uXFBkUz+d2oyB6lD1hDKM7GYO+zf5pqQ5auF5elo84FNvvhy0SraBJlcTuD53y7tyJ3j9ZAb7E2MyU51KY9DXk97PmN9UfGno5j+26fom9LuJCipM+sCaOVsr1JwkXaNxAFck7+RaAXnsXIMTSCmOxXGNbXYsAiLYARw==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(36860700001)(316002)(41300700001)(83380400001)(336012)(53546011)(186003)(956004)(2616005)(26005)(47076005)(356005)(40460700003)(82740400003)(478600001)(81166007)(82960400001)(110136005)(54906003)(4326008)(70206006)(70586007)(40480700001)(7416002)(86362001)(8676002)(5660300002)(8936002)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:14:01.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afd71ac-09fc-4982-5fd1-08db869565a9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIzLTA3LTE2IGF0IDIyOjE1IC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiA3LzE2LzIzIDIxOjA3LCBodWFxaWFuLmxpQHNpZW1lbnMuY29twqB3cm90ZToNCj4gPiBG
cm9tOiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBUSSBS
VEkgKFJlYWwgVGltZSBJbnRlcnJ1cHQpIFdhdGNoZG9nIGRvZXNuJ3Qgc3VwcG9ydCB0byByZWNv
cmQgdGhlDQo+ID4gd2F0Y2hkb2cgY2F1c2UuIEFkZCBhIHJlc2VydmVkIG1lbW9yeSB0byBrbm93
IHRoZSBsYXN0IHJlYm9vdCB3YXMNCj4gPiBjYXVzZWQNCj4gPiBieSB0aGUgd2F0Y2hkb2cgY2Fy
ZC4gSW4gdGhlIHJlc2VydmVkIG1lbW9yeSwgc29tZSBzcGVjaWZpYyBpbmZvDQo+ID4gd2lsbCBi
ZQ0KPiA+IHNhdmVkIHRvIGluZGljYXRlIHdoZXRoZXIgdGhlIHdhdGNoZG9nIHJlc2V0IHdhcyB0
cmlnZ2VyZWQgaW4gbGFzdA0KPiA+IGJvb3QuDQo+ID4gDQo+ID4gUmV2aWV3ZWQtYnk6IEtyenlz
enRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gPiBSZXZp
ZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vckBrZXJuZWwub3JnPg0KPiA+IFJldmlld2VkLWJ5
OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExpIEh1
YSBRaWFuIDxodWFxaWFuLmxpQHNpZW1lbnMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IEd1ZW50
ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVzLm5ldD4NCkhpIEd1ZW50ZXIsDQoNCkknbSBnb2luZyB0
byBpbnRlZ3JhdGUgaXQgd2l0aCB0aGUgZXhpc3RpbmcgYmluZGluZyBhcyBLcnp5c3p0b2YNCnN1
Z2dlc3RlZCwgY291bGQgSSBsZWF2ZSB5b3UgaW4gYFJldmlld2VkLWJ5YD8NCg0KICAgNTkgZXhh
bXBsZXM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KICAgNjAgICAtIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KICAgNjEgICAgIC8qICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgNjIgICAgICAqIFJUSSBXRFQg
aW4gbWFpbiBkb21haW4gb24gSjcyMWUgU29DLiBBc3NpZ25lZCBjbG9ja3MgYXJlDQp1c2VkIHRv
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQogICA2MyAgICAgICogc2VsZWN0IHRoZSBzb3VyY2UgY2xvY2sgZm9yIHRoZSB3YXRj
aGRvZywgZm9yY2luZyBpdCB0bw0KdGljayB3aXRoICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KfiAgNjQgICAgICAqIGEgMzJrSHog
Y2xvY2sgaW4gdGhpcyBjYXNlLiBBZGQgYSByZXNlcnZlZA0KbWVtb3J5KG9wdGlvbmFsKSB0byBr
ZWVwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0Kfl8gNjUg
ICAgICAqIHRoZSB3YXRjaGRvZyByZXNldCBjYXVzZSBwZXJzaXN0ZW50LCB3aGljaCB3YXMgYmUg
d3JpdHRlbg0KaW4gMTIgYnl0ZXMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIA0KICAgNjYgICAgICAqIHN0YXJ0aW5nIGZyb20gMHhhMjIw
MDAwMCBieSBSVEkgV2F0Y2hkb2cgRmlybXdhcmUuICAgICAgIA0KICAgNjcgICAgICAqICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAg
NjggICAgICAqIFJlc2VydmVkIG1lbW9yeSBzaG91bGQgYmUgZGVmaW5lZCBhcyBmb2xsb3dzOiAg
ICAgICAgICAgIA0KICAgNjkgICAgICAqIHJlc2VydmVkLW1lbW9yeSB7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgNzAgICAgICAqICAgICB3ZHRfcmVzZXRfbWVt
b3J5X3JlZ2lvbjogd2R0LW1lbW9yeUBhMjIwMDAwMCB7ICAgICAgIA0KICAgNzEgICAgICAqICAg
ICAgICAgcmVnID0gPDB4MDAgMHhhMjIwMDAwMCAweDAwIDB4MTAwMD47ICAgICAgICAgICAgIA0K
ICAgNzIgICAgICAqICAgICAgICAgbm8tbWFwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIA0KICAgNzMgICAgICAqICAgICB9OyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgNzQgICAgICAqIH0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgNzUgICAgICAq
LyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IA0KfiAgNzYgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9zb2MvdGksc2NpX3BtX2RvbWFpbi5o
PiAgICAgICAgICAgICAgIA0KKyAgNzcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KKyAgNzggICAgIHdhdGNoZG9nQDIyMDAw
MDAgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgNzkgICAg
ICAgICBjb21wYXRpYmxlID0gInRpLGo3LXJ0aS13ZHQiOyAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KfiAgODAgICAgICAgICByZWcgPSA8MHgyMjAwMDAwIDB4MTAwPjsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KfiAgODEgICAgICAgICBjbG9ja3MgPSA8JmszX2Nsa3MgMjUy
IDE+OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KfiAgODIgICAgICAgICBwb3dlci1k
b21haW5zID0gPCZrM19wZHMgMjUyIFRJX1NDSV9QRF9FWENMVVNJVkU+OyAgICAgIA0KfiAgODMg
ICAgICAgICBhc3NpZ25lZC1jbG9ja3MgPSA8JmszX2Nsa3MgMjUyIDE+OyAgICAgICAgICAgICAg
ICAgICAgIA0KfiAgODQgICAgICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZrM19jbGtz
IDI1MiA1PjsgICAgICAgICAgICAgIA0KICAgODUgICAgICAgICBtZW1vcnktcmVnaW9uID0gPCZ3
ZHRfcmVzZXRfbWVtb3J5X3JlZ2lvbj47ICAgICAgICAgICAgIA0KICAgODYgICAgIH07ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KDQpC
ZXN0IHJlZ2FyZHMsDQpMaSBIdWEgUWlhbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IA0KPiA+IC0tLQ0KPiA+IMKgIC4uLi9iaW5k
aW5ncy93YXRjaGRvZy90aSxydGktd2R0LnlhbWzCoMKgwqDCoMKgwqDCoMKgIHwgNDENCj4gPiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDQxIGluc2VydGlvbnMo
KykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3dhdGNoZG9nL3RpLHJ0aS0NCj4gPiB3ZHQueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy93YXRjaGRvZy90aSxydGktDQo+ID4gd2R0LnlhbWwNCj4gPiBpbmRleCBm
YzU1MzIxMWU0MmQuLjRiNjZjNGZjZGYzNSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdGkscnRpLXdkdC55YW1sDQo+ID4gKysrIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3RpLHJ0aS13ZHQueWFt
bA0KPiA+IEBAIC0zNCw2ICszNCwyMCBAQCBwcm9wZXJ0aWVzOg0KPiA+IMKgwqDCoCBwb3dlci1k
b21haW5zOg0KPiA+IMKgwqDCoMKgwqAgbWF4SXRlbXM6IDENCj4gPiDCoCANCj4gPiArwqAgbWVt
b3J5LXJlZ2lvbjoNCj4gPiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gK8KgwqDCoCBkZXNjcmlw
dGlvbjoNCj4gPiArwqDCoMKgwqDCoCBDb250YWlucyB0aGUgd2F0Y2hkb2cgcmVzZXJ2ZWQgbWVt
b3J5LiBJdCBpcyBvcHRpb25hbC4NCj4gPiArwqDCoMKgwqDCoCBJbiB0aGUgcmVzZXJ2ZWQgbWVt
b3J5LCB0aGUgc3BlY2lmaWVkIHZhbHVlcywgd2hpY2ggYXJlDQo+ID4gK8KgwqDCoMKgwqAgUE9O
X1JFQVNPTl9TT0ZfTlVNKDB4QkJCQkNDQ0MpLA0KPiA+IFBPTl9SRUFTT05fTUFHSUNfTlVNKDB4
REREREREREQpLA0KPiA+ICvCoMKgwqDCoMKgIGFuZCBQT05fUkVBU09OX0VPRl9OVU0oMHhDQ0ND
QkJCQiksIGFyZSBwcmUtc3RvcmVkIGF0IHRoZQ0KPiA+IGZpcnN0DQo+ID4gK8KgwqDCoMKgwqAg
MyAqIDQgYnl0ZXMgdG8gdGVsbCB0aGF0IGxhc3QgYm9vdCB3YXMgY2F1c2VkIGJ5IHdhdGNoZG9n
DQo+ID4gcmVzZXQuDQo+ID4gK8KgwqDCoMKgwqAgT25jZSB0aGUgUE9OIHJlYXNvbiBpcyBjYXB0
dXJlZCBieSBkcml2ZXIocnRpX3dkdC5jKSwgdGhlDQo+ID4gZHJpdmVyDQo+ID4gK8KgwqDCoMKg
wqAgaXMgc3VwcG9zZWQgdG8gd2lwZSB0aGUgd2hvbGUgbWVtb3J5IHJlZ2lvbi4gU3VyZWx5LCBp
ZiB0aGlzDQo+ID4gK8KgwqDCoMKgwqAgcHJvcGVydHkgaXMgc2V0LCBhdCBsZWFzdCAxMiBieXRl
cyByZXNlcnZlZCBtZW1vcnkgc3RhcnRpbmcNCj4gPiBmcm9tDQo+ID4gK8KgwqDCoMKgwqAgc3Bl
Y2lmaWMgbWVtb3J5IGFkZHJlc3MoMHhhMjIwMDAwKSBzaG91bGQgYmUgc2V0LiBNb3JlDQo+ID4g
cGxlYXNlDQo+ID4gK8KgwqDCoMKgwqAgcmVmZXIgdG8gRXhhbXBsZSAyLg0KPiA+ICsNCj4gPiDC
oCByZXF1aXJlZDoNCj4gPiDCoMKgwqAgLSBjb21wYXRpYmxlDQo+ID4gwqDCoMKgIC0gcmVnDQo+
ID4gQEAgLTU5LDMgKzczLDMwIEBAIGV4YW1wbGVzOg0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoCBh
c3NpZ25lZC1jbG9ja3MgPSA8JmszX2Nsa3MgMjUyIDE+Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZrM19jbGtzIDI1MiA1PjsNCj4gPiDCoMKgwqDC
oMKgIH07DQo+ID4gKw0KPiA+ICvCoCAtIHwNCj4gPiArwqDCoMKgIC8vIEV4YW1wbGUgMiAoQWRk
IHJlc2VydmVkIG1lbW9yeSBmb3Igd2F0Y2hkb2cgcmVzZXQgY2F1c2UpOg0KPiA+ICvCoMKgwqAg
LyoNCj4gPiArwqDCoMKgwqAgKiBSVEkgV0RUIGluIG1haW4gZG9tYWluIG9uIEo3MjFlIFNvQy4g
QXNzaWduZWQgY2xvY2tzIGFyZQ0KPiA+IHVzZWQgdG8NCj4gPiArwqDCoMKgwqAgKiBzZWxlY3Qg
dGhlIHNvdXJjZSBjbG9jayBmb3IgdGhlIHdhdGNoZG9nLCBmb3JjaW5nIGl0IHRvDQo+ID4gdGlj
ayB3aXRoDQo+ID4gK8KgwqDCoMKgICogYSAzMmtIeiBjbG9jayBpbiB0aGlzIGNhc2UuIEFkZCBh
IHJlc2VydmVkIG1lbW9yeSB0byBrZWVwDQo+ID4gdGhlDQo+ID4gK8KgwqDCoMKgICogd2F0Y2hk
b2cgcmVzZXQgY2F1c2UgcGVyc2lzdGVudCwgd2hpY2ggd2FzIGJlIHdyaXR0ZW4gaW4gMTINCj4g
PiBieXRlcw0KPiA+ICvCoMKgwqDCoCAqIHN0YXJ0aW5nIGZyb20gMHhhMjIwMDAwMCBieSBSVEkg
V2F0Y2hkb2cgRmlybXdhcmUuDQo+ID4gK8KgwqDCoMKgICoNCj4gPiArwqDCoMKgwqAgKiBSZXNl
cnZlZCBtZW1vcnkgc2hvdWxkIGJlIGRlZmluZWQgYXMgZm9sbG93czoNCj4gPiArwqDCoMKgwqAg
KiByZXNlcnZlZC1tZW1vcnkgew0KPiA+ICvCoMKgwqDCoCAqwqDCoMKgwqAgd2R0X3Jlc2V0X21l
bW9yeV9yZWdpb246IHdkdC1tZW1vcnlAYTIyMDAwMDAgew0KPiA+ICvCoMKgwqDCoCAqwqDCoMKg
wqDCoMKgwqDCoCByZWcgPSA8MHgwMCAweGEyMjAwMDAwIDB4MDAgMHgxMDAwPjsNCj4gPiArwqDC
oMKgwqAgKsKgwqDCoMKgwqDCoMKgwqAgbm8tbWFwOw0KPiA+ICvCoMKgwqDCoCAqwqDCoMKgwqAg
fTsNCj4gPiArwqDCoMKgwqAgKiB9DQo+ID4gK8KgwqDCoMKgICovDQo+ID4gK8KgwqDCoCB3YXRj
aGRvZ0A0MDYxMDAwMCB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAidGksajct
cnRpLXdkdCI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDQwNjEwMDAwIDB4MTAwPjsN
Cj4gPiArwqDCoMKgwqDCoMKgwqAgY2xvY2tzID0gPCZrM19jbGtzIDEzNSAxPjsNCj4gPiArwqDC
oMKgwqDCoMKgwqAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDEzNSBUSV9TQ0lfUERfRVhDTFVT
SVZFPjsNCj4gPiArwqDCoMKgwqDCoMKgwqAgYXNzaWduZWQtY2xvY2tzID0gPCZrM19jbGtzIDEz
NSAwPjsNCj4gPiArwqDCoMKgwqDCoMKgwqAgYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmazNf
Y2xrcyAxMzUgND47DQo+ID4gK8KgwqDCoMKgwqDCoMKgIG1lbW9yeS1yZWdpb24gPSA8JndkdF9y
ZXNldF9tZW1vcnlfcmVnaW9uPjsNCj4gPiArwqDCoMKgIH07DQo+IA0KDQo=
