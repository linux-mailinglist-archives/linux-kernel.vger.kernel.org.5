Return-Path: <linux-kernel+bounces-67693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED03856F45
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BA64B2180B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8556513DB8A;
	Thu, 15 Feb 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eV3emh7H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GekgdusL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352C12BF18
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032352; cv=fail; b=WRYtmBkCOLxf74iaStnfT+l7ZvWPYohI9fdP1TP/IKBGvEezHl5U1w9aNyfqcF/k5drJSvZ8gpP6PSqpdlrHCvzLPX6bse4IPfvYcaRtlGYgmwyt88U7mIX2uS25j8L+ZnR57RTBOn/uTJeWeUqVZzZVde+a8VEVME0injM+sE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032352; c=relaxed/simple;
	bh=xhKh0BurhrN2tZ0FFaNg/Ohbljpaf42qxdDXZTlsoME=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=kxTe85Tr6fDjrWJthjvM2fSbhQXjyqwTWutwVv2ZcTn1sDfqQXSoc99ghvuqMswfCoa7QdkNAwBoY/Ic6gTbWjG68oAYyNA88GfwooqDopVAx6lApDxa2jZxiZlcgWA2cB4pNz4zXKjks+c0xjeJgM6Ohw5oC9exx+w51ppq8uA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eV3emh7H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GekgdusL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FFSrcO030968;
	Thu, 15 Feb 2024 21:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=YNJ/ZDH4IZe7YERdAAE7iWp/JEPb7pX5B+fT8eW5kao=;
 b=eV3emh7HWidKikuACy1kJGdMUl59SJesm177iHlu18RU/ft7wwfjx61bCywcPeBiqWnB
 CKTGQFKl+AVHthzB3CZHu7jwqjTmoNWlxZBjHFXgfACKOlwS/OfgpxBgJYuhDUYBKyZx
 75tRLen2IjoKgLPqa22eu/TZAphDGBxmXjBuL9y1PoAW8TtVvOYzjWv8mIwMP40PLcbI
 Bo1//41+kz2MgbAfqle2h65XowvChChSAGNXqTVIpraACvtOd51g8Dmi7LiNQlzaCbt1
 nA5lFMUCTgz32nSvD7dgvhZ+IdeKQGeCN3H6thCm7pKkhF4unQfd+ccLb4gKD9+/unrh bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w9301kaqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:24:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FK7Sgu031573;
	Thu, 15 Feb 2024 21:24:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykb58ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 21:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuRIwKEs2X6IMYIE9lNgtT72i/9a3BUdOZBjYdEJqehq0jB01iLE6o7ThHmWVpsfyazKTFFWXl2Jppdfb1VYMiO6Lgdp+pZcizJVwN/8OUEIeRdxw6i3RgcoAQQcx/TYMlpxCQLChRy6jfkvRLfPZ++A6x6SRqH5WL7PnSQM9U2zvZ4QmrGt3lmZKXOPFbkpzqSDdnb9oGY31QM9A/ZppbWG9LeEOMQmPgO0FL89juuMskjEQpCeaoXuM/wSj6pNHi5kHYXkEF6cllEAk/49gbVOWX6EGyBuz1jmlxAMjGrrPHSIKgoptn+6meFt2Y41ds5O7yu7Y0H7KSXFYk1P3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNJ/ZDH4IZe7YERdAAE7iWp/JEPb7pX5B+fT8eW5kao=;
 b=Yje/L98PdI+Z88N8kVbtQeh1F1mpU+1ttosx2E99Kv/xYtz3vWKgjcyFF5scwuU2cn8rkdT9eWi6axuDhZ5TnIvO7E/HMiSPDNlTHh2NKasdMtuYSiJwG5VrouLd7uI6/Z9Af8NhvYcmWFWSOND/EpxuIACDxOJL6X5P+AD5f5IcBX2LzaBWK0jcXhm+2o3ETmmwyA5/Jm+EhS43WNhYsh35yNUqtF0NzieWw/e0fSm4aGzdctoByTvevi404SVoR24xrEHJp6Ah3i4hOhB5tY5pUj11k3N1rj4W5rcV1EEtyiaDNWUBS8U6awNjGYbDx0s9h+JnKOMxj3Oc+d/7uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNJ/ZDH4IZe7YERdAAE7iWp/JEPb7pX5B+fT8eW5kao=;
 b=GekgdusLYEIS9hwR8a9F0Mh8lgzs4WUTpyqb6tITCkxH7Zox92NNxihNVdu3Zue1sGquFxnx8BjZ0BfWToT4TkvjQlfmVNzFJ+gFarOdF0gyXQfUIV38On2VjVlijeLEWfYHynCrlfp2zfoiDKQ3N6vOo9h9IdZQlNHoMQF0xsg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM6PR10MB4345.namprd10.prod.outlook.com (2603:10b6:5:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 21:24:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.029; Thu, 15 Feb 2024
 21:24:45 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <a7e785f8-d4c3-4b1b-9abe-36ac0b971e44@paulmck-laptop>
 <87le7mpjpr.fsf@oracle.com>
 <4e070ae0-29dc-41ee-aee6-0d3670304825@paulmck-laptop>
 <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
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
In-reply-to: <0d4a4eec-ce91-48da-91b6-1708a97edaeb@paulmck-laptop>
Date: Thu, 15 Feb 2024 13:24:59 -0800
Message-ID: <871q9dmndg.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0409.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::13) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM6PR10MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: e9b0c7fb-7e32-481a-88a6-08dc2e6c87ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eY2HU0E5yGQxJGIj3Me4YVNvIt/Z6x2eGvOW3U27a+5RoWd3r/0ggkCjL1BOu2uAHmdGSp5bCQSGffseZp98Lb52jKuo5H86FbqYpEJj6ODYh3jW0khrzGzsA3pwtB+NNaPRl7hw5pHXnB71RtrKvSlTNU3Nr0mFtKmdqGh+P3+5ROnprjEurHeoEj74ryXYDJjw78GoBojv2GX5+1ckAVsORkHYNCjZZuF9H4yX4jxLlwXGyCnrWwGCZxLTZuExHMYXxTqvnOx0QdYqR2f8FbEeBYAY/4nDeSuHvzSmxBz6Gh7A7/z9GJ5Uu59OZwm2LDD7Mizy/LO8lGFDTd60rgHMvV1B561zx/d0yTrjgKmOkEilMLeVanDxjWBt2PQeJQY+tLcUPbrYMBrJHRJlzyAyqf6eTIB0VBQdcb0yepLT2yr4hJKx+UqxOpuSCKY1k5k1SC9iN13LxsJu/7QCM8a6FEGcwoWljI1FPq756mJ1kIplh/FJPIImWYI9E3qKeERHw3DspaauF+jFrbj08+tLquXhIzJ1T27tmjTlLHTFZk1+wOKSmzlXcRJ9vzQX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(8936002)(4326008)(2906002)(8676002)(5660300002)(7406005)(7416002)(2616005)(107886003)(36756003)(38100700002)(26005)(86362001)(316002)(66556008)(6916009)(66946007)(66476007)(6506007)(6512007)(478600001)(6486002)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rk4M1vN0thzo9G4Cdmf2z/OI5nzKdeByRJoyJX2H4df5oSYo926TA+XKr8I0?=
 =?us-ascii?Q?Aao+qUylSbLKqcuXk68wcQSdgeYzYDUhLCTUB//Hgb6nPRPiNe625S3lDjff?=
 =?us-ascii?Q?DPV4u20N8laKIOCooaHd3YIIhqLwwVUeKLz7TWoe4tLR8ATn7HGpC1e/VHGW?=
 =?us-ascii?Q?xHXrjIUGUIK5pnei3Bci37fZinTkkr25SRgcVkez4+qMUo/bSzOLTA+6jiX/?=
 =?us-ascii?Q?3yuCXL2Ta5xfZmFHTrfRjkkfOvfu0qadyNxYrWpIF1gBbEcr+7NIz0W/gsCq?=
 =?us-ascii?Q?50XSLMnx6GumLG7QFNuMIyQkDAacUsLvg+jx0Demt43Lv4MqeZVKREThsJhl?=
 =?us-ascii?Q?EpwE2IQC4eIxNHNY18SE/MxFEUFnjer15t1Q2g4cKOICAmbOaDnxXwNeFEQa?=
 =?us-ascii?Q?IseNmEongp1lsCsqPY3Y0VlnhuviK42alA4JOC+uNo9kbWsI9AWs+GXs67GF?=
 =?us-ascii?Q?/vlmBVLY3BKTaDvaJgBw81xwgLyXVPixhkkOl8dv35UopqmIJRzc5CI7Cn6E?=
 =?us-ascii?Q?6FtCZ+fb5O1ZQGEjuECXCEOLu/I8RmZoJICwOj+rLNUrRimIuGoWygqV0JCA?=
 =?us-ascii?Q?scSA7yhM/THyMQYO/AzG3BBRrzgMvzhIGZ1Djn8zbWAjPX8MbZ+jWHcKLIFT?=
 =?us-ascii?Q?varWC+JUCixEZaNrqn6l7q8lLXIg5bmkqlP3PBFRYQZS3egqeaCGJfnhFbhz?=
 =?us-ascii?Q?qs5PPY6QXpt5WW/5Kevdz6D9ZzULC8t2+gC8RFd7o2CAhQhhtYl4PqH0Myyv?=
 =?us-ascii?Q?eIhPcNF1+REyAIA+qjYWZxXkQCJRPV+W/3oz+yJRRTOM2vfXJgZ2flMBhLmr?=
 =?us-ascii?Q?5KU8uRAAn6P0S3mCZ6t8J4sPVGgjM0g5hZGLPQbxRIalr+CDuC1GhTZiq8WX?=
 =?us-ascii?Q?CmpljKRNdqzw3RCMs5/mN3kIoIjPiC1d56yi85WoklbgA+G49nRunSjdKArR?=
 =?us-ascii?Q?agMBvWDrA649/sp+0wik3mccoqTWiFKeIYKDioUzlGbDJd57qbBv4pAkjo6d?=
 =?us-ascii?Q?+1LlSdsQWbU11jmY4K0Tq25M4VYAvMxKwfGm4POeeRGZPW79A7inVWFFeNk/?=
 =?us-ascii?Q?hjXtG3Yy1RHJfr8oCDHhPoFPueUWyf8nqUyR+EFVjQQOa1r/Zzz72lDMEVat?=
 =?us-ascii?Q?O6x3J2x6unHwtKwaI6iWyaUjNumRx2XPLH2b7bjEcfAs0D/Mab2k9tBt84JS?=
 =?us-ascii?Q?rrTgnylyRde8KrrMxKfd9SLXek7bLZ42F5GaCVgB7ofkvAIojFko55h91nuq?=
 =?us-ascii?Q?1BimL6acTvp5eLooVEvf3NNsZI1EElkDU5j3MxmSWSAYnHbkXaNJW5exYITI?=
 =?us-ascii?Q?Am5YROKj79+lYj0n5MYQ4lxli8WX5xasqOXTzyJ/uxuemB5IdvCnztwIML0z?=
 =?us-ascii?Q?akGqgwYVZAVuT1/y0SEaVmfwScDQ1Ma02x7dOmCG9czuzN210jB705ONNBl6?=
 =?us-ascii?Q?mijNZhs9JsYeQPdboaAvY8qA6Bg4KcjaqKshUHPV/HnIEQ4M6VvfGW+wNEnL?=
 =?us-ascii?Q?8DRlzFP1mOv/xEeolQ+rx1RyhaAwHSyzJT2H6x16POkSt7c3dFA8dK9Xp/z9?=
 =?us-ascii?Q?EKUWJKbwp/mg+3RGPxZLhbrh50ISMq43yjhVZI1T0DKCFJuUQeJPd7JOIINF?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fAG6WI0+m2L1HbIhnRYFICZO7ggwiCPBaXp+H0aDh40F+WpMAlV1UIsf30L0Z7r06avW+4lWJTQ5X25wgQ0jciODR0a1V72gnQUgnFU0t3U1kF6EwVTQbq6kF+wbAe+ttbDeQel7OMlx1KHhOWzycpCPv4uUBlFLdF5G7Q+yyz4YF6ZmsAdi2i1JoL73JJtJnOecrXDosTzWA9tOMFsDozBNyDSN90PG1XoPu3ozK7B4/ZkleVgUIlLZr8C1/Iv3GN30bn5KTKcUICtwYmCLClHEhaRd6SrirNZuDFzfm2bWfp7gX7yxb0j8MxvLC9MK7JTAmRK8CHN+B4uqKlHiMQokZfR/zo1O8t3xnMEwjTym6N08L2UaHRyq9uMiv3JMHA/JjD7DutgxqQHfkkXPcbgj2eArXHNOSN88tDgh1ZPtI5dGOyNDc3gucCasXG4HBM0N08mqwHyi/flebeJ0dgcxcuWMeobmE6ek8w/BQ5Wn4UF0qKmsS7GxXsO2VbbjFyIX6HkDh2NAmlTT0IQddT7r/qE4dRqUbFb6+lq8ER+KJ6dovI34Z7K8ROxz6+xAVNCVSW18VsNLgkbDjx9b6qLV6eOo6QkaZ5Glh6KnzuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b0c7fb-7e32-481a-88a6-08dc2e6c87ba
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:45.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qJwiyGa+5YXZqB9s8Ew3+HpuPPH6fMXE4rr7trZkNtTzeOu/nzXGMDviKg9qopQYPgm8IAPO6tyHiZSSVB+acjGL00nV92Mhcxyb205B4Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_20,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=853 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150168
X-Proofpoint-GUID: ukEcdPm2IB6rxfrQDquYu6vsuNyztm9n
X-Proofpoint-ORIG-GUID: ukEcdPm2IB6rxfrQDquYu6vsuNyztm9n


Paul E. McKenney <paulmck@kernel.org> writes:

> On Wed, Feb 14, 2024 at 07:45:18PM -0800, Paul E. McKenney wrote:
>> On Wed, Feb 14, 2024 at 06:03:28PM -0800, Ankur Arora wrote:
>> >
>> > Paul E. McKenney <paulmck@kernel.org> writes:
>> >
>> > > On Mon, Feb 12, 2024 at 09:55:24PM -0800, Ankur Arora wrote:
>> > >> Hi,
>> > >>
>> > >> This series adds a new scheduling model PREEMPT_AUTO, which like
>> > >> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> > >> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> > >> on explicit preemption points for the voluntary models.
>> > >>
>> > >> The series is based on Thomas' original proposal which he outlined
>> > >> in [1], [2] and in his PoC [3].
>> > >>
>> > >> An earlier RFC version is at [4].
>> > >
>> > > This uncovered a couple of latent bugs in RCU due to its having been
>> > > a good long time since anyone built a !SMP preemptible kernel with
>> > > non-preemptible RCU.  I have a couple of fixes queued on -rcu [1], most
>> > > likely for the merge window after next, but let me know if you need
>> > > them sooner.
>> >
>> > Thanks. As you can probably tell, I skipped out on !SMP in my testing.
>> > But, the attached diff should tide me over until the fixes are in.
>>
>> That was indeed my guess.  ;-)
>>
>> > > I am also seeing OOM conditions during rcutorture testing of callback
>> > > flooding, but I am still looking into this.
>> >
>> > That's on the PREEMPT_AUTO && PREEMPT_VOLUNTARY configuration?
>>
>> On two of the PREEMPT_AUTO && PREEMPT_NONE configurations, but only on
>> two of them thus far.  I am running a longer test to see if this might
>> be just luck.  If not, I look to see what rcutorture scenarios TREE10
>> and TRACE01 have in common.
>
> And still TRACE01 and TREE10 are hitting OOMs, still not seeing what
> sets them apart.  I also hit a grace-period hang in TREE04, which does
> CONFIG_PREEMPT_VOLUNTARY=y along with CONFIG_PREEMPT_AUTO=y.  Something
> to dig into more.

So, the only PREEMPT_VOLUNTARY=y configuration is TREE04. I wonder
if you would continue to hit the TREE04 hang with CONFIG_PREEMTP_NONE=y
as well?
(Just in the interest of minimizing configurations.)

---
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04 b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
index 9ef845d54fa4..819cff9113d8 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04
@@ -1,7 +1,7 @@
 CONFIG_SMP=y
 CONFIG_NR_CPUS=8
-CONFIG_PREEMPT_NONE=n
-CONFIG_PREEMPT_VOLUNTARY=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT_AUTO=y
 CONFIG_PREEMPT=n
 CONFIG_PREEMPT_DYNAMIC=n

