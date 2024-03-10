Return-Path: <linux-kernel+bounces-98225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E2F8776EC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3F7281168
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9AF2943F;
	Sun, 10 Mar 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RQxMcLwU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="RQxMcLwU"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C979B24B34;
	Sun, 10 Mar 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.55
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076007; cv=fail; b=MtJ13xVIUqZ94NPiu1CArXJYntgCo/3mB+CvWtBgyv5Elw7tTLPLrjjKs5XfS0RkPg2gw+KjuQijAyI6fmRK5afwcOHNftnErcjnBbxkl17ChWGfNBSpfrGHhZslQi0syHDw1FYPrZoBx9Vclrufcmnt7/Xdy6nvZz0+cGmwGi4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076007; c=relaxed/simple;
	bh=2cu+qzXVIqrn/EfO/cXf2LqTe+AV93MCT6JxIaLOI48=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3OzpLM3rRLxJAqHmK0DH5rbpE6QyE2/o6MpbFiTaqL3IyuSSOcVvJiBH4pQYvTQh2+t3IjjJzni+hSeOGvlr/mPSeFwWFxslRrR7mtFtMULcow2qaVKtzkqqDLvNS66kb+FM+ZXnArdAgvcHLktDRvuLb6NX6abCH1k2u0g2Ek=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RQxMcLwU; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=RQxMcLwU; arc=fail smtp.client-ip=40.107.22.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=ChknI1qWrcp7hDQamP4Ipq4SUZTAxZkiDUhQhEhyK7vrCkLsVA/z/R8x5mo8GrR0ovDDSbjj8bIFcIu32WShXrx8OjNlmhU57zUwExg0eXfMkXiGC5X3eu0Wj+NalGCMdswcT/PGUMuWX6hVPMjVWY7eHGApWH6/cDm1PEbMLEULGb65LujXY6Y1kxB1gL2yYiymFVdwHkza0LJvstdbA5AFidlp33fGYDRuSyVO0CuAAJALA6i0SAYp3jGkoKSLoxdj2d+TRYGe+eXWs+3TJrZKWLx3/csGAWVFVLpoRVafZGP2hZe0HZrtuWQRUkiASgp8EpUYzlHnmjFK30QCyg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cu+qzXVIqrn/EfO/cXf2LqTe+AV93MCT6JxIaLOI48=;
 b=kKs7SB84vQjPbpxPlkVny31GWFcxgB2wvHkwPmzvTw13+Y39TtPY6yMpcNc2B1883MrsTuQdu1YF/Muv6fIxBg/d+V0auL5dmjn43ZZiG98AimxOzqA7QL/nVSi/lITSCe3HvIPthaALjFHsrKV95c5ZpwNLUfP13PIHyJLl5U/iWd/CyOI2e580GOX2qWHYVvIHWZlgkA6TwDQ6CstsLTsV8EAw4Tq6NhpUPHaSzZw3Nw5MZVsWTcCdDzboAc45sAO1eUTa6DIzMAE7yfNpuNYeUnwVV0cVRHqMGDwsq4VnVNXk+7KmV3oyI5cZhDFElKomjJaKK8ggkoJTx7yMNg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cu+qzXVIqrn/EfO/cXf2LqTe+AV93MCT6JxIaLOI48=;
 b=RQxMcLwUQC0s7rn6rbL/AlJg8oUmUY5fKxAWdphTunTEQMbShPvfqC4hZb6AhtZ89yNTg40X/NsykINyhQrMUDAPZfNlXrLyvEGAexQq9r6S6BYOSBpwf7fnMVsVyjvU4vebBF23iS5NPKWG6l2qcZvCMcIw5Vg4McKsDgdnzpo=
Received: from AS8PR04CA0004.eurprd04.prod.outlook.com (2603:10a6:20b:310::9)
 by AS4PR08MB7507.eurprd08.prod.outlook.com (2603:10a6:20b:4fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 13:06:34 +0000
Received: from AM4PEPF00027A6A.eurprd04.prod.outlook.com
 (2603:10a6:20b:310:cafe::8c) by AS8PR04CA0004.outlook.office365.com
 (2603:10a6:20b:310::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34 via Frontend
 Transport; Sun, 10 Mar 2024 13:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM4PEPF00027A6A.mail.protection.outlook.com (10.167.16.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 13:06:34 +0000
Received: ("Tessian outbound 456a16a4297b:v276"); Sun, 10 Mar 2024 13:06:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3186fea5ed1517db
X-CR-MTA-TID: 64aa7808
Received: from dc40a18b7262.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id EBA8DA22-E1EF-4DBE-93CE-5B000A9416A6.1;
	Sun, 10 Mar 2024 13:06:27 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id dc40a18b7262.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 10 Mar 2024 13:06:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcyMmbRcmHldPfsjwFwVFobXOHve0LnTuTolmeKIFp6+YVThPA2OQNyLvmpcWGHl+RipwKbZ36+9wl4OS8zJjRIblFpP3/E5CMkWRNmumaOxyb5X4VDzfOvB/l455TidPd6hGUWuImjO6GCLQUrSeE79z1Z3hf2jbrihhQ0D8Gaa/F9blYQ4tfWAoPG1pHvs6B3mgZ7wROpEz4p/DhWXYRQsmwKnT6u+Eqzb6lMF8BXFwWBtXbkpJyTHMoAZwy8F2L+RXkmcEARpRrmr8fJugVbnYoo7UjXTeAIges0UsruRLNFxZgED+yNIfl9nBNnP2pHEjjLo6R5QuUjzDHZ3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cu+qzXVIqrn/EfO/cXf2LqTe+AV93MCT6JxIaLOI48=;
 b=AJwaBPkp4AY3aeMQCg9fT8fWdUFUrLNQl6vGs2ycSP+ZM2KBU8OQmUgV3x2o7SLUJQpAKvGJdDsfgPEQyxBoaXJ0EyPOmtqbYyHvgOo3NWNjFXZMemh32Md4tIslLfS/8JcX7HjmOYoJ29lbHwD92vaZ4uWTusQhY4m8+w0hCPMcJQBAlvwZJtOr4z99VCSxhfOoXipAdkJueB8/kME9DxTEGBOViQi+FOjyIX5g/fg21M1a7NBUFfkm1ABYnGltWFVLrjvVlAIwBZdsO9vAUM4fCA+Ac7N81WNlI2f4V85Dpk1icS8GwmSlt0wkV0+zTYRo4IdxW1amTWHRppJaAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cu+qzXVIqrn/EfO/cXf2LqTe+AV93MCT6JxIaLOI48=;
 b=RQxMcLwUQC0s7rn6rbL/AlJg8oUmUY5fKxAWdphTunTEQMbShPvfqC4hZb6AhtZ89yNTg40X/NsykINyhQrMUDAPZfNlXrLyvEGAexQq9r6S6BYOSBpwf7fnMVsVyjvU4vebBF23iS5NPKWG6l2qcZvCMcIw5Vg4McKsDgdnzpo=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by DU5PR08MB10611.eurprd08.prod.outlook.com (2603:10a6:10:519::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Sun, 10 Mar
 2024 13:06:25 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 13:06:25 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
CC: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org"
	<acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Mark Rutland
	<Mark.Rutland@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"irogers@google.com" <irogers@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>, James Clark
	<James.Clark@arm.com>
Subject: Re: [PATCH v2 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Thread-Topic: [PATCH v2 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Thread-Index: AQHaWpBWrJhAzLuZ6E6a1txXQZQfLrExIl+A
Date: Sun, 10 Mar 2024 13:06:25 +0000
Message-ID: <61a6b2efd849bd9ad5fa9a3ccba1f4591c53795b.camel@arm.com>
References: <20240208131050.2406183-1-ben.gainey@arm.com>
In-Reply-To: <20240208131050.2406183-1-ben.gainey@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|DU5PR08MB10611:EE_|AM4PEPF00027A6A:EE_|AS4PR08MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e29e712-cf67-4659-dabe-08dc4102e967
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 06/nq/StleigZAR7G/Q36YidqWYPw/4z2wymliTfmN+NDlsYMXzlDmxjFUHe0tdA/jP0tg7aWKUTj/QDgM3Z4mSuQEbn/kOa5khH9vBoeVZxVfRAGI6LcsIHMVvYamWSI7x22+MZNwbFuzAa30Mys3c/hOmzI0PvdJ06X7nBIDcEpu5H8k6O9Q4fB6Cnq+K3uFfJvh97rUEZeKt2WWOAiJVJebHJq/MaI3FnZqvp4+iEBvpUgT7BZHbkLDs5w57ewE4JB7l6ecF3Bw+eAYyo0TmNI19bWIJ5fWvSsO3um6RxfW1aSIfG6aUvGugstpMkoM4mOGa4hrU0YNh1ISEzLLatEsVeXfrUm4Ach55fKu8q0+H/yDr1A8QFEaDc9mXnDwuR8Hqpk2LfEoyZWsirCPgj0Ct0nZML1WRndy78r9c18LxYWQTPfmt3I2vbbWMgUdexC6PCuLsSYdQh1u67e6ixYB/wHI6GVipNukIzkIBwbVxJBP4mjlu9DQUOmCn1jYjx0R8NQcAp+ayh8W77q1xTyaBDz8XM03FEPde2CCRrnOw/nwPooDfuDVmP/MeoEnV6sT80uj3YrVzPpDiZIi6wEmjmLiNFfegSrBL33LztMoNRQ5CbFg+b8XXuYDn7MncvfCTJkY7Dl1A8NbzpJ9foBDvXolcsgevfKKBuDEMGZaLYghZVwKSEDvvAzitZvtJraQM3nOlrAT9hyFoKCAc07c3gBg6UiCL1VzrRhDw=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E915A23D128AD4BAE8533E1D1EF1083@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR08MB10611
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	150b7e44-ae92-40ae-4f92-08dc4102e476
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QmIrdR3qtX+5uZBjI8sWuOF5g3IwNhQz49T3/V8PqKvONJvvUWan2cLkNtWLbwDbCYbtHfDYZUsqqL9spTsk2Ow01oRTnsF1Kzac5mwVOtxh2iW8vORErPZP33dxxkvyylJhCPASw6+kFrapheAGhRIg7YBVWfGIvNDZvLQu2NdIOwgbcLcFVKkMOM8mJP/f0FktclTxGPHqYbs5Z5uDhctHsy/DHIyqb0ZdOTs5eyWUfqn9OyP144G9oa2CIQfcytw3cclykBMkdoVV33UOQaKXFb5MTnzc1rebnjMI3nxW3sYWS3aCqzpbcavQUt7C0+u8DErqWxs1BA+MwZCb8hLcw8bsv3yPficfUMe77u4TEKuwnUnRuFja4i6viH+sTed9S3nGORWOaaaH6ecreG4HCazoxyfdZwOAFvIeBC4w/cGtjaJjwPMO4zarZzN61jLDgepmCeUAVLEmKLUcgNmyLSLSHayebz5uJ6fKp8CQ75KPNfUVO9YUu+JDp7g8u3yf1ZpxrtCGiYXAvAnEpXBd/j2hYjUffGD2XDHdYN+ix8sZtnLub0RKfCZvM0kfr3UhvD0IZYQ8AGr92FogDyZdb3ROMzYeCZSvfNs/1ahhde9kFoWOH4u5ooCl1omPrNK/qK92jRdiPAzFWtVlRuwyBKJoXM9u5DaixsW/Q0xCSEz/+VJrupWwfWbdyzisckctQ/jkyJ4RTQbC8SaT18VQx5naIgm/eRSgg90VpjgrK8czdYuLg4cR6GDLvUJx
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 13:06:34.0624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e29e712-cf67-4659-dabe-08dc4102e967
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6A.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7507

T24gVGh1LCAyMDI0LTAyLTA4IGF0IDEzOjEwICswMDAwLCBCZW4gR2FpbmV5IHdyb3RlOg0KPiBU
aGlzIGNoYW5nZSBhbGxvd3MgZXZlbnRzIHRvIHVzZSBQRVJGX1NBTVBMRSBSRUFEIHdpdGggaW5o
ZXJpdCBzbw0KPiBsb25nDQo+IGFzIGJvdGggaW5oZXJpdF9zdGF0IGFuZCBQRVJGX1NBTVBMRV9U
SUQgYXJlIHNldC4NCj4NCj4gQ3VycmVudGx5IGl0IGlzIG5vdCBwb3NzaWJsZSB0byB1c2UgUEVS
Rl9TQU1QTEVfUkVBRCB3aXRoIGluaGVyaXQuDQo+IFRoaXMNCj4gcmVzdHJpY3Rpb24gYXNzdW1l
cyB0aGUgdXNlciBpcyBpbnRlcmVzdGVkIGluIGNvbGxlY3RpbmcgYWdncmVnYXRlDQo+IHN0YXRp
c3RpY3MgYXMgcGVyIGBwZXJmIHN0YXRgLiBJdCBwcmV2ZW50cyBhIHVzZXIgZnJvbSBjb2xsZWN0
aW5nDQo+IHBlci10aHJlYWQgc2FtcGxlcyB1c2luZyBjb3VudGVyIGdyb3VwcyBmcm9tIGEgbXVs
dGktdGhyZWFkZWQgb3INCj4gbXVsdGktcHJvY2VzcyBhcHBsaWNhdGlvbiwgYXMgd2l0aCBgcGVy
ZiByZWNvcmQgLWUgJ3suLi4ufTpTJ2AuDQo+IEluc3RlYWQNCj4gdXNlcnMgbXVzdCB1c2Ugc3lz
dGVtLXdpZGUgbW9kZSwgb3IgZm9yZ28gdGhlIGFiaWxpdHkgdG8gc2FtcGxlDQo+IGNvdW50ZXIN
Cj4gZ3JvdXBzLiBTeXN0ZW0td2lkZSBtb2RlIGlzIG9mdGVuIHByb2JsZW1hdGljIGFzIGl0IHJl
cXVpcmVzIHNwZWNpZmljDQo+IHBlcm1pc3Npb25zIChubyBDQVBfUEVSRk1PTiAvIHJvb3QgYWNj
ZXNzKSwgb3IgbWF5IGxlYWQgdG8gY2FwdHVyZSBvZg0KPiBzaWduaWZpY2FudCBhbW91bnRzIG9m
IGV4dHJhIGRhdGEgZnJvbSBvdGhlciBwcm9jZXNzZXMgcnVubmluZyBvbiB0aGUNCj4gc3lzdGVt
Lg0KPg0KPiBQZXJmIGFscmVhZHkgc3VwcG9ydHMgdGhlIGFiaWxpdHkgdG8gY29sbGVjdCBwZXIt
dGhyZWFkIGNvdW50cyB3aXRoDQo+IGBpbmhlcml0YCB2aWEgdGhlIGBpbmhlcml0X3N0YXRgIGZs
YWcuIFRoaXMgcGF0Y2ggY2hhbmdlcw0KPiBgcGVyZl9ldmVudF9hbGxvY2AgcmVsYXhpbmcgdGhl
IHJlc3RyaWN0aW9uIHRvIGNvbWJpbmUgYGluaGVyaXRgIHdpdGgNCj4gYFBFUkZfU0FNUExFX1JF
QURgIHNvIHRoYXQgdGhlIGNvbWJpbmF0aW9uIHdpbGwgYmUgYWxsb3dlZCBzbyBsb25nIGFzDQo+
IGBpbmhlcml0X3N0YXRgIGFuZCBgUEVSRl9TQU1QTEVfVElEYCBhcmUgZW5hYmxlZC4NCj4NCj4g
SW4gdGhpcyBjb25maWd1cmF0aW9uIHN0cmVhbSBpZHMgKHN1Y2ggYXMgbWF5IGFwcGVhciBpbiB0
aGUNCj4gcmVhZF9mb3JtYXQNCj4gZmllbGQgb2YgYSBQRVJGX1JFQ09SRF9TQU1QTEUpIGFyZSBu
byBsb25nZXIgZ2xvYmFsbHkgdW5pcXVlLCByYXRoZXINCj4gdGhlIHBhaXIgb2YgKHN0cmVhbSBp
ZCwgdGlkKSB1bmlxdWVseSBpZGVudGlmeSBlYWNoIGV2ZW50LiBUb29scyB0aGF0DQo+IHJlbHkg
b24gdGhpcywgZm9yIGV4YW1wbGUgdG8gY2FsY3VsYXRlIGEgZGVsdGEgYmV0d2VlbiBzYW1wbGVz
LCB3b3VsZA0KPiBuZWVkIHVwZGF0aW5nIHRvIHRha2UgdGhpcyBpbnRvIGFjY291bnQuIFByZXZp
b3VzbHkgdmFsaWQgZXZlbnQNCj4gY29uZmlndXJhdGlvbnMgKHN5c3RlbS13aWRlLCBuby1pbmhl
cml0IGFuZCBzbyBvbikgd2hlcmUgZWFjaCBzdHJlYW0NCj4gaWQNCj4gaXMgdGhlIGlkZW50aWZp
ZXIgYXJlIHVuYWZmZWN0ZWQuDQo+DQo+DQo+IENoYW5nZXMgc2luY2UgdjE6DQo+ICAtIFJlYmFz
ZSBvbiB2Ni44LXJjMQ0KPiAgLSBGaXhlZCB2YWx1ZSB3cml0dGVuIGludG8gc2FtcGxlIGFmdGVy
IGNoaWxkIGV4aXN0cy4NCj4gIC0gTW9kaWZpZWQgaGFuZGxpbmcgb2Ygc3dpdGNoLW91dCBzbyB0
aGF0IGNvbnRleHQgd2l0aCB0aGVzZSBldmVudHMNCj4gdGFrZSB0aGUNCj4gICAgc2xvdyBwYXRo
LCBzbyB0aGF0IHRoZSBwZXItZXZlbnQvcGVyLXRocmVhZCBQTVUgc3RhdGUgaXMgY29ycmVjdGx5
DQo+IHN3aXRjaGVkLg0KPiAgLSBNb2RpZmllZCBwZXJmIHRvb2xzIHRvIHN1cHBvcnQgdGhpcyBt
b2RlIG9mIG9wZXJhdGlvbi4NCj4NCj4NCj4gQmVuIEdhaW5leSAoNCk6DQo+ICAgcGVyZjogU3Vw
cG9ydCBQRVJGX1NBTVBMRV9SRUFEIHdpdGggaW5oZXJpdF9zdGF0DQo+ICAgdG9vbHMvcGVyZjog
VHJhY2sgd2hlcmUgcGVyZl9zYW1wbGVfaWRzIG5lZWQgcGVyLXRocmVhZCBwZXJpb2RzDQo+ICAg
dG9vbHMvcGVyZjogQ29ycmVjdGx5IGNhbGN1bGF0ZSBzYW1wbGUgcGVyaW9kIGZvciBpbmhlcml0
ZWQNCj4gICAgIFNBTVBMRV9SRUFEIHZhbHVlcw0KPiAgIHRvb2xzL3BlcmY6IEFsbG93IGluaGVy
aXQgKyBpbmhlcml0X3N0YXQgKyBQRVJGX1NBTVBMRV9SRUFEIHdoZW4NCj4gICAgIG9wZW5pbmcg
ZXZlbnRzDQo+DQo+ICBpbmNsdWRlL2xpbnV4L3BlcmZfZXZlbnQuaCAgICAgICAgICAgICAgfCAg
MSArDQo+ICBrZXJuZWwvZXZlbnRzL2NvcmUuYyAgICAgICAgICAgICAgICAgICAgfCA1MyArKysr
KysrKysrKysrKysrKy0tLS0tLQ0KPiAtLQ0KPiAgdG9vbHMvbGliL3BlcmYvZXZsaXN0LmMgICAg
ICAgICAgICAgICAgIHwgIDEgKw0KPiAgdG9vbHMvbGliL3BlcmYvZXZzZWwuYyAgICAgICAgICAg
ICAgICAgIHwgNDggKysrKysrKysrKysrKysrKysrKysrKw0KPiAgdG9vbHMvbGliL3BlcmYvaW5j
bHVkZS9pbnRlcm5hbC9ldnNlbC5oIHwgNDggKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgdG9v
bHMvcGVyZi91dGlsL2V2c2VsLmMgICAgICAgICAgICAgICAgIHwgMTUgKysrKysrLQ0KPiAgdG9v
bHMvcGVyZi91dGlsL2V2c2VsLmggICAgICAgICAgICAgICAgIHwgIDEgKw0KPiAgdG9vbHMvcGVy
Zi91dGlsL3Nlc3Npb24uYyAgICAgICAgICAgICAgIHwgMTEgKysrLS0NCj4gIDggZmlsZXMgY2hh
bmdlZCwgMTU0IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPg0KDQoNCg0KSGVsbG8g
YWxsLCBhcHByZWNpYXRlIGV2ZXJ5b25lIGlzIGJ1c3kuIElzIHRoZXJlIGFueSBmZWVkYmFjayBv
biB0aGVzZT8NCkkgZXhwZWN0IHRoZXkgd2lsbCBuZWVkIHJlYmFzaW5nLCBidXQgYmVmb3JlIEkg
ZG8gdGhhdCwgYXJlIHlvdSBoYXBweQ0Kd2l0aCB0aGUgYXBwcm9hY2g/DQoNCkNoZWVycw0KQmVu
DQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0
dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNl
bmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkg
b3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRo
ZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=

