Return-Path: <linux-kernel+bounces-106247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C087EB5B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A7C1F246FC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB49D4E1BC;
	Mon, 18 Mar 2024 14:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CnI7UZxt";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CnI7UZxt"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE84D9E2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710773175; cv=fail; b=vGiNX3qE+4mAgrQoG00gvowW7JVBe3C+IPF9Sip+WFoj+JsdM9E3/BAQFvkj3yMamaINPGCLKav8nNvEuAQ2qiUtdQgfO9y0Yej0rH0q+32TLrExndYMNQHG2+GC/9dgd/M2w/lF4A9V20QikeKHRKxEFH0agg9t2NG/5iAK6dI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710773175; c=relaxed/simple;
	bh=wBaBpBFdeMVQphxwkS264aq6ED9t16TOTJTcJwpU6fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CoetDl8TUW/22nMAzWSVYomXZkwYINhB/5KsVWueDhkg0iSsqY2DQ70BK9YsSuoQJBvqR5p/qFTwZy1kjsS8JCCUa10OVwjQLhQOzAa+ufxaFCfkkyy1bX9R/uf+qeOiY5OrACJZWCUVjkSTZ6Bw7pdBkxJavtGmsSj2ZcJmTtI=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=CnI7UZxt; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=CnI7UZxt; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=HC2BM1I9jehZ/7GEWYk4Re+JGRKqAIOXdbAFSQg2xrnmEijjNtXC1mnhVAooYBedbff0uo0K5lDJEAVjWmAO/pArRBgB8kq16SbRutUORCZ7Jy2zGlk7CEZvl4FSOE17VYalllGNHOoptKHLjneGlyNEHNAWLYitUJjgpNiL9v9pKWTLJeLA4Wwrxyw5FKZ8pC7RoMQHn6xtHkrPAu9SD/pkafNqxfClH/y0kj5H0Yhx+Mcpu0KWcjsAtFsCUE46E59CnQb+l9vnFyBEqds0DJ/vPmW/xhTOyp5inlbIeKJKC1kNSBz4Z1myxlye3JAjeY0ll+m8oZU9q3Ur2cQ0wQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fkRDFt3FxJNApgJDoeBREY8AnHGH/ESkLOwj9vcRLs=;
 b=mHxZwo7/eho4w1+ChpuRSyigrJ0Q65ob9PeTyDO5qhDllsGiWFPOlg8mAmUTi8p8GgRhjrBsl+5TiPYwW9AeUBirD0+ywdAEi7SGensD1DqBM4mR3nr6rXuRNjX1VVRv2WgNBc/ZxL84E74S4CGQIbeox+/BasKEWBmgZSNNVycLcohWnmoXHY2ZZ0xYXeWv8e9OxsVJQIOYoMI8j2BVrvTylRCu73kdo85+WMn1yrpZC77onXcE3iJRPY1fXAbJ7ytEUQxxqez3ZqmhLToElaP5ypj+jDqnqZkTM4myTL7bYvdjHqdXBMqgDjPo2XnrYOMwG4sLlfS0DkgM/0vP+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fkRDFt3FxJNApgJDoeBREY8AnHGH/ESkLOwj9vcRLs=;
 b=CnI7UZxtyvNiNVcwGPbLWLLiMoMvc9YXxkmgqbsx4BET7/Rc2dwkRd8QHKfpfeBn48QEkV45G4Vf4fZpRD09S3meCyHrC3BUSyJjg3pJvRaIH391zROvbzA7KexetQCsX63QNGIUS4XpDTo2NFKMVSC6V7IRcE3vJvU7Q5j7JC4=
Received: from DU2P251CA0025.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::23)
 by DB9PR08MB8412.eurprd08.prod.outlook.com (2603:10a6:10:3d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 14:45:49 +0000
Received: from DB1PEPF000509F6.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::98) by DU2P251CA0025.outlook.office365.com
 (2603:10a6:10:230::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 14:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF000509F6.mail.protection.outlook.com (10.167.242.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 14:45:49 +0000
Received: ("Tessian outbound f0b355493f75:v300"); Mon, 18 Mar 2024 14:45:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2a4549fbc38e6589
X-CR-MTA-TID: 64aa7808
Received: from 817df38c814c.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2396F9CA-F3A3-4A51-8AF6-49AEEB9DA5C5.1;
	Mon, 18 Mar 2024 14:45:38 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 817df38c814c.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 18 Mar 2024 14:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRrAjmJi3CkpOzovfZVHYBIpDXC6wZpyrxvaMNebbhWfOfqgAzeJBSHhwCNzU0E1gJiAXDpQaRo+6Y8xuFiz6v/9neUxP6u51EOvdiBLTX0n3PgIQW9Gaqjwf9jzAgcMrR8TOL/ki0mgkWMcfcpsgCFSOqR+TKcLwXoBjdSZxqtvMENy5oqIxKohOzliImcFcya70q+UCWSNvigB+GoNQlr7gUv8tE5ehv6taI108I+apHTfRLeMCb29S/dR+K4+2MSQf1xBnp5/wKumQXyF/w4+DqhTKUcY6JSnSLmaG5XvM7yYJ+6GoblsA5HB1OQTQ8BmAV8D/arWd4Tj1SIpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fkRDFt3FxJNApgJDoeBREY8AnHGH/ESkLOwj9vcRLs=;
 b=gvMNnWnX6od5RMzw+vrh8i1xLWq79yB9qWGxDOlKCPJ+D4fhJqvASZLUl0ukQGgwQ+L+DOeLiMOHmi4TU6nj9t5/in4zRIwVQwGnk7ZLgPZIUV9tKuSXKMnV3uPfJg8x+MGV6cBE8etlObPmAatNLziZUAZF/QyGje4WcR068OgTfKE12OHz9IkV8NWr1/8nRLUKWerj3WSJv+g7I1AlsJ7307vcCZwZTAu1ImfZz6wXm7KiO6jU7G9U1JEEFJ3gs/0cr4sagEOXR42zgwRPjRUWyGHv5FA9hexu9w69bzoSfxobmN2ge2K5vETFNlYdU2XiviKhpRCo6ikfjrCa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fkRDFt3FxJNApgJDoeBREY8AnHGH/ESkLOwj9vcRLs=;
 b=CnI7UZxtyvNiNVcwGPbLWLLiMoMvc9YXxkmgqbsx4BET7/Rc2dwkRd8QHKfpfeBn48QEkV45G4Vf4fZpRD09S3meCyHrC3BUSyJjg3pJvRaIH391zROvbzA7KexetQCsX63QNGIUS4XpDTo2NFKMVSC6V7IRcE3vJvU7Q5j7JC4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com (2603:10a6:803:c4::31)
 by GV1PR08MB10536.eurprd08.prod.outlook.com (2603:10a6:150:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 14:45:33 +0000
Received: from VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::363f:3fc8:fc36:58ed]) by VI1PR08MB3919.eurprd08.prod.outlook.com
 ([fe80::363f:3fc8:fc36:58ed%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 14:45:31 +0000
Message-ID: <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
Date: Mon, 18 Mar 2024 14:45:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, sshegde@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
References: <20240228161018.14253-1-huschle@linux.ibm.com>
 <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
Content-Language: en-US
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0350.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::13) To VI1PR08MB3919.eurprd08.prod.outlook.com
 (2603:10a6:803:c4::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3919:EE_|GV1PR08MB10536:EE_|DB1PEPF000509F6:EE_|DB9PR08MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b5002b-572d-407b-5406-08dc475a1aa5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7aoamcJB01kBge1l5H6ivJJw6MqkPuljgJG9ERuLGNTjdRG8j6naeNaFUCAp2m01M6ThYIiyl5A5/W6McB5EcG9hzoUlKe3dhP1yH5g0BJetNkbzVd/zBW+huNX86cncf5QgaXzWwpGz/T1aBRPJiZe79bbvKrD7KLdxg1s04M1o2klGGyXf6Y9zRJtedzVI0TVojxmAuCxjh4cd0iylSkut9P3qTgb6nr28W3k36XWXOOVaHiDgmMsd2FGmD2drtY0MFo7JrAJbrpo0j4cFPamn+uWtKZAccgUZ8zrKPtvSmvz4LYXpZi93uQ7lhiPCgTp8beylqFaF+QfhJMH17opGIMrZVEENNKhZ2AZJxPp0cXTmsHoQihi5K8hLzB4j6H/Jxfz2Sfynr2jLl4YBtKKW/3lAW81TnyTzQNACL/jZUDl+Q8qx7NlkW/Bi/HOEjfc38yQja8G8ZBl5F4EHx/NdZsFs84uuz75buTeFuskr6ShbT15Ne2BdoiGPezThYmMRZm9bwqxQjov1WTAo7LQ3LkL63mhKouZeRzYbgkb88ecrP8g7tKWmGCvzEHc4L6igUnb9stW67EUosEWShoP88LiqclwZu3rTGaJ9cbU=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3919.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10536
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	255463f8-ab7e-4d72-a5af-08dc475a0f8b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ypELNA7PL9E3vSS/f18nB0zm48+IGp83iH3/fXcHmOTfjB/jgBFVYkW0YJhOutiUVp8pM3MuIRE0gdv8RNk/0mIBmjZEQeJZVLvrXqO7shJg94aWAtC02g7PtGjdmNyF91nqTALHgQcHOGHS7/M6aHv35xaQUoE5KW32a+ZpplnajP8xJHJ9ydI76alRfSXnzwSxrb42UtID/HCP/eG7kjtPVPg5Aav6SePnZ2aTFsVzimO82roo3UZajlvWgY2egZAb5cAlzTnxZtI6jtgKhzJQC2pya9zUNXWCm0SZLsVu+Y/czsKKvuCWfIG7x4l4PYcYqS/1+SVo/kIpWHp67t1Caq2ctgFVmhC5Q99NS90FX4gsdhPB0d3qR9uqbfdFlvtBrbltr5NbTFFvphO4QQu1LM9GEPuDyAQowOVWFJ0XfzFFNW9Sin8Vg0Qfm507nsaRCzXjIY13uSxE/qdrVo63QCjDdLDvzXfIotrosgV5cVT5AKySuW+siEkJbm4F/RixgpMWhwwkauVo1xnyDNyLRaQHhKka5+UuBzGvz8gHbH7JMrsbfjDDVBsMfA137rP7pRbCaGonjh4d1kf0eCGc7CPmoWsGtMuFbLinK+41spAocLrwqUTk8cPncxjwEDKnh0ujQPCeEBwDNUUqzURrzJwf3eDIc9QEltTVWsc4CtaeroaupLrKVI8LpQBjUrrn3CSd4cNBYCMO5Gp1jQ==
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 14:45:49.9439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b5002b-572d-407b-5406-08dc475a1aa5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F6.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8412

On 3/14/24 13:45, Tobias Huschle wrote:
> On Fri, Mar 08, 2024 at 03:11:38PM +0000, Luis Machado wrote:
>> On 2/28/24 16:10, Tobias Huschle wrote:
>>>
>>> Questions:
>>> 1. The kworker getting its negative lag occurs in the following scenario
>>>    - kworker and a cgroup are supposed to execute on the same CPU
>>>    - one task within the cgroup is executing and wakes up the kworker
>>>    - kworker with 0 lag, gets picked immediately and finishes its
>>>      execution within ~5000ns
>>>    - on dequeue, kworker gets assigned a negative lag
>>>    Is this expected behavior? With this short execution time, I would
>>>    expect the kworker to be fine.
>>
>> That strikes me as a bit odd as well. Have you been able to determine how a negative lag
>> is assigned to the kworker after such a short runtime?
>>
> 
> I did some more trace reading though and found something.
> 
> What I observed if everything runs regularly:
> - vhost and kworker run alternating on the same CPU
> - if the kworker is done, it leaves the runqueue
> - vhost wakes up the kworker if it needs it
> --> this means:
>   - vhost starts alone on an otherwise empty runqueue
>   - it seems like it never gets dequeued
>     (unless another unrelated task joins or migration hits)
>   - if vhost wakes up the kworker, the kworker gets selected
>   - vhost runtime > kworker runtime 
>     --> kworker gets positive lag and gets selected immediately next time
> 
> What happens if it does go wrong:
> From what I gather, there seem to be occasions where the vhost either
> executes suprisingly quick, or the kworker surprinsingly slow. If these
> outliers reach critical values, it can happen, that
>    vhost runtime < kworker runtime
> which now causes the kworker to get the negative lag.
> 
> In this case it seems like, that the vhost is very fast in waking up
> the kworker. And coincidentally, the kworker takes, more time than usual
> to finish. We speak of 4-digit to low 5-digit nanoseconds.
> 
> So, for these outliers, the scheduler extrapolates that the kworker 
> out-consumes the vhost and should be slowed down, although in the majority
> of other cases this does not happen.

Thanks for providing the above details Tobias. It does seem like EEVDF is strict
about the eligibility checks and making tasks wait when their lags are negative, even
if just a little bit as in the case of the kworker.

There was a patch to disable the eligibility checks (https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/),
which would make EEVDF more like EVDF, though the deadline comparison would
probably still favor the vhost task instead of the kworker with the negative lag.

I'm not sure if you tried it, but I thought I'd mention it.

