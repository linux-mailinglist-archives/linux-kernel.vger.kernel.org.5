Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3963C7C65D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377241AbjJLGqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjJLGqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:46:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E0190
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:46:10 -0700 (PDT)
X-UUID: 0229ce7868cb11ee8051498923ad61e6-20231012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=b5CU+Nxu2QFpRcL4HXcoQg3+jqiiaiFS4aeL73lFJTs=;
        b=GW0Sj+nVvUV/HwFyGJUGrz8E3NIs0RTlafyDCtGHlMamJLlUKgVQHVLfOtaE9U7PiLjUoAqrgAdYvgIPe07/8MuVOhh7prPso0yfs4L/Vugsa9mDna3sJY984ISon6wSaef1DtOarQN6NyPEZaKcSZtF/RAZHGInChJthS8i3Vs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:9876b4de-629a-4f2f-a388-298ff2d9fb84,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:e0d6b3f0-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0229ce7868cb11ee8051498923ad61e6-20231012
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 73866523; Thu, 12 Oct 2023 14:46:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 12 Oct 2023 14:46:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 12 Oct 2023 14:46:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gP0PKeRqTbwAmp635InUYmsi0a1PU++3jFCt5p+8+zcxReQ4IGIl8h7YvwiYFoTSlY4wJwpM88S5TDugMy0XJI5bjIDlT5ZKfRNfXLRAo1ovhZfhZlzO+AId0CXDm5wDBIpi16DxEmYcX1de8sgs/wCYScx7VLdKAtd7MBkAfbbT8MXhmLPeF9uAQjOJ2no/qBDR5qnqqir0lcCfB3GA0lExjAqtE9y2V/4EqYiVY/0q4n3t2DLnOEIXaXtQ2HKluuB8e7ZC5/fmPZzrkcwozxJvW2N3QakWld2b54koKqs1DIyereZcyPTkrFyQZfVFOyRNAX7zkRg2iJQ+HbGNHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5CU+Nxu2QFpRcL4HXcoQg3+jqiiaiFS4aeL73lFJTs=;
 b=Beqb72Yt3PRxYiqtZ9Brsve8j5H+U9sjGwhL37lEPUrwOh2bBIOxk5uXjzNwcBAc0yCPxfQ5FoP84GRT+QdQBNemsI5opvShjfBl/cGXIzycHqDqoj1/jTW+2imeFaj4tGkSIQPgRmXaFw4qwlZ9TMOyHQzJdcxgUbes7iQyLvgM2nGlvYrpLXoYz4jIWPBTsie1fARS5spo1wuhGWsV7UJq7hmVbg1lU49yRoy8ceqMmV/Kox30B3Jwz5/IQRbMX1iBaiGkb6zufgjWTNn4zy7cWaI6QrtTSxwb05tHCxLs4PDpcpsVGNN1hggHcqE1J4QUNJP/GJnFY1qGV2mXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5CU+Nxu2QFpRcL4HXcoQg3+jqiiaiFS4aeL73lFJTs=;
 b=jdYgSh54mxojhKHbVBRwV967VUw3NiuVvF67gFh6ln8wiCPj063ptzN8XMbg4i+1kozhbGVI8nrb8p6XWouFdOyUEtBdQRKbFOiHjYRl+0guDZ+TWLK7cMmc5yZpBjMh5uyiCyVa2j54w1vTnFR6jKE+qg4GtxdawghMOk2rBVY=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7271.apcprd03.prod.outlook.com (2603:1096:101:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Thu, 12 Oct
 2023 06:45:56 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%7]) with mapi id 15.20.6863.041; Thu, 12 Oct 2023
 06:45:56 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
Subject: Re: [PATCH v10 04/16] drm/mediatek: gamma: Improve and simplify HW
 LUT calculation
Thread-Topic: [PATCH v10 04/16] drm/mediatek: gamma: Improve and simplify HW
 LUT calculation
Thread-Index: AQHZxqWNIFqt7HhU/UmHEceVhYGjkbBGIjUA
Date:   Thu, 12 Oct 2023 06:45:56 +0000
Message-ID: <45b10d44508304e2d7dc28e6ce0aab262c4c579f.camel@mediatek.com>
References: <20230804072850.89365-1-angelogioacchino.delregno@collabora.com>
         <20230804072850.89365-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230804072850.89365-5-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7271:EE_
x-ms-office365-filtering-correlation-id: 04cd939a-4297-4a93-3e92-08dbcaeee33d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WMVd1apKUL5jZJl8BLfOvRXum01A0/kMTSdbxu2fv8eDKWzN06RtQoAjb0XgTtvJYYkxQPJAf7DZBPhXiVqTMdefol0sBkghf+FOPlH7gdt64I1aS+DZ3sLk6OrkqfKEDZ91UeJ1P1GpJp8dWWx+In3wirIy/qzn4mp82PrnJEXY6wTLetEOzQxPljsegdk/ddc5Otf7ztG5GPxHuJ4EW6rt9A2Z46226BsME84EjJ/suU7BjMPJv+5n7WExG8/YzkPnIC6w9/jEuQUGVEkxYzzrPl1SsmY4PkE4W51/l5x16A1PMLK3M29OV15VYli+be2Bl/5MP4vU0XlWvVDp6Y8BCOZKGOfl2nveflzo6GeT/LIV31fMs6NyqKCDbc7hAmEvezvWutt+7+TzYSUTZBhDKvf13t6rYkTaM8f1itAPFCl1t4zC4QQdbW+dnm7DNS3NTmcjq7QnwZpMeS5BPYS2rFEHxVwk7VlQbPGYC8ESazbiONYsNO0LHoTDRXGgjVnx7AGImNyTNcclYN8jTx+rx35qdoa3YPybLuNISdvmnA9Y9Y8odaoYlSo2J6NO1Y/mBEWlzcFsCnD1GgtWIC9P08mOC4J9w4b7OtpELTVKY2orKuutXbpIGPOH0kG/y7P52RXcyY/q6TQJwrlWC5SpqHDyOTLaPb0UcZf5Olk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66556008)(6512007)(36756003)(86362001)(38070700005)(85182001)(38100700002)(478600001)(122000001)(26005)(2906002)(66476007)(8936002)(83380400001)(6506007)(6486002)(71200400001)(2616005)(41300700001)(66946007)(5660300002)(110136005)(76116006)(7416002)(316002)(64756008)(8676002)(54906003)(4326008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhxOHhrYWpOeHNtOVRWRnVndklvTkRnQ0lqNG5vWDA4dnVkaTV3YlkzSitT?=
 =?utf-8?B?Z3paaUVrMUFXYWhBbWZXdVhCZ3Q3eHFPUWF2NU1BNEZRc3hxOVZZSXJ1emtl?=
 =?utf-8?B?RUhERzN3enpRQ0NVNUMwT1lPbmNtMjAyaWNJVjNZZGNWZTBETmJKVUdTdHN6?=
 =?utf-8?B?OWZTcTBDWDZCbVluYStFZzBndEo2YlpENFo5SnlhRWNtRTRkQ3ZlQTV3MTRU?=
 =?utf-8?B?ZjI1Z1hSYjdWSUlVWnNiZFNISit3VDhMbktoeU5uNHgvNFI4bUkrNTFCc05J?=
 =?utf-8?B?NFZ6ZEgxWndJZjAydVhOY084ZmpjYTY2bFA4bFNDNHByUzhQYjVyTWIxUTRv?=
 =?utf-8?B?c09LWTJWeldnaWc1cXZhdTZidGVEUzZPZDZpRlQrWnJDY09HWE9PNHlQc0Rv?=
 =?utf-8?B?UDdveHgzUGtKQTdoY1NRVElQM3I0ZlpKeEN2WnRYMi9mSHBZWStXaGRzRjZY?=
 =?utf-8?B?MTVEbFlEeHUzaWt2U1RiSXZ4MjFlVlNVSXNUQTVNbXM1MFI2SGwyZkkzblA2?=
 =?utf-8?B?Z2lrM0NqaldwZC8zWng0aXZaVVgyMldPRHRQakJzRWhrbW5GajJjeE9vWC9W?=
 =?utf-8?B?VkF1TERieTB2Ymx4MnBDeXNKbE1zVVpDbUZJMzFzSEZTRGxMdW4vZHhOMGFP?=
 =?utf-8?B?ZWlMSzBpdUNSQ3VpOVVrZmxzVHZqemlGVFJOS05wVGtHVVF5bk9INmE4NXBx?=
 =?utf-8?B?TmdMM09PQmVNVUlJUVFueGIyakF4aTVlYnU3ekwydkJmcHBLeUh6VTg5KzVi?=
 =?utf-8?B?ZTExUUFPK0xxeEVoTDh2VDZiOWtDdnR3UnRVT2sycW5YMUpvSGIySGlDbnFY?=
 =?utf-8?B?OFl1Mndtc3Iwc0pWWFVQQ00rQytjc1ZRTDYreFdJdWcrc1Jac21nSC9RTkV2?=
 =?utf-8?B?N0FnV0MxWTlEcXZYZFVFRGcvcUxVU2tvYkR3OVdqNi9KT0JWSitWZU9md2pt?=
 =?utf-8?B?MGxQUGt3R01JQUdSL2NYYnJUeVRBLzdZM2xvWjNWUVhmMjVzdWZ0V1REN2cr?=
 =?utf-8?B?akdRMFcyZXlyV01KN01ndHVsWE45Um56bVovNXlrVi9xUDRhdUU4bVVsZG54?=
 =?utf-8?B?UzNYakdsVVZoWVlOSnU5V3NwTHZQR0dkenpETnQzd3ZhRmhwMjNkZi9pd1Q0?=
 =?utf-8?B?RytTd3crN2l1aWljcWdVK2RORWphazhUcVl2QUQ1RkxvcHd4UExNL1NtSTQr?=
 =?utf-8?B?NGZFSUgyM1hSZUhsUlJpQWdRTlBESzE1eU9vdlNTZnhwaGJBQ3pzUVE2Y250?=
 =?utf-8?B?RXhrZTFuQWtGYWFLNGYwQ080Skk0K0dkZnlJdkdRaFYreGs1d3B1eENvZlVj?=
 =?utf-8?B?dnRRSDRwVG1uMW9CdG9jdjdJSktISGMyUjFUdDZJaDIvZlhDN1dMR1NGWGdZ?=
 =?utf-8?B?NUhuM3RSdWEzT2ZhV2ZCbllMZEhZR3lvUFJGVE1Bb0toU0poYWx1UGwrKyt6?=
 =?utf-8?B?YTZWRmh6cndUQUhsSlh2Rmg0MFhMdFpTeENid2psbkpvM0pES1oydUZwZWlx?=
 =?utf-8?B?Qk93ZEF1MDh2d2xyQitwSzdOSG5kTVJiaWZlNHVtd3d1M2tvSFJWbDBZOWNE?=
 =?utf-8?B?Zm0xOGxOL1ZKc1VSR1dFc0QzWCtxQlZ4TzFjejdnOXpYRUJ0R1VzNTJTaE5I?=
 =?utf-8?B?L3pyeUpTc0lRMXpoQWxMOURCMFAya3d4eVJodGp1QktiQVdlM0xQVjBZSFJO?=
 =?utf-8?B?Mys5V0V1bG1MakZpWnVONjhKVEtKN3VsaXRSK2hUR2tLU3h3V0RHZlFWRVZ3?=
 =?utf-8?B?SXpqSFJ3SFJuamllZGdsVDJuUHloWWhMRWZ6cy81SW45MDR2bEt5dkJrMWRr?=
 =?utf-8?B?UE1qb0kzVU1GeVJKVmFtNzBZTjQrTWg4Z2NYWlh0eEZUcCt4cW5MSXRkT2VE?=
 =?utf-8?B?T01Sazc3c0NKZkVybjdYVlpDZEhFZ1h1eEVKL1cyRTI5K1JSYWpaZFJpYnRh?=
 =?utf-8?B?RDVoUk5vamsyRUNEcy9pMFFTL0NtYm15OXdKRVB4ck5lcWdkbzhkN0VJMkN6?=
 =?utf-8?B?dnZjc29Mc2FRVzBtZTc2d2F2NmpITUV4ZVRpUWF5eTZudkU2OXI5ajNEby93?=
 =?utf-8?B?dnNPcGdHUjJXWitwSGtCaE52TCs4cnJLZkcwQ0dxWHVpd0tnL0NaQ0gyL2dB?=
 =?utf-8?Q?TxknNkqRcEbmzVM+oJcQGszdj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12D1F8F9C6F6B446A5EEAF65F58B9A3E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cd939a-4297-4a93-3e92-08dbcaeee33d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 06:45:56.6272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Js2tGxW2MtWmtjWEor8QfqgvRxD+hBohcKSeFiANoS0nxJXOC68iC63a8MaQUen6nwUSQZPHlDrpz9+S+KER6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7271
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.873900-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hcNtKv7cnNXnSa1MaKuob8PC/ExpXrHizz4JyR+b5tvoHBK
        HBsAePqAMSHUAIPyvK0mNpzri1sed4vefA3PKlmsY1bQMCMvmn4RvEpVd3vS1d9RlPzeVuQQVSd
        AA6mVeIafEC+GFN7etcjVNRvJeEXU8ZTibkDR5X11e7Xbb6Im2mykBU62J7SDmyiLZetSf8n5kv
        mj69FXvKEwgORH8p/AjaPj0W1qn0SyO81X3yak81vqGET2M2aM87W0kKh+4zVGLlGxZBM2qXFCk
        NLs0QS8D32vr3fK0+R+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.873900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 8D8C139AE70BB408481D5F703297AAD93D650B2D5A3534F9BDE2D911B18BFAF42000:8
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
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gVXNlIGRybV9jb2xvcl9sdXRfZXh0cmFjdCgp
IHRvIGF2b2lkIG9wZW4tY29kaW5nIHRoZSBiaXRzIHJlZHVjdGlvbg0KPiBjYWxjdWxhdGlvbnMg
Zm9yIGVhY2ggY29sb3IgY2hhbm5lbCBhbmQgdXNlIGEgc3RydWN0IGRybV9jb2xvcl9sdXQNCj4g
dG8gdGVtcG9yYXJpbHkgc3RvcmUgdGhlIGluZm9ybWF0aW9uIGluc3RlYWQgb2YgYW4gYXJyYXkg
b2YgdTMyLg0KPiANCj4gQWxzbywgc2xpZ2h0bHkgaW1wcm92ZSB0aGUgcHJlY2lzaW9uIG9mIHRo
ZSBIVyBMVVQgY2FsY3VsYXRpb24gaW4gdGhlDQo+IExVVCBESUZGIGNhc2UgYnkgcGVyZm9ybWlu
ZyB0aGUgc3VidHJhY3Rpb25zIG9uIHRoZSAxNi1iaXRzIHZhbHVlcw0KPiBhbmQNCj4gZG9pbmcg
dGhlIDEwIGJpdHMgY29udmVyc2lvbiBsYXRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xs
YWJvcmEuY29tPg0KPiBSZXZpZXdlZC1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVk
aWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJh
eWxpYnJlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
Z2FtbWEuYyB8IDMwICsrKysrKysrKysrKysrKy0tLS0NCj4gLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9nYW1tYS5jDQo+IGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX2dhbW1hLmMNCj4gaW5kZXggNzU3NTIzNzYyNWQyLi5m
ZDZhNzVhNjRhOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9nYW1tYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9n
YW1tYS5jDQo+IEBAIC03NCw3ICs3NCw2IEBAIHZvaWQgbXRrX2dhbW1hX3NldF9jb21tb24oc3Ry
dWN0IGRldmljZSAqZGV2LCB2b2lkDQo+IF9faW9tZW0gKnJlZ3MsIHN0cnVjdCBkcm1fY3J0DQo+
ICAJYm9vbCBsdXRfZGlmZjsNCj4gIAl1MTYgbHV0X3NpemU7DQo+ICAJdTMyIHdvcmQ7DQo+IC0J
dTMyIGRpZmZbM10gPSB7MH07DQo+ICANCj4gIAkvKiBJZiB0aGVyZSdzIG5vIGdhbW1hIGx1dCB0
aGVyZSdzIG5vdGhpbmcgdG8gZG8gaGVyZS4gKi8NCj4gIAlpZiAoIXN0YXRlLT5nYW1tYV9sdXQp
DQo+IEBAIC05NywxOCArOTYsMjkgQEAgdm9pZCBtdGtfZ2FtbWFfc2V0X2NvbW1vbihzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+IHZvaWQgX19pb21lbSAqcmVncywgc3RydWN0IGRybV9jcnQNCj4gIAls
dXRfYmFzZSA9IHJlZ3MgKyBESVNQX0dBTU1BX0xVVDsNCj4gIAlsdXQgPSAoc3RydWN0IGRybV9j
b2xvcl9sdXQgKilzdGF0ZS0+Z2FtbWFfbHV0LT5kYXRhOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBs
dXRfc2l6ZTsgaSsrKSB7DQo+ICsJCXN0cnVjdCBkcm1fY29sb3JfbHV0IGRpZmYsIGh3bHV0Ow0K
PiArDQo+ICsJCWh3bHV0LnJlZCA9IGRybV9jb2xvcl9sdXRfZXh0cmFjdChsdXRbaV0ucmVkLCAx
MCk7DQo+ICsJCWh3bHV0LmdyZWVuID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5ncmVl
biwgMTApOw0KPiArCQlod2x1dC5ibHVlID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGx1dFtpXS5i
bHVlLCAxMCk7DQo+ICsNCj4gIAkJaWYgKCFsdXRfZGlmZiB8fCAoaSAlIDIgPT0gMCkpIHsNCj4g
LQkJCXdvcmQgPSAoKChsdXRbaV0ucmVkID4+IDYpICYgTFVUXzEwQklUX01BU0spIDw8DQo+IDIw
KSArDQoNCkFmdGVyIHJlbW92aW5nIGRlZmluaXRpb24gb2YgTFVUXzEwQklUX01BU0ssDQoNClJl
dmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IC0JCQkJKCgobHV0W2ld
LmdyZWVuID4+IDYpICYgTFVUXzEwQklUX01BU0spDQo+IDw8IDEwKSArDQo+IC0JCQkJKChsdXRb
aV0uYmx1ZSA+PiA2KSAmIExVVF8xMEJJVF9NQVNLKTsNCj4gKwkJCXdvcmQgPSBod2x1dC5yZWQg
PDwgMjAgKw0KPiArCQkJICAgICAgIGh3bHV0LmdyZWVuIDw8IDEwICsNCj4gKwkJCSAgICAgICBo
d2x1dC5yZWQ7DQo+ICAJCX0gZWxzZSB7DQo+IC0JCQlkaWZmWzBdID0gKGx1dFtpXS5yZWQgPj4g
NikgLSAobHV0W2kgLSAxXS5yZWQNCj4gPj4gNik7DQo+IC0JCQlkaWZmWzFdID0gKGx1dFtpXS5n
cmVlbiA+PiA2KSAtIChsdXRbaSAtDQo+IDFdLmdyZWVuID4+IDYpOw0KPiAtCQkJZGlmZlsyXSA9
IChsdXRbaV0uYmx1ZSA+PiA2KSAtIChsdXRbaSAtIDFdLmJsdWUNCj4gPj4gNik7DQo+ICsJCQlk
aWZmLnJlZCA9IGx1dFtpXS5yZWQgLSBsdXRbaSAtIDFdLnJlZDsNCj4gKwkJCWRpZmYucmVkID0g
ZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYucmVkLCAxMCk7DQo+ICsNCj4gKwkJCWRpZmYuZ3Jl
ZW4gPSBsdXRbaV0uZ3JlZW4gLSBsdXRbaSAtIDFdLmdyZWVuOw0KPiArCQkJZGlmZi5ncmVlbiA9
IGRybV9jb2xvcl9sdXRfZXh0cmFjdChkaWZmLmdyZWVuLA0KPiAxMCk7DQo+ICsNCj4gKwkJCWRp
ZmYuYmx1ZSA9IGx1dFtpXS5ibHVlIC0gbHV0W2kgLSAxXS5ibHVlOw0KPiArCQkJZGlmZi5ibHVl
ID0gZHJtX2NvbG9yX2x1dF9leHRyYWN0KGRpZmYuYmx1ZSwNCj4gMTApOw0KPiAgDQo+IC0JCQl3
b3JkID0gKChkaWZmWzBdICYgTFVUXzEwQklUX01BU0spIDw8IDIwKSArDQo+IC0JCQkJKChkaWZm
WzFdICYgTFVUXzEwQklUX01BU0spIDw8IDEwKSArDQo+IC0JCQkJKGRpZmZbMl0gJiBMVVRfMTBC
SVRfTUFTSyk7DQo+ICsJCQl3b3JkID0gZGlmZi5ibHVlIDw8IDIwICsNCj4gKwkJCSAgICAgICBk
aWZmLmdyZWVuIDw8IDEwICsNCj4gKwkJCSAgICAgICBkaWZmLnJlZDsNCj4gIAkJfQ0KPiAgCQl3
cml0ZWwod29yZCwgKGx1dF9iYXNlICsgaSAqIDQpKTsNCj4gIAl9DQo=
