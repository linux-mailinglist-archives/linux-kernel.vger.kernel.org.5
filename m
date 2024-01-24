Return-Path: <linux-kernel+bounces-36319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9390839F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AD4B282BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1CF5C85;
	Wed, 24 Jan 2024 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XkPqsDYh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gowlRP9X"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C5468A;
	Wed, 24 Jan 2024 02:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064130; cv=fail; b=DLyFbnB161bjkR6g83bfpPcm9Jn0AsXwdp3hvPl1OPYUNlPC8hWPdpCRaP9CWLyfjI9egRV2XiGfmKdqumypKFQ5951zIUBfS61ySgjFXhCQfvCn3gzio8CRHpEAeSrhorS2AIyP9u/f6wlVO+3KoJV2mfGvaw1SbR6Z8wB/bT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064130; c=relaxed/simple;
	bh=FatQIhe9+AJzWnPCwgKW0o7SuN4lAsFSox5sMxOgBgU=;
	h=To:Cc:Subject:From:Message-ID:References:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=cyLcd2w0HP1j9mi6odlds/WHamBpQB1QnzAfmDaRxZJ1t1eFFyyIG98FUlVRFzyXzyuTnUj/tSHl5JdQj1RwymHTp807w7L9pTICXY+HgBb89qeBGJQwsHZbKL1p4Q75bu2z9YVBx12ZYx4fiAXupoH9NGtI88t1gJJEVb1wHZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XkPqsDYh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gowlRP9X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40NNGvEa010799;
	Wed, 24 Jan 2024 02:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=/yJDUBo0TbE3/rx/aBQdJ9Q5eHmTofe2Du34MghXUZ0=;
 b=XkPqsDYhk03YlZfIMn/86k5HvhFn+1r9PMrnbegMmOQzlXdJ7lMCMiFY8KQVM2jFWpdT
 sudgJFjaYImv1GcEcLs3A164/ziUoKrnVsnuTvX3l0Hlu6SmjU1vH3/PUQJfncgSCeBT
 oq210iFSh4eYdo5p/obqKUuQ7CjBr09S44YploW8ZGId+WzAg6DMp2PPYNlf8GWpVUlR
 69RVeyNAX3ho277mwazf+vuY+TU9Mc3WH+VHSHI16JwDSO/Gp3mrGULC3Wc2oLBJpMJf
 ioc/ZhQK9PsfUA98YAAKHCsuNqTFNcv8SqKzdfnQo87QbI1XFIgoyN9kmWSyi2QUMIcH 5w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cxyt6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:42:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40O1RIVR014637;
	Wed, 24 Jan 2024 02:42:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs3727wtr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 02:42:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9B31tCHCnA0GO7Soae2oA0yUuTVFolzwgGgl/2BM83YRrDYK5hmzwdLmdxqsWfl8Ve5fapliou9JrDD2theibv2IaVeiyS4b0HezNxntYuHhwMucVbIkFikKZ2MENH6Bx8DEcMsf2oIipquSHH/XGajtIZEuWDkE6DYxP8mi99TMHrdTTmlQiCp5TVAO/sZWi12cMegse9yQVVjPPBLTdnaB6dd9HfGxcTxU0PAyOPXv2ReGBIsSbMbmV9hedUvnLMZdCD2106aARKgVxk1PXEn4lQp8XYeCIBRzo63WqvQs9TLFgRd2VWTI425sOCLRYZkiF+0JHea9tWXbMPtkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yJDUBo0TbE3/rx/aBQdJ9Q5eHmTofe2Du34MghXUZ0=;
 b=OuVcqYfT/lFgpPX3UiCX8IccWoYaPnS1sGauwQ0B1r7NpOlyGX9tLaejWyD/oeWeeOzVpCOUSi4nRVoVxUTgNx7APy6ykV0J6SBEWPcUS3PEEcTiWxf53AgeKoKtZDkYaXlSF471IWuY5igBhkRLNTz1HK03S6ZqB5eQEdAJE6GGVydOBoymVqqkFf0it/sfVt+sU4DiDF93b8QJ2eKtNpru21cy+apBae4pE/aeDc/5fB3GkW1prbYu+EEic5Yg5Xf31VrCY9qUVIpiL76hunqaelsSiXNtcMIG9q1oI+UryWJRGNEUpnCaQQem1P5MrZZ4XpUu0Qx9JDs8uy1+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yJDUBo0TbE3/rx/aBQdJ9Q5eHmTofe2Du34MghXUZ0=;
 b=gowlRP9Xum+1KsvVvX2RDhlkCfFDbyON+LIlKWBha6zdb4ouwrDOPue4pQ75EtFuC9aWXtvLLnfzq6b+X/DHqI4UxkTI5hzvBh0gda/BJErmFjqdWjG/y1gUpmmS/KDtG3JIUWrovKljMrp1Ikse+Y0aSa5w8q8BVZDYu6Stars=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Wed, 24 Jan
 2024 02:41:58 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::3676:ea76:7966:1654%4]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 02:41:58 +0000
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Justin Stitt
 <justinstitt@google.com>,
        Michael Cyr <mikecyr@linux.ibm.com>,
        "James
 E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] scsi: ibmvscsi_tgt: replace deprecated strncpy with
 strscpy
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15xzjxxjr.fsf@ca-mkp.ca.oracle.com>
References: <20231212-strncpy-drivers-scsi-ibmvscsi_tgt-ibmvscsi_tgt-c-v2-1-bdb9a7cd96c8@google.com>
	<202312121321.E15E09BF@keescook>
	<9f246fbc-b2e4-4585-912d-a5a00ac8cd04@gmail.com>
Date: Tue, 23 Jan 2024 21:41:56 -0500
In-Reply-To: <9f246fbc-b2e4-4585-912d-a5a00ac8cd04@gmail.com> (Tyrel
	Datwyler's message of "Thu, 18 Jan 2024 12:21:04 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd6b085-86f4-4108-1353-08dc1c860932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MPha3oe79k3mE3e1BFpUhqGD0tvf3TeDWzJLSw/t0/oW31INFXHtPIElp1mqTC9QqdhO69yC0S3HW3Hrs2Mlwt3OxOk/CINtIqz6V3GGBnPQIGCJbVp6cniGHTTgiO6e1QGReON6gc8Ofa6kalXgfxVRdLO8HrJNFlK2lWLVeW0LsAMqiYhmF2/00UiXNsvmeN9z1e8/oc4jjAiQOaVCTnLdeNtKJRP/n+V+m4lJA0+KfGl6FCdL7DaCDSf395tGWUn4VcCKH+0eVp0+0Hq8CD2Pv62VIeSPYB4Sr03XNpE0MLClOSS0J9IBNXmZjKzxNptB5ZnuYFGGaTnZRgJg0w5QQBPfc/84esyD9PW8eBdDdNgk6s/gxCgX0bhx85nm/Cv6C6+rivCU2mQYckgVk9KeDul3BtrukSzqzLfM1l28o3x2ZB6H598kw6RG2oW+fGOHqHDufH/vr3ScABi2xKVFrAAlH8aLIh5ooQDU65xtMy+4+dIut8PSAG4xl5IRxm4A6v0RJDZUPDq/VWB7PDO8xM0jjwLAr1D2yC9S9XuiC1evREJ+LMuvvLBSPQ3f8qQWnGvw8tHjwJZiKPyuuoXqf6R4/aUJl6z1q3JMK2a//A4KXMc4ZY0mzxTZybQj
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(8936002)(2906002)(8676002)(5660300002)(54906003)(316002)(6916009)(66476007)(66946007)(66556008)(6486002)(478600001)(26005)(6512007)(6506007)(36916002)(4326008)(38100700002)(558084003)(86362001)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jX0RnB/VkA/Hy9LQKd46HAONKmdLCJ0/LqOWz9l6L3wW3E72Nx6n5M4nxhl9?=
 =?us-ascii?Q?G1ID6FTvaeTokajZ65Fjn6hw8oAB0kixxBmGWoaDomorvHPLQV9Q9KHVaQ47?=
 =?us-ascii?Q?fzow3Bnn2WU9uObeImy5CcrtC6tMhxNS/CWd/LyK1PEMOJdPCLXqG6Jo2jUH?=
 =?us-ascii?Q?N0UjK2DyqSlDmbX04aHgd273acBcX6+RK7to6idNm8bJ2GinpdPBWXQNW5A0?=
 =?us-ascii?Q?oXO+Sz/1zl5/Zvd5QX9Eb1Q42jWMp/Bsg5GfeEmZ6WKAqBu6V2b5VCZ0Xb3U?=
 =?us-ascii?Q?cWFMVHOhlCWC1moKlpSXR315ceqS2+Cm3YYnbeRzTTQfW15hLF1YKW7ZvPaT?=
 =?us-ascii?Q?dhf7VH4MhNGCGp6+phDtuInFmpFWXBVARaaGlYNj57XIsAkD9MEjK/0znoPX?=
 =?us-ascii?Q?lWwOGmDzntckGa64q12xnUrH3PcoOa3Vyts2an3XDAvLlh/sZdOl+nMvJoRb?=
 =?us-ascii?Q?4B5hbW1E9cwyVWo6spGvok5JV/PA7r3poNDvaQadhCn4RahzNDEhoAWqzDpg?=
 =?us-ascii?Q?xAKBP5w+LTsEXln0jAnHqpYbeScE7KztVgA2jNLdIikP5E2M2KA0g0hm2qZW?=
 =?us-ascii?Q?6IaBOhSh/5JdFKQCs38tV5Uam2pUPRdzlzCKPPx7zb7TGIKzJCS3z588P7Mv?=
 =?us-ascii?Q?BZFtUGvTZMJQUHTsqqKxa7n4EfIiIj2CVoVWywwaS5YbqMiTahi1G7jgFnkD?=
 =?us-ascii?Q?THMhngK6OimYtpPpC8tusiox0DC/Pb8E9250QRLu3W3p9wW8wvCJpLO4JZpD?=
 =?us-ascii?Q?uJD1ievVS8YMnElgh2hCeHIGwqPLeH4xWfGK4WLwkmXDMttdkBrVZkNScltx?=
 =?us-ascii?Q?gbD+zpcEa5nfAoJQkGV1D5LncIGhcvYT14XJjkBhmz/M7/nOt65Dh19eD2yy?=
 =?us-ascii?Q?qYdziZC+bkn1tkd13SgotgCaVgudOTxeTL0WhhZHaGAq0zBpF7Lyo8XsPq4L?=
 =?us-ascii?Q?th3MBynFe8HppSEllByue3+v7/VW2MidzsMH6Z14ru7pLKKh/y70JoZ6NU22?=
 =?us-ascii?Q?Etu8qARqLIWbnpIdlqgrbXIupUzrLmXWRQUrtuZtJih8AgydpSqxUL6RkR/z?=
 =?us-ascii?Q?Lestts6VHxvPmNaDPocX4SkZxyEEjpaqx3b6fsx0gryPXYUl/gVLxfGfQrjE?=
 =?us-ascii?Q?dOscMsSamt3N2x2M0zcnQEAoA9QU8zrf1U41oQPjFK/eUJ79vIbNJozwqH43?=
 =?us-ascii?Q?cJmaqsLipBagyn0CFqq3oO7vm37QEug5oaD4DS9knk5tBfRqaZg8D0KzP2KV?=
 =?us-ascii?Q?pwylCL7w76O9swL/UNQEHXyKgLaTGGq6hNJFV9ctv5kQQ0nQuaiLcs1pJ2Ox?=
 =?us-ascii?Q?ZY8CC1IdgKWI3yM/VZf2B/xLK+sCqVh3OqRHN0pIFLqusX4Fj0hkUlnvXMHJ?=
 =?us-ascii?Q?Stcvw5+6wV7ZpuEnWqpmhQhRv9xPwMwIQse2fmsgjtEfJH3GgYCBNN6zj8h8?=
 =?us-ascii?Q?kQcIojUTEx5A0TgI97/+EkEmHgAQspBUKn7ReOcF4LO4uxTM/5f4z0TGzOqU?=
 =?us-ascii?Q?QvZ7HvcGPWB8OtDJAdGZKDwRWiAiblTvft+/Wkc8BY2FOQNlvpgUdPHMb1/q?=
 =?us-ascii?Q?CZI8CqdGJ6wk4CG75TGIeefly806mQPHUkHh+Odb6Y7+MnJZnqoAnbcz82I6?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZXhOoX7AYRaBXdA7HqG4OK3NcXaj49iTyrGoOisFN4m/22XPhbB9cYQqO9SVJcwS/BJ+wE1RzW06fx3+DC17KmJQs2uUJxnXohnqb1Pqse/1VQv/b+dnr8/JIIEgDOKdJOhbiyKtdw5uUxnQeKtzjucl7rhbVY/Q/F7vHG5V/HGzO+erCWHzI2llNu2kYwtY5HO3CPuJVsVbiFE2lad+J2IscCGl87rF+vDQSQ0cBsAOlp4D/ir0zGU5TqYIbLgSYg7pUw6zWA+dwHWhNF8YtkIZafgH6qCElZJc+Es9YgckGYbFcCcSPL9FnHau5SUvEseds8jybGHgfXqDYczQa1zrhcWbAnUeg7bULRGO1VnBIMkDq9MONV2qGYG+TWaLYkosBR9dWJ8hC722JrxThd8IfthgM7n2uo1+dk14HSrdY1G44QfdUVrOSntk64X5BUYMYWvX0iw0h4QvnJcEyo4eL9i0ECs93F2dy4sU/RIm97IswGbDdBAdsAHLYp5z5BoDxJFk0KLrOy+Cs9E9qgDXz++T6zafx06P45Dz8GXVVmaymE0RRBi2YG1XSIRUrSOKya9u/P/8FarrwfrPj1ZaGyuPni9hEPzqBofBZA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd6b085-86f4-4108-1353-08dc1c860932
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 02:41:58.6631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flqJCVtkc3oHw8LvuIKU3j2mpdySXu9vJAd1wKdf5peSCYjYFCG49YS4v4EvJnJbXcfX99YSchPXgV/TZPNsbWy5eH9lstLNbAbFmClc5l8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=738
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240018
X-Proofpoint-ORIG-GUID: NMJNXUzQCUNKsyVXKu-618RArduSQLCH
X-Proofpoint-GUID: NMJNXUzQCUNKsyVXKu-618RArduSQLCH


Tyrel,

> To reaffirm the assumption, as I mentioned in my response to v1 these are
> intended to be handled as C strings.
>
> Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

Applied to 6.9/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

