Return-Path: <linux-kernel+bounces-108600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818E6880CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E086AB21D39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C82238384;
	Wed, 20 Mar 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vlL4wm6F";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vlL4wm6F"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2057.outbound.protection.outlook.com [40.107.8.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0808374CF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.57
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922375; cv=fail; b=OGGpIgSW23EGd/GwITdmw5njX47O2lzBUNhIhYJ/7v5kucvhth0iU+AXqfgeFjs0Nzqcc+1zg4YS937n0OOHAPta3l1uMXiTsK/+D7Gr+3PQ4ycJwrTu6ZxqmSEvAL78GkKL6YD90q5HJB/B1HyBd1uYE9iq+t655sxd4Tzxsx0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922375; c=relaxed/simple;
	bh=FSpPf2ReLm6mUqCwk/SgCkx5JL4vlySArv+Yxu4DBmo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LzN8MwLcfgft9j6ksqk4J/LCbaU/OCZ1tClj/k5iKVLAMDEEcMei/Wp+2LtKXEXtJibHAjpCPBKEKEOUAmlnesyvAhwHXlvygWNtsydxU+EXjOebyIgn6Qgh7rma3oo8bWs+7NaOrmZw0KRfrXtP62jqbEw+cYlXSTaV1sxzN5A=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=vlL4wm6F; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=vlL4wm6F; arc=fail smtp.client-ip=40.107.8.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=nUtyx9RwmQHOzmoNEElfqEUAPkMKh2iQJKn+3NJ3Ys+PHsxkqSeMXqvAlpfUVNCJ6g6ynmJrIeFQf1JK2C5SNr3c582ZYX45meu57ng02C2H3HwLlUqkHe/H+JNPxxv/pM/VX3Ryl/ivhskVRNOde73I+lbQiupO2uS8eUyn0AcRfJg/RmvAZ+WeUzbDKXnUdnH48anahCOJTyiDtuJMSbuClIRqZd8CoX7ZHvQ2PSyn5HV3eGGjXAGctUgAPy9bHBHbXyqGNoy6H/0rRfSwg9CbAX8sO6kPMByHxjevkHc8x2DZJpRK5pvnumiUv9o5F1gR1mY5jj0KIR2dswBU0g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt0+QpsVElN8a4lucaX9vVROoHh6h1nTL9n4s+qpaiU=;
 b=Eu6qbORVWDYGAWbZh9Mb9BVGP5opeqGbEgR03H4SGEED/1nnM+e3TrLAkCeC3zWz+kDPoUFnZcXVkZg8v/spABdmc9DdfWQtdMPvQUtRw4TIqcMJsle4avHW+nEDgwfRWem4yRoRzK3T7O+lCQLmM8hltuYPBWXmPeLaAn+Yz3rXco6aGnZCPxkvfDm21Qw9prd/7g8H7OFG7g6iFl4KcaHkCRrfjT5GmxznSBGolE2IgtLf38LvJHS6Dp/3w6lE/zA9mcpv6rLWf41BOoAubToH1NCTOvGxMDQQMOII5Pwk34XfnPfgT5kbEAzwRU5v6lcaH50SQr9bj33EVDt7vQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt0+QpsVElN8a4lucaX9vVROoHh6h1nTL9n4s+qpaiU=;
 b=vlL4wm6FjPf1LJWC/1/dBHm3n/QgNQjRr1FrZF9/6cTRDNsr9lPncO418aH1a/BbleABUM0W3ioe8m+R1i8dR/nkW14F+N13KKfKy1DffNlt9LYwyvKlMyk2aHWQb0QUS2kLUpsnqXjVJjH5U1d5pMh/IE7s28uq1hSehSznVo0=
Received: from DU6P191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53f::26)
 by AM9PR08MB6195.eurprd08.prod.outlook.com (2603:10a6:20b:284::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 08:12:45 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:53f:cafe::1b) by DU6P191CA0045.outlook.office365.com
 (2603:10a6:10:53f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:12:44 +0000
Received: ("Tessian outbound 9d16f63426bd:v300"); Wed, 20 Mar 2024 08:12:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 3f506dc0523184e5
X-CR-MTA-TID: 64aa7808
Received: from 5ba36317b1df.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id D4662689-3DAB-4D16-964F-4244560F5115.1;
	Wed, 20 Mar 2024 08:12:34 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5ba36317b1df.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Mar 2024 08:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WndU/REmIeRG427exB486aVows2C+V3z/DnoODDcl4ta7DcWzNM8I0LVMIsSxqwTnndTqZcnxkpdyaDK0IFmskQ4MZUnOayG6gcjAh+sQXCl6CeRSudoUpP+4X+q4gLRfb8O3PrSRa4+CNOccGRzJVcuR+4Jrd/rxeyCR5Ut4mDe6lgzoMRwUURazKGzBzqVqZXZHvshUejQF7YNlhzEqR+rbVqSrMGNUqfy67y1ZwKwCWeUn2Nka2s35RcHco0iVWm5oPFwHGIr7RbF1G6uP4Sdx7BtmDCZhQdgob1xe1WZc+BOxGEieE+O5mvOZgT1FigafR6Ig+nMhsNoa4SuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt0+QpsVElN8a4lucaX9vVROoHh6h1nTL9n4s+qpaiU=;
 b=ftl4+Gjnm7s7x+wE4B3TVB1xPJGRn0w6ZRwJL29AbTZSp7qGcGbo+2nIOeXT1lz4IQWUHJgPeFIHiDADXBwGt33ff38LzLOQ5YaAmXc5ok70wubCPYXycI+thw1Xy8NPrentHGzEsZHWjwvJCefaa0hB/j3o3JndzpWDZnPlWVfs4Oi7oR39AGdp+R2lFpPb3irwoLi4kOi8rjfEQhfLEHsPvQpjgtA+SB4uB+1IAu0M56TkcLueWy4dOPRl2LkjI+hJaX/pUKJ23cBY/Q/TCxBf1k5BgjZ5Xabe5mxb8fQv4mePhmrY72f4Fs/uV638sHIJ51IQ6WB9XXqdQ3UggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt0+QpsVElN8a4lucaX9vVROoHh6h1nTL9n4s+qpaiU=;
 b=vlL4wm6FjPf1LJWC/1/dBHm3n/QgNQjRr1FrZF9/6cTRDNsr9lPncO418aH1a/BbleABUM0W3ioe8m+R1i8dR/nkW14F+N13KKfKy1DffNlt9LYwyvKlMyk2aHWQb0QUS2kLUpsnqXjVJjH5U1d5pMh/IE7s28uq1hSehSznVo0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by PAXPR08MB6384.eurprd08.prod.outlook.com (2603:10a6:102:154::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 08:12:30 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::363f:3fc8:fc36:58ed]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::363f:3fc8:fc36:58ed%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 08:12:29 +0000
Message-ID: <6d0dcb2e-09a2-4238-8629-e6857504765f@arm.com>
Date: Wed, 20 Mar 2024 08:12:18 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
To: Tobias Huschle <huschle@linux.ibm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
 <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
 <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
 <ZfqKbLm4rWXmfPN4@DESKTOP-2CCOB1S.>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <ZfqKbLm4rWXmfPN4@DESKTOP-2CCOB1S.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::9) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|PAXPR08MB6384:EE_|DB5PEPF00014B8F:EE_|AM9PR08MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5890387d-85dc-4c82-55fc-08dc48b58583
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 8OTKQqyZylVTdIRBZ+sbWbpU4AbjdMmS6SGBHr2vviP78Um+jDZ9BnOJnK2tsz3SszqbU+Qf0qoR0wbrGEVkgwfVoEm6UkZS6z0eBGoWuN9T+0MYsvoqUeGsVXfr77+CbqrnMR8Zr4R02LREPs7UhQYBOBpSmEj92ySuRdFdhlQ480O/k9FUCtyPBR3wGU1USVSpIkM/9L71etxNUKrhCXt3Ft58a710N1S8Kv1kmdcwLPf9LfzBgvjDGb3I6jo7SfxwYzrkYlDO1nK8Bxcpx2l802MYBK9G/TAimwqlF5b2kqkircb9ji8qzpC5xMMg64vV3ktMNB7JeSjJRCZwaedqliC7TYdVlRnueJDobk7MONK22kMnjUS2Bgs3nwkNn6Q4FiN6DhVRnrjjuIHzCWhaL0DuHgTAU7O/eCZKEXq6gjMB4tS+pvbfxd3efhHbcdcpj1QbrizkcCSVSmc0hyYoZ8+KVpOfIbxdzOM2TiF4RnEusLvSKPMQoxeGqR9/xwTk0C58hmJdIij9FjruBRKXtaaKhql8NZ2/HZfRNjueORqxwjIjJeE8s5IJIfHmjc2ueKuElFPjxp3en/XZ/vVq09f7gfE4Z6k+w+jGKv8=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6384
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	258f15a3-5473-4b00-2bc0-08dc48b57c20
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/ZoU2Y1aaC6KfthNeJAQTREV71xCKHrZncgQYf+CMrEJgO6T1ctslxvM6JoNi9/V9nDpX/V6VeGFHawlSUbiQ70aF/x37gX/1O97tMYu0jSaoTDzG+s1+8NJOGgs/VII5jtnlh3GiYHfKAts/iWoITjmuKgwGblbW2vF5YmRKNG8OvdyRKqr/Slk1mYfz0hTGt5j9pHQrnBilokqfAfITFWO9bvw9L9nc95tgLmQ9v4bRG3v4hFi4Z7xlp2hZJ+ts90xStsjKQMHHJ9ofFdjFvKKQT4nBfjHKHKPG1mCaTmNa8PzYdb1lBNR94ZASsmyYjTEZYQhVyQaBzB5XNdvFUHa7yM5KeHkdssuQQkUstr0BiyKX8byuGI5DjTYtcLyb3AHLLB5PjlnFjHKUmET34njxHguhhzi4G4ozjhWhdqm2a+KIe9QotfYerxOC7a9VS03T0eF06g7TYnOU7732QERxvNdrTPZAAKNTPu6n+NtPHRkZ54CylFMZfsyNs7mpmEjmPIqVtWIKF2Vy/t96Zt66DgY91IfdSDHnuMOAGqI30lzRT/WRAUXADgV/HI5WzwzkdLLPsrMoKnLV1H906BoMz0352s2Pv2O2knw4kgrkZV3dhwBM8kAnDPdK5UgCb4of0KZJW9Rh1LhnYlbN+2WXK90zrK6yWZj9gDofgvO6AAWgRGSovrcG7nL040eNzFYqJKFZp327lHy1CbEZA==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:12:44.5400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5890387d-85dc-4c82-55fc-08dc48b58583
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6195

On 3/20/24 07:04, Tobias Huschle wrote:
> On Tue, Mar 19, 2024 at 02:41:14PM +0100, Vincent Guittot wrote:
>> On Tue, 19 Mar 2024 at 10:08, Tobias Huschle <huschle@linux.ibm.com> wrote:
>>>
>>> On 2024-03-18 15:45, Luis Machado wrote:
>>>> On 3/14/24 13:45, Tobias Huschle wrote:
>>>>> On Fri, Mar 08, 2024 at 03:11:38PM +0000, Luis Machado wrote:
>>>>>> On 2/28/24 16:10, Tobias Huschle wrote:
>>>>>>>
>>>>>>> Questions:
>>>>>>> 1. The kworker getting its negative lag occurs in the following
>>>>>>> scenario
>>>>>>>    - kworker and a cgroup are supposed to execute on the same CPU
>>>>>>>    - one task within the cgroup is executing and wakes up the
>>>>>>> kworker
>>>>>>>    - kworker with 0 lag, gets picked immediately and finishes its
>>>>>>>      execution within ~5000ns
>>>>>>>    - on dequeue, kworker gets assigned a negative lag
>>>>>>>    Is this expected behavior? With this short execution time, I
>>>>>>> would
>>>>>>>    expect the kworker to be fine.
>>>>>>
>>>>>> That strikes me as a bit odd as well. Have you been able to determine
>>>>>> how a negative lag
>>>>>> is assigned to the kworker after such a short runtime?
>>>>>>
>>>>>
>>>>> I did some more trace reading though and found something.
>>>>>
>>>>> What I observed if everything runs regularly:
>>>>> - vhost and kworker run alternating on the same CPU
>>>>> - if the kworker is done, it leaves the runqueue
>>>>> - vhost wakes up the kworker if it needs it
>>>>> --> this means:
>>>>>   - vhost starts alone on an otherwise empty runqueue
>>>>>   - it seems like it never gets dequeued
>>>>>     (unless another unrelated task joins or migration hits)
>>>>>   - if vhost wakes up the kworker, the kworker gets selected
>>>>>   - vhost runtime > kworker runtime
>>>>>     --> kworker gets positive lag and gets selected immediately next
>>>>> time
>>>>>
>>>>> What happens if it does go wrong:
>>>>> From what I gather, there seem to be occasions where the vhost either
>>>>> executes suprisingly quick, or the kworker surprinsingly slow. If
>>>>> these
>>>>> outliers reach critical values, it can happen, that
>>>>>    vhost runtime < kworker runtime
>>>>> which now causes the kworker to get the negative lag.
>>>>>
>>>>> In this case it seems like, that the vhost is very fast in waking up
>>>>> the kworker. And coincidentally, the kworker takes, more time than
>>>>> usual
>>>>> to finish. We speak of 4-digit to low 5-digit nanoseconds.
>>>>>
>>>>> So, for these outliers, the scheduler extrapolates that the kworker
>>>>> out-consumes the vhost and should be slowed down, although in the
>>>>> majority
>>>>> of other cases this does not happen.
>>>>
>>>> Thanks for providing the above details Tobias. It does seem like EEVDF
>>>> is strict
>>>> about the eligibility checks and making tasks wait when their lags are
>>>> negative, even
>>>> if just a little bit as in the case of the kworker.
>>>>
>>>> There was a patch to disable the eligibility checks
>>>> (https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/),
>>>> which would make EEVDF more like EVDF, though the deadline comparison
>>>> would
>>>> probably still favor the vhost task instead of the kworker with the
>>>> negative lag.
>>>>
>>>> I'm not sure if you tried it, but I thought I'd mention it.
>>>
>>> Haven't seen that one yet. Unfortunately, it does not help to ignore the
>>> eligibility.
>>>
>>> I'm inclined to rather propose propose a documentation change, which
>>> describes that tasks should not rely on woken up tasks being scheduled
>>> immediately.
>>
>> Where do you see such an assumption ? Even before eevdf, there were
>> nothing that ensures such behavior. When using CFS (legacy or eevdf)
>> tasks, you can't know if the newly wakeup task will run 1st or not
>>
> 
> There was no guarantee of course. place_entity was reducing the vruntime of 
> woken up tasks though, giving it a slight boost, right?. For the scenario 
> that I observed, that boost was enough to make sure, that the woken up tasks 
> gets scheduled consistently. This might still not be true for all scenarios, 
> but in general EEVDF seems to be stricter with woken up tasks.

It seems that way, as EEVDF will do eligibility and deadline checks before scheduling a task, so
a task would have to satisfy both of those checks.

I think we have some special treatment for when a task initially joins the competition, in which
case we halve its slice. But I don't think there is any special treatment for woken tasks
anymore.

There was also a fix (63304558ba5dcaaff9e052ee43cfdcc7f9c29e85) to try to reduce the number of
wake up preemptions under some conditions, under the RUN_TO_PARITY feature.

