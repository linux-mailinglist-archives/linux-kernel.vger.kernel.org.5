Return-Path: <linux-kernel+bounces-89973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7C986F868
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519FC28105D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 02:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B115B7;
	Mon,  4 Mar 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rSMmrhRh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dkbyZAO+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33963A31
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709518289; cv=fail; b=ulspzvRLavLc3novUscfCMaFx69aL2uTe2nxlTpLXUx54nLvOXSRaGwEoO5D5KTW3WhwkA0oIEGQIcLTLacHjiOnsyxhAP5/mqkDOitIvv+QKXfWPIa2uScWt8YDktcgKd/Tt1qXU/tMYyLVki1Xwg/FS5piPeM994U4QEDQ/hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709518289; c=relaxed/simple;
	bh=aHXidaeQKN0zJ5rcYqu0yaeaHkfXlKjKp1zHjhTHnl4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dezs87c7Ylwh1l6K1P3VlbEf8BxJKQMJ9T96QQoNj9F7/cLFngyfn4q1F3zroXMaIJ5D7Zw+Nis2mxusxBJL87i+shOI+BOnuV4jpEriTTbik3COW3BEJqWyvA43ezQd7s/4tQhdaAqKahoa7xtpISlykbh1tL4DxeuRBxwHFbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=rSMmrhRh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dkbyZAO+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7f3c2736d9cc11eeb8927bc1f75efef4-20240304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=aHXidaeQKN0zJ5rcYqu0yaeaHkfXlKjKp1zHjhTHnl4=;
	b=rSMmrhRhfRpBM7FBsj4TrIThhAtNPAXJjtmTgLo49qUWyY66gh7hJOyXxbtpf1uMQard4UDXj7w0R7qK8/HiJQ7IW3ImwEqXt0sW2g1D2AwLhkjEbfwqXDa2620anQ6XJSB2/KN82bq+/XXuyxYbbEcRkXgJ+RIjwSRW5eMew8s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:7ffc1ec6-1ad5-4422-86c9-13ba820e6ba7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:84831081-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7f3c2736d9cc11eeb8927bc1f75efef4-20240304
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 870991442; Mon, 04 Mar 2024 10:11:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Mar 2024 10:11:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Mar 2024 10:11:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGBGgTP3TBDXafVNDRMk8tojSqpGZ3Hb71ufinQ28LK9TNnw86HjaWtJchT5jMlNbB8ilR4uwc4tMfp0mIuo0pfQNCpHf0i/7n4GKHQ9MKCLRnzWDGBUpLSna1ix+hP6v4qODqPugkvHC07XGQWZiKreXRzB27hS561NMx6KqbO9Lr/PVfrXOm7GSXc/8O0bSpotKcoGGlVgTHG2FhCfhuU4Att6R9Cyh9y1A6KLWElCPEY0PWJKn0znM3tiIN/KT0ix18cUnhKLHQxLpens00RgWDPgwQZcdgBIYuTL0FsX8ZKfzeEJzCxW949C2Y7kBrIxuKnkIkl158TefVGiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHXidaeQKN0zJ5rcYqu0yaeaHkfXlKjKp1zHjhTHnl4=;
 b=fTrEcMA7L8qiKT0RHWtAbpkA74lY6bWQXdVxPn9Ogcfvgy3dT2EvTcB4dLW1vhU0domv3LgzR5vV9MU4juY27fxkDnt6GF2FP10QpjoaHX8ZjVciiXl/+Owh9DHgtgLmCSTl1qMp9lZ7zj/wVgVWKyd2fyZblIt5Q2dS1qCJhEws1Ja3HH5YLe3ju4cFTzl8U6DMJSHWlOzkNs6VSe+9DZrtyt1BK8Rysexxv9iN/+c3eXmFXg8bbC6u1vkGsialcMDFqTNRE0NhYo7QtDW89Dwk5qPWH+WFL+WURYuShlhubQy31rm/1kx47ut8lsNr0nUMItlbbkR+SGJu65fHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHXidaeQKN0zJ5rcYqu0yaeaHkfXlKjKp1zHjhTHnl4=;
 b=dkbyZAO+GObMviY3Og1x1mI4J4aUYFHurk52LZJFudSNmUX8vFh9z12HjsLkAoVFnNnZkbdgYF8YYJOLGFFFbA+pq+SaQ6fgkn1oXQn3rhWXqXvb2uUHRST+qYY+mI+j8Ll4vNS+2kGbL3dnNjWG94nKLo5n3gBzUaC+Ym4CS6o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7992.apcprd03.prod.outlook.com (2603:1096:400:472::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 02:11:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 02:11:18 +0000
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
Subject: Re: [RESEND, PATCH 4/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_acquire_event() function
Thread-Topic: [RESEND, PATCH 4/5] soc: mediatek: mtk-cmdq: Add
 cmdq_pkt_acquire_event() function
Thread-Index: AQHaa+cLpU3uhZOk6EW7XZ3akksJTrEm2q2A
Date: Mon, 4 Mar 2024 02:11:18 +0000
Message-ID: <ade36b07c4f60a755a3b7700250e56ec61711d53.camel@mediatek.com>
References: <20240301144403.2977-1-jason-jh.lin@mediatek.com>
	 <20240301144403.2977-5-jason-jh.lin@mediatek.com>
In-Reply-To: <20240301144403.2977-5-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7992:EE_
x-ms-office365-filtering-correlation-id: 61fd49a5-10b4-4a1d-e178-08dc3bf060c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ISyWRQnp+j6StzU1apxJO69M/DiWz+L0PE+zMTA0GR6AiyE0FwJqmLy/SVFFXlSzJraMmCoUD/qY4Jp7soD/wfbc6XNwLXmFUKQ+J0fAsYym9enQ5Em8PaxaCXJQZDg7ob+mYj5IBnGf54GTZTazS4ltBDdlIuuSpWZn/ZklJwGwU+4vLIJCflCE99rOy+4bqayC5rl63iKjk69Y1Y7IJ2fKciqb8yrC+M7OcM+23UlRr5YmjGuSnOrdzYcfDR/DOxosa3S1WvV5021Bihzs1E/F2bls4+fvnJldqbx0vrjLvcL43szFu7YGh7A/AZqTkRCT4nWE34lLStpSF1LrzNawJW6Mc+IIueqK6evxLl4nPBFO5lpdd2iFRl+ZqoHWxQFzvmddTxEtURGHBwOaax/oW4ooj8OAUcmIFuSthh9/7SGntBBvo1kVUK1Iyd5DZYJVCBQZLHDQK7IZb5xHP+o+45aMVvCxUfB8i1KPx0wBR1cpuRjKcHfmQN01H6GfqMo+Y3beLGqwu0P7aKmr5lD3nnenVKmyScEdzTAZ4W5pAOYXXcr85eV6r1XPigASCoXFpMpaz9DvZ8RjGn9nMkUCIPBKTGtQ9DhbNF9UInMhUVauxIL2aNtYvhJR8DbVcjqeKNPx4r4clKnoCkJy2BupAXxqqQA6xX0keelQe3UB/zQMvxtyOVYHbhhXU1NYiNFBQ/0BTR8qGuBAN9GbOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3FDY1FSTW1xcDlmNjhuNXlxSW1zNk1iL285WlprR3c1dGpxVzFqZG5GbUZk?=
 =?utf-8?B?N0Y5NktvcmJhZjdvamRZSlZMM2o1N0l2MTlmZWdmRC9lRlA3MVRYREdhNUpC?=
 =?utf-8?B?Kys3a0lza041eE9Ja0VhQm0yc3VoSjVUQ2pPVjBGY0Z2czdWOXFIZk9lS1JV?=
 =?utf-8?B?TUhaRmNBZjBKMmZ4ZHZnWUd2bTVTNjU3L2Y2VDR0K3pERDd4bVdqbjYzakJ6?=
 =?utf-8?B?ZGhQZTQxNlFjaGthckFBZ1hudm1EOEtveEZYZVFhRHhMc2RwR0xEUERaWFVZ?=
 =?utf-8?B?RTZteHRJSUtzNEdkaEwxaXZBTWlTcGdDZytDeTNiVE5hQW9waTBHN2RUMWR4?=
 =?utf-8?B?TEFaalhBVGdnaU1mTlhMdXZKMEN5MFNtY3FSNGh1Q01aVVFldElCcEZVNWMz?=
 =?utf-8?B?WHlQbjEzMmR2dHl6Z2JWai9BUFhxVDlVZGowMURtMmZDL0ZIVm1hakVSTDZq?=
 =?utf-8?B?bXdsQ3hkbkxRbFd2b201MVRDNWs2ampTdk43TGlQTDNtcU1jSkM0NHNLSlJ6?=
 =?utf-8?B?ZW9UUlBVMWNmclNoOVp3WTJNTjRHVXd4cWgvc0gxSWllNUc2endUQTh1aGto?=
 =?utf-8?B?MUwwajdJNGpaeE5McTloYmR1dUhIaExKQ1VqVVJvdHo2bFl3eU1KMkwxQ1lQ?=
 =?utf-8?B?VzQvS01odDFhaVlWenI1eTF6MjcxbDlFWHVETWthV2xLUUNVa2M4TitmOWlU?=
 =?utf-8?B?ZTNoek5pUGxDMzFUQVJ5ZkwwU05Na01WQmx6a0JKVitKLyt3Q2VzUXJMVDB6?=
 =?utf-8?B?SHZTWUFwMDB4UitYSG9oQ3pQaE9XbWFhQnF0Ykw5b2JIZm5KeW9RQkRGeUV2?=
 =?utf-8?B?QWltZitqTGdENjZOK3ZodUU0eTNBeENDcGhuYnZ4R2RRNnFBMTZBT3AvaEU0?=
 =?utf-8?B?c3M1aVBpNjZKRFNZVmJvMDdNS0ZXRG43UU91OUJVSGNUREZsQ0RvdW1CQStT?=
 =?utf-8?B?N3FYMFlmNzZ0a1Uwbml0bU5hdkJEMmJQZ3RlQjJhcWl2WjZEVzZVb3pzVStr?=
 =?utf-8?B?RjNXc1RQUlVRbmJ3QWtYRTdsRW1iRGZqbERLZkdHMDk5T2hMWHZtMHNMVHlq?=
 =?utf-8?B?dXFSZ0F1S3FadW0zZDlPc0xtaERIWXF3VWFBS0RGelhHbmdJV0pmbmxVQXZh?=
 =?utf-8?B?enpRNnVNVExHM1UrQzdBaXNsaUM3ZUpnUThQUnJ2a2tWZ3ZteklsVjRCU3ND?=
 =?utf-8?B?L09JY3M2bWErTFNmbklqUU13dEFsbHUwNTY5SW1HenkwQURJdnhXNy8vOGps?=
 =?utf-8?B?WVNqSHowK1Y5cGhucWx4Y29Yc2lKYTcyMTlGck4vNldhRmhPNWlyckIrajZz?=
 =?utf-8?B?Y0JGdG0rcVhObmtqam1nZDZIQzlEYnU2d2RXZ0VtUGpJbFdrd2V2Q0ZNNisw?=
 =?utf-8?B?MklxT0NIL2NFdUpiSHU5bDAzYnVGaVUxbE1Cb3NhT1FJZEJlZlhwalQ5dDkw?=
 =?utf-8?B?Q2lnWTQveThXaTZJWnRsYkNnQUdoNFhTOHBtWWc1bEU4YmFHckJUTTR0eWty?=
 =?utf-8?B?NEhyVlJWT0JoQmlQVnFLMVlUOXM4ZksySCtTM1JMTytEL1I0bGNTVUR3ZjVh?=
 =?utf-8?B?dFhKc3cwWlZaQW5CTzJZNVV1QVJYb0RqQWRYaDZEN1Q3djZsME5yN295ZlJS?=
 =?utf-8?B?Y1AyMDFuQm9CMWkvSDVtd09QcmhWRFBKUGdOSkZmVlRURGZQK0NjVE5SNnha?=
 =?utf-8?B?bTRjckw2Vy93dWZOUzh3ek43V0lTRnBPK1JVcW5NY2MxajY1cU5FSXVvL05q?=
 =?utf-8?B?T2FUMEs1dnVZaFNsNStWNFZselY4Mm5EZzBjeTJQYzN5ajkrWEt2c01xMUVu?=
 =?utf-8?B?Nk5od1pQbUZjNldyeFdBUE85RVBhdDFBU1l1OUNmckJGei96MUVOVXpSeEps?=
 =?utf-8?B?T0ZZWU9MdXBseVpHNUk2UGIyTXJKdXdRckVlbFYramt3MEFTVk1KMjhXRnZ4?=
 =?utf-8?B?TVRmd0EwYk9oaGNVenl5Y1V0N0lrSWE3Ym1tMmRWeEVoRjc1dmJGOUVpbTBC?=
 =?utf-8?B?Rnl0SS8rK090RmVRK0M5N3VJbUlCQVc1N0JMNmFaeVJ6Nmx5R2szcVZTbXIx?=
 =?utf-8?B?RDUvMFVVbjRmYmpxbkgzbVJkd1ZwbnZOc1phRGJkWVVnTGRzUFRuckJxbGcr?=
 =?utf-8?Q?62k/EG4+izOZoJFFvwz5ncS4y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <30832091EB2A0B478427A2A6201C0D05@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61fd49a5-10b4-4a1d-e178-08dc3bf060c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 02:11:18.1226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QJ1gIldoxgiv6AKpmIZaEN3Pm+RYoIXgpS0UO6dw4Jhel+gpswi5HXqi5zgaxHb28yFgMJqtD+ce+gCYHIa+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7992
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.171200-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfvoSitJVour/Sa1MaKuob8PC/ExpXrHizxcKZwALwMGsysr
	JW0urk/e4azG4plFaZPKX3Pdweau2glMpDEUOdDrsyNb+yeIRAo0AKed0u9fB8KYIz68iIFcvKh
	E+jIZDRwV+qI2X8Mfk9QmEDtCZjuY0RCs70uuPqGEryjhqiyzyko8jH4wkX2j31GU/N5W5BCtqT
	vdhCcbZ0ZPa0R9xjYKBN6vHTXX4uob/YfuChee5rIGMNfiwa5NfS0Ip2eEHnylPA9G9KhcvbLn+
	0Vm71Lcq7rFUcuGp/FYF3qW3Je6+7YdficrnEI50SV9UEGDO/HN9uFLhnDD/1+wIwMbnt4MU61W
	6rKZqHqVId6qQR8aPPXbmGFE6hjEkHlX+G8CaaUh7oT+tXua7/wNgAzF8116xNxlEFDc5GXHtMB
	P/jXy2fh0UMxNN2q2VGMhh6J/ibp+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.171200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	C149298F6F93423D6695EB90FB671274A88F6E42DEE21B9A5DBE9A91B370FFA52000:8

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjQtMDMtMDEgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gQWRkIGNtZHFfcGt0X2FjcXVpcmVfZXZlbnQoKSBmdW5jdGlvbiB0byBz
dXBwb3J0IENNRFEgdXNlciBtYWtpbmcNCj4gYW4gaW5zdHJ1Y3Rpb24gZm9yIGFjcXVpcmluZyBl
dmVudC4NCj4gDQo+IENNRFEgdXNlcnMgY2FuIHVzZSBjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KCkg
YW5kDQo+IGNtZHFfcGt0X2NsZWFyX2V2ZW50KCkNCj4gdG8gYWNxdWlyZSBHQ0UgZXZlbnQgYW5k
IHJlbGVhc2UgR0NFIGV2ZW50IGFuZCBhY2hpZXZlIHRoZSBNVVRFWF9MT0NLDQo+IHByb3RlY3Rp
b24gYmV0d2VlbiBHQ0UgdGhyZWFkcy4NCg0KSSdtIG5vdCBjbGVhciB3aGF0IGFjcXVpcmUgZG8g
aW4gZGV0YWlsLiBUaGlzIGlzIHdoYXQgSSBndWVzczoNCg0KY21kcV9wa3RfYWNxdWlyZV9ldmVu
dCgpIHdvdWxkIHdhaXQgZm9yIGV2ZW50IHRvIGJlIGNsZWFyZWQuIEFmdGVyDQpldmVudCBpcyBj
bGVhcmVkLCBjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KCkgd291bGQgc2V0IGV2ZW50IGFuZCBrZWVw
DQpleGVjdXRpbmcgbmV4dCBjb21tYW5kLiBTbyB0aGUgbXV0ZXggd291bGQgd29yayBsaWtlIHRo
aXMNCg0KY21kcV9wa3RfYWNxdWlyZV9ldmVudCgpIC8qIG11dGV4IGxvY2sgKi8NCg0KLyogY3Jp
dGljYWwgc2VjdG9uICovDQoNCmNtZHFfcGt0X2NsZWFyX2V2ZW50KCkgLyogbXV0ZXggdW5sb2Nr
ICovDQoNCklmIGl0J3Mgc28sIGRlc2NyaWJlIGFzIGRldGFpbCBhcyB0aGlzLiBJZiBub3QsIGRl
c2NyaWJlIGhvdyBpdCBkby4NCg0KQXMgSSBrbm93LCBHQ0UgaXMgc2luZ2xlIGNvcmUsIHNvIG11
bHRpcGxlIHRocmVhZCBpcyBzZXJ2ZWQgYnkgc2luZ2xlDQpHQ0UsIHdoeSBuZWVkIG11dGV4IGxv
Y2s/DQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4g
PGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgIDkgKysrKysrKysrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDI0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQo+IGluZGV4IDJlOWZjOWJiMTE4My4uMDE4M2I0MGEwZWZmIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBAQCAtMzQyLDYgKzM0Miwy
MSBAQCBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYNCj4gZXZlbnQs
IGJvb2wgY2xlYXIpDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dmZSk7DQo+ICAN
Cj4gK2ludCBjbWRxX3BrdF9hY3F1aXJlX2V2ZW50KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYg
ZXZlbnQpDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHt9Ow0KPiAr
DQo+ICsJaWYgKGV2ZW50ID49IENNRFFfTUFYX0VWRU5UKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gKw0KPiArCWluc3Qub3AgPSBDTURRX0NPREVfV0ZFOw0KPiArCWluc3QudmFsdWUgPSBDTURR
X1dGRV9VUERBVEUgfCBDTURRX1dGRV9VUERBVEVfVkFMVUUgfA0KPiBDTURRX1dGRV9XQUlUOw0K
PiArCWluc3QuZXZlbnQgPSBldmVudDsNCj4gKw0KPiArCXJldHVybiBjbWRxX3BrdF9hcHBlbmRf
Y29tbWFuZChwa3QsIGluc3QpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hY3F1
aXJlX2V2ZW50KTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X2NsZWFyX2V2ZW50KHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgZXZlbnQpDQo+ICB7DQo+ICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
aW5zdCA9IHsgezB9IH07DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQo+IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
PiBpbmRleCAyZmU5YmUyNDBmYmMuLmRlOTNjMGE4ZThhOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQo+IEBAIC0yMDIsNiArMjAyLDE1IEBAIGludCBjbWRxX3Br
dF9tZW1fbW92ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwNCj4gZG1hX2FkZHJfdCBzcmNfYWRkciwg
ZG1hX2FkZHJfdCBkc3RfDQo+ICAgKi8NCj4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcik7DQo+ICANCj4gKy8qKg0KPiArICogY21k
cV9wa3RfYWNxdWlyZV9ldmVudCgpIC0gYXBwZW5kIGFjcXVpcmUgZXZlbnQgY29tbWFuZCB0byB0
aGUNCj4gQ01EUSBwYWNrZXQNCj4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiArICogQGV2
ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0byBiZSBhY3F1aXJlZA0KPiArICoNCj4gKyAqIFJldHVy
bjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KPiArICov
DQo+ICtpbnQgY21kcV9wa3RfYWNxdWlyZV9ldmVudChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IGV2ZW50KTsNCj4gKw0KPiAgLyoqDQo+ICAgKiBjbWRxX3BrdF9jbGVhcl9ldmVudCgpIC0gYXBw
ZW5kIGNsZWFyIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFENCj4gcGFja2V0DQo+ICAgKiBAcGt0
Ogl0aGUgQ01EUSBwYWNrZXQNCg==

