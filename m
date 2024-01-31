Return-Path: <linux-kernel+bounces-45762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D0B8435F1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAE428554A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1380A3D575;
	Wed, 31 Jan 2024 05:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f7kiPZm+";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KmdhZvTi"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A193D54C;
	Wed, 31 Jan 2024 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706678242; cv=fail; b=aZHdIa/lu44q0FtXh+d0g9tn2Os56eXBlVjdW/V3+iZ9p1Zt4kofSNEsTevfIrrUegTR5TTa3MWK6+IaTbs7sIEPZJ49agJ2xGZNeiCYTbriMkN7OM1g+jVzaGV1mdkOfBw750O9RBcMZmSo1hhuD8k1lEZLqizODyk5bYMkQ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706678242; c=relaxed/simple;
	bh=F1syUeGXpzMoucijBDP82/t+HMxJh23LwMs1Qux00pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rwm/abcJWe428DX1ObXxDa1pT2Vlh2MmyliBClBePtkYcDhBGJpspw83GhREbTxfExMYX7LAd9iAvjVN0zhfziWso/LhMRoOqUDVCPcIG/YbrGOeEotxRV66xJ9PVdb1cb0ZMYkHozxjJCbAzdCwhauNwbpa52/cxSGgPbSrHeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f7kiPZm+; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KmdhZvTi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fe997ccabff711eea2298b7352fd921d-20240131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F1syUeGXpzMoucijBDP82/t+HMxJh23LwMs1Qux00pg=;
	b=f7kiPZm+Z05OWMUy5YxEHgzrgJNWeJ9aQycVOuH1CYSHM7Pk9W/SWiXenZiL6GQ6dhg4zTdS0AZjbFD7mBs2FNJu/srxn4m/ruiGRy3W1HNwqeJ8cFP4MRz3w3oykx3huFcCiovxEBIY7RW8mKK+hsVcaR+nhQOm7wjOwxL/pi0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:38a42812-e437-48dc-8ad2-52c31d5ffd4f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:766d7283-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe997ccabff711eea2298b7352fd921d-20240131
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 589531577; Wed, 31 Jan 2024 13:17:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 31 Jan 2024 13:17:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 31 Jan 2024 13:17:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDQ2jCdYJdk+heMMTEBVKEiy6AwDF8YUpW4wcXZ4/0aeY+QLaky6dqaxSO9D02MFNM95qqbxSIR4tJI08lRtIra3VJdN9v+Cfq/RysWNg85yUhXKdv3XOk0NzwNicnYhWh7FUsRcnYdYSJE+ahJUCE5yg+6nxICgZUkKsC3YR0c0JhvlGgtx9zE4HiOTy6mlpMOp0ZK4nFZktqcSPV04fNJ5TtRr98Zh0p8sLRYz4y0etmgkfdScsMdGuDFnX+HtF1j4h3tjHkaL4XjGhGG29A+vunOycvZma24bI+2g3VYRMHqbTYldCJo0sks6dx+myMYjaSguyzj3aBuSdVdRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1syUeGXpzMoucijBDP82/t+HMxJh23LwMs1Qux00pg=;
 b=UTH/1FPZ2mslypd8lfd8CtZI86MmnjYQQRVHkuV5AHUQwokjQZQi4Q0mpmQU9KGlmZPsFI7XrokcVHuKATnxex2UFA1p8P6kPP7ZdMkqeLpmg4qZUob+fyIDjT95rdunLv5i3ydpxgknEHYQZTMi/HjteT57ampRdQW58EPlcyqPRXMssgzrGSuF+HY+8kkUeUFvYwewBeivx0dEpqkf4VMoPRM1fSHI5hZUGO4owbxHOC+eggqf6n5TLk1uo9NjmX2HQyNn4ZpUFXzI1orq05u7fJQCQv4NM7bA5Asip7yAXkdQaXL8dFzABJxDYMrouue9MBO2J7JGjalbPgW1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1syUeGXpzMoucijBDP82/t+HMxJh23LwMs1Qux00pg=;
 b=KmdhZvTi4UOyeCMUlE+Q+cBuqfPqeYHLAPuVi1k0c3IJk2U8ud6IsQ9NxbE0phJPAj8s/iS/fBvvp2KKfiTAV6GatCjyIM/4giq77JzP4vO3Syx6ROo28Zz/4BLTetBfOMNlyqi5zsDnGGtbRxpVQCvhDhgw/rWUY9TN7DmMvRE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB8383.apcprd03.prod.outlook.com (2603:1096:101:220::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Wed, 31 Jan
 2024 05:17:09 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 05:17:08 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "daniel@ffwll.ch" <daniel@ffwll.ch>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "michel@daenzer.net"
	<michel@daenzer.net>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "mikita.lipski@amd.com"
	<mikita.lipski@amd.com>, "dmitry.baryshkov@linaro.org"
	<dmitry.baryshkov@linaro.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"maxime@cerno.tech" <maxime@cerno.tech>, "daniel.vetter@intel.com"
	<daniel.vetter@intel.com>, "nicholas.kazlauskas@amd.com"
	<nicholas.kazlauskas@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "quic_abhinavk@quicinc.com"
	<quic_abhinavk@quicinc.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
	"lucas.demarchi@intel.com" <lucas.demarchi@intel.com>, "sean@poorly.run"
	<sean@poorly.run>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
	"fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "jani.nikula@intel.com"
	<jani.nikula@intel.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "freedreno@lists.freedesktop.org"
	<freedreno@lists.freedesktop.org>
Subject: Re: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
Thread-Topic: [PATCH] drm/atomic-helpers: remove legacy_cursor_update hacks
Thread-Index: AQHaTaau1JBuNr0KqkifWFu/qedV2rDm6fyAgAPwMICACJP+gA==
Date: Wed, 31 Jan 2024 05:17:08 +0000
Message-ID: <1349365de499bae53a8c868738c7270fc16813d5.camel@mediatek.com>
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
	 <20230307145613.xvhru3fpcudlpazt@houat>
	 <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
	 <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>
In-Reply-To: <ZbKlsTEvGPiGtzS3@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB8383:EE_
x-ms-office365-filtering-correlation-id: a175ba57-a917-4e22-47eb-08dc221bdf2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2wbQHNyh3EiuWoreQgd8JrLG558i/lgDA7e6UGaMhuWHdjnhynGLZYUwt9RRRviWffeoWs/2PwXpCj/TxD6gCrseufkcU2jbeL64HcDsf1YVpJnMkgEWwBkoAfIgRZdMsA5njr3ZkTMVZbKz29c3vUkHFL7Mx6EJahKuomNPL01/2Ar+ikP+ZtlfcQgMNmYSZuPlqxRlOQccCC6Hhj5WA1Vl6QxkEMyYRQLMek+GWtuufQ6VyHntNbBhU1aPwCy4KadZe1L88K+gCUNXgmZoQDg/UyXhAN8ENG2OpCJ7sK4r8kQuzVXTq8H1xtcvX/z6XUYX1OOiMWBWA+LG3KZiNQzDqRUe98R22I0u0BOyNVQnGOB2aXE9Sakk6LfA8OBDGgOBb2G+hKDaFkeKGi4TvxbL0vc7yJl0E1//BkRGhXUfQEJ2RNZ+/G9Z5sXrrqMEZnvGKMmbTKK8uIbdK6DDgdmZhzWH9pYp2UzsXCf63tcDHRMw8XS8f1mtcEUKe/9FoJNslaaq/Da7mLpodcXqEj3GXBgKgego9/G1hh8JXepjCwlsg9dsNJ2h5qYbPrxc/f1okGtI5KHKjbwLRi2yV5qOoJGz1rr2kw60V0DuxlT/2EXkdzMnt9IkUAjk4heD9U5bKaLUTeHJte0qYflN59ayRGmwChqgNy3k3rCQJWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(122000001)(36756003)(85182001)(86362001)(41300700001)(71200400001)(6506007)(4326008)(8936002)(8676002)(54906003)(6916009)(316002)(478600001)(64756008)(66446008)(66476007)(6486002)(76116006)(66946007)(66556008)(5660300002)(7416002)(83380400001)(2906002)(6512007)(2616005)(26005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlRsU1NiakZtc0d1ekxnV2tEajg1YjFseW1yNlJrL0p4SVVpUEM3WkR5cG8y?=
 =?utf-8?B?Yng5RWxEdUd6aitROVY0TFJFYTJmSmFPZXFaSmN2Uk0wamtBSjdKdVpFNHhT?=
 =?utf-8?B?QXl6Z3VKamFuTGdpc2RqZ3ljcEZKUEEyNlNwVlVubFY0RTJ0MjhNRXViTlFD?=
 =?utf-8?B?RTg3Qkh2TnR1UmphSm9LZExKM1dtdUo3Wm5CbHl3K3BXbmxJb0dBMytYZXBy?=
 =?utf-8?B?QzZCTzRMWjNsVmc3TXpncVdyOHNQeU50K0oxMmpSR2lwYXE3b2w3Qmt4eHJX?=
 =?utf-8?B?TEhnUlhIeFZyOVUycXh3bnV2N2wwMTg0b2R6alluVXNuQmhnVWQzejNOdzNC?=
 =?utf-8?B?ald6TVhFRHM1Nnl5Sk4rRzdNQllVaDZvMWxiTnRhRFNNOUw2QUZkdUFiSnZw?=
 =?utf-8?B?Y0YrUEd1bnRFWFhtM1E2OFVPQWRRSVZPem83RnVBWVFHU0NnU2k4WFpYdnVr?=
 =?utf-8?B?SjhwM2FHVkVGTS9VOXRiUjJsRFZTejFySE81U09BbFN6S0J2Tm9GUkRvN3lr?=
 =?utf-8?B?VjQwa0huVElqUjlhaDhIRVphMWxJUWUvc2pXNTc1YUovckVjMUpCVDdXZnc2?=
 =?utf-8?B?ZmVkeFNiZkVOWmNnYmUzN3MwYXExZ0EwbVU5dlQ1aVhwOUFxbnp4MnpMcUJU?=
 =?utf-8?B?cFgxd2Z1SW84Y3JhSjF4T2lwS3hrN3M5WXI3emxjQ2ZjckM4VFhxcVZCR0xr?=
 =?utf-8?B?L2l4aHg2cXp6M2xZZDUydHBUYzM1T3N0UXRTUUppSkpnQ2pDREFTYlVMVVZV?=
 =?utf-8?B?YnRQdUJUOGVUZEJrbWZZYzhWMlFLZ3cvTlhCalZUYW5YVzFCSkdLTmxaRm1Y?=
 =?utf-8?B?Y1hpZ2ptTG42N0YyeHJwYmYxNTNZYlErYkpkOXJIL25sWWNHSmFVRzdpU0k3?=
 =?utf-8?B?OEd1ZTJobVJZcWprbkM4VlUrYUF2NGFrVXFoV1pxSEZmaE1UZ3ZMQ2ZZdE43?=
 =?utf-8?B?ekJRR1dsTUx5d251ZmhPVTk2bTB2a0pLV2p1TVkwUGNLWkhPczNpVzBEcVZi?=
 =?utf-8?B?Mnp4bWFJYzBVc0VXZTlGbWVJOVN2OVJMc2RKVWxGbTlpTFJMa1diY2RZSHNM?=
 =?utf-8?B?VmNSRlNyQ2d3WWFWam50ejR4Nm9OUmthVHl5S0YyOTd0VVJyWUJwUisxa0RT?=
 =?utf-8?B?ZGF4Z0g0bkJkc29WM01JTlMvODhJOG1NOVZnVWlXR3RxWTFhOEhzblVNYWJD?=
 =?utf-8?B?aTd2cVBvR2prU0FjREdTYnJJVjVnOWZGTWZQVk5GUlVPZUpuY3RFcTFoTnVP?=
 =?utf-8?B?dmxFLzdvVndSbWROMEFBdGlIcnVCcWhndUtSL2l0NUwvTEY0dndRcFFFOWVh?=
 =?utf-8?B?bjNTd1B6TENHY1owcEw3NFNEMGJIekJIY1YwV1pqN2xiOUdYeFlnbnRFVXox?=
 =?utf-8?B?MFRjWWRBck5jQ0RtbzRFdExYeWlDZXhieTFYdjgzbVFmR29CZHZHUFkwSUhs?=
 =?utf-8?B?T0lpQWU0aStRNkxBbHZjd05MUEJ0cURvelVHd3lXdlBmL2IzNWd4a1NhaXUy?=
 =?utf-8?B?V05ub0dZOHYzUW1rSmIrRG9zeTcyQUxkOTF5TFhTeWpDZVdtSXBsdmVMV3pE?=
 =?utf-8?B?cEoyMkp0M003Y2tvOGliUHl0bG95YXYxVzNQTW9Td0dZbDg2bGpPNXErdE9V?=
 =?utf-8?B?MGJuaG5BQ2t6U0JIWWR3VlRscWM2dzBNS3ZxZ3lNUlNrdkEyS3FiRXJrSkFO?=
 =?utf-8?B?d3B2SUZtTDNJdSs1MkNzVWprN3JXd2QwRjB3dkRVTXU4ZXZ5TjVuU0VlUWRW?=
 =?utf-8?B?aUdlam9OcldlTnJHOThQS0RLa1k2YSt1alByVmFoSjBzMmFpZkRmbWlQdmdE?=
 =?utf-8?B?T3AyOVRFV0ZiVkIwR0x6dHIzTjFGV1IyQkhqb3E5YXlNeXBhOUwxdHpZVnlJ?=
 =?utf-8?B?c2orSWdMa3RrdTRHMXYrcXdnTWY0cUgzYWdVZHJjRWp4RW5IQ1VnQkVhVWdU?=
 =?utf-8?B?d25VUnp2a3VBSlUyUUJWU2RRN3I1Nlk2dWR6cHNLWWJwb3VVMmlldTdWR2hy?=
 =?utf-8?B?VExWOVdyUTcvbHQ4bWRhblpoaU1wbU1UOHFrVFBIQmQveXczM044SWNQU3BI?=
 =?utf-8?B?dUx0cDA0RDgxQnJGOGUwOVVYbGswcHBTZXNtQlZNTUMrMEtDNVp2NEVGYjhC?=
 =?utf-8?B?c3VWSzF3UUJSZW1aaVh0aEhQV1lGa0xPNGtnUGVuUjduUGlSWUM2TDhOblpW?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7668EE16E65BF84C86E5F1B570141355@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a175ba57-a917-4e22-47eb-08dc221bdf2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 05:17:08.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y8CvadDV1Z3/8eMiNibD/SKlX+7H9fRXmU33DWqYEIsSwPlZATz+/WrczJYCcMIyjHHqNPRoKZq7G6/dkZa2CvDgztCysld4NaXI+oPzldY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8383
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.216800-8.000000
X-TMASE-MatchedRID: 0dFPYP4mu5QOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rbaVyalxbpdC8tL8AlQGk8jNvYZHpO13et4laWdJbsDIKwF4K/wIz9p5d
	w0IIWrKQQipsrfhmDl/EhOj/FQgkTOlcsoX/uQ8jN+qWlu2ZxaFAI6wCVrE3vNEJplIoT86xAuX
	BRNXoK5iwXMFPlpsQ1jhJi18RLqAJv4CIIATnzlxT656LDV3kUTJDl9FKHbrl0TRq4bcxmH8VA0
	8S977kgdSeUDaSPgEueU6zuRbTFfa5t5nK2l6NDYR6QE8KYfsgRKRMYqsuVUN9zZd3pUn7KB5/k
	Wgq1QbP51Y9I9gr+WkEan9iSsRLNsi3B2Xfuo4aGwT67eecJ8DFcf92WG8u/R2YNIFh+clEGk2p
	TPAu+9xvbS1sPuc0ruXLKq++rPJdccQ8eam5EfdIFVVzYGjNKWQy9YC5qGvz6APa9i04WGCq2rl
	3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.216800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2FE38DFDE91BA03DDAA495FE1086EAAD440C6EC70E4118A5C456F67ECA8972A62000:8

T24gVGh1LCAyMDI0LTAxLTI1IGF0IDE5OjE3ICswMTAwLCBEYW5pZWwgVmV0dGVyIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIE9uIFR1ZSwgSmFuIDIzLCAyMDI0IGF0IDA2OjA5OjA1QU0gKzAwMDAs
IEphc29uLUpIIExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gPiBIaSBNYXhpbWUsIERhbmllbCwN
Cj4gPiANCj4gPiBXZSBlbmNvdW50ZXJlZCBzaW1pbGFyIGlzc3VlIHdpdGggbWVkaWF0ZWsgU29D
cy4NCj4gPiANCj4gPiBXZSBoYXZlIGZvdW5kIHRoYXQgaW4gZHJtX2F0b21pY19oZWxwZXJfY29t
bWl0X3JwbSgpLCB3aGVuDQo+IGRpc2FibGluZw0KPiA+IHRoZSBjdXJzb3IgcGxhbmUsIHRoZSBv
bGRfc3RhdGUtPmxlZ2FjeV9jdXJzb3JfdXBkYXRlIGluDQo+ID4gZHJtX2F0b21pY193YWl0X2Zv
cl92YmxhbmsoKSBpcyBzZXQgdG8gdHJ1ZS4NCj4gPiBBcyB0aGUgcmVzdWx0LCB3ZSBhcmUgbm90
IGFjdHVhbGx5IHdhaXRpbmcgZm9yIGEgdmxiYW5rIHRvIHdhaXQgZm9yDQo+IG91cg0KPiA+IGhh
cmR3YXJlIHRvIGNsb3NlIHRoZSBjdXJzb3IgcGxhbmUuIFN1YnNlcXVlbnRseSwgdGhlIGV4ZWN1
dGlvbg0KPiA+IHByb2NlZWRzIHRvIGRybV9hdG9taWNfaGVscGVyX2NsZWFudXBfcGxhbmVzKCkg
dG8gIGZyZWUgdGhlIGN1cnNvcg0KPiA+IGJ1ZmZlci4gVGhpcyBjYW4gbGVhZCB0byB1c2UtYWZ0
ZXItZnJlZSBpc3N1ZXMgd2l0aCBvdXIgaGFyZHdhcmUuDQo+ID4gDQo+ID4gQ291bGQgeW91IHBs
ZWFzZSBhcHBseSB0aGlzIHBhdGNoIHRvIGZpeCBvdXIgcHJvYmxlbT8NCj4gPiBPciBhcmUgdGhl
cmUgYW55IGNvbnNpZGVyYXRpb25zIGZvciBub3QgYXBwbHlpbmcgdGhpcyBwYXRjaD8NCj4gDQo+
IE1vc3RseSBpdCBuZWVkcyBzb21lb25lIHRvIGNvbGxlY3QgYSBwaWxlIG9mIGFja3MvdGVzdGVk
LWJ5IGFuZCB0aGVuDQo+IGxhbmQNCj4gaXQuDQo+IA0KDQpHb3QgaXQuIEkgd291bGQgYWRkIHRl
c3RlZC1ieSB0YWcgZm9yIG1lZGlhdGVrIFNvQy4NCg0KPiBJJ2QgYmUgX3ZlcnlfIGhhcHB5IGlm
IHNvbWVvbmUgZWxzZSBjYW4gdGFrZSBjYXJlIG9mIHRoYXQgLi4uDQo+IA0KPiBUaGVyZSdzIGFs
c28gdGhlIHBvdGVudGlhbCBpc3N1ZSB0aGF0IGl0IG1pZ2h0IHNsb3cgZG93biBzb21lIG9mIHRo
ZQ0KPiBsZWdhY3kgWDExIHVzZS1jYXNlcyB0aGF0IHJlYWxseSBuZWVkZWQgYSBub24tYmxvY2tp
bmcgY3Vyc29yLCBidXQgSQ0KPiB0aGluaw0KPiBhbGwgdGhlIGRyaXZlcnMgd2hlcmUgdGhpcyBt
YXR0ZXJzIGhhdmUgc3dpdGNoZWQgb3ZlciB0byB0aGUgYXN5bmMNCj4gcGxhbmUNCj4gdXBkYXRl
IHN0dWZmIG1lYW53aGlsZS4gU28gaG9wZWZ1bGx5IHRoYXQncyBnb29kLg0KPiANCg0KSSB0aGlu
ayBhbGwgdGhlIGRyaXZlcnMgc2hvdWxkIGhhdmUgc3dpdGNoZWQgdG8gYXN5bmMgcGxhbmUgdXBk
YXRlLg0KDQpDYW4gd2UgYWRkIHRoZSBjaGVja2luZyBjb25kaXRpb24gdG8gc2VlIGlmIGF0b21p
Y19hc3luY191cGRhdGUvY2hlY2sNCmZ1bmN0aW9uIGFyZSBpbXBsZW1lbnRlZD8NCg0KUmVnYXJk
cywNCkphc29uLUpILkxpbg0KDQo+IENoZWVycywgU2ltYQ0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+
ID4gSmFzb24tSkguTGluDQo+ID4gDQo+ID4gT24gVHVlLCAyMDIzLTAzLTA3IGF0IDE1OjU2ICsw
MTAwLCBNYXhpbWUgUmlwYXJkIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPiANCj4gPiA+IE9uIFRo
dSwgRmViIDE2LCAyMDIzIGF0IDEyOjEyOjEzUE0gKzAxMDAsIERhbmllbCBWZXR0ZXIgd3JvdGU6
DQo+ID4gPiA+IFRoZSBzdHVmZiBuZXZlciByZWFsbHkgd29ya2VkLCBhbmQgbGVhZHMgdG8gbG90
cyBvZiBmdW4gYmVjYXVzZQ0KPiBpdA0KPiA+ID4gPiBvdXQtb2Ytb3JkZXIgZnJlZXMgYXRvbWlj
IHN0YXRlcy4gV2hpY2ggdXBzZXRzIEtBU0FOLCBhbW9uZw0KPiBvdGhlcg0KPiA+ID4gPiB0aGlu
Z3MuDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgYXN5bmMgdXBkYXRlcyB3ZSBub3cgaGF2ZSBhIG1v
cmUgc29saWQgc29sdXRpb24gd2l0aCB0aGUNCj4gPiA+ID4gLT5hdG9taWNfYXN5bmNfY2hlY2sg
YW5kIC0+YXRvbWljX2FzeW5jX2NvbW1pdCBob29rcy4gU3VwcG9ydA0KPiBmb3INCj4gPiA+ID4g
dGhhdA0KPiA+ID4gPiBmb3IgbXNtIGFuZCB2YzQgbGFuZGVkLiBub3V2ZWF1IGFuZCBpOTE1IGhh
dmUgdGhlaXIgb3duIGNvbW1pdA0KPiA+ID4gPiByb3V0aW5lcywgZG9pbmcgc29tZXRoaW5nIHNp
bWlsYXIuDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgZXZlcnlvbmUgZWxzZSBpdCdzIHByb2JhYmx5
IGJldHRlciB0byByZW1vdmUgdGhlIHVzZS1hZnRlci0NCj4gZnJlZQ0KPiA+ID4gPiBidWcsIGFu
ZCBlbmNvdXJhZ2UgZm9sa3MgdG8gdXNlIHRoZSBhc3luYyBzdXBwb3J0IGluc3RlYWQuIFRoZQ0K
PiA+ID4gPiBhZmZlY3RlZCBkcml2ZXJzIHdoaWNoIHJlZ2lzdGVyIGEgbGVnYWN5IGN1cnNvciBw
bGFuZSBhbmQgZG9uJ3QNCj4gPiA+ID4gZWl0aGVyDQo+ID4gPiA+IHVzZSB0aGUgbmV3IGFzeW5j
IHN0dWZmIG9yIHRoZWlyIG93biBjb21taXQgcm91dGluZSBhcmU6DQo+IGFtZGdwdSwNCj4gPiA+
ID4gYXRtZWwsIG1lZGlhdGVrLCBxeGwsIHJvY2tjaGlwLCBzdGksIHN1bjRpLCB0ZWdyYSwgdmly
dGlvLCBhbmQNCj4gPiA+ID4gdm13Z2Z4Lg0KPiA+ID4gPiANCj4gPiA+ID4gSW5zcGlyZWQgYnkg
YW4gYW1kZ3B1IGJ1ZyByZXBvcnQuDQo+ID4gPiANCj4gPiA+IFRoYW5rcyBmb3Igc3VibWl0dGlu
ZyB0aGF0IHBhdGNoLiBJdCdzIGJlZW4gaW4gdGhlIGRvd25zdHJlYW0gUlBpDQo+ID4gPiB0cmVl
DQo+ID4gPiBmb3IgYSB3aGlsZSwgc28gSSdkIHJlYWxseSBsaWtlIGl0IHRvIGJlIG1lcmdlZCBl
dmVudHVhbGx5IDopDQo+ID4gPiANCj4gPiA+IEFja2VkLWJ5OiBNYXhpbWUgUmlwYXJkIDxtYXhp
bWVAY2Vybm8udGVjaD4NCj4gPiA+IA0KPiA+ID4gTWF4aW1lDQo+IA0K

