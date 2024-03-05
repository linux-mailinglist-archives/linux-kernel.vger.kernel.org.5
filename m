Return-Path: <linux-kernel+bounces-91735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464528715CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F6A2839EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D207BAFF;
	Tue,  5 Mar 2024 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="folcq74s";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Vb5UvXsf"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F56167A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619801; cv=fail; b=rUpeWDzRw6/QI8Pde9fN2qZfrl+zhZy0cgEn1oQNhS1GJ61UKiRCqfjpFP0VjIpz1405XYEXmeJGgjGjik3vzLAK2lXwwXh4iTGw2u2UWIeiJO2zkq/G7mzTHHhJD96tmN84D1c9aIbbGDiIfYprDjP7z0fZaVjgmTukWMFwURQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619801; c=relaxed/simple;
	bh=t4Yefej4ebCx9ntwV7JAl/SVS3twyM4JQKZ24IeZzSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dgp1nuiMG1/UeXWNxv4ksvcnXKGy1WZiXq07L9h6hMmcM/AhxjfNx6Zw5p5BDcRR1Jb00B6QIe8volyUH26qgJixPX6g7V0LJtLZKMiay2REWxWzfv0oQpbUB+2KC5LjcbS+VJM+FhCQi6xH+sOTcw+oHhVmUCxBquP3ROpLWig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=folcq74s; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Vb5UvXsf; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6a5e452dab811ee935d6952f98a51a9-20240305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=t4Yefej4ebCx9ntwV7JAl/SVS3twyM4JQKZ24IeZzSk=;
	b=folcq74sq1q3QxfIcY03AZlNeFWvMq+iV17oG21RSjO0FW3vfU5LtwM3Sm7xuvyNB/KfTOkTlwwl6EzyTj6uEDKYv2H/WIUTu+CzkIsTV8qEoMBTXmVgqcZ3NsD6mL+L0OV4uAJldhhkp5foggdnxYx2U1iXJMylCygBJUB4Xlw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:0ff3316b-837a-43ba-8abc-958110d8ef5c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:abd00690-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d6a5e452dab811ee935d6952f98a51a9-20240305
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 353293898; Tue, 05 Mar 2024 14:23:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Mar 2024 14:23:08 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Mar 2024 14:23:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ws71PkSV2+Pv99bKTXMk8T6ua12LOG3BFK8mprzlQa+xuvP3TBOrVrElYlJJldapysJIc4/Mywrj1pvgROo0CYZ+Yp9Tzx0MznPvxrLbx0HIbTAEklqLI3+V/LN4aY6yLc30uHJg8e9gysM0plN3oAudAhWIho42IaodlDrCNRPDynMmx5sok/Va3PzZtXtVHqLCQDmkivzq632TNj5enaXp4nTCjdqg7rM/nyq7M7CBUJhhL54SqCavMLSYL7j0vG7rmrzFV7elEmtaN9U9c7UdsCt47L3kjmPeQNJBnwCQ/UdE+iVEwV6fuG5pzTpJ3TEL2YfRnf5fkcJNOfkmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4Yefej4ebCx9ntwV7JAl/SVS3twyM4JQKZ24IeZzSk=;
 b=YUHwtNmudzSgT7+MfSvJZQX9gv8t3bGZuYVUBgxGaxhn6C2F/WMarK9GrpzE9cJxJXqwBbCq2yCeRFAw3gAiH0ZuKAnIGCc3clQRkgmz8ZU1Na7m3C4JFuLz6QG/oUWZJbY+edNI0RNWSFS5xs7vrYfebKqCshEhgiOIXVSt75ON3kxeKXlYy76l9z6BuSioRgk89i0qHuIKXw+C9GDH1Jf6gjoBMRHGM2LJtRweYagLCUH8YqJDUohzm5EAfysfPDVUvMlZ8sQZwYCS6Ww7VmJ0XN+BfWNdx0ubFE7p1SnIpIFFM2zlZC3RTBWJyIGumavLtsG26VoASKRfpCsU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4Yefej4ebCx9ntwV7JAl/SVS3twyM4JQKZ24IeZzSk=;
 b=Vb5UvXsfep0Cmu2nFA7NSeHr7RSnoxPpPrUQB9FjEAgqgVnki2s+y4uYXICRJvfRoe0/aov6k8QbnFNDmWeAZcrw6AAqYaDPoQaPVNCmtcnd3alX3JB4p7rp59VsVLMEBpodYo2sCETiCPkdqUeegUZCCV5MGZoLDR80aoe+U+I=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB7904.apcprd03.prod.outlook.com (2603:1096:820:f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 06:23:06 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::bc7c:deed:ae:ed4c%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:23:06 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Topic: [RESEND, PATCH 3/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_poll_addr() function
Thread-Index: AQHaa+cLJ6J47YqzE0edY2v/hhyrU7Em65gAgADYAYCAAL5vAIAAAzIAgAADvYCAACplgA==
Date: Tue, 5 Mar 2024 06:23:06 +0000
Message-ID: <881eb7846b0e096e745557eee4a05796278aa63f.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-4-jason-jh.lin@mediatek.com>
	 <d33fc25f014785d21ff7bac3f00a48e7621b810e.camel@mediatek.com>
	 <ec598de2d5012206fe3c3335bfede85100c8f7c5.camel@mediatek.com>
	 <172e03d1f7bdb65c15e6a6ca5f52b3dd1929c7cc.camel@mediatek.com>
	 <0e18361489d77d38647db957d921bf21fcc067c0.camel@mediatek.com>
	 <388bf94dfc0a98386b131e99a5c57d210e86c99f.camel@mediatek.com>
In-Reply-To: <388bf94dfc0a98386b131e99a5c57d210e86c99f.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB7904:EE_
x-ms-office365-filtering-correlation-id: 12cf517c-b526-4726-7091-08dc3cdcb85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3L3rZeXov2ZDbaW6qPjmv6dPyT4ivRR8jeYziYMStLhVfdrp5umfmRjhWpFOvkJB0EW6zWzrISl3tTi36HxFo0xF7mGb0qnolD/qBhtD6RmqSDidIxCQSuDBrzZTydbAFMZZ206KBTxD6UsqsKRevLUGoxxGkDeHJF/hXhUhPv69/nBueYYBVymamrib8YfP8QeSZjnCUqW/nNhgJNj7zrdwk78JldePs/Lx3YWS8hZMO0QvXZovPC/j0z0vE+uHnEQe/GZw4lEFDy7WOwxScwvOso9c9qvUQ0AcZLklHK1e/v5bEWHeg6Dv8SJufqijwd5Etg13k0J+npY0Dhy4LbWiLtXP8WLh08IMkQFAYD9W7LdFapU8vSlzHnro5WgB5zX/MC57rdWdeSJTdBmTZjJ0jPUpLtMDEYWIC1CA4P1ZamUXplrVv+fYiDW2LHWB2NU6LaRAgAqymUQF7DnI2Hhhq6BFZX2aMhsq6kHl1rwdoJz+ZvlLFyyGuzxayAgtGNbqM4muyq58v13YKfWCo2HKzi9iH8glegTYdEkanX2RZrNXvYCc6bPiAWPLOGDDbiWfG0e4kjHFRGwM4vmug7aKEdjNJQ9XgVFxspbPgFrtDKOBMW66zRNuFo8ZsXZYN25NCYVBNy/YOKbqlXlttZbaDpQuf51ueAeexKLqHh71Re84IOO85apu/iySHdeQlcZArNxMbQwNanQ8zHSYlz/r3Y+VMu1/gcTkbN7tiYk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3ZjYS9sTTl2VE0xNGtqV3hsZmZGeEVES3hxdFFwRkFVOFFDbFRWRTVKdkRx?=
 =?utf-8?B?dE9ENFhQV2tSWWphT0xBS3FjSFJtWEM4ZVdPUCttTlJmYWU4TDI2dUV0QVo4?=
 =?utf-8?B?TEwvcGhWWU00YzBWMHkzMHloek0ydnl1ZkxqYUpEUlQwNWoxZXdMVzRKLzA0?=
 =?utf-8?B?UEQvb0YzaFFaenVKTVVka2RZSGlGcnhYMVYzMEhPV0dEelVaY1VJbUFrQ3pC?=
 =?utf-8?B?enp5cUd3Wm1vMXVIV1B6K09ZS0ZRT0NJeU5IT0xKNW5nSndJVjNYWkZsSysy?=
 =?utf-8?B?ZmFQdDJmNG90WUdaYkxXVDE3U1BWd0UvNUxwcjc2S0NOK1hCcTljbERiS0Vk?=
 =?utf-8?B?elc3WFp5QWxDSmZ2b3R3VmgwYytJNnpsblBrelp3REQ1eWE1dmEyNTB6SGVN?=
 =?utf-8?B?RldSSXJ1VTYwTEQ3UUkyWlhwQVVBL2FPVW93TFlMNEEyTjJsaHZOTDVMdm5s?=
 =?utf-8?B?RlJnVlpCRDNPTFkrMk1JMVkxRHpTRUNpVzR3WENrZVAvVW9sUm5POENTSmVx?=
 =?utf-8?B?TTI5anRtRDN6QzJFVmxNam02WUd4WWQxdGtHUkNVMU9GRld5WG83QWdsbm92?=
 =?utf-8?B?RzdOcUV1cEZ1ZTI2eWFhYkJ5NFduMkdHVC9tbjMwS2haMEtIL2czSkNIVmNG?=
 =?utf-8?B?Mm9PR2NsaTFXMVZaSkpQYUR6cHdBSXlveGY5Qzh1MUhMWkNzRTJwZXVtOW5H?=
 =?utf-8?B?UjA5STRCRVh2UEpabFp6YmJYbnFDNnpQbDA3Nk1RbFJWQUQzTHNLTmZQTVd0?=
 =?utf-8?B?RWJ5RG9YR0NhTFUxU2ZnZjdqaGR6dmhsOU5SZzNkOTZ1SVhrZk1tcEowZEV4?=
 =?utf-8?B?NzgvdThLSk5VdnlGWWpHKzBQSDJQYzlobzEvU2NtSk4rdWNPMm1QTlBUekg0?=
 =?utf-8?B?VkdYRk9Kb1QxOEtKZkV1WlM2bUNyZjNreWNqREFJNHFYelRxWDMzVVpoWTlO?=
 =?utf-8?B?MVppMzNnb3pXOUFMRFMwUndoWUdwRFpaYWVFTVpORkxDUnVuQUZVVEF0UE5i?=
 =?utf-8?B?azdRVzcyR2JjSjcyWXJMRDU0WXFxL3ZmQ2RLWkpJaGlUYjdZN3BYRU5mb3lz?=
 =?utf-8?B?cklrOUV5aGpkQkpCU0hwS0VtdjZFOVRQQnFxRFJwL1R4elFOYnFpdUozVjN3?=
 =?utf-8?B?SERtQ3VYUGZTT2NTbWdUc3pwN0NYRnd5WVRSVGlXYk1rQXdrRFZUclh0UTRO?=
 =?utf-8?B?RWc0OU55QlhWTVIyVVNvZVplRGUrRXhmQnFyb1l0YWc0dFRlV3MzOGVmcnMx?=
 =?utf-8?B?S0lKcUVjbUZ4QzZ3QzZVd0VRbFJBdTZqd2tCYXNBRkV0RjRMNjRSMVRWbDJp?=
 =?utf-8?B?cmRnVTNQQllZeFNBQjJuN1RJcXlkcHNxMTJiN3ZqWE5nNFdxTFBYQkdVbW5p?=
 =?utf-8?B?eU5vYVYzNk00blFvb21hcjloUjdkdjZrWGc3aVJleFIvNFEwRjA5dFJiY2ZY?=
 =?utf-8?B?RzVqNGVTZDdidDRqaVBHUEZObHdlcWdSUW9rZzRKZTIzalFkVHl5eUFLM0dQ?=
 =?utf-8?B?dDJVYUY5bTZRVElOU0g0RjBzYXpvYWF2VkVRNGJTWmFDYmZIT3pqUEUxYjZE?=
 =?utf-8?B?Wm9mQWRJMXBzWTNYQnp4Sk5xeE8yYmpuT2VIYmkzVFZtNkdvQ0h3YmdRdUNo?=
 =?utf-8?B?alVvVk90aDBJYldmRVFNV2R2QmNzNjFwb3FWcmtTZy9RR0xBTWJ1TG03NFZD?=
 =?utf-8?B?MCtYakFjU2tZTWxGNVQrSC9GZVNNUHkzRDh1alN6eXo4SWhMeUlLd1g2UFpl?=
 =?utf-8?B?UGdOQjlDOVRPV09HUmUvYUU3NHhVZTREZWE4Ymp1aXE1M3V5VG1wTDQ4OGtF?=
 =?utf-8?B?ZjRDb3I3SmFlSnk3SUgrKzgvcG5DQk5uVU5GMVF3ZUI5dkRJTGlRQXdHREFI?=
 =?utf-8?B?UFZYT1M5ZUFkemNEa2hqY09HN0VLS2M2MDc5dFliNmZpRmVTb2M0Yi9ZUWs1?=
 =?utf-8?B?OVlFM2d5L0lLRWFqTE9qSnlLNHUxUjZSN3dSZkhlTWduVXp6QXVjVGJPSUFO?=
 =?utf-8?B?bEpGM2ErMDRsc3FTRjJuaVpNTGd3d2Z4MkQ1ZUkrSzA2TlNuSkVndWJvQ0Vw?=
 =?utf-8?B?bEhEakpHU21WT2xWTng5dkJpcng5WHU4VXNldUVFM1pFY0pMMk53eS8vS0ti?=
 =?utf-8?B?STh1eU9ZWFc1dGdLcy9kbGlqMllWWXdGOElNQ2VlckxyR0dpTXB4dVkzZFN3?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36D6169C72C79141855EACCBA25305EE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cf517c-b526-4726-7091-08dc3cdcb85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 06:23:06.2728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YmV0Xd1lJJi/JuDT2o1CyEDfUiUNyxXGnlPU+WgtzwyvCFviTpfMrP4J7kiTrgM9P/rbGGF6kIlmlVGNMDaNShwaRG6g66Ka3BVI5gxnGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7904
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.592500-8.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGjoSitJVour/Sa1MaKuob8Pt3aeg7g/usCe9toQ6h6LEyZK
	RIFpXA+BH+RndCK32H0hcnM8qCdEajW+K/PcvqBro65WJt1k1O8Ea8g1x8eqF8lgi/vLS272+lm
	NZCKoGWFG5M2kXEpG3mmW2sWau8OPzcCZ20yMYlUD2WXLXdz+AbuesBT0pDFRDpCUEeEFm7CtEa
	JoVjyWkDu/leP9T0nGAn/jq7o4j6CUYaO/E+T/Q836paW7ZnFoUXlp1FHYSPVzwVmY5TMrNvWnL
	2FmW8AToYF92SVscfliEgb3ryiNYFfcVmfgO8Ty2OSj4qJA9QZb2iL0xnz/EsxIlVWoMfNWZt9E
	JVCt3ojAhbdIi+Y2LbnlVPOTfszdAjPI/s9IvI/4Wr1WT+bU2n0tCKdnhB58pTwPRvSoXL2ZMPC
	nTMzfOiq2rl3dzGQ1A/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.592500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F65C80C33A08CE13EF29237825F906EB7A1B70EF6E345EC0E5F81B3DEC91615E2000:8

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDAzOjUxICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gVHVlLCAyMDI0LTAzLTA1IGF0IDAzOjM3ICswMDAw
LCBKYXNvbi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDI0LTAzLTA1
IGF0IDAzOjI2ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiA+IEhpLCBKYXNv
bjoNCj4gPiA+IA0KPiA+ID4gT24gTW9uLCAyMDI0LTAzLTA0IGF0IDE2OjA0ICswMDAwLCBKYXNv
bi1KSCBMaW4gKOael+edv+elpSkgd3JvdGU6DQo+ID4gPiA+IEhpIENLLA0KPiA+ID4gPiANCj4g
PiA+ID4gVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uIE1vbiwg
MjAyNC0wMy0wNCBhdCAwMzoxMSArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+ID4g
PiA+ID4gSGksIEphc29uOg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE9uIEZyaSwgMjAyNC0wMy0w
MSBhdCAyMjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+ID4gPiA+ID4gQWRkIGNt
ZHFfcGt0X3BvbGxfYWRkciBmdW5jdGlvbiB0byBzdXBwb3J0IENNRFEgdXNlciBtYWtpbmcNCj4g
PiA+ID4gPiA+IGFuIGluc3RydWN0aW9uIGZvciBwb2xsaW5nIGEgc3BlY2lmaWMgYWRkcmVzcyBv
ZiBoYXJkd2FyZQ0KPiA+ID4gPiA+ID4gcmlnc3Rlcg0KPiA+ID4gPiA+ID4gdG8gY2hlY2sgdGhl
IHZhbHVlIHdpdGggb3Igd2l0aG91dCBtYXNrLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBQ
T0xMIGlzIGFuIG9sZCBvcGVyYXRpb24gaW4gR0NFLCBzbyBpdCBkb2VzIG5vdCBzdXBwb3J0IFNQ
Ug0KPiA+ID4gPiA+ID4gYW5kDQo+ID4gPiA+ID4gPiBDTURRX0NPREVfTE9HSUMuIENNRFEgdXNl
cnMgbmVlZCB0byB1c2UgR1BSIGFuZA0KPiA+ID4gPiA+ID4gQ01EUV9DT0RFX01BU0sNCj4gPiA+
ID4gPiA+IHRvIG1vdmUgcG9sbGluZyByZWdpc3RlciBhZGRyZXNzIHRvIEdQUiB0byBtYWtlIGFu
DQo+ID4gPiA+ID4gPiBpbnN0cnVjdGlvbi4NCj4gPiA+ID4gPiA+IFRoaXMgd2lsbCBiZSBkb25l
IGluIGNtZHFfcGt0X3BvbGxfYWRkcigpLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1o
ZWxwZXIuYyB8IDM4DQo+ID4gPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ID4gPiA+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTYgKysr
KysrKysrKysNCj4gPiA+ID4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykN
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+ID4gPiBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+ID4gPiBpbmRleCAzYTFlNDdhZDhhNDEuLjJlOWZj
OWJiMTE4MyAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KPiA+ID4gPiA+ID4gQEAgLTEyLDYgKzEyLDcgQEANCj4gPiA+ID4g
PiA+ICANCj4gPiA+ID4gPiA+ICAjZGVmaW5lIENNRFFfV1JJVEVfRU5BQkxFX01BU0sJQklUKDAp
DQo+ID4gPiA+ID4gPiAgI2RlZmluZSBDTURRX1BPTExfRU5BQkxFX01BU0sJQklUKDApDQo+ID4g
PiA+ID4gPiArI2RlZmluZSBDTURRX1BPTExfSElHSF9BRERSX0dQUgkoMTQpDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSSB0aGluayB0aGVyZSBhcmUgbXVsdGlwbGUgR1BSIGFuZCB5b3UgdXNlICMx
NCB0byBzdG9yZSBoaWdoDQo+ID4gPiA+ID4gYWRkci4NCj4gPiA+ID4gPiBJDQo+ID4gPiA+ID4g
d291bGQgbGlrZSB5b3UgdG8gbGlzdCBhbGwgR1BSIGFuZCBkbyBub3QgbGltaXQgdGhlIHVzYWdl
IG9mDQo+ID4gPiA+ID4gZWFjaA0KPiA+ID4gPiA+IEdQUi4NCj4gPiA+ID4gPiBUaGUgcXVlc3Rp
b24gaXMsIHdoeSBsaW1pdCAjMTQgdG8gYmUgaGlnaCBhZGRyPyBJZiB0aGUgR1BSIGlzDQo+ID4g
PiA+ID4gc2hhcmVkDQo+ID4gPiA+ID4gYnkNCj4gPiA+ID4gPiBhbGwgdGhyZWFkcywgdGhlcmUg
c2hvdWxkIGJlIGEgbWVjaGFuaXNtIHRvIG1hbmFnZSBHUFIgdXNhZ2UNCj4gPiA+ID4gPiBmb3IN
Cj4gPiA+ID4gPiBjbGllbnQNCj4gPiA+ID4gPiBkcml2ZXIgdG8gYWxsb2NhdGUvZnJlZSBHUFIu
DQo+ID4gPiA+IA0KPiA+ID4gPiBZZXMsIHRoZXJlIGFyZSAxNiBHUFIsIGZyb20gR1BSX1IwIH4g
R1BSX1IxNSBhbmQgdGhleSBhcmUNCj4gPiA+ID4gc2hhcmVkDQo+ID4gPiA+IGJ5DQo+ID4gPiA+
IGFsbA0KPiA+ID4gPiB0aHJlYWRzLCBidXQgR1BSX1IwIGFuZCBHUFJfUjEgaXMgdXNlZCBieSBH
Q0UgSFcgaXRzZWxmLg0KPiA+ID4gPiANCj4gPiA+ID4gSSB0aGluayB1c2VyIG1heSBub3Qga25v
dyB3aGljaCBHUFIgaXMgYXZhaWxhYmxlLCBzbyBJIHRoaW5rDQo+ID4gPiA+IENNRFENCj4gPiA+
ID4gZHJpdmVyIHNob3VsZCBtYW5hZ2UgdGhlIHVzYWdlIG9mIEdQUiBpbnN0ZWFkIG9mIGNvbmZp
Z3VyZSBieQ0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gdXNlci4NCj4gPiA+ID4gDQo+ID4gPiA+IEN1
cnJlbnRseSwgd2Ugb25seSB1c2UgMSBkZWRpY2F0ZWQgR1BSIGluIHBvbGwsIHNvIEkgZGVmaW5l
ZCBpdA0KPiA+ID4gPiBpbg0KPiA+ID4gPiBDTURRDQo+ID4gPiA+IGRyaXZlciB0byBtYWtlIGl0
IHNpbXBsZXIuDQo+ID4gPiANCj4gPiA+IElmIHRocmVhZCAxIHBvbGwgYWRkciBBIGZpcnN0LCBH
UFIgaXMgc2V0IHRvIEEuIEJ1dCBwb2xsIHRpbWUNCj4gPiA+IGV4Y2VlZA0KPiA+ID4gR0NFX1RI
RF9TTE9UX0NZQ0xFUywgY2hhbmdlIHRvIHRocmVhZCAyIGFuZCB0aHJlYWQgMiBwb2xsIGFkZHIg
QiwNCj4gPiA+IEdQUg0KPiA+ID4gaXMgc2V0IHRvIEIuIExhdGVyIHN3aXRjaCB0byB0aHJlYWQg
QSBhbmQgR0NFIHdvdWxkIGV4ZWN1dGUgcG9sbA0KPiA+ID4gY29tbWFuZCBhbmQgR1BSIGlzIEIs
IHNvIHRocmVhZCAxIHdvdWxkIHBvbGwgYWRkciBCLCBidXQgdGhpcyBpcw0KPiA+ID4gd3Jvbmcu
DQo+ID4gPiBIb3cgZG8geW91IHNvbHZlIHRoaXMgcHJvYmxlbT8NCj4gPiA+IA0KPiA+IA0KPiA+
IElmIFBPTEwgaW5zdHJ1Y3Rpb24gaGFzIHRpbWVvdXQsIHRoaXMgbWF5IGJlIGEgcHJvYmxlbS4N
Cj4gPiANCj4gPiBCdXQgUE9MTCBpcyBhIGxlZ2FjeSBvcGVyYXRpb24sIGl0IHdvbid0IGNvbnRl
eHQgc3dpdGNoIHdoZW4gdGhlDQo+ID4gZXhlY3V0ZSB0aW1lIGV4Y2VlZCBHQ0VfVEhSX1NMT1Rf
Q1lDTEVTLiBTbyB3ZSBhZGQgdGhlIGNvbW1lbnQgIkFsbA0KPiA+IEdDRQ0KPiA+IGhhcmR3YXJl
IHRocmVhZHMgd2lsbCBiZSBibG9ja2VkIGJ5IHRoaXMgaW5zdHJ1Y3Rpb24iIGluIHRoZQ0KPiA+
IGtlcm5lbGRvYy4NCj4gPiANCj4gPiBBbmQgY3VycmVudGx5LCB3ZSBkb24ndCBzZXQgdGhlIEdD
RSBoYXJkd2FyZSB0aW1lb3V0IGluDQo+ID4gQ01EUV9USFJfSU5TVF9USU1FT1VUX0NZQ0xFUywg
c28gaXQnbGwgcG9sbCBmb3JldmVyIHVudGlsIHRoZQ0KPiA+IHBvbGxpbmcNCj4gPiB2YWx1ZSBp
cyBzZXQuLi4NCj4gDQo+IElmIElTUCBwb2xsIHRpbWUgbG9uZ2VyIHRoYW4gdmJsYW5rLCBpdCBt
YXkgbWFrZSBkaXNwbGF5IGRpc29yZGVyLg0KPiBXaGVuDQo+IEkgc2VlIGRpc3BsYXkgZGlzb3Jk
ZXIsIGNvdWxkIEkgZmluZCBvdXQgSVNQIHBvbGwgdHJpZ2dlciB0aGlzDQo+IGRpc29yZGVyPw0K
PiANCklmIHdlIGNhbiBnZXQgbXRrX2RybV9kZHBfaXJxIHRpbWVvdXQgZXJyb3Igd2hlbiBkaXNw
bGF5IGRpc29yZGVyLA0Kd2UgbmVlZCB0byBkdW1wIGFsbCB0aGUgY21kIGJ1ZmZlcnMgYW5kIGN1
cnJlbnQgUEMgaW4gZXZlcnkgZXhlY3V0aW5nDQpHQ0UgdGhyZWFkcyBieSBtb2RpZnlpbmcgdGhl
IENNRFEgZHJpdmVyIGNvZGUgYW5kIHNlZSB3aGljaCBQQw0KaW5zdHJ1Y3Rpb24gbWF5IGNhdXNl
IHRoZSBwcm9ibGVtLg0KDQpJZiB0aGVyZSBpcyBubyB0aW1lb3V0IGVycm9yIHdoZW4gZGlzcGxh
eSBkaXNvcmRlciwgdGhlbiB3ZSBoYXZlIG5vDQppZGVhIHdobyBjYXVzZSB0aGF0IHByb2JsZW0u
IFdlIGNhbiBvbmx5IGNoZWNrIHRoZSBmcmFtZSBzZXF1ZW5jZSBpZCBpbg0KSVNQIGRyaXZlciBm
cmFtZSBkb25lIGNhbGxiYWNrIGlzIGRpc29yZGVyIG9yIG5vdC4NCg0KQmVjYXVzZSB3ZSBkb24n
dCBzZXQgQ01EUSBoYXJkd2FyZSB0aW1lb3V0IElSUSBvciB1c2Ugc29mdHdhcmUgdGltZXIgdG8N
CmhhbmRsZSBzb2Z0d2FyZSB0aW1lb3V0IGluIENNRFEgZHJpdmVyIGN1cnJlbnRseSwgc28gd2Ug
d29uJ3Qga25vdyBwb2xsDQppbnN0cnVjdGlvbiBpcyBibG9ja2luZy4gSVNQIGNsaWVudCBkcml2
ZXJzIG5lZWQgdG8gYWRkIHRoZWlyIHRpbWVvdXQNCmhhbmRsZXIgZm9yIGVhY2ggY21kcV9wa3Qg
c2VudCB0byB0aGUgbWFpbGJveCBjaGFubmVscy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0K
DQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gSmFzb24tSkgu
TGluDQo+ID4gDQo+ID4gPiBSZWdhcmRzLA0KPiA+ID4gQ0sNCj4gPiA+IA0K

