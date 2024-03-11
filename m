Return-Path: <linux-kernel+bounces-99502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD6D878950
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00839B21763
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801456760;
	Mon, 11 Mar 2024 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/M0D3xe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bH6tngcz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9A56745
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187842; cv=fail; b=StqCUowOuNO85v/cM17hM1nWwHwJgmQ6ajeblVk3gVab7GimM5WycyYFk/shygOvWExnsMcepEqR+FkQXqP+FcD/261/xC/nVXluSlO8Q8R21FTibZ+mnLaGbbOBAxXBgZd9Kj6v+PtjXCpawq2qtgnjFr8mNoYF95jQ4AcWwlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187842; c=relaxed/simple;
	bh=NEJ/o4dpoD/hZ8GqQatw4cxcQu5d3HAdfw6YncC2gYI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=rUuAI3aY21tSoOp4z3nbgv3UZTlWg1l0CyD6bknnInluPei5splVDNDsCmUvNMj5Zsl+d0SH2t3Y8Z2zP21vJpcZGYTuXu3EkXXuLC2cT/RHdtD4/Yc3GqV7VXgYMJ3RJkiDr3URZkXv1IctmovehhTAaz6Q9GcPT0o3YE6tQfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/M0D3xe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bH6tngcz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BIYUSd008743;
	Mon, 11 Mar 2024 20:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6EP2z5Hl0/OyGJKReR7krpFuZ6Eh1VEiZWaSW/tuWcI=;
 b=B/M0D3xe+4gQ9hG+IoDGkF/rJ+ms90p6Q+inKJJ/RdkDj7MeC4Qww/ASrEBJ/qxW7+5N
 DQCJCVlbgZuIjIYp2ec9W5FdcQ+fOQ461wvs1/7ecmAawwgpX8GqFdGTDzi+6U35lP8I
 rDQ26vIudvscTZ2nyZHeVa4QxTa66TY2iuyn8zg9QmZgp6cXFIEKXbsIukLvjiu0Tl5R
 Ls4IfmDZ1/nUKZHJJUnIqlqqMXZengKNdsx5OdxUczGFTNDgFOAc9dQFgRAkWuebd7+d
 XOZ9bx/ChDYIksk47VTn2+3KJKXKLUSqbPa9zfL5WrgxVD0SmlrotJUT936RuROsnuLL KQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrfnbm3td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 20:09:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42BJU9Gw009084;
	Mon, 11 Mar 2024 20:09:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7cffvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 20:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eelx/JwYqOMF2XCv4NJc66f5m2OWX2yGKr4rJxdx2iYSd5LuqlifBvtJ4f2JltHWpcIVxq8N2Ou1pGmEfv0WqNTIX2Sp6GBWPBPw6qMC+D48S4949VsbXHKtm71jZrC92g2Gi9EzmoV42m8zLqVCF8YTC5bVDY+2924SQCS5yh7QQzXaqEmzJ9SCysF03N6DiWfs8h8I+NmAInEV7FjjWR8s1yW8TMH9q4QhOP6GxhaSkJlz+qkq4ctw11dubYMJ2FYUR48bzIB1QWpkprJMZtKECYxsEGytMq18gujw9uHdehvt+MvcQDz7V71vS9geekv927mEkhT8RQ3dDhYQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6EP2z5Hl0/OyGJKReR7krpFuZ6Eh1VEiZWaSW/tuWcI=;
 b=OtF+SsRxqGyvOhBoc1WOLP6IktXBsy2LeUhRzSkv1/97/TtjCGJibHhm4E83km2+pt/ONeuvwJZZrFjA4RS3m1sztCjQzbGNZpBa9RLXyPIKh5jTL3mR5Dm6J7k6sRqT6Cjpgh1mFX7lW+yiUaXH2h4TIBoDm84Mtz/ULUZM0508wnm2z3S2bovUIi7AFdiUvT7FpczSuy9ZvYc7jFLkkCrYSDOmi7mHxT/V0UMnCrjcbHcadH0i/akEP01RwnrKehsVXIh9TPFUcWPxYfxtwcQq5hreZoAGw1GYWf3as3bFt5Ww/GDCxRj3PSl4D3cVtsefRtV4+eyIyPhePZj2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EP2z5Hl0/OyGJKReR7krpFuZ6Eh1VEiZWaSW/tuWcI=;
 b=bH6tngczWKYvg/Mzrpt1wwAo8AKa3do8fEcFIDxN9J8egmYK0dWRXLuarO71N3prxAlx+MwWH/ZXdXwRRcQ7MDT96m3lUlGzQAnIhy5cUddkNly8EQsByWg/uS78fI+luQ9K4cFcZcwYPkATmfOxT/hbobwf8Thcb1xgpXtfr6Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7315.namprd10.prod.outlook.com (2603:10b6:930:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 20:09:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 20:09:22 +0000
References: <20240213055554.1802415-27-ankur.a.arora@oracle.com>
 <65e3cd87.050a0220.bc052.7a29@mx.google.com> <87frx514jz.fsf@oracle.com>
 <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com>
 <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Joel Fernandes
 <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-reply-to: <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
Date: Mon, 11 Mar 2024 13:09:54 -0700
Message-ID: <87cys0il7x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:303:2a::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f1fef6-98e0-49c7-1065-08dc42072454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wC5LqnLTfeGIi0GsSZcerhZVVBuuRcnhWo85KQg3NWuS5xgCkO7r9e0SY8+fMW8KjectO39KUhBZIswN9Rpg/P4I6/6qYLe80o3bH4dy86cCK27goSd5qcBGci88HEIVqTrqjFfsSi2i6/VpKfdkpmNbOm/xkcCrD19jGl5zKTaK1CrAhE3Gu3zo7efplsuyPvk8hAWrY//e4uQIAatsYelV4PL1YqQ1NIz+Hijr2BLBFkXvIx1hcjZ7sFdu8qyP5n35jFimw3pdok6k46AYg1qs/wF9QPUOoPhMLAbkxPhMnXryRkmMZwvof2j/XS6cjYdoX8RTM7+18Eq3zOaeBNu6H43EHntzEs3cXR+NU4T4tQX5ktiMoFPEQ+pBxVX7pxQ+m+BmtM1PNezcugODpkoX4SBDiirlr+gwg4lKyZyP6AM0iVdR1oCwhQXzT8XDHefNjo0ggKMteRlEgjRNr68wy3sIduZfbuZWoIHDJuw4gHT7JK9zgO2qQ/xmCRWcnATUWgCYgk57BAOwoqDDKTbj3NLUgmvfdYqK1xlpZC+QrU6ocpzeNClyG3iuvSUPkSvL+KAJsRfr716z8MgQF6Ya427hkabdci0TY9iKE1mcQt/KwchvOPQBiJHLmcj1PajHcgm47gq3OQFvz4cdswCFgeyzZpd6hMyCHGY1DL8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iJkDCCBVhuXs5mP46+Thg8nimggIhVQVETeend+6HkeywKHTVIKesK+uE6Fe?=
 =?us-ascii?Q?45Svtf/TyMI4mdb6UU1bQ93KMU6TXs9myzfztsHScJsHfhULI1ROhcT+xTVl?=
 =?us-ascii?Q?Rt8/1i9T3E1Soog5OGp041uhgvMoY8EQWeZVqOcG83IFHVYvIP109tj34V8Z?=
 =?us-ascii?Q?ARVNRQD0xaW0LVSmtKCHtZ1V8cdF/Ln9jXj/VVPPmIhJyoo2hO66wRIdkTeG?=
 =?us-ascii?Q?FMbmGZQqRatolYsBpL5vzEIHU/H+Y73yIQsEdX2DdqBiyneJstYeO2w6p490?=
 =?us-ascii?Q?eKmku07ESq9GwwqsMvhEWx5sLT8rK+RppaaJ0Qp1ic+LSNKU8xbzhGOSKuhC?=
 =?us-ascii?Q?gClSGzSQYJApyv/2QylCKqi1ynTHtG2stT53gJtLxw58ngGVCfuAEal5ICrY?=
 =?us-ascii?Q?f1v/JRfloieb5lWuUeFoAqmBwfje1ukY+64DQFAK7zyvxWcW8v09tr5vi9KE?=
 =?us-ascii?Q?g911dw7z+bUJsAsBOO0Qz+0/rmlDupm4jPULdUG0aUz9g2z7uVE4t8FZqBuV?=
 =?us-ascii?Q?RmHd1LglvRu/LeeF9ndBNy8rB38kO1rqgcoIKkxyrPjPQmTTV0U1qmt7oagc?=
 =?us-ascii?Q?DpN8DhEKT7J4mx6B/lkZqckkjGaSp0LZGo+p/matr2mcD4z6lfiuQfPmechg?=
 =?us-ascii?Q?0nmhieWNA3bz2OAqUEPqrhXxynqUG6x3EF3n3AABYwsh0JIwIWv4UcKH55zA?=
 =?us-ascii?Q?a7SCGw4LQL/solkqctEiEaT1pFIx3DCgDG/aanqr+D6lVlmgzmIgpQVQ2ebn?=
 =?us-ascii?Q?EwsfLKW4FUskOs6IQyKqxlhyJAzxeMpQgV9cM0hyqhgSwTm5/E4ldjmXrYKA?=
 =?us-ascii?Q?2elewMvbXPARzTR2+TyYVtLekQMLxEFRFDQh070zNIruYM6+KSCgokqtOult?=
 =?us-ascii?Q?ATcErI+FU9194xWymX6Fje67TnbW4tIxRXq/EujJMA+OQ2ZCqgzGLHGMOp16?=
 =?us-ascii?Q?Tf4Oxw14dIbwGMSKd0cIVXbAPjyk3+1SMLqCb4hzvyvaR0DuWLRUBAlF8Mvo?=
 =?us-ascii?Q?dhVzsk/WTvtEV5Rzl4xtOZnpc5nXUxgvlfVVk58ik/QYzBP0vhH1/B3iDalM?=
 =?us-ascii?Q?LC2Q8a/10MLDqC8NIBY0mr7JTHj4QiNqgijxLhO/+nQiGgg94VJ+MZ1ijQv4?=
 =?us-ascii?Q?6wqrsz+3C70WSKXkA9On4Ix6KLNGFWmIV8MgTEA+CTdwt+UzpAD4PYWbKVHT?=
 =?us-ascii?Q?X2kfj+AsWU2yTgRe0q58c2BM88nV4piCe5sb/lhLk3aCvJSd5MNNCUxGOcLJ?=
 =?us-ascii?Q?FHVlgvvFdN/T/3bOqJ4DD+nFt2rjEgwsg4u+cKsg+ywF7KtX6yOlVHnVIpZL?=
 =?us-ascii?Q?Rfylc0ScyC9KsmHp1N/g/gn1g+6s6HjjRn/REbFjGZUd3cdgqP7Fler17HBZ?=
 =?us-ascii?Q?b6aKuS7XuXd7o8RD7zSkyu1us0Fq93M5ImB1HpiN9iubvcnDixhwaujh8l4w?=
 =?us-ascii?Q?G0L0U3aQK+gMPSGXVpv+PpXDr6N2VWB47+do1s6P5nOGhOz6UlQZpmRyCc7c?=
 =?us-ascii?Q?KOt+3JuphXVbvADYSffHzdZQEaddQ1L3/LhPvPlCXCv7gfneFI2egMfWlqGo?=
 =?us-ascii?Q?J9THXrsXnyPdAYOVER4pR08jIDKrIMY8R9MX3kASLLtDFdeggBedsdPTBMim?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Q3LTdMyePjG72fFoskVIHx4EIz8KfQYKxALkTIzHqjaGUhgRgqJ5F0S+UqYnPBTldSFy5vZcscwmiLrkdgKf4ERPnhUnHGY0dFMT2ZqGL04cNSqgb71hQslQkF9OwTKlZ5SY3cOvjCXSCX7zHecNEDvaZRQ4hwvjDAUqD3KhhJeH3xMn1/96mgqe0XOCEVKgk5vcrl1VtIAefOchk+4lR2NSOWaEwA+xSZNgHOAIttpjRyv0h/B9PCNb/4RoCwt7xs3zxU8E3PKkkHUxOJyB20ujbUTDhlmp7+2luu6FQYioeMroPpYpqPPb3JUNbwoD/NxgWhlrgmetCqJtpfgrWPI+1lI0sSwTke21UGERNgiizSvuTe/90jnJLRMjE+/p4HipTQp3qhEwl8oIgWlEsvTtkfboCXhw4CPwBUFYzKFxqcBcX5T4BDtz75OlGJKBeH9huOZT0mswEs4OHVMdECxw/2KplJk1Ak5Hb7KGUnPeFMYHAfEUCAf+2QoUbH6lg0D1Hg2esrAv3DTIVr6SDGUK7l6GQ2hZGpATY80hnzcSxwPxC2Ts8eskgIIBjhWJERvpSGUktnByZml3iPSNcDf1fTLecoYNvonueU2+DHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f1fef6-98e0-49c7-1065-08dc42072454
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 20:09:22.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eUWwXr3PWIJqs9yyntCqG/8tgZO7w4R27Dg7NKbjbh7F0wkL7hIA81nqOk6qQjbtbfztAKsm9WHnguApcVlolIYDTZcLbUR9NfJJMlTKKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7315
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=975 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110154
X-Proofpoint-GUID: nBs9r2HqfPcmUp1Z5BOQsj6ly1pgTn_2
X-Proofpoint-ORIG-GUID: nBs9r2HqfPcmUp1Z5BOQsj6ly1pgTn_2


Paul E. McKenney <paulmck@kernel.org> writes:

> On Sun, Mar 10, 2024 at 09:50:33PM -0700, Ankur Arora wrote:
>>
>> Paul E. McKenney <paulmck@kernel.org> writes:
>>
>> > On Thu, Mar 07, 2024 at 08:22:30PM -0800, Ankur Arora wrote:
>> >>
>> >> Paul E. McKenney <paulmck@kernel.org> writes:
>> >>
>> >> > On Thu, Mar 07, 2024 at 07:15:35PM -0500, Joel Fernandes wrote:
>> >> >>
>> >> >>
>> >> >> On 3/7/2024 2:01 PM, Paul E. McKenney wrote:
>> >> >> > On Wed, Mar 06, 2024 at 03:42:10PM -0500, Joel Fernandes wrote:
>> >> >> >> Hi Ankur,
>> >> >> >>
>> >> >> >> On 3/5/2024 3:11 AM, Ankur Arora wrote:
>> >> >> >>>
>> >> >> >>> Joel Fernandes <joel@joelfernandes.org> writes:
>> >> >> >>>
>> >> >> >> [..]
>> >> >> >>>> IMO, just kill 'voluntary' if PREEMPT_AUTO is enabled. There is no
>> >> >> >>>> 'voluntary' business because
>> >> >> >>>> 1. The behavior vs =none is to allow higher scheduling class to preempt, it
>> >> >> >>>> is not about the old voluntary.
>> >> >> >>>
>> >> >> >>> What do you think about folding the higher scheduling class preemption logic
>> >> >> >>> into preempt=none? As Juri pointed out, prioritization of at least the leftmost
>> >> >> >>> deadline task needs to be done for correctness.
>> >> >> >>>
>> >> >> >>> (That'll get rid of the current preempt=voluntary model, at least until
>> >> >> >>> there's a separate use for it.)
>> >> >> >>
>> >> >> >> Yes I am all in support for that. Its less confusing for the user as well, and
>> >> >> >> scheduling higher priority class at the next tick for preempt=none sounds good
>> >> >> >> to me. That is still an improvement for folks using SCHED_DEADLINE for whatever
>> >> >> >> reason, with a vanilla CONFIG_PREEMPT_NONE=y kernel. :-P. If we want a new mode
>> >> >> >> that is more aggressive, it could be added in the future.
>> >> >> >
>> >> >> > This would be something that happens only after removing cond_resched()
>> >> >> > might_sleep() functionality from might_sleep(), correct?
>> >> >>
>> >> >> Firstly, Maybe I misunderstood Ankur completely. Re-reading his comments above,
>> >> >> he seems to be suggesting preempting instantly for higher scheduling CLASSES
>> >> >> even for preempt=none mode, without having to wait till the next
>> >> >> scheduling-clock interrupt. Not sure if that makes sense to me, I was asking not
>> >> >> to treat "higher class" any differently than "higher priority" for preempt=none.
>> >> >>
>> >> >> And if SCHED_DEADLINE has a problem with that, then it already happens so with
>> >> >> CONFIG_PREEMPT_NONE=y kernels, so no need special treatment for higher class any
>> >> >> more than the treatment given to higher priority within same class. Ankur/Juri?
>> >> >>
>> >> >> Re: cond_resched(), I did not follow you Paul, why does removing the proposed
>> >> >> preempt=voluntary mode (i.e. dropping this patch) have to happen only after
>> >> >> cond_resched()/might_sleep() modifications?
>> >> >
>> >> > Because right now, one large difference between CONFIG_PREEMPT_NONE
>> >> > an CONFIG_PREEMPT_VOLUNTARY is that for the latter might_sleep() is a
>> >> > preemption point, but not for the former.
>> >>
>> >> True. But, there is no difference between either of those with
>> >> PREEMPT_AUTO=y (at least right now).
>> >>
>> >> For (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y, DEBUG_ATOMIC_SLEEP=y),
>> >> might_sleep() is:
>> >>
>> >> # define might_resched() do { } while (0)
>> >> # define might_sleep() \
>> >>         do { __might_sleep(__FILE__, __LINE__); might_resched(); } while (0)
>> >>
>> >> And, cond_resched() for (PREEMPT_AUTO=y, PREEMPT_VOLUNTARY=y,
>> >> DEBUG_ATOMIC_SLEEP=y):
>> >>
>> >> static inline int _cond_resched(void)
>> >> {
>> >>         klp_sched_try_switch();
>> >>         return 0;
>> >> }
>> >> #define cond_resched() ({                       \
>> >>         __might_resched(__FILE__, __LINE__, 0); \
>> >>         _cond_resched();                        \
>> >> })
>> >>
>> >> And, no change for (PREEMPT_AUTO=y, PREEMPT_NONE=y, DEBUG_ATOMIC_SLEEP=y).
>> >
>> > As long as it is easy to restore the prior cond_resched() functionality
>> > for testing in the meantime, I should be OK.  For example, it would
>> > be great to have the commit removing the old functionality from
>> > cond_resched() at the end of the series,
>>
>> I would, of course, be happy to make any changes that helps testing,
>> but I think I'm missing something that you are saying wrt
>> cond_resched()/might_sleep().
>>
>> There's no commit explicitly removing the core cond_reshed()
>> functionality: PREEMPT_AUTO explicitly selects PREEMPT_BUILD and selects
>> out PREEMPTION_{NONE,VOLUNTARY}_BUILD.
>> (That's patch-1 "preempt: introduce CONFIG_PREEMPT_AUTO".)
>>
>> For the rest it just piggybacks on the CONFIG_PREEMPT_DYNAMIC work
>> and just piggybacks on (!CONFIG_PREEMPT_DYNAMIC && CONFIG_PREEMPTION):
>>
>> #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
>> 	/* ... */
>> #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>> 	/* ... */
>> #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>> 	/* ... */
>> #else /* !CONFIG_PREEMPTION */
>> 	/* ... */
>> #endif /* PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
>>
>> #else /* CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC */
>> static inline int _cond_resched(void)
>> {
>> 	klp_sched_try_switch();
>> 	return 0;
>> }
>> #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
>>
>> Same for might_sleep() (which really amounts to might_resched()):
>>
>> #ifdef CONFIG_PREEMPT_VOLUNTARY_BUILD
>>        /* ... */
>> #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>>       /* ... */
>> #elif defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>>       /* ... */
>> #else
>> # define might_resched() do { } while (0)
>> #endif /* CONFIG_PREEMPT_* */
>>
>> But, I doubt that I'm telling you anything new. So, what am I missing?
>
> It is really a choice at your end.
>
> Suppose we enable CONFIG_PREEMPT_AUTO on our fleet, and find that there
> was some small set of cond_resched() calls that provided sub-jiffy
> preemption that matter to some of our workloads.  At that point, what
> are our options?
>
> 1.	Revert CONFIG_PREEMPT_AUTO.
>
> 2.	Revert only the part that disables the voluntary preemption
> 	semantics of cond_resched().  Which, as you point out, ends up
> 	being the same as #1 above.
>
> 3.	Hotwire a voluntary preemption into the required locations.
> 	Which we would avoid doing due to upstream-acceptance concerns.
>
> So, how easy would you like to make it for us to use as much of
> CONFIG_PREEMPT_AUTO=y under various possible problem scenarios?

Ah, I see your point. Basically, keep the lazy semantics but -- in
addition -- also provide the ability to dynamically toggle
cond_resched(), might_reshed() as a feature to help move this along
further.

So, as I mentioned earlier, the callsites are already present, and
removing them needs work (with livepatch and more generally to ensure
PREEMPT_AUTO is good enough for the current PREEMPT_* scenarios so
we can ditch cond_resched()).

I honestly don't see any reason not to do this -- I would prefer
this be a temporary thing to help beat PREEMPT_AUTO into shape. And,
this provides an insurance policy for using PREEMPT_AUTO.

That said, I would like Thomas' opinion on this.

> 3.	Hotwire a voluntary preemption into the required locations.
> 	Which we would avoid doing due to upstream-acceptance concerns.

Apropos of this, how would you determine which are the locations
where we specifically need voluntary preemption?

> Yes, in a perfect world, we would have tested this already, but I
> am still chasing down problems induced by simple rcutorture testing.
> Cowardly of us, isn't it?  ;-)

Cowards are us :).

--
ankur

