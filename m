Return-Path: <linux-kernel+bounces-89980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D186F893
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6390A1F213FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78066127;
	Mon,  4 Mar 2024 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R5DPmOb4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cxBHfier"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E7522D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709519419; cv=fail; b=NNrdtn78PH8QWntNYNqOONjYEjhmnQDL/BzZQx45HEpCFcuir6Vil6nvf2gKBmoylCMBuOmsCp56nZvk3HoVJXwgfP7eUi1GsJY9TWC8UvFra/1WYCuZjfYdLVsT0h5qwVfLxhCx4rMmOGcwFuEVx0TA0oO/1aJUGsIsYruRtQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709519419; c=relaxed/simple;
	bh=EF3vgF3RCS4Ssstdof2LMWEsquHRVzgOPh/ZYi37ZfA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rTpIlKeuHyEO9zeOOiIdfdPJ6sUGVujN9IkT2/ELJtrRNo8RP6GqS1UnbiYsrirglCqx9pUw6iMNVCwobhJ0bQw+SaBUDeTVeIwmgFbHeo2R7KAeBe+GXvAa0724pmJTr/uv3RwPhs8MCb07D7iBSn7b4MNVm+M1yvyNYY8KUX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R5DPmOb4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cxBHfier; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1bb7afded9cf11ee935d6952f98a51a9-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EF3vgF3RCS4Ssstdof2LMWEsquHRVzgOPh/ZYi37ZfA=;
	b=R5DPmOb4kh9l0tRrqbxDLSQ+doC9iigObtpwqXNFhPJxPkmKAeoGWQV87xDIN3YWxTW2zbjJWXDBZCJTJ1JxcVsc2/drgp/NipxEXjwky5lWD0Rf5o1pVKl7mqtqRwl3EjfBj/KMSofpUuyNXIfhJcwuDkWpBX0BaSzujzSK6JQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fb5a2aca-e1b2-44c0-bb69-786561b5b249,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:b4bb75ff-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1bb7afded9cf11ee935d6952f98a51a9-20240304
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 182638818; Mon, 04 Mar 2024 10:30:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 10:30:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 10:30:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4UaeQb21xLcG/CT43Iba0npJLot93b2L9OQclcaX7z/sh4h971zz60KPlUcJPjW9As8nPpkiWkPO9ae8AbY2Zri1SAjvUlu4xYnlMubV9Ubl+yFAfqwZ3phpFRksqBElHGWfO1De1l4oRMEJHoQQU48dQYzGVRgdebFEX6ukqS9D2zEu+MK9dd4Nwl7yRRphoIrdQ54csA5ChI9/dhdD8UDwLjQe23Yn8uSVr0oKMCRFFekaIR/ivAsBLXGkHwp1Ccz1Xoy/dHzXo1djQERZVO0jiHL3tiQWMimtH7mAATwKqdXog0sflgWNu2Ulx4FZOPrJVOn7LYV2m1DmmBjdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF3vgF3RCS4Ssstdof2LMWEsquHRVzgOPh/ZYi37ZfA=;
 b=O50BnrVp70RJBoFif4K1dnnMX5/2QiRKWJd7lMURKy9lVus001C2S/0UPFQWr6SbXmIiTAPp2pXxj+J/YwIAeWiWi74+Go3WpWpHh+lxIvRFfFMsBkz5/hX23dBEHSEeXdhV4y81F1bGGuynMcaude5N35A8byqx94uOb3VLQ1hRJ7VG6zYVl8CqWR029BCHoTggZ8iUKMGkeAjA9mBEAD/GbThgs0m1aSOeW5rJBiRM+vr93IsbJ1s8qfFX83gPI55ZiX1BmpnMZ1xTuXX6jTAnbeqUPRZwxKeJllWUJrRM8bXRnU5X1+d/zrgSpYHEwOTwZFJ6gxg/oP5c9mGofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF3vgF3RCS4Ssstdof2LMWEsquHRVzgOPh/ZYi37ZfA=;
 b=cxBHfierM9BPq38Jl1fcvz4+wEgt0h+XsNR1YB8AP8c2raq+H3R/CblCrxhf9eSyH0pZ1ClA91G+cOZDiay1ldfdYCkwIEt+Le+jzLHgANGgsRyg04q+gOLHi8T1p4mMcaAZ/xhR2zWAVGjx9zkNdgOm3J3qmlM9ke1NiZhP7fg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8537.apcprd03.prod.outlook.com (2603:1096:101:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 02:30:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:30:00 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Topic: [RESEND, PATCH 5/5] mailbox: mtk-cmdq: Add support runtime get
 and set GCE event
Thread-Index: AQHaa+cJEQPI4k9J/kOhfVF98/x/R7Em3+aA
Date: Mon, 4 Mar 2024 02:30:00 +0000
Message-ID: <1d14bad104b8e5c74ffe6c08cbafb4da6e1e751a.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-6-jason-jh.lin@mediatek.com>
In-Reply-To: <20240301144403.2977-6-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8537:EE_
x-ms-office365-filtering-correlation-id: a9d06c52-90db-41ef-22ad-08dc3bf2fdbe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2usQagqqPO+Urd6Ebn+QOxuTlz+zvl8afAh21efpMrA3nbz8V1YlEBX47heJD8i3BpSY0Iq9PbOg8NHBRd+y1Zi2JuF2N/key8yceIKmPuDauC8/yaBhjFy9UJJDACS5lIv6D1ygch0JKA07Aw3z34k4KgDxF3OxZYD4uNdlCQOfWfu9aRcgqvuPO5oHLwgSkYAuaHjkdZRrUEVu/SottLhwLHDwifa/3tWhKqcFr0MkCQdB+nIiZlJNBdvOrI5sEYWXRvv9U15AnzxzpB0buUPe/7w65bgmFNkIc8ns3szMXxEweWkGSsSpkcqReShK9Q5RymXqvSBgT/VOgWByifJyDPhYS0KS3eV3DNRn1SQUgkdNig9qiAbbuEdGgQmAld7cohn0uoLPoSpE/I8ep33PW2j5zml8hzrUT747ecjkQFEUbHVls6PaaxDX+oOuphU1SfaAdbBSWXPlI8CLuKAe5o/KOPqFEB2UTb1t7NahvAlcz2FxdvAvTCMGfmq/JV3+O8tLER9o2YG5nomT96irlrBh4Dn0dRJ89eyLadXh5sEpxzB/ZmvRECLYiAwei5oGqq6uVDLfZ2p0Ams2sCislCGWGC3iFmlqV3xqjDUfaXq3+GgRbGg8I/UtHQOEZvEMRh464aRNJEUhyeBEnbXX38tDfxYp9ph2trMf6fyleUeK06jDNLLD3en33WP9mA54iJ2FYaBsME8WA/cmQDOBozXsycqe+b1V4V62fM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnJ5dXlsWUVwOEdHaFhvS05JZEh0MUtPVjZPeVlnRXBQZFROcFBVRkNMMU55?=
 =?utf-8?B?bEpXZ2YzUkFuZzRLVnRIR2NEN0s0N1RMcDgzN1JBcjNhYTc2cHd4Y3Z3TUs2?=
 =?utf-8?B?YTZncGZoVnFnNS82YTZYRFc5NGpzOGRYMUREVEswYmMvR1E5MHZ0WXdnOTB1?=
 =?utf-8?B?ZEY1YnNJbGNEYUxCMWRTVnZnSkJnd1cxS3FzZ1pPVG4veEhISUthbGFFbWhW?=
 =?utf-8?B?a1M1YjY1MXhLMUQwVVg5ajhaZjUzZmFVMGJ4VHUwN1dzTUdNOHdia3hrTy9Z?=
 =?utf-8?B?d2lvYWxSeDQvVjZTTnBrNW9EbDBLOHhHM1hXN2NPOFd3eFZyNmczWWkwbVZx?=
 =?utf-8?B?WlJ5VXBpS0E0YjZoUzBDL1VSOVl6WFhXNkVMWWNFcmN0bUNZeG5NT3dWTWo0?=
 =?utf-8?B?V2Nta3kvWmRFVDZNTmEvRnZTbGJwY3o5TWlBbW4rRGVsYUZDd3ZIdnRSdmsy?=
 =?utf-8?B?dzZuamlTUGdESzBLbCtkbEFBYkwxbkNackRLMW11OHBqbUQyTUtINUV1aHZQ?=
 =?utf-8?B?NURlQVpQOEZCRzNRQVJKNHFJbEJXdUc5bmRWelF2TnF0dDdaRit5cUtpbTRs?=
 =?utf-8?B?V3BHRTI3Sm1Mb09mM2U5TDRnYzNSSTkvc0x5QS9FZDhMVGlYYk1wUzlHVmdO?=
 =?utf-8?B?amRBUDJnYzhSaXQ5cC8wYk1aZEVad2ZKcUVDQkU5SkdFUnplTnNNNW5NU29k?=
 =?utf-8?B?Mmc1WnpaNjc3MFFnRkV4ZWp5b2ZjL3pIVm8yd1k2RWhObEpuQmwyYXJVakM2?=
 =?utf-8?B?MTlsMG16OXhEKzczZDZyQ2t0dVROeUlyYy9HM1BmN2VxNmtmNXQ0ZWtZSExQ?=
 =?utf-8?B?OUxwbE5wcHVMN2EwMy9CZTFtRnF5Q3NKTUlGQXdwOGNFTXRUMjNvb1FZM0ZJ?=
 =?utf-8?B?dzdHOVoxR05oWTBZUVdBT1d2d2VqaWNYRzBqNFplRzQ5TklaSlNQNTFTdU9E?=
 =?utf-8?B?U1FBengrT0pybkhFY3VjS0xkQW1VR0hSdnJ5ZjZUaDFyQ09PcFNoZWRSTGpC?=
 =?utf-8?B?Z1FuOVI3S0txTHZEV0tHQUNTdDcvL3lZckRoQk1lN0dwZ3FRYUZvQ2RXeVpY?=
 =?utf-8?B?VEliazVkTzF2cFMxR2VmVlgxVGw0RmRTWElVR05OTmoxSUZJNVRsZmJVem1N?=
 =?utf-8?B?d3pVV3dkaEw0M1dvV1hYWVl4eXVOUGdoU3pyell3UFAveFVYK2gvR1Q5QmVS?=
 =?utf-8?B?NkZlZVhyczU4QnVibDhFZ0syckRHQUpEb2NwMjdMUW1uNElROUNtVTBhY0xY?=
 =?utf-8?B?bEc1WUlIRVRhZ0V1SlZrTTZVS2lMNVkwQ2hWL0RjZDVjRkx3Q1piNnJESUh0?=
 =?utf-8?B?Q1hIMkhncENNYU11N3RiM3pSdkVmV0FKdE9Xa2JOblhrS0RHUGxDYnNTNjZM?=
 =?utf-8?B?YS9VeWR3RUxXZEFNN21YZXN4SWRjUDYwbTYycUI1L3JIVEhkU0VVNzZBc1ZI?=
 =?utf-8?B?eXFGQTBlOTFsY3BPTkpOTy9DUm1NMzJDaXpaOVdPRDhWeW9pa0lYRDhiUEdF?=
 =?utf-8?B?ckdMMFc2cm9ubUlJTUE0bFJDR0Q4THEvTUhiakNucFJ5bFlMMVF0NGdpQWZz?=
 =?utf-8?B?cFZGOENncUYxWjZsejl6T2RvWUE3aHFOUjBsaFVCWWNoZ1lJY2wralcwNzdX?=
 =?utf-8?B?bVJpV05vQVdUckJwRVAvMHE1NGhCeXhyb0dtM3VVTHlhR2NnamhvZlU0OWpw?=
 =?utf-8?B?d0x2ZlE5ZDNFYkhxQi9EYmFiT1M0TWhhdzMza21lTU11dVplZ0xBeklFcU83?=
 =?utf-8?B?YXV1MDFsMUR6Q3M1Wm5qelVvczJLVWZwT25MMDQvdjVYT2FwN01BRnJyM1Ns?=
 =?utf-8?B?dXdNVjZuTFVJbXNjQm9ZbmdiRE05R1JFVUw5VVhINjlDcklaOEhvSEhQVWw3?=
 =?utf-8?B?dEg5YnJsbkdlTFFDNUJXQzlRcWpiWWZZS3V3RHladnBwcUpKUGNwR0FqMFZr?=
 =?utf-8?B?bWFVZVIzc2tvZGZDNW8vbzJPOTBpNlRaVkNIejJzTEcrRkZOS0pSbW1Ga04w?=
 =?utf-8?B?cXhJOUNZeEgwWUZnVFVsNXlEcGtQRU9NcTRJeWtWWkFBY0Y0YU4rKzZ1M2dG?=
 =?utf-8?B?Yy9IOUVNcXlRNVJZdjlpYll1U3lSZXNsaEk5U0Z3bVYvTktrM0RoYXNqVFJn?=
 =?utf-8?Q?kQzhbbgCyK3ct6PPaG3Yn51QF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07044DA401E7D64FBBA923CF8B2163CC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d06c52-90db-41ef-22ad-08dc3bf2fdbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 02:30:00.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7gYCugpDTuJ35k+fneNm909+VxhPHRY+ZaKhxaViv9B14Bq0OoEPu11momFxXVuglibzzcmQtVvmLwGf84gKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8537

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjQtMDMtMDEgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gSVNQIGRyaXZlcnMgbmVlZCB0byBnZXQgYW5kIHNldCBHQ0UgZXZlbnQg
aW4gdGhlaXIgcnVudGltZSBjb250b3JsDQo+IGZsb3cuDQo+IFNvIGFkZCB0aGVzZSBmdW5jdGlv
bnMgdG8gc3VwcG9ydCBnZXQgYW5kIHNldCBHQ0UgYnkgQ1BVLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRy
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgICAgICAgfCAzNw0KPiArKysrKysrKysr
KysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmggfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBiL2RyaXZl
cnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggZWFkMjIwMGYzOWJhLi5kN2Mw
ODI0OWM4OTggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBAQCAtMjUs
NyArMjUsMTEgQEANCj4gICNkZWZpbmUgQ01EUV9HQ0VfTlVNX01BWAkJKDIpDQo+ICANCj4gICNk
ZWZpbmUgQ01EUV9DVVJSX0lSUV9TVEFUVVMJCTB4MTANCj4gKyNkZWZpbmUgQ01EUV9TWU5DX1RP
S0VOX0lECQkweDYwDQo+ICsjZGVmaW5lIENNRFFfU1lOQ19UT0tFTl9WQUxVRQkJMHg2NA0KPiAr
I2RlZmluZSBDTURRX1RPS0VOX0lEX01BU0sJCQlHRU5NQVNLKDksIDApDQo+ICAjZGVmaW5lIENN
RFFfU1lOQ19UT0tFTl9VUERBVEUJCTB4NjgNCj4gKyNkZWZpbmUgQ01EUV9UT0tFTl9VUERBVEVf
VkFMVUUJCQlCSVQoMTYpDQo+ICAjZGVmaW5lIENNRFFfVEhSX1NMT1RfQ1lDTEVTCQkweDMwDQo+
ICAjZGVmaW5lIENNRFFfVEhSX0JBU0UJCQkweDEwMA0KPiAgI2RlZmluZSBDTURRX1RIUl9TSVpF
CQkJMHg4MA0KPiBAQCAtODMsNiArODcsNyBAQCBzdHJ1Y3QgY21kcSB7DQo+ICAJc3RydWN0IGNt
ZHFfdGhyZWFkCSp0aHJlYWQ7DQo+ICAJc3RydWN0IGNsa19idWxrX2RhdGEJY2xvY2tzW0NNRFFf
R0NFX05VTV9NQVhdOw0KPiAgCWJvb2wJCQlzdXNwZW5kZWQ7DQo+ICsJc3BpbmxvY2tfdAkJZXZl
bnRfbG9jazsgLyogbG9jayBmb3IgZ2NlIGV2ZW50ICovDQo+ICB9Ow0KPiAgDQo+ICBzdHJ1Y3Qg
Z2NlX3BsYXQgew0KPiBAQCAtMTEzLDYgKzExOCwzOCBAQCB1OCBjbWRxX2dldF9zaGlmdF9wYShz
dHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiAgfQ0KPiAgRVhQT1JUX1NZTUJPTChjbWRxX2dldF9z
aGlmdF9wYSk7DQo+ICANCj4gK3ZvaWQgY21kcV9zZXRfZXZlbnQodm9pZCAqY2hhbiwgdTE2IGV2
ZW50X2lkKQ0KDQpzdHJ1Y3QgbWJveF9jaGFuICpjaGFuDQoNCklzIHRoZSBldmVudF9pZCB0aGUg
aGFyZHdhcmUgZXZlbnQgaWQgbGlzdGVkIGluIGluY2x1ZGUvZHQtYmluZGluZ3MvZ2NlIA0KPyBJ
IG1lYW4gQ1BVIGNvdWxkIHRyaWdnZXIgdGhlIGV2ZW50IHdoaWNoIHNob3VsZCBiZSB0cmlnZ2Vy
IGJ5DQpoYXJkd2FyZT8NCg0KPiArew0KPiArCXN0cnVjdCBjbWRxICpjbWRxID0gY29udGFpbmVy
X29mKCgoc3RydWN0IG1ib3hfY2hhbiAqKWNoYW4pLQ0KPiA+bWJveCwNCj4gKwkJdHlwZW9mKCpj
bWRxKSwgbWJveCk7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKw0KPiArCXNwaW5fbG9j
a19pcnFzYXZlKCZjbWRxLT5ldmVudF9sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwl3cml0ZWwoQ01E
UV9UT0tFTl9VUERBVEVfVkFMVUUgfCBldmVudF9pZCwgY21kcS0+YmFzZSArDQo+IENNRFFfU1lO
Q19UT0tFTl9VUERBVEUpOw0KPiArDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmY21kcS0+
ZXZlbnRfbG9jaywgZmxhZ3MpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3NldF9ldmVu
dCk7DQo+ICsNCj4gK3UzMiBjbWRxX2dldF9ldmVudCh2b2lkICpjaGFuLCB1MTYgZXZlbnRfaWQp
DQoNCkRvZXMgdGhpcyBnZXQgdGhlIGV2ZW50IHN0YXR1cz8gSSB0aGluayBldmVudCBoYXMgb25s
eSB0d28gc3RhdHVzLCBzZXQNCm9yIGNsZWFyZWQuIFNvIEkgd291bGQgbGlrZSB0aGlzIHRvIHJl
dHVybiB0cnVlIGZvciBzZXQgYW5kIGZhbHNlIGZvcg0KY2xlYXJlZC4NCg0KUmVnYXJkcywNCkNL
DQoNCj4gK3sNCj4gKwlzdHJ1Y3QgY21kcSAqY21kcSA9IGNvbnRhaW5lcl9vZigoKHN0cnVjdCBt
Ym94X2NoYW4gKiljaGFuKS0NCj4gPm1ib3gsDQo+ICsJCXR5cGVvZigqY21kcSksIG1ib3gpOw0K
PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsJdTMyIHZhbHVlID0gMDsNCj4gKw0KPiArCXNw
aW5fbG9ja19pcnFzYXZlKCZjbWRxLT5ldmVudF9sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwl3cml0
ZWwoQ01EUV9UT0tFTl9JRF9NQVNLICYgZXZlbnRfaWQsIGNtZHEtPmJhc2UgKw0KPiBDTURRX1NZ
TkNfVE9LRU5fSUQpOw0KPiArCXZhbHVlID0gcmVhZGwoY21kcS0+YmFzZSArIENNRFFfU1lOQ19U
T0tFTl9WQUxVRSk7DQo+ICsNCj4gKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZjbWRxLT5ldmVu
dF9sb2NrLCBmbGFncyk7DQo+ICsNCj4gKwlyZXR1cm4gdmFsdWU7DQo+ICt9DQo+ICtFWFBPUlRf
U1lNQk9MKGNtZHFfZ2V0X2V2ZW50KTsNCj4gKw0KPiAgc3RhdGljIGludCBjbWRxX3RocmVhZF9z
dXNwZW5kKHN0cnVjdCBjbWRxICpjbWRxLCBzdHJ1Y3QgY21kcV90aHJlYWQNCj4gKnRocmVhZCkN
Cj4gIHsNCj4gIAl1MzIgc3RhdHVzOw0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tYWls
Ym94L210ay1jbWRxLW1haWxib3guaA0KPiBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmgNCj4gaW5kZXggYThmMDA3MGM3YWE5Li5mMDVjYWJkMjMwZGEgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiBAQCAtNzksNSArNzks
NyBAQCBzdHJ1Y3QgY21kcV9wa3Qgew0KPiAgfTsNCj4gIA0KPiAgdTggY21kcV9nZXRfc2hpZnRf
cGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbik7DQo+ICt2b2lkIGNtZHFfc2V0X2V2ZW50KHZvaWQg
KmNoYW4sIHUxNiBldmVudF9pZCk7DQo+ICt1MzIgY21kcV9nZXRfZXZlbnQodm9pZCAqY2hhbiwg
dTE2IGV2ZW50X2lkKTsNCj4gIA0KPiAgI2VuZGlmIC8qIF9fTVRLX0NNRFFfTUFJTEJPWF9IX18g
Ki8NCg==

