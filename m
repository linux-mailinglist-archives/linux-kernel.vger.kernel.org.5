Return-Path: <linux-kernel+bounces-62960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55688852869
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11BE1F24B71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA49171A5;
	Tue, 13 Feb 2024 05:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gzec7MUb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="udJQEnS2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515C13AE8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803817; cv=fail; b=oopYkkjggJTIeLcoBeEwRxJJ8kZVgXgXVN2w6lQ/m5sesi5M8ZZZg4JQhvGntOUkKwcgwkYQWclunV+Gecsi9BrwKxmf0jzPjcxZ0R0kzV+5srBdbTMDrAngdWgAF6mZGGSzqoeNyusUAsa4AXrtTVU9vtr+SHEmj7byUVGSMeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803817; c=relaxed/simple;
	bh=EjX72QId1zVFFp7qM0r2GQLoHgmWlGmnGOOnzaAPdmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aDwcWq4w/aOcqFTmed/OdDnee8I0a6JEzyn4O0hA/500hlIGUwoD3cVFKiW8CtTATSk4MaSjuBV8AmzJ8OJEMBL+hdhsZV+tYBvxbciwOmICAGre+orWms2FKzwwRjH/LWoxFPZgiIqg5W8ITxYtczytdpLVvMfFWIveKUdcq9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gzec7MUb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=udJQEnS2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D50uK0002098;
	Tue, 13 Feb 2024 05:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=A2GLpj6phi1v9myea55hgaJ0LAaKEWQELk7JINqSxmw=;
 b=Gzec7MUbs6bVmqj00w4n2+eWxR3sYUk81GHwa7ohTnSTXs9GL6EK9rih4awPUoGykQ0C
 TRxKiGiRr7VZcnxjMVkttRTw8h4JQGXN8JKOEXYaYCNyC4VK2tD2mMTreOIrGaWcNHFw
 gpISMd49MFO2evjHdyRtLDe97IbuiO97DI8dNaW4imdH0E+lxebq5wUrU56IF7H/fv5P
 FWJ3Dh+DWQn73UrKiKOEjUVJ5LGYmt9/oYEpgEh85FCigmF2CCEklV3JWMVXtKt62YiK
 QAf7rVCwYqfZ5akB9pUXHJNWOQ9K4AVkhJRfug9ysUkAkQLOCXiK0miub4u5STbpbbjL 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w81vm836m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3Ug28031505;
	Tue, 13 Feb 2024 05:56:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6tw4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDuMHwID/Zoe5WCrUmTc7DwGstaJKyDIlPfxtQZ1Miuj1QKYYmyD0mndGFa5MDCtCAWjNQwVF7KRgJBdjRpe8rjTKwdejHtPxL/14OaIkK7gYJDTlquRiF1iVvsvvLXRRop9bZvO3/dsCXCkW0ONG/j2kYQn29OXhUEjfwbXXdhcsYL0kUgvcwXcZjxRTcS52tPF0YB10Wh+7wxt6W0hwmhytGshBZF+1SpNNTGYczwEfd5bXEBgll0Ujz9mDoI+BIgf3FNWxRKtlIFiw2/rTagvjuJidiOW0Tnq7/bUjLKcvRdHfdyeeWVTdFEmwaSaeuTQOons0LA92AKuAeiPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2GLpj6phi1v9myea55hgaJ0LAaKEWQELk7JINqSxmw=;
 b=X1pP3TYpQ4KEufm6pIk9Y0SdXXx4J/JTbVnVB6kLRBSXK/vipKNCPeohpCytgLIr+odC9uAscChG5MpU6iMvhTa0qFeGvSzEhX5LZDfxb0WTwk2IPvbrzDnyLaZ0nU0gBBv5NRPFCEBHb+05WLC1n/uXSDdRlPFdmPWvm103zvxeM8+TK6IL7J75AJmDkBbqY/JG2TKfQ4ygUeuvcc4cQ3Xu41KX1mUdO1z4SciJZyj+/A4HzdfTUNWROp0fOebcYBpKIu8gWUUZIfDUhAK8xvDwxhWbFXGJlJo5beMBbxlGTBSCRQETD1DVWBHgkx37oLuGF/zPzJK5ixd0/FSfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2GLpj6phi1v9myea55hgaJ0LAaKEWQELk7JINqSxmw=;
 b=udJQEnS24k4OeBY7E2VcQLrZNXD7nqSse2elE3jX2MJzeG++NYac2V/waDSYWdkwQ+qQpHS0c46Cv11gPg3ahyQMiq35mBNFDPbM/VSZ/7XOCIDh0VZ9i2mi1KXsFKpG2WMMh7vgULRmA5YCMJff0EP0DZ943M3C99qHLy1ji4Y=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:06 +0000
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
Subject: [PATCH 11/30] sched: runtime preemption config under PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:35 -0800
Message-Id: <20240213055554.1802415-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0024.namprd21.prod.outlook.com
 (2603:10b6:302:1::37) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: f63e2cb2-2915-4831-65ab-08dc2c5877f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	KrBtfX2dd0EVm33NpEcKDkyrdvuvUXrW/KAzWbJ1OL/JexrX+y5qqBrFjvyVTbEXGfd9Jt6q8eo7jfenm5kKF+gKcp2T2DtbXtWpWiJvdoB2SjDuF2/HioAVO/UWEHFyjWYndY64AtGoeOoB0PPqIb+DIDMUReS/wlRO+iYZWbYVn6bp4MC9PP6A/1bSJY1360HVKtNT4eS7QoqDduZqrpqkBO2I5gtqO3TKlUiyk0ANh6GPfjljiPv3vPqheBiYznJc8cD9Ncfy5JYSuZfbFMFKVrxM1sDX8xDVW/KSUYOpKDi4Rbk4m5j/ykIhuFZJ+cgdNg3ob+EkPebF9fs3uY6gzBsihJehrGK8YJB08Iztq/qRyj7uitzwj0TEzkIN3mzM1Io8IyDmGMIIrPkrMrg0iH3deitN83NMfqyKc/Z6qLkmYqTZn1tXSw6vBg+4jYNtrZADC/EnpeMDxB1Ws0ZmPbQFOwOVVOpChPYWYS1bOuQ/mjekkETOYCXOP2LB79STqrqRo5vDzGxhzC75cqoulZ7U8chrEuRYkulEPFaZPk2SGcq+hSCgMJWrPP0x
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LRcTc3Sdn1rwDwDvt4fHVFcvRO6bFocPWEBirqeZfVr1T02zNPqucb5+hegu?=
 =?us-ascii?Q?Fgb5hKJ79iMeF+Q9C7EJdZ25jfLxrcWBx3mzwuyxCrK1VUcW32E+hSH+vVqf?=
 =?us-ascii?Q?Hl9HQ4QwjTs9ZJEtETS37PqY3lJyWqftuCs55pP1ZfLDzj44ldXmA/8G7Fdc?=
 =?us-ascii?Q?MvjPcKoPFaU7+nhTNVbuXiwY5NfhRQULrSn1WUVArLM4O2r3lqoH7wgsv/Fn?=
 =?us-ascii?Q?K1p5BYR3JQ0J/I+yc2ukNa4IfAaDvUr0u3oPeUT2O7rtuJFdOJfLDwijgvDy?=
 =?us-ascii?Q?BspIQXtMWrpdcuU8g7LMRMzaZ+lnt860emmYM8mYjp3kWoL2Azp+cm9wuL6b?=
 =?us-ascii?Q?JbeEm73Tj+96PWiuB52JgO51wyZdQmf/Hovi7lCzD5+H1W2OFJXMlxNObMIv?=
 =?us-ascii?Q?DUlw+Mn+JqxKdt1FYBdDYKwK+N74Tr62yqT2gCVzTjwvMrSSWMcRFQ+IFJyy?=
 =?us-ascii?Q?Yhx25cg5ZJ4Ztw8H102ZPYEdgOsMoyTVdT48RCJ7fUDyMfuorIjiaV2e30vF?=
 =?us-ascii?Q?qZKyo5z1jGJa6hywEcTwgNqH4U5zgGo3LDlRkZG8x8NQmDiHk0SM5SEq/gtL?=
 =?us-ascii?Q?/NcMf4atLHIo6ofXdmutPQF0Q4i7EzEux56egP1JNRsZ6Is7VrU+hrN5LikX?=
 =?us-ascii?Q?ziNCmtdWHaitsQZv8Ggmxo02Tcmp1j8q4SluPY1dxEY/YGxEAQJuS0vyaFe0?=
 =?us-ascii?Q?fnYDpTB/CeNghz5R2I6/fmIkxBmmaRVjiX1TzfnHxI9GY6Ba2y3k+ProijSv?=
 =?us-ascii?Q?1mq2PelmWOWwzOlKM2D0OZIjmj+f/yKnDfSWICTQsKBQjC91S9606Y32OBJT?=
 =?us-ascii?Q?gbAtRn2+Rl0OPlyEbJTpsRlJw/VTByzQ1zalcFzNkJIne8Yp54pyURxVvHlr?=
 =?us-ascii?Q?3viRFjDw4g0EHgES11r8N2YLNpfFkGxAgy9jOYwky3eas00iS8u6GWfci3m/?=
 =?us-ascii?Q?gHd61/Hj5Agr9lVpE+5fEkTMkqYt55jcx5GfGfsDwJj0XSQq4C9CQAFuFqaS?=
 =?us-ascii?Q?036dBf75pzGHKur31rW/nSIdk7rTYYzZo1IC+J+MqlBFxUMQDiibQo0GbQrh?=
 =?us-ascii?Q?94P8IoVcupPIfkjDJ2gHCp2++OPZE+8BVp2Kl3CcWjocI3W6wR5cRDcriQPx?=
 =?us-ascii?Q?kJHR8midzIu6b7p2VqCSFoWrHgbO1WHIFZmfSPwZAin0bqZBvf7EzYsBiASw?=
 =?us-ascii?Q?4qhtfzuffXT66TddMiOXMD9sbLRp/+88S3dCF4j/RZaqJZfsPK0ewSdZLe2B?=
 =?us-ascii?Q?lti3u51tHYBA+CnsP+s+2OyJCJkLkGbUGa4KqsURrBhgXYObtgIb0ocy+43K?=
 =?us-ascii?Q?fXJU6+Z6npakSzdAPIzAN0lxwCx0YCoefaMpyVHp6xjAPCRCXiQ6iqmyR2Yp?=
 =?us-ascii?Q?D+PoYrDrYwHgDZsJUqJ5K+QB9x9j3+IGQf2x97fKeUNXMmf8pKN4z0JKIPrw?=
 =?us-ascii?Q?J/oUamxFcxIi7t8NCTpuaYR3QKUgOLC3E0RkwgJMSSZfudTR0OkfhSwguVC1?=
 =?us-ascii?Q?Y3rS52DM4jlHPldUMWq0z3dqSosOZoaeAgJBv3z9zDXgsHGmjQhxSrbezfW1?=
 =?us-ascii?Q?hY9wWYP7odsbCCfQGYyYb87AeiG6fJ8nl+jFG/ZdEBPNSqp5QhrNYYpZhPz5?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HKPax4B0fWvznOZZyCC4MzUMBqlfZZ7lALHv3ZAfeYVr5k+CeNiHuGat+DnqY+ZXHx6VJD66rUhtSwhrpV+XGkQEiBxA5+ZmF2LWQDaHoKS01t6elpIy1i7JcRJtpjwa9VoC32dJeoqY/l0v1umzxt0EUxaQxXQh5dcJQvesZHjxgrYPCZgLl8jA1wpgh+vCS/bBMyPD48cUvT9hZbdlo8DOCHsM00XLYn9Mbz/mhFGicgJ8YOgNEJo4JPIckcAxqnuh4Iz3PDi5hHu36f06jpA1OoNoMfY5iQtc9svk8jX8rha85VhK1rmzWFX13b6YWZ+RRKoXXU6tbIdxj5y88SF5pZOliSTy0HRbUkDqUuKr5LY59vI1gztIlmNPBL8OE/9ZGzHzy3cCSvs9fwmCoZPGcMWNabF3qepITMKTENYc6zJacn5/+EL/NSV7HOO6k5VcUJgeaFHLv7MlyZ415ZzGId01lSiRTkNRqBZTKvHa+ZfIsJ8YLBPqTAIjjxzBbFBv85Psv8SSDCDoS3agwBxW/0M4U2TbElRS8vWFLxXA2/OvrcdnORV+0EmdmuVKLVJQ76u7gg4m4ukOjU+rxYeS11hT+ejGJ8VPOmELXwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63e2cb2-2915-4831-65ab-08dc2c5877f8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:06.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w0JNEXwhcrD8zFsY5T/zCQ/Rq+Do9S99PDG6RXv3sDbNWbK+f8DMK4y+L53VDwXQiXX+5pNYJZKl1CI7m7kllAx3jRrCCx8Z56Q3leTFEu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130043
X-Proofpoint-GUID: ebCTFaiJy3eEBBRGgSiCMsKWx5aFFUyc
X-Proofpoint-ORIG-GUID: ebCTFaiJy3eEBBRGgSiCMsKWx5aFFUyc

Reuse sched_dynamic_update() and related logic to enable choosing
the preemption model at boot or runtime for PREEMPT_AUTO.

The interface is identical to PREEMPT_DYNAMIC.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/sched.h |  2 +-
 kernel/sched/core.c   | 31 +++++++++++++++++++++++++++----
 kernel/sched/debug.c  |  6 +++---
 kernel/sched/sched.h  |  2 +-
 4 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d226c2920cff..58e6ea7572a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2073,7 +2073,7 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 
 extern bool preempt_model_none(void);
 extern bool preempt_model_voluntary(void);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c5de6c1da27..e5d631197f35 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8692,9 +8692,13 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
-#if defined(CONFIG_PREEMPT_DYNAMIC)
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined (CONFIG_PREEMPT_AUTO)
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
 #define PREEMPT_MODE "Dynamic Preempt"
+#else
+#define PREEMPT_MODE "Preempt Auto"
+#endif
 
 enum {
 	preempt_dynamic_undefined = -1,
@@ -8769,11 +8773,11 @@ PREEMPT_MODEL_ACCESSOR(none);
 PREEMPT_MODEL_ACCESSOR(voluntary);
 PREEMPT_MODEL_ACCESSOR(full);
 
-#else /* !CONFIG_PREEMPT_DYNAMIC */
+#else /* !CONFIG_PREEMPT_DYNAMIC && !CONFIG_PREEMPT_AUTO */
 
 static inline void preempt_dynamic_init(void) { }
 
-#endif /* !CONFIG_PREEMPT_DYNAMIC */
+#endif /* !CONFIG_PREEMPT_DYNAMIC && !CONFIG_PREEMPT_AUTO */
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
@@ -8904,7 +8908,26 @@ void sched_dynamic_klp_disable(void)
 
 #endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
-#endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
+#elif defined(CONFIG_PREEMPT_AUTO)
+
+static void __sched_dynamic_update(int mode)
+{
+	switch (mode) {
+	case preempt_dynamic_none:
+		preempt_dynamic_mode = preempt_dynamic_undefined;
+		break;
+
+	case preempt_dynamic_voluntary:
+		preempt_dynamic_mode = preempt_dynamic_undefined;
+		break;
+
+	case preempt_dynamic_full:
+		preempt_dynamic_mode = preempt_dynamic_undefined;
+		break;
+	}
+}
+
+#endif /* CONFIG_PREEMPT_AUTO */
 
 /**
  * yield - yield the current processor to other threads.
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..e53f1b73bf4a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -216,7 +216,7 @@ static const struct file_operations sched_scaling_fops = {
 
 #endif /* SMP */
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 
 static ssize_t sched_dynamic_write(struct file *filp, const char __user *ubuf,
 				   size_t cnt, loff_t *ppos)
@@ -276,7 +276,7 @@ static const struct file_operations sched_dynamic_fops = {
 	.release	= single_release,
 };
 
-#endif /* CONFIG_PREEMPT_DYNAMIC */
+#endif /* CONFIG_PREEMPT_DYNAMIC || CONFIG_PREEMPT_AUTO */
 
 __read_mostly bool sched_debug_verbose;
 
@@ -343,7 +343,7 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("features", 0644, debugfs_sched, NULL, &sched_feat_fops);
 	debugfs_create_file_unsafe("verbose", 0644, debugfs_sched, &sched_debug_verbose, &sched_verbose_fops);
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..34899d17553e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3229,7 +3229,7 @@ extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *w
 
 extern int try_to_wake_up(struct task_struct *tsk, unsigned int state, int wake_flags);
 
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#if defined(CONFIG_PREEMPT_DYNAMIC) || defined(CONFIG_PREEMPT_AUTO)
 extern int preempt_dynamic_mode;
 extern int sched_dynamic_mode(const char *str);
 extern void sched_dynamic_update(int mode);
-- 
2.31.1


