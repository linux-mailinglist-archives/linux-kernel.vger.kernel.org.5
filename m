Return-Path: <linux-kernel+bounces-62964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C9C85286D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E628268D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8B1B277;
	Tue, 13 Feb 2024 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l/pyXAhm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aDW4HWn1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE017995
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803824; cv=fail; b=AkerbR8K7XwvkCSe/I79hw1Kde/EQC5+WjrhtiMcVoW5OpUpctjOTSQfUr01ZrDDP4z76sj1Vue2+ASglvov4095jFjx2lcIJKvajULMvAmdLy/5FLZY/X5FJs7rz+v1vBCSkgxEPFOGjcPPBV0T5i8aOsZMNrjH9seBOhLk/5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803824; c=relaxed/simple;
	bh=uyJvof1Y84DCTs62xNaN2/yfkDP/JhPAVxfDuZlMrSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZNqFD3Jna3PpHUm+ifJMnU1ZFOV5oK1Bcwz37EqmLI/p77Wr2QNHtSvWECik6zqMLsDOdFFttcWgtsbBMOCuN6ROIwK2PXZye306C/IwrEZ2W33prHwhTdYKAekmyVwGVE+Zo4sdBJCG5PeeWqfqbZnm2ZKe6UVtZIeDQyYZFCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l/pyXAhm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aDW4HWn1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5nJTS013833;
	Tue, 13 Feb 2024 05:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=tWjhyKlLEwGO7Nsfh/khG/DAMH36BSalzUK3LRdpXrc=;
 b=l/pyXAhmdlpeLjZ4bQO1NnAmmto20mPaDytTyfobcsqL2XWa8mnBmmXb4n66Qmnyai8q
 D9myqvSvFclfyBecsj3pZzH/Fln/dQbEb5Se2qtVXD9bwlzH3N6QVla8xEY+DYODxVjM
 OYf8Ge9Bh/wtNbOCAN1+zfFPNhZtwAqCISBD9jwOMrELQ4iVgaguLbQ0ACwrfTpe0Zjj
 Ed09FWhdHJPFU0zrKNTCuzIM7NU1Ce+3AbTLMsH9lgBFmKVLVBZafka0esDiT2eMluZK
 Ut77/6p58PZr+VxvF838hPjzIUNbxKo1SxHG3DDdGEydC3mEL6i+kAtnTT4eTln7JTnl SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w816tg49g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D3XGS7014943;
	Tue, 13 Feb 2024 05:56:06 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8ak-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Exx6NSDUFTxbB7mnjSyhnFSqWkWPJ9LRs/uHuOvCfOk5v88bqRCWh4kFfL61zBtyWz7HD77VoYPGeY61qRXfEngh6TvWchX3ay04zioKPkg3pT4V4g2q1PjrBXYJ3a79sKPVgZ0CRY3M8dyDV1SUlgHtbXrSxYrV+yaiiTnyRSHdHXRdYMBmvPXnWfBig3bmxdc8xfFR0GzA2fq6jwmAQ1WW6FqiBhnle/2ME2S43+3cF1WxpGYC4s0wlfvIW/ucXtu0MD+8jfwN37RyPDh3oZjE584Au79Dmub5PXYGjDO44x0NHCuuX7yt+Pe4IktmUBX9aI/OMU9gNjqMsrWiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWjhyKlLEwGO7Nsfh/khG/DAMH36BSalzUK3LRdpXrc=;
 b=OTL/CxM8KUBctyAdOiF95OtG+zYbafVRoC9O6YL4WUGJTQptk/OBblxr8o/k/qNevKBSWY86ZhM2ZpM9VodLeQpmAcruvbTbkVWCg52Cj89tZImvRUxrRZm9DauyE8MgVb37XD44TqKVBDG4REHSap60htBY5qbel/sZjLGfkIQiZeQ+nvgcED1AtIL2wxIj1B6pINd0WWWkCgv49LdGdGoJty31ZXeXCiX2mE5vKOONWWgpnlyuWl7GXsha+Ik7AJ2L8V44Pp8+YYihC8FIhejwlFwVkEmV7KE2ss2hwaa2cXi27KqZODR7I6lCvb4Di0nspi+bAUU5zwU04ck8AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWjhyKlLEwGO7Nsfh/khG/DAMH36BSalzUK3LRdpXrc=;
 b=aDW4HWn1BB5dxq+ojHuO39Gt9rfwuCoWEY8aGzKMLlECkhDE1riipMubw2Y+nPkY1Nmni+ORjtZbVUf1tAUMqY3EvX9Wu15Dvg9Q0/rbOyQ3TcdBf5T6gyzEvZORHW6kHLC4YAi/pIzSHBObDlOCyIB8rpX5aPuoC5rEegaPrDQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CO1PR10MB4642.namprd10.prod.outlook.com (2603:10b6:303:6f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:04 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:04 +0000
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
Subject: [PATCH 10/30] sched: separate PREEMPT_DYNAMIC config logic
Date: Mon, 12 Feb 2024 21:55:34 -0800
Message-Id: <20240213055554.1802415-11-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CO1PR10MB4642:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b4eefd-9be8-4fa4-a75b-08dc2c58769f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3SdKWUc+6Q0NH7Ehhj8rN08hfbh6GC0aWTpXSCGYg4SevNzmmOCQi1sl0wmerUMLz6vAqsSh4EYtLFtBIiHGKSmSS3A6dvRIt2mA8N7Xjs4W0/3JK480UEMwIYiuuFXgaqITtAlT0Rx2enWzzw+AGhnylQG2Zsaq9gz1qK/P30/W18w+w+4Fe3i/sUHAs9QMu8g5IyKXB0DQtCPpCxuVFJ31Xk404iabEV96xrdfbm2aRh57C6gh5nWqKvjlwuatoh9Q8+eu/Eddgo+4yRR4qYPEiyD3DWDkx2m5PMDDktb03kAbhX1YNveJqbWny7ALZpqq32oruiSExBo4+ueuD1jPMku7mJES+oP9q6VfTh82WwyUIapfHjAwGgfsnSPW6yyM9udMkeag6Wg2V0ey01brDUovV2ZBi4/5jjlhI5ffLOnhlnco8XEWI5XRfTqdOD5qV6Az8Cy8IuCcf4p5bB4b/tDQHoRbzpScn0ZIMFCt31CfRVvIFAptEQBiS3vzGf2Rftl17t37nc58cKAVoyzpAlOA4814TNiAfcQ2p1pS4i0/h9PAS2E8Gkr/BMIE
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6916009)(2616005)(41300700001)(83380400001)(26005)(1076003)(107886003)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(6512007)(6486002)(316002)(6666004)(103116003)(36756003)(38100700002)(478600001)(86362001)(2906002)(7416002)(5660300002)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wXQyaeMmlWuM1M5v+rJPy1VQJgjbVBnNiLIMJmfHCavmAtira3nWOLkckifd?=
 =?us-ascii?Q?OQMYHWoJflLCBWTsbir+bNIdrCndDCOUKVjat70c5bHjsIYgA3z86/K/8IKe?=
 =?us-ascii?Q?phZT1+zxrkRSJKqh2AFWpKHacY7vzj5U0XyAsQX+pYCEwrJgWMp+gxyhpjCr?=
 =?us-ascii?Q?OlchQLm9g7J1us8KKqnjSx0CIlMNRQfsDd8ex6JkvFOO9zDwMWQ96PHi9zw6?=
 =?us-ascii?Q?bEvMTEK0GQ/4mvQY5kBOwm3GWVTlY3pBIMCK2aS7klgkCVdf83rrAROBXPMp?=
 =?us-ascii?Q?jTgJU/WksN+VVqzvV+uIxmu7Nq7AhLTWXSdcBVfUhLHGJlNsX+nj5uF/XkRz?=
 =?us-ascii?Q?wGD44/585mDhmGMFf44Q1DbnvN1SgQd10L4pMvvAewBecjnMaEJZTYlrZ1jA?=
 =?us-ascii?Q?0lCk2CRvOb/d1S8dWqnIaRV/pN1ePTC+JXnfnqR1u+NMPJSISDcyaRQmHKgy?=
 =?us-ascii?Q?GkWRWz6DYaTBDvC6mhk8++Fw5l5q8AkSS8YH9YNXmKUDjW54oHEA6tmHcKxu?=
 =?us-ascii?Q?BUucwyF7rHO7WLr0/OU1RKW9NXlnnofMV/zmFqf/iPRYaM1YvzziDFPo3v96?=
 =?us-ascii?Q?PFfutTqIJgpyR3N69Ahn/ng3OmXRffCH/uqlHFbC3QERwNrHpIyGptR3iXva?=
 =?us-ascii?Q?rj6AW/Ldz4lCcGrDecRxT+abcAZJ124rx8bpIY1zvsklBPxLrWAQgolJJl9j?=
 =?us-ascii?Q?ZpsqxRRWspVft+JQAdubHgJZiJYnskux6ARpRNdLvU/mzoXsOSPePIEM6mbI?=
 =?us-ascii?Q?9IRaJXSjmgrRNtqgLfqOpGCA1Y7EeUXMMRcPG+rN1A4UHteqMs5E2o3w/JBf?=
 =?us-ascii?Q?rMH4NQFIJJuyl86eddxboRyJ6P73SEv32yk8WUFFjVKvpg0Wz2i3/+d6fDZK?=
 =?us-ascii?Q?Qgk+OGHsVkbFj+RWqXNZC1Q1rrhmXj9aHq7VvZR2lOFc6a5ik+RuyrXMve7t?=
 =?us-ascii?Q?BWzHs11ACphT5Nvfrs95W0g1LGCN+gRSC6gVwWWnb6BYXsXcLmm9Uib/lZAb?=
 =?us-ascii?Q?50QJZGvEJZboXQVz+PY7DDvaxxXt0RaIiXO+OInaMVrcvoNNq99Xnwel/qEr?=
 =?us-ascii?Q?8cGEQE8zZ0jSvK+zvApZHrw6wACSjvOiMg3YnwnwPjgu92zLSAyn/B6gSmrR?=
 =?us-ascii?Q?H/9O/XgzKqbGZJI3BUSF1a51n4u6YfX/yGQxJ+JJPGDW63LRrau0gdGwKWWz?=
 =?us-ascii?Q?OPJ7XI9JA5sPFrnEaFG3u83WbKipCmbCImCwxRPEfXjZpnk8rrQYvps98ZCK?=
 =?us-ascii?Q?Znl1fsWfw3t48k6d0DqEtXrU4Oo5Kt5fCoTaXbzOyHUmZwQKiOkl8uar/Rej?=
 =?us-ascii?Q?rtzSxzBBEDQgKJR4Hdei2RHLMLi7/oEph5ZElSKAUYssb5CHxTvhqTHL7kID?=
 =?us-ascii?Q?JRHVTV0FcZzw+0l2F7SCOX3yH2V9bhRtKeRMhme8D+eh4r98FMWMlQoU/7yN?=
 =?us-ascii?Q?Ib4crInSRGHCY6INQg3NxnxAsZjnnwDuSxPluV/wj/ZKgm+AqKQAoOlz8HeA?=
 =?us-ascii?Q?MLtDM6vS/02eJRZ+aw9TEYATnMDh7ymblPDoE4jdPzb6vINeHo33AHm4Y/su?=
 =?us-ascii?Q?yIw/k7/YzVb4BoyBFInyyAwZG42zovqlohd5A2iG3G7zAV0GbhAXgEeT8lFa?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ptrz4irqTFYNzEu9jNP1aP+WO3dF9iVlU+nHiNmr5YXi+FozzKx1azOxoyhgkburuwQAhKWGfyzDmH+/vKyjLZs+iG7YH5FSXhTCKA4AV2cuxqlErNycAkoPcyhlgSjTXozwUuzTxhQolxo4BsPokszB+I4UUYl/BLIfhmXe30m9SA7g6LcV5SpMz5zK2kCSQrEEw7H6rhs6t6LNflct+QEpU+EW4cpMFLziH+0IdJ8Hm+vUdyTV9V4eJNZdE7iZMTh+cfAQYakqxxhlpb6hXSPnNH+mXsCOiUbdH3dSyqNqB68G7i4uY0scDNEM7mjSpIwAb/mODEB4Fliy10P4hUUFvYReG//kNNCk9yCICF0qdAvh11dRzRXEX9KgMD1lFF78vDnpCG/mrtsvPfWv6oSuhOanuVyvViRGuklC3QDiXYs6AUYr2YTt918vYXms/Q88mbaT1xy82/UHnt3AdxbvRjNE2XSX+tSPabNee/EA2NINk2PwTkN7vJ8iiac4Bi215uj/9P5HuNBF0H6O4yBiPdjhqTa3x6J4VcyscC78T+8Q92j17CSuRvwmlO1wih1G4cP4JwWa64xvN1mXkoV7eViVwkd02Wiu1B6leLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b4eefd-9be8-4fa4-a75b-08dc2c58769f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:04.0526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3i8slpFIc537vDm2XVC1SVlIVe+cKVACkgEg15fZFHseYsGCZBmsZTJTTZj2t7XKRlZUvuIsJzVVoyAScXqbRMv0iuB43SNVDJP+oVZTZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: FzI2GUJiZPzgGZvsBg7zonksnnwLlYsW
X-Proofpoint-ORIG-GUID: FzI2GUJiZPzgGZvsBg7zonksnnwLlYsW

Pull out the PREEMPT_DYNAMIC setup logic to allow other preemption
models to dynamically configure preemption.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 165 +++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8e492d20021c..6c5de6c1da27 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8692,6 +8692,89 @@ int __cond_resched_rwlock_write(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_write);
 
+#if defined(CONFIG_PREEMPT_DYNAMIC)
+
+#define PREEMPT_MODE "Dynamic Preempt"
+
+enum {
+	preempt_dynamic_undefined = -1,
+	preempt_dynamic_none,
+	preempt_dynamic_voluntary,
+	preempt_dynamic_full,
+};
+
+int preempt_dynamic_mode = preempt_dynamic_undefined;
+static DEFINE_MUTEX(sched_dynamic_mutex);
+
+int sched_dynamic_mode(const char *str)
+{
+	if (!strcmp(str, "none"))
+		return preempt_dynamic_none;
+
+	if (!strcmp(str, "voluntary"))
+		return preempt_dynamic_voluntary;
+
+	if (!strcmp(str, "full"))
+		return preempt_dynamic_full;
+
+	return -EINVAL;
+}
+
+static void __sched_dynamic_update(int mode);
+void sched_dynamic_update(int mode)
+{
+	mutex_lock(&sched_dynamic_mutex);
+	__sched_dynamic_update(mode);
+	mutex_unlock(&sched_dynamic_mutex);
+}
+
+static void __init preempt_dynamic_init(void)
+{
+	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
+		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
+			sched_dynamic_update(preempt_dynamic_none);
+		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
+			sched_dynamic_update(preempt_dynamic_voluntary);
+		} else {
+			/* Default static call setting, nothing to do */
+			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
+			preempt_dynamic_mode = preempt_dynamic_full;
+			pr_info("%s: full\n", PREEMPT_MODE);
+		}
+	}
+}
+
+static int __init setup_preempt_mode(char *str)
+{
+	int mode = sched_dynamic_mode(str);
+	if (mode < 0) {
+		pr_warn("%s: unsupported mode: %s\n", PREEMPT_MODE, str);
+		return 0;
+	}
+
+	sched_dynamic_update(mode);
+	return 1;
+}
+__setup("preempt=", setup_preempt_mode);
+
+#define PREEMPT_MODEL_ACCESSOR(mode) \
+	bool preempt_model_##mode(void)						 \
+	{									 \
+		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
+		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
+	}									 \
+	EXPORT_SYMBOL_GPL(preempt_model_##mode)
+
+PREEMPT_MODEL_ACCESSOR(none);
+PREEMPT_MODEL_ACCESSOR(voluntary);
+PREEMPT_MODEL_ACCESSOR(full);
+
+#else /* !CONFIG_PREEMPT_DYNAMIC */
+
+static inline void preempt_dynamic_init(void) { }
+
+#endif /* !CONFIG_PREEMPT_DYNAMIC */
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 #ifdef CONFIG_GENERIC_ENTRY
@@ -8728,29 +8811,6 @@ EXPORT_SYMBOL(__cond_resched_rwlock_write);
  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
  */
 
-enum {
-	preempt_dynamic_undefined = -1,
-	preempt_dynamic_none,
-	preempt_dynamic_voluntary,
-	preempt_dynamic_full,
-};
-
-int preempt_dynamic_mode = preempt_dynamic_undefined;
-
-int sched_dynamic_mode(const char *str)
-{
-	if (!strcmp(str, "none"))
-		return preempt_dynamic_none;
-
-	if (!strcmp(str, "voluntary"))
-		return preempt_dynamic_voluntary;
-
-	if (!strcmp(str, "full"))
-		return preempt_dynamic_full;
-
-	return -EINVAL;
-}
-
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define preempt_dynamic_enable(f)	static_call_update(f, f##_dynamic_enabled)
 #define preempt_dynamic_disable(f)	static_call_update(f, f##_dynamic_disabled)
@@ -8761,7 +8821,6 @@ int sched_dynamic_mode(const char *str)
 #error "Unsupported PREEMPT_DYNAMIC mechanism"
 #endif
 
-static DEFINE_MUTEX(sched_dynamic_mutex);
 static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
@@ -8786,7 +8845,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: none\n");
+			pr_info("%s: none\n", PREEMPT_MODE);
 		break;
 
 	case preempt_dynamic_voluntary:
@@ -8797,7 +8856,7 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_disable(preempt_schedule_notrace);
 		preempt_dynamic_disable(irqentry_exit_cond_resched);
 		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: voluntary\n");
+			pr_info("%s: voluntary\n", PREEMPT_MODE);
 		break;
 
 	case preempt_dynamic_full:
@@ -8808,20 +8867,13 @@ static void __sched_dynamic_update(int mode)
 		preempt_dynamic_enable(preempt_schedule_notrace);
 		preempt_dynamic_enable(irqentry_exit_cond_resched);
 		if (mode != preempt_dynamic_mode)
-			pr_info("Dynamic Preempt: full\n");
+			pr_info("%s: full\n", PREEMPT_MODE);
 		break;
 	}
 
 	preempt_dynamic_mode = mode;
 }
 
-void sched_dynamic_update(int mode)
-{
-	mutex_lock(&sched_dynamic_mutex);
-	__sched_dynamic_update(mode);
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
 #ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
 
 static int klp_cond_resched(void)
@@ -8852,51 +8904,6 @@ void sched_dynamic_klp_disable(void)
 
 #endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
-static int __init setup_preempt_mode(char *str)
-{
-	int mode = sched_dynamic_mode(str);
-	if (mode < 0) {
-		pr_warn("Dynamic Preempt: unsupported mode: %s\n", str);
-		return 0;
-	}
-
-	sched_dynamic_update(mode);
-	return 1;
-}
-__setup("preempt=", setup_preempt_mode);
-
-static void __init preempt_dynamic_init(void)
-{
-	if (preempt_dynamic_mode == preempt_dynamic_undefined) {
-		if (IS_ENABLED(CONFIG_PREEMPT_NONE)) {
-			sched_dynamic_update(preempt_dynamic_none);
-		} else if (IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY)) {
-			sched_dynamic_update(preempt_dynamic_voluntary);
-		} else {
-			/* Default static call setting, nothing to do */
-			WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT));
-			preempt_dynamic_mode = preempt_dynamic_full;
-			pr_info("Dynamic Preempt: full\n");
-		}
-	}
-}
-
-#define PREEMPT_MODEL_ACCESSOR(mode) \
-	bool preempt_model_##mode(void)						 \
-	{									 \
-		WARN_ON_ONCE(preempt_dynamic_mode == preempt_dynamic_undefined); \
-		return preempt_dynamic_mode == preempt_dynamic_##mode;		 \
-	}									 \
-	EXPORT_SYMBOL_GPL(preempt_model_##mode)
-
-PREEMPT_MODEL_ACCESSOR(none);
-PREEMPT_MODEL_ACCESSOR(voluntary);
-PREEMPT_MODEL_ACCESSOR(full);
-
-#else /* !CONFIG_PREEMPT_DYNAMIC */
-
-static inline void preempt_dynamic_init(void) { }
-
 #endif /* #ifdef CONFIG_PREEMPT_DYNAMIC */
 
 /**
-- 
2.31.1


