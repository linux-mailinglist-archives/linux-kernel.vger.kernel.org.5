Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB987C62B2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjJLCXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjJLCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:23:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E798
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:23:05 -0700 (PDT)
X-UUID: 42d3df1a68a611ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cCAsMHkZsMoWInjd6hkFnWqHnjGf6kg4ytFuYN723D8=;
        b=YbgygDC+oBWU8kd/sReKGUne+ZJdDtqb7PCDeDftTS+lb5OwsVymxoj0glVp1XghCLmFquYGT3W6oJ3dM/VFp0eu+ipo667/np5YzoDKjMttyx6blSZvLbTC8f0c4Zv+fHb+0iWyq3SoVcCUDnFIYOsIhgcll2XyMFtjQicNFC8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:e9b8f9c6-8354-401b-9a74-d2b339b41053,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e1e6b0f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 42d3df1a68a611ee8051498923ad61e6-20231012
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1119273831; Thu, 12 Oct 2023 10:22:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 10:22:58 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 10:22:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAIp19yXREhOcNjz7PhydRl4E3NiBf/swwn40egIq4gq7b02kRYvinOqW9MEH16YxrEBfg5XEOXxLPT/XuLcswv8wZPfuaEVMmWLHo80DWNSMaCHyDE9UE8Gvp46t3rpsPKQ1JI2zQ22gmvpctiM3/gu63GaugfL3FodB4vejRKFRUTkj+nPWGsL2KqPWPO6fez3kWskL0dCaj4BJKzdOWtF34NGK5CYkjjA9UeONxLDLUX03DcMfOvH0Xjg0UBR8HGe/VEm3HAyGBLyOEBuac5yE9OztaNMmW8YXymeWtE4uf0tNdFGDHcdTVpwICbRBvDesdIGw7u4TfQEOYW1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCAsMHkZsMoWInjd6hkFnWqHnjGf6kg4ytFuYN723D8=;
 b=Xsw9ssbo5ukYc7dcsyQkhhYT0C8OudH4h6IqR6oWProkgpj94E+ttEU2EA4IhtSMfYPIdLk8ad9QbdTaDDOx+ZMXTVxTTGe9U2MWuaPgK7F6ilvGeJuS9cDVex2jF+7DBqPh+pOn9WPKel6PBkW5OLcbE0LB8KkHj+AIl4BQ7cw0BwdgdTDDjMvsdxOgTg+aYCbuZsIdaKGG1UtlzoKQ5Gwm3Z9mKwFyRyCw0RwqzG0X7GCCW2byYiX5g6gnENw6tPqvN2Z7w6ODM+vT3EKNSt7yQxa7yST/giMBJ8j4T8197cP5uQqwD2eBoynGDtEDq8VZ40EyEHeRtp6f0X/acw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCAsMHkZsMoWInjd6hkFnWqHnjGf6kg4ytFuYN723D8=;
 b=fmwo0DcfsTCPCoQNVLY/obK55VUQ/Ek1Faf1fSo6qUZd+PN6nOtFyzIa1bKxnCBNY8oe1o69lAmH/giK34gADBk5ihX9fBlz2BpNmxAV77lAgjhV1HqTdTNbpkAaSYNcra03MM91H7CbtxTWv8a2EiplaLG+yacDxlvNhgABZuY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6353.apcprd03.prod.outlook.com (2603:1096:400:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 02:22:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 02:22:22 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v10 08/16] drm/mediatek: De-commonize disp_aal/disp_gamma
 gamma_set functions
Thread-Topic: [PATCH v10 08/16] drm/mediatek: De-commonize disp_aal/disp_gamma
 gamma_set functions
Thread-Index: AQHZxqVz4v2dCyALOUa8p9O50zFcyLBF2IoA
Date:   Thu, 12 Oct 2023 02:22:22 +0000
Message-ID: <e48af62879d3e3e7cbaa35e29526f43d1f5f650d.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-9-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6353:EE_
x-ms-office365-filtering-correlation-id: 35b01e93-9791-4ef3-755d-08dbcaca1132
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0micAYjFjMCn5d7mVqsHisr00YIqz8C2HufhrY8cub9iJivBRt/P9mB0hQ+M2/BVmJGBWsV1p3kK38DMLuNBipHz+Xd/o0EUSQvx34YUMzoeeS7KutH6Ef/57SdOMLthsKPZftJwKih6PMRuDmlPO18UibBNTjEUX2zDP11J/d2J6UqDyjJYr01LAAmmuGOMu3AtokXMla857NKP/pcE2vtmQFMwZty6OIrVC8qKJPI39FjITewaxpaG6+dCTj0/AJS3GXR5O0/gJMI3nna6oGSA2opho5OtDWKHfKzq1RgVmioZWTuvuYVt4u1BzNGR5x1OU9T+5wUFjahk5vUsFHvLkk/g1uXmQUEH/x5gCWWx8RTbncihNsGr60fdeFUa7qlgubgnh/kzMijQCvPBF26UYJ89hyD7fc7Cn/3tb/l2NxUXgRRWmrciI6CqGbeuiW3EsSZq+fsTTQh0W8GsAH1s3iaKMqdVpoLr7Vtd17EagNZaGmu0xwIpNbzRK8IROxQGjT1zPWwkW049BSPBRaFOsgsFOWnNXcLdh0HDep+y3Zjs5Pt0xXRX4Unh+pWC7UUVTv9N6PQQT7of8JXGpxr83HFCM//5UylorfWLbEIrowDYIn69yfFE2F5b2s0kfzdD5VRliZS2ys01V7i841rfD8yHUZ94QzqjfU0bSaU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(8676002)(8936002)(2906002)(41300700001)(83380400001)(6486002)(4326008)(66946007)(54906003)(76116006)(66446008)(66476007)(66556008)(316002)(64756008)(110136005)(7416002)(5660300002)(478600001)(71200400001)(6506007)(6512007)(2616005)(26005)(36756003)(85182001)(122000001)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckVjdExFK2pNVUVWMVdFMTQ4dlR1OG9aelZoL2lZM3dTYUVHRjQzR243NGNn?=
 =?utf-8?B?M2JxS0NhOTVrc0YrVmZMdy9nczl0bnhDbEpjKzhqSmhmejZ1a1dDaytnTEVq?=
 =?utf-8?B?M2FSTUdLaHY3cnVNaUlhbysvTzcxNGtJVDNqR2YxZ3ZIeTZCdjNqVS9EWW1H?=
 =?utf-8?B?MkxGYmtwR043bWZieG9uM21GUGxaVjUvbnFBZXBFYWtaTlNkYjVVcTJkQ08z?=
 =?utf-8?B?a0NiVjc2YXg4REFIQXphdFFXdjUzTUlzVEhzaGVVSmtabFRxb2V0dFVpcjRx?=
 =?utf-8?B?SE9randub1NST1VuejlweEpsL1lSaitNMUZEajV0bVdhR2FiaUZaWGpyUTUr?=
 =?utf-8?B?Mzg4YmdYNkFOemtVS3VrUzhSVDZNRkY1UlFjMTMwNU5vNlorRU1kWld6SkVq?=
 =?utf-8?B?clF0VG16N0hZVlM3RloxaEVZaExmRzVJKzBXSlVkNUk2ak9lV1hLQWY4TndY?=
 =?utf-8?B?VkVzUGVPWURjbmhFK2ZnR3BtSDAvRStQRzAvVnpuc2c1TDZhbmF5Z3VmSXhQ?=
 =?utf-8?B?VUtTVHhoQkwwaWlEalAvU3lNUXU1SHlTSGxMMDJPSW9QR2pLb3ZzbVZtdHdO?=
 =?utf-8?B?dGZQS0U2ODVFd21EL0llWFFkbFR0N3lrY3l5dlZJY0t3UGVXRmRMa1NvRzhN?=
 =?utf-8?B?SUxab2hTT3A1azRoTS9JdjZhRWdMeUNaeFNtVzh2cnFURVJla3BoUFkrWnVF?=
 =?utf-8?B?Z2hGMVg4aEZmZzk5cmFTeE5JT2QxR1UzRWoySC9vWGQ0NmFjZngyMU9tdWFq?=
 =?utf-8?B?aDlDUDRQUThRWVlPS1FzTVUxSDQyNXRCRVpTWC8yVnFzZVlBRFhGMHExeFhH?=
 =?utf-8?B?Tnh3bGFCV3NvRmphK2NlODFVNFoxU0ZsSkFxSGR4YmxVdnM2Y2lwRlN2VmMz?=
 =?utf-8?B?Z1BNck5lVk1NOGdJTVhCb00xSk41SXQ3OHNtcVhEajFrdjI2MEVoRENsam9q?=
 =?utf-8?B?UlpoTkNxU0ZrWnhLUGpKK25aK1ZEdXhEdHVVSWhaZWZwWDlRclk5WDIyN2FW?=
 =?utf-8?B?cVhSTWo4MFdWM0F2V2JOakNVVE96QmpzRnI2SUpLY2lNZkNZQnpXQW1wZUR0?=
 =?utf-8?B?N2tOWDQzRUg4MHZtaXhqUXZmcTRoT3dpT250V203cDd5dHozcEF2SEwzUTEy?=
 =?utf-8?B?ZDFLa2VEbzcxenhaSExYVy96aXBmTm9qeVUzWkFVY3J5eFF1RG1NdGdiM3Jr?=
 =?utf-8?B?QWYrV2tMT3Q5NW1Kd0NVTkZ6R2UxM2hYUklrS2pwZUZ1ZlJ5SjVadk10RVFE?=
 =?utf-8?B?QWM5QlJQd0c0WkVweVdSTE9JSTFMTlRHWStQRCs0aXpYRllhVTV6NG5yMHNu?=
 =?utf-8?B?SEVDWE50a01ZT3ZJUFlCT2t1VnIzVUN4TUtMcGozNXNQOTlFZFU2N2c5QVFx?=
 =?utf-8?B?RndEQVF5MjBrVzhjOFBuQnVYZjJEMmQ4MVZ6VHpXL2FtYUtOa0ZaRjcxcmg4?=
 =?utf-8?B?OW5oSEEyRDJpTStCcHA5YzcxRVg5M3JoWXlGMlRHQlRZcnBuamxob3doRzZB?=
 =?utf-8?B?SVBUamc1VkZzbTdRMEc4a1duN202YWYwTXdoQThWYTZkYWlxRWovVnFCM0ZH?=
 =?utf-8?B?QnM0ZU10dE1XS0U3YzJUb2tRY25nMWtGQUM0UElzdzd6bTBCOGxnYThaR1dz?=
 =?utf-8?B?aVE2OGlLRUxkaWZxVlNSMWo0OE1iZ3VJdHJzeW1PL3o0aVAwM25IYUozajZV?=
 =?utf-8?B?dkcvV3lKU0UvMjJZSlRUcU5meFB1U3RjaFh4R1NYL0t2aVVBUk52S1ZEMDFk?=
 =?utf-8?B?N0k3R2lhWlA1c3pmT1hCaXhzbDlEWmR3RFlJcFVBRXphakxqajhKR1ZTdVBH?=
 =?utf-8?B?bWJnUkQ4Wm9mMGpYRFoyanFML3NzcWtmMEozaEY0czhKaGVzUHh1NFgySmxq?=
 =?utf-8?B?MGgvV3phb0ZralNyUE44UkJDUndmd1NMSXhHWmlSNytEcXMzaXZaUS84ajdh?=
 =?utf-8?B?SnU5UGZzSnRPbDlrOFZ0MFhaanB0VUZ1WUpuSlJRR0pWcUZheUVRQXpEbGNl?=
 =?utf-8?B?OG52M3hvV0xrSXZoTjZzdUpJV2VJS1ZYWDNiNC9rTU9oTFZQSWlVUXJvdnln?=
 =?utf-8?B?dTRBdmNDNmd2Y2JWYzFHaFdtMVdONXdHeWNLRnVkbWdjTjJ5cEx0dmNqeFFj?=
 =?utf-8?Q?suxfIHPh8AaK1hE9/53ZhBjzL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2A3E705F80B884C884FB610CE2BE1A2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b01e93-9791-4ef3-755d-08dbcaca1132
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:22:22.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HayhePAH4usPXfb5LPBsgxROuAyKHYDktaOc+XW9ovTqjOpSGXfxtbJzdRMCpaSHNgI/2GClmiMc4gNJrwSTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6353
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDIzLTA4LTA0IGF0IDA5OjI4ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW4gcHJlcGFyYXRpb24gZm9yIGFkZGluZyBh
IDEyLWJpdHMgZ2FtbWEgc3VwcG9ydCBmb3IgdGhlIERJU1BfR0FNTUENCj4gSVAsIHJlbW92ZSB0
aGUgbXRrX2dhbW1hX3NldF9jb21tb24oKSBmdW5jdGlvbiBhbmQgbW92ZSB0aGUgcmVsZXZhbnQN
Cj4gYml0cyBpbiBtdGtfZ2FtbWFfc2V0KCkgZm9yIERJU1BfR0FNTUEgYW5kIG10a19hYWxfZ2Ft
bWFfc2V0KCkgZm9yDQo+IERJU1BfQUFMOiBzaW5jZSB0aGUgbGF0dGVyIGhhcyBubyBtb3JlIHN1
cHBvcnQgZm9yIGdhbW1hIG1hbmlwdWxhdGlvbg0KPiAoYmVpbmcgbW92ZWQgdG8gYSBkaWZmZXJl
bnQgSVApIGluIG5ld2VyIHJldmlzaW9ucywgdGhvc2UgZnVuY3Rpb25zDQo+IGFyZSBhYm91dCB0
byBkaXZlcmdlIGFuZCBpdCBtYWtlcyBubyBzZW5zZSB0byBrZWVwIGEgY29tbW9uIG9uZSAod2l0
aA0KPiBhbGwgdGhlIGNvbXBsaWNhdGlvbnMgb2YgcGFzc2luZyBjb21tb24gZGF0YSBhbmQgbWFr
aW5nIGV4Y2x1c2lvbnMNCj4gZm9yIGRldmljZSBkcml2ZXIgZGF0YSkgZm9yIGp1c3QgYSBmZXcg
Yml0cy4NCj4gDQo+IFRoaXMgY29tbWl0IGJyaW5ncyBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vs
b2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYWFsLmMgICB8IDM5DQo+ICsrKysrKysrKysrKysrKysr
KysrKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICB8ICAx
IC0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jIHwgMzQgKysr
Ky0tLS0tLS0tLS0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKSwg
MzAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2FhbC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2FhbC5jDQo+IGluZGV4IGJlYzAzNTc4MGRiMC4uMjFiMjU0NzBlOWI3IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfYWFsLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2FhbC5jDQo+IEBAIC0xNywxMCArMTcsMTggQEAN
Cj4gIA0KPiAgI2RlZmluZSBESVNQX0FBTF9FTgkJCQkweDAwMDANCj4gICNkZWZpbmUgQUFMX0VO
CQkJCQkJQklUKDApDQo+ICsjZGVmaW5lIERJU1BfQUFMX0NGRwkJCQkweDAwMjANCj4gKyNkZWZp
bmUgQUFMX1JFTEFZX01PREUJCQkJCUJJVCgwKQ0KDQpZb3UgZG9lcyBub3QgdXNlIHRoaXMgYml0
IGluIHRoaXMgcGF0Y2gsIHNvIG1vdmUgaXQgdG8gWzEyLzE2XS4NCg0KPiArI2RlZmluZSBBQUxf
R0FNTUFfTFVUX0VOCQkJCUJJVCgxKQ0KDQpZb3Ugc2hvdWxkIGVuYWJsZSB0aGlzIGJpdC4NCg0K
PiAgI2RlZmluZSBESVNQX0FBTF9TSVpFCQkJCTB4MDAzMA0KPiAgI2RlZmluZSBESVNQX0FBTF9T
SVpFX0hTSVpFCQkJCUdFTk1BU0soMjgsIDE2KQ0KPiAgI2RlZmluZSBESVNQX0FBTF9TSVpFX1ZT
SVpFCQkJCUdFTk1BU0soMTIsIDApDQo+ICAjZGVmaW5lIERJU1BfQUFMX09VVFBVVF9TSVpFCQkJ
MHgwNGQ4DQo+ICsjZGVmaW5lIERJU1BfQUFMX0dBTU1BX0xVVAkJCTB4MDcwMA0KPiArI2RlZmlu
ZSBESVNQX0FBTF9HQU1NQV9MVVRfUgkJCQlHRU5NQVNLKDI5LCAyMCkNCj4gKyNkZWZpbmUgRElT
UF9BQUxfR0FNTUFfTFVUX0cJCQkJR0VOTUFTSygxOSwgMTApDQo+ICsjZGVmaW5lIERJU1BfQUFM
X0dBTU1BX0xVVF9CCQkJCUdFTk1BU0soOSwgMCkNCj4gKyNkZWZpbmUgRElTUF9BQUxfTFVUX0JJ
VFMJCQkxMA0KPiAgI2RlZmluZSBESVNQX0FBTF9MVVRfU0laRQkJCTUxMg0KPiAgDQo+ICBzdHJ1
Y3QgbXRrX2Rpc3BfYWFsX2RhdGEgew0KPiBAQCAtODUsOSArOTMsMzYgQEAgdW5zaWduZWQgaW50
IG10a19hYWxfZ2FtbWFfZ2V0X2x1dF9zaXplKHN0cnVjdA0KPiBkZXZpY2UgKmRldikNCj4gIHZv
aWQgbXRrX2FhbF9nYW1tYV9zZXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX2NydGNf
c3RhdGUNCj4gKnN0YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBtdGtfZGlzcF9hYWwgKmFhbCA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArCXN0cnVjdCBkcm1fY29sb3JfbHV0ICpsdXQ7DQo+ICsJ
dW5zaWduZWQgaW50IGk7DQo+ICsJdTMyIGNmZ192YWw7DQo+ICsNCj4gKwkvKiBJZiBnYW1tYSBp
cyBub3Qgc3VwcG9ydGVkIGluIEFBTCwgZ28gb3V0IGltbWVkaWF0ZWx5ICovDQo+ICsJaWYgKCEo
YWFsLT5kYXRhICYmIGFhbC0+ZGF0YS0+aGFzX2dhbW1hKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+
ICsJLyogQWxzbywgaWYgdGhlcmUncyBubyBnYW1tYSBsdXQgdGhlcmUncyBub3RoaW5nIHRvIGRv
IGhlcmUuICovDQo+ICsJaWYgKCFzdGF0ZS0+Z2FtbWFfbHV0KQ0KPiArCQlyZXR1cm47DQo+ICsN
Cj4gKwljZmdfdmFsID0gcmVhZGwoYWFsLT5yZWdzICsgRElTUF9BQUxfQ0ZHKTsNCj4gKwlsdXQg
PSAoc3RydWN0IGRybV9jb2xvcl9sdXQgKilzdGF0ZS0+Z2FtbWFfbHV0LT5kYXRhOw0KPiArDQo+
ICsJZm9yIChpID0gMDsgaSA8IERJU1BfQUFMX0xVVF9TSVpFOyBpKyspIHsNCj4gKwkJc3RydWN0
IGRybV9jb2xvcl9sdXQgaHdsdXQgPSB7DQo+ICsJCQkucmVkID0gZHJtX2NvbG9yX2x1dF9leHRy
YWN0KGx1dFtpXS5yZWQsDQo+IERJU1BfQUFMX0xVVF9CSVRTKSwNCj4gKwkJCS5ncmVlbiA9IGRy
bV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0uZ3JlZW4sDQo+IERJU1BfQUFMX0xVVF9CSVRTKSwN
Cj4gKwkJCS5ibHVlID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5ibHVlLA0KPiBESVNQ
X0FBTF9MVVRfQklUUykNCj4gKwkJfTsNCj4gKwkJdTMyIHdvcmQ7DQo+ICsNCj4gKwkJd29yZCA9
IEZJRUxEX1BSRVAoRElTUF9BQUxfR0FNTUFfTFVUX1IsIGh3bHV0LnJlZCk7DQo+ICsJCXdvcmQg
fD0gRklFTERfUFJFUChESVNQX0FBTF9HQU1NQV9MVVRfRywgaHdsdXQuZ3JlZW4pOw0KPiArCQl3
b3JkIHw9IEZJRUxEX1BSRVAoRElTUF9BQUxfR0FNTUFfTFVUX0IsIGh3bHV0LmJsdWUpOw0KPiAr
CQl3cml0ZWwod29yZCwgKGFhbC0+cmVncyArIERJU1BfQUFMX0dBTU1BX0xVVCkgKyAoaSAqDQo+
IDQpKTsNCg0KVGhpcyBjb3VsZCBiZSBtb3JlIHNpbXBsZToNCg0Kd3JpdGVsKHdvcmQsIGFhbC0+
cmVncyArIERJU1BfQUFMX0dBTU1BX0xVVCArIGkgKiA0KTsNCg0KUmVnYXJkcywNCkNLDQoNCj4g
Kwl9DQo+ICANCj4gLQlpZiAoYWFsLT5kYXRhICYmIGFhbC0+ZGF0YS0+aGFzX2dhbW1hKQ0KPiAt
CQltdGtfZ2FtbWFfc2V0X2NvbW1vbihOVUxMLCBhYWwtPnJlZ3MsIHN0YXRlKTsNCj4gKwl3cml0
ZWwoY2ZnX3ZhbCwgYWFsLT5yZWdzICsgRElTUF9BQUxfQ0ZHKTsNCj4gIH0NCj4gIA0KPiAgdm9p
ZCBtdGtfYWFsX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCBjYTM3NzI2NWU1ZWIuLjU0ZDM3MTJlMmFm
ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5o
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBAQCAt
NTYsNyArNTYsNiBAQCB2b2lkIG10a19nYW1tYV9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1
bnNpZ25lZA0KPiBpbnQgdywNCj4gIAkJICAgICAgdW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNt
ZHFfcGt0ICpjbWRxX3BrdCk7DQo+ICB1bnNpZ25lZCBpbnQgbXRrX2dhbW1hX2dldF9sdXRfc2l6
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBtdGtfZ2FtbWFfc2V0KHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlDQo+ICpzdGF0ZSk7DQo+IC12b2lkIG10a19n
YW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCBfX2lvbWVtICpyZWdzLA0K
PiBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKTsNCj4gIHZvaWQgbXRrX2dhbW1hX3N0YXJ0
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19nYW1tYV9zdG9wKHN0cnVjdCBkZXZp
Y2UgKmRldik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dh
bW1hLmMNCj4gaW5kZXggZWE5MWQzNjE5NzE2Li4wMDFiOTg2OTQ3NjEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IEBAIC03Myw0MiArNzMsMjkg
QEAgdW5zaWduZWQgaW50IG10a19nYW1tYV9nZXRfbHV0X3NpemUoc3RydWN0IGRldmljZQ0KPiAq
ZGV2KQ0KPiAgCXJldHVybiBMVVRfU0laRV9ERUZBVUxUOw0KPiAgfQ0KPiAgDQo+IC12b2lkIG10
a19nYW1tYV9zZXRfY29tbW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCBfX2lvbWVtICpyZWdz
LA0KPiBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKnN0YXRlKQ0KPiArdm9pZCBtdGtfZ2FtbWFfc2V0
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gIHsN
Cj4gLQlzdHJ1Y3QgbXRrX2Rpc3BfZ2FtbWEgKmdhbW1hOw0KPiArCXN0cnVjdCBtdGtfZGlzcF9n
YW1tYSAqZ2FtbWEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIAl1bnNpZ25lZCBpbnQgaTsN
Cj4gIAlzdHJ1Y3QgZHJtX2NvbG9yX2x1dCAqbHV0Ow0KPiAgCXZvaWQgX19pb21lbSAqbHV0X2Jh
c2U7DQo+IC0JYm9vbCBsdXRfZGlmZjsNCj4gLQl1MTYgbHV0X3NpemU7DQo+ICAJdTMyIGNmZ192
YWwsIHdvcmQ7DQo+ICANCj4gIAkvKiBJZiB0aGVyZSdzIG5vIGdhbW1hIGx1dCB0aGVyZSdzIG5v
dGhpbmcgdG8gZG8gaGVyZS4gKi8NCj4gIAlpZiAoIXN0YXRlLT5nYW1tYV9sdXQpDQo+ICAJCXJl
dHVybjsNCj4gIA0KPiAtCS8qIElmIHdlJ3JlIGNhbGxlZCBmcm9tIEFBTCwgZGV2IGlzIE5VTEwg
Ki8NCj4gLQlnYW1tYSA9IGRldiA/IGRldl9nZXRfZHJ2ZGF0YShkZXYpIDogTlVMTDsNCj4gLQ0K
PiAtCWlmIChnYW1tYSAmJiBnYW1tYS0+ZGF0YSkgew0KPiAtCQlsdXRfZGlmZiA9IGdhbW1hLT5k
YXRhLT5sdXRfZGlmZjsNCj4gLQkJbHV0X3NpemUgPSBnYW1tYS0+ZGF0YS0+bHV0X3NpemU7DQo+
IC0JfSBlbHNlIHsNCj4gLQkJbHV0X2RpZmYgPSBmYWxzZTsNCj4gLQkJbHV0X3NpemUgPSBMVVRf
U0laRV9ERUZBVUxUOw0KPiAtCX0NCj4gLQ0KPiAtCWNmZ192YWwgPSByZWFkbChyZWdzICsgRElT
UF9HQU1NQV9DRkcpOw0KPiAtCWx1dF9iYXNlID0gcmVncyArIERJU1BfR0FNTUFfTFVUOw0KPiAr
CWNmZ192YWwgPSByZWFkbChnYW1tYS0+cmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gKwlsdXRf
YmFzZSA9IGdhbW1hLT5yZWdzICsgRElTUF9HQU1NQV9MVVQ7DQo+ICAJbHV0ID0gKHN0cnVjdCBk
cm1fY29sb3JfbHV0ICopc3RhdGUtPmdhbW1hX2x1dC0+ZGF0YTsNCj4gLQlmb3IgKGkgPSAwOyBp
IDwgbHV0X3NpemU7IGkrKykgew0KPiArCWZvciAoaSA9IDA7IGkgPCBnYW1tYS0+ZGF0YS0+bHV0
X3NpemU7IGkrKykgew0KPiAgCQlzdHJ1Y3QgZHJtX2NvbG9yX2x1dCBkaWZmLCBod2x1dDsNCj4g
IA0KPiAgCQlod2x1dC5yZWQgPSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLnJlZCwNCj4g
TFVUX0JJVFNfREVGQVVMVCk7DQo+ICAJCWh3bHV0LmdyZWVuID0gZHJtX2NvbG9yX2x1dF9leHRy
YWN0KGx1dFtpXS5ncmVlbiwNCj4gTFVUX0JJVFNfREVGQVVMVCk7DQo+ICAJCWh3bHV0LmJsdWUg
PSBkcm1fY29sb3JfbHV0X2V4dHJhY3QobHV0W2ldLmJsdWUsDQo+IExVVF9CSVRTX0RFRkFVTFQp
Ow0KPiAgDQo+IC0JCWlmICghbHV0X2RpZmYgfHwgKGkgJSAyID09IDApKSB7DQo+ICsJCWlmICgh
Z2FtbWEtPmRhdGEtPmx1dF9kaWZmIHx8IChpICUgMiA9PSAwKSkgew0KPiAgCQkJd29yZCA9IEZJ
RUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfUiwNCj4gaHdsdXQucmVkKTsNCj4gIAkJCXdv
cmQgfD0gRklFTERfUFJFUChESVNQX0dBTU1BX0xVVF8xMEJJVF9HLA0KPiBod2x1dC5ncmVlbik7
DQo+ICAJCQl3b3JkIHw9IEZJRUxEX1BSRVAoRElTUF9HQU1NQV9MVVRfMTBCSVRfQiwNCj4gaHds
dXQuYmx1ZSk7DQo+IEBAIC0xMzIsMTQgKzExOSw3IEBAIHZvaWQgbXRrX2dhbW1hX3NldF9jb21t
b24oc3RydWN0IGRldmljZSAqZGV2LA0KPiB2b2lkIF9faW9tZW0gKnJlZ3MsIHN0cnVjdCBkcm1f
Y3J0DQo+ICAJLyogRW5hYmxlIHRoZSBnYW1tYSB0YWJsZSAqLw0KPiAgCWNmZ192YWwgfD0gRklF
TERfUFJFUChHQU1NQV9MVVRfRU4sIDEpOw0KPiAgDQo+IC0Jd3JpdGVsKGNmZ192YWwsIHJlZ3Mg
KyBESVNQX0dBTU1BX0NGRyk7DQo+IC19DQo+IC0NCj4gLXZvaWQgbXRrX2dhbW1hX3NldChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqc3RhdGUpDQo+IC17DQo+IC0J
c3RydWN0IG10a19kaXNwX2dhbW1hICpnYW1tYSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAt
DQo+IC0JbXRrX2dhbW1hX3NldF9jb21tb24oZGV2LCBnYW1tYS0+cmVncywgc3RhdGUpOw0KPiAr
CXdyaXRlbChjZmdfdmFsLCBnYW1tYS0+cmVncyArIERJU1BfR0FNTUFfQ0ZHKTsNCj4gIH0NCj4g
IA0KPiAgdm9pZCBtdGtfZ2FtbWFfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQg
aW50IHcsDQo=
