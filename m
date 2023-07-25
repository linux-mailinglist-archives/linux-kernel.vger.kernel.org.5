Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B5760A68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjGYGiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjGYGiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:38:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FBA116
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:37:55 -0700 (PDT)
X-UUID: c47ec8882ab511eeb20a276fd37b9834-20230725
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=26BmddmkBuzS6P2Cz7YC08NXZSe48iPDKd3RnsBXQCQ=;
        b=JyccfQbcS/RcUznLdPXq1J9c1gloE04blHm+wUwm8y3J3Ut8XnjiRhI2hS5bVl3Rhi9IHMJb/IEej0a8TFyOQjhtuU8cevNYlt+ZbpE7UgEM3ZvJ8gn/v6tUUeX3gsPNo0nWHoWKYgiwBdzlgabjLD2jw3EnpsVwipBWsznAM+k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:8ad6f82c-af8d-49d9-a733-77a4bc90d1cd,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.29,REQID:8ad6f82c-af8d-49d9-a733-77a4bc90d1cd,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:e7562a7,CLOUDID:0fb6c1b3-a467-4aa9-9e04-f584452e3794,B
        ulkID:230724104134JUTCJ669,BulkQuantity:16,Recheck:0,SF:48|38|29|28|17|19|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:PA,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD,TF_CID_SPAM_OBB
X-UUID: c47ec8882ab511eeb20a276fd37b9834-20230725
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 386000679; Tue, 25 Jul 2023 14:37:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 25 Jul 2023 14:37:45 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jul 2023 14:37:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So1vta2HAtfk4NEbIyROPpyeeHhYEq7cmYFDUJ3HkMroULIqb7XY0HMm9bf1WZkckW5+5kuDzZBo3XAMJ6DKj0DL/zAFibUGQSfMr9yJLCwHfnylVlAszPufX5UjR5w/Ua5IONUfGxJLSgeblumYGLZhleKgHq/nRvwY46Rr/sry2gDznbE6lms3DyuEWES+XHRvB+JZkDejIMRNK3TNZAgbB0srynwDIh7+1hc17oaM7EgvGZTwMOjljRGP+ZqlZ63B9pamTCv9PZgEtVz5x9DAcdZskSmY/1KpEK2YUQGywFsrGeNElGYeISRMZOKu+zQq1ql7M5Pnj2DDYe4g5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26BmddmkBuzS6P2Cz7YC08NXZSe48iPDKd3RnsBXQCQ=;
 b=ei5gkCpgA1dWJ0ddkK4GgSJdujzWESXkiENXobk135uXf8bsKG20JIVkgsm5HQWgpTZdLdwxfFcZoWPYT69HKc9RQYyo8H+KbFLr4ONtb7EgvZvrtMA/Q9saqtSub09FRMpDqsDghQnBwlsxBRku5diZpcoOlhu3p903AwohZvxloC7B06JXXh4Ji0YQRyA9060xPBMwk/RHETaXY2cpixTcfGm7oad+CUwxFttVDIMDqqI07gQcFwIANBu7a8P7F9m9dep2e3r6uzWlFvZe03FsLKhN/V/WLcCVVJYHp9F1vBQP46Qh5RFwa0cZga+z20wJ1C8IV3JQITxTuPjy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26BmddmkBuzS6P2Cz7YC08NXZSe48iPDKd3RnsBXQCQ=;
 b=wPJHYLiE+++ujRvRYXvxVabe4L4sB/48ZPg1z2Z1mpaQM750T/VcgvwRNu9aw0gHkAkLNSfvVUju680rtZNT4YrRad3Zak7yz/LmQwiEfO5vUV+yCeiPPSjS5GIZrhjU5WGJvGeX9J/oOD9oMVMdij+zj6tOArww/Swvha6Fl6U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7647.apcprd03.prod.outlook.com (2603:1096:820:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 06:37:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::d126:7f34:9e4f:a95%4]) with mapi id 15.20.6609.026; Tue, 25 Jul 2023
 06:37:43 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH v6 11/11] drm/mediatek: dp: Don't register HPD interrupt
 handler for eDP case
Thread-Topic: [PATCH v6 11/11] drm/mediatek: dp: Don't register HPD interrupt
 handler for eDP case
Thread-Index: AQHZuLkkGJenYhvR1026TUHal1XgJq/KE5WA
Date:   Tue, 25 Jul 2023 06:37:43 +0000
Message-ID: <16123fef00babcc855c626ff65b5510fdeea6e15.camel@mediatek.com>
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
         <20230717141438.274419-12-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-12-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7647:EE_
x-ms-office365-filtering-correlation-id: 72270185-4f88-4778-894a-08db8cd9a6bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +rJJOP1KxTrJVdnuWeCQ58IFrXcYHy3JqAOEjI9GQ86oA4TZhldOdhvST7n/UHrs0i6D9OTRSjwL2QJEkR6Wr1mcoS25R3gVczX0zbwvvRdnMDactW2qHmhSbfq0gGvLwVZxp4M34cvWi/VX9Yf7fvIGeu4fqYt9lVUlnks4rNgsY5zzGgWhmUkNKReVYOYAJsLLjhOe+s8DrP7P1RQvx5zIfGb9Y4JP9bArM4KvaPVl0/MXE6HBcqRH61Q/uvAy/LbZO53XQ8VaOoIEpTJFhu9wwcWiNYPXXftrBG0BlT5tHhFfkXgHWzegI2bCy+C6K3UBNVxLildUiSRtAZ5ubSjIXJ0Zk+Yd5/otxlw9ffWRxSnHWGyIzIvAWdlOXlHavay+eh7KY++02ZaO0QsRWK5EM6pmUznT7wD2XxpIRnO1URTtWwSJ4/T0CYXhHK/pD1bjd21eFazaf77Anvz/jIHeMn8GjoTiC4h1+/3BqkEff7ZQmdJb+Nf6hLNOVxrDflu4JLcJOexjN/VFes5go56xqkqlRCfZXGJicOK/XlsVnTQHls3FJp/giFNyJ8yen0Gqkl+cOUtLVRAavRw863OcObMQwuHF5+MF3vcPK6RMqPiHuFdY2bILUmhkv07WBXtZvr2gxN/fHfz4D3hMYaFK78oLlRhZj++qxX8A5p8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(54906003)(71200400001)(6512007)(6486002)(110136005)(478600001)(2616005)(186003)(6506007)(26005)(2906002)(76116006)(41300700001)(8936002)(66556008)(4326008)(66446008)(36756003)(8676002)(5660300002)(7416002)(66946007)(66476007)(64756008)(316002)(38100700002)(122000001)(85182001)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnNHUERWWEVnVTFVNklEWFVVMkpYQkNDVDg0c0ZRbkJ5OC9MK3JtK0duOXQ3?=
 =?utf-8?B?ME8yQ1FHTTN3TTRHZUZBQkZXQjJUYXhuNzA2aFI5elowN1dTNmI4YW5qRHhT?=
 =?utf-8?B?bXBWd3pDSmpOTnVQMDczQjZjUm5rS041TGdUaGpTcm1TUWFzSVFCbUlkK0to?=
 =?utf-8?B?dTRtOWlFMlVpN0x1WlVVUDBDZG5VbHl4Rkg2cXNTb2tPYnZuWFRvS0EycWp1?=
 =?utf-8?B?Q3NzcXJKbjdtcituVjNQY2pzWnVJYmZmVkJrN3M5WkxFQXAvenA0aVc2THBG?=
 =?utf-8?B?bmFObm1KQ2U5cWtFZmtwUlBjVDNWelNzeWRuSlJMb25OWVMrZVdzZDdGRmpw?=
 =?utf-8?B?bm9GWkhjRXp6V01KZ1ZBNHl6UDgxanc1Ykt3NHQ3ZFcvOWhxN1VvUE5aOGdW?=
 =?utf-8?B?Vmp2c3o5RWhVN0g4eUx1RmYyYlcrcVMwbVN1eUgxM2dQbVBrZkJvTW96SEdF?=
 =?utf-8?B?cUU1WVpoOU9ybHEwOUN1UXZNMmZJVVVhZkNJUER2S2M4czl3QlBqR3FWUWZv?=
 =?utf-8?B?dkkvVkpNSVFsUHQzenN6V0FRam5Sb211Nkx4ZkVmVGViazg2M1ZOOFhXYitH?=
 =?utf-8?B?dENiQlNHNXFGc2pYcmlrUmx1M2pyL2pNTHNiRVg1THk0Y1dBbVo3Q1lXLytC?=
 =?utf-8?B?Z0tBdFA2ejRUNERwRkZQQWVhZ29vNGY3dWNQc285VkVMczhESlZUbE5udnA5?=
 =?utf-8?B?U0VZQlE2NTRIMzd2cmNjd0M5RnE3N3BuSEZ4cDhVdWdwd09PMkNsN0FZWVRs?=
 =?utf-8?B?M2UyNlZ1SkppRTJoOXlYMUFBdXNtZ011eUlHUXhZSlNVck9qb241NG1MZnFV?=
 =?utf-8?B?V1VZNXdTdERoMS81SkMvL1M0OXBSbUVxQk5VdWNvUWRUTHVyS1lBWVJJZlBa?=
 =?utf-8?B?c296aW1tQTBuaWt4bGxQSitZTGFUKzhPc1RramlOc1l6SExPdWZ0dEFpWllE?=
 =?utf-8?B?MDB5bWdBcTV1YjdONFdwbEZxOHFGbkZLYkNWWnNLWmJVNkZnWTlnNHVzUlBV?=
 =?utf-8?B?ZUFEcE56QloyYmlUOGQ2WHNCM0hVUElPUTIxZG5xY0d2SG4zZVJNMFUwSmg5?=
 =?utf-8?B?T2VBNDl3QmdkZGc2cEZoVlVRWVBGQlE5b25aMGtKVlJ3cHJJMW5aUEZITE9z?=
 =?utf-8?B?SjVRQ1hjWWZPUElQRkd4SmJNdnZseUROUzBkbCtxbUVUeFNHU294dzhvd0w3?=
 =?utf-8?B?Z0lyMzBibFFiTXhwdWtBTEh3azJoQyttT1RMbk91YXpoTXdHekl3cHVkcmZa?=
 =?utf-8?B?bkhaR1F4Ym5VWDVPNlZRdGpEZEY2NXRBQU5GdU1HZVI2M2Q3UHdGaXA3dWxj?=
 =?utf-8?B?ZmVubU9LWU9UajNOY1JScisxSVU4d1BvcWpRR29icWpKZk5oaGFmRDJtNkQ4?=
 =?utf-8?B?L0R6TE5QM1hOSHZkQ2NJVytXS0ZZRmRidUdOVVVvQ1lwTEVZQUVzZHlRYjF5?=
 =?utf-8?B?d1JsdThvVWJObHI1OVNZdDR0R0VpYjBMZXFCc0RxaDlyNnNYV3ZrdWJQYmh1?=
 =?utf-8?B?ZWdtUkZLYWxRMi80N1FnTVpHTUVPVzNoWlpEY0tkY2pLMXk5dGtwZ1hTTWhu?=
 =?utf-8?B?QTlBYmwvVUJ0NmdUYUJSLzFJRlRLamJEMEpQN2RkNXhRMW9rNXdWK2owbHlW?=
 =?utf-8?B?QWdwS3FsenZwT2orM0haY3pOOGgzZWJXMEQrQWhZL1lvMjF2UHgwUDRuM0Yv?=
 =?utf-8?B?ajRiNTcrNVNKQ1lueU1kUHdDWGh6TjZaaHZnaXRDTEN0ZGNXTDRiVXE5S0Vo?=
 =?utf-8?B?NnBtMDZoZkl6Z1BOZTVMbjJIcnp0dGlFNkRHZkV1ZS91TTFVa21obnQxODlk?=
 =?utf-8?B?emtkMHVrdndaaEIzYjhoZEtXamlxdFhNeTdNT1lsYkdBOXkxcmkvdHZJZGxl?=
 =?utf-8?B?ajJBNUYyOVBXUEdsNE9xU0c0akFTSDhUU1JOUWpQeFk0TUQ1RCtRZUVCTDNB?=
 =?utf-8?B?QUJqVGFEdjduVnVBS3J2UlprRW94RFcxdHB1RGpQcGJoaVJPcDBaRXMwWXpD?=
 =?utf-8?B?YndkWnN3blk3TDd1eVdGaXJKdVRFMm5pRU9JU3VqWXBDVVZnWTAvRDVXNThD?=
 =?utf-8?B?azVOMWU5RG9DSG4xNTdzOVFGMGNYWDJMeVZnbjU3SXZRNElURURCWlh0T3JP?=
 =?utf-8?Q?gCjEAo5HqcIzFw6n2ODDPwFu9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3B042FBD6DA0C469A42C4F90EDF4864@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72270185-4f88-4778-894a-08db8cd9a6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 06:37:43.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7YmWTk0Qft4Ngd0yq5M9cqViGoUaPLoF6wgIS/b64hrb9JrUuV1vzUxJCa5v1SIM4oqHubd+SupSpiy6BYUoVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7647
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFuZ2VsbzoNCg0KT24gTW9uLCAyMDIzLTA3LTE3IGF0IDE2OjE0ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxl
YXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBo
YXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBUaGUgaW50ZXJydXB0
IGhhbmRsZXIgZm9yIEhQRCBpcyB1c2VmdWwgb25seSBpZiBhIGRpc3BsYXkgaXMNCj4gYWN0dWFs
bHkNCj4gc3VwcG9zZWQgdG8gYmUgaG90cGx1Z2dhYmxlLCBhcyB0aGF0IG1hbmFnZXMgdGhlIG1h
Y2hpbmVyeSB0byBwZXJmb3JtDQo+IGNhYmxlICh1bilwbHVnIGRldGVjdGlvbiwgZGVib3VuY2lu
ZyBhbmQgc2V0dXAgZm9yIHJlLXRyYWluaW5nLg0KPiANCj4gU2luY2UgZURQIHBhbmVscyBhcmUg
bm90IHN1cHBvc2VkIHRvIGJlIGhvdHBsdWdnYWJsZSB3ZSBjYW4gYXZvaWQNCj4gdXNpbmcgdGhl
IEhQRCBpbnRlcnJ1cHRzIGFsdG9nZXRoZXIgYW5kIHJlbHkgb24gSFBEIHBvbGxpbmcgb25seQ0K
PiBmb3IgdGhlIHN1c3BlbmQvcmVzdW1lIGNhc2UsIHNhdmluZyB1cyBzb21lIHNwaW5sb2NraW5n
IGFjdGlvbiBhbmQNCj4gdGhlIG92ZXJoZWFkIG9mIGludGVycnVwdHMgZmlyaW5nIGF0IGV2ZXJ5
IHN1c3BlbmQvcmVzdW1lIGN5Y2xlLA0KPiBhY2hpZXZpbmcgYSBmYXN0ZXIgKGV2ZW4gaWYganVz
dCBzbGlnaHRseSkgZGlzcGxheSByZXN1bWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwLmMgfCA4
MSArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDQ2IGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHAuYw0KPiBpbmRleCBlNzQyOTViYTk3MDcuLmMwNmZjYzczMThlNyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcC5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHAuYw0KPiBAQCAtMjE4Miw5ICsyMTgyLDExIEBAIHN0
YXRpYyBpbnQgbXRrX2RwX2JyaWRnZV9hdHRhY2goc3RydWN0DQo+IGRybV9icmlkZ2UgKmJyaWRn
ZSwNCj4gIA0KPiAgCW10a19kcC0+ZHJtX2RldiA9IGJyaWRnZS0+ZGV2Ow0KPiAgDQo+IC0JaXJx
X2NsZWFyX3N0YXR1c19mbGFncyhtdGtfZHAtPmlycSwgSVJRX05PQVVUT0VOKTsNCj4gLQllbmFi
bGVfaXJxKG10a19kcC0+aXJxKTsNCj4gLQltdGtfZHBfaHdpcnFfZW5hYmxlKG10a19kcCwgdHJ1
ZSk7DQo+ICsJaWYgKG10a19kcC0+YnJpZGdlLnR5cGUgIT0gRFJNX01PREVfQ09OTkVDVE9SX2VE
UCkgew0KPiArCQlpcnFfY2xlYXJfc3RhdHVzX2ZsYWdzKG10a19kcC0+aXJxLCBJUlFfTk9BVVRP
RU4pOw0KPiArCQllbmFibGVfaXJxKG10a19kcC0+aXJxKTsNCj4gKwkJbXRrX2RwX2h3aXJxX2Vu
YWJsZShtdGtfZHAsIHRydWUpOw0KPiArCX0NCj4gIA0KPiAgCXJldHVybiAwOw0KPiAgDQo+IEBA
IC0yMTk5LDggKzIyMDEsMTAgQEAgc3RhdGljIHZvaWQgbXRrX2RwX2JyaWRnZV9kZXRhY2goc3Ry
dWN0DQo+IGRybV9icmlkZ2UgKmJyaWRnZSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2RwICptdGtf
ZHAgPSBtdGtfZHBfZnJvbV9icmlkZ2UoYnJpZGdlKTsNCj4gIA0KPiAtCW10a19kcF9od2lycV9l
bmFibGUobXRrX2RwLCBmYWxzZSk7DQo+IC0JZGlzYWJsZV9pcnEobXRrX2RwLT5pcnEpOw0KPiAr
CWlmIChtdGtfZHAtPmJyaWRnZS50eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApIHsNCj4g
KwkJbXRrX2RwX2h3aXJxX2VuYWJsZShtdGtfZHAsIGZhbHNlKTsNCj4gKwkJZGlzYWJsZV9pcnEo
bXRrX2RwLT5pcnEpOw0KPiArCX0NCj4gIAltdGtfZHAtPmRybV9kZXYgPSBOVUxMOw0KPiAgCW10
a19kcF9wb3dlcm9mZihtdGtfZHApOw0KPiAgCWRybV9kcF9hdXhfdW5yZWdpc3RlcigmbXRrX2Rw
LT5hdXgpOw0KPiBAQCAtMjU3OSw0MCArMjU4Myw0NCBAQCBzdGF0aWMgaW50IG10a19kcF9wcm9i
ZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCW10a19kcC0+ZGV2ID0gZGV2
Ow0KPiAgCW10a19kcC0+ZGF0YSA9IChzdHJ1Y3QgbXRrX2RwX2RhdGENCj4gKilvZl9kZXZpY2Vf
Z2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gIA0KPiAtCW10a19kcC0+aXJxID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCAwKTsNCj4gLQlpZiAobXRrX2RwLT5pcnEgPCAwKQ0KPiAtCQlyZXR1cm4gZGV2
X2Vycl9wcm9iZShkZXYsIG10a19kcC0+aXJxLA0KPiAtCQkJCSAgICAgImZhaWxlZCB0byByZXF1
ZXN0IGRwIGlycQ0KPiByZXNvdXJjZVxuIik7DQo+IC0NCj4gLQltdGtfZHAtPm5leHRfYnJpZGdl
ID0gZGV2bV9kcm1fb2ZfZ2V0X2JyaWRnZShkZXYsIGRldi0+b2Zfbm9kZSwgDQo+IDEsIDApOw0K
PiAtCWlmIChJU19FUlIobXRrX2RwLT5uZXh0X2JyaWRnZSkgJiYNCj4gLQkgICAgUFRSX0VSUiht
dGtfZHAtPm5leHRfYnJpZGdlKSA9PSAtRU5PREVWKQ0KPiAtCQltdGtfZHAtPm5leHRfYnJpZGdl
ID0gTlVMTDsNCj4gLQllbHNlIGlmIChJU19FUlIobXRrX2RwLT5uZXh0X2JyaWRnZSkpDQo+IC0J
CXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihtdGtfZHAtPm5leHRfYnJpZGdlKSwN
Cj4gLQkJCQkgICAgICJGYWlsZWQgdG8gZ2V0IGJyaWRnZVxuIik7DQo+IC0NCg0KV2h5IHJlbW92
ZSBuZXh0X2JyaWRnZSBzZXR0aW5nPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCXJldCA9IG10a19k
cF9kdF9wYXJzZShtdGtfZHAsIHBkZXYpOw0KPiAgCWlmIChyZXQpDQo+ICAJCXJldHVybiBkZXZf
ZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIHBhcnNlIGR0XG4iKTsNCj4gIA0KPiArCS8q
DQo+ICsJICogUmVxdWVzdCB0aGUgaW50ZXJydXB0IGFuZCBpbnN0YWxsIHNlcnZpY2Ugcm91dGlu
ZSBvbmx5IGlmIHdlDQo+IGFyZQ0KPiArCSAqIG9uIGZ1bGwgRGlzcGxheVBvcnQuDQo+ICsJICog
Rm9yIGVEUCwgcG9sbGluZyB0aGUgSFBEIGluc3RlYWQgaXMgbW9yZSBjb252ZW5pZW50IGJlY2F1
c2UNCj4gd2UNCj4gKwkgKiBkb24ndCBleHBlY3QgYW55ICh1bilwbHVnIGV2ZW50cyBkdXJpbmcg
cnVudGltZSwgaGVuY2Ugd2UNCj4gY2FuDQo+ICsJICogYXZvaWQgc29tZSBsb2NraW5nLg0KPiAr
CSAqLw0KPiArCWlmIChtdGtfZHAtPmRhdGEtPmJyaWRnZV90eXBlICE9IERSTV9NT0RFX0NPTk5F
Q1RPUl9lRFApIHsNCj4gKwkJbXRrX2RwLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDAp
Ow0KPiArCQlpZiAobXRrX2RwLT5pcnEgPCAwKQ0KPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUo
ZGV2LCBtdGtfZHAtPmlycSwNCj4gKwkJCQkJICAgICAiZmFpbGVkIHRvIHJlcXVlc3QgZHAgaXJx
DQo+IHJlc291cmNlXG4iKTsNCj4gKw0KPiArCQlzcGluX2xvY2tfaW5pdCgmbXRrX2RwLT5pcnFf
dGhyZWFkX2xvY2spOw0KPiArDQo+ICsJCWlycV9zZXRfc3RhdHVzX2ZsYWdzKG10a19kcC0+aXJx
LCBJUlFfTk9BVVRPRU4pOw0KPiArCQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRl
diwgbXRrX2RwLT5pcnEsDQo+IG10a19kcF9ocGRfZXZlbnQsDQo+ICsJCQkJCQltdGtfZHBfaHBk
X2V2ZW50X3RocmVhZA0KPiAsDQo+ICsJCQkJCQlJUlFfVFlQRV9MRVZFTF9ISUdILA0KPiBkZXZf
bmFtZShkZXYpLA0KPiArCQkJCQkJbXRrX2RwKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCXJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LA0KPiArCQkJCQkgICAgICJmYWlsZWQgdG8gcmVxdWVz
dA0KPiBtZWRpYXRlayBkcHR4IGlycVxuIik7DQo+ICsNCj4gKwkJbXRrX2RwLT5uZWVkX2RlYm91
bmNlID0gdHJ1ZTsNCj4gKwkJdGltZXJfc2V0dXAoJm10a19kcC0+ZGVib3VuY2VfdGltZXIsDQo+
IG10a19kcF9kZWJvdW5jZV90aW1lciwgMCk7DQo+ICsJfQ0KPiArDQo+ICAJbXRrX2RwLT5hdXgu
bmFtZSA9ICJhdXhfbXRrX2RwIjsNCj4gIAltdGtfZHAtPmF1eC5kZXYgPSBkZXY7DQo+ICAJbXRr
X2RwLT5hdXgudHJhbnNmZXIgPSBtdGtfZHBfYXV4X3RyYW5zZmVyOw0KPiAgCW10a19kcC0+YXV4
LndhaXRfaHBkX2Fzc2VydGVkID0gbXRrX2RwX3dhaXRfaHBkX2Fzc2VydGVkOw0KPiAgCWRybV9k
cF9hdXhfaW5pdCgmbXRrX2RwLT5hdXgpOw0KPiAgDQo+IC0Jc3Bpbl9sb2NrX2luaXQoJm10a19k
cC0+aXJxX3RocmVhZF9sb2NrKTsNCj4gLQ0KPiAtCWlycV9zZXRfc3RhdHVzX2ZsYWdzKG10a19k
cC0+aXJxLCBJUlFfTk9BVVRPRU4pOw0KPiAtCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9p
cnEoZGV2LCBtdGtfZHAtPmlycSwNCj4gbXRrX2RwX2hwZF9ldmVudCwNCj4gLQkJCQkJbXRrX2Rw
X2hwZF9ldmVudF90aHJlYWQsDQo+IC0JCQkJCUlSUV9UWVBFX0xFVkVMX0hJR0gsDQo+IGRldl9u
YW1lKGRldiksDQo+IC0JCQkJCW10a19kcCk7DQo+IC0JaWYgKHJldCkNCj4gLQkJcmV0dXJuIGRl
dl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+IC0JCQkJICAgICAiZmFpbGVkIHRvIHJlcXVlc3QgbWVk
aWF0ZWsgZHB0eA0KPiBpcnFcbiIpOw0KPiAtDQo+ICAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgbXRrX2RwKTsNCj4gIA0KPiAgCWlmIChtdGtfZHAtPmRhdGEtPmF1ZGlvX3N1cHBvcnRlZCkg
ew0KPiBAQCAtMjYzNCw5ICsyNjQyLDYgQEAgc3RhdGljIGludCBtdGtfZHBfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gIAltdGtfZHAtPmJyaWRnZS5vZl9ub2RlID0g
ZGV2LT5vZl9ub2RlOw0KPiAgCW10a19kcC0+YnJpZGdlLnR5cGUgPSBtdGtfZHAtPmRhdGEtPmJy
aWRnZV90eXBlOw0KPiAgDQo+IC0JbXRrX2RwLT5uZWVkX2RlYm91bmNlID0gdHJ1ZTsNCj4gLQl0
aW1lcl9zZXR1cCgmbXRrX2RwLT5kZWJvdW5jZV90aW1lciwgbXRrX2RwX2RlYm91bmNlX3RpbWVy
LCAwKTsNCj4gLQ0KPiAgCWlmIChtdGtfZHAtPmJyaWRnZS50eXBlID09IERSTV9NT0RFX0NPTk5F
Q1RPUl9lRFApIHsNCj4gIAkJLyoNCj4gIAkJICogU2V0IHRoZSBkYXRhIGxhbmVzIHRvIGlkbGUg
aW4gY2FzZSB0aGUgYm9vdGxvYWRlcg0KPiBkaWRuJ3QNCj4gQEAgLTI2NDcsNiArMjY1Miw5IEBA
IHN0YXRpYyBpbnQgbXRrX2RwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ICAJCW10a19kcF9pbml0aWFsaXplX2F1eF9zZXR0aW5ncyhtdGtfZHApOw0KPiAgCQltdGtf
ZHBfcG93ZXJfZW5hYmxlKG10a19kcCk7DQo+ICANCj4gKwkJLyogRGlzYWJsZSBIVyBpbnRlcnJ1
cHRzOiB3ZSBkb24ndCBuZWVkIGFueSBmb3IgZURQICovDQo+ICsJCW10a19kcF9od2lycV9lbmFi
bGUobXRrX2RwLCBmYWxzZSk7DQo+ICsNCj4gIAkJLyoNCj4gIAkJICogUG93ZXIgb24gdGhlIEFV
WCB0byBhbGxvdyByZWFkaW5nIHRoZSBFRElEIGZyb20gYXV4LQ0KPiBidXM6DQo+ICAJCSAqIHBs
ZWFzZSBub3RlIHRoYXQgaXQgaXMgbmVjZXNzYXJ5IHRvIGNhbGwgcG93ZXIgb2ZmDQo+IGluIHRo
ZQ0KPiBAQCAtMjY5Miw3ICsyNzAwLDggQEAgc3RhdGljIGludCBtdGtfZHBfcmVtb3ZlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICANCj4gIAlwbV9ydW50aW1lX3B1dCgmcGRl
di0+ZGV2KTsNCj4gIAlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+IC0JZGVsX3Rp
bWVyX3N5bmMoJm10a19kcC0+ZGVib3VuY2VfdGltZXIpOw0KPiArCWlmIChtdGtfZHAtPmRhdGEt
PmJyaWRnZV90eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RPUl9lRFApDQo+ICsJCWRlbF90aW1lcl9z
eW5jKCZtdGtfZHAtPmRlYm91bmNlX3RpbWVyKTsNCj4gIAlwbGF0Zm9ybV9kZXZpY2VfdW5yZWdp
c3RlcihtdGtfZHAtPnBoeV9kZXYpOw0KPiAgCWlmIChtdGtfZHAtPmF1ZGlvX3BkZXYpDQo+ICAJ
CXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKG10a19kcC0+YXVkaW9fcGRldik7DQo+IEBAIC0y
NzA2LDcgKzI3MTUsOCBAQCBzdGF0aWMgaW50IG10a19kcF9zdXNwZW5kKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gIAlzdHJ1Y3QgbXRrX2RwICptdGtfZHAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsN
Cj4gIA0KPiAgCW10a19kcF9wb3dlcl9kaXNhYmxlKG10a19kcCk7DQo+IC0JbXRrX2RwX2h3aXJx
X2VuYWJsZShtdGtfZHAsIGZhbHNlKTsNCj4gKwlpZiAobXRrX2RwLT5icmlkZ2UudHlwZSAhPSBE
Uk1fTU9ERV9DT05ORUNUT1JfZURQKQ0KPiArCQltdGtfZHBfaHdpcnFfZW5hYmxlKG10a19kcCwg
ZmFsc2UpOw0KPiAgCXBtX3J1bnRpbWVfcHV0X3N5bmMoZGV2KTsNCj4gIA0KPiAgCXJldHVybiAw
Ow0KPiBAQCAtMjcxOCw3ICsyNzI4LDggQEAgc3RhdGljIGludCBtdGtfZHBfcmVzdW1lKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gIA0KPiAgCXBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2KTsNCj4gIAlt
dGtfZHBfaW5pdF9wb3J0KG10a19kcCk7DQo+IC0JbXRrX2RwX2h3aXJxX2VuYWJsZShtdGtfZHAs
IHRydWUpOw0KPiArCWlmIChtdGtfZHAtPmJyaWRnZS50eXBlICE9IERSTV9NT0RFX0NPTk5FQ1RP
Ul9lRFApDQo+ICsJCW10a19kcF9od2lycV9lbmFibGUobXRrX2RwLCB0cnVlKTsNCj4gIAltdGtf
ZHBfcG93ZXJfZW5hYmxlKG10a19kcCk7DQo+ICANCj4gIAlyZXR1cm4gMDsNCj4gLS0gDQo+IDIu
NDAuMQ0K
