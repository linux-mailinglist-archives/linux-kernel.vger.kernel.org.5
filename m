Return-Path: <linux-kernel+bounces-160592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5378B3FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EA61F228CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532BB2137E;
	Fri, 26 Apr 2024 19:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Td7uQ8Qq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H9at1RrP"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE9B208AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714158116; cv=fail; b=vEiSIK9LEbgY8PdJv2xm4IUZj0gAwQIkIVuGYPYYnXQjgKkHu+kXGCvWa0W7YI16TNdAWvuw4SbFkHgOtroUDxk42Q0JBijQyS9xrTl4GBIOd0ymei6fR1O/m8b9o4oMh5yNtryWM1xv2mafFhnHKdjcW65n8kkAiXkhPG7UIpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714158116; c=relaxed/simple;
	bh=FFDocaTB/cwgE01sSGZT0ls1SY99F68jfzBOk6TtLF0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=hjR4Fx9ChP3WNS5b2/UfD7r/mOzprpfTFBHgbmWyk/fovVlTMntl/YyWmeufg9GWObVYj70jdnaOUIGsWbmr9V0ttZp2G35WkKtZ6Q+VK0pJ2h/c6YRlbS7ncXTn7C4X7Lw7NL52+O75LBJOk8NZjmblTxw1Z6KA9KXPFrgv9Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Td7uQ8Qq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H9at1RrP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QIaE46011781;
	Fri, 26 Apr 2024 19:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=JkRVARqCe4X/dctOe4tScCN1hMYMAavlEI9+JUGlVuM=;
 b=Td7uQ8QqL17m3mvPWxAZN3W2H0m9cLG0sgRZKpHJKTIoEgnOpq1y5MlnZ2Y2afOsEBc7
 3d6hT3ZjOPYamx09sQGoFLY62yLMN3I0jkw3r62pcKrbdeOX7fp5yqVb/RRevK7hTyne
 k55sUCngHIIZe50vo+1PtJF0UogFPIu7uKnB+xYf0Z7CRN0klOUAz+gL1wEhFkNQ7FJt
 gi99wD7ZmTf4G8/ujd73PbTAsf9018tdxbJ+sqFsP26MHAUODS+I7a49aDLGdJ49x0+l
 0WNe5yWlKOQ1R1hn5KrHmau0dWNnVz0TbFdwEuaC23rVba81oLLECS0LcIGb4k7nDuX5 IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbxfx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 19:00:08 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QIqmAg019824;
	Fri, 26 Apr 2024 19:00:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf818b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 19:00:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqr63s7uBS6iSru0O6rCQwIgXAnsN/oyC1Fu++Y939RcjzfW/lEbWszuPS7OgTwQE2DvMsgb8Fa1B1/qAvTObYTVxHIRnC9yA7SDRheKay8mxNaFar79QnBs9ZjrB3EWe6FE+XpxBoaJ9eFR2gr7NnsgVtRhoqhb4Al7PWVu6B0NHdlJ2Y9jCMpzvgn4IeLgpFx7+dSAwtJGotYeqdnZbC5r808MCXGUigiNGnr6PjEiRxLCMQ/4nCVONY745iZEtpwRWMquBnkLFKewKrbokD7amOPyk5hgD5QTpl9czB4KFRjZwDxaYLSaQfAOXW2D2Bvaqv5GBEELv4B++IJe9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkRVARqCe4X/dctOe4tScCN1hMYMAavlEI9+JUGlVuM=;
 b=HXYg3KhtJwl3T6viOSH/PXbKChPduwzlGjUtCB8mPqlZrzf65S2RqBsO2Jugm27hO95goNZmAPHm89PaUigGUbqueDZsJHzVHORrSDQ7BX4EJDKITIa70aHg2cJSLZ6q/MK7Bk8c89OBCnGVo103k3NVBuWaI2SRy1Io2L9jY3SBv5DKc08f1WgbQ30l5cP4S8k8CCqgN6kXrxcnKuvFo8sqsdAXQ6Wd0x/AWj5+7dQfFDyaVAyCYYtkBUfEHSSu0gwELNIFvVZp6vlena0vbSeMOiqnqHx6Pfhaj6EFsVaz4iBseOxVhSIefObYvkn+5KewayeDb/QZYcdq6tbi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkRVARqCe4X/dctOe4tScCN1hMYMAavlEI9+JUGlVuM=;
 b=H9at1RrPK2znzVaRM7C9lSUhWKSGqt7u4XJfWt3DVGrUb/eD8D/7M9YJ8zyAA/t8MdyVYwuNzV2fMM7JG89LKPR22+KVcPBGhi4/jJfnFSair0fKoitu73n7fbmJhWSk3WIe538BB8BHPMniSS6iO6cRV5FC0Y9saQzi3ybRp0A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA0PR10MB7604.namprd10.prod.outlook.com (2603:10b6:208:48f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 19:00:02 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 19:00:02 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
 <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
 <63314d92-9226-4005-a166-37c8648c5351@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora
 <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML
 <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <63314d92-9226-4005-a166-37c8648c5351@linux.ibm.com>
Date: Fri, 26 Apr 2024 12:00:00 -0700
Message-ID: <87r0esc5lb.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:208:160::47) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA0PR10MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c717ee1-c642-420e-c805-08dc662313f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vqsapUXvvFs6wPWdti5vMse9Km6ez6iQpIQlb4mD9GDcHn3HZnYmSuoGAApI?=
 =?us-ascii?Q?I1JjueUJWZXDzUI7lBuv6PbKQKE4Kn23CO9z9gydinesR1FQ/0l0q49vXIcz?=
 =?us-ascii?Q?FgO0ZxxBzgquqA9t3ur3VPGpC51NFx5kd1OAFuL1DZG1o5spx3GqYkHn3pJ0?=
 =?us-ascii?Q?BRFd+EJULaZvQwVt31vXlY9rRtplo0w8cSX9mRSOTiEOGgqrNtUc0cplyF9E?=
 =?us-ascii?Q?BZcf3DohTf2irmmnS30gss63+gMDKole0HjwPsp9XP8H//+r6YF0m8a8yQwc?=
 =?us-ascii?Q?zUaWW3nj5h2393mNDvGeIAaXK9WJIZ+oP/dMxMwUC3QXM1/cz2Czb5IuACOi?=
 =?us-ascii?Q?9F1l88VFwYav2IkvUxvwowZHqndpqa7JLOX5nteQM8D2hK0VyZHRHo3cdky2?=
 =?us-ascii?Q?zuaDKQReOjHJW/ru8NacO2ay9A28qeZ+dbAJo6l2nLuf7gaOYnZJEE6OO9UB?=
 =?us-ascii?Q?N2upRuWg2QL3VctS0l6tu2tFh64zO/TTy4qCtVyoSvNDzN1xAM5rS2V/Jt3G?=
 =?us-ascii?Q?EAY0DegDlO6y2dNoWaaIC6H5GXJc+rOVPApe83JCPNItSe5F7PJrZINWvHwG?=
 =?us-ascii?Q?RF5VyrEF632Wn/Yvy07prJCtwQbXTg1QGu/Z54HK9OcjazDFV1gYvlSUmsJB?=
 =?us-ascii?Q?0llHGkxmJ/vfxc1MXMwAmQvXVbF5lTNLEcXY9+0bXTP1jDg10Gi1PrUJeCic?=
 =?us-ascii?Q?Pz6a7Jw2qsJTX3RI/s0sU4d1SzIxFflBo8NN1K0eRignV8lMjwBXfi0bdZOz?=
 =?us-ascii?Q?GdYU11E3ar8OSev1Gq1aDgZj5p0mUvPyMYautMfECxe+yS5AQ3PrmI/0rDUz?=
 =?us-ascii?Q?f02s9+4GBgG5AZDYNFT1Ks1LIqwkqH+Kd1qQWjsCb4y9IIO+8GSKpjSzoIWl?=
 =?us-ascii?Q?L/W6vNgrY592YLlOcvwJLLOUZIscE7Rs+4wSHEDKdIYV+4EMqoZ7u+q8ewLw?=
 =?us-ascii?Q?niPONouBwkCWmR4YsXZjeOuoG5lTwf3AnrYuhEyJXqky0Sv2qLGJ+EwFX8sc?=
 =?us-ascii?Q?hUQ4s19EX+NpQU3M8RVQ/xPKqpdCF0jPhenDFQG/Jc219sWwQG5/D29TETJc?=
 =?us-ascii?Q?b+tAfugNW82g0CTyTbzOnFoKl8WlhksR6sKfQh974sRf15nMzBgEdk19tzDi?=
 =?us-ascii?Q?zhK+NoDrxtzMz8camc3nXudq3XY5TO4q2bx1tfiOPTVNmPNlHNwD6V6huAgI?=
 =?us-ascii?Q?ZqJnEY2Iy6lcroiVmiIR0I1OHk1/QrH+e9Z+PvFCGpwcC/Ls9ej5W5abFYJ5?=
 =?us-ascii?Q?yHHbt8brrqgPjcjhHS7UUaaJKt1zhQrWA0RZkyVJjA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?61dPWyP9hi5nD7KlbVxdVCnL2cobgi91aEwwrYwOUCBMYCdmEY7Pk7dIpeSY?=
 =?us-ascii?Q?I9t4tqhvw93jUjN7tYp72gCQzc3VJ0/ryGS/WIUlJNdl+nQrpmiV7VZrN1Un?=
 =?us-ascii?Q?G25JfZEwW+r3FeLMHv+jUnkp2ssvYNu1nVr/Tf3/YJmoWXaeKYxZdlitjVAg?=
 =?us-ascii?Q?/ZAzBlH2MgI9At9j2Op/bgYge0wKIiN6ZW+bJAX9BLau6hnPxTzF0M3pHtYh?=
 =?us-ascii?Q?pD8MiKKp3n5XmdnARde6u24NId/rbZkmTR/K29Xb/NZ8akHPjNnDpekrBWsu?=
 =?us-ascii?Q?42TIGChWA5zrBQjSKEK16rgREkty56EP2+PeQu3DwnTjxgi6JCcWmpiyfLd5?=
 =?us-ascii?Q?4tSh6qeZ+/VwPP0U26LYXbETR3vFmz8pnQeS1n2EqvCDoLfH1r6UkzVA4ekf?=
 =?us-ascii?Q?xWFY7TLHyN1CEltdPSmePJJf8lI+eEiBxpgkjjjbTE3Rbu3+9rUBFSjewzJh?=
 =?us-ascii?Q?jOM5L6OWKoRDX3ZCOwB0VQgG+0IBv89SUBmFsv/ZEFt+F6JTB+zOyzs/ufqV?=
 =?us-ascii?Q?+3M1N9VbLAB753TF5LRTb0QMSCt6sSp3k+1sysq9cbawTIzKlIg6Voib+t29?=
 =?us-ascii?Q?kuxz9Eetgo0KTx9NMyG7YEGFXsSZG9X/mQ2+CX/+QUy8vlxvc+qwmsEru5vV?=
 =?us-ascii?Q?QXgqU+nYsy8u73JO5Czt2TIbIUQEwsKjsP9QuhIFt3KedHBc0O+dac96hiwr?=
 =?us-ascii?Q?YGzdeGbHi8lNEc/cQv+UBFFdFvPsLhltBTSLNG5DV9kXyqTWTI7CqWae0Epz?=
 =?us-ascii?Q?UIYE2V5zuxGY1nrVpmtfzMPTPImJZAxhXfaYg8hqI5yK08lH5lLrgIVrf6hL?=
 =?us-ascii?Q?Kx9lGEpgBZGiMNzSsydXjO5+O3UI8ljCK0BhwGSjhZy4NUtOnzb94DUNfFI+?=
 =?us-ascii?Q?lpJDXME8wXEJMd40VN9b72bfCViek/NGSPDkVpZOyjUiNSn57khLnueyxNOA?=
 =?us-ascii?Q?G+m3FAQMkFxgeBlg8LxpDUIjKjSMiiptBDgPbeaLXSiPXfw43McEmu3W8i++?=
 =?us-ascii?Q?m7zue+HOfEYa7iBRW7sI6MByi3k2HIL8Yq1tJdKJU8ts5lP6SZrqjIynJLvT?=
 =?us-ascii?Q?HlCtXnecC4kUSnOCiXTlh69xBkCckW8vRgGwCpa5FAH8dSLKwHiHB4bNbAZ8?=
 =?us-ascii?Q?srKb7ECKjw4a6msnbz9Agp8GftUHdEDjFGSHzCnRs4ZNFcVgwk4+IFqBbcyx?=
 =?us-ascii?Q?TPOsEStc0h033FdCxkgIPbrOy8N54/xTgi6PBkm+qN0Nu8U3KuUp6XRV/W8a?=
 =?us-ascii?Q?neX6PTIjK0JZTCymRALQ8OXFsz6Ls4bI/5Thd1h075f+CxcqeK5s3qPRojgq?=
 =?us-ascii?Q?XvLjxdlXrybMjuYdKKPyxf/qkgDweElQOXdrDF9S7EuDfe8j92LcwwRKQAI5?=
 =?us-ascii?Q?8dwEa9uVym56tCcIhfFK7emERvTOSrTFDqlyWUkMM8P7HMcOpw+X9aS2p/Ro?=
 =?us-ascii?Q?DWsgqUfOH9fTUHb5hFq97JadOljk/Th6ISgkyimEQTnMug+Dm/f4Rip8S2ZC?=
 =?us-ascii?Q?ry1eO6feM0lZ+MDOYJETSBC31/4JnKXvYkLglQ6G3prPPCV72CZVOprlVMt4?=
 =?us-ascii?Q?Ff5U9zGO/izwMII6x3IBhoehNf07h7FNbko9Wwh2QJ3h5Fx4nhRD9IDLcU24?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QjmYRpA/wdSpyPFS7rQuz1l9ng5ddzoiOBT0UaCIQpveV+ewPPVuFctzEYoA60Hvr1/CnhaDTyHRghlmEMgly5CGaUS9zcFUNoJw7gvvTBm7RDCN4rCl9uD6e79s+U/KN8jlsXFcSOTv+3UH6TYUPm+vEVPlaxTwKBSABukBXNu2wM/RUEc+wOPJMl8hZ2dFW/oO73jdlBjQJQZLzz7tldp5xdcAsYWBtJEO+lyPn0DcyGNr4iBfDAQVc54uXCCeut2TmKdHhVmyVmx3WJOljlKNj6ser3tZ1JsuFFN4YfVZgfLhwHL5Eo+jQG+XRB53K59MJ2HQYR3lYjM0HAfcZd8x5ZZyneGvlfUMx3u4e2QP0xpATEhlIElmg6RmNyr9dnQxR5J0dei0x010p5QXrz1mfH/Zd6f9L89f7FrJ3qTlLViMf/kTaB1zPxuhTMjG5RQU0r9J2n+GBxJ/2p536B5Cxxnk/MW/ctjkBHg2RiDm1N6o9/V0XdPKAfRsyISi07Y2gxhPs1ayasMQbcKvPTBEZ4Hdpwfknu62PcSw3KPhCiUD+ly4rdsJOaXE1k1oWpJZfUhvr1460WAyaLQTktQJikUmC7oV3w3qwd+uzSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c717ee1-c642-420e-c805-08dc662313f8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 19:00:02.6671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwGyia7VcPF8OypgcOvhAu7WtHjxtYGYFsH5PwdH9ndoZJSyfOQz1CTuC7wvTQcPgOZ2au+VmZtMosvS/1apY+ocz6pwm4R89HQ/dQRA+rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_16,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=887
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260130
X-Proofpoint-GUID: tbvHfBAUQYkv0VElvbMuB4qAYT2L2kjf
X-Proofpoint-ORIG-GUID: tbvHfBAUQYkv0VElvbMuB4qAYT2L2kjf


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 4/23/24 9:43 PM, Linus Torvalds wrote:
>> On Tue, 23 Apr 2024 at 08:23, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>>
>>>
>>> Are these the only arch bits that need to be defined? am I missing something very
>>> basic here? will try to debug this further. Any inputs?
>>
>> I don't think powerpc uses the generic *_exit_to_user_mode() helper
>> functions, so you'll need to also add that logic to the low-level
>> powerpc code.
>>
>> IOW, on x86, with this patch series, patch 06/30 did this:
>>
>> -               if (ti_work & _TIF_NEED_RESCHED)
>> +               if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
>>                         schedule();
>>
>> in kernel/entry/common.c exit_to_user_mode_loop().
>>
>> But that works on x86 because it uses the irqentry_exit_to_user_mode().
>>
>> On PowerPC, I think you need to at least fix up
>>
>>     interrupt_exit_user_prepare_main()
>>
>> similarly (and any other paths like that - I used to know the powerpc
>> code, but that was long long LOOONG ago).
>>
>>                 Linus
>
> Thank you Linus for the pointers. That indeed did the trick.
>
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index eca293794a1e..f0f38bf5cea9 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>         ti_flags = read_thread_flags();
>         while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
>                 local_irq_enable();
> -               if (ti_flags & _TIF_NEED_RESCHED) {
> +               if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY) ) {
>                         schedule();
>                 } else {
>
>
> By adding LAZY checks in interrupt_exit_user_prepare_main, softlockup is no longer seen and
> hackbench results are more or less same on smaller system(96CPUS).

Great. I'm guessing these tests are when running in voluntary preemption
mode (under PREEMPT_AUTO).

If you haven't, could you also try full preemption? There you should see
identical results unless something is horribly wrong.

> However, I still see 20-50%
> regression on the larger system(320 CPUS). I will continue to debug why.

Could you try this patch? This is needed because PREEMPT_AUTO turns on
CONFIG_PREEMPTION, but not CONFIG_PREEMPT:

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index eca293794a1e..599410050f6b 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
                /* Returning to a kernel context with local irqs enabled. */
                WARN_ON_ONCE(!(regs->msr & MSR_EE));
 again:
-               if (IS_ENABLED(CONFIG_PREEMPT)) {
+               if (IS_ENABLED(CONFIG_PREEMPTION)) {
                        /* Return to preemptible kernel context */
                        if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
                                if (preempt_count() == 0)


--
ankur

