Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8477F246E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjKUC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjKUC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:57:45 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1951EC4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:57:34 -0800 (PST)
X-UUID: b310ee52881911ee8051498923ad61e6-20231121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=cWJnY0DBnOW1AQvRCgZGyCzb6694+zTgdk8+/ueyC6Q=;
        b=uLkpTCvKNbYl8prK48tjnDu/eIFvKXyP7jWjd4EmeAVYgqRDRSL7FhP2QibsCV4x8a/CjJ//QuEP9R1ulymNJVrP6ZC7rTabVUgRCMxgGo+ATWNytCPGsE5GfeUjOlJpOnmdLeQjpjWPf01MNKLosQvDg7UlKHV5lfvVGwaAlMo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:196a21b3-fbea-421b-a7b0-367a06ab7f97,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:7e7fe172-1bd3-4f48-b671-ada88705968c,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b310ee52881911ee8051498923ad61e6-20231121
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 784585409; Tue, 21 Nov 2023 10:57:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 21 Nov 2023 10:57:23 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 21 Nov 2023 10:57:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV+g/ynL9aAb/rx7gQPq2ttqmcgEJ3IpDMgAbOA7g5URtEwgkenodg32y7S52G5BcuSbo1kRAWjYf0gF1MM+WI4Yymg6gf8EPHoFey6StI2Id5TR9j/xTSYPNDjAmA1djxIbe6Xp5JagKNZACm7wuHKrj62QAKcQJxX74BL4ySmejzYK7JCGjyJM4FkmM6r/vhaw8mlel6aNlXPi0OIAeJ4NQc0KkQCybGGgWbAZjCXjGToj7I4X4LlONEccdMKGaSFdRWcNfM07nmxrryn6dgwvhHy8wT6yKrX2705fceU2tflrxxR7ls9lV/ZQ5xeH2cXkI5sYe9ZyiAHZt8bfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWJnY0DBnOW1AQvRCgZGyCzb6694+zTgdk8+/ueyC6Q=;
 b=g0f67GP2vZsLrKaJZtpIAZAvb3YakD4kWBQkEHn0QE4XH4MMQInpn5ei/tB6dhqs4Cg+9y1kK8PhTIubfBixqQ+7jXCl79yiJnTF+Eq1uotZelKHHVp43LMWGh+GlgeuyH5qUfHI8dCZNBfq1s52yTo1wOB9n9F+annRO99mk+5RDxwzkNdIXUIUchheKm0z1Q0UJyDdxeNewaw9pC0YIh+npX9EbWzhghUOPmBn4UCennqniGpe8fWr331LExfRInAwrGGnRwJ9IEKMtnzjZa/eergPYHuqn03hnHxWX19aEtm5HQTwC/QeJSD7mR0zNeY29WJMv17FKQBQbmB0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWJnY0DBnOW1AQvRCgZGyCzb6694+zTgdk8+/ueyC6Q=;
 b=it9uvhn6rvnoLq+RuwDn3CG4/lmciHYl2FE+IaMIoecpnhOgiMKZ6OD1ijCFSNlQ6sH3GRBSXovOQhLLfYk6DBo/uxL75IeKAYbFn3lKZLAJWq6+32Ig0VW7+qrF6o8UeNssELZc2XIKvYnYzRmSnO+VYYyap0kjkrxm1lvdNNs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB5530.apcprd03.prod.outlook.com (2603:1096:4:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 02:57:21 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::a4e1:1557:a3fe:c252%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 02:57:21 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v3 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHaG4D7vF3iXoWQyEOF1sh2wbJQoLCEFeEA
Date:   Tue, 21 Nov 2023 02:57:21 +0000
Message-ID: <e7316d95958f9628186e8768f10f691657ea77a1.camel@mediatek.com>
References: <20231120071246.30823-1-shawn.sung@mediatek.com>
         <20231120071246.30823-2-shawn.sung@mediatek.com>
In-Reply-To: <20231120071246.30823-2-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB5530:EE_
x-ms-office365-filtering-correlation-id: 9e987cc2-a230-46c2-a721-08dbea3d94c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uwq9ESmk5f1MELIdzC6W/sYhHGEhE3g/ZOxzqqlM/y1lJSQgEpnliEC4vCfI7kGeY2naXcB5FTObEb4DIC7KJNsn9UIlJGYqSamxLJLtPM/5hMRzqlsqm4f4+pGjEm+TIZraeoHGCyNviEitqkgceJ7FpGRfxRaF7Sg3UjpC7suTmbX3hhVrnMnNJoZDisB3/YcPiQmrroQYcW9YfgU3LwHHYbC7IrR5Ta7qPgCHWRdkpHNDBlnWphp+DdiggS/+QAdy5TcibyemF2HMbDgFOBuGbf3XmdP9mVz0kB7IsLvgB48kuqjCtmJip7GBHQHkUaWHHc6HU2ArTRy8U+AYv4K+GD4+Rm7RUiN793SXOb7WiPVysQzWxF1gDgSn6qSng9Rth7Pvo/4KgLVFLXaVmNCcj+mBDd+bBQzk7MKMSQpPG22wMM/BFW+60Pm+qVEGa/6HYwfgOaP/JyYU+2ie2IKX0soLjGtvvJ4J7b+CIpvXOKA8oF7C6VIL8u243itgAFcgxiZbrRR5WzrUMWHTBSNCXLxqFHse2u2YxW3DbS4ezqAEiuriyJ8r7+bWOFXxNz5I874HoTrYEmaVloVNxqGz1pxvcegPWpLGlxz30rO8JU9/nDFTc8BR1J644jIX7xB3QJBw+KLK8LAXVsFutuy0VaIEr9c6/c+AKuCP6h8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(122000001)(71200400001)(83380400001)(38100700002)(2616005)(6506007)(6512007)(7416002)(8676002)(4001150100001)(2906002)(41300700001)(5660300002)(8936002)(36756003)(85182001)(4326008)(86362001)(66946007)(66446008)(64756008)(54906003)(66556008)(110136005)(66476007)(76116006)(316002)(38070700009)(26005)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aktPeW5obEY4YVUyS3pjRWpib0ZnRlp6eGtFVzF5RG56bkxGMytqWkQ1S1kx?=
 =?utf-8?B?ZFZSdUhKTldadmxDSWRDU213YkZoY01ZMFZET1BGenI0WHV1N1drN1NEUk1Q?=
 =?utf-8?B?QVlQT0VSNTFqem9KRFM1bVQ0bnVWb25YUUlMb3orNzhINE5GSzRJQlJoMk1L?=
 =?utf-8?B?Y3plWEh2Z2pLbHpyU3c0Z2ZBUGFMVE1pNXhmcWZmSUMzSmMyQWJWRjVaN1pB?=
 =?utf-8?B?VlZUQTFJVlo3TzdOOHlNUytmL05PbGpvcVovSWg3NmJyR3VYL2tXUlhKbVNY?=
 =?utf-8?B?SGxaZmtwZ1NnS1lQZXBvTzJJY3c0TTJxTjFNRGpEaEY1cXYwNk1OY3BDQkJv?=
 =?utf-8?B?OUlNK1FrNituWU96TlJ2dXNsTnlkNExrNGdHSlZoR3d2a2E3WG9GdzJ5Lzk5?=
 =?utf-8?B?VG0yd01uYWNoNmxHY25qSU0wQ1VxMDlTQXFWYlZPbXIvb2I1WXJTNGpzRVRm?=
 =?utf-8?B?R3ZEb3N0OW5yUDBZMUpDL0hwbmdWM2IrZWpXOWZxaWh0V1YzVzdyTkExelRi?=
 =?utf-8?B?TWh1U2REc1dwODl5aWV0aXVHTmRWeWZ0T2hJOHZmZWxqdXpQQkFnbjZ6NTZq?=
 =?utf-8?B?V094aWZiamtGdWRYbjhZdUliSmZQMENpdmNKV2lUdUFKQlBLSFZHNEM2dXpP?=
 =?utf-8?B?VnlzUG5qYzFKZHg1a2RaZlN6RWxtVEZaUlU4RmJGZDdueEFmQUlBYnhGNWky?=
 =?utf-8?B?Qk9WWU95Vk1NNkwwdXdHcTBRYnJLZGtIODZHMFFFMko2WkdlaEZISVZXNWQv?=
 =?utf-8?B?QUNjVGhEYW1MeWxIb2l1R2ZpUy90WkNDVTJ2aVdZMmcrTXp6bmloTHZIQXQy?=
 =?utf-8?B?TFVBMW1wL2NmZkxtbGl6Qno3bEcrTkhjQ2NNU2dhTmR3OE9Ic1NOY1dRT0NG?=
 =?utf-8?B?YlJsYjBCVnMrZUFDbmF6dDR3cXN5bEkrZkdvVWxhNldoaHJZcHdkSmdySkNw?=
 =?utf-8?B?Wmx0cEllZjVXT2tvUWwvTGhyakdtYmgxRS9ub2J0OHdnMzVyUWRnQkhaVC9o?=
 =?utf-8?B?VjYzcm00b2RIU3Q5bjNtSHlyQTlOWVpJQXd0OTlrbW5oVUYvNXo2NitSNk1Y?=
 =?utf-8?B?dVl4Sk1vVFNJS1VQN3lqMHU2bHFpeCtmdm95NEV6Nk84ZGVFMTV5Q2JDeThD?=
 =?utf-8?B?UEE2OUFyMDcyL1Z3TzZCbDJ2MkFnc00rMVJ4K0l6NCttM2hOZ25DekdodVhv?=
 =?utf-8?B?TENZZndCNDZpNkIyQXlVZU8xSjFZajFIQ2hCYW1BMkl5RmdZdjcrVXBjT3dy?=
 =?utf-8?B?MHhaUGd3bGtuTzJmKzlRS09KNkxVSXhNNkRZUGVnL0xGWTBjMVJoVHAvc092?=
 =?utf-8?B?c0JaWTIxa0VZNXc4WkovcDh6a3RXTVpNMmJtM0t1K25ENUJUbHBCTnZGcEdu?=
 =?utf-8?B?NWVsUS9CcVdobmdoMS9ORDQ5ZC9ORlk5Mm42bUpNaEpMWnkyNXJZVDQzc0Mz?=
 =?utf-8?B?VHk4MWFHWFJ3TDJkeTNzZ3ZYWEd4S0NZWWNwb1NpcUFDNVlMMmVLb2wwTklw?=
 =?utf-8?B?NEkvYnBSQjlONEdVU2dBWDZrZEFnN1ZOT2wxM3FaOVRrWHNiNEo3K1lpTnpx?=
 =?utf-8?B?bkJFb3piby93djk0aWozOEJIZ0txVTlTd2xNakFKMURYb3lnVWZ4cTQ1L20z?=
 =?utf-8?B?V0xyRm55Mm9OM0JOV2N3ZE10WFJlQTZlVm04aldyNzVtL29LOU1oeUxSRXk5?=
 =?utf-8?B?STdkMTNlQmxtMDlQMGh5YnhZbDIwbDRCMlN4NmtqU0tTVTNMYmxHbVdMbEhj?=
 =?utf-8?B?SVdIMWI1dkw4QVZVMUFoVlBIZlJKZUtjYlJ4Nk5JZHZ6cWh5RlJRZGFXeWwv?=
 =?utf-8?B?UzAxVXlNVHkyb3Z4MUFNeGNYbEFSLysycDhuZ09oMXlqODVFNTFMR2V3TEEw?=
 =?utf-8?B?c2pkNTVCTWNtWkFqTTE0MlRDbXJFUmYxc2hqc2ExMVJxUDVSQ2tWOW9Wemsv?=
 =?utf-8?B?WDVQM1Jmczd4dGJ5S1dWeXV6SjV5N3NiNDJVbFFqZURQc00vVXV6UDBiVW02?=
 =?utf-8?B?Umwxb0dZY0tOWWJldUVXQitlMDFnSXJla0ZqckNFZ2VLN2E4VzlxWXNXeU9s?=
 =?utf-8?B?aUpDWUxYYzJEdzVwNTFXSlM1ZXBMMVVxa2x4ZVlYWVJtTmJJMzBERW1Oa29B?=
 =?utf-8?Q?0lxRLDhR9RmiGO10eTpm0Ky3X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AABA99923AF28547857A02BDE0EC891C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e987cc2-a230-46c2-a721-08dbea3d94c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 02:57:21.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jqFxYJn9mGkm/HV01KjrVho3HgF3iN12nTjke1odpepGS5OIDRy9oDfKWMh1aHZeg72sfsJQutaCM3SRf4AYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5530
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.534400-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0/XHdICuW5r97SWiiWSV/1jLOy13Cgb4+qvcIF1TcLYOoH
        78fyjH+uZYRfClLq1u6k0VYTefV9UEMN6I0Tm14dT7jCYv2QJPFzd7C7BtJobv96+aVV/3FmpSh
        LJWs0HZyjmrD+IUq29ogmzRSnu+RYg83Zr5OBrdIVglQa/gMvfJnaxzJFBx6vIj0lCwYGw2/UW+
        DoTRTq/7j73R2aT5mj7c2dg3HqZ1gobEkwGN/CVbEKX02srTXIh+w9Wz/xXDoJ5zM3dzkaQcYfu
        DbxC24g07yNIWvXe9qn2r1luyXo5rvaJG+XDhc25Rvu7Ivm8959LQinZ4QefKU8D0b0qFy9suf7
        RWbvUtyrusVRy4an8SAHAopEd76vcrlnQ+5pRrog53baGqz/9a2GKTATxCGx7fTH+1+sablALcP
        TpC/Cwg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.534400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 051FAB5D9A40AD3524088FD648C525270F30FB35B81987A6A0F39E809E8C68452000:8
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBNb24sIDIwMjMtMTEtMjAgYXQgMTU6MTIgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IENyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eSBhY2NvcmRp
bmcgdG8gdGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkuDQo+IA0KPiBGaXhlczogODRkODA1NzUzOTgz
ICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0IHJlZmxlY3QteSBwbGFuZQ0KPiByb3RhdGlvbiIpDQoN
CkluIFNlYW4gUGF1bCdzIHBhdGNoICh0aGUgcGF0Y2ggeW91IGZpeCksIG92bCBkcml2ZXIgb25s
eSBzdXBwb3J0DQptdDgxMjcgYW5kIG10ODE3MywgYW5kIEkgYmVsaWV2ZSB0aGF0IFNlYW4gaGFz
IHRlc3RlZCBvbiBtdDgxNzMuIEluDQp0aGlzIHBhdGNoLCBvbmx5IG10ODE5NSBvdmwgc3VwcG9y
dCByb3RhdGlvbiwgd2h5IGRvIHlvdSBkbyB0aGlzDQptb2RpZmljYXRpb24/IFBsZWFzZSBkZXNj
cmliZSB3aGljaCBTb0MgaXMgd3JvbmcgaW4gY29tbWl0IG1lc3NhZ2Ugc28gSQ0KY291bGQga25v
dyBob3cgdGhlIGNvZGUgc2hvdWxkIGJlLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9y
YS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9k
cnYuaCAgICAgICB8ICAxICsNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmwuYyAgICAgICB8IDMwICsrKysrKysrKystLS0tLS0tDQo+IC0tDQo+ICAuLi4vZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jICAgfCAgNSArKysrDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgfCAgMSArDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAgICAgfCAgMiArLQ0KPiAgNSBmaWxlcyBj
aGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gaW5kZXggNGQ2ZThiNjY3YmMzLi5j
NWFmZWI3YzU1MjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2
LmgNCj4gQEAgLTEyNyw2ICsxMjcsNyBAQCB2b2lkIG10a19vdmxfYWRhcHRvcl9yZWdpc3Rlcl92
YmxhbmtfY2Ioc3RydWN0DQo+IGRldmljZSAqZGV2LCB2b2lkICgqdmJsYW5rX2NiKSh2bw0KPiAg
dm9pZCBtdGtfb3ZsX2FkYXB0b3JfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAq
ZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2VuYWJsZV92Ymxhbmsoc3RydWN0IGRldmlj
ZSAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX2Rpc2FibGVfdmJsYW5rKHN0cnVjdCBk
ZXZpY2UgKmRldik7DQo+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9y
b3RhdGlvbnMoc3RydWN0IGRldmljZQ0KPiAqZGV2KTsNCj4gIHZvaWQgbXRrX292bF9hZGFwdG9y
X3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdG9w
KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX2xh
eWVyX25yKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggZWNjMzg5MzJmZDQ0Li4yODU5ODdjMWNjYzcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTE3Nyw2ICsx
NzcsNyBAQCBzdGF0aWMgY29uc3QgdTMyIG10ODE5NV9vdmxfY3JjX29mc1tdID0gew0KPiAgICog
QHN1cHBvcnRzX2NscmZtdF9leHQ6IHdoZXRoZXIgdGhlIG92bCBzdXBwb3J0cyBjbGVhciBmb3Jt
YXQgKGZvcg0KPiBhbHBoYSBibGVuZCkNCj4gICAqIEBjcmNfb2ZzOiBjcmMgb2Zmc2V0IHRhYmxl
DQo+ICAgKiBAY3JjX2NudDogY291bnQgb2YgY3JjIHJlZ2lzdGVycyAoY291bGQgYmUgbW9yZSB0
aGFuIG9uZSBiYW5rKQ0KPiArICogQHJvdGF0aW9uczogc3VwcG9ydGVkIHJvdGF0aW9ucw0KPiAg
ICovDQo+ICBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgew0KPiAgCXVuc2lnbmVkIGludCBhZGRy
Ow0KPiBAQCAtMTkwLDYgKzE5MSw3IEBAIHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSB7DQo+ICAJ
Ym9vbCBzdXBwb3J0c19jbHJmbXRfZXh0Ow0KPiAgCWNvbnN0IHUzMiAqY3JjX29mczsNCj4gIAlz
aXplX3QgY3JjX2NudDsNCj4gKwl1bnNpZ25lZCBpbnQgcm90YXRpb25zOw0KPiAgfTsNCj4gDQo+
ICAvKioNCj4gQEAgLTQxNSwzNSArNDE3LDI2IEBAIHVuc2lnbmVkIGludCBtdGtfb3ZsX2xheWVy
X25yKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gDQo+ICB1bnNpZ25lZCBpbnQgbXRrX292bF9z
dXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gLQlyZXR1cm4g
RFJNX01PREVfUk9UQVRFXzAgfCBEUk1fTU9ERV9ST1RBVEVfMTgwIHwNCj4gLQkgICAgICAgRFJN
X01PREVfUkVGTEVDVF9YIHwgRFJNX01PREVfUkVGTEVDVF9ZOw0KPiArCXN0cnVjdCBtdGtfZGlz
cF9vdmwgKm92bCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiArDQo+ICsJcmV0dXJuIG92bC0+
ZGF0YS0+cm90YXRpb25zID86IDA7DQo+ICB9DQo+IA0KPiAgaW50IG10a19vdmxfbGF5ZXJfY2hl
Y2soc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkJc3RydWN0IG10
a19wbGFuZV9zdGF0ZSAqbXRrX3N0YXRlKQ0KPiAgew0KPiAgCXN0cnVjdCBkcm1fcGxhbmVfc3Rh
dGUgKnN0YXRlID0gJm10a19zdGF0ZS0+YmFzZTsNCj4gLQl1bnNpZ25lZCBpbnQgcm90YXRpb24g
PSAwOw0KPiANCj4gLQlyb3RhdGlvbiA9IGRybV9yb3RhdGlvbl9zaW1wbGlmeShzdGF0ZS0+cm90
YXRpb24sDQo+IC0JCQkJCSBEUk1fTU9ERV9ST1RBVEVfMCB8DQo+IC0JCQkJCSBEUk1fTU9ERV9S
RUZMRUNUX1ggfA0KPiAtCQkJCQkgRFJNX01PREVfUkVGTEVDVF9ZKTsNCj4gLQlyb3RhdGlvbiAm
PSB+RFJNX01PREVfUk9UQVRFXzA7DQo+IC0NCj4gLQkvKiBXZSBjYW4gb25seSBkbyByZWZsZWN0
aW9uLCBub3Qgcm90YXRpb24gKi8NCj4gLQlpZiAoKHJvdGF0aW9uICYgRFJNX01PREVfUk9UQVRF
X01BU0spICE9IDApDQo+ICsJaWYgKHN0YXRlLT5yb3RhdGlvbiAmIH5tdGtfb3ZsX3N1cHBvcnRl
ZF9yb3RhdGlvbnMoZGV2KSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+IA0KPiAgCS8qDQo+ICAJ
ICogVE9ETzogUm90YXRpbmcvcmVmbGVjdGluZyBZVVYgYnVmZmVycyBpcyBub3Qgc3VwcG9ydGVk
IGF0DQo+IHRoaXMgdGltZS4NCj4gIAkgKgkgT25seSBSR0JbQVhdIHZhcmlhbnRzIGFyZSBzdXBw
b3J0ZWQuDQo+ICAJICovDQo+IC0JaWYgKHN0YXRlLT5mYi0+Zm9ybWF0LT5pc195dXYgJiYgcm90
YXRpb24gIT0gMCkNCj4gKwlpZiAoc3RhdGUtPmZiLT5mb3JtYXQtPmlzX3l1diAmJiAoc3RhdGUt
PnJvdGF0aW9uICYNCj4gfkRSTV9NT0RFX1JPVEFURV8wKSkNCj4gIAkJcmV0dXJuIC1FSU5WQUw7
DQo+IA0KPiAtCXN0YXRlLT5yb3RhdGlvbiA9IHJvdGF0aW9uOw0KPiAtDQo+ICAJcmV0dXJuIDA7
DQo+ICB9DQo+IA0KPiBAQCAtODgzLDYgKzg3NiwxNSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10
a19kaXNwX292bF9kYXRhDQo+IG10ODE5NV9vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLnN1cHBv
cnRzX2NscmZtdF9leHQgPSB0cnVlLA0KPiAgCS5jcmNfb2ZzID0gbXQ4MTk1X292bF9jcmNfb2Zz
LA0KPiAgCS5jcmNfY250ID0gQVJSQVlfU0laRShtdDgxOTVfb3ZsX2NyY19vZnMpLA0KPiArDQo+
ICsJLyoNCj4gKwkgKiBhbHRob3VnaCBPVkwgb25seSBzdXBwb3J0cyByZWZsZWN0aW9ucyBvbiBN
VDgxOTUsDQo+ICsJICogcmVmbGVjdCB4ICsgcmVmbGVjdCB5ID0gcm90YXRlIDE4MA0KPiArCSAq
Lw0KPiArCS5yb3RhdGlvbnMgPSBEUk1fTU9ERV9ST1RBVEVfMCAgIHwNCj4gKwkJICAgICBEUk1f
TU9ERV9ST1RBVEVfMTgwIHwNCj4gKwkJICAgICBEUk1fTU9ERV9SRUZMRUNUX1ggIHwNCj4gKwkJ
ICAgICBEUk1fTU9ERV9SRUZMRUNUX1ksDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3Qgb2ZfZGV2aWNlX2lkIG10a19kaXNwX292bF9kcml2ZXJfZHRfbWF0Y2hbXSA9IHsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5j
DQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4g
aW5kZXggNDM5OGRiOWE2Mjc2Li5iMGQzZWJkYmE5M2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IEBAIC0zODMsNiArMzgz
LDExIEBAIHZvaWQgbXRrX292bF9hZGFwdG9yX3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QNCj4g
ZGV2aWNlICpkZXYsIHZvaWQgKCp2YmxhbmtfY2IpKHZvDQo+ICAJCQkJICAgICB2YmxhbmtfY2Is
IHZibGFua19jYl9kYXRhKTsNCj4gIH0NCj4gDQo+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFw
dG9yX3N1cHBvcnRlZF9yb3RhdGlvbnMoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCXJl
dHVybiBEUk1fTU9ERV9ST1RBVEVfMDsNCj4gK30NCj4gKw0KPiAgdm9pZCBtdGtfb3ZsX2FkYXB0
b3JfdW5yZWdpc3Rlcl92YmxhbmtfY2Ioc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgew0KPiAgCXN0
cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAqb3ZsX2FkYXB0b3IgPQ0KPiBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29t
cC5jDQo+IGluZGV4IGZmYTQ4NjhiMTIyMi4uMjA2ZGQ2ZjZmOTllIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gQEAgLTQyMiw2ICs0MjIs
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcw0KPiBkZHBfb3ZsX2Fk
YXB0b3IgPSB7DQo+ICAJLnJlbW92ZSA9IG10a19vdmxfYWRhcHRvcl9yZW1vdmVfY29tcCwNCj4g
IAkuZ2V0X2Zvcm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X2Zvcm1hdHMsDQo+ICAJLmdldF9u
dW1fZm9ybWF0cyA9IG10a19vdmxfYWRhcHRvcl9nZXRfbnVtX2Zvcm1hdHMsDQo+ICsJLnN1cHBv
cnRlZF9yb3RhdGlvbnMgPSBtdGtfb3ZsX2FkYXB0b3Jfc3VwcG9ydGVkX3JvdGF0aW9ucywNCj4g
IH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtdGtfZGRwX2NvbXBfc3RlbVtN
VEtfRERQX0NPTVBfVFlQRV9NQVhdID0NCj4gew0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX3BsYW5lLmMNCj4gaW5kZXggZTJlYzYxYjY5NjE4Li44OTRjMzlhMzhhNTggMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBAQCAtMzQ0
LDcgKzM0NCw3IEBAIGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBz
dHJ1Y3QNCj4gZHJtX3BsYW5lICpwbGFuZSwNCj4gIAkJcmV0dXJuIGVycjsNCj4gIAl9DQo+IA0K
PiAtCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zICYgfkRSTV9NT0RFX1JPVEFURV8wKSB7DQo+ICsJ
aWYgKHN1cHBvcnRlZF9yb3RhdGlvbnMpIHsNCg0KSSB0aGluayB0aGlzIG1vZGlmaWNhdGlvbiBp
cyBub3QgbmVjZXNzYXJ5Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCQllcnIgPSBkcm1fcGxhbmVf
Y3JlYXRlX3JvdGF0aW9uX3Byb3BlcnR5KHBsYW5lLA0KPiAgCQkJCQkJCSBEUk1fTU9ERV9ST1RB
VA0KPiBFXzAsDQo+ICAJCQkJCQkJIHN1cHBvcnRlZF9yb3RhDQo+IHRpb25zKTsNCj4gLS0NCj4g
Mi4zOS4yDQo+IA0K
