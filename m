Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744528052F6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbjLELeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347021AbjLELdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:33:55 -0500
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29BB10EB;
        Tue,  5 Dec 2023 03:26:29 -0800 (PST)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
        by mx07-00376f01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B582T6P020233;
        Tue, 5 Dec 2023 11:26:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=dk201812; bh=GfRLGCli1+p0dXkjvQXSM3ppOx2DYZQLCZd2O0eKEh0=; b=
        Nbqa85DWGARRu6ODG/1RHtrjNKyNoYSMeuUd3rEw/y460oDTdpkk0CpokWaP41pF
        RmE/O1q+rXqYrhQhuwaAXmXKSw9sSJdefC2s4ijdFhw3WQFQiC4xlz3ve3S375mB
        XYCNKLLP5argNo1zxbh64ITeV0IzP45NJ2OCyKJzwzO1KTP52makmS+9av93mlqP
        Gd2Q9c6WKhv1+fJ3eAXiVgRS4JiHw7+r3Suh60C02avgkE8wHOFWxpCEN614VNFl
        REDaOcUn6Pz/QYKEcAyT6BOg0LiHB+Bt3gy9fmLsggzR3uqkpIiK6j53hPuFnfPW
        XrAKctrCV/mLvA76Jy4RSg==
Received: from hhmail05.hh.imgtec.org ([217.156.249.195])
        by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 3uqwhwa7aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 05 Dec 2023 11:26:06 +0000 (GMT)
Received: from HHMAIL05.hh.imgtec.org (10.100.10.120) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 11:26:06 +0000
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (104.47.85.105)
 by email.imgtec.com (10.100.10.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 11:26:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSsfurYMW64me1hpTp7MQLjOjTS8Sa544Wm8Osm5v44oCkl1lWr25FPOyHyjosfj5KBDKbY44Skk3e8qepfTCkWGbGPZcx7TtpdrjIZH8FR+O7GqTQnp7+GJ3K9rLDvvHbDL8V0uMYzb98Xd2SG6wHZbDPID2FyLahAG3SlKqbPC4DozU2qvPOFOTqrae/UoVaE5vDnB3DanYRv0CsCM8baY5Ps2OvztJ38P5C3PgKASX+lsur6Mjp+t1da/RroqBd5wZthU5ldvBWxIYxa0c1kItQKEkCUkWKhFOaYE3ccUrAOpDnagr4/kAUt39/BL99cgBqwTHdnFxKyN2tS1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfRLGCli1+p0dXkjvQXSM3ppOx2DYZQLCZd2O0eKEh0=;
 b=E+dZDNn2Pa/RgdSw8HpaWxVMSgxMKBeVd7hLgypVOUbP7ZvhE06a5vIPWbDVZGBIiRfyUQWi42gztJa8khfRBpdmEt/5vua/lV40PyrmaJPaBHxp2qDBtTxDoz6cACe/B+1XTPM/gK3ThnoYBrn6Uc1WeBmemXIC16zJGcqiWDDVnLr0c+CBwcjXfF/DkQdYEaSiDzLmap1+SYXjOvUXo5LvhaL3LqzXnOUwtDR16H+JybO6UwnC0gL6JaPWkKqs7CG1biMDX7nSvsS+P+ZvcVu2h3vYTIAWWK1IFjLFCR6mSypHlQtZtmFAeaAskaIGawuW+u6wHq1E8yYCFqOV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=imgtec.com; dmarc=pass action=none header.from=imgtec.com;
 dkim=pass header.d=imgtec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=IMGTecCRM.onmicrosoft.com; s=selector2-IMGTecCRM-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfRLGCli1+p0dXkjvQXSM3ppOx2DYZQLCZd2O0eKEh0=;
 b=nKFV/VTXHWlx2osYvY/8M5dOjrrLMOhwFGDaP+N46bUrPbqcJtF9v6bLupJidLoO3cgAsUUD3bMirQBz+ynJtOjQ7YyC4sIjRAf63h7B2ov3jjQiwVjVpoFmncZZqARrkBQfNori1m6dfglCxUbSNSRL+zuoWqp8yUxP6rL7eKo=
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a0::8)
 by LOYP265MB2238.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:123::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 11:26:04 +0000
Received: from CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34]) by CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a85a:76f7:c085:2b34%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 11:26:04 +0000
From:   Donald Robson <Donald.Robson@imgtec.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kristo@kernel.org" <kristo@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        Sarah Walker <Sarah.Walker@imgtec.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "mripard@kernel.org" <mripard@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Add GPU device node
Thread-Topic: [PATCH] arm64: dts: ti: k3-am62-main: Add GPU device node
Thread-Index: AQHaJqugg03/oMKSk0i/8bzmQAg/cbCai3iAgAAC2YA=
Date:   Tue, 5 Dec 2023 11:26:04 +0000
Message-ID: <6e71745a9258ecd384261369656dd05da5ab10fa.camel@imgtec.com>
References: <20231204121522.47862-1-donald.robson@imgtec.com>
         <c20b213534667337f08b75a6c325fafec6526135.camel@siemens.com>
In-Reply-To: <c20b213534667337f08b75a6c325fafec6526135.camel@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB5770:EE_|LOYP265MB2238:EE_
x-ms-office365-filtering-correlation-id: 733d122d-c453-4d4a-db88-08dbf584f7e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MNM/YV2Cj9Jr+yF0gEMYyH8NQpJRkLzUgLy5ibBhrlvtohCZYwpid7XsMWmSZM4UaxJ+bqOUkiDWHigspAECQx/W8WKcXBvROZTOUdvSeoKXePVlxcQw/Keljx9ERF5RpM3yIQAc1hzPZWTcaDapQE+IcoeFjxEYxI6tV/fFLQ6jnIBujpONrexU1xebxaT5+Wrou2Z8IQ0byfObc0GKbXNXOUqwo9nngxWvX1ITLenh4qu5E2fFc/yAs3vvzckPEqF77LRqgnBxiI6EFjuh0WsV8h/qdZ0kAD8c/ftDXRYnOJhuN/qjj2M+4kP1GNzYhfsAew8WQBPsoTvFnBnTttHiH0wYE+aXagaavTz0j+2hSfSNvykml4zez7iZrx4i9jzT7o9B3JBM3K3+Nwa01Sw1sx6yKToVvzBoQQnXi4zafME3KNNa5z92pPAdghKWdj7u3jL1wTUHFJd2IRpNBYQu064mt7QbUKczSHBPynYacgVya6jKOdCMx00VwEWmk+QdWyG7n2FIHgUR4FceEbVMAYycb465A8N9TOpO5P5cReRhgQiHcpaKrVaNLBjyfLDKiYmC6GWGr92O16WcKX9Rb6mxyHHhr86NMV+bfZ1n0xoK0Yjwnk7AKWJa35ZJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2906002)(86362001)(38070700009)(5660300002)(7416002)(83380400001)(122000001)(38100700002)(36756003)(6506007)(71200400001)(6512007)(2616005)(26005)(8676002)(8936002)(4326008)(41300700001)(478600001)(6486002)(66946007)(316002)(54906003)(110136005)(76116006)(66476007)(66556008)(64756008)(66446008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3BqdDFUaXRkV0tmRmp1MFBORHd5ZHZaOU5yRmtXOCtmanlIY1licVdGQkc3?=
 =?utf-8?B?VWFqRXR6STdsa0JGWGtZellMYkVTc3VIdmJKWjdGNHFpSlBLc1RnZ09ySjlY?=
 =?utf-8?B?enNpS09CczlmS25mTnVYb3M2ZTUzRncwMFIxY0VzZXJPaFBsaldtQUxlb1Ny?=
 =?utf-8?B?SlZYVWRKS29LM01NcitTMHNXWm45eExPNEhRa1BnQm5FWTRYTFFFdTRuaElx?=
 =?utf-8?B?WG13Z1dXUDRYVTlSRFB1WFg2dFljd0VKQ0FBUWZXdlByMlRkRElQWWFjN0xn?=
 =?utf-8?B?RVI0bWo2ZDhjamVUNDVEeG1OeFExRjJQdnMyYzdkUkNkU3RCT1VjUHRBNFBt?=
 =?utf-8?B?YW1VOXFhK0pVVTh2ak9uaitlWHlhWm5tTkJhMGZKUzNSSmNnTy9EaHNvc1I3?=
 =?utf-8?B?K1dlYmNKTVkyTURodkk0alhGbVkxcG1xSjJLTU5xQXBNbkVKZFNOcmVpMjZ2?=
 =?utf-8?B?ZWg2SlVUeGY4eFFBSE9JUkN2OTN0L0p1NHI3alk2eDhKMytnMmRLd2tuVU1n?=
 =?utf-8?B?QmhLZXFWNlpBZnZNaDkvOFozRTNVL2x2UnVyaFFUM29xL2gvcytwTElSd1ZP?=
 =?utf-8?B?NzgraG5acS9zY3k5bThKeHFER3FBNUtvcFpjMWM1elRhVEJDMjkwN0szbkNL?=
 =?utf-8?B?Y0xPc24rc0h0U1FjZlFzTnVJdlVsK2JxT3JleU9hY3pyWFcxeHhjUG9sRE4w?=
 =?utf-8?B?clE2ajc0Yi9OT3QyNDZOeVlkbTZxd1FOamJWWm5VMms3cFQvZjlnKzB3b2h3?=
 =?utf-8?B?ZkNBMEx6cFk1elRheHRmM2lTbzlLTWZtT1A2bVIwL1ZXOTdOclduVStkVTBk?=
 =?utf-8?B?K3Bhb09vS1RqUWw5Vks3YzFUSUVCcjg0bXBRcG5xbzM3ZEJxNmhxeWtoaWd0?=
 =?utf-8?B?YkJ4U3F5SGFNODEvWTVoUW01TFBwNWJYL2FRVzVsRXJZNUtHSkMvN2RySms5?=
 =?utf-8?B?c0tOZmVnblFBVWUvNzgrOFZheVIvalFpWmZ5bWp2MHVHOHdLTzcxcjY5OWFi?=
 =?utf-8?B?R1dXeldMMW9BZ1czUjIxZXozZTJ6ZHYrbXZIck9LbFhuTW5QaTZlVk5MRjVh?=
 =?utf-8?B?ZDNyczlSVnZrM09SV3ozMnV1T24rT3FBRlVENVprWkhHbis2OFZoNHRteEl4?=
 =?utf-8?B?d3EyTmJkV3hkR3p1OVRDdWttNE5ObDcvSXIxS1dwWkIrNytGNjVyM1pJSUk4?=
 =?utf-8?B?R1RnL04zSXE3K1lBZlJNSGxpWUxhVE1uVTJnMXlocEZZc3hNT2xabFJVV0RC?=
 =?utf-8?B?ajR4M2dzdUZRRGc4SnQ1SnZDK2xBb2RNMWROdVhkeThzZHNBRjh4RlBJVWQr?=
 =?utf-8?B?VktMakFpZlBGZXZvSldaMjVFSjRBV1hBVHhtU3NPVENXeHZRN0RvWHNPdEpj?=
 =?utf-8?B?bjliK0RpcSttcFoyUE1ESUNDZlVqMTV4N2hzMTZqaUw1QjB1UnpkSE9pcnJW?=
 =?utf-8?B?ZEpZZkhSa3FFS201WEQvb3N5cGZHUUNwam5kS1dmbmw1ZmRoTmlaTmY2MEpH?=
 =?utf-8?B?dzhndVJyVmxQU2tFUkE5YWJDTFRPQTN3QmF5aWFaOEg3bmpya3VKL3YycmpF?=
 =?utf-8?B?VWNUS2VhZkpDTzJBZWllZmREOTNTZ0NEcUFFRXJ5am1YYlFreklwSlVIUzN1?=
 =?utf-8?B?NXBuZjExdUo3UWl4SWpFYWJtdjgvaTJvSFRZNGpEcy9seVEzd3dHWjBmQ3Fy?=
 =?utf-8?B?dlcrSzJkaDZNaGhkajRjYml1ZEJmN0h2UXAzRkdRVkdtN1RuZVdYUkZqNGRm?=
 =?utf-8?B?S3NmalNuUnlDYnJsVHpnOExwOGJma2xhZjZQUFk3L3hoMFlXZkVzTGpZemxK?=
 =?utf-8?B?WlA4RW9uTEcxd0t5eFBRc3ppaHFaWHc4SnZpM2lvVDd3Y0VhcVVyK20weHp1?=
 =?utf-8?B?eWRuczVXSm9MaTM5UzFHb3R5eTJEZzAzZVUrTkVya0pRMWZGYm5SUkVOWDZy?=
 =?utf-8?B?QmJ2R2NaSTlPRXpSNlN3Z1A5T1IzSlExVXhOQWxvSG03V3dXcmZrQWhta1FZ?=
 =?utf-8?B?SC9SVXhMWjN5aVJWTEtla28xaWx3ZCsxRE9vOW54WUtjS29ZV0ZyeTlCYzU0?=
 =?utf-8?B?VElCMkF5azJZSWVOVzVBNE1keHBaamFDNVBDS0MyZWdEQ1V3MCtqVnJFS1Jo?=
 =?utf-8?B?K0l1VUNzaGxrL0l2NEZObm81SmFmQ09vMy9FMVFoVGV1MjdrSGYxQ1Q2ckRy?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <674CB944D27AD7409693A43ECF499A2C@GBRP265.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB5770.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d122d-c453-4d4a-db88-08dbf584f7e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 11:26:04.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d5fd8bb-e8c2-4e0a-8dd5-2c264f7140fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWG+k7qhJmI2P+k1aRn0DMpSPZA3s6fomB9JHXHXk75TmAZ26KrGaAWx3USvmHqbNNXYpEKt29Sfxbf/LcGozd5Tcrkl818ZXLz4zhbxV4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2238
X-OriginatorOrg: imgtec.com
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: RGxbXPU_xqYnU-aUTo5E20wYYkzCypzx
X-Proofpoint-ORIG-GUID: RGxbXPU_xqYnU-aUTo5E20wYYkzCypzx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQWxleGFuZGVyLA0KDQpPbiBUdWUsIDIwMjMtMTItMDUgYXQgMTE6MTUgKzAwMDAsIFN2
ZXJkbGluLCBBbGV4YW5kZXIgd3JvdGU6DQo+IEhpIERvbmFsZCwgU2FyYWggZXQgYWwsDQo+IA0K
PiB0aGFua3MgZm9yIHRoZSBwYXRjaCENCj4gDQo+IE9uIE1vbiwgMjAyMy0xMi0wNCBhdCAxMjox
NSArMDAwMCwgRG9uYWxkIFJvYnNvbiB3cm90ZToNCj4gPiBGcm9tOiBTYXJhaCBXYWxrZXIgPHNh
cmFoLndhbGtlckBpbWd0ZWMuY29tPg0KPiA+IA0KPiA+IEFkZCB0aGUgU2VyaWVzIEFYRSBHUFUg
bm9kZSB0byB0aGUgQU02MiBkZXZpY2UgdHJlZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBT
YXJhaCBXYWxrZXIgPHNhcmFoLndhbGtlckBpbWd0ZWMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IERvbmFsZCBSb2Jzb24gPGRvbmFsZC5yb2Jzb25AaW1ndGVjLmNvbT4NCj4gDQo+IHBvd2VydnIg
ZmQwMDAwMC5ncHU6IFtkcm1dIGxvYWRlZCBmaXJtd2FyZSBwb3dlcnZyL3JvZ3VlXzMzLjE1LjEx
LjNfdjEuZncNCj4gcG93ZXJ2ciBmZDAwMDAwLmdwdTogW2RybV0gRlcgdmVyc2lvbiB2MS4wIChi
dWlsZCA2NTAzNzI1IE9TKQ0KPiBbZHJtXSBJbml0aWFsaXplZCBwb3dlcnZyIDEuMC4wIDIwMjMw
OTA0IGZvciBmZDAwMDAwLmdwdSBvbiBtaW5vciAwDQo+IA0KPiBJbiBnZW5lcmFsIGl0IGFsbG93
cyB0aGUgZHJpdmVyIHRvIGJlIHByb2JlZCBvbiBUSSBBTTYyNSBFSywgc28NCj4gVGVzdGVkLWJ5
OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0K
VGhhbmtzIQ0KDQo+IA0KPiBCdXQgSSdtIG5vdCBzdXJlIGlmIHlvdSBtYXliZSB3YW50IHRvIGRp
c2FibGUgaXQgYnkgZGVmYXVsdCBsaWtlDQo+IG90aGVyIEhXIGJsb2NrcyBmb3IgdGhlIChwb3Rl
bnRpYWwpIGJvYXJkcyB3aGljaCBkb24ndCBoYXZlIHZpZGVvIGF0IGFsbC4NCg0KTm9yIEkuIEkg
Z3Vlc3MgaXQgc2hvdWxkIHN0aWxsIGJlIGVuYWJsZWQgc28gaXQgY2FuIGJlIHVzZWQgZm9yIGNv
bXB1dGU/DQoNClRoYW5rcywNCkRvbmFsZA0KDQo+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL3RpL2szLWFtNjItbWFpbi5kdHNpIHwgOSArKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3RpL2szLWFtNjItbWFpbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy90
aS9rMy1hbTYyLW1haW4uZHRzaQ0KPiA+IGluZGV4IGU1YzY0Yzg2ZDFkNS4uNDMzOGZkOGFiMmQ3
IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02Mi1tYWluLmR0
c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjItbWFpbi5kdHNpDQo+
ID4gQEAgLTk2NSw0ICs5NjUsMTMgQEAgbWNhc3AyOiBhdWRpby1jb250cm9sbGVyQDJiMjAwMDAg
ew0KPiA+ICAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZrM19wZHMgMTkyIFRJX1ND
SV9QRF9FWENMVVNJVkU+Ow0KPiA+ICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiA+ICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICBncHU6IGdwdUBmZDAwMDAwIHsN
Cj4gPiArICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ0aSxhbTYyLWdwdSIsICJpbWcsaW1n
LWF4ZSI7DQo+ID4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDAwIDB4MGZkMDAwMDAgMHgwMCAw
eDIwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgY2xvY2tzID0gPCZrM19jbGtzIDE4NyAwPjsN
Cj4gPiArICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiY29yZSI7DQo+ID4gKyAgICAgICAg
ICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA4NiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4g
PiArICAgICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmazNfcGRzIDE4NyBUSV9TQ0lfUERf
RVhDTFVTSVZFPjsNCj4gPiArICAgICAgIH07DQo+ID4gIH07DQo=
