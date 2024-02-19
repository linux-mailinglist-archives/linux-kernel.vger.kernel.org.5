Return-Path: <linux-kernel+bounces-70650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A64859AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39ADB1C20895
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD521FA3;
	Mon, 19 Feb 2024 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sWoFqtSJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XVV+1y/Q"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710051C3E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708309730; cv=fail; b=FC0uX4ULPTPxhAub2G+GYmJRIrl0GSNHfcB9EgokL7tBxw5iwqpX27zpg4u8qMMgABSMQM6f5ZfXKZHXwexLSZr5/vFCn8i9TtvOqkNuxzPa923zZ+api7QoYW8DeEYlO4VXzdNIqxBOX3LsfBklDVBj+hcFuMw6jlOWINxgTMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708309730; c=relaxed/simple;
	bh=Eo7+UwludMKaT6gc5shQLTImq8z66gVceiVNXPTMTLU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqWkNyRWb6n3vQsrKIB2ZAKUcRqKj1acE8gwR9+GNVJ5S1sz7Qtc8ZIUfD6st4EqlP7Xq7sVrrxiuBrCFS8xmpLd2EVVQK4yxY1W8npczRWuhB+8iW+kT7vGiiYNkCebz8ym0O+vNwsUGTm4iIbbcl/WrP+8TJxAuVu+8BHEu48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sWoFqtSJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XVV+1y/Q; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 990cf4e6cece11ee9e680517dc993faa-20240219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=Eo7+UwludMKaT6gc5shQLTImq8z66gVceiVNXPTMTLU=;
	b=sWoFqtSJ11zfyLHIwBFwYTuaXmyaLSjA027eNU5hju68V2eHC460nPJh5PwETp1hFWWalyCTHjcaV5zRVxZ/oJO4hj6lw8eUhcJmxf+WtB3at8Y4s4a51r0qeuDLxMV1KpYrK4bKRK/HaQGetK4XW32zRaG6w9wgG3Yf6fJS1+I=;
X-CID-CACHE: Type:Local,Time:202402191006+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:686a84c8-3f52-472e-9473-60c90abe2c28,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:67a88880-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 990cf4e6cece11ee9e680517dc993faa-20240219
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 440428675; Mon, 19 Feb 2024 10:28:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Feb 2024 10:28:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Feb 2024 10:28:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGW/4/BmDNAADeIyffIFRGNTZDEtWTgzY+ykJb7xKFNUQlWmPUCldIiMjV5fJaxoUc5ZsXHIJX1FnhbRSRBb/poni+ZgnuPNJi+Bu4SOTC/5L95sLS5b7cXOforMMmEYAwlWfe8mIF7iYzQLdypxD1U4AHqQR0vFldegTYYtqhv0bjg3004tNv5iqu4HTo3RqwqyKQQxX3slxBurcS39Xofd5rTgb3IjT5INGIja4DfAU1flgrdeIZ8NWzhUNlpI/rBsqaqCdlL3QynwgxM3AjNPm8tGkEr/ZdLKiS91lHxHzTeB4tU8TqpEncMl/KUFCNiZKGbAIFdZgVKSKBOg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eo7+UwludMKaT6gc5shQLTImq8z66gVceiVNXPTMTLU=;
 b=c6CYzxtpGTUhXAfVdYaHFlpknpH4MA+nWPA7pj0X9whDMrcm546fO7FQHnpZ+U+9idD0jfDRonti1AUY+7oORgAYrQl5eTo+sXc/aQcBlkivkV5eO7+ltuVYVk71DvInNvs6ibCkYbybP271PeYe2sQRmbXFRqJz8X7RAzxexoMgKSdD4xjor4Ty3VkjNlKVSzzPZ4yc1LMZsicDqUp/Ug4QjddJnitgM1PGyIS70iQLGGF/HyA0XHT2JavCtdbzSi6PS6W0bUCd8THRuvaSdQ7R+NL96Yyg6CktEkPVqQhvZkdLrT11RfIOb/T8/QNcUydbrHoF0LDKOPWZaK3HkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eo7+UwludMKaT6gc5shQLTImq8z66gVceiVNXPTMTLU=;
 b=XVV+1y/QVw/K+ge2b9sttoGYHVEDytOA0M086/K+vKJtQ4aVvQ8H5bWi4JnaJDREOMdyUwdvzi9aOaInsiQQFMYTV/XyKOgphfZkVkYuM3kFusUO6PX8XGMCpWrgJHjyetlnGBl83A+V4vjqtdWfdx9Qjjcb4XWvSNVwB+uaOSY=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEZPR03MB7631.apcprd03.prod.outlook.com (2603:1096:101:10d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 02:28:38 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7292.026; Mon, 19 Feb 2024
 02:28:38 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Thread-Topic: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Thread-Index: AQHaX/dpb4xX9vYSDEyAoA9XDt3r1rENNImAgAADoICAA76XgA==
Date: Mon, 19 Feb 2024 02:28:38 +0000
Message-ID: <574c4d570ea4c1c7170ce7e0652c342b8ccbb5af.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-11-shawn.sung@mediatek.com>
	 <Zc-Vq2MeG9X37JJe@phenom.ffwll.local> <Zc-YtaJV1-EMiJoC@phenom.ffwll.local>
In-Reply-To: <Zc-YtaJV1-EMiJoC@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEZPR03MB7631:EE_
x-ms-office365-filtering-correlation-id: 806efca4-67e2-4d43-467c-08dc30f27b2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Da5oqXDfaJViro0zjVpwNNYuiVYI6MHvNYJTs2ExnKo+/kqlDnu3QpIGqwvxDXgGi46tV5GnAifnsXkMAjRDif0E78LYJyuEvEkJ7AQUL+YgvXoH+2Ziq6MTKyPqXPBsqBmivtbEZOgc6AnZzeLUKURZcQOMpu41fJYqro9NaKa47N5QSh7Rb+LOKtcMxWSj6wO+uiajto94UyJZ01f0tTsR06ZcjPf6ppLMKjSfUVS66s6/LAmA+YdUmzDvzW6VzTGQUjygC7Ny9E19eiX//aycilzmia6rLHIL/dTbn3cka9L4wUBxLSahXk9sYVQf1nbjtPViLApwUCiHUUOXNRZ3ZFrIo2IWNqfvCukaWn27lvRygcpm+ub8unJUz7SnZ4OIqHBYb+KrkxQHUwI+8lgGeKKMNPxirjLdG3Nhxpi54f681kuRXyapEa20xIxnyWdurKq+8wr49x1ZHtbV/WfReQo6Aa0NhRrrDG8+GoefTu79laSXa1zEc9efdtHwek38gaY64msFtS6BZCYS+1fb3kpiFQRyZl7TjCmrKXxN8O8dSAFIAmz0GIBPNm5H0VwD3wabR/7G1jxmNi+WcyT3mrsMvWa2QyTqSkL/VfN81V8B74/zm0oKYKFRNPxmpGY+ke90HzS50Sun6dnLYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(39860400002)(346002)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(83380400001)(122000001)(38100700002)(2906002)(64756008)(66946007)(8676002)(66446008)(76116006)(8936002)(7416002)(66476007)(66556008)(5660300002)(71200400001)(26005)(2616005)(110136005)(6506007)(478600001)(316002)(6512007)(6486002)(41300700001)(921011)(38070700009)(85182001)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGNvaXROeHlPZHliVTBuWXRXak5DNkxDWDl3RUdqMi9MWlVSLzE0MnNDM0Fr?=
 =?utf-8?B?ekhWRGdVV1hyYnNENnZvMFpTOFd1bEpXMHFJcnBDMFNzK09KMStrVHd4YXRK?=
 =?utf-8?B?dE8ydGo0UW1ZSld0WkZsc2VDYXl5TXM5Snhvd1dqb3lmZVEwTzcvTitHNkRS?=
 =?utf-8?B?dXRTb3NxVlVRL1RrbWVNcmNyYWUwcWwvRlJ0QlROUlpLa28wZ1Btb3FkQmdF?=
 =?utf-8?B?bS9sTU90d0pjSHpiZmQ0MWlKbklqazNwRVdNb2wreXNJc1ZDdWVWWWJXcTdQ?=
 =?utf-8?B?U3ZLSENmZlNpMVYvSEFYc0xsZ21OWnFicStvMTI0Wmt0aE43NFpFQjVFb05K?=
 =?utf-8?B?akovUXQ1aXNGd1Mwd1lqY0QxK3pIQ2M3TlIzcmU4TmdDZXBrQ1FIYm91UFRR?=
 =?utf-8?B?Z0IzSXNIa0IyeUVOUVRnWWt0a2lLNVBKa29HaTFTYXBuVWNxZzNiQnBKOW1o?=
 =?utf-8?B?Mm5WRXl5NXB1NGRCc3NJalVLMjQrOGVRbmFucEp1Z3JJNGhQc2VITzA2MnpV?=
 =?utf-8?B?ckwyajBVc0FFS3dQeEVSSG9DWEVEMkplSlJnTlZUV2V1R0pleU1YTVBzaUZm?=
 =?utf-8?B?bTRwMjhpekZQam1NYnl4RWorRzdpU0dadUJlUGJpdWx0SzVsU1EyZ3lYVlZP?=
 =?utf-8?B?MHhsR1RvT1VvTXExbXpVS09FUFVjVm9yemJvMWY1ZWoraGsyQS9IVFg2NGN0?=
 =?utf-8?B?TW9sMUc4Y0hHSlE0dEkyWTdzYUZoeHVuY2FDUm8yc2M2VWlRVldrNWk1Q1Zs?=
 =?utf-8?B?WjI4QWhLajlUZjJKMUNVOFBNdmZhb3BsMHpQdDRqL21SK0g0MkNHZVBwZHlp?=
 =?utf-8?B?b210TnBwQlU5V0NMWnZVQ1VyUm42OGxkT0hQbUZEb0VsZllWS1FRRnRKcExI?=
 =?utf-8?B?SlVCb2FGaDJINWY3cHdLclh1c2NMZEJScjlZREh2Y0lyZFE5MjlCVXl3RW1v?=
 =?utf-8?B?NmpZalhOZ2toa2ZaaUFxb3J5Q3NxR21BWEo5RmNoQ3ROaUtXUnN3eER4MVNL?=
 =?utf-8?B?azllcXFZSDRSY01YTVV3ZDY3YUtjMmpsb3hSMEc0VjRUUlptNmNiT2J3L2pU?=
 =?utf-8?B?OTlGMEJvMkgyK3hKSERSRENXZmtXOUNLTFdRL0FvcUIxai9STStkVzN0a01W?=
 =?utf-8?B?T2FlNCtWMEQvR1NnellGNVRwV3JiVC9kWTBsYVpjS3loTWRBTGtHWkVzSG9L?=
 =?utf-8?B?K3loSUtKdnNtYUZRQWdNQkt6SU1OZ3VYNHJuOHl0ZlJaRjh3QXJPazUwclF6?=
 =?utf-8?B?aFNFZU90MGQ2L2RHZ0pUbTdJNnAxVnlYYnVMOHBiRjdSZXVGL3VHTWpGRms5?=
 =?utf-8?B?djJUWTlCbXQzNXRDYUcvT1JNOXBlK2J1eDBxTURSMEdZbTQ0eEQxdjNldEFj?=
 =?utf-8?B?aVRWcng3bndnOXBpaUdRSVJmNmpDWkw3LzZyK2pqamJYZWlZR041dzVoUVlP?=
 =?utf-8?B?SnRYMUV1SVAwNGRUeUN4aXRiRGNsSzd5VzdlRDRHOUdpbTNFOUo3eWk2VjdK?=
 =?utf-8?B?bU54Z3BUdURvR3YxNVdtMU11MWVjVFNKa2tqWU1NNkczcXRJZnRhN2NMd2lB?=
 =?utf-8?B?VnRzdlUyWUFIaVdKSEZiQWZhYVVxWVJzclUrVHI0cis3eUNhYzFDbTJJVkIv?=
 =?utf-8?B?K3FkTTdzUmtFRVl4eGQ1eTlvWk1aSUJRMi9ZaFBKcTdqZ2N6ZnZpK0J0NENp?=
 =?utf-8?B?ckNQc1pudTcraGZNNiswVmlwUjRZaGF2YVZSNWZ4L1lyUk9WZlZOYzVxZGFO?=
 =?utf-8?B?Y0haUG04RVBOa21CVkZUSEgrY2NtdEZZOWQ4bXNjQllmd2JYQWE2V2Q0eW16?=
 =?utf-8?B?MThXaHFSNVpUVE9nb2RnRU5lVDBneHZ3MGg4OUc0VDdJSHJXYmltNUZBQmV1?=
 =?utf-8?B?ckFMRTJWK3R1Mk5naVFyakNwYmc0cEdKSFBxaHQzaFZKSEw5bHEvLy9uT2dH?=
 =?utf-8?B?WDVqd25YTDdPL2UyMWc3dCtlTlFzcjBJaHhDRGc1dnVMVm9OY2xMQlUreElB?=
 =?utf-8?B?c3VpODB4TVp3TzNZNWo1RHBwZGF4OUhUNWI3c3ovUmJocmVycmZPSGJZQmZZ?=
 =?utf-8?B?SmNRYm01ZkovK1RKaEdmQ0k3MGpKempvNlVhMDBWdENnQkIrQnk0STNlYU0r?=
 =?utf-8?B?RHc1WjQxSWJNYmxIY3h0Ly9Bb3lKL2M1aGlYSUtCbm1TQVJDaElpbzc0akVQ?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <975340A571D04E488136E7EFBF02FED9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806efca4-67e2-4d43-467c-08dc30f27b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 02:28:38.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rWRQJqa6sDrJD4zgqUDrpaPpy2rPVoumis9XpEfB7kCZaQ06DyEFfGyJka9gTi4mt8XdEiP30VSx720XQf96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7631

SGkgRGFuaWVsLA0KDQpPbiBGcmksIDIwMjQtMDItMTYgYXQgMTg6MTcgKzAxMDAsIERhbmllbCBW
ZXR0ZXIgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gRnJpLCBGZWIgMTYsIDIwMjQgYXQgMDY6
MDQ6NDNQTSArMDEwMCwgRGFuaWVsIFZldHRlciB3cm90ZToNCj4gPiBPbiBUaHUsIEZlYiAxNSwg
MjAyNCBhdCAwNjoxMToxNlBNICswODAwLCBIc2lhbyBDaGllbiBTdW5nIHdyb3RlOg0KPiA+ID4g
UmVnaXN0ZXIgQ1JDIHJlbGF0ZWQgZnVuY3Rpb24gcG9pbnRlcnMgdG8gc3VwcG9ydA0KPiA+ID4g
Q1JDIHJldHJpZXZhbC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4g
U3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgIHwgMjM5DQo+ICsrKysrKysrKysr
KysrKysrKysrDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5o
ICAgICB8ICAzOSArKysrDQo+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuaCB8ICAgMyArDQo+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAyODEgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0
Yy5jDQo+ID4gPiBpbmRleCAxNGNmNzVmYTIxN2Y5Li42Y2IxZWQ0MTlkZWU3IDEwMDY0NA0KPiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiA+IEBAIC02
OCw2ICs2OCw5IEBAIHN0cnVjdCBtdGtfZHJtX2NydGMgew0KPiA+ID4gIC8qIGxvY2sgZm9yIGRp
c3BsYXkgaGFyZHdhcmUgYWNjZXNzICovDQo+ID4gPiAgc3RydWN0IG11dGV4aHdfbG9jazsNCj4g
PiA+ICBib29sY29uZmlnX3VwZGF0aW5nOw0KPiA+ID4gKw0KPiA+ID4gK3N0cnVjdCBtdGtfZGRw
X2NvbXAqY3JjX3Byb3ZpZGVyOw0KPiA+ID4gK3Vuc2lnbmVkIGludGZyYW1lczsNCj4gPiA+ICB9
Ow0KPiA+ID4gIA0KPiA+ID4gIHN0cnVjdCBtdGtfY3J0Y19zdGF0ZSB7DQo+ID4gPiBAQCAtNjM1
LDYgKzYzOCwxNCBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZHBfaXJxKHZvaWQgKmRhdGEpDQo+
ID4gPiAgc3RydWN0IGRybV9jcnRjICpjcnRjID0gZGF0YTsNCj4gPiA+ICBzdHJ1Y3QgbXRrX2Ry
bV9jcnRjICptdGtfY3J0YyA9IHRvX210a19jcnRjKGNydGMpOw0KPiA+ID4gIHN0cnVjdCBtdGtf
ZHJtX3ByaXZhdGUgKnByaXYgPSBjcnRjLT5kZXYtPmRldl9wcml2YXRlOw0KPiA+ID4gK3N0cnVj
dCBtdGtfZGRwX2NvbXAgKmNvbXAgPSBtdGtfY3J0Yy0+Y3JjX3Byb3ZpZGVyOw0KPiA+ID4gKw0K
PiA+ID4gKy8qDQo+ID4gPiArICogY3JjIHByb3ZpZGVycyBzaG91bGQgbWFrZSBzdXJlIHRoZSBj
cmMgaXMgYWx3YXlzIGNvcnJlY3QNCj4gPiA+ICsgKiBieSByZXNldHRpbmcgaXQgaW4gLmNyY19y
ZWFkKCkNCj4gPiA+ICsgKi8NCj4gPiA+ICtpZiAoY3J0Yy0+Y3JjLm9wZW5lZCkNCj4gPiA+ICtj
b21wLT5mdW5jcy0+Y3JjX3JlYWQoY29tcC0+ZGV2KTsNCj4gPiA+ICANCj4gPiA+ICAjaWYgSVNf
UkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gPiA+ICBpZiAoIXByaXYtPmRhdGEtPnNoYWRv
d19yZWdpc3RlciAmJiAhbXRrX2NydGMtPmNtZHFfY2xpZW50LmNoYW4pDQo+ID4gPiBAQCAtNjQ2
LDYgKzY1NywyNCBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y19kZHBfaXJxKHZvaWQgKmRhdGEpDQo+
ID4gPiAgaWYgKCFwcml2LT5kYXRhLT5zaGFkb3dfcmVnaXN0ZXIpDQo+ID4gPiAgbXRrX2NydGNf
ZGRwX2NvbmZpZyhjcnRjLCBOVUxMKTsNCj4gPiA+ICAjZW5kaWYNCj4gPiA+ICsNCj4gPiA+ICsv
Kg0KPiA+ID4gKyAqIGRybV9jcnRjX2FkZF9jcmNfZW50cnkoKSBjb3VsZCB0YWtlIG1vcmUgdGhh
biA1MG1zIHRvIGZpbmlzaA0KPiA+ID4gKyAqIHB1dCBpdCBhdCB0aGUgZW5kIG9mIHRoZSBpc3IN
Cj4gPiA+ICsgKi8NCj4gPiANCj4gPiBVaCB0aGlzIGxvb2tzIHJlYWxseSBzY2FyeSwgZXNwZWNp
YWxseSBzaW5jZSB5b3UgcHV0IHRoaXMgYmVmb3JlDQo+IHRoZSBjYWxsDQo+ID4gdG8gZHJtX2Ny
dGNfaGFuZGxlX3ZibGFuayBpbiB0aGUgZnVuY3Rpb24gYmVsb3csIHdoaWNoIHJlYWxseQ0KPiBz
aG91bGRuJ3QgYmUNCj4gPiB1bmVjZXNzYXJpbHkgZGVsYXllZCAoYmVjYXVzZSB0aGF0J3MgdGhl
IG9uZSB0aGF0IHRha2VzIHRoZSB2YmxhbmsNCj4gPiB0aW1lc3RhbXApLg0KPiA+IA0KPiA+IFRo
aXMgc291bmRzIGxpa2UgdGhlIHBlcmZlY3QgYXBwbGljYXRpb24gZm9yIGEgdmJsYW5rIHdvcmtl
cg0KPiB0aG91Z2gsIHNvDQo+ID4geW91IHBsZWFzZSBsb29rIGludG8gZHJtX3ZibGFua193b3Jr
LmguIEFuZCBpZiB0aGF0IGlzIG5vdCB1c2VhYmxlDQo+IGR1ZSB0bw0KPiA+IGhhcmR3YXJlIGNv
bnN0cmFpbnQsIHRoZW4gcGxlYXNlIGV4cGxhaW4gaW4gYSBjb21tZW50IGhlcmUgYW5kIGluDQo+
IHRoZQ0KPiA+IGNvbW1pdCBtZXNzYWdlIHdoeSB5b3UgY2Fubm90IHVzZSB0aGF0IGFuZCBoYXZl
IHRvIHJvbGwgeW91ciBvd24uDQo+IHZibGFuaw0KPiA+IHdvcmsgcmVhbGx5IHNob3VsZCBiZSB5
b3VyIGZpcnN0IGNob2ljZSBoZXJlLCBiZWNhdXNlOg0KPiA+IC0gaXQncyBkZXNpZ25lZCBmb3Ig
ZXhwZW5zaXZlIHZibGFuayB3b3JrDQo+ID4gLSBpdCBnaXZlcyB5b3UgYWxsIHRoZSBmbHVzaC9j
YW5jZWxfc3luYyBmdW5jdGlvbnMgeW91IG5lZWQgZm9yDQo+IGRpc2FibGluZw0KPiA+ICAgY3Jj
IGFnYWluLCBhbmQgaW4gYSByYWNlLWZyZWUgaW1wbGVtZW50YXRpb24uIE11Y2ggYmV0dGVyIHRv
IHVzZQ0KPiBjb21tb24NCj4gPiAgIGNvZGUgdGhhbiB0byByZWludmVudCBzeW5jaHJvbml6YXRp
b24gd2hlZWxzIGluIGRyaXZlcnMgOi0pDQo+ID4gDQo+ID4gPiAraWYgKGNydGMtPmNyYy5vcGVu
ZWQpIHsNCj4gPiANCj4gPiBCZWNhdXNlIHRoaXMgaXMgcHJvYmFibHkgbm90IHJhY2UtZnJlZSwg
c28gd2UgbmVlZCBzb21ldGhpbmcgc29saWQNCj4gaGVyZS4NCj4gDQo+IFNpbmNlIGl0J3MgbWF5
YmUgYSBiaXQgdHJpY2t5IHRvIHNlZSBob3cgdG8gdXNlIGRybV92Ymxhbmtfd29yazoNCj4gDQo+
IC0gaW4geW91ciBjcnRjIGluaXRpYWxpemF0aW9uIHlvdSBhbHNvIG5lZWQgdG8gc2V0dXAgdGhl
IGNyYyB3b3JrDQo+IHdpdGgNCj4gICBkcm1fdmJsYW5rX3dvcmtfaW5pdCgpLg0KPiAtIFlvdXIg
bXRrX2RybV9jcnRjX3NldF9zb3VyYyBuZWVkcyB0byBhY3R1YWxseSBlbmFibGUgdGhlIGNyYyBi
eQ0KPiBjYWxsaW5nDQo+ICAgZHJtX3ZibGFua193b3JrX3NjaGVkdWxlIGZvciBjdXJyZW50IHZi
bGFuayArIDEsIHNvIHRoYXQgaXQNCj4gaW1tZWRpYXRlbHkNCj4gICBzdGFydHMNCj4gLSB5b3Vy
IHZibGFuayB3b3JrZXIgaXRzZWxmIG5lZWRzIHRvIGFnYWluIHJlLWFybSBpdHNlbGYgd2l0aA0K
PiAgIGRybV92Ymxhbmtfd29ya19zY2hlZHVsZSwgYWdhaW4gZm9yIHRoZSB2ZXJ5IG5leHQgdmJs
YW5rDQo+IC0gdGhlbiB5b3VyIHNldF9zb3VyY2UgYWxzbyBuZWVkcyB0byBoYW5kbGUgdGhlIGNh
c2Ugd2hlcmUgeW91DQo+IGRpc2FibGUgdGhlDQo+ICAgY3JjIGFnYWluIChzb3VyY2UgPT0gTlVM
TCkgYnkgY2FsbGluZyBkcm1fdmJsYW5rX3dvcmtfY2FuY2VsX3N5bmMNCj4gLSBhbHNvIHlvdSBw
cm9iYWJseSBuZWVkIHRvIGNhbGwgZHJtX3ZibGFua193b3JrX2ZsdXNoIHdoZW4gc2h1dHRpbmcN
Cj4gZG93bg0KPiAgIHRoZSBjcnRjLCBvciB5b3UgbWlnaHQgaGF2ZSB1c2UtYWZ0ZXItZnJlZSBp
c3N1ZXMgb24gZHJpdmVyIHVubG9hZC4NCj4gICBDb3VsZCBwcm9iYWJseSBhbHNvIGp1c3QgcHV0
IHRoYXQgaW4geW91ciBjcnRjIHJlbGVhc2UgZnVuY3Rpb24uDQo+IA0KPiBObyBjaGFuZ2VzIHRv
IHlvdXIgaW50ZXJydXB0IGhhbmRsZXIgbmVlZGVkLCBhbmQgYWxzbyBkZWZpbml0ZWx5IG5vDQo+
IGRpZ2dpbmcgYXJvdW5kIGluIGRybV9jcnRjLT5jcmMgZGF0YSBzdHJ1Y3R1cmUgd2l0aG91dCBs
b2NraW5nIC0NCj4gdGhhdCdzDQo+IGVudGlyZWx5IGludGVybmFsIHRvIHRoZSBjb21tb24gY3Jj
IGNvZGUgYW5kIGRyaXZlcnMgbXVzdCBuZXZlciBsb29rDQo+IGludG8gaXQuDQo+IA0KDQpJIGFt
IGRlZXBseSBhcHByZWNpYXRpdmUgZm9yIHRoZSBpbmZvcm1hdGlvbiB5b3UgaGF2ZSBzaGFyZWQu
IFdpbGwgdHJ5DQp0byBpbXBsZW1lbnQgaXQgd2l0aCBEUk1fdmJsYW5rX3dvcmsgQVBJcy4NCg0K
U2luY2VyZWx5LA0KU2hhd24NCg==

