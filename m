Return-Path: <linux-kernel+bounces-65939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF385540D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA6D1F21322
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DA355E45;
	Wed, 14 Feb 2024 20:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DciJIhuB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gSZPbsQs"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678618E0C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707942767; cv=fail; b=Gnujm8LSGugxM9N2ROzn3/ysbyRz0/kpahw/OdtrKlla9THe+hn5Mjr1IlnlnAg/i4RCNlaZk+QwCY2ZACC02gWaBHMLp7XrCq+byLZwe4hS9gYKajDgje1fiaxb2Budt6mVaNySxJdqS25nSDm37FwexIRpNQggkw1diSd8/6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707942767; c=relaxed/simple;
	bh=yBKmDPyZ2Q20qAIiBK4jC6z9h1SZJd8q2f612K8Aya0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=XSP31GdnwrTUmI8OrDT3tzow9oawMLUjUMqv4OfOrO4VHULuQ7t1RoPR/yPNeiGf3r5ZCusp0L9szxIL0e/ni7wbOx3KomdATyd6GqwEqBjaz21dWKGD71ZBKUReFH5X3Me6jEgTGW65Q3hvLTDerLXOp3GdLzRCAztBMBFL2g4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DciJIhuB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gSZPbsQs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIOt1l011440;
	Wed, 14 Feb 2024 20:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=TmMbYjwQvy6NMZdHtgK00NG/Jqx4tqhv24HpTs1/PoU=;
 b=DciJIhuBV574ehvg8cU8kyCm4R3B+vcNATjypRlpwrAPUQLHap8hht+FYZlGv2Yg+5oI
 txwJJyblOwR3dht00iXxr7RGqgUs4XGvwIsz7xkO9vymgyt0SFW+X/oWECM+qJUzkwE/
 g/nf+gxRNqSYTgWQOIYu90OTjs9K3rmKUjhpgm+c5RNFEgDRzMIfyOrP8U9bFXxvs9ZS
 LGMWCz8z89OI3faadJM2Fu5UDJ/6DBtISBBTgQnwyaZVygLYv5Nq0IYQpoS+/7yDYlKJ
 7IY3wh5tq16Zf+JUrr5JcmrcDCgjDh9uIaaDKsJuVASPwOO3mgcySdU+aEKwl2PpYsOf 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92s709g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:31:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EJYeEl024589;
	Wed, 14 Feb 2024 20:31:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykfs77v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:31:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hv+Ob3ed5xNZanQTUgXoxERRWi8khWyPvAL0Lsii0c4tc8NUWL5wEffh9y6ukYDMLXWJbNH3YADF7ckAfQSpdrez1EgM23GBGNcRt/U3R+ZAIWEJMH1KUTqYf891H5AG92SdhNJ7MopAs9MWneRYLD/M8lSg6zQJUIt/NDkpegZ87j8tJQgmPzgDULQL3QiFQI4VmnJuIOj1vCRqfLIriFr4Wp+LraaW04gfNW/xNSdCMdU2Z5C2zqz3Tl1zwKJuoPwL8tOx/HgIgGijHuds/9e8NT3YWVgfSa/4JfB7uB9QdnOT1C67zpufJWyw0g38MDcJ4x/yJM/eymV1rgCI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmMbYjwQvy6NMZdHtgK00NG/Jqx4tqhv24HpTs1/PoU=;
 b=aH7TprqiTw4YeoARXIoKVzarETdyBxKKDeU7fFLW+LSMbej3fFys5lfyajJp4ON3lEYNtU/SrA8PKRuZ2CRY8qt2C2654Anv3LDcEdTNKRA7QbFBu5RYFVzA4B/dnZl+nP0C4r2GV7Tksj2ojAA55v27scUL1EDxFt+Q/io+G0EfZior9JGItVUahCFYwj9t2jzhpRZ1cF2Y43ntdaaEG+6RIFD9MmlaQh7/8i8e6pDTeL7Cj7sWtLj/U+3jN6Rlfp33KQ1kdBP8H1WBPgtrOBi5YePIXJHbLW5FzrEHKQmzFTAhMG5JKhPl2cCwbYo33YuYrGdXGAbFYfxIP360RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmMbYjwQvy6NMZdHtgK00NG/Jqx4tqhv24HpTs1/PoU=;
 b=gSZPbsQsiX/GIrhgum6Z9HU5gHaA9vTbiiwHpQt8n/PZYABlQRj5WrGtar9IqaiH9Ls7yPgbp018DQ9cXEjdmPnsKX+tKUQbsI1+OkBvLqv4+PiYkRrkdG2RHmcYPGyPRmYJJNyDbuCvIHfaUZSRE7IRAPzh+iWoDwGl9BY4+JA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6651.namprd10.prod.outlook.com (2603:10b6:510:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 20:31:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 20:31:11 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-18-ankur.a.arora@oracle.com>
 <Zcy_TJt9L0EXcsVM@FVFF77S0Q05N>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, jgross@suse.com,
        andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 17/30] x86/thread_info: define TIF_NEED_RESCHED_LAZY
In-reply-to: <Zcy_TJt9L0EXcsVM@FVFF77S0Q05N>
Date: Wed, 14 Feb 2024 12:31:29 -0800
Message-ID: <874jeardni.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1a7642-0774-44e0-f195-08dc2d9be1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1nC8BLPOSLxNMCYIvBdpLIpgbpsxM8qGQ3BxnNZzpkdIyDytqHE5Vtwa1IMCayRHPe5k+28OVWYhyOq8GfJULp/k1Li1UdoOMWwNKCdZ+CrgRjzTJVqDCyy666GkXGq3APmC7SXS+/CD2Q1mtLQJPhXgu66jpc7wO4mODddGWpVe4X0NGNtl0aqNxDvtdBDS7bkRO6HLP+QqGxBLFJNaC9PR3jZ69POqgljZHLgJUc+WMvVl0ybl8+kZQuMqKbp/3xcTzc8PXNcBVi6e/nknn/17CF/tX5BbQLGPBhDOtI+IK4w4bmdqrSyEYuxZEzUcfyVe3rOLPClfjzvryithFycvoVO/Kim6G2ARv4ogLuLjbbbhLFUF+2Fj5Bkm0D+tNLJPq12N5iRzMnmZlbKh7C+k9WJWHsLjzRL01aJ4m5p36Ti+YAqVuGXGYJsc7OtRchMr1/3muGeS+axbUuPOXI191id8C4C96PiAYs2qCCN/lssBJEjp1BJQGQNLVBCushsMx/MhTSMSV2zYIOuphS+JLH37eDw0T7nFyc8DpYE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(478600001)(6512007)(2616005)(107886003)(41300700001)(2906002)(5660300002)(8936002)(8676002)(6916009)(7406005)(66476007)(7416002)(66556008)(66946007)(4326008)(966005)(6486002)(6666004)(316002)(6506007)(26005)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xhtmRGEaaHl29vQVLE3Md0d1dYQ6FCbRxY35xQKzCQvmcglUUsPbGNKnRb/m?=
 =?us-ascii?Q?Az+Tg32ftKDTtKyRjLxD4WL/fTfro6JlgHkf3c7mrXu3J4SZLj6f/UUWeh6A?=
 =?us-ascii?Q?IUwzv/WpG6bzDlmZ4hLT5vSC+O45Q8867yfCqR15UMiCsl7pTi6bb5m2oQh3?=
 =?us-ascii?Q?zkBr//ZrdoC3L39eg0teByEC7+VuAlqwWRMhqTwkcPPVZr9nieVV8XkZD3tP?=
 =?us-ascii?Q?2zXwh+RcEOQohBO3LumTRb5pteqpfoe+4+0hFlrkdw7pSlXFpN7CoR0Q7GsE?=
 =?us-ascii?Q?EgkGJ4s6Yt8RpgS7KPqt/smMyBW8fPdBMxKtHgR86bjyVWBJzZI5O25czY1U?=
 =?us-ascii?Q?I1zxYobl46UlAzNMjgX5e/WRBLzKtekA3cOTLveDTSjm65kKHo439BGNQwJJ?=
 =?us-ascii?Q?28VS3sRLgP1UFcOOHaxuu0vODEE+BB6FgYlXz9eQLe+zB/0XCkhPG0WmKWP9?=
 =?us-ascii?Q?nk4dGLktO3FsmDeElmwXH8fVE/0ekZiqVa1dUcSuerNebCZy0q5cEHCjw1E+?=
 =?us-ascii?Q?bd8eG192ZFh/c6iDK6xGsDRBehWe0wZ3+qRqN7yAEqWY8TeVHBbPiHirzNBg?=
 =?us-ascii?Q?KVamLfvK6y6sQUiOa4hxifzKz0l2A+WCcAVzwSv4S+7t7BUXZXlu/wzeNdIm?=
 =?us-ascii?Q?ee/c0pV9Ba+spb3UiQbEpdlqEV0W9UXXYRXgNTbCllBfQnGLXj8JK81wRATM?=
 =?us-ascii?Q?mQquf+fUKchna8ZBlgDfgGbXCKM/kN0wsy/Uh2HRSAejF+UBAmqNVjdiIojV?=
 =?us-ascii?Q?SXf5IzV1IlrzS/M2t67O6INrUmXJyVkajkVEeF+n7BHvA66BzakKZ0pMJC5y?=
 =?us-ascii?Q?IwzssD0RESQ34oYElC74twr70oabRWXoWCJmJcF4gH9gTfUQFckMB7FYP3o2?=
 =?us-ascii?Q?qZVAahm5ZCG5BkktEb7m0zUuE/WJBl2HU522Inte8IAninZuyhAatsGYvHKR?=
 =?us-ascii?Q?m52nXEGiv/Nst7swskYkxg6+GYgN0q6ewxjaWRU7N0ajUb3KLrFikziS9zzp?=
 =?us-ascii?Q?5EkQPiuY9EesLY2mJdOFN489Jfkc0WHmQxWZVQ1yW26s3sHVT21N8AMOqLwC?=
 =?us-ascii?Q?t3Se8V4+ghFTsDdEBmVU8zm8VhHlpgEkTa4Vw807HBrDtcLyeBz2p8MErNGM?=
 =?us-ascii?Q?gBSMLyAxOJ7MfvFWHmEQ+OnsD3BjVUDwSn4bP6NrYPVvrJz2iysM1FF5P8Pi?=
 =?us-ascii?Q?09mEQ9y8/KCnJ5xGVnCC3c4i98E7rhwPsnRaq992cXF+NlDyaAR4lMqblQBV?=
 =?us-ascii?Q?LV31OG1gg9UtbVxDI3v1X1ZIgg+kLOTIVkMl/2HoI6Z10L8ehmR1t4klZCbd?=
 =?us-ascii?Q?ytXkSkx7WCf98jAw4qeQBwi8af+C8onukRwPhPbt3QyVTcuSKw4xOAjKrC6j?=
 =?us-ascii?Q?jZ7zp/gqZOGqQIxpBXhZkmclxNMrH99AJH54pZlXX7zP55kjYaAj/Yuv4Q73?=
 =?us-ascii?Q?JiC3E/dsAmSXf9LOOTWTcTK7N5vb11GOEwrqFf6ToxdjffMe1fJUgYfxdc2h?=
 =?us-ascii?Q?4HPYxWv9PkXFMJQt5eWhZ158A/T6RUESBSur7x6f82iU+3uJv1y9IPslH91Y?=
 =?us-ascii?Q?akjJL86xO/oledL2SuV+QIo9TYW3Wbm5SjdcRZ4zqgsdffOVtLiQKj8Yklcv?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0grf7pUvMWiR89MvebGckd0+SU8iLQ+UDwkIlh4U96x+B8z3qYHqAc0Roh6RsUnS7ZnKzNEoBbn0pC7tGqJG9QKZckgR9qxHMNb+L294vQYbZHEeRYV3mP7zz5FnMNAbRSRdM7XnLBPsYj+4AltcNWFKo4Z24uP69jmWTZ2lbgz/j9iX382UAnkRygnFozFCPsWStblAqa/g+RHvALBS0uj2dMCw1bbzV2nMweRvEwzZ+YbDKgKteaEAlqArfnWw+GibEtBKYHXbEXTLjSfeJr+9T75CPHh9+6uoeJcvYbjEcnhcpnqaBP/VbxFGEeOR3Nwo+uxw6mAkBGeAGROKRZecKm4Ilcs019LHYw8DjyCC9pfrPhrhziNBsI3N6iWMt6VfugxwRJ/7RBCbH9InKYKC05XUfEjqrLms2MmmjuDc4WTI77dJmLubNfoFVTU3f5HUmSvY0D0l2bLyASCkUGbqdkjIkwibVtZOH/vjqGa33f5shPPuX/4k81rHXrOJTmwFJqb59mHgmaz9Lhyz+XYBIdflKeA80mviQZ3xGawB+stBern1LOrg6x2CwOiDh/ObOfDLEGIRJgLYSVjeXXH+nPW8a0FABItvqXnrNDI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1a7642-0774-44e0-f195-08dc2d9be1bb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 20:31:11.1821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd05mx3hcOPl2N14s/nlwoBprJ+N64ad+x3MtVNFhro8XfMgAEYU5VSLt1GwvnmX8beRRW6GfiPwBkIjelO3V2+WcMGDFGxXHOCMKGKUD0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140160
X-Proofpoint-GUID: cJf2tgGkl4SnP_7KGSMuQYrD29TtNIxH
X-Proofpoint-ORIG-GUID: cJf2tgGkl4SnP_7KGSMuQYrD29TtNIxH


Mark Rutland <mark.rutland@arm.com> writes:

> Hi Ankur,
>
> On Mon, Feb 12, 2024 at 09:55:41PM -0800, Ankur Arora wrote:
>> Define TIF_NEED_RESCHED_LAZY which, with TIF_NEED_RESCHED provides the
>> scheduler with two kinds of rescheduling intent: TIF_NEED_RESCHED,
>> for the usual rescheduling at the next safe preemption point;
>> TIF_NEED_RESCHED_LAZY expressing an intent to reschedule at some
>> time in the future while allowing the current task to run to
>> completion.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/x86/Kconfig                   |  1 +
>>  arch/x86/include/asm/thread_info.h | 10 ++++++++--
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5edec175b9bf..ab58558068a4 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -275,6 +275,7 @@ config X86
>>  	select HAVE_STATIC_CALL
>>  	select HAVE_STATIC_CALL_INLINE		if HAVE_OBJTOOL
>>  	select HAVE_PREEMPT_DYNAMIC_CALL
>> +	select HAVE_PREEMPT_AUTO
>>  	select HAVE_RSEQ
>>  	select HAVE_RUST			if X86_64
>>  	select HAVE_SYSCALL_TRACEPOINTS
>> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
>> index d63b02940747..88c1802185fc 100644
>> --- a/arch/x86/include/asm/thread_info.h
>> +++ b/arch/x86/include/asm/thread_info.h
>> @@ -81,8 +81,11 @@ struct thread_info {
>>  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
>>  #define TIF_SIGPENDING		2	/* signal pending */
>>  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
>> -#define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
>> -#define TIF_SSBD		5	/* Speculative store bypass disable */
>> +#ifdef CONFIG_PREEMPT_AUTO
>> +#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling */
>> +#endif
>> +#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
>> +#define TIF_SSBD		6	/* Speculative store bypass disable */
>
> It's a bit awkward/ugly to conditionally define the TIF_* bits in arch code,
> and we don't do that for other bits that are only used in some configurations
> (e.g. TIF_UPROBE). That's not just for aesthetics -- for example, on arm64 we
> try to keep the TIF_WORK_MASK bits contiguous, which is difficult if a bit in
> the middle doesn't exist in some configurations.

That's useful to know. And, I think you are right about the
ugliness of this.

> Is it painful to organise the common code so that arch code can define
> TIF_NEED_RESCHED_LAZY regardless of whether CONFIG_PREEMPT_AUTO is selected?

So, the original reason I did it this way was because I wanted to have
zero performance impact on !CONFIG_PREEMPT_AUTO configurations whether
TIF_NEED_RESCHED_LAZY was defined or not.
(I was doing some computation with TIF_NEED_RESCHED_LAZY at that point.)

Eventually I changed that part of code but this stayed.

Anyway, this should be easy enough to fix with done #ifdefry.

Thanks for reviewing.

--
ankur

