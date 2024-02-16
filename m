Return-Path: <linux-kernel+bounces-67905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C98E8572BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF5D12823CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226D3DDA3;
	Fri, 16 Feb 2024 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FXgEqTh6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YQLEURst"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7FD27A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044441; cv=fail; b=PrRue0dIS0ORoGHoE6U7qMHu++6n0+7kv0GcyAs0yEj3PEl34dOmftLio2V7u3cCwWlxCsYBj/H1apXzYxEEvbz/kqm+GKiEZRo1xnKmiKxpeckhNAygWxg1mMIzvncg3kxgZ5U7wZLOaBpN8NJ43qBsS/WsklX9EAaPqB9+gqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044441; c=relaxed/simple;
	bh=prDrrLZqK12VJb0uJ5SVwlPxmjiFlnluhR4SnWkHmik=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=gqHB2LaA02obxFXDolPKPX6qlxbTVRVCIBAMsrkI/crh6rPvBe5hvUVay5IU6/6kDK45/8o0yKNozF8Mwx/yDO7kbyEwlGwKCA7639oT/Eo5ryqwTuzLkpm6yv7FeK1yuZ4QEC0/AMeTdyuPPtL7RHjIdPpOGEXnMo3gPkoibX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FXgEqTh6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YQLEURst; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLSqfK020998;
	Fri, 16 Feb 2024 00:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6y0gyKwUYRPATCRfrClht4Rz7mBGfqpCRjNQgo9Lgx4=;
 b=FXgEqTh6E9VzYgNRifNr+PDrO3PV/3OtTze+VqifdUe/Fc0g4duLkyLWhEMTSuQoPEAQ
 Y4ohKZiYPWOC0Ce8HXm+ASDHTZuie53YNbQiaFVjkLyjyMB7bWvb8yoURm6dE679ha1D
 ZdX4/miVIZxQuvji4LBhpb6LwBgIvuBzuDtAlfijQlCkTWnSy9HstDARkCFCHEP7HFl7
 h8IAIXs2xfdwePPmEc3n6ZA9YcV26keiPr1Y3nhhe2FPIPjhxIy3JwmB7O9CjXcvZZ8Z
 U8X789tjj3E+g3hqBcbjxGv4DFpFmWXCYU4JldjgvIyS5I8LOnmIhEqSYuryiJ0aSBHu MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91w6uvty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:45:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41G08QH1015037;
	Fri, 16 Feb 2024 00:45:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb367c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 00:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ll6Sc+O/zODQ9PYnF4PhEzE3Au3tPW2cxiNe+DuRTpL9yQ9fcU0B6/PU2tBcepRaJdScmRvGrvXAsJ1bMkSV3bg7cMzGk53MFA2o6Oi/wkCIH7O+D8xA2qyF28+lr5Jy83kvVIDc18nCeTboebASa8W5pB8HeIp6idKzrmBkrrzkzf3ViZLlot4K6Smt+rEFff5lnjpnH5capLsr+CIArautB40JuUswXJPVcxVqfRmuzIPqkGi+DvOBTzyQFkq4Dve9CqEQJnkNIzsOqMc7mMbzH3bAzu7zW5I/fHf5LMTlPe2fKU1YsadOKKQKRdMN8yu5ncQ5joPVcAZYkKbDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y0gyKwUYRPATCRfrClht4Rz7mBGfqpCRjNQgo9Lgx4=;
 b=TI+8fQzX9BCXyIBK/ZaYXS+isllLlbVF2LIdW9OdMztFqFE9V5RmbeZXAFDAesiGU9lgpME20L8Wm7Lx5GCvwJ4lzR60Tbh4jNEWXsSqly73cG8S7qdac12rwhqTYtu0aB4aT02+kmAJtBeRbKhYJHsnlFWeMUY+sj7K/6nHet4r5tAlZDBBZp+DFhHnQKrV6WIqt6VPZOgoUI3dtGnm7kCYrER+q9VmaC4nMViJwveAjTt0w1MLEErTl4QP7JNvY8sSHjrl/eivuDbsD8kExBJRcwlcLv/rzk1J1p+3MtFth9XxlVC1UEtMTIfqKMnH0EIqTuZJxen/y3u5O3us5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y0gyKwUYRPATCRfrClht4Rz7mBGfqpCRjNQgo9Lgx4=;
 b=YQLEURstjKQBHl3tRM0hu8s0SS4GbiBSYc4Sz9UTTWwfRKSC/2kbBvymxxDgMQKrdOXAvOREEfau6ufSlcfQ7qd+5hsP55uP3EGoYpEk5zs/QMtjBoDoV6IfSipE4aZp2xOVey8V6ZVDkzhuP4S9Ug/j8s2Jhl+uYvoTMqymvqk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7210.namprd10.prod.outlook.com (2603:10b6:610:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 00:45:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 00:45:22 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
Date: Thu, 15 Feb 2024 16:45:17 -0800
Message-ID: <87le7lkzj6.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bc66f89-8e11-468a-1d9a-08dc2e888e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qTkjDAI1BQf0omkr6GejLYSCA3WEgvpQ7dIcbnVX7jcEVdronv8xK8EHmFr9137J5280Z2xXWGiD/P14U0s35HgfgA+xgGyhR6nSYJuj7XtsMT3Dhurp91FmApWLUtCnYjfgE2+CRcTpZBRWbXKtADT/XA7ZK64JZaAMMI4irKPjoK0F4R+QgJXQZfUEjO6hty/bDJbB57zEyx75P3tcHi9Y/dbRZ3jku0ChRqf1c65q3VqekV76PVvNMqeBiXMLujXjcwOH1oAU688Q7Xxjbm/sTUvgDkhLkqkusCLWCmf7jGJU6T0RawLNohDm9NaWHzeJCyz0o9jG8RZkHS4o60SRPMg+Xk3kNVhyfXiie/nvsluOP12EwQ1Va8+g4M2FDkhp/oP0TAmLkO+2bbMU6SfIMpUu2f+UzrIhNGxeNJxRd7QBAhkGs01OnOaK4x1cbtorsq+DQfzdVl+Pb3DrI6qYbfTfExN+VQ+A/YOZtswTAhNkpm6P93VVV1bTIU1W9vZ/J/XlWodFMxoHjg3utK6ZY9HDQas/ji4JAoi7pNEemO/hYKfe+9C1TtdiwY3T
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(4326008)(8676002)(2906002)(7406005)(5660300002)(7416002)(2616005)(83380400001)(38100700002)(36756003)(86362001)(26005)(66556008)(6506007)(66476007)(66946007)(316002)(6916009)(107886003)(6666004)(6512007)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?G2m9MOeGwDCSd+9Ah12SdnMcEsA93YLgi0Umd8BCVLuON85my0R0R8WULfCl?=
 =?us-ascii?Q?0tyAjcLNkGT5qEMa51NLfnZ5yXKPWqLtWSha3Jgs5OTrMf555K8iZ4LTrrFm?=
 =?us-ascii?Q?V1yRPZ+9bxbTqLDLkvq6PRXE12dXVQ3DPXSM3Ar2vLtr2k+vQvuJ26Ba6QvJ?=
 =?us-ascii?Q?KzRIpaJxlylgIa2QiBWE/ikzW/uAT+1S8p7sQrDZOTnJfFqp1JuAgFDMiPmR?=
 =?us-ascii?Q?q+QZmJjQOA8sZcIdNBm4Vd7/to5k/UDXaM8BpkD8yMKPvdVmdmtCWTKPc3YP?=
 =?us-ascii?Q?YUlX6gg/T9E4ubsoHtUsj8RRv2la4A8EPBNKbO2IKwNYgWlw4upLE0JYcrLb?=
 =?us-ascii?Q?ZvONXktI+64/TmS6ioGoMFum11+LizTdU5v13Q4Xd8CjoS2/UIWfX1uhpdEC?=
 =?us-ascii?Q?eIXf0wk4P/vn5OeKUEhetynpET5g6QO7IBnFA+5C8lBsXyqCrZ0k7L8l4nOa?=
 =?us-ascii?Q?o1pmQ8e6NmrXP5bBgisVLEUmJlOeB7ifPp6hYcFcOecwa5fFtyXBBpM0yBSE?=
 =?us-ascii?Q?GqEhs1twcAsBg4zteRT4OtZHx4YB3TQviunYBduE91XEr5f8H1AJhKMjd1N9?=
 =?us-ascii?Q?dYUy70fepNaSMsGkOjbMweqi7U5H03yvC7R7tiZYHd/WcpCqLRXzUNUgnmO0?=
 =?us-ascii?Q?ebvjY8GG3Z43/jOi8qvKz5wRtPZ0nQXUzDWMb43utia/J8BoQrFyXBROKYEG?=
 =?us-ascii?Q?+Ea5yZn620mvJk3eYWcs8JSqQ7BjV2oZtxEZPTygXM+4elmWviqRJi1GxVWl?=
 =?us-ascii?Q?NsH1BQrlv+lSc8aZmNuUC8X3aoZEb1go0HeM4Zpz86v735BOxEoAr/8ZjYM5?=
 =?us-ascii?Q?nHsp9dGLea4uH3SJD3iq+nFtc9uJ6YM/7tzb4VCyWkdA1v3qPPFU2fTzCNQN?=
 =?us-ascii?Q?pEBMEoDKkZ3yo3fTELYVTlTQ/X4QmYQjJW+3he2SR68ptBxpYiMlWkqPxagA?=
 =?us-ascii?Q?fKGIn+p+iYkCoVQS6257U+XzqTLzEq6YoXwdV8PJ7JXBnoC3VK20tswRVrq7?=
 =?us-ascii?Q?2atHqkz5+092rI/8Lo0nQLlFxKxJ2nCvWjo0Rcsf1M0YFQkaoU7CkGbQx7FH?=
 =?us-ascii?Q?9Bu+smKlSWXE7kTHwwIDmJlXLWqfRVB/t/QV2RSM3+YnHT+V4d3yWvM+JDz8?=
 =?us-ascii?Q?u5zknIX9aWftIuVT28eToSZmlkB1PZAfYFH2yai9Q3dMMt/RZMUWGbe2ftQI?=
 =?us-ascii?Q?kd4S8i9bGSwQt28H0k4nlhJRx1ORixtGp6qtbJcwMRwr5fNDDTqI7rtTBk9+?=
 =?us-ascii?Q?Gr/c650Jhwsk+EM14bsh2quuJfsv17EIo7I75bTL+C/8qu+d2LcFo06I10s1?=
 =?us-ascii?Q?rFdvO8EkvEkdvoJgN8dKN/e+3DklTGwxJREuIFQ1So1LRn3EvksUe8WllZ8n?=
 =?us-ascii?Q?bSzFJ+xY9+esxVYCYDalyppTwou78sljTT416mWl5XCBJuzPQbcYbqIBBRVL?=
 =?us-ascii?Q?gbYflqWk118zzYD2IfwRMAmSZ86wWe6IXju9i4iuj4NPn4HkRT0u2EFuzIcN?=
 =?us-ascii?Q?tZm6bF9FIfxNf7m5IUJj6XrQXL/klewEJ8HpLPDDtdE0i/9RhmMzvSp9h6Zc?=
 =?us-ascii?Q?6nM3VROgR0wGt1b+yTOGg2PDRXAYOHvjsYGh63cz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aAX8UtA/RsRj8NzBEgqi5xhStCMq4S18QgHjaybuDdy4nuCJ09gVEEd/aigMSf23RCJVfhpz/tlzAIjg5WUGCDu2PPsUX7td7jAhGnbVLx7o+K3c33xQ0ISC4J644bdADF92z/aTaJf6dJD6sP9R/3LIVQciyjqSXo+PIWK5bPwtO0307kAaRh54M8thA+iox63wY7b3qyCapAJ1pZo05g9P9pk4n+lI52e4B7gnMP8idHw4N65ZOBjg1Cf4CKMn6Xgz3fFBOwZm3yUrhov1JLFYMi1Snl0uLYZIkdGBVZNHdOg94h1qmpipjdMbXMaBqlewk2DkwflGPiLF+9djK63ECeRpLSirQ08dbtNSaEzZSDoNCBUNsaQPVCv2NrR+7u5UmOr5C6KcRxHRgIlEyKtE+KpPIaRUQLqlTNHAYAnzejVtJiFI1h1QI4aBZoRwxOOftAeJ4ZEUcdfeNC48qUzKeI66OihXX6iHfW4iShxAtPZls+yvViUQZub1NUwoG6CsXO82HacCod0I/lWgWJZ8iWKOZ7RkmFYsJ4W1yVRXvzgLhv5o7zbSuzWtluydwRcSwdkoNixRogrTx66Sv+B7chAi42LNvzF2ttekQkk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc66f89-8e11-468a-1d9a-08dc2e888e5d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 00:45:22.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjiNctxAsj6efjG96r60cFnJIFuRgkON3XLebFloe1+xAp0im3Cyo4w1qJD/P+V3ImuemmmuyUBqxAsGIz5I72P6JROJ6lm6Vi7SwLoyY0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_23,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=755 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160004
X-Proofpoint-ORIG-GUID: SGAA-kH25ifE-hySNKdRHep0sGLyd8rA
X-Proofpoint-GUID: SGAA-kH25ifE-hySNKdRHep0sGLyd8rA


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
>> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
>> >> >
>> >> > Paul E. McKenney <paulmck@kernel.org> writes:
>> >> >
>> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> >> > >> Hi,
>> >> > >>
>> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
>> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> >> > >> on explicit preemption points for the voluntary models.
>> >> > >>
>> >> > >> The series is based on Thomas' original proposal which he outlined
>> >> > >> in [1], [2] and in his PoC [3].
>> >> > >>
>> >> > >> An earlier RFC version is at [4].
>> >> > >
>> >> > > This uncovered a couple of latent bugs in RCU due to its having been
>> >> > > a good long time since anyone built a !SMP preemptible kernel with
>> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
>> >> > > likely for the merge window after next, but let me know if you need
>> >> > > them sooner.
>> >> >
>> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
>> >> > But, the attached diff should tide me over until the fixes are in.
>> >>
>> >> That was indeed my guess.  ;-)
>> >>
>> >> > > I am also seeing OOM conditions during rcutorture testing of callback
>> >> > > flooding, but I am still looking into this.
>> >> >
>> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
>> >>
>> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
>> >> two of them thus far.  I am running a longer test to see if this might
>> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
>> >> and TRACE01 have in common.
>> >
>> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
>> > sets them apart.  I also hit a grace-period hang in TREE04, which does
>> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
>> > to dig into more.
>>
>> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
>> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
>> as well?
>> (Just in the interest of minimizing configurations.)
>
> I would be happy to, but in the spirit of full disclosure...
>
> First, I have seen that failure only once, which is not enough to
> conclude that it has much to do with TREE04.  It might simply be low
> probability, so that TREE04 simply was unlucky enough to hit it first.
> In contrast, I have sufficient data to be reasonably confident that the
> callback-flooding OOMs really do have something to do with the TRACE01 and
> TREE10 scenarios, even though I am not yet seeing what these two scenarios
> have in common that they don't also have in common with other scenarios.
> But what is life without a bit of mystery?  ;-)

:).

> Second, please see the attached tarball, which contains .csv files showing
> Kconfig options and kernel boot parameters for the various torture tests.
> The portions of the filenames preceding the "config.csv" correspond to
> the directories in tools/testing/selftests/rcutorture/configs.

So, at least some of the HZ_FULL=y tests don't run into problems.

> Third, there are additional scenarios hand-crafted by the script at
> tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
> them have triggered, other than via the newly increased difficulty
> of configurating a tracing-free kernel with which to test, but they
> can still be useful in ruling out particular Kconfig options or kernel
> boot parameters being related to a given issue.
>
> But please do take a look at the .csv files and let me know what
> adjustments would be appropriate given the failure information.

Nothing stands out just yet. Let me start a run here and see if
that gives me some ideas.

I'm guessing the splats don't give any useful information or
you would have attached them ;).

Thanks for testing, btw.

--
ankur

