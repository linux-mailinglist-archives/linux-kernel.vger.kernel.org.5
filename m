Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2737A458F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjIRJKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjIRJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:09:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F13188
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:09:18 -0700 (PDT)
X-UUID: 0969aea4560311eea33bb35ae8d461a2-20230918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZzCllzY1L1XrMSoVeb6Wqw9W+KTu3Ug4KsV3aBi81v0=;
        b=hzP/Lg5g0iXpxv0jjEN0wE+dAugrN+SNgGTm4h3O/3b0axnDiMRkMYpPPJfTzl1vqTn7+YWiO5QCRbUurECATVTWpCNwfuf/eYNbZhGgieZCFut1SJ5dPjuvrN/Mt4yYON3KGIEPB/zYsMI73yjD8LrtnmRN+pSN4cErzzw1+wI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:fab0a0d3-6aeb-4a2e-93b0-68d0b0a2e8ac,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:261f1114-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 0969aea4560311eea33bb35ae8d461a2-20230918
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1145251011; Mon, 18 Sep 2023 17:09:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Sep 2023 17:09:12 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Sep 2023 17:09:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDIAgVdGWIGWq+AJuHJV3P2g1xUD5feRcFdOJpDznVhywXccy/PiG5E0L0jtzxQxZdEyZj1DGNxeVPuLYQmMHBjniEjtMkZ7nDvtSmXuXEQryEiwhFJqYsAdX8o6KXdhpkimtTV22sDo/q8oTsCJ+icA4jxE/D8zDkL0sw+hTLSDNuwvVNP9betcrtmnMt4RlaNCVU31PQy93BKX5sKQhbp55pcOfpOUEd6mKqcG2OI5chd55KL8xOe61Uuf2JXnWLECxcFfKRHs4jnKksdeX8WMozLxnoKcO0pnXLfXyiDT5EK9ljOGtZo8d1e+W5pXiy2I5wmhimyP5vDoDE5UVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzCllzY1L1XrMSoVeb6Wqw9W+KTu3Ug4KsV3aBi81v0=;
 b=QMyEXZC5CzcYmcIb6s+giTD6SjMIAighFGZrrByWaQT/Bksuq/To47dvnNmROb3wj8OPLhCXTYPralCkzvzsBYx60vBRzctUeW0+ZOXUXcTKIn3nvLlJkNchQQ1fXLu0uXEJYrH8NkC71LL5XOjIO5L+RSgWzcgMkA/unQQziruYkHwKCudBroPe1r5p39Q+1/C+iFzc53WjMyiaWBKfcoomhz+5dbxTHbPsuaRKaQcndi9NbqZ6Lk/L7fIgIsEbt8LmMUzuvx2+MbDYW8IQscxhXpJwKFV3huKgwtwTNIm2GdUEyFbFGjMJ56FHouPWTHCLEhTHYiysObdXffxOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzCllzY1L1XrMSoVeb6Wqw9W+KTu3Ug4KsV3aBi81v0=;
 b=TzRuYjZmp9XP4d5G2zKqHwlJj2rEMltMwQDLiKLSUgMTFtRdK9hKVlmKWxkaBUk0YtZqTecPZx7ICL+19PE3Bd07xHpLXjTbJptm7tfWjqTMrNad8YnkVBQccVjmd+TbuSZmVdZLfDgTdcBZwPAhdphzNZqBzWu39Grb4s2djUA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6653.apcprd03.prod.outlook.com (2603:1096:400:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 09:09:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9c2c:c08a:212f:e984%6]) with mapi id 15.20.6792.022; Mon, 18 Sep 2023
 09:09:09 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for MT8195
Thread-Topic: [PATCH v2 04/11] drm/mediatek: Add OVL compatible name for
 MT8195
Thread-Index: AQHZ6gwiYoEmHBjFLEC9YeMNqxBairAgS3iA
Date:   Mon, 18 Sep 2023 09:09:09 +0000
Message-ID: <ffcf35cb8ca1ff0fe0a0f0176e3199b9c944b3b9.camel@mediatek.com>
References: <20230918084207.23604-1-shawn.sung@mediatek.com>
         <20230918084207.23604-5-shawn.sung@mediatek.com>
In-Reply-To: <20230918084207.23604-5-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6653:EE_
x-ms-office365-filtering-correlation-id: 0217a75a-8352-4afb-d5ef-08dbb826eb1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kG4vtqMDLAqshav310hCR+5MVuk2VQDVzw+QhW4l1ehcxSBflHKfZSI5jX3BmyfSg7KYm54qj4eBFu65QC14OC0MxMATmBDvg+jhZURTedr+SOO4jeeUlb2WIdqBxwD9UW2sXRPFj8pxFm3NgfwUuZTinP1hYm5/bObzvRN1nnP896mpn+WAUwNZ3sCRxZcwHMloaA18Z5QBoNjyKkM00EKQZLhVLWvArq4ehlu/cbf0vQMDt1pSbDlEFfEhYPGFTVJIIptvLEnduonhqcrGOu1Xk+gdTH/JJ2a6mLvbfAll0Mqbw1gRctCBHWsN16BDYtaXEvXHzCEMs2YWxDRE3zE4oN3CsuWbGnB2ZPSI1+j4sVnWsQfSs0QglewHh6kPvsemViLKsQpNMTK0Zt9IfmmFM4zPOdynVDQkX+LkpDnqvb+PYENc5qNeY5BxmWANdoXrz88YKfeDoePUgvkMI6r1DIq3QPECDFkluE9vF0RzMzddzOtRs9Qm2uv0HjT1MNDwy1Qhd9ltSxsnGFY1WChODtNlTRLQ3dobRN0obbFDpYQuSYeoUlBbFoD3MLzKV4E+AGu/bAceO9LI3COUmys/DOaJPoi10U1wK4sm+f9y8mDDA2oRuJagvuaba6JQ9HSjBdg8e7o+QliwdlrfrywZA+bYhR8InHydMcDA/Yo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(6486002)(5660300002)(6506007)(86362001)(6512007)(54906003)(316002)(66446008)(64756008)(66946007)(41300700001)(38100700002)(66556008)(38070700005)(66476007)(76116006)(110136005)(71200400001)(478600001)(8936002)(2616005)(8676002)(26005)(2906002)(36756003)(85182001)(122000001)(4326008)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFqd3dHcjFwKy9iNjlEeThZZVBPWlh2blNGSnpUTkNFd2tscmh2Tjh5Wm5X?=
 =?utf-8?B?UW5hTHRpUUNNSjVETGJicmgyOVFtSnp1aVZJUXJ2aEJZblFtL08vVE90cmJu?=
 =?utf-8?B?OWRzVWtQTlQ3K3p3S1BsTWYrcTU2WWczbVJmbjlWWGpUL2xkUkRjcGFJa2xV?=
 =?utf-8?B?RjQvVWNMeGRoZWFoQWpab3ZaWitmV29HalE5TDNLdmxualdqdDRYZ3ViZXJF?=
 =?utf-8?B?Ky9OdUxvUHJqRG1vdWUwcVBuTVhXbEhUbExtMExjbE5iZ2llTTZOWGU0bkx5?=
 =?utf-8?B?ZmJFRGR0WGNHV0lTbWRiSGhveUkrd1lXaUVwV1hQRDRsZkxSSU1meCsvNmkv?=
 =?utf-8?B?bGVuVHp5YWVNMVRsKzN3L3JmdWJWYzlCcXEvalpCakIvNFBFYUVUZ0JrYWxM?=
 =?utf-8?B?TVlmNUd5TGJrTmROVjN1MHZUaEhkSEZlSW9qcDJHa0tKUDhyTS9peXQrZjE5?=
 =?utf-8?B?V0Y1WGgzYStYeDAyNnM0YXVBU3kyYU9Nam9RMmc2Y0tJcWFDQW1PV0Rxdndv?=
 =?utf-8?B?U2EwazR6Z2ZNQTB1b0E4UHNXT1lpT0RJdTY1YW5kM1FJRGEyNTZYcVh3U21V?=
 =?utf-8?B?d3ZldnRGWWg2V0tsMmtrUG05eHE2bGgvMEcxZzR1MmNoTGZLa0ZSVTYyT2xH?=
 =?utf-8?B?bXdBUUgxNVI5ZGpGaEpvbXV4R1JDcjd0NzdxVHY3Rzc0M0hNUGJPd3NXRlZj?=
 =?utf-8?B?ajBGd2hYZzh0amo3akVQWlpDcWMzZWxldFFoQTc0djlmWnIyYVUxNHR3VjlE?=
 =?utf-8?B?andKcGlhMGFMZ2lWSFRLeXFyU3NKUVczUEQ3c2NoQ0o5S2VaT2U0ZFp6dFFL?=
 =?utf-8?B?SjRzclY1UE9nWkU3RjcwSUVTbTVvZUhpdU9rL1hhRjQ0N3NSUmkvczNyVE1h?=
 =?utf-8?B?Q2t1czB0WnRDaGZLblZZTEdWcWNnMEM4ZkhDZjVGSHg3eU1Eb21OY1JyT0RE?=
 =?utf-8?B?ZDNwRnpHRjN4ZVBQdjJGQ2dyRDZQZHNubFkyOGFDcGNwME1CeTVWanpGRWNs?=
 =?utf-8?B?emJETk9nQW9FdnNGR0RYNFR6OXUxZncyRndMNFdLQmdva2dGdVpoZUpjQVhK?=
 =?utf-8?B?NHVVTVlTUXllZ2g2SUFkK1NodUtSMDR2RzcrcGg3TDBzZGtFUkJscGFmaVNz?=
 =?utf-8?B?eUlUVXpMNXNzM2UyaENqSGdFTGxGTzZCM0F2QnJBUHZOS1daVXo2dmgzQ2cx?=
 =?utf-8?B?Yk1XUGd3TFc3TGpXOWF2a1A4U3FpaEM4aDBZMm85dUhOd0FFZHEvUHdDS3pm?=
 =?utf-8?B?TTNQUElMUkhhY21rcVBMM0JheDk3K1VBWGJZWVh4WnZrL3FucjZFdlowZFJ0?=
 =?utf-8?B?d0lIRW02VWtxVGhyOVJnaUhDZ1JtQWNxS3NxY01QblF1VXhhM0prM1BPY2pC?=
 =?utf-8?B?YnlTUGRkVkFJUCtYd2FPZFBGRUhJZWx6Yjh4Q3llY3dtVVZBTWRvNks3OVZu?=
 =?utf-8?B?dm5WWjFCWFJiS08wWnlVdHU0Zk9KN3N0d3VKMld6QzZSK09SNENaMDVSUXhE?=
 =?utf-8?B?WmxYN2VTZmhhekRLeXZzMzVlVGhSUm5NbXFPbHBNSnh4bHhCQTlXN1V5cFRE?=
 =?utf-8?B?YkVMdW5HMStDd2ZEUjBTZDlwM0JsTEgyWWVUT2pMZWMycHhSMjY1ZlRadlpo?=
 =?utf-8?B?bHQzZWprdm1tNTB3T1FWWEk1WGtBcDRzc0JnOTZVUGswZXpMeFRGQ3piZTdz?=
 =?utf-8?B?MEFTcWRvaUJvK0JvbUROYUJwT2dFS1FkQTNWNENIVHQyaFJCbGV1OCtzV2d2?=
 =?utf-8?B?NTE4NGM3OEJQNHpCL1FZVUdZNmVOTkxDeG9Tc2xkSitNeDJOYWpkdUp0akt6?=
 =?utf-8?B?TGxIYmFseENaTVE1M2pYdFowb0FMZ2lJUFU0MC9tSDBOYUtHcUpnSUZwcVor?=
 =?utf-8?B?TXBacUpabjBFbnpXMWtYT2N2UUlxbDhxUzhZRmE0Ym9WQiszRkg5QzFVMGFw?=
 =?utf-8?B?Ty9rZ2JQd0ZQNFRKVGhlM0h6VG9XcVExL08vL2NvazFXejlqZEovSUFvcDhN?=
 =?utf-8?B?VG0xUVEydW55ZER0d3d2a0R0b2dCNXQ4eWxmK3RuVlNoUmRwRnAzNFJhcGtX?=
 =?utf-8?B?MGtLVFRhcllsNnNEQnZTa0wrU2ozVnNjQ2M0MTZzM1ZFMHc3UEo2R3FiT2xi?=
 =?utf-8?Q?BS/X3/wcX+ylNqoq7V5Z7L2T5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB9302E4F49A50458798AC1FC2EFE9D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0217a75a-8352-4afb-d5ef-08dbb826eb1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:09:09.5571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zD+NfAf50quxRy6i7dFBQmzgI7yBxG5UxLd56HDP2fEQ6igF+A2B/yBlHUFRzeK8/ajC5vqldzcc/UwAy1lPpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA5LTE4IGF0IDE2OjQyICswODAwLCBIc2lhbyBDaGllbiBTdW5nIHdyb3Rl
Og0KPiBBZGQgT1ZMIGNvbXBhdGlibGUgbmFtZSBmb3IgTVQ4MTk1Lg0KDQpSZXZpZXdlZC1ieTog
Q0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KYnV0IGl0J3Mgd2VpcmQgdG8gcHV0IHRoaXMg
cGF0Y2ggaW50byBJR1Qgc2VyaWVzLiBXaXRob3V0IHRoaXMgcGF0Y2gsDQptdDgxOTUgZHJtIGRy
aXZlciBkb2VzIG5vdCB3b3JrIG5vdCBvbmx5IElHVC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIHwgMiAr
Kw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gaW5kZXggOTM1NTJkNzZiNmU3Li43NzU5YTA2
ZTVjMGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ry
di5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBA
IC03MTUsNiArNzE1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQNCj4gbXRr
X2RkcF9jb21wX2R0X2lkc1tdID0gew0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX09W
TCB9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWRpc3Atb3ZsIiwNCj4g
IAkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElTUF9PVkwgfSwNCj4gKwl7IC5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5NS1kaXNwLW92bCIsDQo+ICsJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJ
U1BfT1ZMIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwt
MmwiLA0KPiAgCSAgLmRhdGEgPSAodm9pZCAqKU1US19ESVNQX09WTF8yTCB9LA0KPiAgCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWRpc3Atb3ZsLTJsIiwNCg==
