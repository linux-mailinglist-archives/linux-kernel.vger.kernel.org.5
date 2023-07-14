Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922367534D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235399AbjGNIQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjGNIPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:15:53 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2122.outbound.protection.outlook.com [40.107.241.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E01F272B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqWRD0/WB6TlHXBfDG4MVVSb380KNt+6EO11FQ4YlSHSCO/XPVy2yI3md8T9DZMdTxbdDuq4svoOiYLVuGi1fR4vGES4tAp1PJqcFzOemSS7WqOBsmqQrv3LU+I6HhsUjiwW7jfNKQ191Id5SiViSVUcXzFTTjkaBcr/YYyI2Ed8/IaAAE/3Lo3dItJn+/KHvmMlGcH4u8dZAcshwzgsB8ss63ZOPCbr55CY6IpjiAt/o6DAalz7nJuYppvB+QyAKbSNZgioTMstTYO0JtLARh+ZdAxFFRecgdvw/97g4RDGv+F6FGivyqq885ZWdb8P7lq5UHNGMdU0C7jJQZTRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+9t/7Rt5DGGYLeDfFLW3EODeI6Yq93vxQp7buwv+Fg=;
 b=lefECVYSmeXwiMrpg4G2s2DsQPalhQC+C1TTuqyOTIZSviGcRaZ2ayD8ke95zcVSZEvb6TdIeE9oG1NoRp8nv2T3RPB+yHho9mqIszZbnKR85gOgxk+Or5Gufw1CNcC+FgUQkLobdfiG6xKbMuhJMl8cPYr8NYFfdE5cP4BvC7CXN2XbdV3cv2oYTw7LHoAPe0saSvvcsWVW8Z5csKSS+IMFpe3pyD+4xx5ly3V1piGa+AJTK8qzzCXgmiHjIU0MRjvwHkiME+nPxLspM/vptwlupEwL8EgxFZikMJZZgxJXjaLi7VsYkx+NsZuRHai0coq4PMaidunTAdmny8sMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+9t/7Rt5DGGYLeDfFLW3EODeI6Yq93vxQp7buwv+Fg=;
 b=hLBzoPiU0YW7Sho6El73W7Wouvk+dmIITkaz2SXfEcrQqTg5hNuZ2h6n4jpcGT5jCY1CgGxaNddpgFKQvr7AoN8sB8c1U3gnQQez/9OKkS0Kf6gh6xtCaHoOaxPEfPynbbD77U4Rie8+zIDnOGcarLH/ITOD56WCXdPvqbXPYb8=
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com (2603:10a6:20b:1da::16)
 by PAXPR06MB7789.eurprd06.prod.outlook.com (2603:10a6:102:de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 08:15:24 +0000
Received: from AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::700:c84f:2ba6:606b]) by AM8PR06MB7137.eurprd06.prod.outlook.com
 ([fe80::700:c84f:2ba6:606b%6]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 08:15:24 +0000
From:   SHUKLA Mamta Ramendra <mamta.shukla@leica-geosystems.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Topic: [PATCH v2] mtd: micron-st: enable lock/unlock for mt25qu512a
Thread-Index: AQHZr1hWPkDpy3UlU0qGBS67M1mV0q+3GdCAgAHeK4A=
Date:   Fri, 14 Jul 2023 08:15:24 +0000
Message-ID: <a8271289-0611-4e37-cf37-0be19a85656b@leica-geosystems.com>
References: <20230705154942.3936658-1-mamta.shukla@leica-geosystems.com>
 <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
In-Reply-To: <19800e51-a871-be9f-9eb5-5829237e2613@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR06MB7137:EE_|PAXPR06MB7789:EE_
x-ms-office365-filtering-correlation-id: 74807b11-4373-4b9c-f422-08db8442797f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZtTcxEc8U/1KWXhEClJqGLOQwniNzTfqJNFrcE3THvtuEczN41SizgkJrfsaepUgUDyzk4Isf4nBQYo3e9qFuszMLr9UbOyr1h7NLnLRhBzoZoQ9ZUaT+X2GZGzHzYxOcwjqUmmEHDqqF4uV8jTN1wRGWGq/MJLrjz1dwjLJ/jKyHzxQS95v4/mpIzQgJJDTZBSkBCPekY/hv1xjTeDDGFIw0XQBKuc4Zmy0TJi5xX699tsL7N9IytPYgLR1QgCVUZb7Uv9shn/4/EiSF+ThFQDFSfVNhepBDSuA2cQySR3sHnRaXbvTlR1j16IAp20uL2YGWb2Q5yY8jOuw+U18uF+9GEg0QsQX2tfSHcskc+OsZ/upti8T5Jg0t5zvx5oXmNozVyLm2vc81emo6wjHJICpBNq8k2kLNMeAynecuJGHEco/HLJg1ICnZ0Gwx9XLlhmJRLcp91No3s9vcM7KlRAwwfaAbHk7Z2VpMmf23gl/3jyklEQL+QY4uLdYqU3Nh4Ebdqb/hLogFxH4vvVYJt3dvELra87whPiRM9Sa+tt/uwjG+DAZump7VYhZm45dKwVz5BszcUsopj1fuCb7v/1ZbdRrF5Sl3/OWqZx94z1vo3uvHkMwXr6QVDLxGb/UkkIw4tNL3N0aRV9vozQDI5/E1AaSivb/1xQamnhC/skReViFVSnR5RIYVm7E3Kk3opgiXN2k2j3kvPf5xZQh8xlrAQIKI1z5lJR/5MEvU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7137.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199021)(86362001)(31696002)(36756003)(122000001)(38070700005)(38100700002)(45080400002)(478600001)(2906002)(6486002)(71200400001)(110136005)(107886003)(6506007)(53546011)(26005)(6512007)(966005)(8676002)(8936002)(316002)(41300700001)(66946007)(66556008)(76116006)(91956017)(5660300002)(4326008)(31686004)(66476007)(66446008)(64756008)(2616005)(186003)(83380400001)(138113003)(45980500001)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUNwSi9yZFoxOEw0ZktqYXFKOWo0Wk1GRDdET1RRL2Q0UFk2ajNKbE9HK2l5?=
 =?utf-8?B?YkI1alZXNWx0WkdHS0ZwM0ltUHFmYVZhTHJPR3JMQXFTYjZpdFAzMFNQaXJV?=
 =?utf-8?B?NXVDUldPY09TMTk5TTZ1elZBTTNhaE4wM0tBeFpzQnhKNGw0WTkyN2VOSkc2?=
 =?utf-8?B?eE1BR3YrSDNDaDRkWXo1cFY2ZEdNTkh5NVRXL2pleG9BTTVLUzVDTzBJMk5L?=
 =?utf-8?B?cnpic2d2bGdrTWhMaW1hNVFjVGp2K2d4RTFaWXJHeXRGZjgzVTRXd1JuWnEr?=
 =?utf-8?B?NUIza0gyaXEwcEpGSUppOVZvTGtQRGlsaGo4NjA0czl3eG5mQzJ2WndEUlNT?=
 =?utf-8?B?a3I0V3dQaWVzSDBYSVJuTTdCOFdZSG15YklML3VnRmNwaERoRUQyWk15ZFhD?=
 =?utf-8?B?bmRDMVlLVHY3aUVpMnJQQTcrWDFmb0Y2UFkyMFpPcFQ4SkQ4bW5hWEk5L05H?=
 =?utf-8?B?emVtbUowTFN1eHlOUnhjU29YVVpJa2owcUFsSWkzclc1WmdnYk5RTGtYTWRN?=
 =?utf-8?B?KzNYbWpwUFZIKy9mZlRIeWlrdUNEaXY0RnBOMjFHMEZYWFJydHM0YUNoMWlR?=
 =?utf-8?B?UFNkelRIU3JYUmlBYWxJeFhMZk9Oa0l5SVA2Q3NWNVdhVXRzYVVYbm10b2RL?=
 =?utf-8?B?Zzk3Q1FqVHJLTlRoQVFiajlUNmJRVVY5V2FLdGpPV2R2Z0hIOWxiOWxGdnYr?=
 =?utf-8?B?cC9pL1FVVWRFUGJ0OWpFckEvNmU2ekZaTm1SamdUNTB6aENNdVhQcGFtOGxR?=
 =?utf-8?B?NndDUlFnZE1tSFcrQXQvdzUrRFNuZVBrWnlUQ04zOS94dHpIQlJLQy8vaTVY?=
 =?utf-8?B?MzhZeUdCVGZITEtFeWs3Q0djQkJIZmJoTzl0N09LdXBMM0MxR00yQk5GTFpQ?=
 =?utf-8?B?aEhxZGUzdWFPeldGOXpxMTFsOW5saXlwTk5tWG16ZzNyL3ArbUU0bVkralhY?=
 =?utf-8?B?ZVNldy8vdHBjYVd5cGlCNVh5N1BwRlE3eWh6RmVZSlVVL3QxTzEvQVVwT1dY?=
 =?utf-8?B?WUlwMUllQ3lsdWs1ejg3aHorTG5zSlpSL1lqcUh6NDc5bE1JdXZCVzZ5K0lu?=
 =?utf-8?B?bG5CTytPS04ycVU2djlMTkcyazd3K0hTK2tQZFhLbEI4S0JkNWFmOG1TRGRa?=
 =?utf-8?B?Mk0rbU1KRlBsMDVpN0gyTGFXUzgzY2lPY2trSFB2NDZEQ3lpTjB1dHVtUG50?=
 =?utf-8?B?Umt6YU90VUZVS0xsNmw2N1FndmdDenV0RFgvajhhUnN4ZnBnMjRtejZHSTdZ?=
 =?utf-8?B?WmF2ekhFajZlcHNFZ3ZnSW1nMElUbGMycW1lY0Y2cU4zemVEQ3hodkQwUFlu?=
 =?utf-8?B?RStQNGFmU0kzeEtBQ3ZHVEZRQkt6UHF2T2J3SFlTS1l6VUw0VTc5RTkwcGtN?=
 =?utf-8?B?eUxCOW1sdndpSGQwQkc4VmFCeVREazZDTFBYeXhZaTRLaXFrOWlrN2xZU1Fv?=
 =?utf-8?B?bXBObHlLdmZWWHV2cE8wZVJkUkkzNEZkZ0xBNXpnOEF4YzJzdEtCSXlDNmFx?=
 =?utf-8?B?L0JoeGZoRDZQbmR0OXppMmFRVCsvVXJPMUFJRVFDSk02VVhVdmhrMHRRMzhw?=
 =?utf-8?B?L2ZlVmt1OTA3VU1iUmcxWTh0WDdwRkNQaU9aeHFPZ3ljVkxzR3NCSnIxTlJ6?=
 =?utf-8?B?OXVjZXdKMVl0T3Z2T0l0bkp6aE5jQTNTQ005YXBWc0ZRcWtYTHpGOU4xZTdk?=
 =?utf-8?B?aCtBenVyQVBnbS8zNHE3ekpDS2twNkxQVC9UY0VuWDdRRzhzWVlDVzlyVkxF?=
 =?utf-8?B?L3dKclByRmp0NnNmN0xxSmpuRThBQytJM2h4TTVwdGVzUnpsV0xLMEovZFhY?=
 =?utf-8?B?YklLRCtER1F1eGtNTmg2Vk9aK2ROeS83cHFUSndwMDN3Yy9kaTVERFlqeTlZ?=
 =?utf-8?B?bG8xVGNBV09HTWRycFpkSkNVNlh3Q3BTNzB5ZWNuUWJpRnNkQnZsNTlMUjUz?=
 =?utf-8?B?enY5WmVEc0laOG42NWRkcEJUZEx6Yjd1WXY2NnlWV2pZSXRyR0JqandvSnRt?=
 =?utf-8?B?TlRLS082bERzVi9sZEIzUFE4VG5QcHJWcUFNNFNVWUZtck1FL0VOanFtYkFZ?=
 =?utf-8?B?U1JDM0MvdTd3aUtFYmwyMTRsdkJtL09DbFVqbTZqbUtvR2YyQndnYTlxUlFL?=
 =?utf-8?B?MkV3K3MrbkhFcmZuY3NwLzB5YnQrWmh0M0lmNHVFWTJEdEhnU2toYjJiNW9l?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3534570E81D6BB4183455DFF5E3DACAE@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7137.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74807b11-4373-4b9c-f422-08db8442797f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 08:15:24.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3076ReAuGEEWHl0QFRa4vuwFlDvYZJGyWlqOEUXvqrU7zZKrK7n2ljdT8uz8LTLQ4oy1lGuzechcQ/PELuEQ7AQ2VOEj2X9zNA+EcktgwgMIIoG0kuaV9iUTFVWdXaue
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7789
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCk9uIDEzLjA3LjIzIDA1OjQzLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0K
PiBUaGlzIGVtYWlsIGlzIG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2Uu
IFBsZWFzZSBiZSBjYXJlZnVsIHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1l
bnRzLCBvciByZXBseWluZyB0byB0aGlzIGVtYWlsLg0KPiANCj4gDQo+IE9uIDA1LjA3LjIwMjMg
MTg6NDksIE1hbXRhIFNodWtsYSB3cm90ZToNCj4+IG10MjVxdTUxMmFbMV0gc3VwcG9ydHMgbG9j
a2luZy91bmxvY2tpbmcgdGhyb3VnaCBCUCBiaXRzIGluIFNSLg0KPj4NCj4+IFRlc3RlZCB1c2lu
ZyBtdGQtdXRpbHMtIGZsYXNoX2xvY2svZmxhc2hfdW5sb2NrIGZvciBNVDI1UVU1MTJBQkI4RTEy
Lg0KPj4NCj4+IExpbms6IGh0dHBzOi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLS9tZWRpYS9jbGll
bnQvZ2xvYmFsL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLXNoZWV0L25vci1mbGFzaC9zZXJpYWwt
bm9yL210MjVxL2RpZS1yZXYtYi9tdDI1cV9xbGt0X3VfNTEyX2FiYl8wLnBkZj9yZXY9YjI1OWFh
ZGMzYmVhNDllYTgyMTBhNDFjOWFkNTgyMTENCj4+IFNpZ25lZC1vZmYtYnk6IE1hbXRhIFNodWts
YSA8bWFtdGEuc2h1a2xhQGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPj4gLS0tDQo+PiAgIENoYW5n
ZXMgaW4gdjI6DQo+PiAgIC0gYWRkIExpbmsgdGFnDQo+PiAgIC0gZml4IGNoaXAgcGFydCBudW1i
ZXIgbXQyNXFsNTEyYS0+bXQyNXF1NTEyYQ0KPj4NCj4+ICAgZHJpdmVycy9tdGQvc3BpLW5vci9t
aWNyb24tc3QuYyB8IDIgKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9taWNyb24tc3QuYw0KPj4gaW5kZXggNGI5MTk3NTZhMjA1Li4wOGU5
NDM0MGViYWEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5j
DQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21pY3Jvbi1zdC5jDQo+PiBAQCAtMjI5LDYg
KzIyOSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzdF9ub3JfcGFydHNbXSA9
IHsNCj4+ICAgICAgICAgICAgICAgIE1GUl9GTEFHUyhVU0VfRlNSKQ0KPj4gICAgICAgIH0sDQo+
PiAgICAgICAgeyAibXQyNXF1NTEyYSIsICBJTkZPNigweDIwYmIyMCwgMHgxMDQ0MDAsIDY0ICog
MTAyNCwgMTAyNCkNCj4+ICsgICAgICAgICAgICAgRkxBR1MoU1BJX05PUl9IQVNfTE9DSyB8IFNQ
SV9OT1JfSEFTX1RCIHwgU1BJX05PUl80QklUX0JQIHwNCj4+ICsgICAgICAgICAgICAgICAgICAg
U1BJX05PUl9CUDNfU1JfQklUNikNCj4+ICAgICAgICAgICAgICAgIE5PX1NGRFBfRkxBR1MoU0VD
VF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQpDQo+PiAgICAgICAg
ICAgICAgICBGSVhVUF9GTEFHUyhTUElfTk9SXzRCX09QQ09ERVMpDQo+PiAgICAgICAgICAgICAg
ICBNRlJfRkxBR1MoVVNFX0ZTUikNCj4gDQo+IENhbiB5b3UgdHJ5IHRoZSBmb2xsb3dpbmcgaW5z
dGVhZD8gV2UgdHJ5IHRvIHVzZSBTRkRQIHBhcnNpbmcgd2hlbmV2ZXINCj4gcG9zc2libGUuDQo+
ICAgICAgICAgIHsgIm10MjVxdTUxMmEiLCAgSU5GTzYoMHgyMGJiMjAsIDB4MTA0NDAwLCAwLCAw
KQ0KPiAgICAgICAgICAgICAgICAgIEZMQUdTKFNQSV9OT1JfSEFTX0xPQ0sgfCBTUElfTk9SX0hB
U19UQiB8IFNQSV9OT1JfNEJJVF9CUCB8DQo+ICAgICAgICAgICAgICAgICAgU1BJX05PUl9CUDNf
U1JfQklUNikNCj4gICAgICAgICAgICAgICAgICBQQVJTRV9TRkRQDQo+ICAgICAgICAgICAgICAg
ICAgTUZSX0ZMQUdTKFVTRV9GU1IpDQoNCg0KSSB0ZXN0ZWQgd2l0aCBTRkRQIFBhcnNpbmcgRmxh
Zy4gSXQgd29ya3MgZmluZS4NCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpbICAyMTQuNzI2
MDkwXSBBQ1BJOiBIb3N0LWRpcmVjdGVkIER5bmFtaWMgQUNQSSBUYWJsZSBMb2FkOg0KWyAgMjE0
LjczMTQ4Ml0gQUNQSTogU1NEVCAweEZGRkY4OTI4ODJEODk4MDAgMDAwMEVDICh2MDIgQUxBU0tB
IE1UMjVRVSANCjAwMDAxMDAwIElOVEwgMjAxOTA1MDkpDQpbICAyMTQuNzY2MDgyXSBzcGktbm9y
IHNwaS1QUlAwMDAxOjAwOiBtdDI1cXU1MTJhICg2NTUzNiBLYnl0ZXMpDQoNCg0KY2F0IC9zeXMv
YnVzL3NwaS9kZXZpY2VzL3NwaS1QUlAwMDAxOjAwL3NwaS1ub3IvamVkZWNfaWQNCjIwYmIyMDEw
NDQwMA0KDQpjYXQgL3N5cy9idXMvc3BpL2RldmljZXMvc3BpLVBSUDAwMDE6MDAvc3BpLW5vci9t
YW51ZmFjdHVyZXINCnN0DQoNCmNhdCAvc3lzL2J1cy9zcGkvZGV2aWNlcy9zcGktUFJQMDAwMTow
MC9zcGktbm9yL3BhcnRuYW1lDQptdDI1cXU1MTJhDQoNCnh4ZCAtcCAgL3N5cy9idXMvc3BpL2Rl
dmljZXMvc3BpLVBSUDAwMDE6MDAvc3BpLW5vci9zZmRwDQo1MzQ2NDQ1MDA2MDEwMWZmMDAwNjAx
MTAzMDAwMDBmZjg0MDAwMTAyODAwMDAwZmZmZmZmZmZmZmZmZmYNCmZmZmZmZmZmZmZmZmZmZmZm
ZmZmZmZmZmZmZmZmZmZmZmZmZmU1MjBmYmZmZmZmZmZmMWYyOWViMjc2Yg0KMjczYjI3YmJmZmZm
ZmZmZmZmZmYyN2JiZmZmZjI5ZWIwYzIwMTBkODBmNTIwMDAwMjQ0YTk5MDA4YjhlDQowM2UxYWMw
MTI3Mzg3YTc1N2E3NWZiYmRkNTVjNGEwZjgyZmY4MWJkM2QzNmZmZmZmZmZmZmZmZmZmZmYNCmZm
ZmZmZmZmZmZmZmZmZmZmZmU3ZmZmZjIxZGNmZmZmDQoNCm1kNXN1bSAgL3N5cy9idXMvc3BpL2Rl
dmljZXMvc3BpLVBSUDAwMDE6MDAvc3BpLW5vci9zZmRwDQo2MTBlZmJhMTY0N2UwMGFjNmRiMThi
ZWIxMWU4NGMwNCANCi9zeXMvYnVzL3NwaS9kZXZpY2VzL3NwaS1QUlAwMDAxOjAwL3NwaS1ub3Iv
c2ZkcA0KDQpkZCBpZj0vZGV2L3VyYW5kb20gb2Y9L3RtcC9xc3BpX3dyaXRlICBicz0xTSBjb3Vu
dD0xDQoxKzAgcmVjb3JkcyBpbg0KMSswIHJlY29yZHMgb3V0DQoxMDQ4NTc2IGJ5dGVzICgxLjAg
TUIsIDEuMCBNaUIpIGNvcGllZCwgMC4wMjIxMzkxIHMsIDQ3LjQgTUIvcw0KDQptdGRfZGVidWcg
d3JpdGUgL2Rldi9tdGQwIDAgMTA0ODU3NiAvdG1wL3FzcGlfd3JpdGUNCkNvcGllZCAxMDQ4NTc2
IGJ5dGVzIGZyb20gL3RtcC9xc3BpX3dyaXRlIHRvIGFkZHJlc3MgMHgwMDAwMDAwMCBpbiBmbGFz
aA0KDQptdGRfZGVidWcgZXJhc2UgL2Rldi9tdGQwIDAgMTA0ODU3Ng0KRXJhc2VkIDEwNDg1NzYg
Ynl0ZXMgZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2gNCg0KbXRkX2RlYnVnIHJlYWQg
L2Rldi9tdGQwIDAgMTA0ODU3NiAvdG1wL3FzcGlfcmVhZA0KQ29waWVkIDEwNDg1NzYgYnl0ZXMg
ZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2ggdG8gL3RtcC9xc3BpX3JlYWQNCg0KaGV4
ZHVtcCAvdG1wL3FzcGlfcmVhZA0KMDAwMDAwMCBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
ZiBmZmZmIGZmZmYNCioNCjAxMDAwMDANCg0KbXRkX2RlYnVnIHdyaXRlIC9kZXYvbXRkMCAwIDEw
NDg1NzYgL3RtcC9xc3BpX3dyaXRlDQpDb3BpZWQgMTA0ODU3NiBieXRlcyBmcm9tIC90bXAvcXNw
aV93cml0ZSB0byBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2gNCg0KbXRkX2RlYnVnIHJlYWQg
L2Rldi9tdGQwIDAgMTA0ODU3NiAvdG1wL3FzcGlfcmVhZA0KQ29waWVkIDEwNDg1NzYgYnl0ZXMg
ZnJvbSBhZGRyZXNzIDB4MDAwMDAwMDAgaW4gZmxhc2ggdG8gL3RtcC9xc3BpX3JlYWQNCg0Kc2hh
MXN1bSAvdG1wL3FzcGlfd3JpdGUgIC90bXAvcXNwaV9yZWFkDQo0ZmU0ZTcxYjExZjQ0ZTk2NzJi
ZDQ5ZTJlMzJjMGZkOTRkYTRmZWI2ICAvdG1wL3FzcGlfd3JpdGUNCjRmZTRlNzFiMTFmNDRlOTY3
MmJkNDllMmUzMmMwZmQ5NGRhNGZlYjYgIC90bXAvcXNwaV9yZWFkDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCg0KU2hhbGwgSSB3cml0ZSBhIG5ldyBjb21taXQgZm9yIFBBUlNFX1NGRFAg
RmxhZyBvciB1cGRhdGUgdGhpcyBjb21taXQgYXMtDQoiTW9kaWZ5IG10MjVxdTUxMmEgRmxhZ3Mi
ID8NCg0KPiANCj4gWW91IHRoZW4gaGF2ZSB0byBkdW1wIHRoZSBTRkRQIHRhYmxlcyBhbmQgZG8g
YSBzYW5pdHkgY2hlY2sgdG8gbWFrZSBzdXJlDQo+IGV2ZXJ5dGhpbmcncyBmaW5lIGFmdGVyIHlv
dXIgY2hhbmdlcy4gWW91IGNhbiBhbiBleGFtcGxlIG9uIGhvdyB0byBkbw0KPiB0aGF0IG9uIHRo
ZSBjb21taXQgbWVzc2FnZSBmcm9tDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW10
ZC84YjdkMjQyMC0yNmI2LTQwNWItOGVmNy03NWUwYTAyMDE0MDJAbGluYXJvLm9yZy9ULyNtMzU1
MDk3M2UwODg0ZWM0YTI4OGQzNDRmYWJkNGE5YzNiNjRhZjQ2ZQ0KDQpUaGFua3MsDQpNYW10YQ0K
