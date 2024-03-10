Return-Path: <linux-kernel+bounces-98223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D619E8776E7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AF71F2155A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21A2C183;
	Sun, 10 Mar 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cepRkd/1";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cepRkd/1"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06F929411;
	Sun, 10 Mar 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710075626; cv=fail; b=rSD/wXVFdbCqVQntamPO5J/Gi/gUSJfO+3Fo2MDSx9wZDzaMu745R0bNXBTMOuoDewxGgqIhyImZmTA0vITnTYbtHmEDjuangG814M1X++LllWb25J1b8q3LM56/Y/8k/o/MOsdM0L3OtkhYjrvRWpOvn7nL4X7Q4K4ut2u+m7M=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710075626; c=relaxed/simple;
	bh=t5gcNxv7G0VgIkksFT1t9/HTEvkx7biEbCp7FinfKJQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EJGW1GUpHUZXzMRyjhc2vBTH1Xf5r3nR6VWapIqKfttxVk6S8J22XdfQijBQK8L57kmQ5IEhM6oRa8URY3gbd1K2n2ckX+VXUXoqagss7lzR3oxR3G4JylTQe1EY9AGO7J0NmzgrxICNiRwbCACWm/Wp0KsviCCBWm+Knt5SGaE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=cepRkd/1; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=cepRkd/1; arc=fail smtp.client-ip=40.107.6.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=EDBFCnc/5skwpmwfdT5Kj/Ki/XR3s1bOjW3hRK7IkqWof5Vu/f2+VztusRh/fMg42obKmb+ec5231NabVaNRNqGg40/JmhKoBVIUSNo1eedNrvpPkR5BTgGK2Xbvvtv88TXUuoZVYbBfty6icCfx3i4qItE7CT+fE+/gCWVlwRATx8ZqAXJv+gHQk94tL4h9VyudkV8TUMA/esdX2LhZOL8W6bPTWyd9FuoCvKKGOx9lFzPzAU6sYP42U5dp1FQP1r9DTyLqFTV7qV4AHPyelukrxHrdr//LVyGKB5V8aJPZc4dYlRiRxwzet58+jXObNPL5GvzrLh08hthVAX0f3Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5gcNxv7G0VgIkksFT1t9/HTEvkx7biEbCp7FinfKJQ=;
 b=M+rSC6jdbOfAoMTUkRJKW/3bErnl31siN5TjTgyrW93n+dM2AjTgO4ASb15QLzqY5GabuEO8i2Wdxvdi8HSg2x7hCo1PrYLK4Ibn+idu2CcomAjt2iXxU84PApyrFhRAiHM9KPt+4Rwsz9ZCJstHdJxZLq8ExZnCt01dpMtNkiHL8CfHxBw2p+z7gjSny0oSRh6WITEhfBdH7ll8GGKqoJiiz4KiyuH6RFKyBtVO1ixWIvTy7Ikg0vhNg1o1CtgcIDQdzW9Li2iVSNDET1ofk8PFTCWgv3ZhFf6itj4TeqDLqEK5WIpjrmBAVSWZ6Q74hB7iIoyMu6quQq6SuJgvuA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5gcNxv7G0VgIkksFT1t9/HTEvkx7biEbCp7FinfKJQ=;
 b=cepRkd/10OaOpkwcAyLkjtGnxYBFxF7HtK4ULpooX5+K9tzeo3mTsLGzDBtgTjHN5i0BYBeFJPl8noncrMwmi/ykj8LDZsHGAjxuqeTiFKsZ3CdFHBRZr6pTb3MffZeOgvs1jD7A3PcZvTCjih96MZ8gfVHc4DoDv2dwcDHI5U4=
Received: from AM6P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::18)
 by AM0PR08MB5522.eurprd08.prod.outlook.com (2603:10a6:208:18c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Sun, 10 Mar
 2024 13:00:17 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:209:81:cafe::c3) by AM6P195CA0005.outlook.office365.com
 (2603:10a6:209:81::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33 via Frontend
 Transport; Sun, 10 Mar 2024 13:00:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Sun, 10 Mar 2024 13:00:17 +0000
Received: ("Tessian outbound 3b68a75ac28e:v276"); Sun, 10 Mar 2024 13:00:16 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3be0621d5a1f2852
X-CR-MTA-TID: 64aa7808
Received: from 17a695cd9dc4.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 048AD41A-225E-4D95-AF68-2134F555E24D.1;
	Sun, 10 Mar 2024 13:00:10 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 17a695cd9dc4.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sun, 10 Mar 2024 13:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlXp5Y4DvJj6ZSiyYixM7dvCsG33dCZBW5PgeKfFOyi1bSVU1j7C3OxIc96IuUteGbOJjpCJJnmkjwWtehMzmKshWcq53X8P7Lv2FWrqq1srndtoS1aNujbCyb8QUihYaMqvI+N2aM5XXvuD4/nYm27zzVMZn6n2hrhLSQYZ/D1gUYWtQZJxccSGXMCAcoaKXCwkLAuTPkgJKutmzjNwg3E/rD4Me9szybLWRc8HVNeijWtwMPt2xaQh40whxXzymc9ahJBIUf8i4iRhamwhRIHXg4ceN18N2kMnOBFj6TvUjdY1FvUcKE+jQQ+M8btEFztq1tI102U8icjpZy+d7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5gcNxv7G0VgIkksFT1t9/HTEvkx7biEbCp7FinfKJQ=;
 b=R7ps13YQ/Wk/qqlgGLtVbG/cIp9Gqrl5nQUdETmIIKgDusRKbdjO5IAv6wH7hx5iCLIpD0jHhCCte4w6IXWJsh8AXLitmJodgH0TL8+9Tmf/DcULiSwvL3IxTt9W49qUcQQuUDACqC1n9pSkmRVLRIdKovByt6NQ63ywPsMpe79v31FYp6TKavGPW9K9RZrCTrWqIIb1XLFXyyR1phg5BSrUbNi9BXDqm6LODWcQ9q8/zYh4lAgwlsDfPBxPW1tO90yQYUIPFo3CrGO+TYJiONWMOdwfai8WUQYbA+Dv9XV5pzJf0Z1qcv6p+gmVo+cSZYWvh/HZUZ/NkvFDhPy8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5gcNxv7G0VgIkksFT1t9/HTEvkx7biEbCp7FinfKJQ=;
 b=cepRkd/10OaOpkwcAyLkjtGnxYBFxF7HtK4ULpooX5+K9tzeo3mTsLGzDBtgTjHN5i0BYBeFJPl8noncrMwmi/ykj8LDZsHGAjxuqeTiFKsZ3CdFHBRZr6pTb3MffZeOgvs1jD7A3PcZvTCjih96MZ8gfVHc4DoDv2dwcDHI5U4=
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com (2603:10a6:20b:350::15)
 by DU5PR08MB10611.eurprd08.prod.outlook.com (2603:10a6:10:519::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Sun, 10 Mar
 2024 13:00:08 +0000
Received: from AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358]) by AS8PR08MB6646.eurprd08.prod.outlook.com
 ([fe80::73ea:d367:20a5:5358%4]) with mapi id 15.20.7362.031; Sun, 10 Mar 2024
 13:00:08 +0000
From: Ben Gainey <Ben.Gainey@arm.com>
To: "ak@linux.intel.com" <ak@linux.intel.com>
CC: "acme@kernel.org" <acme@kernel.org>, "alexander.shishkin@linux.intel.com"
	<alexander.shishkin@linux.intel.com>, "peterz@infradead.org"
	<peterz@infradead.org>, Mark Rutland <Mark.Rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "irogers@google.com" <irogers@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org"
	<namhyung@kernel.org>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [RFC PATCH 0/2] A mechanism for efficient support for
 per-function metrics
Thread-Topic: [RFC PATCH 0/2] A mechanism for efficient support for
 per-function metrics
Thread-Index: AQHaTfAsajJVWBW/3kKvO/nD4CFIobEJvBnlgACb5gCAAMe7AIAmGiGA
Date: Sun, 10 Mar 2024 13:00:07 +0000
Message-ID: <0770e39877c1ac6459d41a692d5de2ff38031a17.camel@arm.com>
References: <20240123113420.1928154-1-ben.gainey@arm.com>
	 <87r0hfwet0.fsf@linux.intel.com>
	 <7de25cbdc9df21e1723d209ca8bd377a55bb54e4.camel@arm.com>
	 <Zc24eLqZycmIg3d2@tassilo>
In-Reply-To: <Zc24eLqZycmIg3d2@tassilo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6646:EE_|DU5PR08MB10611:EE_|AM2PEPF0001C715:EE_|AM0PR08MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8556e1-b9d6-4559-6e39-08dc410208c8
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 JKo+B/ea/wyJg7lqGlbwGZ420EG1vsYLGtdK3AAhdAbo8LaPysWqejYqhVE2FCqtKIUos3ppX+uRxgyxvNI3NlARdpo91SdnGoNeE0+/orT8MbB/oiyzMolas2vHfmx2GEbdOkFC8uzYMSZONHmuNCmxWFlPHhnMfqMoLFGGGeBO3MunbRfFmTcdf0w46Txw7JwfU2BpM+6NAU4azyUVmMPhRqsX6yhCokXzSsASrR747vPTnEtMX6nd/71ILW5Nm/QNg+gmJE8qbibsq6cXUSK8kI/T7sP0IqZ2OEzdee22sln5Nqxsfw32jfCtbLTu9Eudk3efkk4XXGh4DKg/E+27QOaycEPij40jHyiqtriy1jwRTtnoDmPYPY46xm8+xHq2Gq6Rc3c848Vr/4EddDnc70b20gb5ewq3UmZbFovyyF6S70qEJ2VsgF9scsmIiMj//v9zhXcsCX7y4n18M+s6fimUJ42HKOBP4FVSG/fjWFyJB8sMiq5NpnBANC/9ckAZJCfo1Qgdcpm1Ht1GLRgwPQEIPBS5WhYqFlZWai+EJ9mQ0EmeE23PRyw1Ktq5uwiGEk8ZVXuQpabgUWUU17mS7gQcNuEMdg5e8s+J1xnzBDZQuqLeJw29iFfkc05ZYeDG2V+DdFE8FESuQ/I9P3+eqTTIIb688SuoA6XReBvtH2rNDsiFyWuvMkdqlXwZcyoepAFS/r7gqjrsN2QNYr5ylQTTrEZ4xhEKkLMRmcE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6646.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <E33B82F253D4E74989C670F7B0234605@eurprd08.prod.outlook.com>
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
 AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d2340b74-c8db-4364-22b4-08dc41020344
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	937fT26lRrASa5bQfx1/GF3tWYF+i7w4lbH9wbVerYtuLMqoYC0ISXU/DBM2fQgQWC2dc4IG6vjak+WsCdCEaDsaoSrU1etv6FPyOdQ+TDul8jy4EbVz79WVZFzwJcdVdTLyh5GFWHm8QlVJz+lk7xuB3oixZ2tfKnZGWipWHONAKSdeZu2I5nvbIUVN7aXTVvrqg/i+GlKoxM83AHlLickUmEeF2r8QMnRTRVFlspWyuM3+q9sRgy4OBiLLG/h7Tr99e7RN6Qm8ILxiEmMS3qrTHZ5/k5UL09YXNBRouPQsV0cdbIaQPNih4KNFAELbskl24CyI5oYBUGrkQwZS3WTl+irh9sCF/n6J5UZo7JkoSgrXx+PaUp6dDgaerHVrega6kOC9nC5BQZUCWkccPJ67IrxcuM47bXOiT15/fC/OB3wLF4a2z/xcseFhaW7s9Ne+eMCtK4qiw33CYIgmWhKUpFqUVdnTbfx0s6nTtouBpRKaJqWMgE/RNi+qh0HmOIJ3nLgo2+XPfovDIMQ8sRWLlPbjeDsmm4OJd4lBy7IhFznMZTy1e2Eqd+zfWVcwszxnQ6WPzUDSe+riARTfxno3Z0diO0HN8rht8l+0iFKbDUE8QJTeh0397fKq8Gu+7AORsHuBMSVsO/Y4A3555G3DJ6XPS/45/sUO/EEtCLpuz9J8O7u3mt4HZN2dqjCetfsl6LR2sy4CLXKDAybH6Vfg21UjXZ7QyOpxaHwCH03j+vIEbuZnVLjfkXQs40kV
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2024 13:00:17.1923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8556e1-b9d6-4559-6e39-08dc410208c8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5522

T24gV2VkLCAyMDI0LTAyLTE0IGF0IDIzOjA4IC0wODAwLCBBbmRpIEtsZWVuIHdyb3RlOg0KPiA+
IE9uIFdlZCwgRmViIDE0LCAyMDI0IGF0IDA3OjEzOjUwUE0gKzAwMDAsIEJlbiBHYWluZXkgd3Jv
dGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBOaWNlLCBJIHdhc24ndCBhd2FyZSBvZiB0aGlzIGZlYXR1
cmUuIEknbGwgaGF2ZSBhIHBsYXkuLi4NCj4gPiANCj4gPiBZb3UgaGF2ZSB0byB1c2UgYW4gb2xk
IHBlcmYgdmVyc2lvbiBmb3Igbm93LCBzdGlsbCBuZWVkIHRvIGZpeCBpdC4NCj4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPZiBjb3Vyc2UgdGhlIGZlYXR1cmUg
aXMgc29tZXdoYXQgZHViaW91cyBpbiB0aGF0IGl0IHdpbGwNCj4gPiA+ID4gPiA+IGhhdmUgYSA+
ID4gPiB2ZXJ5DQo+ID4gPiA+ID4gPiBzdHJvbmcgc3lzdGVtYXRpYyBiaWFzIGFnYWluc3Qgc2hv
cnQgZnVuY3Rpb25zIGFuZCBldmVuDQo+ID4gPiA+ID4gPiBsb25nDQo+ID4gPiA+ID4gPiBmdW5j
dGlvbnMNCj4gPiA+ID4gPiA+IGluIHNvbWUgYWx0ZXJuYXRpbmcgZXhlY3V0aW9uIHBhdHRlcm5z
LiBJIGFzc3VtZSB5b3UgZGlkDQo+ID4gPiA+ID4gPiBzb21lDQo+ID4gPiA+ID4gPiBleHBlcmlt
ZW50cyB0byBjaGFyYWN0ZXJpemUgdGhpcy4gSXQgd291bGQgYmUgaW1wb3J0YW50DQo+ID4gPiA+
ID4gPiB0byBlbXBoYXNpemUgdGhpcyBpbiBhbnkgZG9jdW1lbnRhdGlvbi4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoZSB3YXkgSSBoYXZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgdGhpcyBpcyB0aGF0IGZv
ciBlYWNoIHNhbXBsZQ0KPiA+ID4gPiB5b3UNCj4gPiA+ID4gYWx3YXlzIG1haW50YWluIGEgcGVy
aW9kaWMgc2FtcGxlIGNvdW50IHNvIHRoYXQgdGhlIHJlbGF0aXZlID4NCj4gPiA+ID4gPiByYW5r
aW5nIG9mDQo+ID4gPiA+IGZ1bmN0aW9ucyBpcyBtYWludGFpbmVkLCBhbmQgdGhhdCB0aGUgInNh
bWUgYXMgcHJldmlvdXMiIGNoZWNrDQo+ID4gPiA+IGlzIGEgPiA+IHdheQ0KPiA+ID4gPiB0byBl
bmhhbmNlIHRoZSBhdHRyaWJ1dGFiaWxpdHkgb2YgdGhlIFBNVSBkYXRhIGZvciBhbnkgZ2l2ZW4g
Pg0KPiA+ID4gPiA+IHNhbXBsZS4gDQo+ID4gPiA+IA0KPiA+ID4gPiBCdXQgaXQgYWJzb2x1dGVs
eSBjb3JyZWN0IHRvIHNheSB0aGF0IHRoaXMgd2lsbCBiaWFzIHRoZSA+ID4NCj4gPiA+ID4gYXZh
aWxhYmlsaXR5DQo+ID4gPiA+IG9mIFBNVSBkYXRhIGluIHRoZSB3YXkgeW91IGhhdmUgZGVzY3Jp
YmUuIFRoZSBiaWFzIGRlcGVuZHMgb24gPg0KPiA+ID4gPiA+IHNhbXBsZQ0KPiA+ID4gPiB3aW5k
b3cgc2l6ZSwgd29ya2xvYWQgY2hhcmFjdGVyaXN0aWNzIGFuZCBzbyBvbi4NCj4gPiANCj4gPiBJ
IHdvdWxkIGJlIG1vcmUgY29tZm9ydGFibGUgd2l0aCBpdCBpZiB5b3UgYWRkZWQgc29tZSByYW5k
b21pemF0aW9uDQo+ID4gb24gdGhlIHdpbmRvdyBzaXplcy4gVGhhdCB3b3VsZCBsaW1pdCBiaWFz
IGFuZCB3b3JzdCBjYXNlIHNhbXBsaW5nDQo+ID4gZXJyb3IuDQoNCkFncmVlZC4gSSB0aGluayBm
b3IgdGhlIEFybSBQTVUgbWF5YmUgdGhlcmUgaXMgbm90IHRoZSBzYW1lICJwcmVjaXNlIg0KYmVo
YXZpb3VyIGJ1dCBpdHMgY2VydGFpbmx5IHNvbWV0aGluZyB0aGF0IHNob3VsZCBiZSBwb3NzaWJs
ZSB0bw0KaW1wbGVtZW50Lg0KDQoNCj4gPiANCj4gPiA+ID4gSXQgc2hvdWxkIGJlIHBvc3NpYmxl
IHRvIHByb3ZpZGUgYSBwZXIgbWV0cmljICJ2YWxpZCBzYW1wbGUiDQo+ID4gPiA+IGNvdW50ID4g
PiB0aGF0DQo+ID4gPiA+IGNhbiBiZSB1c2VkIHRvIGp1ZGdlIHRoZcKgICJxdWFsaXR5IiBvZiB0
aGUgbWV0cmljcyBmb3IgZWFjaA0KPiA+ID4gPiBzeW1ib2wsDQo+ID4gPiA+IHdoaWNoIG1heSBh
bGxvdyB0aGUgdXNlciB0byBtYWtlIHNvbWUgYWRqdXN0bWVudHMgdG8gdGhlDQo+ID4gPiA+IHJl
Y29yZGluZw0KPiA+ID4gPiBwYXJhbXRlcnMgKG1vZGlmeSBzYW1wbGUgcGVyaW9kLCBvciBzYW1w
bGUgd2luZG93IHNpemUgZm9yID4gPg0KPiA+ID4gPiBleGFtcGxlKS4NCj4gPiANCj4gPiBFdmVu
IHRoYXQgd291bGQgYmUgbWlzbGVhZGluZyBiZWNhdXNlIGl0IGFzc3VtZXMgdGhhdCB0aGUgSVAg
c3RheWVkDQo+ID4gaW4gdGhlIHNhbWUgZnVuY3Rpb24gYmV0d2VlbiB0aGUgdHdvIHNhbXBsZXMu
IEJ1dCB5b3UgY291bGQgaGF2ZQ0KPiA+IHNvbWV0aGluZyBsaWtlDQo+ID4gDQo+ID4gRjHCoCBz
YW1wbGUNCj4gPiBGMg0KPiA+IEYxwqAgc2FtcGxlDQo+ID4gDQo+ID4gYW5kIGlmIHlvdSdyZSB1
bmx1Y2t5IHRoaXMgY291bGQgaGFwcGVuIHN5c3RlbWF0aWNhbGx5LiBUaGUNCj4gPiByYW5kb21p
emF0aW9uIHdvdWxkIGZpZ2h0IGl0IHNvbWV3aGF0LCBidXQgZXZlbiB0aGVyZSB5b3UgbWlnaHQN
Cj4gPiBiZSB2ZXJ5IHZlcnkgdW5sdWNreS4NCj4gPiANCj4gPiBUaGUgb25seSBzdXJlIHdheSB0
byBqdWRnZSBpdCByZWFsbHkgaXMgdG8gcnVuIGJyYW5jaCB0cmFjZSBpbiA+DQo+ID4gcGFyYWxs
ZWwgYW5kIHNlZQ0KPiA+IGlmIGl0IGlzIGNvcnJlY3QuDQoNClRydWUuIEkndmUgYmVlbiBsb29r
aW5nIGF0IHVzaW5nIHRoZSBmdW5jdGlvbiByZXR1cm4gUE1VIGNvdW50ZXIgdG8NCmlkZW50aWZ5
IHRoaXMgY2FzZSBhbmQgZmlsdGVyaW5nIGFjY29yZGluZ2x5LiBOZWVkcyBhIGJpdCBtb3JlIHdv
cmsgYnV0DQpzZWVtcyBwcm9taXNpbmcuDQoNCg0KPiA+IA0KPiA+IEFsc28gdGhlcmUgaXMgb2Yg
Y291cnNlIHRoZSBwcm9ibGVtIHRoYXQgb24gYSBtb2Rlcm4gY29yZSB0aGUNCj4gPiByZW9yZGVy
aW5nIHdpbmRvdyBtaWdodCB3ZWxsIGJlIGxhcmdlciB0aGFuIHlvdXIgc2FtcGxlIHdpbmRvdywg
c28NCj4gPiA+IGFueSBub3Rpb24NCj4gPiBvZiB0aGluZ3MgaGFwcGVuaW5nIGluc2lkZSBhIHNo
b3J0IHdpbmRvdyBpcyBxdWl0ZSBmdXp6eS4NCg0KDQpUcnVlLiBJbiB0aGUgYWJzZW5zZSBvZiBh
biBhbHRlcm5hdGl2ZSBoYXJkd2FyZSBtZWNoYW5pc20gdGhvdWdoLCBJJ20NCmFpbWluZyBmb3Ig
cmVwcmVzZW50YXRpdmUgbWV0cmljcyByYXRoZXIgdGhhbiBwcmVjaXNlIG1ldHJpY3MuIFRoYXQg
aXMNCnRvIHNheSwgbWV0cmljcyBhdHRyaWJ1dGFibGUgdG8gZnVuY3Rpb25zIHdpdGggYSBzdWZm
aWNpZW50IGRlZ3JlZSBvZg0KYWNjdXJhY3kgdG8gYmUgbWVhbmluZ2Z1bC9hY3Rpb25hYmxlLiBJ
biB0aGlzIGNvbnRleHQgdGhlIGZ1enppbmVzcyBpcw0KYWNjZXB0YWJsZS4NCg0KDQo+ID4gDQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEkgZG9uJ3Qgc2VlIGFueXRoaW5nIEFSTSBzcGVjaWZp
YyB3aXRoIHRoZSB0ZWNobmlxdWUsIHNvIGlmDQo+ID4gPiA+ID4gPiBpdCdzID4gPiA+IGRvbmUN
Cj4gPiA+ID4gPiA+IGl0IHNob3VsZCBiZSBkb25lIGdlbmVyaWNhbGx5IElNSE8NCj4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiBHcmVhdC4gV2hlbiBpIHdhcyBvcmlnaW5hbGx5IHRoaW5raW5n
IGFib3V0IHRoZSBpbXBsZW1lbnRhdGlvbg0KPiA+ID4gPiBvZiA+ID4gdGhlDQo+ID4gPiA+IGV2
ZW50IHN0cm9iaW5nIGZlYXR1cmUgSSB3YXMgdGhpbmtpbmc6DQo+ID4gPiA+IA0KPiA+ID4gPiDC
oCogQWRkIGBzdHJvYmVfc2FtcGxlYCBmbGFnIGJpdCB0byBvcHQgaW50byB0aGUgZmF0dXJlDQo+
ID4gPiA+IMKgwqAgLSBUaGlzIHdpbGwgYmUgbXV0dWFsbHkgZXhjbHVzaXZlIHdpdGggYGZyZXFg
Lg0KPiA+ID4gPiDCoCogQWRkIGBzdHJvYmVfcGVyaW9kYCBmaWVsZCB0byBob2xkIHRoZSBhbHRl
cm5hdGUgc2FtcGxlDQo+ID4gPiA+IHBlcmlvZCA+ID4gKGZvcg0KPiA+ID4gPiB0aGUgc2FtcGxl
IHdpbmRvdy4NCj4gPiA+ID4gwqAqIEhhdmUgYWxsIFBNVSBkcml2ZXJzIGNoZWNrIGFuZCByZWpl
Y3QgdGhlIGBzdHJvYmVfc2FtcGxlYA0KPiA+ID4gPiBmbGFnID4gPiBieQ0KPiA+ID4gPiBkZWZh
dWx0OyB0aGUgc3dpenpsaW5nIG9mIHRoZSBwZXJpb2Qgd2lsbCBiZSBkb25lIGluIHRoZSBQTVUN
Cj4gPiA+ID4gZHJpdmVyID4gPiBpdHMNCj4gPiA+ID4gc2VsZiBpZiBpdCBtYWtlIHNlbnNlIHRv
IHN1cHBvcnQgdGhpcyBmZWF0dXJlIGZvciBhIGdpdmVuIFBNVS4NCj4gPiA+ID4gwqDCoCAtIERv
IHlvdSB0aGluayB0aGlzIGlzIHNlbnNpYmxlLCBvciB3b3VsZCBiZSBiZXR0ZXIgaGFuZGxlZA0K
PiA+ID4gPiBpbiA+ID4gY29yZT8NCj4gPiANCj4gPiBJIHdvdWxkIGhhdmUgYSBjb21tb24gZnVu
Y3Rpb24gaW4gY29yZSB0aGF0IGlzIGNhbGxlZCBmcm9tIHRoZSBQTVUNCj4gPiBkcml2ZXJzLCBz
aW1pbGFyIHRvIGhvdyB0aGUgYWRhcHRpdmUgcGVyaW9kIGlzIGRvbmUgdG9kYXkuDQoNCkFjaywg
dGhhbmtzLg0KDQpSZWdhcmRzDQpCZW4NCg==

