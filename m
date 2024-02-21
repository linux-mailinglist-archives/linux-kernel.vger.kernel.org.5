Return-Path: <linux-kernel+bounces-74163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B934785D09C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC211C21EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360673611B;
	Wed, 21 Feb 2024 06:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l9bpD+7E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A+josgNy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090926AFC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498169; cv=fail; b=i783iOfkapshmEDIQ5qXscysuoDO27IZfNdwYXTprSexvFtpaihDWwHzosag0MN0v1Rl84inQhXgmI/9WGtO0GpqHxTnhBoV3MYpLMJBCLq/eW9Qsbv1N49xrL3H11VVwZ5Atjg3TEwdXW6y9IY4fBoI+mv/1pie/MfniYs5F+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498169; c=relaxed/simple;
	bh=5mv92pJyiGfWCxV6u/ve7yADfUKv+9ir0KIBJfUtbzg=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=McDq9THwfEFKGSDkO9pKfxtOFBmv4W5JaEW1OQ5hQYQLLE1izzywjrNYQJtvoH/A/hZEI1BBYju5xyXfkNIcwTTSX8snascVZnrSZECBaILTzcQK+Nih5n9LgXDpU1/AcAm7On3IEK5nC8Hs0OKVTOdSkXMgNiH7+B8nsfqK/qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l9bpD+7E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A+josgNy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L6cu9J014961;
	Wed, 21 Feb 2024 06:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=lr4p8rzJsGszN2ytcWpBJOSYpJR/8daz4nDhhdUnrwo=;
 b=l9bpD+7Ep/d+/ctpBQE8WsgQd+sB6iFibYLq3z0kTcyl5FW00YZmf8qcXB/yy+tfn8nd
 cWbAuXiRuTiQcbNQsgvC4PoN6PbMB4O+E+lkkF8GgWEHYVVAugswp7hV3hGVl1BjWBlZ
 lG3TpJxkR1CoWP11PVN/7ygLxR9cNxV0oNcoF5AjN/ppsZPZvRDXZ400Y5yYahkCCfWM
 3D6XmIZwp9cCt1iMri+LNQEL7SHTK0ZNGyiCQ2jXAD9orlee2YeOhm1QiPyAQSk8mLGT
 p8hQSbZHhAidfGOGvWrLXLCdTSlovcq2tYU0sk+YEkoQb4Xt+CS0ZMm72HiuIxnmRAm3 6w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud10nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 06:48:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L4h5Ed039694;
	Wed, 21 Feb 2024 06:48:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88h7cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 06:48:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ/1R4P6b3krEfhutGQ5XVFdES+nP8IXT0fq4Ah73t/GW5KpRp3ZbqfWCFvOK1P2iuBlGFp7Bso4n7kFmdNSOmdYXWXV20nKDZ/pXk1dQYjDvLYP4eQBl2aH2ABQSxKRhUjq/vArse2uBjdZ4FVsj5TPfODdBrwArePVx6E/K9AAD5HIPi8IioeLYARYmTXO7+623J3k8XPUNA4ckZ9+Z6QK5VCpKUlLDfKCKwicWUtS/0q+nVNLnyfdCVDkVtJXAbWmNg/rvjRPxzoX2DIMRVODpCmsBhZxToYOsa6CsHVvjQkJbn6AWkZR/5CCQ+KjBQgPuhVDkspx0Vo3IgAlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lr4p8rzJsGszN2ytcWpBJOSYpJR/8daz4nDhhdUnrwo=;
 b=OhXQ542RHJVwqvpi9BlB1lZL5hLHCfT2ZL4w+d2MWYn9kf2BjKqIicnoDwfmAkk/EEiN6U4k3BYVSqj4AdYjxX7yi9X2ojGwWGml97Zi4fwMdkNHtV9NO89b/hBhrXSVNp5JTJjbLUnqJVB7+ANxCL/gLSv4hNEMff5YFWW6VUlYSVvz7k2uzDrHDbYCiF90Kp7ecxr2pCWO4PGRtVLD/CFjIcAq6TkYhTT2NGKcPCCYP6U3bEy329hsxnNeL+jvxX8bN0tiZ7amnLlE95hjzm82CJ07cZNZoCYj/HuuVXn1CujyvsOlgJegQYCUl7POEscHRfF/J3qIgvn+YECFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lr4p8rzJsGszN2ytcWpBJOSYpJR/8daz4nDhhdUnrwo=;
 b=A+josgNyAaXqRxBajpJ7FFCBcjmSPVNwAw6HKj8LmFgF8hNOHrP8+t8IkR9Xl8L4IpFL/fmLGg6cnYS33w1uksLtmpjB4JMPAWdfJFx3O07tKMvoXYWqiCtcewl+3hojuav503VkVrX43nSCKJGJR9jYrm72blegWlMK3C25IY4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7457.namprd10.prod.outlook.com (2603:10b6:610:159::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 06:48:18 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 06:48:18 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
 <871q9dmndg.fsf@oracle.com>
 <9916c73f-510c-47a6-a9b4-ea6b438e82c0@paulmck-laptop>
 <87le7lkzj6.fsf@oracle.com>
 <4bc4ea06-e3e9-4d22-bacf-71cae0ba673d@paulmck-laptop>
 <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
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
In-reply-to: <0be4df28-99be-41a3-9e24-2b7cfc740b4a@paulmck-laptop>
Message-ID: <87a5nugvna.fsf@oracle.com>
Date: Tue, 20 Feb 2024 22:48:41 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0365.namprd04.prod.outlook.com
 (2603:10b6:303:81::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3382b5-44d7-4dc9-2b57-08dc32a9164d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ods1+ZAdqRqnPJXhFxD+lH4JsR/jnecl/2yeDCaChrlPgTbpg/rRp4Wse75RgAB1cATJ7MILwaLkgFB0tx5TI4qAGBEWxJ9L04czAtUQx1hig6XLoaF97gYZ223RHUEjnF1zZEx+dO5i4O5pMDz0XmvGm934KhSENo5fmuQfFFKcGUszPgAzwe2VENOdqOedoYEOdWLrB8iuBmXkeKNMHV1avH0lf8lU8ed8HfnxRYwiQ774U7OO/H6wY6TBgH7p5BixJL72T6X2sZM51eg5tTJ6YsfD2i4OiiF+rpQIFjeE6opUp2mpZGkiMNgIYzPtJuPXT4/Rq1pJ9jjRx/OwDQzYyEQRByLLJLLeRmSnQV/KO2K4nMUn98Jzw+2IOr0xDJ8PiImLEWiSibHLTtXhb1HRGAO/6D1UdNhypGaj0g9bIH+zch97+fDkFKpK9mBensDu2XVuJdbKFyqbHroW1eMCB9z+j0RG9gF/0NcWGdGo0JstCj5i3C8BsqqGkbiOnn3ujpiC/0ZQ3vT7jHvNDY5T/a3jlj5+0NrjqcvZH2cssrey8uP4MlcgYSEd08OZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y+AtGUVJBCPg01knTMH46BfLS+rwtyLD8t6hPDyIRUt/5wey2RQgr0pOrnqW?=
 =?us-ascii?Q?DVXIdPnprVNJsdcyFz3x/neDBWLwmffibD34zZHL06AvtWHpK1p1qc67ahE1?=
 =?us-ascii?Q?x3aJEh4nDTLyfuqqMcCovKjnWormekjB/Le/f5GXZtoT+aZwYc3jXqmJU41o?=
 =?us-ascii?Q?RWMD3G/CkEUoyZjqANHPaFV1eD8VTlehVKHKBeUvDx+XACKMuSRzMMkJM6LS?=
 =?us-ascii?Q?xjW0rhkymVhXAFnR5ovjYU+8JbJjp4Ik6AqNdqQktRhZfRsSsanS0COHXNBD?=
 =?us-ascii?Q?dFmHr9kWMXeQoLQQBKA11s2eaNyrhX3OWzalqsDAvIAOuUWH5To8M2Pn7OOI?=
 =?us-ascii?Q?AyIGdYFRGvIFRB5RFtO3uY/De8JZyEp6N91ZKdauHuCu3yl2hc31BBhdi+Gj?=
 =?us-ascii?Q?Fw5ZGv42eTT9RE3LznMTEFy5bpqxdyzUZlRUHXPgS5uewyHfBXNCjlpr9PPe?=
 =?us-ascii?Q?DBZ4OZfIY6htWLLpA7Sy3LzmE4o7+nyMiMXmhtUjw7s4BwuoVE8hl7bvT//p?=
 =?us-ascii?Q?ZR8YsVaWv8m1mD15mWZThFf0JoVCxd0zHkL8BfXWe9u7H2TQf1u72R2tdLrW?=
 =?us-ascii?Q?ZaVyA68z4P/Q+9LAvpl7zY1DiLbA7MkyxAoJHnvMKayLxPhrnZr9IHQoNX6E?=
 =?us-ascii?Q?k7Zehmy3rfgWAjIvcKyiiqxpfXgjzjT7F9v1tGNUV5OwHpVkLH1BUyVBSXqb?=
 =?us-ascii?Q?9pyVbJtk/s3vQY1wxKCIpMvo+QROxMx2bORnXiGxX6TRuZE3zKLnRQCwWCxT?=
 =?us-ascii?Q?9FotxxkN/M71J5V/5HmQaqDug7RYOlhxd0Bmmv3l3H1P3HSjH0q2K9OMOpDV?=
 =?us-ascii?Q?BySBCxP+6kRXcubbbq6DwBmE+E430va461plWI8nFzuRCO7dn70YX9irp6rP?=
 =?us-ascii?Q?Lb6TU3sZ83hB5G4hpcVMF22cKBaycvIqISC3ucfPd3YTj1Ofb8+zCOsaFl2w?=
 =?us-ascii?Q?4yZ1SYsPQRv/gqHXqYKy0gNbhxXTyZ8MBnqS3YQH0428+ykpqgHQT6GThxod?=
 =?us-ascii?Q?AEW0//pi5wmj/mqmQtm1RXdcl5jLy6AuY87lXAztjHhmkUIlghDqtxpGYcnL?=
 =?us-ascii?Q?J7EeJLj+ZZIAaP64cr1718UCcjGFvveTQ9Lk68RA8JAGsSU9tv0KkRVeYFYz?=
 =?us-ascii?Q?M3oqVKvbCqoAR2VbPtfcYdsJbFWGtYQok1CNdTj9bSlN6x9V66EvlwYxFVA5?=
 =?us-ascii?Q?IElYJ4bDrh15cxwf2jp1xS2551n4VaUH9MwtR4Ghp4m5nfgRQIb5LDCusvH+?=
 =?us-ascii?Q?+Ugb1WxGKapwGcntkgZw3hZGlQio4L7mLvAWJTk2v02LOxMtnfxDH98uf0qN?=
 =?us-ascii?Q?ie6wn4E0sHAiYUOhIYU2exvLSe2tdaZxMYhs8yA/j0FaEH+egbIzvtJ88YfO?=
 =?us-ascii?Q?WpO1piOMSZDzWyQVbBv6xsWu1wi0MgraNa6oM8+aRcEf/fBCQu6jGi1ssGfX?=
 =?us-ascii?Q?/ysn/fp9lNQHA3eDrHKJ7JFDz0MwzyNNQOnQNElVtTMjCUSrOb1oAzNQXVBg?=
 =?us-ascii?Q?9ir3fcr1W9OlFpArOs+DNUROToRCJ00R3za1Wu24asnDMjPEwXdmvyFfg1wo?=
 =?us-ascii?Q?44h2LomGo7W0r+oPX7TLIcy5/aI89Vo3oYMk3EZZrI96QyXkNlbgUPBILcB7?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iGXgTuxgRTlUMmOSbvFo3TQwZ9dfmmyOtrlsfL7NDz+/xzlc6IRTdO+ZC/ameWWb+FNVMpJZ3wSuR3p548x8TeypqjIyavrJBFkd2+kra1kdx2XjMiVcaxOSkL0yzRZBOFU3D6WUN7BC/Frf5HMdlj3FIal6b8/D0bdAU0KaR0tYPaI/WHbH2QCFXpA4DrSYkfneoyXsFjpNReuHr0NMsAgbAGAlfnkPuGKWViQLtAb3Lud9OteyABT1l95mpmSILXkCdqaJESoyxMGsBg6irqxP+fY8YaMghxmPhwz7ulxnpNjs9YLfSTWd0oiAZsk5PAqW5yKavhX6xWY95lCegPuaEuETXKv7GHKrQ3YHUM7hgQlXSOTRKTYDLa9MPCiJPuXazd0ti31Farl2cBkuK44Lao0vub2oGtesYzcbv5FRT4OyeuTTdL7dJyMDBMIoYAMDW5V/RGeJLXA71Xtc8VFGaw1mU23cfSqYxFLidl2D74OqUqJs/2QM+bTlygvDODYd115YGm7UPR0lBnsU9f3wQf64HY4cLXoZ6s/zTK74cHMiJcFGEycSszFvrihI0xJ5qfffruxZt45VdpwSrUxkiblLBkv9ie2Tk5a8WtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3382b5-44d7-4dc9-2b57-08dc32a9164d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:48:18.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96VKanDiUsqK12XPIlnANlRVlgIi3luJRR2wucUMVQ1Pm0+WCWybi0tK9OB6VwLIEGD/GIQqyfN0aaHdXaXCA94LLECpi6vK2AiMhxjGQ3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210051
X-Proofpoint-GUID: 7ZV_Kw4YX2l1M5udenyaSbdsKWXbvvLk
X-Proofpoint-ORIG-GUID: 7ZV_Kw4YX2l1M5udenyaSbdsKWXbvvLk


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Feb 15, 2024 at 06:59:25PM -0800, Paul E. McKenney wrote:
>> On Thu, Feb 15, 2024 at 04:45:17PM -0800, Ankur Arora wrote:
>> >
>> > Paul E. McKenney <paulmck@kernel.org> writes:
>> >
>> > > On Thu, Feb 15, 2024 at 01:24:59PM -0800, Ankur Arora wrote:
>> > >>
>> > >> Paul E. McKenney <paulmck@kernel.org> writes:
>> > >>
>> > >> > On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
>> > >> >> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
>> > >> >> >
>> > >> >> > Paul E. McKenney <paulmck@kernel.org> writes:
>> > >> >> >
>> > >> >> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> > >> >> > >> Hi,
>> > >> >> > >>
>> > >> >> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
>> > >> >> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> > >> >> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> > >> >> > >> on explicit preemption points for the voluntary models.
>> > >> >> > >>
>> > >> >> > >> The series is based on Thomas' original proposal which he outlined
>> > >> >> > >> in [1], [2] and in his PoC [3].
>> > >> >> > >>
>> > >> >> > >> An earlier RFC version is at [4].
>> > >> >> > >
>> > >> >> > > This uncovered a couple of latent bugs in RCU due to its having been
>> > >> >> > > a good long time since anyone built a !SMP preemptible kernel with
>> > >> >> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
>> > >> >> > > likely for the merge window after next, but let me know if you need
>> > >> >> > > them sooner.
>> > >> >> >
>> > >> >> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
>> > >> >> > But, the attached diff should tide me over until the fixes are in.
>> > >> >>
>> > >> >> That was indeed my guess.  ;-)
>> > >> >>
>> > >> >> > > I am also seeing OOM conditions during rcutorture testing of callback
>> > >> >> > > flooding, but I am still looking into this.
>> > >> >> >
>> > >> >> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
>> > >> >>
>> > >> >> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
>> > >> >> two of them thus far.  I am running a longer test to see if this might
>> > >> >> be just luck.  If not, I look to see what rcutorture scenarios TREE10
>> > >> >> and TRACE01 have in common.
>> > >> >
>> > >> > And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
>> > >> > sets them apart.  I also hit a grace-period hang in TREE04, which does
>> > >> > CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
>> > >> > to dig into more.
>> > >>
>> > >> So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
>> > >> if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
>> > >> as well?
>> > >> (Just in the interest of minimizing configurations.)
>> > >
>> > > I would be happy to, but in the spirit of full disclosure...
>> > >
>> > > First, I have seen that failure only once, which is not enough to
>> > > conclude that it has much to do with TREE04.  It might simply be low
>> > > probability, so that TREE04 simply was unlucky enough to hit it first.
>> > > In contrast, I have sufficient data to be reasonably confident that the
>> > > callback-flooding OOMs really do have something to do with the TRACE01 and
>> > > TREE10 scenarios, even though I am not yet seeing what these two scenarios
>> > > have in common that they don't also have in common with other scenarios.
>> > > But what is life without a bit of mystery?  ;-)
>> >
>> > :).
>> >
>> > > Second, please see the attached tarball, which contains .csv files showing
>> > > Kconfig options and kernel boot parameters for the various torture tests.
>> > > The portions of the filenames preceding the "config.csv" correspond to
>> > > the directories in tools/testing/selftests/rcutorture/configs.
>> >
>> > So, at least some of the HZ_FULL=y tests don't run into problems.
>> >
>> > > Third, there are additional scenarios hand-crafted by the script at
>> > > tools/testing/selftests/rcutorture/bin/torture.sh.  Thus far, none of
>> > > them have triggered, other than via the newly increased difficulty
>> > > of configurating a tracing-free kernel with which to test, but they
>> > > can still be useful in ruling out particular Kconfig options or kernel
>> > > boot parameters being related to a given issue.
>> > >
>> > > But please do take a look at the .csv files and let me know what
>> > > adjustments would be appropriate given the failure information.
>> >
>> > Nothing stands out just yet. Let me start a run here and see if
>> > that gives me some ideas.
>>
>> Sounds good, thank you!
>>
>> > I'm guessing the splats don't give any useful information or
>> > you would have attached them ;).
>>
>> My plan is to extract what can be extracted from the overnight run
>> that I just started.  Just in case the fixes have any effect on things,
>> unlikely though that might be given those fixes and the runs that failed.
>
> And I only got no failures from either TREE10 or TRACE01 on last night's
> run.  I merged your series on top of v6.8-rc4 with the -rcu tree's
> dev branch, the latter to get the RCU fixes.  But this means that last
> night's results are not really comparable to earlier results.

Not sure if you saw any othe instances of this since, but a couple of
things I tbelatedly noticed below.

[ ...  ]

> [ 3459.733109] ------------[ cut here ]------------
> [ 3459.734165] rcutorture_oom_notify invoked upon OOM during forward-progress testing.
> [ 3459.735828] WARNING: CPU: 0 PID: 43 at kernel/rcu/rcutorture.c:2874 rcutorture_oom_notify+0x3e/0x1d0
>
> 	Now something bad happened.  RCU was unable to keep up with the
> 	callback flood.  Given that users can create callback floods
> 	with close(open()) loops, this is not good.
>
> [ 3459.737761] Modules linked in:
> [ 3459.738408] CPU: 0 PID: 43 Comm: rcu_torture_fwd Not tainted 6.8.0-rc4-00096-g40c2642e6f24 #8252
> [ 3459.740295] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [ 3459.742651] RIP: 0010:rcutorture_oom_notify+0x3e/0x1d0
> [ 3459.743821] Code: e8 37 48 c2 00 48 8b 1d f8 b4 dc 01 48 85 db 0f 84 80 01 00 00 90 48 c7 c6 40 f5 e0 92 48 c7 c7 10 52 23 93 e8 d3 b9 f9 ff 90 <0f> 0b 90 90 8b 35 f8 c0 66 01 85 f6 7e 40 45 31 ed 4d 63 e5 41 83
> [ 3459.747935] RSP: 0018:ffffabbb0015bb30 EFLAGS: 00010282
> [ 3459.749061] RAX: 0000000000000000 RBX: ffff9485812ae000 RCX: 00000000ffffdfff
> [ 3459.750601] RDX: 0000000000000000 RSI: 00000000ffffffea RDI: 0000000000000001
> [ 3459.752026] RBP: ffffabbb0015bb98 R08: ffffffff93539388 R09: 00000000ffffdfff
> [ 3459.753616] R10: ffffffff934593a0 R11: ffffffff935093a0 R12: 0000000000000000
> [ 3459.755134] R13: ffffabbb0015bb98 R14: ffffffff93547da0 R15: 00000000ffffffff
> [ 3459.756695] FS:  0000000000000000(0000) GS:ffffffff9344f000(0000) knlGS:0000000000000000
> [ 3459.758443] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3459.759672] CR2: 0000000000600298 CR3: 0000000001958000 CR4: 00000000000006f0
> [ 3459.761253] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 3459.762748] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 3459.764472] Call Trace:
> [ 3459.765003]  <TASK>
> [ 3459.765483]  ? __warn+0x61/0xe0
> [ 3459.766176]  ? rcutorture_oom_notify+0x3e/0x1d0
> [ 3459.767154]  ? report_bug+0x174/0x180
> [ 3459.767942]  ? handle_bug+0x3d/0x70
> [ 3459.768715]  ? exc_invalid_op+0x18/0x70
> [ 3459.769561]  ? asm_exc_invalid_op+0x1a/0x20
> [ 3459.770494]  ? rcutorture_oom_notify+0x3e/0x1d0
> [ 3459.771501]  blocking_notifier_call_chain+0x5c/0x80
> [ 3459.772553]  out_of_memory+0x236/0x4b0
> [ 3459.773365]  __alloc_pages+0x9ca/0xb10
> [ 3459.774233]  ? set_next_entity+0x8b/0x150
> [ 3459.775107]  new_slab+0x382/0x430
> [ 3459.776454]  ___slab_alloc+0x23c/0x8c0
> [ 3459.777315]  ? preempt_schedule_irq+0x32/0x50
> [ 3459.778319]  ? rcu_torture_fwd_prog+0x6bf/0x970
> [ 3459.779291]  ? rcu_torture_fwd_prog+0x6bf/0x970
> [ 3459.780264]  ? rcu_torture_fwd_prog+0x6bf/0x970
> [ 3459.781244]  kmalloc_trace+0x179/0x1a0
> [ 3459.784651]  rcu_torture_fwd_prog+0x6bf/0x970
> [ 3459.785529]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
> [ 3459.786617]  ? kthread+0xc3/0xf0
> [ 3459.787352]  ? __pfx_rcu_torture_fwd_prog+0x10/0x10
> [ 3459.788417]  kthread+0xc3/0xf0
> [ 3459.789101]  ? __pfx_kthread+0x10/0x10
> [ 3459.789906]  ret_from_fork+0x2f/0x50
> [ 3459.790708]  ? __pfx_kthread+0x10/0x10
> [ 3459.791523]  ret_from_fork_asm+0x1a/0x30
> [ 3459.792359]  </TASK>
> [ 3459.792835] ---[ end trace 0000000000000000 ]---
>
> 	Standard rcutorture stack trace for this failure mode.

I see a preempt_schedule_irq() in the stack. So, I guess that at some
point current (the task responsible for the callback flood?) was marked
for lazy scheduling, did not schedule out, and then was eagerly
preempted out at the next tick.

> [ 3459.793849] rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 913 jiffies): 1s/10: 0:1 2s/10: 719677:32517 3s/10: 646965:0
>
> 	So the whole thing lasted less than a second (913 jiffies).
> 	Each element of the histogram is 100 milliseconds worth.  Nothing
> 	came through during the first 100 ms (not surprising), and one
> 	grace period elapsed (also not surprising).  A lot of callbacks
> 	came through in the second 100 ms (also not surprising), but there
> 	were some tens of thousand grace periods (extremely surprising).
> 	The third 100 ms got a lot of callbacks but no grace periods
> 	(not surprising).
>
> 	Huh.  This started at t=3458.877155 and we got the OOM at
> 	t=3459.733109, which roughly matches the reported time.
>
> [ 3459.796413] rcu: rcu_fwd_progress_check: GP age 737 jiffies
>
> 	The callback flood does seem to have stalled grace periods,
> 	though not by all *that* much.
>
> [ 3459.799402] rcu: rcu_preempt: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 0 delta ->gp_start 740 ->gp_activity 0 ->gp_req_activity 747 ->gp_wake_time 68 ->gp_wake_seq 5535689 ->gp_seq 5535689 ->gp_seq_needed 5535696 ->gp_max 713 ->gp_flags 0x0
>
> 	The RCU grace-period kthread is in its loop looking for
> 	quiescent states, and is executing normally ("->gp_activity 0",
> 	as opposed to some huge number indicating that the kthread was
> 	never awakened).
>
> [ 3459.804267] rcu:     rcu_node 0:0 ->gp_seq 5535689 ->gp_seq_needed 5535696 ->qsmask 0x0 ...G ->n_boosts 0
>
> 	The "->qsmask 0x0" says that all CPUs have provided a quiescent
> 	state, but the "G" indicates that the normal grace period is
> 	blocked by some task preempted within an RCU read-side critical
> 	section.  This output is strange because a 56-CPU scenario should
> 	have considerably more output.
>
> 	Plus this means that this cannot possibly be TREE10 because that
> 	scenario is non-preemptible, so there cannot be grace periods
> 	waiting for quiescent states on anything but CPUs.

Might be missing the point, but with CONFIG_PREEMPT_NONE, you could
be preempted if you exceed your time quanta by more than one tick.
Though that of course needs the task to not be in the read-side critical
section.

Thanks

--
ankur

