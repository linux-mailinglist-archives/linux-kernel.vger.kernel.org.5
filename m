Return-Path: <linux-kernel+bounces-116805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4847F88A50A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29267B39489
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22818A73E;
	Mon, 25 Mar 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hqeV/SnZ";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="hqeV/SnZ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3512C551;
	Mon, 25 Mar 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361567; cv=fail; b=T9366M8kxlaCrbmcFugxwhEB/fwJ/EWHi7o0jPfjLTHLBwLe7MirD9covr6GZmWUl0yr8jgfgv88F2v5hg1tnAmgeBvpbRowCB9kfFCG8ugiA5UzvW96dBPIDGXgkaFV6BMfUOHAyDeXcmtYvy6YbGj7tTWh6hpHL6eip8AbWf0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361567; c=relaxed/simple;
	bh=s8kuF2ClGLw8ngaNm4d2YuuPzYPpVA+0+sEpsXYWFbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kj1oVeVyeq7jPvr6VTqcKGivaA493qrLmA3ZuBKRkmWEAbTvmxqXG3c0+LEe8yOsUUJzTzL+6Z18Le8Wnsr6Zk2TESuoPyXIoeY2yPz9KjRXquawK6hwyiqMD76ByUxeuclM55AcUND80iVsQ3kiVtzVvxMPrvCoTw7bKXYdJBU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=hqeV/SnZ; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=hqeV/SnZ; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=FJdM/yAKHxdYKeiubFPcRpGMWI/l6xAVlqLoF8KStb4We4gp637/PqMqsnSL8mHynUHcvAS8OsQuuPXqb8X/4l4ie91or6OWFlLSmrCnoU53G52QNZ8et1n29B1hGICrKG4hcu2VcVoOStB9EVt1xG0QsdbQALrVx3CRCCAYpYkARix06cHs+i525kItyUv1rQxDYXbyTpTRHHS4obW/SJ/sFWX4umYI1NB1zwCSPQR9UjpgO3AwCBj2PDevqIhipAYMaU+ifJTPDLGnU/kS8+v2CZuS8kJ/LP0xCgbVqYm1XlnKr6bX5fWDPxM03R/3meQ2lHQ5C5xssbw7Tfkvmw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8kuF2ClGLw8ngaNm4d2YuuPzYPpVA+0+sEpsXYWFbs=;
 b=dWAU8bNuZWq+78CAwcoEXScqPU+BvtVgIY3G3W4/fQRaMF9nBHI24lXyiTQKWIINmp/Zn91yY2DjwmA1uqQMCxysERc734lucWH9ZKH1ecNHz72dv+0/qhxLkv0i1jX+CFnS3pWYfk+quy0H7BclTLcfmkv253m32K9HWznN5ehXvK2POwpyWooNvvxjRU3e+q5FPC98BYjsKIQHOVD6ZKy5EQPdF82Y/xUfJwezpNNa4DChWZF9fEQ3/R7MZ7q6XOpokXH/0YqSPCvPYqRyeLiUrf9zU6Z4fCP1ta7EITO/iIkZkk1GqUojVpM/gotCW1A3yg91mdwAPnQTdcINfg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8kuF2ClGLw8ngaNm4d2YuuPzYPpVA+0+sEpsXYWFbs=;
 b=hqeV/SnZE1xM/jLHH53un7sePzsIa4UlmTAnVUfykj/IXAhbI8yjFRhojqufTB81sObZGG5lTmUBNPEbhr/0ClH7SkifNJWxTzNJCY3GXh4OZdvCAf0Fgp1CnpyQx1CzyQyXYI4YvEUN0uesTNkQ0UEF1yIzb5Jz0qANvAuKUos=
Received: from DB9PR05CA0003.eurprd05.prod.outlook.com (2603:10a6:10:1da::8)
 by DU0PR08MB7761.eurprd08.prod.outlook.com (2603:10a6:10:3bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:12:34 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::b2) by DB9PR05CA0003.outlook.office365.com
 (2603:10a6:10:1da::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 10:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:12:34 +0000
Received: ("Tessian outbound 9b7417e2a8eb:v300"); Mon, 25 Mar 2024 10:12:34 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 478b2eabbd03b61e
X-CR-MTA-TID: 64aa7808
Received: from f1a03c07e085.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id CC623EFB-6D06-43D7-B72E-D295330F99AA.1;
	Mon, 25 Mar 2024 10:12:23 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f1a03c07e085.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 25 Mar 2024 10:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCw0caQLlHrQrkQC55+96lEym3JSxQLuEQuhJxntdHS+Ff6zyNHx/t4o6v7OI6JmBYg9rxKBIvr0BH31frzqYvQ5HYWy722xuKJtVDcVp5+e7JtuA+bIIOXvz0MQ6bGMjW7neXSJHhktB36jX+c3P9tsF3W64XYlDsn23jbtw5gH1iyZOkSVG5DCHBItvrny21oCI0PhybIeoa5De+8WBNaBw9JaIKaIM40OKS9h+YANWYIxcsbFEod/WBgwZyHnIaH5Bz82WEFrIWhos0HdGjV56BTI1r0Ept3CFcmKbgOGWkmCyOjE3bVc2bCEZIW993ET+edQx4oc7/Uf5fsrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8kuF2ClGLw8ngaNm4d2YuuPzYPpVA+0+sEpsXYWFbs=;
 b=JwJntveCMkz+PEEGEYmn0ndeXHuIwTwOEv9oHX83vPspqTNJs2RyiJ+4SKf/2bQFFxNyIZclDSGZnl8CZo80OYBjMDvvkz+VjS3sDSxHKtUEf66Y/zGyiVCoERIH9UtBWj6aKbzIDbbg13kCqFPlHxFsyo6RNPvB/6AdmfzrMrpb/HP4KiJwp09mh07wJcRlzpEwgu568CcpbWGdMLbmJ4w3W+1NYotNWxbfLNlwYBCe2B0YFcyZq3NFPCWTGBLZJYgnl5u55ggLCpWXZDqgKLyYlT9WwiXLHW73nLc17AFbwtQ252PhJgefJ/cdrT/hibD4hE4ixhy7/caaQLl0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8kuF2ClGLw8ngaNm4d2YuuPzYPpVA+0+sEpsXYWFbs=;
 b=hqeV/SnZE1xM/jLHH53un7sePzsIa4UlmTAnVUfykj/IXAhbI8yjFRhojqufTB81sObZGG5lTmUBNPEbhr/0ClH7SkifNJWxTzNJCY3GXh4OZdvCAf0Fgp1CnpyQx1CzyQyXYI4YvEUN0uesTNkQ0UEF1yIzb5Jz0qANvAuKUos=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by PA4PR08MB7434.eurprd08.prod.outlook.com (2603:10a6:102:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:12:20 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 10:12:20 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "namhyung@kernel.org" <namhyung@kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, James Clark
	<James.Clark@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Thread-Topic: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Thread-Index: AQHafHgCEyGa3x+fLUesu0xkFXNghbFEiDwAgAO4qoA=
Date: Mon, 25 Mar 2024 10:12:20 +0000
Message-ID: <70cb93e37dc6036c7638a2630ae6dcbaa728602a.camel@arm.com>
References: <20240322164237.203358-1-ben.gainey@arm.com>
	 <CAM9d7chfXH0ynfT_PSPyjhE8ATa=fV-kbx_csgeQrWiv+1EiiQ@mail.gmail.com>
In-Reply-To:
 <CAM9d7chfXH0ynfT_PSPyjhE8ATa=fV-kbx_csgeQrWiv+1EiiQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|PA4PR08MB7434:EE_|DU6PEPF0000A7E3:EE_|DU0PR08MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: df304242-44f0-4af8-42e1-08dc4cb4170b
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 P9tjyFVx8NYaF/KXRGPVFzhMs53gztiBMzV3Sc7PqrkG4pqyG+LqLftkSotjRgN2OwhW3bF8kQ+720UwNUd/9i/5BNV3v/U62GQF8s/Bl63efeqYjjBTWGIr58dtcnQhgSbwrAFVELgpxC41NqMvpAjGhtlSs+mo3tWd9lQzs5UomSbOsA/lpe3reA7KVsMIzP/1uv5GIYl713pvBvTlSEPtBAA+LLXyoJdsz1lCPlSd1IZY1BarOpy0sVbpsUzLA3XjFohJfsl0f6AruyU87ibNe0dGQVtg8t+yBuvk5FGXsqef93g0rMMa1XyzmhUIelrGpMXt2FG7hnEu7/8OfeWdxZdqSOJLBTJJLXCIk43jo4xLNk8tkz4iKEobhfBhfHZ8VTsmNvBELcO/SHiNG5oModd0Yii7m4UNltn8ldHSITCfoWaQzZ++6S7igGRmUc7XtlOOPh8dAuF/Yp5Mf19eOrMNOind8KGeYFQIFKqctVRXMdSIAb0TOQt+PxL0SzLNi8EKxdYRsqLUt4y3PfJoBkOoVWNE3UGqEgtFAEsMV3xX6MqEZ6qa2cSiWXY0m+t4a4y7LNvE6h/ZctUe2QqaowhPbidNOokD9p6FKs6Z/paGkashB10CQOKdssKmfK1E7fK/G+A0My3qDRZPfAvdX5zPqKfIPzdA7Wj/apw1THWW7+sMoLkiO3ccQ1U3EF5nKtN5TEjB4BFQ3oVCT9pu3d1m1PHStHroMvwY2t4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <8715FDBC19630447B568445BBEA1759E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7434
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	95109811-cf21-4f23-9bf8-08dc4cb40e99
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6ALp21ob0i6uY77u057vKsoqUrXQb0WZj3iUZdYxwRDw3uJxwxDGGLCxCkJg1bnCNkCJurgxq2okRv/VFB9O8Ah1NursW/RXsWFJ7Wi2Vs0q2ijDEEXXVB5gRElyRVgip3U4KNW7ps4hlRvG8lPr5rmVb4gBvwpaDY8k2LXAnwY1fy8fnRgikqe0rzZ4bIkU6nuUri1q2KFgRKsB0vicZXjIw790M8MNYtqzEajZwc6frFgwCYNZFuK8J58QS86hcSj8xYl50c9liGmZvQq2onas45SSUGqtijjtEx97f99fPRcpRs+JQ4VFjA31kWahkyg4ijgQ/PQBye/eu8wWUob6aqKObVAkHFdYTJNsMrnQtOlnJrYk87ks3eyJydrgw/zIqU7KxsdQ3b5RXLBuVRnBGRbMwTdVDxn/MfN24Rl7yhgNXwbgjx3E4r1e2ZwszQEWu50csMqH2MiPQhvi3KWiR5VstlRKY4ny2NwrFAL3uEYiVLJVjtluq0Hm722I7DpyjrPiuYnQA0Vvsx2EEU9Bu1hpAczU5Gd3I/nckSQejzqB4R6zxyVsDRlTZed7GE5nrXShJQxcifbgrGQ2yOjMVgsqU7i/8XjzGkXcwAiZxTpVE2G/E3YB9fCq5lgEIsXyqV5iIlWjimCgue+ipOxATEFMVrxbHmHzi0oy+etqDw3UMwOUHReC9UagxvWosyekY0Nf6NYOnBhrx71AM1Wzq4dsNFIRjCLm2E0uuQrlIGM0j7ChwW/jNano+Z0M
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:12:34.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df304242-44f0-4af8-42e1-08dc4cb4170b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7761

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDE4OjIyIC0wNzAwLCBOYW1oeXVuZyBLaW0gd3JvdGU6DQo+
IE9uIEZyaSwgTWFyIDIyLCAyMDI0IGF0IDk6NDLigK9BTSBCZW4gR2FpbmV5IDxiZW4uZ2FpbmV5
QGFybS5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gVGhpcyBjaGFuZ2UgYWxsb3dzIGV2ZW50cyB0
byB1c2UgUEVSRl9TQU1QTEUgUkVBRCB3aXRoIGluaGVyaXQgc28NCj4gPiBsb25nDQo+ID4gYXMg
Ym90aCBpbmhlcml0X3N0YXQgYW5kIFBFUkZfU0FNUExFX1RJRCBhcmUgc2V0Lg0KPiA+DQo+ID4g
Q3VycmVudGx5IGl0IGlzIG5vdCBwb3NzaWJsZSB0byB1c2UgUEVSRl9TQU1QTEVfUkVBRCB3aXRo
IGluaGVyaXQuDQo+ID4gVGhpcw0KPiA+IHJlc3RyaWN0aW9uIGFzc3VtZXMgdGhlIHVzZXIgaXMg
aW50ZXJlc3RlZCBpbiBjb2xsZWN0aW5nIGFnZ3JlZ2F0ZQ0KPiA+IHN0YXRpc3RpY3MgYXMgcGVy
IGBwZXJmIHN0YXRgLiBJdCBwcmV2ZW50cyBhIHVzZXIgZnJvbSBjb2xsZWN0aW5nDQo+ID4gcGVy
LXRocmVhZCBzYW1wbGVzIHVzaW5nIGNvdW50ZXIgZ3JvdXBzIGZyb20gYSBtdWx0aS10aHJlYWRl
ZCBvcg0KPiA+IG11bHRpLXByb2Nlc3MgYXBwbGljYXRpb24sIGFzIHdpdGggYHBlcmYgcmVjb3Jk
IC1lICd7Li4uLn06UydgLg0KPiA+IEluc3RlYWQNCj4gPiB1c2VycyBtdXN0IHVzZSBzeXN0ZW0t
d2lkZSBtb2RlLCBvciBmb3JnbyB0aGUgYWJpbGl0eSB0byBzYW1wbGUNCj4gPiBjb3VudGVyDQo+
ID4gZ3JvdXBzLiBTeXN0ZW0td2lkZSBtb2RlIGlzIG9mdGVuIHByb2JsZW1hdGljIGFzIGl0IHJl
cXVpcmVzDQo+ID4gc3BlY2lmaWMNCj4gPiBwZXJtaXNzaW9ucyAobm8gQ0FQX1BFUkZNT04gLyBy
b290IGFjY2VzcyksIG9yIG1heSBsZWFkIHRvIGNhcHR1cmUNCj4gPiBvZg0KPiA+IHNpZ25pZmlj
YW50IGFtb3VudHMgb2YgZXh0cmEgZGF0YSBmcm9tIG90aGVyIHByb2Nlc3NlcyBydW5uaW5nIG9u
DQo+ID4gdGhlDQo+ID4gc3lzdGVtLg0KPiA+DQo+ID4gUGVyZiBhbHJlYWR5IHN1cHBvcnRzIHRo
ZSBhYmlsaXR5IHRvIGNvbGxlY3QgcGVyLXRocmVhZCBjb3VudHMgd2l0aA0KPiA+IGBpbmhlcml0
YCB2aWEgdGhlIGBpbmhlcml0X3N0YXRgIGZsYWcuIFRoaXMgcGF0Y2ggY2hhbmdlcw0KPg0KPiBJ
J20gbm90IHN1cmUgYWJvdXQgdGhpcyBwYXJ0LiAgSUlVQyBpbmhlcml0IGFuZCBpbmhlcml0X3N0
YXQgaXMgbm90DQo+IGZvcg0KPiBwZXItdGhyZWFkIGNvdW50cywgaXQgb25seSBzdXBwb3J0cyBw
ZXItcHJvY2VzcyAoaW5jbHVkaW5nIGNoaWxkcmVuKQ0KPiBldmVudHMuDQoNCkhpIE5hbWh5dW5n
DQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLi4uDQoNCkkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBj
b3JyZWN0LCBpZiB5b3UgY29tcGFyZSB0aGUgYmVoYXZpb3VyIG9mDQoNCiAgICBwZXJmIHJlY29y
ZCAtLW5vLWluaGVyaXQgLi4uIDxzb21lLWZvcmtpbmctcHJvY2Vzc2VzPg0KICAgIHBlcmYgc2Ny
aXB0IC1GIHBpZCx0aWQgfCBzb3J0IC11DQphbmQNCiAgICBwZXJmIHJlY29yZCAtLW5vLWluaGVy
aXQgLi4uIDxzb21lLW11bHRpdGhyZWFkZWQtcHJvY2Vzc2VzPg0KICAgIHBlcmYgc2NyaXB0IC1G
IHBpZCx0aWQgfCBzb3J0IC11DQoNCnZzDQoNCiAgICBwZXJmIHJlY29yZCAuLi4gPHNvbWUtZm9y
a2luZy1wcm9jZXNzZXM+DQogICAgcGVyZiBzY3JpcHQgLUYgcGlkLHRpZCB8IHNvcnQgLXUNCmFu
ZA0KICAgIHBlcmYgcmVjb3JkIC4uIDxzb21lLW11bHRpdGhyZWFkZWQtcHJvY2Vzc2VzPg0KICAg
IHBlcmYgc2NyaXB0IC1GIHBpZCx0aWQgfCBzb3J0IC11DQoNClRoZSBiZWhhdmlvdXIgaXMgY29u
c2lzdGVudCB3aXRoIHRoZSBmYWN0IHRoYXQgbm8taW5oZXJpdCBvbmx5IHJlY29yZHMNCnRoZSBw
cmltYXJ5IHRocmVhZCBvZiB0aGUgcHJpbWFyeSBwcm9jZXNzLCB3aGVyZWFzIGluIHRoZSBpbmhl
cml0IGNhc2UNCmFueSBjaGlsZCB0YXNrcyAoZWl0aGVyIHRocmVhZHMgb3IgZm9ya2VkIHByb2Nl
c3NlcykgaXMgcmVjb3JkZWQuDQoNCg0KPg0KPg0KPiA+IGBwZXJmX2V2ZW50X2FsbG9jYCByZWxh
eGluZyB0aGUgcmVzdHJpY3Rpb24gdG8gY29tYmluZSBgaW5oZXJpdGANCj4gPiB3aXRoDQo+ID4g
YFBFUkZfU0FNUExFX1JFQURgIHNvIHRoYXQgdGhlIGNvbWJpbmF0aW9uIHdpbGwgYmUgYWxsb3dl
ZCBzbyBsb25nDQo+ID4gYXMNCj4gPiBgaW5oZXJpdF9zdGF0YCBhbmQgYFBFUkZfU0FNUExFX1RJ
RGAgYXJlIGVuYWJsZWQuDQo+DQo+IEFueXdheSwgZG9lcyBpdCByZWFsbHkgbmVlZCAnaW5oZXJp
dF9zdGF0Jz8gIEkgdGhpbmsgaXQncyBvbmx5IGZvcg0KPiBjb3VudGluZyB1c2UgY2FzZXMgKGUu
Zy4gJ3BlcmYgc3RhdCcpIG5vdCBmb3Igc2FtcGxpbmcuDQoNCg0KSSB3b3VsZCBiZSB2ZXJ5IGhh
cHB5IHRvIHJlbW92ZSB0aGUgaW5oZXJpdF9zdGF0IHJlcXVpcmVtZW50LiBXaGVuIEkNCmZpcnN0
IGNhbWUgdG8gdGhpcyBpdCBzZWVtZWQgbGlrZSB0aGUgbG9naWMgd2FzIGFsbCB0aGVyZSBpbg0K
aW5oZXJpdF9zdGF0IGFscmVhZHksIGJ1dCBub3cgdGhhdCBJIGhhdmUgdG8gdGFrZSBhIGRpZmZl
cmVudCBwYXRoIGluDQpgcGVyZl9ldmVudF9jb250ZXh0X3NjaGVkX291dGAgSSBzdXNwZWN0IGl0
IHNob3VsZCBiZSB0cml2aWFsIHRvIHJlbW92ZQ0KdGhlIGluaGVyaXRfc3RhdCByZXF1aXJlbWVu
dC4NCg0KDQo+DQo+IEFsc28gdGVjaG5pY2FsbHksIGl0IGNhbiBoYXZlIFBFUkZfU0FNUExFX1NU
UkVBTV9JRCBpbnN0ZWFkDQo+IG9mIFBFUkZfU0FNUExFX1RJRCB0byBkaXN0aW5ndWlzaCB0aGUg
Y291bnRlciB2YWx1ZXMuDQoNCg0KSXQgbG9va3MgbGlrZSB5b3UgYXJlIGNvcnJlY3QsIGJ1dCB0
aGUgSUQgZ2l2ZW4gaW4gdGhlIHJlYWRfZm9ybWF0IHBhcnQNCm9mIFBFUkZfU0FNUExFX1JFQ09S
RCBpcyB0aGUgSUQgcmF0aGVyIHRoYW4gU1RSRUFNX0lELiAoSSBoYWQNCmluY29ycmVjdGx5IHRo
b3VnaHQvc3RhdGVkIGl0IHdhcyB0aGUgbGF0dGVyKS4gSGVuY2Ugd2hlbiBwcm9jZXNzaW5nDQp0
aGUgcmVhZF9mb3JtYXQgdmFsdWVzIGluIHRoZSBzYW1wbGUgcmVjb3JkLCB3ZSBlaXRoZXIgbmVl
ZCB0byB1c2UgdGhlDQpUSUQgdG8gdW5pcXVlbHkgaWRlbnRpZnkgdGhlIHNvdXJjZSwgb3Igd2Ug
d291bGQgbmVlZCB0byBtb2RpZnkgdGhlDQpyZWFkX2Zvcm1hdCB0byAoYWRkaXRpb25hbGx5KSBp
bmNsdWRlIHRoZSBTVFJFQU1fSUQuDQoNCiAqIFRoZSBjdXJyZW50IGFwcHJvYWNoIGluIHRvb2xz
IHVzZXMgdGhlIElEK1RJRCwgd2hpY2ggcHV0cyBtb3JlDQpjb21wbGV4aXR5IGluIHRoZSB0b29s
cyBidXQgbWVhbnMgdGhlcmUgaXNuJ3QgYW4gZXh0cmEgZmllbGQgaW4gdGhlDQpyZWFkX2Zvcm1h
dCBkYXRhIChmb3IgZWFjaCB2YWx1ZSkuDQogKiBBbHRlcm5hdGl2ZWx5IEkgY291bGQgaW50cm9k
dWNlIGEgUEVSRl9GT1JNQVRfU1RSRUFNX0lEOyBJIHdvdWxkDQpleHBlY3QgdGhhdCB0aGUgdXNl
ci90b29sIHdvdWxkIG5lZWQgdG8gc3BlY2lmeQ0KUEVSRl9GT1JNQVRfSUR8UEVSRl9GT1JNQVRf
U1RSRUFNX0lEIGFzIHRoZXkgd291bGQgbmVlZCB0byB1c2UgdGhlIElEDQp0byBsb29rdXAgdGhl
IGNvcnJlY3QgcGVyZl9ldmVudF9hdHRyLCBidXQgY291bGQgdXNlIHRoZSBTVFJFQU1fSUQgdG8N
CnVuaXF1ZWx5IGlkZW50aWZ5IHRoZSBjaGlsZCBldmVudC4gVGhpcyBhcHByb2FjaCB3b3VsZCBh
ZGQgYW4gZXh0cmEgdTY0DQpwZXIgdmFsdWUgaW4gdGhlIHJlYWRfZm9ybWF0IGRhdGEgYnV0IGlz
IHBvc3NpYmx5IHNpbXBsZXIvc2FmZXIgZm9yDQp0b29scz8NCg0KQW55IHByZWZlcmVuY2VzPw0K
DQoNCj4NCj4gPg0KPiA+IEluIHRoaXMgY29uZmlndXJhdGlvbiBzdHJlYW0gaWRzIChzdWNoIGFz
IG1heSBhcHBlYXIgaW4gdGhlDQo+ID4gcmVhZF9mb3JtYXQNCj4gPiBmaWVsZCBvZiBhIFBFUkZf
UkVDT1JEX1NBTVBMRSkgYXJlIG5vIGxvbmdlciBnbG9iYWxseSB1bmlxdWUsDQo+ID4gcmF0aGVy
DQo+ID4gdGhlIHBhaXIgb2YgKHN0cmVhbSBpZCwgdGlkKSB1bmlxdWVseSBpZGVudGlmeSBlYWNo
IGV2ZW50LiBUb29scw0KPiA+IHRoYXQNCj4gPiByZWx5IG9uIHRoaXMsIGZvciBleGFtcGxlIHRv
IGNhbGN1bGF0ZSBhIGRlbHRhIGJldHdlZW4gc2FtcGxlcywNCj4gPiB3b3VsZA0KPiA+IG5lZWQg
dXBkYXRpbmcgdG8gdGFrZSB0aGlzIGludG8gYWNjb3VudC4gUHJldmlvdXNseSB2YWxpZCBldmVu
dA0KPiA+IGNvbmZpZ3VyYXRpb25zIChzeXN0ZW0td2lkZSwgbm8taW5oZXJpdCBhbmQgc28gb24p
IHdoZXJlIGVhY2gNCj4gPiBzdHJlYW0gaWQNCj4gPiBpcyB0aGUgaWRlbnRpZmllciBhcmUgdW5h
ZmZlY3RlZC4NCj4NCj4gSSB0aGluayB5b3UgbWVhbnQgUEVSRl9TQU1QTEVfSUQgbm90IFBFUkZf
U0FNUExFX1NUUkVBTV9JRC4NCj4gSUlVQyB0aGUgc3RyZWFtIGlkIGlzIGFscmVhZHkgdW5pcXVl
Lg0KPg0KDQpZZXMgbXkgbWlzdGFrZS4NCg0KDQo+IFRoYW5rcywNCj4gTmFtaHl1bmcNCj4NCj4g
Pg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB2MzoNCj4gPiAgLSBDbGVhbmVkIHVwIHBlcmYgdGVz
dCBkYXRhIGNoYW5nZXMgaW5jb3JyZWN0bHkgaW5jbHVkZWQgaW50byB0aGlzDQo+ID4gICAgc2Vy
aWVzIGZyb20gZWxzZXdoZXJlLg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB2MjoNCj4gPiAgLSBS
ZWJhc2Ugb24gdjYuOA0KPiA+ICAtIFJlc3BvbmQgdG8gSmFtZXMgQ2xhcmtlJ3MgZmVlZGJhY2s7
IGZpeHVwIHNvbWUgdHlwb3MgYW5kIG1vdmUNCj4gPiBzb21lDQo+ID4gICAgcmVwZWF0ZWQgY2hl
Y2tzIGludG8gYSBoZWxwZXIgbWFjcm8uDQo+ID4gIC0gQ2xlYW5lZCB1cCBjaGVja3BhdGNoIGxp
bnRzLg0KPiA+ICAtIFVwZGF0ZWQgcGVyZiB0ZXN0OyBmaXhlZCBldnNlbCBoYW5kbGluZyBzbyB0
aGF0IGV4aXN0aW5nIHRlc3RzDQo+ID4gcGFzcw0KPiA+ICAgIGFuZCBhZGRlZCBuZXcgdGVzdHMg
dG8gY292ZXIgdGhlIG5ldyBiZWhhdmlvdXIuDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0K
PiA+ICAtIFJlYmFzZSBvbiB2Ni44LXJjMQ0KPiA+ICAtIEZpeGVkIHZhbHVlIHdyaXR0ZW4gaW50
byBzYW1wbGUgYWZ0ZXIgY2hpbGQgZXhpc3RzLg0KPiA+ICAtIE1vZGlmaWVkIGhhbmRsaW5nIG9m
IHN3aXRjaC1vdXQgc28gdGhhdCBjb250ZXh0IHdpdGggdGhlc2UNCj4gPiBldmVudHMNCj4gPiAg
ICB0YWtlIHRoZSBzbG93IHBhdGgsIHNvIHRoYXQgdGhlIHBlci1ldmVudC9wZXItdGhyZWFkIFBN
VSBzdGF0ZQ0KPiA+IGlzDQo+ID4gICAgY29ycmVjdGx5IHN3aXRjaGVkLg0KPiA+ICAtIE1vZGlm
aWVkIHBlcmYgdG9vbHMgdG8gc3VwcG9ydCB0aGlzIG1vZGUgb2Ygb3BlcmF0aW9uLg0KPiA+DQo+
ID4gQmVuIEdhaW5leSAoNCk6DQo+ID4gICBwZXJmOiBTdXBwb3J0IFBFUkZfU0FNUExFX1JFQUQg
d2l0aCBpbmhlcml0X3N0YXQNCj4gPiAgIHRvb2xzL3BlcmY6IFRyYWNrIHdoZXJlIHBlcmZfc2Ft
cGxlX2lkcyBuZWVkIHBlci10aHJlYWQgcGVyaW9kcw0KPiA+ICAgdG9vbHMvcGVyZjogQ29ycmVj
dGx5IGNhbGN1bGF0ZSBzYW1wbGUgcGVyaW9kIGZvciBpbmhlcml0ZWQNCj4gPiAgICAgU0FNUExF
X1JFQUQgdmFsdWVzDQo+ID4gICB0b29scy9wZXJmOiBBbGxvdyBpbmhlcml0ICsgaW5oZXJpdF9z
dGF0ICsgUEVSRl9TQU1QTEVfUkVBRCB3aGVuDQo+ID4gICAgIG9wZW5pbmcgZXZlbnRzDQo+ID4N
Cj4gPiAgaW5jbHVkZS9saW51eC9wZXJmX2V2ZW50LmggICAgICAgICAgICAgICAgICAgIHwgIDEg
Kw0KPiA+ICBrZXJuZWwvZXZlbnRzL2NvcmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA2
MiArKysrKysrKysrLS0tLQ0KPiA+ICB0b29scy9saWIvcGVyZi9ldmxpc3QuYyAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMSArDQo+ID4gIHRvb2xzL2xpYi9wZXJmL2V2c2VsLmMgICAgICAgICAg
ICAgICAgICAgICAgICB8IDQ4ICsrKysrKysrKysrDQo+ID4gIHRvb2xzL2xpYi9wZXJmL2luY2x1
ZGUvaW50ZXJuYWwvZXZzZWwuaCAgICAgICB8IDU1ICsrKysrKysrKysrKy0NCj4gPiAgLi4uL3Rl
c3QtcmVjb3JkLWdyb3VwLXNhbXBsaW5nLWluaGVyaXQtc3RhdCAgIHwgNjIgKysrKysrKysrKysr
KysNCj4gPiAgdG9vbHMvcGVyZi91dGlsL2V2c2VsLmMgICAgICAgICAgICAgICAgICAgICAgIHwg
ODINCj4gPiArKysrKysrKysrKysrKysrKystDQo+ID4gIHRvb2xzL3BlcmYvdXRpbC9ldnNlbC5o
ICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgdG9vbHMvcGVyZi91dGlsL3Nlc3Np
b24uYyAgICAgICAgICAgICAgICAgICAgIHwgMTEgKystDQo+ID4gIDkgZmlsZXMgY2hhbmdlZCwg
MzAxIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgdG9vbHMvcGVyZi90ZXN0cy9hdHRyL3Rlc3QtcmVjb3JkLWdyb3VwLQ0KPiA+IHNhbXBsaW5n
LWluaGVyaXQtc3RhdA0KPiA+DQo+ID4gLS0NCj4gPiAyLjQ0LjANCj4gPg0KDQpJTVBPUlRBTlQg
Tk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFy
ZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlh
dGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29u
LCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlv
biBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

