Return-Path: <linux-kernel+bounces-73769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FE985CAD7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965061C21687
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F05153BF9;
	Tue, 20 Feb 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j+pFFB6y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f1vlVTXY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2A152DE9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468750; cv=fail; b=KSYQTgu6r5fZiIKNQq11DDCNf+WPgEvphndOfUm27CFcliy68JIWGW2UxSqvLXyZ+qLSdmbVn6q/RJs2nImBfnDnHEkxYFOM+2x90hAhzDkIMg6vcn9FK6Kxr+ier2wI4DtXOxmFDJfH2H2X0bgeexKbI5jUEnSbbKITPebt+j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468750; c=relaxed/simple;
	bh=/f3dj8smH+gbaARNuiV5XnUGMhzFEli/wDBV82dLCNQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ncmGjN21xcbr64LaPqDovbJEkIFib0iDEHY5wTtHqqSM37TbFTPotmnNEAWH98Nrx/WltVKfZ5iTZtm/Uupo1JQ7PDOnrJjAA1EAcysPCk6Er+iMGGkP8qaJ3sCOTWq0Rv+QigwgNXJ7Ts7n2AK8Zm11kjOfvgd9tyXvJKzO/Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j+pFFB6y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=f1vlVTXY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKSoHc029395;
	Tue, 20 Feb 2024 22:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YSxOkd1db72YF8Ddqytaz5UidOh0247XIIfHvOA80E0=;
 b=j+pFFB6yciXt49e+todU5qLCU95UkqMt1de2KogygReS9pVsZ9fQwRRaVPtFFwgZhuTy
 r7u0a9mIuOTtzk3ed/AJW+80x7Mj3uqWswfL72NlmsLC//LKtCkPP1HyTfSjaLzfi19o
 Nv6zpV9OtUaPXsRjJtj5pby4ANujXQYlWvzoshe2mhjhaS9ElRdRLewYqAsNa/NbmXFc
 bgQXUd2UuAF3MqDwWtlvxdhlW5RQV9kGpsMBQM9eLRVfxtA040pciBrdnH6fSPRHzPWI
 WTU27A1KSe7HoSlYlQBYkiCmeXXL/DjiVFnCp+29FY8dveryscZkfMpBu45l1H0XwBrX 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamud0aw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:38:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KMZj5J006578;
	Tue, 20 Feb 2024 22:38:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak889e71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:38:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTfTRLlhmunOPg1ZNuzwKU6+UQknKWUPJp0B1cP28rVcttCuQverwQcNyhhhLOfm5iVsTK2Ktj0zYg7sCgvC9gF6+/b/4zX2HX4PFlyzlNPQ9ywsfzGeTBb62yty6kVQ6CC3lmlwqF+svIZ6+3GVOor/NmYPPaO26NK+GqeRvPGP/GJUBdb6mQP/peJT1KU0df07X+NanbeloP84QdvhmiWPdTrcKSIwzCCdq8MQLXwJQ1rJl76ES7WaqofgEd98ZqWTEXm1k59EWFZqLr7d6si9hlsVOx+wIk0u789AacjcVy/vavELLtXcziicUuvEm0zBqVEpN7XAf4HE0Qrd/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSxOkd1db72YF8Ddqytaz5UidOh0247XIIfHvOA80E0=;
 b=RnT55K5k69SEX8UExt5iab3moaV5ZZGeKiEWQiE56mTprupfgofa8lL+apUUZLm1n318oy0yp50mDyXmUHMQkAgIGCH40oxp3TqU1Iu+lafLouCIDl1Ml4aVk9E2oqfAMwlQM11TaUUn0kEIurZ8oOrEmix+1RPy/N2lw5hFzapMTlZ4tRYyHPhkgt/GV9+bzVCRvQcKd+hqRbjPd4EPQ140VjnL1OB+uDbqcz9ag9TxqvK44opWRtQVCe4PWfJo8lS3t53mQrhcZjq1VdWCSP9t4Zkn0YKyckyPqgCLV8IRZMRTYQD8eH0PNqnTUlnBX600TnXpFWPsNc6XRiAFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSxOkd1db72YF8Ddqytaz5UidOh0247XIIfHvOA80E0=;
 b=f1vlVTXYWabh7YNEF3JsE8PZPtDnv9IC0iGX8FAwepFchPFUB36iKjgrz4DxRVVp0Iql8+kThwJ3dlewoAGcGDl0Dx+mSUlvqWzh3LTm4GE/QTNudSx9hUGlLaTL4I1hgGGjaNWnxH0xzpYLcZXGRYwidsG/C/Ef8ccIC+D88a8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH2PR10MB4325.namprd10.prod.outlook.com (2603:10b6:610:aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Tue, 20 Feb
 2024 22:38:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:38:05 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-7-ankur.a.arora@oracle.com> <87plws8obl.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 06/30] entry: handle lazy rescheduling at user-exit
In-reply-to: <87plws8obl.ffs@tglx>
Date: Tue, 20 Feb 2024 14:38:28 -0800
Message-ID: <87h6i2iwwr.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH2PR10MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0f6f6f-2f7b-445c-2866-08dc32649afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+iE/uahWD8rcFKcDCfxbZfKtciOMAKnhbkW36Z63oFZ2bElyM4aT+NNEy6IUJ8Jrp0kxP3k2nVI0EYj7c8rQPGGfCzf9b83hoc8FmXunVzrcwYZNXBaQodTT3PTFFIZXm6WJECh0xyxQATZP85xDzV8TbOdzBIT7kQPljz1MS8ZXAzPwtU1nPTDDw4+FxW3yHfZJEEXoAaAohvM9sA7n7wwikWDsocChLXrnlugeC42C2u864BNqGf/fp1gzMv7kfkHipqM0IxUfQrUDz74fPK/7XEHn6zQSDtrHLAdRYUvbZYi0+i7B4mAdpfOV6+/O4mk8fTWD/TYPY6Xbl12mdTPtzA8yC3y3jGeFXtHGKS2gh83Yb3McztMWq3fK3RRBIfDXSyArM3W1co/QV1Iu+uC1lmL8W06/hBHQ/fULYzvhAW5VicaAVWDXh+xBGgNnuxUO/sy3vAs36LdAaj41OPIuvXggMcwx2Cit84g85hrsOV1zv5lIpjoYiNN6ZQJtWzCP22G9AlbIkxgrfSnAdnqruq+sXIVM4CaUC9/AmRU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wl4KZ47mNloLa6wDoCms73sb6rQGl52jdydinQIs0lxyXa670pKlcMx7+/b2?=
 =?us-ascii?Q?nrzlQBr9C/ZgruGvOSZMrGV07PHHS8aDAK/BLYEeLnuhZNchmA89X4Ytd5iq?=
 =?us-ascii?Q?n62gK6vBfcaDXjk68vmYsBMrQK4qx8k/ZyPyj+fu3eCGuglWTtIooAvhDhl9?=
 =?us-ascii?Q?Uva/iDJz1srz8fSFm53kusNumulT1TYA8iVPOoCXKn05ULHaLr78AzMYo2XF?=
 =?us-ascii?Q?WwBYsqvR8vHI1cJBPjJ79YL7Fy//O4iYeW9ZAnoB953DVgvKJKjYzLpjupaD?=
 =?us-ascii?Q?oaKfaukRV5sqOJBWqPhCWHmWtgwbY+IPj4r/DZx9aNDUKuGzNWpknG1ouhfC?=
 =?us-ascii?Q?qPbHTjNkLkNfk+gQmD3KXvlgiBXn5fQ+mqpBEbv4Q5l0Ui7DIC/GCFU4jfOV?=
 =?us-ascii?Q?KUZD85B4ukD7CW7HGxjtAiVNnSo62jSxCn0is/dWwCEmkhY3dBjeEFtVzzK/?=
 =?us-ascii?Q?g3zYD9NjyqUEcvJM1vSraDgw5LCcGh+SJBHLiN8CKUIGf5vvHVljgTYJZtrp?=
 =?us-ascii?Q?qwGfXSfBnTHtrnh0t8EIOQFi8TZHBH9iCSnnLyH5ka4t2mZNmLByW7jWHhLZ?=
 =?us-ascii?Q?ql0O8a0vJgIpK/7qMFjBSwuDqJI3cHnuSO9VqaKke1k1taYQh+A3JQq6jXWn?=
 =?us-ascii?Q?CwnrJj0tl7MB/CbcUqNqUveCQDtXQ/HHZrr87Kodc8FxkY7NSO9TdFXl07HY?=
 =?us-ascii?Q?PnwP+A0eJ0r23l91BwmB59w7QAp1QFq7E4OQly+cnpAu4odwvmqvi6vunIPj?=
 =?us-ascii?Q?rMkQCw7YB7bGiMN+defifTYRaE4uRpQX+BJc9dgDjmIE30M8XdtuH3tR+JNr?=
 =?us-ascii?Q?IuWBS0/KYTu4JTNyeLtreWQdzsgYJJvagDE/UGKrgelSgo0PWr//x7sZCf3E?=
 =?us-ascii?Q?AwoDQKBykrCxIcFvQEwCFxVtjB0i/Q0Wmv/mJSlMItbFYTm3xlk+F+a32wKY?=
 =?us-ascii?Q?yNk6hKaS8tpCExYA6VEod8OCglPdu1X6zU8bdw/cUnoZbqXOs4/JyjJvHvco?=
 =?us-ascii?Q?B6OGcjWuo8VQIMLElG8ArNXbcCXfXjt+8r5VLzuWyUVrYglIzlP3wQX9PU4B?=
 =?us-ascii?Q?JIty8T6MfYHEKu20ni64Ugi2Y7dvQn3oL2uNqyEuogNF2g8VMCkUkm+mJr8h?=
 =?us-ascii?Q?SxRl13tLx8dPJ/029fU44D7cA51Cq/rb1Cgfxvzi7InuOrAIDJsrwwFIqJ4/?=
 =?us-ascii?Q?giS25mtV08OO+trQhYiHiBf6hhp72yJJB8Xc3JcKgK7foQV4/bgW33L3Or+W?=
 =?us-ascii?Q?J+xR+sW2q1M7ifKsqWDy+pDR/n19slx/ST64DPMcVbH4FqYD5qz4vlzOarTi?=
 =?us-ascii?Q?rb4dSl/d1bd8l2C2c0Uy9EHmUrStHxdjxIUiKuQfbBTV/2Zmec2O7E4Wy19k?=
 =?us-ascii?Q?fGyl/Gi6WF1S3w6SfgAwS0I5QA3FepgP9cz6pKf/qRWKGdT1i6llqnL+NGhJ?=
 =?us-ascii?Q?gn9PCURjkqJbUDQV/ytGzlchwvc4viOg3Y1ttyi+Bn0Ekzu067S9M2Pm9VOD?=
 =?us-ascii?Q?GMUt2Z4BIClS8oZDWcsbD06xMEckm5EAn9qy8fuob0LOmASaifNgY06RFBKj?=
 =?us-ascii?Q?36c2/a9ulGKV2Ram8qM5/EX1N5RC1s3uGhgTMrv3iVNzJ9h/0yzhhAWiVM90?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fdASf0NRULdNlr2kgCeum1PzqGK3JlqD0oW32zaOPwtmML5R41KckG4ek75hhp7fx+L/5wNHO5ZZyp6rUGyiZH0r6BfZkuFOnCS75eOkEPn/174X+z+kJrC79FyE9EPrp8aKXjBs62vOKUi0VwVfDVK2b/hMi4r6C/TzPf5f3ypUkBGCji+5SH3SgHWkws7Q8QA0kA8OfnSVKrODhmiAnPHLdew2CtaYgHC4/Yvw3mCqVWP7aQgYdHnQbllyin8osH17uUxNDQ3ht6hcPdppjXZ4Kg6iaKyK6QTPSYGelyGcVN1cV6j68B/rCJgIP6JtKqQBTQKzoqWa/dJ+U163OTXmX2zBrKMj5hGDeWhjyfGYXjC6oMZb9mP6I2yMI6E6dQyGV7MjKVOFIZT7SiRuVSSjfP0MgVGoQVJNYesjBiQzEixk5cVTBbS6q1tDobLDMEMSXT8aBW0wFxhknGyPBtIHlJITssoWt4jwCNzZz2LYHUAj0GQe/b6FY8z95lCnemtMyAhzkxLZeyizUMGX7bW9crO+Z/8rV3fW6zQZyNoP4QyXy1FmUCb1ZHBKcVhnp7bFkwcZtma+eS3fYZfI0s2jKTdufnYL0asTX4nOLDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0f6f6f-2f7b-445c-2866-08dc32649afc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:38:05.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snSDbnr7UbGKZqWrnm6KJEX35zZZEleBWw0zM3HJYsziK70D7lDbmFEH/34oey3+FvVY27IEkfs818kGp8hwE466rXBNl89RSWRs366zKTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200163
X-Proofpoint-GUID: RFob0bvrQgV_HaIHust-xtJqylvNRg_9
X-Proofpoint-ORIG-GUID: RFob0bvrQgV_HaIHust-xtJqylvNRg_9


Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>> The scheduling policy for TIF_NEED_RESCHED_LAZY is to allow the
>> running task to voluntarily schedule out, running it to completion.
>>
>> For archs with GENERIC_ENTRY, do this by adding a check in
>
> Please write out architectures. This is not twatter.

Thankfully not! Will fix (this and elsewhere).

>> exit_to_user_mode_loop().
>
> Thanks,
>
>         tglx


--
ankur

