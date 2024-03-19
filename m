Return-Path: <linux-kernel+bounces-107158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEAB87F84E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC591C21949
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CF9535DE;
	Tue, 19 Mar 2024 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rtn/u4A7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tUTV2lBp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800640853;
	Tue, 19 Mar 2024 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710833125; cv=fail; b=J7a0tRa4g25GbOewulENh5ZMvBVJ8+AG/nIoK/mLwhtPF0OEAY0cL+LUki2lOjHqI71OxMfNqqZ/BbrXDSxOnyE+n8sQL9+KyFy8rKMrkSzeRxpdVGNntK+HKyWxfTQcYMjFU5t+6k/KxlBTToHh7vD+amBxd6+KyTt0gf7qsxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710833125; c=relaxed/simple;
	bh=9/i0sNDR6iHFJv9RjiWLJ/l0HGOHgJyU2ysXF3JutAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q6WiRSbjbiDcIVG60zyxVv5cIhzWgfMp3ZVWwxO8yYNuE9N9aUOf3wKgyZSPsC8mtOLoC9oD/mcJywYysF8N4fS8TM9IlvdQ27/jW3dDXs0ZuYGalbp/J/HE47RYMOsgosbF+M6QJ04M7+wogOwu0OKqIcJNPR+Ch9V5jR2h8z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Rtn/u4A7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tUTV2lBp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d6121920e5c111ee935d6952f98a51a9-20240319
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9/i0sNDR6iHFJv9RjiWLJ/l0HGOHgJyU2ysXF3JutAQ=;
	b=Rtn/u4A7Elpl8OI+MiKJiIftcbd+HwhvTJ+Mwt8jkO8zozRrvGy0Z89rLXknBuGhrWGVaexkTQYRhf0H43MX4abuFuzF5gTK8KvQqBpzx/GBUMDs/ZprXrxJyScF4iRvGx2kW/MPjrcBCXabbay7Kaj07iyJtPzm2Vk7saWE3L0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:4861b6cb-186f-4ae7-b504-5b6f728c452f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:4c3b2b85-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: d6121920e5c111ee935d6952f98a51a9-20240319
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1906366360; Tue, 19 Mar 2024 15:25:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Mar 2024 15:25:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Mar 2024 15:25:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8y5ysppgba4+7lBjnD1E92jCaTMgS8fFo6/0wiZh43Z/kNxAC29BWNxhv4a9IGERLKh2UUHrcwqAfFz+Oc2Nq98wcd46lZswIoM7kUBiQgd7EXD9VShhH1aB0UugLFStLmFrBEVReoE0hvAJktLO378fAy1C7j2+5tuklwqNjGKb0wzwbUFp/prfxASQjU+o6f/dki3hCp+sW0yvhnp9tnC7+GNQeBQTFR22EKVdrJumALxp71Wp9yZ0rgdnpJHu5ClCEuuTSlIeksZHX9YFEdOmXydqQF6RYFhFbLOyoem6h4vutTo1ElMZREMj9DdtDdiMunMwySMPHpk5IuhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/i0sNDR6iHFJv9RjiWLJ/l0HGOHgJyU2ysXF3JutAQ=;
 b=eJ4GDW7ciTpDppke8IbKy5PyNJ3ad52DEEnm1bdmh8A4I/JkzwIOcD+haaPcTBnuTi4b3pQrrWYhqMdrqx6CYHJ97GMLVT5QFNPWc/FdHHMJd2dhVJ9AcHprTC0MYxBEeb+Rqsl/07wpNJqCKKXPoMcUGfpD3if1gea9bPeCZ8tZGwGJjprsf27DJfgOrXWPJIeCtOHGEuZv6/ycH6y5pEIUj0HZGy8S9bik2u2ByIYPzIYTcNq7XdI+fMn0F7LOxsr0g334XVZlq2edp3x3C3OgjfUCBWVizWbvxPKQB92/VNsINjKuh8er6OWhVr2eehLpulNXIt1n/nXE5yVvbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/i0sNDR6iHFJv9RjiWLJ/l0HGOHgJyU2ysXF3JutAQ=;
 b=tUTV2lBpqVSYYaij2/Qd/PRPxq1BWRpz0EBsSL9bPJMPB+HGqKfHuUyXo88FOhsj2f8OzVF/FlQgxukt9pk4z9y0cHEniSsvY5og0qfyDAt4KDjTmG/qFjDF3nx7HQWqBnW1PWEeMVryTh90Z2YPFbgwe2RT9R0shzpJvX931e8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8992.apcprd03.prod.outlook.com (2603:1096:405:cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 07:25:14 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 07:25:14 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: display: mediatek: gamma: Add support
 for MT8188
Thread-Topic: [PATCH v2 2/3] dt-bindings: display: mediatek: gamma: Add
 support for MT8188
Thread-Index: AQHaax57HBP5i5Vvkkm9tEYcK3ZAp7E+xuyA
Date: Tue, 19 Mar 2024 07:25:14 +0000
Message-ID: <f1603b23fe5bf207bf70e93fd717a0e5cee697fc.camel@mediatek.com>
References: <20240229144844.1688-1-jason-jh.lin@mediatek.com>
	 <20240229144844.1688-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20240229144844.1688-3-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8992:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RnRRR6YarTuak5rgmH10bHS261WgsazWX1e1LqHIo36tOWEYopyuTfvaEruVwzKX0bLDa5UDzfhhoTFjNf7zw0RE/aj00lR0Ldejjy/3UXLXbALotzclNnWYwCSxH7xLG2aFKBfxbY2aBjBrxMsVXJ/MO1AiIJSsMtKMc2PN05lJvbndQG5N7cJc5Ou3oj+5Pz7O7s69lcFtoGEBY0OC9JNaRh9RdequzNk0280Y9B8CrGt6Gh2bGiorTjvjYgHM3P3golzX+5UFV+myEc43eAhv3i3RjdhNN6mnfEAsAgbBoAgpup0cMAR7e6TLksbY3g1tPAZSb4oAJ6nCLfhq57lBBtr0DjuPa05BGc3ndL5oX4bzJhgjPh1U3wr933DIo6838pKJ3YGuZyZej1z3hzrzgy1nQ1RgqargEgEqDZoWD4AlQxtQ4qvSzLwmhVZPaYJXd5jAXdply4UZRX1P3VTa958qAnqhchybPFyS1c9K2KreAxWWkABjl9Oe40ZcTXGQY3v4oDKbUqIJ4ekFRHeKpX5Rkz3bUEW2gMbuaNSineNzUT6LurmmUQ3Rllp/6Tw92kSC/YR0dAesvBeEcLHCkQgk+38pUindGNmqAOk/xJ1npZ+US4eyvZzHpM5X8dErCTuyj+ppCfEq/dgYjUqQyUocg4Nu2TDcaxh30zA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHVyTW1XUGhwak85UnJEeWRNNkhQYmtyRXV0QTBaaDBrVHFTcFBhcFdHR2dE?=
 =?utf-8?B?RFN2NEZuSkVBbE11SXdsWDJZY1VxWG9YMnhNM21hY3QzNEtNL25xcVdRTzFM?=
 =?utf-8?B?RU1VWlBzK1NicGR5bWNBQkdMU0syaDl2ZVllMmpBYnBSWXI2dGtTd3VFVEZ3?=
 =?utf-8?B?ZktMZlVrRlFEM1JYQjBidUgwb1l1c0R1RFdSWUlwRU5LR2RYb1BPbWxiV3F4?=
 =?utf-8?B?YnRTVEtxZndoNjJIUlVmem9GbWdOU3Z2Q2FUbWVWSUM3WUN3VGJwYlBCRjFh?=
 =?utf-8?B?Z241WXJiRnR4SURRM0V3UWt3VFA3UXFLMmZ4UTRZWlk0Z1NwcWtORkVnaTQy?=
 =?utf-8?B?b2d4QWY4RTljTVRLU3p6aGs1dFN6bWF1OGFGV01sWnZZMzlhdDhPaTVIa2hq?=
 =?utf-8?B?R3ptcWk5SmlUTCtzZUFCcStERjViUzhDQkZqZ24yMkNHeEJjYlA4Qjh6RXc3?=
 =?utf-8?B?UHdwVTNNcWE3MVNsZlFpVlA0L3Y5SnZxOEZQQkc1SVJoSlFITHZxdStxQ0ll?=
 =?utf-8?B?VUQ4WHdzRFBTYTQ5MW1XdU94aFV6TzRqTjJmZkZLS1p2SXVhOVdjc3FRMWpi?=
 =?utf-8?B?bmdxZmFlNDhaTW5ESnJWY1Z5RjE5eGNMYVF6Z3k0S0hDQTFiQmpjdm9XQ3hu?=
 =?utf-8?B?aUNlUVJ3cEM0Ym9CeUdyY2liQWJRMXp6VDVuWXdVVk93dm5TbklWcG4xZmU4?=
 =?utf-8?B?aGEreDF3OU1PRnNKV3B4dkJEY3h0R1lhdEJJb2dSaVRwcjBSbDhXaEVaVzdh?=
 =?utf-8?B?STZxUUxNTTNCdC9mcWsvTDhCS1pwWTBFNkR2UFUvb2FLbzJOeWtJdnBXMUZz?=
 =?utf-8?B?WVNFVHU3MDg1RUZCV0FDN2pjcjdVaFNiOUs2YndyWFNGYkk3dkxxNDg3dmk4?=
 =?utf-8?B?a1VQb3d2aWtKZC9mcDcyN3o0ODgzd3dtQXBXRWdtRERhOXRkcXJGeG9hNytj?=
 =?utf-8?B?TmZqaWVKNGFXZkRmM1ZlVlF2MzBEa00wNFpzVGI4dGpyZ1BDaUdBQWI3bkQx?=
 =?utf-8?B?blMrTmxoK3hkZVlxR2hpQTZ6Q25pc3phUEZqa1IrZzRlYkR4T0JFOCs1THBi?=
 =?utf-8?B?WFQ4OGljZEdObklaYnovV1BSTDFUeEtpM0tqaDNBT01Yd3VUaldsaVpRWVA2?=
 =?utf-8?B?UkZzdjN3cC8wNWJHVUU4R0pCejdXU1lwSGJva2hHWklTNXNRU0c2VEVZdWQ3?=
 =?utf-8?B?dEVPQnlJdGtlZFRXUGtkaEgzd2NHT0Y1WitJeWZnRGFsVG9vRXhGL0w3ZGgx?=
 =?utf-8?B?ODUxemVOTTFJNEF1emMvOWNic0U3YXozTjdBTU1HOUtEYVlkREFCLzQvRDJ0?=
 =?utf-8?B?bVdEWXo2Z1BrMU0rQVlCdGtrU2YySWpld05DdVJ0Q2Vac0JKd2R6aTlDNC9K?=
 =?utf-8?B?L3dGSnNVbnJJTmV0dTlkNjc4bjkwT1BQN0xKVEE2d0UwY1pvbGlzRkdPUU0v?=
 =?utf-8?B?MkZicU84ZVhncVB0T2M1MkZrVU1sbzRUeThJL25RQ0lQM1h4MCtyWVBrdm11?=
 =?utf-8?B?SUNBWCtCdDg4UmFsU0p1TnFOWUdvTVNJd2UrcDZRYnhEMndNYUJwcG5RNEtv?=
 =?utf-8?B?cVN2cHBVbHRBTEFCeDFSR2VHeUJpQTNuaTllUTcwRDJSclgxcXlza2tsazI1?=
 =?utf-8?B?M1lFMVZaSUpqYUdLN1ZicFF5cWV5RjVDaHN2TW93SElObGp2ZVY0RkIwbHNx?=
 =?utf-8?B?VDVNRTRoejFWYWNPT2NsWFFvTXNyUVhkUmRISmcxdkZnZElCaS91WmwrNTFW?=
 =?utf-8?B?ZlQyMWFib2x3MER0T3l4cTZxalc3L1RtN2VQVG4rUTltdVJMaTdZelR5bTlv?=
 =?utf-8?B?TmNkRWt5K0o2QXkweDFzaldvcFArSlc3b05wcElERHZMWXFUMHV5Y05mK3BP?=
 =?utf-8?B?UlF5eHZoRC8rRkM3NVBwS1VsWTdPVGJHL0FVQmlPRWJZLzI5OGRrcnM2WTZs?=
 =?utf-8?B?ekhFSXlldTgxUFhva1ZqQ0tkdHdkTUx5ZlBINEtTenpOSHlQTFNMUUtGZ2ts?=
 =?utf-8?B?V1ZnMlNvNFVKbWNnOTZKSHRhc055UXplTnJlTmlOTmxINlpLajJZZE1hbUlX?=
 =?utf-8?B?TlpVQWRFcUptdHE1Q251MjVSdzR2S2tzRFFEbE9xNS9jSGdoSGFZekt0N0Fz?=
 =?utf-8?Q?x9sixGH/hm2TGdTGQLjLyO7r+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A33EB74A62DF8D42B867DD3F8903CB59@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a56ac4-c1b2-462e-f71c-08dc47e5b844
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 07:25:14.3886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlM0ubDmuukf7HfTBcScUnSeBsKAJOlAn+a9llRqa+g0Mcctf5WbOd/+lZ1i6PenrLpqEVuclpGTO4qhEEesHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8992

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjQtMDItMjkgYXQgMjI6NDggKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVGhlIGdhbW1hIExVVCBzZXR0aW5nIG9mIE1UODE4OCBhbmQgTVQ4MTk1
IGFyZSB0aGUgc2FtZSwgc28gd2UgY3JlYXRlDQo+IGEgb25lIG9mIGl0ZW1zIGZvciBNVDgxODgg
dG8gcmV1c2UgdGhlIGRyaXZlciBkYXRhIHNldHRpbmdzIG9mDQo+IE1UODE5NS4NCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdu
b0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZ2FtbWEueWFtbCAgfCA0DQo+ICsrKysNCj4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxnYW1tYS55
DQo+IGFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLGdhbW1hLnkNCj4gYW1sDQo+IGluZGV4IGVmMWY1NzU3NTdmNi4uYjhi
OGU4M2ViYzNmIDEwMDY0NA0KPiAtLS0NCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxnYW1tYS55DQo+IGFtbA0KPiArKysNCj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxnYW1tYS55DQo+IGFtbA0KPiBAQCAtMzYsNiArMzYsMTAgQEAgcHJvcGVydGllczoNCj4g
ICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItZGlzcC1nYW1tYQ0KPiAgICAgICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE5NS1kaXNwLWdhbW1hDQo+ICAgICAgICAgICAgLSBjb25zdDog
bWVkaWF0ZWssbXQ4MTgzLWRpc3AtZ2FtbWENCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAg
ICAgLSBlbnVtOg0KPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1kaXNwLWdhbW1h
DQo+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTk1LWRpc3AtZ2FtbWENCj4gIA0K
PiAgICByZWc6DQo+ICAgICAgbWF4SXRlbXM6IDENCg==

