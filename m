Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5693753269
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjGNHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbjGNHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:00:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA87C2719;
        Fri, 14 Jul 2023 00:00:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPBo8UtjS70tACsur15cXib5aWmIyx5uVNh+WLW3fTL/aJOo9HUhHepSyhYkSgEOHJsz1Qd8FfSHSg2+hOxEtUB8yaomyipD/6GdbIUdwbSeA73O+Q7JjHqiZQSlpgwHQyLEy9DrYybJvcrG5eIbmsRnLc9kKGiIS9Fflgjt7tEYGzawQhtTfi/oQHLnoBuCDNPbIyIixmKQfgjwVKRHV2zJYm6veeP5K4zWREwjSUbL5jQgCMG0uxOhw5c22iVbnnhC094es4PLDtdGRfti/A/nmdJ6uttutpSoB9WiJwg76G/CKT64rxAThRX+5Rg6ZpP2ufAH4VBOOJCyYSTLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoXTnf3ubQCz2RfeX1LXpNMKWrwNo8mM22y/fM+kBss=;
 b=MtwshNOu6+nB38cqG+ouJlBpJB/pnQRsO7cgYT7aKkj+nkKM9qSp4gxRpCUVUOEnmeMZVwYxpwwxAw1atgNZ8w2ytRbXWvoQhb9BtOd/66WM65+fZ9S4BgZCOQOz9Rf3uyfwR2ogqZWjzmFRqQ9neEA6hRg57qptpFc+wub1dLIv85al8Vk7Ml0GbB3qygKMP7crexn/iftJdEuiExfl/eDrV2vLoSMcIKjugGP3J8+1ScBHzsbbWbVSnBk5K41DAzQbvPwugbGLBfd+qzA53pSVZ5eVzuZ7fb2mFm0rRK+uQWVfoM8R11qYMFC9VO/6ZsTVI7O/eNYFfEmi//kykA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoXTnf3ubQCz2RfeX1LXpNMKWrwNo8mM22y/fM+kBss=;
 b=AUD99zFHesxrjmVWky9NLXdvXfFZgQYBP7g2LuiaeeiM1qgipW9Sp+DpmjFQUdux6c+3SASKpPeKhWSEdgO0JGgfyeqZJp+IBSTnwBTT3X7f82DjfaYzFY1yzCxIXBuAHmNRDVQqwaDEMmadZptFdWgNdXrWCeYjYbsJ2uoiylUz6ExTeeiQOlRQgtzUHiQDpSdfVauvp177LBJzfnpPnnyQlpFab58DS1D63ex9qvRHPieCaxsaIQwaKb9wNOV0KiEyWeFKI+caChiQ/kL1HTMoh/d5mTqHhL/LIIgAEkzdI3nv8driD45kxHmtDfojJJ43Us/CzJn4NHDUKxfUKg==
Received: from FR0P281CA0202.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:ad::17)
 by AM7PR10MB3857.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Fri, 14 Jul
 2023 07:00:06 +0000
Received: from VE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:ad:cafe::82) by FR0P281CA0202.outlook.office365.com
 (2603:10a6:d10:ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.15 via Frontend
 Transport; Fri, 14 Jul 2023 07:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT091.mail.protection.outlook.com (10.152.3.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.14 via Frontend Transport; Fri, 14 Jul 2023 07:00:05 +0000
Received: from CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 14 Jul 2023 09:00:04 +0200
Received: from CNPEK01M03MSX.ad011.siemens.net (139.24.237.220) by
 CNPEK01M05MSX.ad011.siemens.net (139.24.237.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 15:00:02 +0800
Received: from CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) by
 CNPEK01M03MSX.ad011.siemens.net ([139.24.237.220]) with mapi id
 15.01.2507.027; Fri, 14 Jul 2023 15:00:02 +0800
From:   "Li, Hua Qian" <HuaQian.Li@siemens.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: Re: [PATCH v3 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Topic: [PATCH v3 0/3] Add support for WDIOF_CARDRESET on TI AM65x
Thread-Index: AQHZtW+mZ/ETSk0+rU2NBd5Xb9D67q+3a/EAgADkrQA=
Date:   Fri, 14 Jul 2023 07:00:02 +0000
Message-ID: <840f5d90fdb794e4d07db3f6fb71a14e144e91b7.camel@siemens.com>
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
         <3eec9b79-0505-0b15-f7a0-fcc7f4031c85@roeck-us.net>
In-Reply-To: <3eec9b79-0505-0b15-f7a0-fcc7f4031c85@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.24.108.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B529882224570447BB7F69C16EC1DF09@siemens.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT091:EE_|AM7PR10MB3857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1688e629-51e2-489b-4dff-08db8437f42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0hoksouxtMTJ6JCnKlUyIrG+EmISMvNfJnX30VTQl25/oUThUKi3i1mXt7uE7sz+9ZWQa1ysLlqvmrS22W3iCJwIUKWGegGCdPci0x8oVngme3T3jkMugLuja6+UcwYKuX7JOP7qvum8pkEs5Ml1WE9FphTiFzaSpIL6JoTKkPu614pQK7ZSbogQacuXlurHaEAGeFlcCKpOX3xzzFlqTDxs3U6wqjOFG/LTw18Ed5/8L5/TBg75n7XD7KxkboxyCzXA/5JVkQ0CTOgV9JdtUA8Pg4WahBOB9WgafKZ3xCmuHzUXUgRqoBc0bk6IS9K0Tv00vsDrY+wxsu/jFxNZRvlBYrS13nUTdooOm/1ceWN+puPe5CtiwlQkpX0l15rNx47TNRrHwuNS1Pf7jI8rzRD0f8kHCsfEJZjJsf7i0HDNiD/YxRiI9om4ZZlXN3gDRUG7K+9acRQnzO3o3XNViCjXnTO7k2yhjpcK6f1pUaThexjSCMidcdrOd5gggmnhtFKLi6VjlEfazEPMu3HAVqlvh9bK1qwN2Zju1XLl9aV25H7UyQcJawnmZiivsnKC60d+fNIogwEDEisnh1nCQHHObPjS3+6JBcXOIIRq67CyLB4usU+rsSE78Az/U4CRTqXXJnX7WTfxHWLByuUdHcW8KnfGCo/Hs7euTFiJLUt73Mz6AfzTmKKcYVfz9Yu6S8QsYeZJhN9GCZdqMdD25csWKDOpeHLb+gzm49LFvDIurMR/KWdq3BNdc87LXc18pqlN1XIlpX0FR7AcMwhyg9nxNZkpK7FhTvPkuyM/EQ=
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36840700001)(40470700004)(46966006)(26005)(82310400005)(41300700001)(4326008)(47076005)(316002)(8676002)(82740400003)(36756003)(5660300002)(8936002)(82960400001)(7416002)(40460700003)(81166007)(40480700001)(356005)(478600001)(966005)(2906002)(956004)(110136005)(2616005)(36860700001)(86362001)(53546011)(186003)(45080400002)(336012)(54906003)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 07:00:05.7331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1688e629-51e2-489b-4dff-08db8437f42e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT091.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDEwOjIxIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiA3LzEzLzIzIDAyOjUxLCBodWFxaWFuLmxpQHNpZW1lbnMuY29twqB3cm90ZToNCj4gPiBG
cm9tOiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4NCj4gPiANCj4gPiBUaGUg
d2F0Y2hkb2cgaGFyZHdhcmUgb2YgVEkgQU02NVggcGxhdGZvcm0gZG9lcyBub3Qgc3VwcG9ydA0K
PiA+IFdESU9GX0NBUkRSRVNFVCBmZWF0dXJlLCBhZGQgYSByZXNlcnZlZCBtZW1vcnkgdG8gc2F2
ZSB0aGUgd2F0Y2hkb2cNCj4gPiByZXNldCBjYXVzZSwgdG8ga25vdyBpZiB0aGUgYm9hcmQgcmVi
b290IGlzIGR1ZSB0byBhIHdhdGNoZG9nDQo+ID4gcmVzZXQuDQo+ID4gDQo+IA0KPiBPbmUgdGhp
bmcgSSBrZWVwIHdvbmRlcmluZyBhYm91dDogV2hhdCBwcmV2ZW50cyB0aGUgTGludXgga2VybmVs
IGZyb20NCj4gdHJlYXRpbmcgdGhlIHNwZWNpYWwgbWVtb3J5IGFyZWEgbGlrZSBub3JtYWwgbWVt
b3J5ID8gSSB3b3VsZCBoYXZlDQo+IGV4cGVjdGVkDQo+IHNvbWUgdXNhZ2Ugbm90ZSwgc3VjaCBh
cyB0aGF0IHRoZSBtZW1vcnkgYXJlYSBtdXN0IGJlIHJlcG9ydGVkIGFzDQo+IHJlc2VydmVkDQo+
IHRvIHRoZSBrZXJuZWwsIGJ1dCBJIGRvbid0IHNlZSBhbnl0aGluZyBsaWtlIHRoYXQuDQo+IA0K
PiBHdWVudGVyDQoNCkNvdWxkIHlvdSBoZWxwIHRvIHN1Z2dlc3QgaG93IHRvIGhhbmRsZSBpdD8g
DQoNCkkgYW0gbm90IHN1cmUgd2hlcmUgaXMgYSBnb29kIHBsYWNlIHRvIHdyaXRlIHRoZSB1c2Fn
ZSBub3RlLiBJIGFtDQp0aGlua2luZyB0byBhZGQgaXQgaW4gdjQgdG8gRFQgYmluZGluZy4NCg0K
QmVzdCByZWdhcmRzLA0KTGkgSHVhIFFpYW4NCj4gDQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAt
IEFkZCBtZW1vcnktcmVnaW9uIGJhY2sgZm9yIHRoZSByZXNlcnZlZCBtZW1vcnksIGFuZCByZW1v
dmUNCj4gPiByZXNlcnZlZA0KPiA+IMKgwqAgbWVtb3J5IGZyb20gdGhlIHdhdGNoZG9nIElPIGFk
ZHJlc3Mgc3BhY2UuDQo+ID4gLSBBZGQgY2hhbmdlbG9nLg0KPiA+IC0gTGluayB0byB2MjoNCj4g
PiDCoMKgDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2F0Y2hkb2cvMjAyMzA3
MTEwOTE3MTMuMTExMzAxMC0xLWh1YXFpYW4ubGlAc2llbWVucy5jb20NCj4gPiANCj4gPiBDaGFu
Z2VzIGluIHYyOg0KPiA+IC0gUmVtb3ZlIG1lbW9yeS1yZWdpb24gYW5kIG1lbW9yeS1zaXplIHBy
b3BlcnRpZXMsIGFuZCBiaW5kIHRoZQ0KPiA+IHJlc2VydmVkDQo+ID4gwqDCoCBtZW1vcnkgdG8g
d2F0Y2hkb2cgSU8gYWRkcmVzcyBzcGFjZS4NCj4gPiAtIFJlbW92ZSB0aGUgdW5uZWNlc3Nhcnkg
cnRpX3dkdF9pb2N0bC4NCj4gPiAtIEZpeCB0aGUgbWFpbCBsaXN0DQo+ID4gLSBMaW5rIHRvIHYx
Og0KPiA+IMKgwqANCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMzEzN2Q4N2U1NmVm
NzViYTBiOGE5MjNkNDA3YjJmZWNhY2U2Y2NiZC5jYW1lbEBzaWVtZW5zLmNvbS8NCj4gPiDCoMKg
IHYxIGhhZCBhIHdyb25nIG1haWwgbGlzdCBhdCB0aGUgYmVnaW5uaW5nLCBhbmQgdGhlIG1haWwg
dGhyZWFkDQo+ID4gd2FzDQo+ID4gwqDCoCBtZXNzZWQgdXAuDQo+ID4gDQo+ID4gTGkgSHVhIFFp
YW4gKDMpOg0KPiA+IMKgwqAgZHQtYmluZGluZ3M6IHdhdGNoZG9nOiB0aSxydGktd2R0OiBBZGQg
c3VwcG9ydCBmb3INCj4gPiBXRElPRl9DQVJEUkVTRVQNCj4gPiDCoMKgIGFybTY0OiBkdHM6IHRp
OiBBZGQgcmVzZXJ2ZWQgbWVtb3J5IGZvciB3YXRjaGRvZw0KPiA+IMKgwqAgd2F0Y2hkb2c6cml0
X3dkdDogQWRkIHN1cHBvcnQgZm9yIFdESU9GX0NBUkRSRVNFVA0KPiA+IA0KPiA+IMKgIC4uLi9i
aW5kaW5ncy93YXRjaGRvZy90aSxydGktd2R0LnlhbWzCoMKgwqDCoMKgwqDCoMKgIHwgMTIgKysr
KysNCj4gPiDCoCAuLi4vYm9vdC9kdHMvdGkvazMtYW02NS1pb3QyMDUwLWNvbW1vbi5kdHNpwqDC
oCB8IDEwICsrKysNCj4gPiDCoCBkcml2ZXJzL3dhdGNoZG9nL3J0aV93ZHQuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNTENCj4gPiArKysrKysrKysrKysrKysrKysr
DQo+ID4gwqAgMyBmaWxlcyBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspDQo+ID4gDQo+IA0KDQo=
