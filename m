Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48C6804CED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344982AbjLEIs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbjLEIsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:48:25 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2093.outbound.protection.outlook.com [40.107.20.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B7A122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:48:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhy5l3xj5KaCqKpIpdYn/MEen0pTzL/SVqL2NnvmzOOxJ5Hj6xCeeNMzCUa5mXWgN3XovMEyqytH4DNH32Oixaog91DjhGRdCOGGhaUCcq3oWSgVchjGWDg1yYgM4/Hlhkz1Uc6Pdt92Ew0tpm91wt/Paf6R4iq6JqeJAXuHDV4jIS2pqhpA+DiINyS+zGZmH24iKn58OQnv1c+iJ9nu7nJhPdCW3iQieFfqpVU0BYfN6U4W0c4D5yk50KW0QU3e+iW2Mi0N/YFo5/Nf1/z7g+W/1VMgPKORBMy0ZtnJv03qSBjsVmpc7Yba6Fl1pRv37UoRJFZ9VEIt5or0njJWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OISJ+gufW3YW9qcMqKLdkDOS/HJ0VG8W2nJ7EiQPMo=;
 b=XcE/w8hpEo+f1/AzTqt0DJgi7cP81WnG4TlE/CcyGFhEtPTaKwJUz+7FNa5uaE4La2kp7kaR3cr5waUcZuQ4IWBDaxNs0ZGLFbWCorrLU0Dwyk+Q77KexIHq/v6Afr4a2A6UG0dJlLU2EMvJYtupYWuIitKt/NJ0msF8ZJhRGzpqkfJEcP06RVw5btlPH76cf3qW5Bmw7gXUnFDSwHsi9oghEJNHPB2ctLxCdkFxm4P0vdO02VhnC4QrthfHNhmESmk4QchFIj6xPB7w8qmP62LUvZz89432e5Ftz+1DUH+hFFc1lboU1rI0/h9WM9mXuwOZz/JWGTuJ81+ZjGBCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OISJ+gufW3YW9qcMqKLdkDOS/HJ0VG8W2nJ7EiQPMo=;
 b=jOu1Bxd5Wv/kB3M3JMDjekdM7iV7Wl7/pFUko0vsUVeEPAC0ybFyIYnRAyaMpDMvYZmfpYg1qPuGn4xtDyPAHXBjyO30chjPvDPpCNctm2tnizQZCI6TLXPeJrjPemA1wSVaD/td+M72rf1ZC46L2Xb8WQ1N8WX7j8Pyp9JxgKg=
Received: from VI1PR06MB6063.eurprd06.prod.outlook.com (2603:10a6:803:9e::11)
 by AM9PR06MB7857.eurprd06.prod.outlook.com (2603:10a6:20b:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 08:48:27 +0000
Received: from VI1PR06MB6063.eurprd06.prod.outlook.com
 ([fe80::f5af:b3bb:56f3:dc02]) by VI1PR06MB6063.eurprd06.prod.outlook.com
 ([fe80::f5af:b3bb:56f3:dc02%7]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 08:48:27 +0000
From:   POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        GEO-CHHER-bsp-development 
        <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH] nvmem: fix issue within nvmem_register with fixed-layout.
Thread-Topic: [PATCH] nvmem: fix issue within nvmem_register with
 fixed-layout.
Thread-Index: AQHaI6piidK+FNpn5UOEVnKlCBQFIbCaaEuA
Date:   Tue, 5 Dec 2023 08:48:27 +0000
Message-ID: <16c4c272-1a19-4fb8-8a2d-b2cf61ba37f2@leica-geosystems.com>
References: <20231130162922.2989774-1-catalin.popescu@leica-geosystems.com>
In-Reply-To: <20231130162922.2989774-1-catalin.popescu@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR06MB6063:EE_|AM9PR06MB7857:EE_
x-ms-office365-filtering-correlation-id: 8812a210-ff30-4f17-7dd8-08dbf56ef309
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s19PVdBn0ToPQpUcqoO5VdzBmsHGwMnIAyNBkkZYlo5XTjaJoy/FmDl1xnrhqZ8p3eCVLKxiC5DVrZNlV3Xt2yhJ4Gq8cLdxDy4Z4/j5EeqBh/iLfHyLYoL7nLwZAtVPoHzUeex0KgSn2GGEyvnyRDOyLSxvM36W7LWrmIWSWheMR5Aq/Jh9Z9HNvcCLV/Tmpz2GKNFneOqg1LeC4nuNjqCqpKP0l5nHAXo4otMCkAqZw5dxKESe0j/L7eM0Bkek8YO6MqCizOGfAhJnvAM2LbuM8Jx5D4vNNi8I0+lWXcaAd8QnaclgNkzh6SO/7IieJadvMSAolfDCdWFc/J2vyFiucHtGyqTPWnK/4GGGMOOK5Tk24Aop5jQrd9A4jhc2HJgEpYkZzHb12FP1KWlipgFMyYfUB9p6f6EWhzXAM85rKODO/sxfv2QCu2tVPvJ8/ZuZgRfaJLb1in3AfgUlbHVwUstRudHEyF10YNf5oNeIT8frIm2MvL74d0prSehWouaxPGUX8opuJdQy8gUUNyFk8ejCoxdFGqgs98nXQGrqBawItpbiMBDXoe2TIQGbrsAjMWzGelUL/2gFvblBSU0NsFnu+viryr8R/yMfKdvl6NAhFuv3hFurZILJRBzHsf7oxj4w0yEO9sKbt0b1SQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB6063.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(5660300002)(38100700002)(31696002)(86362001)(36756003)(2906002)(41300700001)(122000001)(107886003)(53546011)(2616005)(4326008)(26005)(71200400001)(6506007)(6512007)(478600001)(6486002)(91956017)(54906003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8936002)(110136005)(316002)(83380400001)(8676002)(38070700009)(31686004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REJURkUzYWxPb2hJWGFZWTVvVm1adHhYc05uTEZBYTVPK2pWWmt4WHNWWW1W?=
 =?utf-8?B?TlZxeEt4bHgxZlBobWI0cHorVmd2THlLdmhzT0xFbzNJM1dZcEowK3JPTnpt?=
 =?utf-8?B?cFFWR2pXV2Y4MHRQc1lxNCtBOUpTNDNheHNPS0RKZ1hwKzVTd1ZtZ2czQTFK?=
 =?utf-8?B?MUNpUXR4L0kwcHcyVmVuZDNET3VGazU3RFB3Mm9ibjlmRlVlMlpsOHBodit4?=
 =?utf-8?B?QUJFYktBcHM0YU0xL09YRGlBTnpyQ2NHclBFczh5RG1xQVJYM0dxWG1LZFdM?=
 =?utf-8?B?WnhzYU5TZEthT2k4a0hMMTE4eFVWSVNiTENBWW9kUnp5N3FuUUhOZUNoLzVn?=
 =?utf-8?B?YUQ0ZUlZRW1DOUxEeDhKWFV4Z21DR3NjSDlNVzJqU1dVMlpRZlA5cWpYWkJz?=
 =?utf-8?B?eUlGL0N6MEphY2ZmMmkvRlVRMUFGKzh2MHJCN0YyeGZsSFhjeGFwbEJUUkow?=
 =?utf-8?B?MFRmeFZUTktnS3NPQ3FOOWJXc0F3ZjdOdDVQajVPcWZWVmNBNXg2OEl0enVq?=
 =?utf-8?B?WlBIVjFzRXhPZnBmeDBNbUJrK0JaZFJrbS94RXd5d3hkZXh3UW45VnZ2cm1h?=
 =?utf-8?B?NEN4bzRCUURrSkJZbmF1MWJLUkJPb2U0UVlqdlFxRjZXU1ZZbnhEODZuOVlT?=
 =?utf-8?B?NjdpbXV6NjVqRDBvRlRRRFFzZUJjK0JrcHZPaDAybFBoQm5lQytLS0s2a0s3?=
 =?utf-8?B?VHI1WjNjTnRwcDA4YzBzSmVMMGUrWUIvcytRbjlIVkFJcHJQdXNzWCtnN2Iv?=
 =?utf-8?B?UFdlcitETC8rVXhSK1NIRHlMSGw3RWpPK0c5ZnplQ09XcHdRVWgwR3Zkbk5i?=
 =?utf-8?B?c1pmWHpOZFRTSCs0N3gvRFVocnczb3F6Y3B1N0piK1FYZFUrcXJtK25WQVEy?=
 =?utf-8?B?MG50cEM0dkJNcEJpRmZPY21Rc3FpcW5Ia2w0d0NVcGR2eTBHTEpQOWloSUN0?=
 =?utf-8?B?WmlXc3NLblhqK0dVZ3d4WURZWVJhZFBLdXRONUdudWRrT0V3b3JIM2VpTUVO?=
 =?utf-8?B?TW9XN3NEN25Ua3hxVFdGcFhIZ1Q4bSt1alhOU0tmbzJLR0ZVbUhvMDZaOXI0?=
 =?utf-8?B?bnZBSkp0RXpiYTh1bnVMd1d5R3BxU1R5YVVXWEdoT044UXo1OUhrU0JXakN1?=
 =?utf-8?B?eTQ2dld2TFBLUDFQL2J1dWtpemwwZjdkQWsrODJxR1paU0ovalpKU2RkU0pz?=
 =?utf-8?B?K0EvZzJpWS9sOXU5VTlmamFXUHJlWitlZHlOeGR6eUNaSytJR0F4dUhGUkZJ?=
 =?utf-8?B?TnU1VHBmRHJoaFEwMHZXMHRKQk04TmtGc1l3d2xIenBjTUE1QmMzQmt6YTdK?=
 =?utf-8?B?bTczc05yWlpVV2h5N0JxNDhQOWVZOStDRHN4RXgxZDZmOFVPRVhZbzhJa0tt?=
 =?utf-8?B?bXdhYlVHbVpDM0RqZ2lzSDdQd0V0Y0czYWgzRml1RW1nNmQ4VVVZcnM3a1pR?=
 =?utf-8?B?aklBWlFaeXUvYzdrSkZlWlpWN2VqeThkTFlNYnlzbnJwbHZtS2ZmWGNMZmpk?=
 =?utf-8?B?ZXlVdHd5YlRLVXdYbXBkVktrSmxRU2l0bVlrblpSMnJHSFBzS3ZnemNPZnlr?=
 =?utf-8?B?bE4vbUpVN0NkWmhoOW5YU1JBbkhLbVpIclZDaFp4NVpUbHNhcWRPdm5LbDZz?=
 =?utf-8?B?aVFhSndEWXAyZFU1ci9TQWdpU2xEc1FlOFdjZFdxNXZjdmR2aUZzOU1obUNJ?=
 =?utf-8?B?dDVFU3hMSHJNS0VrdlRsSDVyeFhUWlR1WlcwSFg1ZkVBUjVvUHJhcTNUemh1?=
 =?utf-8?B?MlVmN3lJZHdzb2pNWEF4dlROZTZUU1hlcDRnK1hDSUp3VjNubWVlK0R5amQ3?=
 =?utf-8?B?eGNmbXBWd2pYOVBOdDRPUkpia2NPQXFuRUIzNE1uQ3pPL3Y0Sm84emdkdFhI?=
 =?utf-8?B?NExLbnkyV3JIbXBQR3JVUEJLR0llU0ZmcTVUZTluSHJwOVN0bTVjakc3SU1D?=
 =?utf-8?B?SnZUUHlGczdONTFPbFpMbnVHOUNZMldKM2tEUDF4Z0orR1B3cjgyUm9Cd1N0?=
 =?utf-8?B?NDV3WEpRZ3RiaFNpOFBJenpnQks3THN3cy94cndwL2M1V0E1ekwwSzFQNG5i?=
 =?utf-8?B?cmlpZEtRZzRCQW44ZEIyWlZZYlJpbUlvZFJBbENvTjFvdW9qK0VJaDJWUUdD?=
 =?utf-8?B?UWVGVXhpSEhiTGIxK0FlWDFKVSttaVd5bDlDRmNiZlFVYjlDVkZ3aC9NUHdq?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FCEA7AD2C0FA54C94B280F2902925DF@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB6063.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8812a210-ff30-4f17-7dd8-08dbf56ef309
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 08:48:27.5235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA/489lp0NH1rsj5lWTlcFkyvWqBsh0+gtacE+6b54KHb4gAGPBFRxMGeT3pgnQY9pOJt7avwuarlct7Unlq8r3JO0atDk5poCPplg7lx2wOBQtRCj8J8/WvB56pReGY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkaW5nIG1vcmUgcGVvcGxlLg0KDQpPbiAzMC4xMS4yMyAxNzoyOSwgQ2F0YWxpbiBQb3Blc2N1
IHdyb3RlOg0KPiBmaXhlZC1sYXlvdXQgaXMgbmF0aXZlbHkgc3VwcG9ydGVkIGJ5IE5WTUVNIGZy
YW1ld29yay4NCj4gWWV0LCBpdCdzIG5vdCBiZWVuIGRlY2xhcmVkIGFzIGEgc3VwcG9ydGVkIGxh
eW91dC4gQXMgYQ0KPiByZXN1bHQsIG52bWVtX3JlZ2lzdGVyIGFsd2F5cyByZXR1cm5zIC1FUFJP
QkVfREVGRVIgaWYNCj4gY29uZmlndXJhdGlvbiBoYXMgbm8gbGF5b3V0IGFuZCB0aGUgTlZNRU0g
cHJvdmlkZXIgRFQNCj4gdXNlcyBhIGZpeGVkIGxheW91dC4NCj4NCj4gQXMgYSBmaXgsIGRlY2xh
cmUgZml4ZWQtbGF5b3V0IGFzIGEgc3VwcG9ydGVkIGxheW91dA0KPiBhbmQgdXNlIGFkZF9jZWxs
cyBjYWxsYmFjayB0byBwYXJzZSB0aGUgY2VsbHMuIFRoaXMgYWRkcw0KPiBjb25zaXN0ZW5jeSBv
dmVyIGxheW91dHMgcGFyc2luZyBhcyBmaXhlZC1sYXlvdXQgcGFyc2luZw0KPiBpcyBoYW5kbGVk
IGluIHRoZSBzYW1lIHdheSB0aGFuIG90aGVycyBudm1lbSBsYXlvdXRzLg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBDYXRhbGluIFBvcGVzY3UgPGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1z
LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lbS9jb3JlLmMgfCAyNCArKysrKysrKysrKysr
KysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNyBkZWxl
dGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vY29yZS5jIGIvZHJpdmVy
cy9udm1lbS9jb3JlLmMNCj4gaW5kZXggYmY0MmI3ZTgyNmRiLi4zNDY3Yzk0MjA3ZTggMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbnZtZW0vY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZW0vY29y
ZS5jDQo+IEBAIC03NDYsNyArNzQ2LDkgQEAgc3RhdGljIGludCBudm1lbV9hZGRfY2VsbHNfZnJv
bV9sZWdhY3lfb2Yoc3RydWN0IG52bWVtX2RldmljZSAqbnZtZW0pDQo+ICAgCXJldHVybiBudm1l
bV9hZGRfY2VsbHNfZnJvbV9kdChudm1lbSwgbnZtZW0tPmRldi5vZl9ub2RlKTsNCj4gICB9DQo+
ICAgDQo+IC1zdGF0aWMgaW50IG52bWVtX2FkZF9jZWxsc19mcm9tX2ZpeGVkX2xheW91dChzdHJ1
Y3QgbnZtZW1fZGV2aWNlICpudm1lbSkNCj4gK3N0YXRpYyBpbnQgbnZtZW1fYWRkX2NlbGxzX2Zy
b21fZml4ZWRfbGF5b3V0KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gKwkJCQkJICAgICBzdHJ1Y3Qg
bnZtZW1fZGV2aWNlICpudm1lbSwNCj4gKwkJCQkJICAgICBzdHJ1Y3QgbnZtZW1fbGF5b3V0ICps
YXlvdXQpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKmxheW91dF9ucDsNCj4gICAJ
aW50IGVyciA9IDA7DQo+IEBAIC03NTUsOCArNzU3LDcgQEAgc3RhdGljIGludCBudm1lbV9hZGRf
Y2VsbHNfZnJvbV9maXhlZF9sYXlvdXQoc3RydWN0IG52bWVtX2RldmljZSAqbnZtZW0pDQo+ICAg
CWlmICghbGF5b3V0X25wKQ0KPiAgIAkJcmV0dXJuIDA7DQo+ICAgDQo+IC0JaWYgKG9mX2Rldmlj
ZV9pc19jb21wYXRpYmxlKGxheW91dF9ucCwgImZpeGVkLWxheW91dCIpKQ0KPiAtCQllcnIgPSBu
dm1lbV9hZGRfY2VsbHNfZnJvbV9kdChudm1lbSwgbGF5b3V0X25wKTsNCj4gKwllcnIgPSBudm1l
bV9hZGRfY2VsbHNfZnJvbV9kdChudm1lbSwgbGF5b3V0X25wKTsNCj4gICANCj4gICAJb2Zfbm9k
ZV9wdXQobGF5b3V0X25wKTsNCj4gICANCj4gQEAgLTEwMDMsMTAgKzEwMDQsNiBAQCBzdHJ1Y3Qg
bnZtZW1fZGV2aWNlICpudm1lbV9yZWdpc3Rlcihjb25zdCBzdHJ1Y3QgbnZtZW1fY29uZmlnICpj
b25maWcpDQo+ICAgCQkJZ290byBlcnJfcmVtb3ZlX2NlbGxzOw0KPiAgIAl9DQo+ICAgDQo+IC0J
cnZhbCA9IG52bWVtX2FkZF9jZWxsc19mcm9tX2ZpeGVkX2xheW91dChudm1lbSk7DQo+IC0JaWYg
KHJ2YWwpDQo+IC0JCWdvdG8gZXJyX3JlbW92ZV9jZWxsczsNCj4gLQ0KPiAgIAlydmFsID0gbnZt
ZW1fYWRkX2NlbGxzX2Zyb21fbGF5b3V0KG52bWVtKTsNCj4gICAJaWYgKHJ2YWwpDQo+ICAgCQln
b3RvIGVycl9yZW1vdmVfY2VsbHM7DQo+IEBAIC0yMTI2LDYgKzIxMjMsMTkgQEAgY29uc3QgY2hh
ciAqbnZtZW1fZGV2X25hbWUoc3RydWN0IG52bWVtX2RldmljZSAqbnZtZW0pDQo+ICAgfQ0KPiAg
IEVYUE9SVF9TWU1CT0xfR1BMKG52bWVtX2Rldl9uYW1lKTsNCj4gICANCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGZpeGVkX2xheW91dF9vZl9tYXRjaF90YWJsZVtdID0gew0K
PiArCXsgLmNvbXBhdGlibGUgPSAiZml4ZWQtbGF5b3V0IiwgfSwNCj4gKwl7fSwNCj4gK307DQo+
ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBmaXhlZF9sYXlvdXRfb2ZfbWF0Y2hfdGFibGUpOw0K
PiArDQo+ICtzdGF0aWMgc3RydWN0IG52bWVtX2xheW91dCBmaXhlZF9sYXlvdXQgPSB7DQo+ICsJ
Lm5hbWUgPSAiTlZNRU0gZml4ZWQgbGF5b3V0IiwNCj4gKwkub2ZfbWF0Y2hfdGFibGUgPSBmaXhl
ZF9sYXlvdXRfb2ZfbWF0Y2hfdGFibGUsDQo+ICsJLmFkZF9jZWxscyA9IG52bWVtX2FkZF9jZWxs
c19mcm9tX2ZpeGVkX2xheW91dCwNCj4gK307DQo+ICttb2R1bGVfbnZtZW1fbGF5b3V0X2RyaXZl
cihmaXhlZF9sYXlvdXQpOw0KPiArDQo+ICAgc3RhdGljIGludCBfX2luaXQgbnZtZW1faW5pdCh2
b2lkKQ0KPiAgIHsNCj4gICAJcmV0dXJuIGJ1c19yZWdpc3RlcigmbnZtZW1fYnVzX3R5cGUpOw0K
DQoNCg==
