Return-Path: <linux-kernel+bounces-91878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 594DE8717C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFB41F2228B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF398173B;
	Tue,  5 Mar 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VpkuuMuW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iGqomAlL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A828172E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626359; cv=fail; b=i028IxDFIMJA8D1d6hV3mSrFRrFi3o/3ufCJcVC0nmM7szWuvYtWT1QHb4a2jbOnarVK84Eu7o1LRa1iohkIkNL9hOP1q4fFNl91T8zUIGHOhSqaDBoY73zGZP59nn9N6wD4uLT6GvwkR2DwcHByOQDGUc4Skm5z96C/adTXUAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626359; c=relaxed/simple;
	bh=2n1hT2Bsfhs2Qaf0FoxQP9htEfqVOzG4f5rbiaMf30w=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ev2MF+xW5Er3M92qud9346n3oAxWr9QOgu2Q9IT8Z5Q1uw+X3Z4QUKTlvQbo/3b1Tkx0dE+Ui4s/wMnMV+fA6n5EvtlD3yLCVf3oxcp3IFF/BfSomPALGDNgmPHVzZ6pJUGiL/5lr0JGzIcccmRsEGVEoKDOShiqBbnMYgKW/3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VpkuuMuW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iGqomAlL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4257Amm9028747;
	Tue, 5 Mar 2024 08:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=rHlOoovj5/UDGR0jMpWVSyUOD24scIeK6R1bzgntZpg=;
 b=VpkuuMuWlXBwxYsL7bfaTM5453o0Ja2c8VjQ7pvH2fC7fNWvlYJ65zwqksDrxshShX3e
 Td/I5nI39DUw/XoavM9hVAXzBaquf/eMHmgK+4XY4bupUqibFP63gcXI+Ltvr4mg7E7l
 /4rBDHqwPhyobiDr43U8wdnF/j3qdPIUUDrLsfiy0ooulzUtOBf+zBijAjYqLGDqsQQU
 iGCE6ZOSj+yPDXpofimJPihrc9mCfvY+9vlEAoHHaKiy0ZHiiCG/TZMQQ5Xfr6+7KrFF
 YOB/GLNMsOZji4q7eVo+Se/cQY+mdKqk0LH8iDPoHx4C31Q+g0PKPPNL03aEb6msJbk7 Hg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw45edq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 08:11:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4257U92o017606;
	Tue, 5 Mar 2024 08:11:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjd5gx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Mar 2024 08:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdPTQMRI3UIZT7sYzmOauoMjLjfXhTeiXfA11qHVQGwGNZ95y/NM2oX6VW+xKDdPLh5HPf2IMLK0D+kTH+3a/0LvRNCiva54m66w36Yxzevwdki2IAAScSx/T+DVQj8YsvzilpKQqXDhVq6oh73JHF1aZAJl0uUHiD+6O6UV5yqnAypwXP+VEeXurfW2KqzWrv0et4zhMl6t2Q4Li0BU5JwtEF/kAXNM+bHoGKf+0nS8fPj7yLaSTEVHKdCq+/KPf137cJgjE4y0+I4Yonrw2CHeQhI6XY8Aot+jmGlgj1XYPLBKs6ma4nJpn/zI6t7OTAxDbuQCFk+e5DN8M/x1Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHlOoovj5/UDGR0jMpWVSyUOD24scIeK6R1bzgntZpg=;
 b=Zwl4vxx2Qh1J+bPXdbZStB9DyrKVtIupoefXh9q4zyNsU+mhWrOLmHZCrVcW2rxODACA7IBV5xl3eLy5k4DTGw/nWaLVb89PRmHKBtZs0BPpsZVdZh/1UVZBxNtOKXnjmenfHGdhg9R1SBMFjtbTHaB5H64osKK0X9WRx4VPIdAXUd7/vVxMm64JPHRIe8xnnU2E3dzec8nuUux3Ult4yluNuYUXyOGGI8SFRUXJUrbRrezW/UOZUODwxOGwRpnNyJcuwVqMHVoE/8GMC1fX6UumoWjWXsAb7040Bc7mevLGVE17LXtk4S5jU4MZIIrBEA3GYNoKI6xF3NkXmQMOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHlOoovj5/UDGR0jMpWVSyUOD24scIeK6R1bzgntZpg=;
 b=iGqomAlLvs+EP2D23tYzUaqxwqIOq0jYLQH79f4tC1irVMbD4BSBFf9vy6MPg/jybDS4m6EHWez5SHCUpzEOhONopePLvGKN/7LAORs96faDftzh0RrjTW36/9DvxP3xI1hixK8JOAEPea03XmG73uVh+r4ulnH6k6cOGhXiKvQ=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 08:11:00 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::34b0:3c2e:51c3:e062]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::34b0:3c2e:51c3:e062%5]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 08:11:00 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <65e3cd87.050a0220.bc052.7a29@mx.google.com>
Date: Tue, 05 Mar 2024 00:11:28 -0800
Message-ID: <87frx514jz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::15) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|CO6PR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cec29b-98eb-460d-f130-08dc3cebcb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yWpqoWphF6mQTHlx6CQ/nh3QyL0cxL3kmibEi3zI1Ie93W6i+zS4/Q0Hju7fP054y6cRrucyFyECbQ+gpA58YHf3IB90vc93slLjf4VemcVnhai5SaLDN+Ip+YD8zdbNqsi1x8JA+Dg/YPXX+IX/W18JhcAQDLKPjH5Y6ip5ExzliRkGdu7ffRZi3kUDsbQ6UL9Ywmf7OGaHWcps2iWHbeysfId21KaPPhONiCDU8uNQZ++e06RcHw81wcZumWcotDEuscaj9xEXjC+OAPZ9GZqDWfGd6q/2cXZv5t+gfKZmXv2K4Zc9muueVX4NZyYMRldbWEQdXmyOqH1O63TluTp8x2RoOwLhkvLC0OzDl/Q0fzGLS/3stpn5xjPGkRnlgbch94Y2saw7AfojNbsMRxVFM039gVF4HoF8KHEASoZhG5RGUeNveZ9mpBQrND6SgWjam5QL5ptqWBQRaXi5f3gGyIxvz3toC8yoZ+kYxuIQC7ZT5jijxsAeqg9trbq7XsFkvaflvEC+XsjUMDhtxk6X0peVFYjEIYDuj0iqTKuKtk8ewf0/P1gnPDjwzi7vCPaDjN0kGApAW06GiHaPiBZ5tJdRDaTNZBKDts00Hxc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i/MoUUmL17oujdhf3J1J5VWjFcrkt2WAN2mYov+A4dg9Zpe+rUrVww1YXxbE?=
 =?us-ascii?Q?xsiA/l8XTIZwSM3QY5HPMS992otaGvwcdWO1oXE6qsUMBvq/t6p381uYqqPv?=
 =?us-ascii?Q?+SjIFBN3YwtxPdfJEuy2Onnt94AZTKIaqdpyHQzTGL4IANmzx5lEO/DdHFYr?=
 =?us-ascii?Q?noMa9QNHlfA2361OOA29u2QnfRxZd5yKMhCc4tpZfNVCEeW0oy2dS8kAMy89?=
 =?us-ascii?Q?LQTaJVRK1R5olJrAlAXEd4EiqCuF38Nq4cbsUB+jRhP4fK0cejOc/m9HWcyb?=
 =?us-ascii?Q?olUJbwJ4l44gjc4J98ADyWMeCavsZJHwgvI/1ry4tblwB7xYXz4YCEkxX03a?=
 =?us-ascii?Q?G9NzPL3y0OQzaTvSIdEzYPqbjG/kpzo2DjAtACcKUAK7riyXM84Jw7HE+FW3?=
 =?us-ascii?Q?ytj7Fp9exZrkoHjnWG+r0J6GKqgNmmSEmMcA9LDbXNSYiUF9plLh4WoHPB3f?=
 =?us-ascii?Q?GX3rMu4NkV8m/gJrEBvX/E3pYA5EgYyu6IHevoW2QtjtUvMM2my1noexKIgA?=
 =?us-ascii?Q?IR64ICeFB/vdpU70kEEPBTkFtja1Fh7b9xNEaoWqWwrhqZH3kxIRlrxy4sdR?=
 =?us-ascii?Q?RsREPi1/z2pjv9EE8evcrIbY7JAtXyWFmsbG+cgwv4uJiMHIEmvzsVbBoqiJ?=
 =?us-ascii?Q?ZXGF+6yQAR9u1SEZLx6WWHPcvCmK6BR0G4iie/VehcUljYDxGmBPuqTx4QxC?=
 =?us-ascii?Q?SYH4kL1cgxJ3JJ8au8SwAGuM3W4kqCAGu2qGG+jccvU1JD0y2h7DTL/Ota8J?=
 =?us-ascii?Q?ok2juS8S0NIHW9SvdEpHnFOLpXj86a0JOJB6WE/3kVa5OWBobH/3fEBXFKYW?=
 =?us-ascii?Q?tm0huoYBAzf2zrLHx01xusFwG5EJrPitDHseKxRUUi8V7ONznANJYxz0BAzw?=
 =?us-ascii?Q?4+YtIx7QqbTTZkBhQeH15J0i6V/tAeeIpE1ca7KLePrMPyzFfuc1rKyEkAft?=
 =?us-ascii?Q?t+EowfK2iaz3XBoWny/8LacCYqC3szkdGPSCLXGWfegofnj1DJ/vUdS4GY58?=
 =?us-ascii?Q?SiNbPTffNqqMcpt54Kk49Q9UTssonzUz1KSFQcnrgT/kuI+dBIKshoK8dJ97?=
 =?us-ascii?Q?JB8QW6iLZ7qXu6tcPgQ6aoFUevfnwEFNDe8ciSU2/1ytHbJFDDlXpYwejE09?=
 =?us-ascii?Q?fI2NSehPkfJhwIqwm9zfnUxutNjQyqoyjjDWoeXDC1Vsbis5JutqqhsAiDd4?=
 =?us-ascii?Q?HWg+Vb7E2ZoLrqRXz8hqzn9fdPoes45cwbYGnjlb3LMMOAwfMAu12Fu/GMN3?=
 =?us-ascii?Q?MveBjZhZ/yjMb53GpXe6ZTTUvaLR53dIs9PaZo4lNbJRvtIcO9Lbq5NGO2DE?=
 =?us-ascii?Q?Gz5RhumhSWzQWwmWSFwH7PrnrZx1xhEcWqlyMiCpHH59EbEur58r7eZAXgk5?=
 =?us-ascii?Q?qdKP7f+dIX+8LC4gnNRxFLcgWgTJ15yk+c8yqstL2JNYLT0xDfTx4xety7nt?=
 =?us-ascii?Q?7wVSwv/PdrstYhYaRBhs2KTO1Sf7/1U7rUnxFMk9W5qSXrQk+7L1r6+y5eh2?=
 =?us-ascii?Q?ERnJh+6Qgve7exmzWg1pBy4WkKj3/0IpOUe2gaxpXZAZ/Vno4EPZu36eyoOz?=
 =?us-ascii?Q?dwFmTWgn1ag6oANYtsKyhQttq6pYV5HlFDy5SpvJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RUkvmydenSTcLiEQ9xeZBVORiUZdCCO6Zb//SCtPo2RTkKoH2ll1yDQLcgV/c02fa9aJNXB3rrAH8zvuBKBKdZkqklDsImuyf0pejB3pCdqWcz9qv9l4R0FjGZeIFr2lG8kxE1ogG0WAPYdJDFM/hg8/2o8/O74yO6DVLdB1vjK+zWrazexaN8WjK+67RMJn6g9ocrd2YjqEKSFE5RJw1qR6BT5OyDwg9z9JrdB9kDvYVvbyUUbNUMTKZOkGJ9hIaBGhFa4HVOmP9yH4l16KmrxmIsspskSuhJqhGC2PSfuUOfVVrnb8IWbnkp1A9lvn2wVFFGOKWfG71hdLXQX3e665Tyhls49RFep1E0Eym7DwmU+0/1lHkHiOvOtEscIxRdBE8XNNDvf1f9SA8Ahb27bz1pY2/jU/QUo29XEqgJZC2fRuFjn/OdaaCXaaLmp+iRrHK7qKb04ga2zWL+0S62SG3aVvPAXHH9cQuGDxe+lDaWiWj1+ZpuJnekMXQ0BBFKKtCNAc37nlORw+RjJewV/2bd5BWTrbqI24/Yt4/UWMR6OzvEhUmfUCr47lqUI/fVqhLz5mmJ/tQOtNjmLfURoJmpGwT26fRLlCjNTnVpo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cec29b-98eb-460d-f130-08dc3cebcb27
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 08:11:00.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VnQAz3jVOUmEhoe+9Cp1TXb0MNM8PW0/uHuNhxi19S/ZuLOJTDldN4AMZebeuDZrjTtCOLE1Az34jCIN8MGtTLFUH1ua65NltdNpOKAfbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_05,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=952
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403050063
X-Proofpoint-ORIG-GUID: s3RtsY4g-VGe7_iSf3m5SqiyOu0f99S-
X-Proofpoint-GUID: s3RtsY4g-VGe7_iSf3m5SqiyOu0f99S-


Joel Fernandes <joel@joelfernandes.org> writes:

> Hi Anukr,
>
> On Mon, Feb 12, 2024 at 09:55:50PM -0800, Ankur Arora wrote:
>> The default preemption policy for voluntary preemption under
>> PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
>> class, and lazily for well-behaved, non-idle tasks.
>>
>> This is the same policy as preempt=none, with an eager handling of
>> higher priority scheduling classes.
>
> AFAICS, the meaning of the word 'voluntary' has changed versus the old
> CONFIG_PREEMPT_VOLUNTARY, with this patch.
>
> So the word voluntary does not completely make sense in this context. What is
> VOLUNTARY about choosing a higher scheduling class?
>
> For instance, even in the same scheduling class, there is a notion of higher
> priority, not just between classes. Example, higher RT priority within RT, or
> earlier deadline within EEVDF (formerly CFS).

Agreed. The higher scheduling class line is pretty fuzzy and after the discussion
with Juri, almost non existent: https://lore.kernel.org/lkml/ZeBPXNFkipU9yytp@localhost.localdomain/.

> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
> 'voluntary' business because
> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
> is not about the old voluntary.

What do you think about folding the higher scheduling class preemption logic
into preempt=none? As Juri pointed out, prioritization of at least the leftmost
deadline task needs to be done for correctness.

(That'll get rid of the current preempt=voluntary model, at least until
there's a separate use for it.)

> 2. you are also planning to remove cond_resched()s via this series and leave
> it to the scheduler right?

Yeah, under PREEMPT_AUTO, cond_resched() will /almost/ be not there. Gets
defined to:

static inline int _cond_resched(void)
{
        klp_sched_try_switch();
        return 0;
}

Right now, we need cond_resched() to make timely forward progress while
doing live-patching.

> Or call it preempt=higher, or something? No one is going to understand the
> meaning of voluntary the way it is implied here IMHO.

I don't think there's enough to make it worth adding a new model. For
now I'm tending towards moving the correctness parts to preempt=none and
making preempt=voluntary identical to preempt=none.

Thanks for the review.

--
ankur

