Return-Path: <linux-kernel+bounces-74164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D836785D09D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673D51F2596C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FF3A1D8;
	Wed, 21 Feb 2024 06:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oiHVBJ1X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CCzei6UV"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447693A1C2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498177; cv=fail; b=nURrEy3n/+Og46XF9JMHPRcmJLkVBQSyu3K5yfM/2o4fZ1SOgD/KlDtp3Kq5ipU75pHX3U5ZzscD6HFh+EtHu7suA9ZReadZJ6jjbIyhQkNJqY2k1HubbelsgWUHg6EUJ9Xfm2L+v689UIZ/tHZFDCvsTdbIR2swBE8/4uWILhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498177; c=relaxed/simple;
	bh=ZWQgA2RLOhQDSWioxuTMSNyZi/bgagLbLgHXCk266II=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=VlLDxJ6aHkNfmqbROVXr5rqxIwwRutnA1o5ejlCvRtugeWWWFbVQOZyH3Yr1aelcqtne5PUXApeWP8cTyC+lJ/TBXxwvLj9Z3yZ5+7EwtDSkR0/WMXle/8eyvc22mfEfIbA/48eSYWmpdognJ1jViISZS5jexDa5wqfb3ALk7yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oiHVBJ1X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CCzei6UV; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41L6crxZ001212;
	Wed, 21 Feb 2024 06:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ZWQgA2RLOhQDSWioxuTMSNyZi/bgagLbLgHXCk266II=;
 b=oiHVBJ1X7Sby7IGJSnQpjvYNhxL3SKh094vdesQOMciokTNj2tbpzdlAVP4QNpQIMyz2
 9giz8qSgTtTlGKngNrTnYA0l/ZNNWVxVzghmPrXyQiuETgDXSWu7AXaV+ku0OEqOYDYS
 FCCJaZq80Yq6nH81FM0V3sp4MyKLSHC3AwUKwhrjtA4LeeecMlfn1uq4Z9xtRWMSrkcb
 Gl+yAzm5ImH/mWD/Dwr1vGnsyb3OV2glUgYZf/2nOQkTfcLv4pEbllA3CIQzcVSR/+H8
 IMdUJaaapTxygWEJy7NWZ426ftlABDMh2VryrT3V4fPJbkGU7bGJQZ2xmAor27WkFqPA RQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk41163-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 06:48:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41L6L6UH006585;
	Wed, 21 Feb 2024 06:48:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88r3s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 06:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnjRDkHtaNleJmXUAoz7ZKprhvPQW5FYbMyWkAOCGd8ilILeDBMSVbu0xaAtJHtxkanggHuoNmv6z8EbYtu8XoMdsqIFM8QMn8/dwt5HVu80T59T5vxND0GMN4OZvenA3aPvWN4RCejjcEcc1w9zseel2ZW1JkGfns7t1ovuxL21NHdMFgoBNbgYM3Qn6uNvGit6F9L2M6kOgSGKQq9Zx/TtftYgCTq3P5bN7PdVayRwefEP51X3w2iPZ8DBrloFRi1VAbW3LUg5aP1pXgX7MXJHrY55/8ABMxprWU0ojo2ebSz/wk1FkKPn6dY3pLpjW4c8KJKKdSbF9usY8+qE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWQgA2RLOhQDSWioxuTMSNyZi/bgagLbLgHXCk266II=;
 b=LjQggaK7jd2XzQ+mHsTvJYIm2H5HQvE1VZGWdJ2gzDp97X5nAWYPyjd+WqcqLEfJqanc2phn9FovPX98tlQg9NhuUBH/tVK1RfI9KySHZnFPs8hjok+eVC9OyMBljnMnQZ6A9Dp9P275rF6E3OfmzUwKHNqgnereO+/TwUte+5w1VVnAybdBaN2jpARsYEObHUlrusgtHYP3ZgAPR3edKdJ51ufvFYx3V5OiffVfjFuoMD7kUqO4EZEYVLajqgSUY1Zo09R1hHqYpqwlmP0D78p8rDJ8juUqNlpS1JUG6wEG8Z9C3qiXERQjHLjvyhnN+TueSfNUj7BOsi8gGjTVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWQgA2RLOhQDSWioxuTMSNyZi/bgagLbLgHXCk266II=;
 b=CCzei6UVwGEF0tyuVJoNwIRJXEI6+cFg1SYAQISJMYLZMJM81c3dCO4PvrER4fMsgq+G2tAe+0cEyFVyyn5ySzUEtn6ZJnCfKd7tHVtpFC6bHnEAyKmriFbnxHcHgrdZqQtJeVOozIFVIN0Jlrw1fqKfU3S0wcIF11IVC5gr39Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB7457.namprd10.prod.outlook.com (2603:10b6:610:159::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 06:48:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 06:48:30 +0000
References: <draft-87a5o4go5i.ffs@tglx> <87msrw8n59.ffs@tglx>
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
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <87msrw8n59.ffs@tglx>
Date: Tue, 20 Feb 2024 22:48:52 -0800
Message-ID: <875xyigvmz.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0125.namprd04.prod.outlook.com
 (2603:10b6:303:84::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: 3072ffb4-1ef8-4be1-339c-08dc32a91d24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OTu2NY2MoFDQRUI9oJ0ihrLycA947sfEbwhXdHYEmqBg4JewIumbr4TZe+Cav5juOktwnvC3OCp75xmNguQJEC8pXeCE+0qFLPg+bShmaCuodyMhrCqhYNQLPF2wO55rNrLSbIOb3b5RuJWMJrF0pQspJRKBgBjm8/xgId13pjXQ7gT1gYtPgJGSGEaEicaQh2N3Xgqj/H5XJVolnq8/PbRLGqmrfJTA7LYzxzvJrEUQDMGWy3o2I0NbENn4J+9GP7z84FNpFbIhUg79Rd9r6JjavkaSYTnkN6EemCSzGsp1WgWxSat3v3ldrDpam4qpF6fPILgEBTIMElDDQIneeRLfL2He7hxyyL97Q6iY0EzzN05qpgFFNeQ7h3VzLQoVimYRCaqHLxInsJIHcx0pCx9qkhabfK26NJGfoYOLVzIuPBB6FjmhryCJnn2JtHpGDm6m+j8A61s/tlIgxFW6tSI3LsuCy4l5DFkaRMmTorRUoMX5jMT1HWq3wS0LT4cWenibzpHb1lpCpRUJM4Sv2p6QmaHfccWyXBIsW991U/8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BcyguTs3e84okGMI8p98wGDfgNKuOeh1Ksaye/C7+ojMa+Y1C4BuSBw9usIp?=
 =?us-ascii?Q?qlfmxotm2RMGPV9/OHUY0qKaWbt3yjfpYkjSn47n9WAYOOhKMxqGxA7VH66L?=
 =?us-ascii?Q?1vQarGtJSj9HRfHoYKgsvL16wBsX36JQiAvBI4UPhYWO0BM2y1nFMxyIDr5n?=
 =?us-ascii?Q?HkfVC2gOwO849FzFKwXFwM0sEjL/dA009MAfgEqK1oTA3/tMDgVhitnowXlW?=
 =?us-ascii?Q?31F+OJ4sryqz2gQ05w7a2IY/bdVNH/grW9FAskVX+ZhYfzWMNzkTVIvoAisW?=
 =?us-ascii?Q?Wh4+LBMEHfNs6V4Bp67dtVzry7ltAMSNF9qPuJ6jSADYjxSMB+aRZs8OZJOp?=
 =?us-ascii?Q?2c0nq+eXru+AjXqUVSvna2O2F8xv1GkbF7e+VGgd5FPeLiN5/2/deGIkXIDJ?=
 =?us-ascii?Q?ftDkSxToHGzZJvwRKAB0GHPC9+2vpjxL7Y2YHC+cElXFQ08pLAKnbtcoP4tK?=
 =?us-ascii?Q?h7yVsb6u4/ud1n/+53voqa6Oxot3EdgdG3OSSRAu7uFblM6pEI3mnWxJbMY1?=
 =?us-ascii?Q?5mE7G0OOM6aU3P9+qlOy578C+4y8T1ZTiCG6xHds/zfqiazub4LfdoP04rF2?=
 =?us-ascii?Q?GLic+utJHtW44P2S66ukXSsE9Wi5LBywDZdWc7z2reUf8BVK08SgzwN5RUEc?=
 =?us-ascii?Q?tx7VmReOsjhrOAR9KRSNivrONBcEzRBDwD6J5Dbtptp78kqOwqgbOg6vOS/y?=
 =?us-ascii?Q?UFKQYvvYI1h+L0VB5XFuD96j/7Idbsoy7If8fPhddnvMzmogqSfzdtbF57If?=
 =?us-ascii?Q?2Y2lq3NvAG888bIDeKZVfY4V5BtmkBsd/c4aetNm88DzGYWO1bPgJh9u1KnZ?=
 =?us-ascii?Q?BjwMYB7yjAZ+ylWgi9ZRJWmYObSTuqbaFD9K6HChDSFuTpyTLMEpHMKI1+uk?=
 =?us-ascii?Q?X5D4Z/5w08JbcdfHOOQzxPsTBkYFTxJJuHNaCmyIdUnSiAByWCOj1h7772ki?=
 =?us-ascii?Q?RbnyAJudXzqP+X77M8aT8XZu1tWrSwkSvZHiO5Zgnf0PDL1g6ksGIti/1hyI?=
 =?us-ascii?Q?73Wuw5VrfYr6ogznjZpjN5E7QSVA+TpYZLlserntsa99fQq6nf2vZ4kmyFRx?=
 =?us-ascii?Q?8eOlf/hX+3TkQY7+j7sKlOZPvpe7l2TQZHXwfs/aL1xz6OB/T5haUG0W2HnE?=
 =?us-ascii?Q?7G04dtIapAQuVd3WqwwlYJGHM1HEadsEkY1JRRn/bBUUL2EwMQOiTfUs5mVA?=
 =?us-ascii?Q?TDo9SDrnZcYu4BNEYyuHVMCX3pq9bMkYQkMsLL0fPazm0GDl0g8LBH7yGY17?=
 =?us-ascii?Q?IOuhZzNtQMSPmEWGERlQiglMVOKy32M1O20yhCc8aCLiQXBZ04X9NXpDLJlT?=
 =?us-ascii?Q?xIOHxiJLFaSyhZQc4lusQlwRlRIN5zGgO1ZnpWPVvYWMmaXkusQm4PIeo74n?=
 =?us-ascii?Q?cGFrvVLewUY9iSSIepmVi3do7qeDd3ivDkjYTlGA8SgxHhgYnukdxF1fDCmI?=
 =?us-ascii?Q?5ofasMriwezVBJDtGFiTDveW1ig+nc+F/ASV+t0JplrfL7j2aUhq8NasOsDZ?=
 =?us-ascii?Q?a4E8XhO5bdqdh7BaA9KasgxkVjPntR1ecDTbHFQdh/F7FA/s3WpGRgpa7cKk?=
 =?us-ascii?Q?QaOg4SMZULHVBhGFwmWxKpMsUgs6YykXD5PHbN2W/DILqeNmlebJfsolu+2t?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kEXTBkc84LGv+W4n4iJBMymZ/YRmtGsmNHArhGZmeUyERRdKqPuvdEH5UZ1qq2fP/ksqzam6MH+BBWDKqVSRpYZ+QdM5t0V1dq7IS7Xp8yVKzrgeiO3bMjscfLN74drTK+s1sZcZZarG4UiHp2wsN4k22mEU2Oq1QhUdoIDQknRxDvsUDLRNicoK1I9DMCOVaxHpB515eDTIa2XG+20qxzwoNlv8yhq6CDpBBxJi9GrRCiJO+ONAcpqC1a1Dipw7XB/kbLENmwShnhjCbApdDxKv4NZHLOHWtflIg7RfBdtvILiBcc8gR2KagCaElN4ibKDi/fddaOwmATLODWSNu+2j2Ou5bG2+KODRtMhZLog7UFaxo3a0wMKSm4dEMcNp/35JCvRt443kLGvUmWQejKRJ3fHxGs1FUoR9gVANg0FVlPbyl0x1qHO0NccGdfO5ITJNmcczC39p6Ip/G568LY4dZIpVj+Q772MBoAK9EPBzWjdQWpjM3I0uv5HKZx/tc5aV9xvjknmfY9qy79pFVVAyxGnuLfocMw5TKMni85hHYz43drKsCxuOaUISJHpHjXYrzB9t4EHOYWLBzFOiBaJ/mYzeKRisD5l4lQs+ZDU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3072ffb4-1ef8-4be1-339c-08dc32a91d24
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:48:30.0826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfjQz1GHlskmXl/ppuEsAHS+vj79Y667Nm3SNV8micNSMg7fZVVA8v/e4HJws9eIsyp2SeyZzhS6PgRwCS8FInVsnRnu7FqjNQN7wiPNGkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7457
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=566 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210051
X-Proofpoint-ORIG-GUID: 2DGbL-s6COkfD5rM6QXr4LyX7pbjWqbu
X-Proofpoint-GUID: 2DGbL-s6COkfD5rM6QXr4LyX7pbjWqbu


Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, Feb 13 2024 at 20:27, Thomas Gleixner wrote:
>> On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>>
>>> Hi,
>>>
>>> This series adds a new scheduling model PREEMPT_AUTO, which like
>>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>>> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>>> on explicit preemption points for the voluntary models.
>>>
>>> The series is based on Thomas' original proposal which he outlined
>>> in [1], [2] and in his PoC [3].
>>>
>>> An earlier RFC version is at [4].
>
> Aside of the nitpicks from me and Mark this really looks promising!

Thanks, I had great material to work with.

--
ankur

