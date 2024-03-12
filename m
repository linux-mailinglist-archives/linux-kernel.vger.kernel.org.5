Return-Path: <linux-kernel+bounces-99841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE835878E28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1521C21C96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9F10A12;
	Tue, 12 Mar 2024 05:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+98UgP/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jm/qLXaq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC65D26D;
	Tue, 12 Mar 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710221117; cv=fail; b=mW4vBq/BfdflKS5YNoIjpQ8zS3r5LiNqaPI47PILTGR8g+0GlgyWa4HD9/fHOpkxvz5oUv+xBfQnEUpQdX0quLqLJyYM2ERFuQRNvLavDZvVL1kVxKYTvBqPZ+9iXCYkI+W7xy710OGUPoEFeVthGZ4LGuaotznGmbyN0OTDyDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710221117; c=relaxed/simple;
	bh=AddB/oTfZytJMVy2Z/oMT13uUIaaIXYL6bmeT0w2f6E=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=ovfy8Q+TRc6LHFyO4zPgvzKAucP3zQchp/fTBE1WkcRXZfmTkcma+gnbdZEU9r0eDheoNy68yffjzlNo2lwKBgdaW21svdSilPiDZtg7jYDaF+Bh1PtV5oymaG1WZQqhH34c95MbdwzSA3oGJC6pP728CpOHpijxfswE54hoxd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+98UgP/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jm/qLXaq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42C0x54I019031;
	Tue, 12 Mar 2024 05:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6rww31wPVauXSetnckvBUDmkR771M9difknIYYD/niU=;
 b=Z+98UgP/627mqMl4BSfD7f+2w/nDwwuyFFSRXqP0snBX3pEy58/BM4mo8AbKB9ByMioD
 /+yZaicmByNW5zrofDrPWccn/ZgbomtgSVwp4LbyFzjGv2mezCGXJ7FhwI2IYbh/UW7a
 u/yTo+iDiNPlsSj+sXce8PBukfit14/IUX61Qrof2IqRPEhKhWUIB8ACRs9C329VPR6N
 G09EsE+HE7h8wJSt/B6hKOZ0a4KFhqWVl+/+1y69FGjQlOZg8zEiBnje2uzVHB56Cz6i
 9F+ZwuWkPCxbjMkXPtRiCcfsFbG7XLZGTrLvpiI6q9tKqW8sLd81BWqYj9sjtTxuR1Z7 og== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wre6ed2e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 05:23:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42C4SsVj019744;
	Tue, 12 Mar 2024 05:23:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wre76qk1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 05:23:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2i2sPntlP679AMRBjScM6Bmtr5cHZBF+8IT8mBDpTO7ZhBRwS9BI/7uMkPOu+SNWubegoUuNTrDH+rwbDmTjnL7qw6yu+xnMCfpus/rvDsh9WSLtLmTPPHBGGEMjuL9qgtbu+LRvNeySwiX65yb8dVMOTj/p3UHtVjH4ERetpzMA2eJS31BQqv/DVdOiMVc33RXHHy++almEhMqWE3O+BK07vMStssMLkQaUcQHSt7zH7L55ZFuZSIBr2GZYPreLv9DoKt8w2QuzMczH+mMPMgqrzlFIKhPqTd+FdL7FGJ//VUh/SO2s6qVlcTACUSppysMCFTeQ1bg+TSrseXGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rww31wPVauXSetnckvBUDmkR771M9difknIYYD/niU=;
 b=KqEwwBCOBoQSjnlfj0lBwO/TBcKbXCxY2mokjz0oliRYRoYskr8Iz1JhQ73qZsqhqXgBSYDOa+jhzDaWt/9wOxjSa0xp7HLHMiOZ5G6ZZQ7nUTxLUPC9S/j8bBntK/rbOCcl/I9S4QXM7gJXcQkXtatrab1a0/6aGNFOi++LQF8jZAM0bUvF52gsw2sczPmokeo+w0iOiAXcPnbonkjG/GgqiMQGWxjWWvsGeUBLUNZslB6+WSrGUmOLGgtRBkmM8gGwGxnwK75PPQPgjYv2l73v8abxu+iUJaa3BMGT/m4+By9ZchpxOrCOydNqaYV1/OKyWnbpscWthMNZ7OqKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rww31wPVauXSetnckvBUDmkR771M9difknIYYD/niU=;
 b=jm/qLXaq4D2ktjtQnSojftXhQJStIXCqHQASc6oFYgsW8Ffm6PmI3F9VEOou1s0GwOQ3slvegf3x+D/PUhZG5GDFCA/x54dRJFwLDU4FMw/ooJC4pjRCoGCi9GxjgFiqZ/6CVGpAhfZMIj0RUmwxuJobtZWbeeMpxUCiPfZrQpc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO6PR10MB5791.namprd10.prod.outlook.com (2603:10b6:303:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 05:22:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 05:22:41 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
 <5b78a338-cb82-4ac4-8004-77a3eb150604@joelfernandes.org>
 <87msr4f8cj.fsf@oracle.com>
 <7a26275f-7ed9-49a8-90ec-798f2f2de195@joelfernandes.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner
 <tglx@linutronix.de>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <7a26275f-7ed9-49a8-90ec-798f2f2de195@joelfernandes.org>
Message-ID: <8734swf2gt.fsf@oracle.com>
Date: Mon, 11 Mar 2024 22:23:14 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0340.namprd04.prod.outlook.com
 (2603:10b6:303:8a::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO6PR10MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 06393d0c-fd7d-4ff6-2a35-08dc42547093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tWHxYpfGQ3a3Wd6lQHzWwfDWowsTO2WJjBGK109Aq1RsSubHIfo2B9TWHODWEx4qHulw2vg9bLVMXw5LHcOf/Ibz0UMXd2wFo2txx0zzXZRgOWQucIijZYleluoAgnaitD2n1IbYFp/qDO5n+m0920YSyHBNOqGg1MChoP9o0XXQ8mzAIPZlpqBPhmbyJfYaoARkhJzUQZsB3jb6uf586QuHY+S6UrlSEXeUiBJ6zIaJsit8UvhmQYDbGxnKThBqTu5XmqRMv9FsWYcjiQ3qWf/s6JMpOLp1ojDWj1eOvi9ATCjWW4bUcUsLGBZpFsbzVEKPmc7pVEM1S//xoJstBG9QY9RISmceYPyGQhNtXYNGqWToG2pZ9UhQLeYr5esD7zgCaWJNIteuLgkobKLHya5Gaognat2ejmSmGJyvuqNWzNBJd5ngn9rW+5aGOqZZshfdmqVizAbIfrka/7vtcc2R2scuDFW8euzyzT2l3fGekD5rIyAVFabtA7nhM7mXJd48e9a27GXPAbwKw0UqXIdqj3YtQWOCWNCHRvyTDDb5EePUZqaApCHp5iO+LdzGjzzMs6isx9ZxSplFn+OKxXCIHQf1sxYJJ6EcUvG2+9w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?gmwoXWpIKxtxmqnFmlqRegxcXhnM7RzMx8iFmsSHaqzIGUx2Z9+rlqk4OWOO?=
 =?us-ascii?Q?Oklv2X158q+0EN73EmtGxcKkTWtYcpAEzSkExzbc6kUAN5AwIjNI1pYfWVlv?=
 =?us-ascii?Q?6VmlsoD8cSvIHqf0A0T4W5o1lGCeFABJg+qYo1dqlw3iXsyeetzA+dHtsnU2?=
 =?us-ascii?Q?/zQa1dCVdPt/sS/OPLcBT9PcSUb1q9uTQ9cqXDAoxvmmWdPoiB2619Dg7oIF?=
 =?us-ascii?Q?jjjwsKKbR6x3KSzZPiz+F6e6F1us9p9/dn2Kq996jL3NuwF3C5dQZ649GUeo?=
 =?us-ascii?Q?0ACEwRDrTzlyL8GlyEi6tIgYRS6Uigj8NYX4Q/LFRPo/4fC+dyRDDZdrh0sw?=
 =?us-ascii?Q?+2zHl7HIxn1IEAj+LceJfMyZVe7X6saozPkGoHZMGBvOiUXXr1keFHbqnhDF?=
 =?us-ascii?Q?pBMBBPiBDvRp+NH2IFQL2uqaMBOcfm4dNEoq0erYankxi75NpjbbdMIqlDdg?=
 =?us-ascii?Q?n6ybMmT1pX5LtLM+KANeAVeID/Levz5BcNJ0qz/+Wcw3nzowqwpwQ7i12JlB?=
 =?us-ascii?Q?x7o+rP73fXvLkkiQF/MXuyKvFNmgl7HF4thyY4jHU82LzfucfSp6rI557dse?=
 =?us-ascii?Q?z28T+gKbgkmPCZb4o+6tJFNKXUAXU/7qFZ5DuvE3vc9TDLfUEPSuGp5ZeYqS?=
 =?us-ascii?Q?kxBTWp2wjP+vG95qoe7ir5v4/FtYgDLxjZq+PJKpGXJztVQZLF+35WSnXYeK?=
 =?us-ascii?Q?sxqOGEwCtdRH4BFLwgO1g+M4Tm7Hzm4Pusmxn8fZeSsMiN3ufnRuzMfnbnYu?=
 =?us-ascii?Q?erpiNGz6HpjyoI6ducM7za7mvANT9p6tvIpM6XHjwe/q5jRBJtlgdh+AJ9Ff?=
 =?us-ascii?Q?CzTMKsUXWI0BDxPHWrqK0HoLKYYA8WxHFo3u2tV/9kEhzirOvtLEiIsEOd1C?=
 =?us-ascii?Q?/rLWY6GMyu7nrAj2bq4NF18BPFjIlEkFbrXmDTvwNluEItCT3g5ZXMsqoqB3?=
 =?us-ascii?Q?AE7VjewXhWfJT3R3srRbUJlxe4w2h+2IlFoAUoS2rsRwB5qzpNcV9NpkjaVX?=
 =?us-ascii?Q?TlXV8L31SD1QQxQKMMJfFs9RInFKpqeHByihnu9hWEB80OIwJCqBVo8m3KXV?=
 =?us-ascii?Q?DKmI81KJ+V6IdqbcS3DIVOsBw9q8XcPEYD2vKb86v+brjAzRoTT3cwrNG9n+?=
 =?us-ascii?Q?/6SecG1mY13KN5EV+/bd52Qw7GC6ywU405TiYyzCrp4QoiR0VVgMM4tgjM6Z?=
 =?us-ascii?Q?RFMZUZWDrJxgbIwaXYSir8jOntM7D1jCk2xTRFlZQqrveWC4ccslyImvKPp2?=
 =?us-ascii?Q?CQ5ehjzEAPdJDBf0qRZlx5H87oJSHZoGKg4U58nI2a2e9hWN9RoWRg73vpha?=
 =?us-ascii?Q?mxo/f9YHl6QSX5LH5snCg6WiM8VGjaC4YiYgQ40sSrphay4SK27qAPBREeWR?=
 =?us-ascii?Q?RMS8VK4dVDxPLaUcAcKinmg4on9YRgJTtIvMvkQVKiKdnxdGzUr/iKjpGhdr?=
 =?us-ascii?Q?Olx9Fu6Ud+hIVw0jXD7LxX07plO73Kfk3FSqkEo4maqyVkjvjxrH6bwtX/kR?=
 =?us-ascii?Q?qFgL6ir5isY/+AMID4xokm1DjL3zVQU3oj+6mSohvBdue5IHc09cfLtud55e?=
 =?us-ascii?Q?AQ35668INMPpDPcqMPDgl6qu91mhCo7K6GEYOghEwwe66Y36aW0c07NK5kTV?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L9XNnF1Wu2pbkeZp+G96yeyOpqr6NNt4zF/K7Yev+SmEs/lYSmX6Ixx54xSnvwPWMGgAw6mI/kHXzl6F1X83WC6EyPbpN0lM7c8SnBG53Z541XpQTyYRxKNsrrSYosoDSStrP7+hj9tta5zyTjLX7yC1tEaYn9UTJe6KnjIylrRfzO31i4QEIDPNl+7FuxMy/i3oo72A4Fq03RQZXHpIl34ql5MlCeAXN6/JZ4tIDTf/O6uXcPEoDu1olm/nVD3VOy1y1m7lwgsxCzkubw5gmAAhDGi9fVEXzVPugDKn4+KLBGy2dVRF2nrrtS3P0EbVGbP8rtoDpp9xuFv4q/cgYlOOhOqpi5Gz6x+RqWFGSgBpGREnMhMYEf4iTLkD8I1UIPe2CvDMfWSXROdjz5KZb/vEyfgn9jkUlkl11lLNOx5Zuw3/B7rxG5hMHgd2zs3BlVzJBSL819d36kbogJcE2pHUcWjP88IADt5kgJQBnSpTF/x3eRSK1bACcpNZTp5DO9U2jiNrOKA5baCuDGuHWJLEi+I1sZB8+i9lAbK0wgO8lDOZI8iSvtcH85Ov+SSeetiEDnGPAYCTduTTIwCkYnFdCA754awXmVsOplf9Rf4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06393d0c-fd7d-4ff6-2a35-08dc42547093
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 05:22:41.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETKOgu0thAmwJN6fX278+wqmXMFM0S5wbH64NK3Z1sE4mI5YSDsgv1w2KSLpSu53xyNYC3ffuvNz6Nc3RrmFlYqiFsfKrnCxuFuU8ieNhBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5791
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_04,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403120040
X-Proofpoint-GUID: y-P9Uo27mGl2rF8W52YbwrDAoRvzaOuS
X-Proofpoint-ORIG-GUID: y-P9Uo27mGl2rF8W52YbwrDAoRvzaOuS


Joel Fernandes <joel@joelfernandes.org> writes:

> On 3/11/2024 11:16 PM, Ankur Arora wrote:
>>
>> Joel Fernandes <joel@joelfernandes.org> writes:
>>
>>> Hi, Thomas,
>>> Thanks for your reply! I replied below.
>>>
>>> On 3/11/2024 3:12 PM, Thomas Gleixner wrote:
>>>> On Mon, Mar 11 2024 at 11:25, Joel Fernandes wrote:
>>
>>    [ ... ]
>>
>>>> What's wrong with the combination of PREEMPT_AUTO=y and PREEMPT_RCU=n?
>>>> Paul and me agreed long ago that this needs to be supported.
>>>
>>> There's nothing wrong with it. Its just a bit quirky (again just a point of
>>> view), that for a configuration that causes preemption (similar to
>>> CONFIG_PREEMPT=y), that PREEMPT_RCU can be disabled. After all, again with
>>> CONFIG_PREEMPT=y, PREEMPT_RCU cannot be currently disabled.
>>
>> I think the argument was that PREEMPT_RCU=y is suboptimal for certain
>> workloads, and those configurations might prefer the stronger
>> forward-progress guarantees that PREEMPT_RCU=n provides.
>>
>> See this:
>> https://lore.kernel.org/lkml/73ecce1c-d321-4579-b892-13b1e0a0620a@paulmck-laptop/T/#m6aab5a6fd5f1fd4c3dc9282ce564e64f2fa6cdc3
>>
>> and the surrounding thread.
>
> Thanks for the link. Sorry for any noise due to being late to the party. Based
> on the discussions, I concur with everyone on the goal of getting rid of

No worries. Given the unending context, easy enough to miss.

> CONFIG_PREEMPT_DYNAMIC and the various cond_resched()/might_sleep() things. I'll
> also go look harder at what else we need to get CONFIG_PREEMPT_RCU=y/n working
> with CONFIG_PREEMPT_AUTO=y.

Sounds great. Thanks.

And, please keep the review comments coming.

--
ankur

