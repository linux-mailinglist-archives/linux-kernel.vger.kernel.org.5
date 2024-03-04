Return-Path: <linux-kernel+bounces-89983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6300486F89D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE251F214B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2361854;
	Mon,  4 Mar 2024 02:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MHZv7ZbT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HXuoX4Rv"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD4C522D
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709520004; cv=fail; b=Wf2OOmfNCvXjCpuDNAjqU4N70FRtX/C4CoZ28hRBpdKzbZ6Rjjhwf98tYRuIukRnErU4KOmea/SrGf11CHvzrlMVz7Ki3kE3tNhZlwUPEDSXpAf0svxof7W+Ex12HmdlcQgLOyIiWQtqCCqsrlmxnWLEPamXp9/ynaZIHxu2qQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709520004; c=relaxed/simple;
	bh=DHzoKuu9hMova/2lG6IdKmwRdpoXNZ16mFwX3VJdlUM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cWYGemLbia5CcPx3h61JwXF1sWmWNCSzTZmA0sg6/Fm5UophpsleCPdpwX6eSxcxI5keNwFsNdfMR1u8Gr2d7TeWFv3CY8LCwlKJMv96JALLr7Idystqi/KhEJynv8FPIQHK0uHef3DmVlsiMObFXtmsV7B6VnSKfwPoLXdiQTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MHZv7ZbT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HXuoX4Rv; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7d413666d9d011ee935d6952f98a51a9-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DHzoKuu9hMova/2lG6IdKmwRdpoXNZ16mFwX3VJdlUM=;
	b=MHZv7ZbTpM4WGx+J+5tS+WR61U4W+DHnCyuLH+tAgNyDh9pRTM8JcNPeHqBb9CThAUx78aO2mU7hfgszHpDGEGrMONGkQOKtSVMlpjlXp4nI5ZTp3Q8zYWpkMXbxZtAzViOhh6wrqECA0Ak7IqKDPx48boaKk2sJ7PFSNm5n5OQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4f8aee31-cba2-4028-af2d-bf4e9a940da6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:88e81081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7d413666d9d011ee935d6952f98a51a9-20240304
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1821996714; Mon, 04 Mar 2024 10:39:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 10:39:56 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 10:39:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFRFueCb9FFD0UObm6/w9onuyEwffkgtbwiVgpMj15XALVNKvnkpKlnjwyBq/W9/nl1nh8mBEhSaKkNAD1c7PnU3da+LpQKt7yb3Xj0jUXoGPnhyaLvxI8bO/hYfEHesY3eVz8PXUg55A98b55/ch2O+qEVe0Sk50OZDnyeLmrvF5lUhumTIQ1oagXUVEeWMZ3ZAoCM2nIeOqneFuwoL+x1pRl+YEN7IyOaDXxQWPZ7h3VBdiLSbbuXFSZ8J0EIf/DlCg251ripqwZON/nQN5GdF/Rb8WRnEq74PhRLnEtHx+nk1xRQ9h2uvL7mH6DlgJH1wJw4oxTIwAYXmg/tUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHzoKuu9hMova/2lG6IdKmwRdpoXNZ16mFwX3VJdlUM=;
 b=gUXA3mj0ttzyqsMxQJV7Si4xf9fbgkCCE7+omXK0p2pcvocpeC/Fnmgshjq8XSf9EeYEHLH4GjrIlXUemhSFMBVDSqEGhcKH3yrsGDTO15/+hd0JXtsiHWvKKNp8Nrj12rR3oT3VB654EPD4H33SngqVB4C2TaRYDs+HnIPqK34x09ZmuOMIevzyilX7+WWxEu87Q32824ITljBQT36+lcWwNmF0qOcjeTsNEz/dCiYntxr7W/KWMB4U3cRd5ejDLFRJlGawovcoXnnq1p5X41WnQIzj8rqOAmya8U2VdyG33KpVyfEWzv97t3M51+31/z/75/WuBnJeSNG0TwGAew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHzoKuu9hMova/2lG6IdKmwRdpoXNZ16mFwX3VJdlUM=;
 b=HXuoX4Rvg1xtBosQaPjOyD106dpv/WFSMgsnoUO4p+1xXWnY+VBvNC0J/S2IFmKBMXR48X1OWKQN7uQaziywuMWvUo9XNH1NM8C1n5FuH51k2qxgCYEW5ZO/pipYk4Y/rcWBaUb9cJgA32LijUkK6P/wMXYqjHbgh9EU7mkdPHU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7244.apcprd03.prod.outlook.com (2603:1096:400:285::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.36; Mon, 4 Mar
 2024 02:39:54 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:39:53 +0000
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
Subject: Re: [RESEND, PATCH 2/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_mem_move() function
Thread-Topic: [RESEND, PATCH 2/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_mem_move() function
Thread-Index: AQHaa+cMxMnSEzOdcEq09CiuIm1YGrEm4qqA
Date: Mon, 4 Mar 2024 02:39:53 +0000
Message-ID: <fc7bf56d8bc962d3f8d28c9aeab1e2282acccca0.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20240301144403.2977-3-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7244:EE_
x-ms-office365-filtering-correlation-id: 5c060c2a-6a1c-4d24-dcd0-08dc3bf45f78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NDYLEjyr3hqGzdWawdbJwpDBS+FH9VLx6YQACKQO3LhqU7TDBjy1tffiWmnrjGU/hw+mRQYVQT3RACXslNHfD5OZIM7kqnkAwyha0AJPWArYuABdrarvAQy+Nu2Khn2Gpw6YvT7q/s0fc7ZT8XmRlnx2RFnT7fC6HaCHk7qRW+0z5ft35YHXIX7GCJDVmxecXWcp1sDOA8VEK+g+gDwG3kEc4Hj4XEUJQlC3FoPH9CuPZCoDOfS6Hcsv5n1DpGOULCj1N9/nB53k4i1Wrc8mTCuZRlB4Up0gUu5i20UqPduyAdQ8lrFnTiJmncL8Ro531azXQOnM5qi0RcU7FzC7lQLb5WEgOocEadLgStq6wLjk7n83ACrwDO2ByOjW6BvfQkpCOklpJQcnwmCzjfgP4Wsbj4haRMii2YwhSCqFuVd9prheVNPg92GwW5ibVdDoBFgRJXaLOSsx7QB/KTrTmwiyM3xVwOkM+DS9TpnUt5QThvlCVEesaWCl3Xpzyodc15sPyMMsxnvm9QvtA/vCJhzk+tqtqn6WBsxg+/LQlwt1wC8VQKH+SAoJQfTK6GHWDhILb8Z8jOqwmgIGcZxEAEk7ZqIypk6RZHETA+a/fMk1nZcfVtEQANO4EaMHJNV0GuamlOsIxrN7VbU1THo42fZLpr3eJHlAcXMm0CdJfcymSYkWHXHnksWxeLUfpTUo2XiQYTanmd/qJL8eklrs06tzxg0OKcjCzB4jNCy+sq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU9DemM2L2E3SGJpejJJVFl6QWRnTTdWU1BQRTc2ZnZJWjZGMzNiZUdHdXU0?=
 =?utf-8?B?b0VDV1U0VlRMMC96bGN6MEw5UTZyT1F6OGdLOGY5dkZCYnlJUDNFaDBENG9q?=
 =?utf-8?B?Q2RyNFVFVjRVZEpZeDVxRm5ualNaa1dLZmU5NGFmRTVrTzlaZWt4OEpBQWtP?=
 =?utf-8?B?SitXM2k1QWw2Z1FqV0NSU3J5UWRzbEpzZ2RsQzVaREdtYWcwQTVsR2lKVU5D?=
 =?utf-8?B?NUFxTktMM21qbGEyTUFBVVl4VzhCdVJLMjdKN01iMEV5Tzd0ZDd3V1FmMGVs?=
 =?utf-8?B?OWJwaDdVSm4yU3hMT0lqR2ROYzRHcmhwYkxhalcwU1hjem1WVXJjdWg0T1BF?=
 =?utf-8?B?eUhDTHllaVJKMWxIZDRNWGpreEZscE5DTWhCeHlGMWZGQVhDaVFhRXRjTUpK?=
 =?utf-8?B?emVzSFJLKzhPZFRnOVJLeFdOMkk1TCt5TjFjdzRkN2toWHhsdGxWaTZFa29E?=
 =?utf-8?B?MUQ1Qm1LN0h5SVFYR0RTYU9OTTJoTDR1cElad1BLay96UklSQnp5SWdPYStJ?=
 =?utf-8?B?VFg5RTAwaWMyUUJBbC9BNjlIUzlvM2hnbGxFN1BEWkJTVUo3NWpTY2pHTkVG?=
 =?utf-8?B?ZnRNT0FqbjVmU3RrZDFRMExnSGtWQjF3YitqRTF3Y0Vnc3FVeVpTRTViSlFS?=
 =?utf-8?B?NDl6R3ROaGlFMk9Ia3E5d013cXVVMzhweHEvVDU5blh3UU1DZWpIRUJjeVor?=
 =?utf-8?B?MHN4Q3A5b3dQR1FsbkVySE45ckxJc1VGdmJ2RHpYUlVnZ3RWdVF0N1dVN1hu?=
 =?utf-8?B?WUU0aSt2dFkwaUJYQWt6YjFkMXQrRzNzMDliVVJDeForRGdiblNXL0VzVnJ0?=
 =?utf-8?B?d1RDVnFURWhVY0FjbUxhUFhKY21WaEU1cHE3VFIyL1JVWDdwYmsxa0RKTW1k?=
 =?utf-8?B?K2xXRlJwU01sQytRcFNDL2k0MkdFTUR2amNPK0p0bFhVWGVOQ2Q2SmJhbTkw?=
 =?utf-8?B?UTlkTmxTQnE4c2ZZeEJYTXNmL0hOSnUrM1V6TGRRdlhteDIySVlPYk4yYzVk?=
 =?utf-8?B?SWlGTWNNT2oxa29JSnN5dFZJNEhZOXFENTJ5YkVOc25sKytVZHJ1U3JTYi91?=
 =?utf-8?B?Z0RneG1oNE4zZ2dGV1hxSm1JdkUyd1Z2MGZQNUdPSXJKWTRieEhTL1hOSkl5?=
 =?utf-8?B?U2xJUXhUR2hTU2FIVVk4MnhFbmx0NnJJaFF3WThHd1k3Q2dJWTdlS3R0Zm4y?=
 =?utf-8?B?OVJNZFo0WjFRa0E0N3ZlamNwY05EUk5wNUsxL0NUNldhQmtGaGlxa1VuK0g0?=
 =?utf-8?B?R3NvVEtST05sVlZrUE5ieGJqbnEvcUZlN1M2Q0NSOWRvNGdNZENNNmkzRnMv?=
 =?utf-8?B?R1lWL0dJeG1jRUNCMVBTVlRMa3V6SFRqTWRwUnJ3amhJcS9vck4vMjNZOWV1?=
 =?utf-8?B?SGNtRklRb1BiYVM0NjFtb0tDbGljKzNkUVF0WjJ1Rzl2VWpzcmhKMDlHNjJ2?=
 =?utf-8?B?RjZEUzRjTWxmbzRzQUVFblVUcnpDTm5oblZKSGExNTA2UWZkQ2VjaFpGaUNL?=
 =?utf-8?B?WXRpT010MzdSWEZBNUVCL2ZSdHQ4OGhVV08zVzRQL1ZYS1VmU1BSMitNVEwy?=
 =?utf-8?B?bzNTRnlJTlhwUEVyWlJqWHdVMGZGbk82Slh3SXNPYlpOSUt6VWdaZG8yMEhi?=
 =?utf-8?B?ZDJSQXVJMGtzZUdnTmo3YXBHc3JtU2VqcFJGd242SERZdkYvdnVaR0hQOFpM?=
 =?utf-8?B?ajFwL0x0Z3ZXYlZrQzREa0tXSVN5cnFIUHJvSGYyNGVsbFpNUHB4bUcxQUNy?=
 =?utf-8?B?c1h0ZWdLU2wrTW5CZExTMUtRRGV5ODlIY1IzTWFwZzZYUDhTSGZzZ0tIY3Ur?=
 =?utf-8?B?bVc1MUZyL20vcFQvMEk4V1BlbHRqbk8wL09WOXlSRk8xMWZHWFI5b0hZVVdJ?=
 =?utf-8?B?dUZPckRPNlZyLzhiK2Z6WnhvZFc3YXhBUUZUOUpIY3NIVEd2Ulh2YjNzUkZw?=
 =?utf-8?B?dGRnZlIzNXdTQi9IYzR4QlkxQWppV241Vkd4TDM3K1FpaEdPN0ErREF4SHlt?=
 =?utf-8?B?UkNCZGhFUk9tVURWakxUWVk3TEZHTzQvK0V5SFFaWTBjMUw4U1E3dXo1OWNB?=
 =?utf-8?B?UFFTUVMwdGFEbzMwdU9Fdit6MUxIUTlwMlVRa2k2Umd5RjJ4K0l4bmQzeSsr?=
 =?utf-8?Q?cVqo8eGsilzlp3JLG9yvbXb/n?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3753BABF40CAC4B992877A961E8EAB5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c060c2a-6a1c-4d24-dcd0-08dc3bf45f78
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 02:39:53.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzI/qtmOy5jEWrLK3dsJLj103sS4XeArU22TZhM3k0hPRSWHWdyjtt3uZBuTY/ZzVsODANkFEjMVR+cTCTDbNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7244

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjQtMDMtMDEgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGNtZHFfcGt0X21lbV9tb3ZlKCkgZnVuY3Rpb24gdG8gc3VwcG9y
dCBDTURRIHVzZXIgbWFraW5nDQo+IGFuIGluc3RydWN0aW9uIGZvciBtb3ZpbmcgYSB2YWx1ZSBm
cm9tIGEgc291cmNlIGFkZHJlc3MgdG8gYQ0KPiBkZXN0aW5hdGlvbiBhZGRyZXNzLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMjYNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmggIHwgMTAgKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMNCj4gYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0K
PiBpbmRleCBiMGNkMDcxYzQ3MTkuLjNhMWU0N2FkOGE0MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gQEAgLTI5OSw2ICsyOTksMzIgQEAgaW50IGNtZHFf
cGt0X3dyaXRlX3NfbWFza192YWx1ZShzdHJ1Y3QgY21kcV9wa3QNCj4gKnBrdCwgdTggaGlnaF9h
ZGRyX3JlZ19pZHgsDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3NfbWFz
a192YWx1ZSk7DQo+ICANCj4gK3MzMiBjbWRxX3BrdF9tZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgZG1hX2FkZHJfdCBzcmNfYWRkciwNCj4gZG1hX2FkZHJfdCBkc3RfYWRkcikNCg0KcmV0
dXJuIHR5cGUgaW50Lg0KDQo+ICt7DQo+ICsJczMyIGVycjsNCg0KSXQgbWF5IG5vdCBlcnJvciwg
c28gSSBwcmVmZXIgdG8gdXNlICdyZXQnLg0KTW92ZSB0aGlzIGFmdGVyIHRoZSBuZXh0IHR3byBk
ZWNsYXJhdGlvbi4NCg0KPiArCWNvbnN0IHUxNiB0bXBfcmVnX2lkeCA9IENNRFFfVEhSX1NQUl9J
RFgwOw0KPiArCWNvbnN0IHUxNiBzd2FwX3JlZ19pZHggPSBDTURRX1RIUl9TUFJfSURYMTsNCg0K
SSB3b3VsZCBsaWtlIHRtcF9yZWdfaWR4IHRvIGJlIGhpZ2hfYWRkcl9yZWdfaWR4IGFuZCBzd2Fw
X3JlZ19pZHggdG8gYmUNCnZhbHVlX3JlZ19pZHguDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsNCj4g
KwkvKiByZWFkIHRoZSB2YWx1ZSBvZiBzcmNfYWRkciBpbnRvIHN3YXBfcmVnX2lkeCAqLw0KPiAr
CWVyciA9IGNtZHFfcGt0X2Fzc2lnbihwa3QsIHRtcF9yZWdfaWR4LA0KPiBDTURRX0FERFJfSElH
SChzcmNfYWRkcikpOw0KPiArCWlmIChlcnIgPCAwKQ0KPiArCQlyZXR1cm4gZXJyOw0KPiArCWVy
ciA9IGNtZHFfcGt0X3JlYWRfcyhwa3QsIHRtcF9yZWdfaWR4LA0KPiBDTURRX0FERFJfTE9XKHNy
Y19hZGRyKSwgc3dhcF9yZWdfaWR4KTsNCj4gKwlpZiAoZXJyIDwgMCkNCj4gKwkJcmV0dXJuIGVy
cjsNCj4gKw0KPiArCS8qIHdyaXRlIHRoZSB2YWx1ZSBvZiBzd2FwX3JlZ19pZHggaW50byBkc3Rf
YWRkciAqLw0KPiArCWVyciA9IGNtZHFfcGt0X2Fzc2lnbihwa3QsIHRtcF9yZWdfaWR4LA0KPiBD
TURRX0FERFJfSElHSChkc3RfYWRkcikpOw0KPiArCWlmIChlcnIgPCAwKQ0KPiArCQlyZXR1cm4g
ZXJyOw0KPiArCWVyciA9IGNtZHFfcGt0X3dyaXRlX3MocGt0LCB0bXBfcmVnX2lkeCwNCj4gQ01E
UV9BRERSX0xPVyhkc3RfYWRkciksIHN3YXBfcmVnX2lkeCk7DQo+ICsJaWYgKGVyciA8IDApDQo+
ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwlyZXR1cm4gZXJyOw0KPiArfQ0KPiArRVhQT1JUX1NZ
TUJPTChjbWRxX3BrdF9tZW1fbW92ZSk7DQo+ICsNCj4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikNCj4gIHsNCj4gIAlzdHJ1Y3Qg
Y21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+IGluZGV4IDFkYWU4MDE4NWY5Zi4uYjZkYmUyZDhmMTZhIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ICsrKyBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gQEAgLTE4Miw2ICsxODIs
MTYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsDQo+
IHU4IGhpZ2hfYWRkcl9yZWdfaWR4LA0KPiAgaW50IGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1
ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgNCj4gaGlnaF9hZGRyX3JlZ19pZHgsDQo+ICAJCQkJ
dTE2IGFkZHJfbG93LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gIA0KPiArLyoqDQo+ICsgKiBj
bWRxX3BrdF9tZW1fbW92ZSgpIC0gYXBwZW5kIG1lbW9yeSBtb3ZlIGNvbW1hbmQgdG8gdGhlIENN
RFENCj4gcGFja2V0DQo+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gKyAqIEBzcmNfYWRk
cjoJc291cmNlIGFkZHJlc3MNCj4gKyAqIEBkbWFfYWRkcl90OiBkZXN0aW5hdGlvbiBhZGRyZXNz
DQo+ICsgKg0KPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2Rl
IGlzIHJldHVybmVkDQo+ICsgKi8NCj4gK2ludCBjbWRxX3BrdF9tZW1fbW92ZShzdHJ1Y3QgY21k
cV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBzcmNfYWRkciwNCj4gZG1hX2FkZHJfdCBkc3RfYWRkcik7
DQo+ICsNCj4gIC8qKg0KPiAgICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZl
bnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tl
dA0K

