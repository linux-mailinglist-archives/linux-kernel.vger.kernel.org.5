Return-Path: <linux-kernel+bounces-62983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6814B852884
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1C551F22C98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4A942078;
	Tue, 13 Feb 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SPvN/kE9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DJySch8q"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5463D977
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803864; cv=fail; b=LSn1TBYAoO0wtSoW1zU5SHLnGrTwKwveQdqwYPmDn6dlc/8bki+/jjq51WIytFq2PQrjluMp4tbvxF3SzBA2uyO2tfCg57ZRUsg7evpBjyh4uzYczUDqFp9RpXg+yJ8LlFmiHZXhuLkfVGCwN5q1s3/uUAzAlZ5kLrvgkVbxPU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803864; c=relaxed/simple;
	bh=Pqnh9+Y4CihM43PeZs1AqTHwvhoLciD4p8HqIMV80K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mPtTVX7GstHrv5ttumqgz+1u7Lm8xjGSVKwkoawZpw8BHwYE3BIuSiJESIyf6uLVKt8sPEr1e2oB6VgS/BZmKFJHLaGVbH8V5gtjRzOGnIIUzzMKDSm48QCEJ5RXkfbPAIFWIFbnhoTkgUSZa62X0h0XAsVJJhkrDeb9l9+3MCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SPvN/kE9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DJySch8q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5Yp9q005664;
	Tue, 13 Feb 2024 05:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=clyARajQghUUYAlB1jitbQuT4jxObCTuhFBJ9nurdGM=;
 b=SPvN/kE9I5Q8byuOXxRxz95vdFG00usP6WBUQE/HmugvfHhJc4SbDT0s0RSG8We3bKlV
 Ff04BZlwt8aCPh28RmiEj07MKitYaynnJTAntuu5KpfXpGPuJsob4rUIeR6RN5UgbZAI
 UIuo/uildaoCVvTv25y5t8DBLootKniWneJZC7GlVKCYnCAG4klLMSPMflmlLayA5Elp
 kBYNxkdR+Zsa9CE/VKBTNK6mNrIYzRzYoFOkzEoD3FBrKIlHdNa8bTll9g5MEc3PGoCk
 ozBJ0KO1ZAPqRvp+vZoj7QFm4sZglVimrEOve9oI3PAZADq+DAjDSbXF5YAJFbDf0o+e rQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r1h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D50lL8024685;
	Tue, 13 Feb 2024 05:56:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd3tq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KumzYutSRi/y0zEcLhOzPZrYQ8eyD3RJUncs96i14da2m3n23h/2ZMt/tORXF28uZzKhnZov48XQvnjc6dMkVm8VtleO48oaDDrlvqorsbr3xP41Cb6HveuCaj2Dd9KdEvWPKVNigsMI69UMvDwpa6txi7PAhPz8CY6nlcIhoURNfHzk6Ac1/dsnmNJ5Ef+DHWQdwsftbG6lBbrY3JkZee75QXzExScbZS4wrP5LXa50NTdOKstUPZvri9iVdpK20uF+S2GJt7fDKy7WuMJ/e24PMAEiUXO3a/x8gVFKIcuePaisxykJ0oDTube4qiOkSegaL8HhB3ArSFddzWLuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clyARajQghUUYAlB1jitbQuT4jxObCTuhFBJ9nurdGM=;
 b=N9fCHJrhDxIKfan7TS4c4S6rvcdOEUb5VQ+1zdoGRelBdgNViYjTSrs++FQDFWmxRAVlPDySONYLHCvK/fv097oOycQUmtlf6gUQ7Pa9sbC2XcSdVXIbXkcw7Qu1q3BkCH+SRQLYNUBSQrmAWoQl4obgVYsM5WLcdabQA1hNw/FvHXysdbUPtBbvXaKqA9l81ahTWQPL3aANlUVcBL+jm9ZmQw/v7R/ILddpjyiOGkziZnE57NlAU9BJD6ARyQ8qVO9Pnc2YEDMtkfZG1b6kLvf7Xk8j+LbDI7/zHyqCmTTc2GoWX7flXbuhTYKZXkP6bWO1nA0FgyrfwAvBfXE5cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clyARajQghUUYAlB1jitbQuT4jxObCTuhFBJ9nurdGM=;
 b=DJySch8qqRCMHLlIDVGG4Wq1YowksDLnI5LOhhqaWBhMRoDOQ73mlfWWGkzhk3+C7alpJXOH+9hA4WaGD9FnTbyQQk8/WNtR6iDEGMqP/heQT9HM1xYFvFJaWSA8YE+25+mOTUAr/JpWuv2JQ1+xdnbdN9/PnP2s66asD508DAE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:54 +0000
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
Subject: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
Date: Mon, 12 Feb 2024 21:55:50 -0800
Message-Id: <20240213055554.1802415-27-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0327.namprd04.prod.outlook.com
 (2603:10b6:303:82::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee8780b-6ebe-4707-1058-08dc2c58949e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7MbNXA9RVJ86zBz98E6pbyp6kC4w352wnBR296a2Ttz6iDUWznMLHCIUxcjPa9iFLJxFojkAmNSvbqVKKvuyO2kyux1fZBLNYXZLnbDSoc2TsQa/osyGafhtrtpLFbWFNzekGsBjr2V41J3vHM+Qv3R6WophfpIlzw7yd2l8keJEmjZBkj27/F1arDNA3XGPREhTU2pQsE5w+OZWgeQmkxJ78UfClcMFwb5HoyAWxU90Rf9iheJoYifXdCXhkMQ9NOlBP+9FDJgV7AhqS+tJrMv/GwtxruHIztxDiv1DVG6le5hdLeumFAI0tMcOzUJVlFslJEjHtznZR7r09ksRgIGBhevoF5tJYYUR+Zjnkb2qkbuXzdq2Ki5JJXwHeVRMSNDP7Oc1OKXUqyy60IqU/npX0yVCMxSHLohRlBrR8mJAs+ETxuOYVCsRmubpNK3Vn2IbabZ6ilP4YrxGfbpQoqdeJYCvPduXNgayNAdsozxBMPw+YBNlsKUCFGNrsXxTypB6fY5hX+hVwykfml5S9N+Y6+Y9wZ5ITG5riPDErBk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QA8SHkvFpc0LXDfJxkWZmSQSowBKcIuU12tf3UQoroCafu2KoVNlT6mJ8dAG?=
 =?us-ascii?Q?le/3z99AkTObNCFnurCzbfeVxu46C16hogD98D/AL30jwdjuUhm7QZMDu4gI?=
 =?us-ascii?Q?u8i8z52Fwsd4/N7OBtEI08GFd0ah2hpsO4S//y35VFo4NwAjdeygS2swZcho?=
 =?us-ascii?Q?aaHokteViUzMVLTY4t5Gcc2GJyqXt4IyI431Chu/qmkR/3nMonl6t9xe/rmt?=
 =?us-ascii?Q?uhbQaxX4aD6pfWlegdoecBv82QoQdDyGZ6l7GgqctI2tXv5EDWjTzVhuJ3t/?=
 =?us-ascii?Q?6Epp09LVTpEO7xxzl1+CQDUAkJC3JvrVER/Sk0XGGoocopUjP5QOlPNvMyah?=
 =?us-ascii?Q?Y/0gMERaCKbmdHOpxZvdyooDu1rJ5K5L0ICbpdTWFQ1UK6ZBps2rCS0tUFjx?=
 =?us-ascii?Q?zIIsPxnQeXHjQmyphx8NuhhF95b3LycVguLYYR4xJhuYuGaST96B4kl2C9hm?=
 =?us-ascii?Q?wuDVjjU0QCFQuB8cpYcDBkNeneN61eHAXiYSKZVwJtY21qvTxnj2wulYyTbp?=
 =?us-ascii?Q?sdWaXPNLdFhFx3u+az9Mo7JYZUTRZCOb8Smxzqkn2c2AlV2g6WbeaL6JOVyH?=
 =?us-ascii?Q?U4BDKG3Y8fizR5t7u3pSrnjjQFADbCZPDDm1nGolgBxXQsv2Xvb0V1lCXum7?=
 =?us-ascii?Q?yIJBvYhNMeANzAxf/xeo9oRaE8wGsS+HqYcUgfPaHZ4SZ6rp1iAJryeSxlLQ?=
 =?us-ascii?Q?Qfv+LzE4iLHfeIVDDH4FMqqhr9NxkSajudo1kPiMNDa4CI6yJsuSXK1SxCiX?=
 =?us-ascii?Q?rDDQht6UpFcWmVKJhyuew6jkCNDzctfD0mPyi50IY6Jetm3oVttDM2b9A1Ko?=
 =?us-ascii?Q?lYMAYs2EFkw3nbmT/T8KI5Gn57U5wid9O1BhzsZ2DF/2157iC+QUdnAwGvrt?=
 =?us-ascii?Q?yexhjFgonyp2zFALULwhura+0GWOfWLz3WjtGBFsvDR/firG+np0Ww8zRBqj?=
 =?us-ascii?Q?Iebc8JWYVFcQOx5xHC4AlQW1KfIPqPQU9/hP4VuVpKpR4eckhqyL8Hu4i8LX?=
 =?us-ascii?Q?L8fIsSxBOBoDgYgz73lWMDvFOAu0Blkb40MpHhgNREVhDphsJO0K2u38j1dy?=
 =?us-ascii?Q?Y2u8NmOTt9jDXAE8PtDzG6DJND7dwl3bjxyTioLxgWohZDdROy7ZocLW6NYa?=
 =?us-ascii?Q?YX+WZzoSNlRoy1ETdNUKrTkG6cGVBiQxYoU2mBD7bit6aicD7Lz8bU8q4bsG?=
 =?us-ascii?Q?lzyOV33zjBsvoK0oXhiUFvb2nQzrZPRb0DPF+s4op3a71FWtJMdm8IKzoqnH?=
 =?us-ascii?Q?VTtKxraswLjhPZCY32hgwrEClcwmGLjiVa/uMK8FFOCPSe+gl9P61Do+jHMx?=
 =?us-ascii?Q?OsCgNfIFQ2QCa3vO7I6y8DFg7+T5DmLsokSyZD31l8sJ0qxBxAPOrY5hWE+U?=
 =?us-ascii?Q?Vsn/+gDpHynWUrtHcZHBPO2AZyIiAlpxP6bwH8Y0BBZWfvW8DHp+kK4kDsGN?=
 =?us-ascii?Q?LDjhwCaQSMLdvGlTFu93/60FeOV9oOvQM8GVrIKlHzTrx+5ueun7XwC19wGV?=
 =?us-ascii?Q?uLtGhrAUsxhyKQb96EygahiwwT/H4sKO6vYK/xEbSORTX9gyUWEg38MMoM2p?=
 =?us-ascii?Q?QkmQyCamaLY179cMQp73umFXnLlIFAcpEiHSrvm5H60o5yfLmW9XEHco8xHN?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	O66dd+qtRsgl/XznNtVtu++9Rde8IBKsGrhwWmdzPZEIVi5uCjwAp9bc6Oj+K/aQpbdG8zjd3nCv5oX6wzrWSz79JvZkETY2iiAOk4uXXhNGL9s429M1h4GY4oFhji7U60mhPXCeIfTsOzxurT4WkfLHuhwq46kiMvlwHhF9MZm+BAzUFNPZGyZPsdoXmG/Ganu/oLTRwZjc1QTga5UXVkgye9z7GDsKLRb75wgJmg+SE8pq57Au8RJPLUcknF72cnk3uILUWKiY27SM4zRP6u2zo6tw5kMzWM/o0JRXp/odYyiH/b7JYE5WYcxvViB+uIiT9k1Etf/j//vh1ynmoEc3JuZYi5EggZuq0jOLvXpu4HbOyErA/s0lson2G4o4z+y3OwMkezH9B33unvf8LCQgPeAtA3NDbuH+pnh3ZnKr120VTY4V8LUn+Osy2GZy8JqdeyU1CAjDu2A4kU8Bt3ISeenS4IZz47FIxanOVxe1YWKBLNw4j+8BgkOsJ9cMlhDhjwp4j8kk6HLOFW/I0MMz3TCLAqbntq+tcFmmPLl1xcKBtRgtORxamTfCQ/S45YBdEOOvEEQeDmExK4u/4VYvUhr61L8ZDPBXVTGPaos=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee8780b-6ebe-4707-1058-08dc2c58949e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:54.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KLFpFcsInx4peieXlAwZPfbGv6awtLeQ2T44wSBphZj612jq2t80X+RIErPtl89aheiAkSzRb70PSxc9TS9EqUfCq/WGTYMvnFs9x0p6d6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: Cyj1bxwmvirPQuAjSU394l4Ust9ZeRJK
X-Proofpoint-GUID: Cyj1bxwmvirPQuAjSU394l4Ust9ZeRJK

The default preemption policy for voluntary preemption under
PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
class, and lazily for well-behaved, non-idle tasks.

This is the same policy as preempt=none, with an eager handling of
higher priority scheduling classes.

So, compare a SCHED_DEADLINE workload (stress-ng --cyclic) with a
background kernel load of 'stress-ng --mmap':

 # stress-ng --mmap 0 &
 # stress-ng --cyclic 1 --timeout 300

 PREEMPT_AUTO, preempt=none
   stress-ng: info:  [8827] setting to a 300 second (5 mins, 0.00 secs) run per stressor
   stress-ng: info:  [8827] dispatching hogs: 1 cyclic
   stress-ng: info:  [8828] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
   stress-ng: info:  [8828] cyclic:   mean: 23829.70 ns, mode: 3317 ns
   stress-ng: info:  [8828] cyclic:   min: 2688 ns, max: 5701735 ns, std.dev. 123502.57
   stress-ng: info:  [8828] cyclic: latency percentiles:
   stress-ng: info:  [8828] cyclic:   25.00%:       6289 ns
   stress-ng: info:  [8828] cyclic:   50.00%:      13945 ns
   stress-ng: info:  [8828] cyclic:   75.00%:      25335 ns
   stress-ng: info:  [8828] cyclic:   90.00%:      34500 ns
   stress-ng: info:  [8828] cyclic:   95.40%:      41470 ns
   stress-ng: info:  [8828] cyclic:   99.00%:      85602 ns
   stress-ng: info:  [8828] cyclic:   99.50%:     301099 ns
   stress-ng: info:  [8828] cyclic:   99.90%:    1798633 ns
   stress-ng: info:  [8828] cyclic:   99.99%:    5701735 ns
   stress-ng: info:  [8827] successful run completed in 300.01s (5 mins, 0.01 secs)

 PREEMPT_AUTO, preempt=voluntary
   stress-ng: info:  [8883] setting to a 300 second (5 mins, 0.00 secs) run per stressor
   stress-ng: info:  [8883] dispatching hogs: 1 cyclic
   stress-ng: info:  [8884] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
   stress-ng: info:  [8884] cyclic:   mean: 14169.08 ns, mode: 3355 ns
   stress-ng: info:  [8884] cyclic:   min: 2570 ns, max: 2234939 ns, std.dev. 66056.95
   stress-ng: info:  [8884] cyclic: latency percentiles:
   stress-ng: info:  [8884] cyclic:   25.00%:       3665 ns
   stress-ng: info:  [8884] cyclic:   50.00%:       5409 ns
   stress-ng: info:  [8884] cyclic:   75.00%:      16009 ns
   stress-ng: info:  [8884] cyclic:   90.00%:      24392 ns
   stress-ng: info:  [8884] cyclic:   95.40%:      28827 ns
   stress-ng: info:  [8884] cyclic:   99.00%:      39153 ns
   stress-ng: info:  [8884] cyclic:   99.50%:     168643 ns
   stress-ng: info:  [8884] cyclic:   99.90%:    1186267 ns
   stress-ng: info:  [8884] cyclic:   99.99%:    2234939 ns
   stress-ng: info:  [8883] successful run completed in 300.01s (5 mins, 0.01 secs)

So, the latency improves significantly -- even at the 25th percentile
threshold.

This configuration also compares quite favourably to voluntary
preemption under PREEMPT_DYNAMIC.

 PREEMPT_DYNAMIC, preempt=voluntary
   stress-ng: info:  [12252] setting to a 300 second (5 mins, 0.00 secs) run per stressor
   stress-ng: info:  [12252] dispatching hogs: 1 cyclic
   stress-ng: info:  [12253] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
   stress-ng: info:  [12253] cyclic:   mean: 19973.46 ns, mode: 3560 ns
   stress-ng: info:  [12253] cyclic:   min: 2541 ns, max: 2751830 ns, std.dev. 68891.71
   stress-ng: info:  [12253] cyclic: latency percentiles:
   stress-ng: info:  [12253] cyclic:   25.00%:       4800 ns
   stress-ng: info:  [12253] cyclic:   50.00%:      12458 ns
   stress-ng: info:  [12253] cyclic:   75.00%:      25220 ns
   stress-ng: info:  [12253] cyclic:   90.00%:      35404 ns
   stress-ng: info:  [12253] cyclic:   95.40%:      43135 ns
   stress-ng: info:  [12253] cyclic:   99.00%:      61053 ns
   stress-ng: info:  [12253] cyclic:   99.50%:      98159 ns
   stress-ng: info:  [12253] cyclic:   99.90%:    1164407 ns
   stress-ng: info:  [12253] cyclic:   99.99%:    2751830 ns
   stress-ng: info:  [12252] successful run completed in 300.01s (5 mins, 0.01 secs)

And, as you would expect, we perform identically to preempt=full
with PREEMPT_DYNAMIC (ignoring the outliers at 99.99%.)

 PREEMPT_DYNAMIC, preempt=full
   stress-ng: info:  [12206] setting to a 300 second (5 mins, 0.00 secs) run per stressor
   stress-ng: info:  [12206] dispatching hogs: 1 cyclic
   stress-ng: info:  [12207] cyclic: sched SCHED_DEADLINE: 100000 ns delay, 10000 samples
   stress-ng: info:  [12207] cyclic:   mean: 16647.05 ns, mode: 3535 ns
   stress-ng: info:  [12207] cyclic:   min: 2548 ns, max: 4093382 ns, std.dev. 116825.95
   stress-ng: info:  [12207] cyclic: latency percentiles:
   stress-ng: info:  [12207] cyclic:   25.00%:       3568 ns
   stress-ng: info:  [12207] cyclic:   50.00%:       4755 ns
   stress-ng: info:  [12207] cyclic:   75.00%:      15187 ns
   stress-ng: info:  [12207] cyclic:   90.00%:      24083 ns
   stress-ng: info:  [12207] cyclic:   95.40%:      29314 ns
   stress-ng: info:  [12207] cyclic:   99.00%:      40102 ns
   stress-ng: info:  [12207] cyclic:   99.50%:     366571 ns
   stress-ng: info:  [12207] cyclic:   99.90%:    2752037 ns
   stress-ng: info:  [12207] cyclic:   99.99%:    4093382 ns
   stress-ng: info:  [12206] successful run completed in 300.01s (5 mins, 0.01 secs)

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 12 ++++++++----
 kernel/sched/sched.h |  6 ++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aaa87d5fecdd..aa31f23f43f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1056,6 +1056,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
 	if (preempt_model_preemptible())
 		return NR_now;
 
+	if (preempt_model_voluntary() && opt == RESCHED_PRIORITY)
+		return NR_now;
+
 	if (is_idle_task(curr))
 		return NR_now;
 
@@ -2297,7 +2300,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 	if (p->sched_class == rq->curr->sched_class)
 		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
 	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
-		resched_curr(rq);
+		resched_curr_priority(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
@@ -8974,11 +8977,11 @@ static void __sched_dynamic_update(int mode)
 	case preempt_dynamic_none:
 		if (mode != preempt_dynamic_mode)
 			pr_info("%s: none\n", PREEMPT_MODE);
-		preempt_dynamic_mode = mode;
 		break;
 
 	case preempt_dynamic_voluntary:
-		preempt_dynamic_mode = preempt_dynamic_undefined;
+		if (mode != preempt_dynamic_mode)
+			pr_info("%s: voluntary\n", PREEMPT_MODE);
 		break;
 
 	case preempt_dynamic_full:
@@ -8988,9 +8991,10 @@ static void __sched_dynamic_update(int mode)
 
 		if (mode != preempt_dynamic_mode)
 			pr_info("%s: full\n", PREEMPT_MODE);
-		preempt_dynamic_mode = mode;
 		break;
 	}
+
+	preempt_dynamic_mode = mode;
 }
 
 #endif /* CONFIG_PREEMPT_AUTO */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c7e7acab1022..197c038b87c6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2466,6 +2466,7 @@ enum resched_opt {
 	RESCHED_DEFAULT,
 	RESCHED_FORCE,
 	RESCHED_TICK,
+	RESCHED_PRIORITY,
 };
 
 extern void __resched_curr(struct rq *rq, enum resched_opt opt);
@@ -2480,6 +2481,11 @@ static inline void resched_curr_tick(struct rq *rq)
 	__resched_curr(rq, RESCHED_TICK);
 }
 
+static inline void resched_curr_priority(struct rq *rq)
+{
+	__resched_curr(rq, RESCHED_PRIORITY);
+}
+
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1


