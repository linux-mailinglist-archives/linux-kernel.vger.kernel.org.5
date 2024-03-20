Return-Path: <linux-kernel+bounces-108334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A5A880953
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D7D283BE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619379FE;
	Wed, 20 Mar 2024 02:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wt1PKdxK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NdkFNycf"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58E7464;
	Wed, 20 Mar 2024 02:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710900003; cv=fail; b=HJwfzaEfTYBkrZUHyexSp6PHupu/vkvlKUgpWH31QF8hlingZK+NsljXtDXSiiNar9yb+MdKLSjCk7CRAx8MwIh7yoqLTn5jCdi1hnktHAUd38EY1FNWqK2p+tLTUeH6nEDz8v942+0CMqMW8qewUbYVOvEAOqDs2in6Pf3k4uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710900003; c=relaxed/simple;
	bh=ArzQrKAb694Vp18qrvxLIq856fzirMOkllHB/R0quhs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vE4uiUmyie/iZ5VIzqk11zU1gHG3ebv+Rewq61VIskkOwxE9aFhH5rpiDLnQTGAyEobiyKVd25o9nuwzB31eh3qfetJxP1ajlvs+imOvPyW64A/FL54OOYCAx4D5xfgLg1D78uIzKuOpztHc1l6IEJ3Z48U1O5PCjU2yeqIU4gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Wt1PKdxK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=NdkFNycf; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8c5927fae65d11ee935d6952f98a51a9-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ArzQrKAb694Vp18qrvxLIq856fzirMOkllHB/R0quhs=;
	b=Wt1PKdxKjOB/Rh9n0xlY5eEawldlJURtkXhL9hFdcIrLWKjjtWU3+3uPyyVw4yFFWTE0eGtcKxTTeeyGKid3rXf8lOTgEUgoIlv82FEDM0k52dqT7mGmk5o3ECTdKMn53THDfZcPa4NLU9hCBToF2z9omuD7ZsfydoI29H+vhOU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:94b0e159-b14a-47f7-8ced-30476b445211,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:60c4b281-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8c5927fae65d11ee935d6952f98a51a9-20240320
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 634067481; Wed, 20 Mar 2024 09:59:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 09:59:54 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 09:59:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHv2yEffTZ1p/VjnD5/NS84In6uvwX6xsAKWC9cDcZuLN+kcfTJurcGDYxwWLXP3EuNolGbanIyPPQ8kcnWKBvB4AgiGZzRhALU65woy554t0VHEmo5SGHZDHIkc6lzIfoabvzmzc+GvnE/7SlMBdg0QFUR525SLflrN7Df6xcCl+3y7TaoMkIVnOdZGfob6lll8b694mDRnSB+BuF7vu25f1sKFZ/n+rYu3oLOOOOlTuMB1jcX872iTtqbUQx7V10GmVxNRR1d4A5iwz338MNDo/rDqfISC82dJ/pQL9Fd14irAVl9rAqoi53TTqxeSHPZqVpNG6mPRcl+9FCkvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArzQrKAb694Vp18qrvxLIq856fzirMOkllHB/R0quhs=;
 b=ZSymSr6ShP4eNlZLKbv2IfoouggbXQZsCWHebiw+IKlJRJPK8p9En8H1IFx7iRsResppqSDYsTUESWteKpKI1K26AzcFEmDaW8vTWbKNy8mPYA0Ef8U4e37fyT310V/KWsfoB69NnP0x5xUA5oj2LDTnsAyB0MJI6yU7kSXfZf2w3OQz2+Wx3OgY5nneBiXtc2R3Ul3BrHjEm7jrlHNKEiVsazVzarYkN6UV9BrUinss4bRkb60VIOZkIe3KJpWiUY8JD2h3hdM+bD6UaJTqzweiGTmZEm4kO5DSvwsxLWgAfQj8uedjFLNVQfw0W+O47vyrbB5cMHs+Ek2caLw5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArzQrKAb694Vp18qrvxLIq856fzirMOkllHB/R0quhs=;
 b=NdkFNycfJbHOQ5ECzCU4C7C+HRu8mbKE90GjjsrV6k3MCSRSng2csQLfhZkYAPAW+lKozELeB/L6WUr7OBv0K2u9nPL9mB86RZPjwdoaujzwf9EQiQlYWDOhbbZw1d8ruWBXjUntfIpMug50AmmcbOaiTv8gT9Ve/QE3VAxsmec=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8513.apcprd03.prod.outlook.com (2603:1096:820:12f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 01:59:51 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 01:59:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 10/14] drm/mediatek: Rename files "mtk_drm_plane.h" to
 "mtk_plane.h"
Thread-Topic: [PATCH v2 10/14] drm/mediatek: Rename files "mtk_drm_plane.h" to
 "mtk_plane.h"
Thread-Index: AQHaecvAtHsvSzqlDUKB2eh8a59rp7E/4P+A
Date: Wed, 20 Mar 2024 01:59:51 +0000
Message-ID: <e4f7ae6e51f15e390d032208405da6f55065d2ae.camel@mediatek.com>
References: <20240319070257.6443-1-shawn.sung@mediatek.com>
	 <20240319070257.6443-11-shawn.sung@mediatek.com>
In-Reply-To: <20240319070257.6443-11-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8513:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C8uf+i0sMCKjhdSQNWlSBOshShNkLPPt5rh3loH7Pd4mcSvKmTn505lHF5HyzMY17kfW4V6IJsYGNZtK+Absi3i/tAUirKYreN5ZE0GdfpFAPnzMvS21MeTCGEEbOcwveE1HoHxYQimQV514JuTu9q3J41QMuF1agXLc8SI9StcUytBtRBSj6moFTMhjJU890Wm3uOEniaqKjHcYLhE/vitwPJE+LO5blk13W2XVjJBckfdyxxM1Poq5rd1tH4WdJSknT7AmOBAKkf6Fs1rRYL6mhljFiLIjDJskIE7JC0G8chE5cW1yOJMWIkDxw2th3ul778kkr/lnEMZ19VFEJzhDVEcrqgNg4NfpfiN8yKB5Gp3Zn77rcQe/YPLpXQjZM8x29z2rp4GXbllSSNQLjNDQp2ZXxtZL+9wmsUJYQev5zKE554LQTpGPukcX1XkBknQJlY03njVBODB64rp81hdkJ9y2MQj4RHhVUPO874fX9qHftDlzOiUIwSNGuE4pKixfOONPT5sAJAezYxyTRUZzMwoOiZIPJOQA/cnJXDlIgAc/ff0llGzeWG4OUDq4/r25Iy64HyldjFqRULyCNhmFqKQ9ztjnssVoI6CBxsylt17E17aUCeUZxqRYJnJmeBww9NFU4oRB8i/Pe5lsKIPyMGXcWocmqUbjSrPqgIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnY2VDh1dk9KRVd3V1F4a2dnMk9ZT25OdmFKY2F6d1UyWW9NSVI4T0VWeElx?=
 =?utf-8?B?ckk4aXd4K0RSVmFUaFpiTEsycndML2lLb3U3U2oxRlRnMG43RXMxVFJHNFgr?=
 =?utf-8?B?dy9zZ2Yxc1VXWHYvY1o0c2QyY1FLeXl5K3RETmpnczk3RHA5dE9kbFYrWVdn?=
 =?utf-8?B?RG0zcnpFdkxrZlE1cjFCQVlZOUY5M0ZvSnVLZWRsL2t1TWVVMnBtM3d5bG9m?=
 =?utf-8?B?aTBGOU8rYkZ5My9va0VnVzJMSFRkNGJCajBoODQwanc2NDFpc2NqVW1jWVVt?=
 =?utf-8?B?NURxWVRkYWt5VGNYLzFxeXVNc2tBVWlmVEswK2FFeGNMYnEwdG13OTZmRnVn?=
 =?utf-8?B?QlR3bG15bEpYMnpaY3ZYTFFDc2NnY3BQZmRYaGdjRWFnVUJ3U0NBRitUcFht?=
 =?utf-8?B?WWw4V3M4Z3cwdWdaOCtwYmVOWXRvYXFNSUhVMG8ralNKU3ZCOXZvRVRCcnNL?=
 =?utf-8?B?dXNDNUFNSW1jVS85RlJaNzVEY3d4ZWRQdGh6YzZwdEZOV2ZKb2E5TzI0eFJs?=
 =?utf-8?B?dzFRc2tZRHRhWjgrcjhadmg1czJzeTJ4WXJxcTBoSVNkL0JibmFYS1FyNmNO?=
 =?utf-8?B?RnduVHpHRlM0U2JUWFE5cDgwamxtUUl3WW8zSTFXOHZIeElmTUdVRVBDc2h6?=
 =?utf-8?B?ZU84Q1YyZjNUak90Umpjd1QvUjNCRUx4TjRiNkEvNkQ0UlV4dEo5dS9tWkNp?=
 =?utf-8?B?QXRjTEdOR3M2R2dnYnVwYWhzZGRmUTFCZVYraFlmcEVZQ2hHVHprMXNEcFVB?=
 =?utf-8?B?eG1pYUIzVFdRUTBrWmVGM2kxa2pWMnJ2VFp4cFh2eVlDSm9aWmd2MGpwWXEz?=
 =?utf-8?B?WG1uVGZQRXhReHlQM0ovdloyOTlraWo4Qms3VDk4bDQwdjQrbExoQnppbkJQ?=
 =?utf-8?B?LzZFZDFwalhOQnozelpOZzh5NEk4QWRaOVZWcFYwZVR1RmtTeWxFYnFsVXNh?=
 =?utf-8?B?QUVaNFRpQVpyWEM1UTVPTkJLZHdOWHdwemE1NVYxTzZuaFBvL2pVTVFsU2dB?=
 =?utf-8?B?eWZvU1ROQ25qS0pIaDZ4UFJYbldDem5NRTFmaUFrUWVpZ0NqWnMzY0o4MGdy?=
 =?utf-8?B?MlRadTdiMkg0eVA5YXdJNk5HQ0RQcHlIOGhMb0c0SG1Sa3JOOStNQXBEYlQ2?=
 =?utf-8?B?c2hlVy9QQjIwMEJaUTJ2aThwTm52NFI2bkNmYkp4Nm5vVmJxTCs2Y0hxMEFF?=
 =?utf-8?B?eitubGc5NzVSbjFsSGE1ZDZSVlY5YitkandxMElIdmMzT0hmVVNMUHZMdnEr?=
 =?utf-8?B?a3lTaER4N2VlWnU1dURFMFR3NnY4WWVKeWJXWnVyWlIxZ3J0UHJkbEpzQnZD?=
 =?utf-8?B?eVhjamM4WlRUUGpXY2lhbDJ5YjFPdXd0VzBiNGtrY0sxeUg0MUVweEh4QjhQ?=
 =?utf-8?B?ZVBhbGhGeW5SOGJENjM0NFQ3bWlWTkxteUxDRUQrN3dpYU9XNEkzSWw0VStH?=
 =?utf-8?B?TUZ4WVM3ZWxuNGluTitXUy85eU56VXNIVjlNRklvOTJHTXVOVm13RmxFZlVu?=
 =?utf-8?B?elR4WjBLUFpsQzB5TFh6N2ZyMXc4YSthb2hOMkFtNnE3cEdKWml5bHFsNHFq?=
 =?utf-8?B?RE9HMkpNMWVQL3ZhdnY3VXhOemNmNDY3UnN0S0w3VmVhWjMzeExSYVJ6aSt6?=
 =?utf-8?B?eWxQcUE1aVdKV2hhOUVSVUhsZ2tLT1lVOHJ3MGNCV1J2dXhQMCtZc1loUTk3?=
 =?utf-8?B?M2FzK0tGbHViMWxIdzhDb3BOUGp0U0lvemJINEU5bkJUQ0phWGIxMkZtOTk5?=
 =?utf-8?B?ZVVkNHNib0RaV3FJR0piYVpWZFJ5aDRwV3paU1VsTmdxZTdMZG9XdktCdnlr?=
 =?utf-8?B?M1VqWUtiK0RBQlBTMUE5VnNRODBXTzg4OS9xT01aRCtsWmM3blVVNXJENzMw?=
 =?utf-8?B?N2VJbTdSUExCNEJmcTcvWDBlZVEzUGMrSEVhM0RBQ1NHaGNYT1hSTFVvU1Js?=
 =?utf-8?B?QXpnQ0w3ck4vb3lWQkdZeHlMOHFsQ1ZIZXUyVzJta0MxVVFiaDJJcXR3aEZz?=
 =?utf-8?B?UnVKL015RHMrdzNBU2c5UDl5Y2xKM3hRbXV3VFVvcUkwVmF1d1QwcHFocjFR?=
 =?utf-8?B?eEFmM0pTRjFpU3FkdFlmTnRIZC81MUg2ODJyK0RkdFoxc0JCTUgzQUJ1UGhn?=
 =?utf-8?Q?OtFjdrAVg13r0kCkV5xSCgE8A?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9D64B126D21264A8FE51285C5A25DFD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50707e4f-be15-4d3d-cd95-08dc48816e54
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 01:59:51.8709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M1iKS0v9OJhLXq+WI1S0js50sMfeiGH5610Ak+nLgF01BbJWSwfvtl6WaBPmzSGh9I1Ch1uRojgPKn0hAUDsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8513
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.945300-8.000000
X-TMASE-MatchedRID: 9zTThWtzImv+DXQl7XSOUia1MaKuob8PofZV/2Xa0cKSO6So6QGgysNq
	SYgiOmwd8cv4yT0rvGNUPHgTUudKRKXzgcphDfm8Q4srjeRbxTZRHIhg1eHfK99RlPzeVuQQLvr
	/pFNuezqvwRreBPMpvT9n/vgRBjkdc2hQ3PtNOqbil2r2x2PwtQreImldQ5BDJO4rwcfXMMqjxY
	yRBa/qJRVHsNBZf9aRAYt5KiTiutkLbigRnpKlKWxlRJiH4397YfnUC/nSg499r3PfjGAgLTnIB
	ZdNV9C15gjEdEkYob8Ev/L0gwCh5w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.945300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	57279CB8335C5ABE780783DC8D4838E0ABA6FC72165C4BFAD4C9448AD3FDE8A52000:8

SGksIFNoYXduOg0KDQpPbiBUdWUsIDIwMjQtMDMtMTkgYXQgMTU6MDIgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgZmlsZXMgbXRrX2RybV9wbGFu
ZS5oIHRvIG10a19wbGFuZS5oLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpYW9jY2hpbm8gRGVsIFJlZ25vIDwN
Cj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBIc2lhbyBDaGllbiBTdW5nIDwNCj4gc2hhd24uc3VuZ0BtZWRpYXRlay5jb3JwLXBhcnRu
ZXIuZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ny
dGMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2NydGMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMgICAgICAgICAgICAgICAgICAgfCAyICst
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgICAgICAg
ICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5j
ICAgICAgICAgICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsve210
a19kcm1fcGxhbmUuaCA9PiBtdGtfcGxhbmUuaH0gfCAwDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsve210a19kcm1fcGxhbmUuaCA9PiBtdGtfcGxhbmUuaH0NCj4gKDEwMCUpDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBpbmRleCA3NzEwZTUzOWUzZGEx
Li4xYmE0N2U2NWEzMmRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2NydGMuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0K
PiBAQCAtMjMsNyArMjMsNyBAQA0KPiAgI2luY2x1ZGUgIm10a19kZHBfY29tcC5oIg0KPiAgI2lu
Y2x1ZGUgIm10a19kcm1fZHJ2LmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9nZW0uaCINCj4gLSNp
bmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICsjaW5jbHVkZSAibXRrX3BsYW5lLmgiDQo+ICAN
Cj4gIC8qDQo+ICAgKiBzdHJ1Y3QgbXRrX2NydGMgLSBNZWRpYVRlayBzcGVjaWZpYyBjcnRjIHN0
cnVjdHVyZS4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0
Yy5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmgNCj4gaW5kZXggZmQ2
YzAwNmYwYzE2OS4uMzg4ZTkwMGI2ZjRkZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19jcnRjLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19jcnRjLmgNCj4gQEAgLTksNyArOSw3IEBADQo+ICAjaW5jbHVkZSA8ZHJtL2RybV9jcnRjLmg+
DQo+ICAjaW5jbHVkZSAibXRrX2RkcF9jb21wLmgiDQo+ICAjaW5jbHVkZSAibXRrX2RybV9kcnYu
aCINCj4gLSNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICsjaW5jbHVkZSAibXRrX3BsYW5l
LmgiDQo+ICANCj4gICNkZWZpbmUgTVRLX01BWF9CUEMJMTANCj4gICNkZWZpbmUgTVRLX01JTl9C
UEMJMw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29t
cC5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IGluZGV4
IGFiOTZiMTAwMWRlM2UuLmMzNDQxNTA4ZjQ1MmYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gQEAgLTE4LDcgKzE4LDcgQEANCj4gICNpbmNsdWRlICJt
dGtfZGRwX2NvbXAuaCINCj4gICNpbmNsdWRlICJtdGtfZGlzcF9kcnYuaCINCj4gICNpbmNsdWRl
ICJtdGtfZHJtX2Rydi5oIg0KPiAtI2luY2x1ZGUgIm10a19kcm1fcGxhbmUuaCINCj4gKyNpbmNs
dWRlICJtdGtfcGxhbmUuaCINCj4gIA0KPiAgDQo+ICAjZGVmaW5lIERJU1BfUkVHX0RJVEhFUl9F
TgkJCTB4MDAwMA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+
IGluZGV4IDkwZTY0NDY3ZWE4ZjguLjA4MmFjMThmZTA0YWEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gQEAgLTksOCArOSw4IEBADQo+ICAjaW5jbHVk
ZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc29j
L21lZGlhdGVrL210ay1tbXN5cy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9t
dGstbXV0ZXguaD4NCj4gLSNpbmNsdWRlICJtdGtfZHJtX3BsYW5lLmgiDQo+ICAjaW5jbHVkZSAi
bXRrX21kcF9yZG1hLmgiDQo+ICsjaW5jbHVkZSAibXRrX3BsYW5lLmgiDQo+ICANCj4gIGludCBt
dGtfYWFsX2Nsa19lbmFibGUoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2FhbF9j
bGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gaW5kZXggNjNhN2EyNDQ2OGMxMy4uOTVhNDMyOGE5YjBi
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBA
IC0xNyw3ICsxNyw3IEBADQo+ICAjaW5jbHVkZSAibXRrX2RkcF9jb21wLmgiDQo+ICAjaW5jbHVk
ZSAibXRrX2RybV9kcnYuaCINCj4gICNpbmNsdWRlICJtdGtfZHJtX2dlbS5oIg0KPiAtI2luY2x1
ZGUgIm10a19kcm1fcGxhbmUuaCINCj4gKyNpbmNsdWRlICJtdGtfcGxhbmUuaCINCj4gIA0KPiAg
c3RhdGljIGNvbnN0IHU2NCBtb2RpZmllcnNbXSA9IHsNCj4gIAlEUk1fRk9STUFUX01PRF9MSU5F
QVIsDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFu
ZS5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5oDQo+IHNpbWlsYXJp
dHkgaW5kZXggMTAwJQ0KPiByZW5hbWUgZnJvbSBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9wbGFuZS5oDQo+IHJlbmFtZSB0byBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX3Bs
YW5lLmgNCg==

