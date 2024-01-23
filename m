Return-Path: <linux-kernel+bounces-34757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C0083872A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D3D1F245CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89A50244;
	Tue, 23 Jan 2024 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="a0pvmHcw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aItbUImR"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E534F8B3;
	Tue, 23 Jan 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990572; cv=fail; b=jFMs+fMFyIyFe6wLxfZsvO6+X9gLpIy645nI5rYvC2rFv9VePN9ULLpfCJQOo4exUeWCZZYiiZ76KEoXMREi9EkZmdN51ehWh9yuBZA7gvD32JNJUMRHfpSLgIA9pmSF1TANfsF0peiP4W2a1KbB7dFRzi5+SuzFQI3rCYgLPFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990572; c=relaxed/simple;
	bh=sDB0u/GJzS3T7WwLtFDtirRx4n+HPrX0Q8O91XTjkRg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sFIeqf/7td5VUONWCOXJAM5dv60h0IYt86OjXZQPnLVy/mm7BtDAOCtg7UtgVWqFvyV7y7lNGLzY2WGBQOLRVkETScsEvprSXTra/m5xE5nK6W+ZYWvkQMOeo6Y4cwUwPWtp/Mn0j2fRhA6+nGTos51svfkM703nZl+GU1Yu4t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=a0pvmHcw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aItbUImR; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e38220c8b9b611eea2298b7352fd921d-20240123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sDB0u/GJzS3T7WwLtFDtirRx4n+HPrX0Q8O91XTjkRg=;
	b=a0pvmHcwB+HCotZnLQuR8MyXlF1t07n9gn8oZgNG00BUULLJqyTDIUQINxRmcydGYZepdxhbpHItHDFGdq4Q9bBZw3u4OY9ojuCj2LTDlOLtZbUVbjotqq2j7bu5NU9CPzB2soJVX6vwUccAEIP75S7UXBqu7paRL9Z6xZZEOcE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:ce110975-141b-48ca-b864-6d74edd5c257,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6e16cf4,CLOUDID:f9b0772f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e38220c8b9b611eea2298b7352fd921d-20240123
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1926833074; Tue, 23 Jan 2024 14:16:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 23 Jan 2024 14:16:03 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 23 Jan 2024 14:16:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jf8UD5tAAhycGFkKO/qZXl3eZhMSfLmhuaokkxEDDjVVLaPxLOMmxXVBYozov+1YqbHLSCi1NydpmIt/meYL3FkqsoxhYUjAi6qNZNlfTb0uC9dfkVjVy/vtdRhSnSoFdyQdiFrFvZsYuy5ftHF1IUpj+CVoen6LIjVaDvJAvoZL+K96GqnUw02SRcE7goa28WZbPb4xoa5krCpprGi3bO188hTDb4zYtdFRBnQZg3Bl+SNv6CiQ/I0W7Opm/2nygWUgCZ12x27P2m0xR/JHL4uEXSFpFdlntgHXsoq3vEbDnxbYzG70Ql5lqtF+4ORcDBPwJSKWgBcsYOFR7CUnjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDB0u/GJzS3T7WwLtFDtirRx4n+HPrX0Q8O91XTjkRg=;
 b=X/7uU+Co5IvPe9e37jQbfmV5TrtpsPXplbZUMMOaOsZ09cUBrasNoORzBYRQN8IrNgV6ZpSNo88wq0ywuKIoUwSui2R3TkZHuBrXdfuC6fGCdHPo9Y0uwyr3hU5Rm2IymoJItoetKlJNCOfBMsiDvzs4Kb6/CJRBT5IsjpC7tsixb6uTacJUPg0eD5/56q6ruUXTc6OztuUnPqX8eEdIF6TtCUBViN4ddPDBp6+GXWxkZ98z9no4/rRrx03eYaGetFBQVZP59krP8XPCHQf/vWFAY1oVleYE7txJiNgt8XR1LSy+0URrKSlFV0faXSk7SzSy0TgcBRfeg1SIf9pvHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDB0u/GJzS3T7WwLtFDtirRx4n+HPrX0Q8O91XTjkRg=;
 b=aItbUImR7KwttlqBNhnGQvJpaeM9xgguui+r8+tlWuV+hVXH6Xi7qojgOZ3OMjJrkqz9kbBZ8cOlRxPu3Ppga9cgUT5qM1ng4TjsajJKVvyBnwPCovMPolIDuJfblwjOME6DhAsmUMpYjEHmc5NTUxI7numqszHuT2Qo4NmPotE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7669.apcprd03.prod.outlook.com (2603:1096:820:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 06:09:06 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 06:09:06 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "maxime@cerno.tech" <maxime@cerno.tech>, "daniel.vetter@ffwll.ch"
	<daniel.vetter@ffwll.ch>
CC: "manasi.d.navare@intel.com" <manasi.d.navare@intel.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"michel@daenzer.net" <michel@daenzer.net>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "mikita.lipski@amd.com"
	<mikita.lipski@amd.com>, "dmitry.baryshkov@linaro.org"
	<dmitry.baryshkov@linaro.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"daniel.vetter@intel.com" <daniel.vetter@intel.com>,
	"nicholas.kazlauskas@amd.com" <nicholas.kazlauskas@amd.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
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
Thread-Index: AQHaTaau1JBuNr0KqkifWFu/qedV2rDm6fyA
Date: Tue, 23 Jan 2024 06:09:05 +0000
Message-ID: <aac416742920953999a9ce230ac68139bf5b9790.camel@mediatek.com>
References: <20230216111214.3489223-1-daniel.vetter@ffwll.ch>
	 <20230307145613.xvhru3fpcudlpazt@houat>
In-Reply-To: <20230307145613.xvhru3fpcudlpazt@houat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7669:EE_
x-ms-office365-filtering-correlation-id: 722b04c6-c86b-48d8-9f6c-08dc1bd9ce25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DD1Z3UaNKef19FydhDJmYEpgOiIzpTY+kF7MN6YwFEuTu9Rh5eKoTl7UaoVMaHBbfwy+HGFhwvhOzQBtouFi9MMItb/QveP2GnBZBSiUDsBzX6QYGSatHMKXQS19+y8faWTrtU8gLvseCMH/BqzKBQfBguH8PL2u+RDLW+AgSj9Die0xYHHOqpaZ7FZ5sE+ENKGeEIEkDQbm8iOmZ7SijRnPYjRBdJIphV4x87colbJp75SG7Cizl+NX09W9YoHILKrL+qltFZnTyvVZcjb/V0BYHbmGJ4RFsKaiocmx5z8W8KxRjYngUCZSc+36OdghaLUSWekrg1v0GrrVPiuWwFtx3Ib9uVRFHELPrfjmpTo8PRMT1dk6K2zcd/sXNDaGw6CXhq1euekD0vX3C6SnoydzsF/jDc5Nf9zPAlXpYLNvLYDz4c4fu2RtWdV3dQ30l66HXEIFBmzA+WJatdXklLXiB2GDTD31gzAZKUaky/75JCcGZpGYhTRUqZM7lStNPwJs6lwMmdh4Llj+OHoK7PCsqMxuyz/iwjEqAh5yJ5Fe+G1vVuHFwPQrVKznw2PE+0kTxuDWVZiwybNRc8JLhx8xjHBXMZKscb5ZcTOTrpLgY38OcNyQRpIyFk+tZYsX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(86362001)(71200400001)(2616005)(26005)(122000001)(8676002)(4326008)(8936002)(6512007)(2906002)(38100700002)(41300700001)(5660300002)(7416002)(478600001)(6486002)(66946007)(66446008)(66556008)(54906003)(110136005)(66476007)(316002)(6506007)(64756008)(76116006)(38070700009)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2tWWHhoUkJ5WjFkWGpvN2xhUGpqZFN5TC93YzBXT0IzSWVyak5rYlZNU1dB?=
 =?utf-8?B?cHl4QVlWTU9ZSHpCbFhqOVNaR2FBSmNmeTl0U1RkOHMzTjlySGQyUVZZc1du?=
 =?utf-8?B?ZWJrMUhKMXRCYmpFMXBIRlJ3YWdwTyswcUhnL1Ntd3Y3UmFXdC9tWTM1MXhZ?=
 =?utf-8?B?UFhXYmhvbmp0cTljTzZFSUszK3pXZkhGcHh0RFJZMk9LYTdhYVFnMndQV3Br?=
 =?utf-8?B?d1BUL0t5VGRMTDVwTjhJWWdGaDk0RWYzNWxsLzliNzBHSHY4WjJFaHNOdWV5?=
 =?utf-8?B?bnd3WktuR1lNT1RnSHliNGhmQmxDa2xCaTh6bXdCTkUzdUpYZk9zTVVxTm9M?=
 =?utf-8?B?ck1WcjVTRmUzT2YwaXVlakVJZkZVT0NKcHFicjdmK0RjdVVocEdXV2x1VUIz?=
 =?utf-8?B?SzdtSFBEWUQybFViSmc1VU8zRnErdHRzWUREU0ViUXkzOTFRYlFTN0g4Sm5z?=
 =?utf-8?B?TDdYZG9UYVphSDhQeGlmZjhOVlR3QU5zYVRBQzRkalhLMU5Dd2FPOFdxTEZl?=
 =?utf-8?B?UTFzVFlFd2xCUUR1T0puZTVDNTdsNkVSYTNzSXhlalpNbXpFaXc0ejFyek1R?=
 =?utf-8?B?enU1L2xESy8rWndEQUNlMEo2YzZYK3ZmYWdGSVVVd3RSdlJ2OFJNQkxBUHhr?=
 =?utf-8?B?Zis4R1VyRlNlbVhGOStxRTZ0TFVkY3Y4VkF3QWRmRTk1V2hoQU53amtpU21j?=
 =?utf-8?B?M0lSbWk2UFBHQ2ZQSU5YRzY0emh3U3hiNnM5dHBsaXVGVEtrZUg5Z09CeEJJ?=
 =?utf-8?B?aUVjYTlWekd1bGVBK2hsMy9xTHIrckhwUkMyNEk1QW5DNFE5cGUxUVJra002?=
 =?utf-8?B?MGsrWVh2bXcyZExrWTd5T2dQTWpLYjBJV2tyd0pRcUJnVkQwR0xoaGk4Q1gx?=
 =?utf-8?B?SlQ5c0tuQmlIUEk0OHRLTjB4UmZDSXZicVBIUXRNemlMa0w4L3hsM1RWdklx?=
 =?utf-8?B?b1RnTTQwVWdLVDdFV3BlNVNRTG96QTNXT1VUQ0pEWGpJTTBJSFkvRFdSNndq?=
 =?utf-8?B?MDFMVDVUZlU0Y2p5TEhFTzVtZTczQkwwTTRzQXFLb0FKcytnMTRTK2pxcWU2?=
 =?utf-8?B?UzdDaDhYbUNua0wydEJjUkZleFF0WnlwTlZuSXdxMHpocjk2YnExWmRoc0dn?=
 =?utf-8?B?VFpreXRaeUFjeEd2aHkxT0dsZThEd3BHTHJwUHh6bkd1Q21qR1BmRW10M3M4?=
 =?utf-8?B?dlFsSUo1Snp1enVoZUhQczVEQzdQOTQ5K0dRaXNvM2hVbVdaZWM0S1pGQ3RP?=
 =?utf-8?B?Y05oZWxManFhemFDS0UyVENDaDZwMkh6MjNHMjM4ajFDcXdUaG4wRzdIT3lm?=
 =?utf-8?B?czVld1RXNzVQc0l6TDFpdG90SHBxcDZGTk92bGtzOWZvOTJxVzU2ZVozYnhQ?=
 =?utf-8?B?eHNtTVhCSXI2NkFTc1pJMktLQ1ROcHNKLzI3dHpQMVN3YmpkekJNa1VMd0wv?=
 =?utf-8?B?SEdyTi8yYUEwRHdiRlVlenFlRXhUL3BKV1h5T0hsbFlqdDFVaVVpZ0hQWmVO?=
 =?utf-8?B?Y3YzVlJRR3RFYmk5akZDekQzdkZwczZVRHQ2dlYreGRxa2VDeEpUU3BaQUdN?=
 =?utf-8?B?RU9TVWZmWnpWU3VCdFZKZ3BFRXdoK1dkWHJzUUxJSnVCZHFQdG9lS2RNMnI4?=
 =?utf-8?B?RXpib2JDOWRFMDlMa1R2N3gvMzRCcW5XamtLTEo3ZXBYUEVxV0p1SFg1eDNi?=
 =?utf-8?B?K01ubTVxaG1VQ1pMYjRGUWF3V0x5MjF4ZnpWYnZNc1p0dllyZDNzNzJVTzlZ?=
 =?utf-8?B?am94UVNNdmVIVys3UkRTZ1hZNmJEdWdXMGp6MHZlanNLaENIWkppbzFpV3ZD?=
 =?utf-8?B?L0pFZGF3a3BGOFV6Q3J1d3FOdjhuT0syWlZNRkdPQnJzVE85dWV5VDNHY1ox?=
 =?utf-8?B?Nm1QSTBpVTBjbmcyYUhEa1ZzQ0c2QXBqbDBJc2ZhZExHUmhnUEhHaVZXanhE?=
 =?utf-8?B?enJwYUVSZ1h3V3NkUm9aRTNrMFNBS2g5d2lhTmsxUWNmRHlVTHp4VW5TajdP?=
 =?utf-8?B?WmJJWUtlaDFvclI2emEwaS9hU3J1T3BuZHNqcyszSDZrek9vcFFkOWludWN1?=
 =?utf-8?B?Q1hUS0VCZDNLOTI5TFFjNnc0TkVGYncrbkE5R3NINWtscUtGTk82MXYyT3B2?=
 =?utf-8?B?YlV6eDBZVko1WXAvZzhLMDdiQi9yT1ltb2NFdTJEY2QxaG5HMnFjRjRFN05R?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6927029EB2E954E880589887E9FB932@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722b04c6-c86b-48d8-9f6c-08dc1bd9ce25
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 06:09:05.9569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z3DCtS9pLTiLvpUwDDS9J09eTwRk+kDeSebgiwYKYBFmrHNsTsPlwr+guGG6rSnOhtbg6NJqIQ0/XyHIvMs5UVv+9tRyGi48oVnlG1kphC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7669

SGkgTWF4aW1lLCBEYW5pZWwsDQoNCldlIGVuY291bnRlcmVkIHNpbWlsYXIgaXNzdWUgd2l0aCBt
ZWRpYXRlayBTb0NzLg0KDQpXZSBoYXZlIGZvdW5kIHRoYXQgaW4gZHJtX2F0b21pY19oZWxwZXJf
Y29tbWl0X3JwbSgpLCB3aGVuIGRpc2FibGluZw0KdGhlIGN1cnNvciBwbGFuZSwgdGhlIG9sZF9z
dGF0ZS0+bGVnYWN5X2N1cnNvcl91cGRhdGUgaW4NCmRybV9hdG9taWNfd2FpdF9mb3JfdmJsYW5r
KCkgaXMgc2V0IHRvIHRydWUuDQpBcyB0aGUgcmVzdWx0LCB3ZSBhcmUgbm90IGFjdHVhbGx5IHdh
aXRpbmcgZm9yIGEgdmxiYW5rIHRvIHdhaXQgZm9yIG91cg0KaGFyZHdhcmUgdG8gY2xvc2UgdGhl
IGN1cnNvciBwbGFuZS4gU3Vic2VxdWVudGx5LCB0aGUgZXhlY3V0aW9uDQpwcm9jZWVkcyB0byBk
cm1fYXRvbWljX2hlbHBlcl9jbGVhbnVwX3BsYW5lcygpIHRvICBmcmVlIHRoZSBjdXJzb3INCmJ1
ZmZlci4gVGhpcyBjYW4gbGVhZCB0byB1c2UtYWZ0ZXItZnJlZSBpc3N1ZXMgd2l0aCBvdXIgaGFy
ZHdhcmUuDQoNCkNvdWxkIHlvdSBwbGVhc2UgYXBwbHkgdGhpcyBwYXRjaCB0byBmaXggb3VyIHBy
b2JsZW0/DQpPciBhcmUgdGhlcmUgYW55IGNvbnNpZGVyYXRpb25zIGZvciBub3QgYXBwbHlpbmcg
dGhpcyBwYXRjaD8NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQpPbiBUdWUsIDIwMjMtMDMt
MDcgYXQgMTU6NTYgKzAxMDAsIE1heGltZSBSaXBhcmQgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24g
VGh1LCBGZWIgMTYsIDIwMjMgYXQgMTI6MTI6MTNQTSArMDEwMCwgRGFuaWVsIFZldHRlciB3cm90
ZToNCj4gPiBUaGUgc3R1ZmYgbmV2ZXIgcmVhbGx5IHdvcmtlZCwgYW5kIGxlYWRzIHRvIGxvdHMg
b2YgZnVuIGJlY2F1c2UgaXQNCj4gPiBvdXQtb2Ytb3JkZXIgZnJlZXMgYXRvbWljIHN0YXRlcy4g
V2hpY2ggdXBzZXRzIEtBU0FOLCBhbW9uZyBvdGhlcg0KPiA+IHRoaW5ncy4NCj4gPiANCj4gPiBG
b3IgYXN5bmMgdXBkYXRlcyB3ZSBub3cgaGF2ZSBhIG1vcmUgc29saWQgc29sdXRpb24gd2l0aCB0
aGUNCj4gPiAtPmF0b21pY19hc3luY19jaGVjayBhbmQgLT5hdG9taWNfYXN5bmNfY29tbWl0IGhv
b2tzLiBTdXBwb3J0IGZvcg0KPiA+IHRoYXQNCj4gPiBmb3IgbXNtIGFuZCB2YzQgbGFuZGVkLiBu
b3V2ZWF1IGFuZCBpOTE1IGhhdmUgdGhlaXIgb3duIGNvbW1pdA0KPiA+IHJvdXRpbmVzLCBkb2lu
ZyBzb21ldGhpbmcgc2ltaWxhci4NCj4gPiANCj4gPiBGb3IgZXZlcnlvbmUgZWxzZSBpdCdzIHBy
b2JhYmx5IGJldHRlciB0byByZW1vdmUgdGhlIHVzZS1hZnRlci1mcmVlDQo+ID4gYnVnLCBhbmQg
ZW5jb3VyYWdlIGZvbGtzIHRvIHVzZSB0aGUgYXN5bmMgc3VwcG9ydCBpbnN0ZWFkLiBUaGUNCj4g
PiBhZmZlY3RlZCBkcml2ZXJzIHdoaWNoIHJlZ2lzdGVyIGEgbGVnYWN5IGN1cnNvciBwbGFuZSBh
bmQgZG9uJ3QNCj4gPiBlaXRoZXINCj4gPiB1c2UgdGhlIG5ldyBhc3luYyBzdHVmZiBvciB0aGVp
ciBvd24gY29tbWl0IHJvdXRpbmUgYXJlOiBhbWRncHUsDQo+ID4gYXRtZWwsIG1lZGlhdGVrLCBx
eGwsIHJvY2tjaGlwLCBzdGksIHN1bjRpLCB0ZWdyYSwgdmlydGlvLCBhbmQNCj4gPiB2bXdnZngu
DQo+ID4gDQo+ID4gSW5zcGlyZWQgYnkgYW4gYW1kZ3B1IGJ1ZyByZXBvcnQuDQo+IA0KPiBUaGFu
a3MgZm9yIHN1Ym1pdHRpbmcgdGhhdCBwYXRjaC4gSXQncyBiZWVuIGluIHRoZSBkb3duc3RyZWFt
IFJQaQ0KPiB0cmVlDQo+IGZvciBhIHdoaWxlLCBzbyBJJ2QgcmVhbGx5IGxpa2UgaXQgdG8gYmUg
bWVyZ2VkIGV2ZW50dWFsbHkgOikNCj4gDQo+IEFja2VkLWJ5OiBNYXhpbWUgUmlwYXJkIDxtYXhp
bWVAY2Vybm8udGVjaD4NCj4gDQo+IE1heGltZQ0K

