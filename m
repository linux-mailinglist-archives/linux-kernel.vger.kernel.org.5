Return-Path: <linux-kernel+bounces-62984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE009852885
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3192B24F29
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615E4CDE1;
	Tue, 13 Feb 2024 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gp19mtXg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="az/145iQ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FF46551
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803872; cv=fail; b=WFvMSqztqe6/PSPrcs86duHG84JRonXOnMrUUH2JKgD+4bFuG02kZbAW82XTHCHS7Mu3/9RgTlD8lF4OQyHZRMjIR1bq/OQ9o+JHEoRlItZKZHReN39nMYKIb9NkhCRtCuxcQge55ylYQx2/9NiF9Ptns56+k+BGKd1HC8GryRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803872; c=relaxed/simple;
	bh=Uxj2dlGr5k8t6r7cvGC9E90vmUoirWWv+uI4l5YRcv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GcfD7JS2qUDTUzLp0ZXVihAcnXn6QrMmrvVapgzRi3SbhELk3z+C91oRRoCGe7RFYa0l+HRlKsLPBERXnxCPsF+whjvGFQvg5bq8XflJIs8K9RI+edc2ada1kLxXjYBHFRYlFdvOXHBMv1V0cZu4+7K0BLgm0Otg91EoSS5eXZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gp19mtXg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=az/145iQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5n3sQ013728;
	Tue, 13 Feb 2024 05:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=dXEtnZOhyxE3K0Iw78IS+ki4QyI9cMz/QAPWPNumPqY=;
 b=Gp19mtXgBZISZS7y/4WN+oW6/ZYzDvbOi7tbRqmaqO2kPoKQ3bLpZALAmhpu7mEbXqpa
 4G4krJMyLWVEYuK+GUFTs22I4WIEEhWbh5hdBw3BjJggh8psr6vaZ8+3zszmGG3FTnfs
 KyuIkdZsNxM+5gvf03GF5TcFrEtC/vs9AFp4VI5SPuKQiNFfT/5MlfVsDlJKhD4LrdQu
 tg0MjoHu327xCukbQN8E6htzHaBrfJ/tPXoDqnxEAZYIV7TXsiUhFxHKIQbCrDnBzT7i
 d6ZU48EiGBM+VHlyF5XIBpzh6QNv4j9k0OQKEjasleIBES4o7mcEDpp4wsKOmPZ+NcO1 JA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w816tg4ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5l6cf024619;
	Tue, 13 Feb 2024 05:56:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3tnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFsP+z8oL/FEbfmlndIhOYyAjGfYrsjupYqU4URyR24grF+8ZeZf2QLJvz8HEsd1/kQsWYO284OMCgfXs1Wet6Lm+RRNgCl+APvxn4uqY9S6qhpGw+7T+fvMfB0OQL3+pkP2XjlWTeuhk5UJs47PEX4zgPXl4gZRXV0nHdGxwSAprhNyMb4o3jyrchjPe81bvTBBRKtuPdE7hJtxqyIi4Ikl6kILiZWLILYb0rP/u+ikYCCc2NImN8Ykha3cce2C6GGuCdbnfyUqzWj+iEAiycbRAtZUeUp7ieZjm05Lq0AsSerRMIhCRE3C+86Dtd4GKzVfebXV8llNTNu7ZUifJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXEtnZOhyxE3K0Iw78IS+ki4QyI9cMz/QAPWPNumPqY=;
 b=Phqosc9K3Rl17ZuQOfc/2coTNzBmzf3NfQACneTdBRhvCc8RAO/6XZnVq61itRuPs/3HK56V0BB90/sSUsp5sCpoZMyy6qpV1VvoIZZduOfcYPLMJVNaiKM+QZ/HWpFnVDZHBXc1P56C04Y/xpDreF3G+2O5kc0ZL8eM+mHfAWOq7aKr3OOjg/l9K66k32e+qPb0gglNbOXHNMCQSxaDrulPMW2OP0oN3DKR2jBNdpsnl0IELDP/yusZ6a9Hc9U/xlp9R7uFpph+ZFe9nGuA3h+VOy9pgHvnIWoYMU1F+Ser/hhMy/RyVyQIvMgn7wOpqBZvm5cSrXbrTNK2dyd2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXEtnZOhyxE3K0Iw78IS+ki4QyI9cMz/QAPWPNumPqY=;
 b=az/145iQkf83OnJnUAvndR5xrbQjq3XWgndlowrGoZi/U8xlRVec/pjE9jpjl/RzUeDWWDATA1C1odIWMopG4RAECpzN+SiIAOBsAb8tVuKHkP5eQAMJYocLhYq4b3au4dwvz+xF8XiW0bNWxEeLezbbVWTBL1H5HSgx5b9vU64=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:52 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 25/30] sched: support preempt=full under PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:49 -0800
Message-Id: <20240213055554.1802415-26-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c6010e-a1f1-48ad-59f9-08dc2c58936f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LGs/JCLc7VAjmR3lqI74SWapFV4kSHCq43a8qqHAJ1Kz5lfcNlRnOQa46s+CZWkcD2N562JrEmM8qm/J2nkOCSS4b4KE/TU/gbbN1OzEejkngbEdhLol7/Y5JwOM4RDLyqma65kpXG1R2+sbudLeHPFy05WWeQ/7RgUsqa0RR5nEXDmd35NolwXF5TF9V8gcqwpp3+VbyYYngG5uSgLjd8fVQBsk0uM5wyQp4HYu+b6VYSA9rsZxPMwAnxktY+ecyapVcpZ5gASS5UktAvQjnvAguu2Zgb3RJkyuAsbXErBwG5w/2Y0hLiga3jHvMyJyKn9eB322Q94hDrxNtoMGYpluQOxotUU6uP50p3gpQIiNIQqgzfx29qQT7bL/hlzyCjuch6CcEJa49+tZTCUTb4iZenWMob7P7DFzZSUEF2swoeQfcF1ZDv0eCr6RWdPpMdD69iHxMShoI7yvpNyL8uksf2rL0DrVeywCKWlAECOX8QxhZBx91FbgW0Hp9WKwR6e3XqEYWyyVCPXSYij2F0x/DxyAiQStW2ALg6bH8HI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Boa+y92NZDD2976/cpbHYNPGn4ANxNqFm6YKvViyh6SXwYkzh8Zmv+yKnQ5e?=
 =?us-ascii?Q?qjAjB7QyTvPZpQvyATtyJTr9oUHZwFh3ArVxlNkHuIxFtRzS/i6UefWlfk2s?=
 =?us-ascii?Q?IpL7e9cMpD3y/RU1hHVXq5SFeGIcPsrCW2N+Aw6mZ2/ZapY5j4wO9iDv2OOj?=
 =?us-ascii?Q?m4XF2HiQNuwJu9sU8PARH5VJ0LP7n368sxaP8fZTyUJ1HNh97ummila6K4ZL?=
 =?us-ascii?Q?Wesur3xqbItLT/9UW1cvTAk13HHw41FqFKyTZ8lYo+Iq160+JWuLDrvXI1E+?=
 =?us-ascii?Q?4+jbzlI3zBBj9rmkL86O92yCCm5Wczn7de2aBoFzQakBNE2R96ZI1JFLLnP4?=
 =?us-ascii?Q?C0IZfDV44O6mrABNMoIiNj7BZ0JMsMKVmYYLZKbfHHPBjk68Lr6twuRQguv4?=
 =?us-ascii?Q?6ysCkwIAwEiaCkRY4AAE5hemL1hBLY9H4fqcqGyibNyssnEwjSw3d0Wh+IMy?=
 =?us-ascii?Q?CX3jsV3PBzx2hBquAsRP70zSRzdQmm3Kjv68DRl1PXoENvuUNnxkeMFMctLY?=
 =?us-ascii?Q?Hyike1pGAMP6cmW31PuB+omzdCxAA/+yhRGkfMRSLql1ewIivg6eJEc+TPRi?=
 =?us-ascii?Q?bmwIXKQMoxHyP2tJgVQs0YdM9UJFdmkEsSVM1KShkjPSZSJ7cIByDpYemaDU?=
 =?us-ascii?Q?0gDijlnrN7+z9bKGy4hYqS7pKyAHmDZ9w6LjPy2wdo9gXFUIO4GEJXuY/hMO?=
 =?us-ascii?Q?GI6HCIEKmTKprMTs38O6g+E1QRwSZwavB2yMbsR6ONANm3gsdpT54F8Okwyd?=
 =?us-ascii?Q?xYfGnzdvZV0u5o9xycha7JjurIfZ6UEls1u34N32m8PLyOFafyLAIQ3mXEXV?=
 =?us-ascii?Q?AQI3ieFCz3xbo1Y1HI1euAIbwk2FOYzwqycWhQTFQBZCGTJcZdXIHBRbTVu+?=
 =?us-ascii?Q?yKPrMZ/brpexbeUqyEsNCLp+eDgp/Yc1y5sEkHio9jNzRr+HQZh8viYdjLtQ?=
 =?us-ascii?Q?6ZrVIqWiJllpCerg6wfduwtpkLIpR4m+ZozVbS641vl0/BWiBC0Ucvi/ob6E?=
 =?us-ascii?Q?9CbdxwQpPPbyj45hGqi3c8z6G5s7I0eFR78kheVPpv+4zOOxkeuhTKQ8IOz9?=
 =?us-ascii?Q?mH2PUBWb8c8Hq2Xa/WlgmhmkF5bxaa4TVljfNdrvIPycZFMkz6w3fTAWyq6T?=
 =?us-ascii?Q?H3pqHPiGnbpC0+MbuyY8FhvZPHQO4a6KIO8YAlrRPsTGoyxQbg4gWpGtUtYe?=
 =?us-ascii?Q?Kpdhg04JSuZWN5C3/hvyW0cS7EkhXQauXKa+QpJQIQOXpoPIJ4LBj6LzF8RC?=
 =?us-ascii?Q?GCiBLRFxR0a9Ql2bYDisg1VBt/OXZ4msJAqO8jAfVB6eFkDyd+fbx616slo+?=
 =?us-ascii?Q?eAatg98tW1VM3/STvWcpQZQl9JpcFEwbL2wtAiPt3Cuz8BmGrhrorCrsALgL?=
 =?us-ascii?Q?hsGzYWoj+RraKd+OcwAs/Hg2K32D8taczFw+7mOyaIgs8RzhZyf3ah3h2R2I?=
 =?us-ascii?Q?5vJ2RjD6YuqOhwP57Xp/OHonXlWJsRYvNMKHIjhoJvL9jv2Wufry6orjfmeZ?=
 =?us-ascii?Q?M8dhYLULJ8bhClezaqSsxGf3YTziblUI0bwQDaasn6o8P27FZ+15JYZ09SZo?=
 =?us-ascii?Q?Ydoeej8OfMYgUHS3Tjn0i3TxumQ6GV0xDhA2SO8ljS3ajvrkM9wq64b31tsw?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yGIOG4kiyCdNTndN497U/nwtfLyS1HzhINwAQjt9HplmrkMWXt802xEU2sMsvWwvmevlCxVW4zmTpM8wKJt9zjQtC4SIF23/XIAxW8pCLS3SakzVMaQ9bwN7WzcGoomN0XVxgDKi7hQV4J3vrQhAxxxFRuR9R3hfa+IqmO3R25N65BPYJX95nc//AENkyXn9YTI/K7+Rn7/uRHvURGnM6y2/Z+xaBiBrSZMEVsHhO1jGpy8TZwAjtxNhDigMtBuz6kOqWPNCUGfOAWAny2sas2dHYUd/yIyUnl0LkmdulzC4azJInlNOtoEeC6PLzahEUebG/afUjIsq9LifHjF8XwD0FfnUJ6qekNmENjx+aksEHoJAoNCHsixxbC0D8K+sPaGlqpGJce8EYkH9cMDH4QeB5v9nwimldyXF2yZtPC1wA0VZ2k8+fqMEDuxUMD1tj3fH5RpSHodVjisPR8fokW1DKXxGRhKG/Nrq3xU9VFdGp5RiEBujr6OTsTBMA/qtRwVGjOHxE5dIVsN93HCiDzVySllItY315+04qlUCVKZu1MfCqmHw9RdvduzCraZCqdfWPxCkfi2ZH63eZEtGaA1jkkOWbFN3B/wZjGkGKQc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c6010e-a1f1-48ad-59f9-08dc2c58936f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:52.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mau2xC+6ge5I4wp/qyCAR/11J8N6QTscMK+xrhwAhH/i1Co3T27EQoa3ZEg+IjCyz3JpRIQTzm2NtZbk1LLV03RAaXM4oL+HaxmcwZD5YaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: _dC-pdLwH5S_86MnE3DooFnxG4vNtnWz
X-Proofpoint-ORIG-GUID: _dC-pdLwH5S_86MnE3DooFnxG4vNtnWz

The default preemption policy for preempt-full under PREEMPT_AUTO is
to minimize latency, and thus to always schedule eagerly. This is
identical to CONFIG_PREEMPT, and so should result in similar
performance.

Comparing scheduling/IPC workload:

 # perf stat -a -e cs --repeat 10 -- perf bench sched messaging -g 20 -t -l 5000

 PREEMPT_AUTO, preempt=full

         3,080,508            context-switches      ( +-  0.64% )
	   3.65171 +- 0.00654 seconds time elapsed  ( +-  0.18% )

 PREEMPT_DYNAMIC, preempt=full

	 3,087,527            context-switches      ( +-  0.33% )
	   3.60163 +- 0.00633 seconds time elapsed  ( +-  0.18% )

Looking at the breakup between voluntary and involuntary context-switches, we
see almost identical behaviour as well.

 PREEMPT_AUTO, preempt=full

           2087910.00 +- 34720.95 voluntary context-switches   ( +- 1.660% )
            784437.60 +- 19827.79 involuntary context-switches ( +- 2.520% )

 PREEMPT_DYNAMIC, preempt=full

           2102879.60 +- 22767.11 voluntary context-switches   ( +- 1.080% )
            801189.90 +- 21324.18 involuntary context-switches ( +- 2.660% )

Comparing kernbench half load (-j 32), we see that both voluntary
and involuntary context switches, and their stdev is fairly similar.
So is the percentage of CPU taken and various process times.

  # Half load (-j 32)
                          PREEMPT_AUTO                              PREEMPT_DYNAMIC

  wall            74.45 +-     0.39 sec ( +-  0.53% )          74.08 +-     0.20 sec ( +-  0.27% )
  utime         1419.68 +-     5.12 sec ( +-  0.36% )        1419.76 +-     3.63 sec ( +-  0.25% )
  stime          250.56 +-     1.08 sec ( +-  0.43% )         248.94 +-     0.80 sec ( +-  0.32% )
  %cpu          2243.20 +-    19.57     ( +-  0.87% )        2251.80 +-    11.12     ( +-  0.49% )
  inv-csw      20286.60 +-   547.48     ( +-  2.69% )       20175.60 +-   214.20     ( +-  1.06% )
  vol-csw     187688.00 +-  5097.26     ( +-  2.71% )      182914.00 +-  2525.59     ( +-  1.38% )

Same for kernbench optimal and maximal loads.

  # Optimal load (-j 256)

                          PREEMPT_AUTO                              PREEMPT_DYNAMIC

  wall            65.10 +-      0.09 sec ( +-  0.14% )          65.11 +-      0.27 sec ( +-  0.42% )
  utime         1875.03 +-    479.98 sec ( +- 25.59% )        1874.55 +-    479.39 sec ( +- 25.57% )
  stime          297.70 +-     49.68 sec ( +- 16.69% )         297.04 +-     50.69 sec ( +- 17.06% )
  %cpu          3175.60 +-    982.93     ( +- 30.95% )        3179.40 +-    977.87     ( +- 30.75% )
  inv-csw     391147.00 +- 390941.00     ( +- 99.94% )      392298.00 +- 392268.00     ( +- 99.99% )
  vol-csw     212039.00 +-  26419.90     ( +- 12.45% )      211349.00 +-  30227.30     ( +- 14.30% )

  # Maximal load (-j 256)

                          PREEMPT_AUTO                              PREEMPT_DYNAMIC

  wall            66.55 +-      0.34 sec ( +-  0.51% )          66.41 +-      0.72 sec ( +-  1.09% )
  utime         2028.83 +-    445.86 sec ( +- 21.97% )        2027.59 +-    444.89 sec ( +- 21.94% )
  stime          316.16 +-     48.29 sec ( +- 15.27% )         313.97 +-     47.61 sec ( +- 15.16% )
  %cpu          3463.93 +-    894.12     ( +- 25.81% )        3465.33 +-    889.04     ( +- 25.65% )
  inv-csw     491115.00 +- 345936.00     ( +- 70.43% )      492028.00 +- 346745.00     ( +- 70.47% )
  vol-csw     200509.00 +-  32922.60     ( +- 16.41% )      187447.00 +-  42567.20     ( +- 22.70% )

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d33f3ff51a3..aaa87d5fecdd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1035,8 +1035,9 @@ void wake_up_q(struct wake_q_head *head)
  * For preemption models other than PREEMPT_AUTO: always schedule
  * eagerly.
  *
- * For PREEMPT_AUTO: schedule idle threads eagerly, allow everything
- * else, whether running in user or kernel context, to finish its time
+ * For PREEMPT_AUTO: schedule idle threads eagerly, and under full
+ * preemption all tasks eagerly. Otherwise, allow everything else,
+ * whether running in user or kernel context, to finish its time
  * quanta, and mark for rescheduling at the next exit to user.
  *
  * Note: to avoid the hog problem, where the user does not relinquish
@@ -1052,6 +1053,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (opt == RESCHED_FORCE)
 		return NR_now;
 
+	if (preempt_model_preemptible())
+		return NR_now;
+
 	if (is_idle_task(curr))
 		return NR_now;
 
@@ -8982,7 +8986,9 @@ static void __sched_dynamic_update(int mode)
 			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
 				PREEMPT_MODE);
 
-		preempt_dynamic_mode = preempt_dynamic_undefined;
+		if (mode != preempt_dynamic_mode)
+			pr_info("%s: full\n", PREEMPT_MODE);
+		preempt_dynamic_mode = mode;
 		break;
 	}
 }
-- 
2.31.1


