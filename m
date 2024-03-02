Return-Path: <linux-kernel+bounces-89319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258E586EE49
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9BA1F22314
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D779D0;
	Sat,  2 Mar 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V+vCXBbH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DN3x4oPv"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7C16FF2D
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 03:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709349067; cv=fail; b=SAeTEtfIE1Cl6WR+PL27WT2Wzx0Gg+lKbUnwj8HW6oFsagHzI9T5oTxpD5NkrUTvXaQX30gyKrQlta13SZHPZMtJgqew6D5qx1qzUw9GpKtFnGaH2CxJ/3mc1D/w+BW7KObQe+vEPw6vCCM8KpgP6JW/U1mBvxN0czdkXNeUAoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709349067; c=relaxed/simple;
	bh=J8CXA5GWXCFg4iu1RtsZQ853q+2xHaVV2s+Botp+Ods=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=sWGtfMoROAAznZX2Thmv34et/Zl9+Y+O7lIK6gQusqhrdSlCTceZRGDg7wBPcP46RHLIdj7IV1e2Ger/sjfaUa5J2FqsSyCb9QkU6hPresZmSmn2sYMMtZL0y+K57L8bTKBTHa5MQt2lYbPHK2hDH2o8tgozMqH5xm+G/XiTCa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V+vCXBbH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DN3x4oPv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4221vR2T009531;
	Sat, 2 Mar 2024 03:08:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ZWNQEN1AgZT7q3QwIorAJexW4WOlU7JpggxDn4ss8ms=;
 b=V+vCXBbHI4WIRFVR2POLSkFhnzl5UevJXevmQfzAGpH/zQma9XDx54pxrtX3Cjs3NH2T
 qp+/hPECfclGUp081gG+qX3PFiT/3393Ar2bTxthsxb00BEADwchYjbCRy5lGPe4iMtx
 fTecyL/2B9H9zXpqRpCQFLUzp6uJQ7x7eBywGADO697suY9aw/D7ai0rRmGy4Ax1nRGc
 ROqgMXa0YFfX/bGU1kqATbkY4mtq/PIAm2VzoIIRDEQZ5CYFj54PnIFQ0CPYO7OIzAij
 z+6asZ00XucRSr1FJeuhmqqL5cBWlF4qYUQ0taCjtxWDVC58tZzwz2HbVW3XtyjfaTbs gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wktw401dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Mar 2024 03:08:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4221Xo0b017448;
	Sat, 2 Mar 2024 03:08:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktj9hsrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 02 Mar 2024 03:08:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mr5G/EtSYvFhfnsAhF00gPBuSNkRjA+2SeQqbyJifaNkUP1EGRfL/Cgs20cWmBOY3rv168OaEhkDaaia99Ubx66zwmp4+ky3dyJ1lUHeOqDL2ql83K2LDAB2rBbvAGaVmap9mYclQVAippNalozFcXLwfCfGXeaZ/gV9IJ1Q995bQ2DIPd/AAEndoYRhp9Vl5Eb01otFxlumGDZE8Ciwq6tI/wQ8LLnQuw3bcnTm6fLzUt1P9WX3GuzsH/ErUXDLq3h+xbtpF4OHDAKb0bTVwu8jVLUOcUqP3yREeTWSLKt2VZg15Ta9tcneXiRf1smLIb2cNEc8xe6bgt/6LN/Yxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWNQEN1AgZT7q3QwIorAJexW4WOlU7JpggxDn4ss8ms=;
 b=SJj/3/Y6n+jpFa48l+DLLTbK7NwOk/Wu9md1qgeouaUuGpEIaWtKq0n3bAcWgeeEWdq8uklYZSvIYXR31bb4yfFyInjLvPEEbRwJDdYvsBiIjpgLrq010L7crUeM6qXsNMkTHI9peWFuIS3PWhJjMo27f+r2UeQgtpVQ3SmVhtVsaQQnCrNb0nuV4UCh9MoE3SBBsZ7s7p/BHEuInLVPSakpwJIl8XkJE2+PREsh5WfkI+mf3Lvdb1T5o1F13kpi0DixYP8+Br8S26eBMYANc5XBiaEs6JyLwbmA8EK7WAn7GUZ45z8gULLgTx8tsqaW1SwnsGOoqfqELQ1ruXMA7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWNQEN1AgZT7q3QwIorAJexW4WOlU7JpggxDn4ss8ms=;
 b=DN3x4oPvp+4GscQ9lAcU8T0fqrtQ3FvHBUr3l8YQH5vuBWe7Xe8nGkvcCmYyZro/YkXD08SUYHJkF2rIY8uEZJew0IjqU0/UK4cxhaIwZ3DjZf0ekkza3+qVYmoULQQpnmuNHhVtpUlQ3RmxOxrpRJl8RtuhnADxZD0zTjihC+8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6853.namprd10.prod.outlook.com (2603:10b6:208:426::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Sat, 2 Mar
 2024 03:08:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::2bb1:744:f397:1d4f%6]) with mapi id 15.20.7316.039; Sat, 2 Mar 2024
 03:08:48 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-30-ankur.a.arora@oracle.com>
 <20240221164334.6f8c69e8@gandalf.local.home>
 <65e265e3.050a0220.7044b.19ad@mx.google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan
 Corbet <corbet@lwn.net>
Subject: Re: [PATCH 29/30] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
In-reply-to: <65e265e3.050a0220.7044b.19ad@mx.google.com>
Date: Fri, 01 Mar 2024 19:09:14 -0800
Message-ID: <87v8652uud.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a5f8ffd-d5b0-4017-6e5e-08dc3a661411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B/LKlGShHQhPpfjm7oTv8HvRyzBBmXks9x6Cu05XeaEuQWkmRq35ho6s7Z9DqqfHykp3ZC3oTJvbKkulG38o1NkyLZTBDOG96Rs5ZvZAr9E93D5hPWCnfmqX2HOehsl/N8a2wb9jcUhnkZvopsVpLccubKvxtmxXzVGQLVRmtHPJYIdsBz+dtGg1XRREbV4mS4JqTJBqAkS5D4oh5aYvg+2h2KbR9KROVz3WLLyqyH9OeHUx7i+McmMZq63hHxSNpeItN8UaG7HJA9nVK1udXFmXI3Qiltz5hUTbHVhY2PFDS8xwkNUYAuGIS1R3u++fXSnjnBIWYOWCe4ALPhtWN3QIEGMvpIN911DSw9wx1TMmNvAxWKWPTrlpHIv6r7iRssYUST4NVVSQaLmixohEsDP2BS8LPuIYYWiSLGr8NuQjTyOirXZ5r2Vgz97Dl5F2+IBRIzXIOUdi3RgAsHgDUKFvXSQSdWgYy3eVdXl/IDjWawgmIP9vs4vSbIpvuVHAlkFZ+pigqqbi9XqECgCz4rzd+ojiPjEqLbBM4SA7NyGHQ0ohn24GmMIiCffbk4NbwcOHFVExSlxFOgDKqqbKWZqGy097nnfWabb6+3yaCU4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VGYfR9Nxgk2d4TmFr69a7Kfl5/tjy/hVemjvRorQ8OeMqUnyi80tcv+7z1/D?=
 =?us-ascii?Q?tikm3KrDmiElYlqL6PT7GPVrC/BbZ4BF0XZgYdSMdU626zLjuhf3gTPKDbNj?=
 =?us-ascii?Q?qvEmG1GFow3lAvkvs+SqT176UKjWedG04E6bSMJiDihhtTz7fHF530Bwi9nk?=
 =?us-ascii?Q?Psw/sdZNC2Gxa+pZMaz2digMhTaaKuOCwqc/lTE36UJcD9odL28juJ7PggZz?=
 =?us-ascii?Q?dMGdB2YK9a8oq6OHk3kbqyRzyv5DwHqEBSMhix/Bb0uMAJDba0u+Ih6QvUv9?=
 =?us-ascii?Q?1ORlH9kgxcrZQptXrMRWnUlr7RMSVM8QbICGDktvuQc06CkoJ1392ZhK2ojO?=
 =?us-ascii?Q?gn32SdqVLcsvy0NVnWnJzYxlUcc9Qh8UMfPkZi+b137RyhZ8oOeYM7zcp+D5?=
 =?us-ascii?Q?uQOZGYkOPTcnQ6kJ2L4hROFyNChS/habcqZ3BhlkLygWObndvnhYlKTYZ8U8?=
 =?us-ascii?Q?LKiRSw821/LCTI3mYvsOh7xJaaFoRG3i2NTpqRyMjpjd0s4cIC1GdKvbGmsg?=
 =?us-ascii?Q?GEWCZNM94oKn8HxAsevjjCtwjFF5IXJ3nixIgkLvpgN7dTS5imeiaGeE9QoX?=
 =?us-ascii?Q?V4cE6TDeq1zNFzYz1HjKZxwK3InHLhzQeYfWbt6zfY+ZPxrJvnaFoGYIzEoq?=
 =?us-ascii?Q?iow6/uTDTRq4py0JvVz38vc9xa2iByuFaiHUdGcNHwpsYXz8E/iJla9CzXIS?=
 =?us-ascii?Q?hLAcJTAXdMzzwps83jw9qHHLUboLJFObFHLe0w7ptwhqqBBRRlFACWR7PFR/?=
 =?us-ascii?Q?PZfSg2fJA2Rj9L9GJ57UyqFu123o3HlBKkcu6KRS7bFTxT8ml1CVg7lj0yXT?=
 =?us-ascii?Q?giUaWec8pxUbmIqM0RyddmFON/gmTOTpcrTgzC/A6KIfofDYqgdbCsRgwS/Z?=
 =?us-ascii?Q?Zdk8KvLaOQ4l7XBS8CI0UXGUgb5X6O1esB6Orcf0/Pq88fPmqKYU9V78//hb?=
 =?us-ascii?Q?uppMR7npa0j8cHqcrWRREDR/5VKO2EEzuBEAcMAa7Zpv5oJ0WPC2igddraUr?=
 =?us-ascii?Q?4Agv2pLFU90K3TBYU7XVfZmSpgbvOPwt6fPa4FeAhtdiwGJasii77JOn4aEp?=
 =?us-ascii?Q?T5OZagfXevP69GCJc95pCV4WTVHwNhSv8+HjSy8aTXrWP6oM08u5KZsxTvLc?=
 =?us-ascii?Q?6A9Tp0cLJLjl9Ph2aDtARsxkW1czhRgt3MwrSccb/WOxbudMk8FJRByvxgFe?=
 =?us-ascii?Q?k0YfZlx7Xm+CesxzECGNYtkLMnEAM5KhXuwqyxw/dwgo6YQBear1V24MS5PU?=
 =?us-ascii?Q?9Lvj35fRBQtp/Ku+Fmj/q9jjaOTqcRurvQ5nDFku/D05mobPFcZn/tNbOG/2?=
 =?us-ascii?Q?3dBKSBnSX02BPaLYrDdOxxE2RGERHBmQTHS3SA9o1+4sjQqZcsPy24//q9kd?=
 =?us-ascii?Q?zVYwayzHOKpL7ER/vc9Z0CLGqjvQm0bVVfMyfWxEsbyRPRMLNdInMv9NaD7Z?=
 =?us-ascii?Q?tDb5/spagwp7IvQGbIbFE3KbUYrxdnCj/1WyTSmIrg9xmK9f5wH2hcEE83UV?=
 =?us-ascii?Q?imtT/cBfB42nTxBCHavzP66WeS6YUnBTw+hxqicGRCpK1uDeV11/7C1dw7pt?=
 =?us-ascii?Q?UavJItACAW3UzPWnUyHeocg6FqguVVNtglaO+2q9nCpyGyNFOmwecCLLPPNj?=
 =?us-ascii?Q?lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vf0S/XpMzSsCXii+Rjx4BRpeXlZ9XGcYJ0Knu9D03pE/iEolN/YYaeZI3IroZ11njVmDozGeObdUdqzRAUbrmyfiRF1yC6KsWXWVMO6amZLCTYiUiZqSXmbLnhu/VoUtRiSsGdFpHqKGLu+LAlzSJ2V9eHANTxR4whXBj1wEmO+qyULhjhKwbRGt83uDhEsclq+OUCM+jOlc0utabLnsZuI4oKlxuRs+7A32pdUpiMncj6Xywhg2gadanKQMzwqYDwMyVbZ06xB01gA8eVw8sbN8jiqIxPh/E7GMuzfdQ851bZOVLyvl/iLn1JGHBVDdmLr8xdagcIov0G1vVBQwVQh01wrV6hvhXEZXVNZzjIbT4OdiT75W/9sPPbe7k1hcEdGM8T/mWQych1NTm73p880n/RZtH1RT6cG2hHHEHZwZTPtTTlcnxsGxutmKxj8GKvgzkys7sJqdkAW8C+733bt1i2nXDimgW8Rf48Ob/G9tfYXPyIXanK/xHFemtfQEhTOJsEEutUvkrSRg3nrheBrJ6lHxVK0Qc89y7s2jQ/vKCQk6BkmUFb0jLHkuUTD7AeGr3ohHYe3SaFztaJJcoxcggb5y2LGu7kVIUzs+bRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5f8ffd-d5b0-4017-6e5e-08dc3a661411
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2024 03:08:47.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ4HL4hfMcrSahjQ16RC14SDRKzYD6dutTW1pZsUqNeKOOHTnbWZtidcR6RQ8dZpDHXZpubcaM/cWv03xoD5y9EmvQzqfTxJJNhv1dPjyyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6853
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403020025
X-Proofpoint-ORIG-GUID: d_gVU6c5VKsL5Rq3Z1nG38ztq3og6FsM
X-Proofpoint-GUID: d_gVU6c5VKsL5Rq3Z1nG38ztq3og6FsM


Joel Fernandes <joel@joelfernandes.org> writes:

> On Wed, Feb 21, 2024 at 04:43:34PM -0500, Steven Rostedt wrote:
>> On Mon, 12 Feb 2024 21:55:53 -0800
>> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> > Document various combinations of resched flags.
>> >
>> > Cc: Steven Rostedt <rostedt@goodmis.org>
>> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> > Cc: Jonathan Corbet <corbet@lwn.net>
>> > Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> > Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> > ---
>> >  Documentation/trace/ftrace.rst | 6 +++++-
>> >  1 file changed, 5 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
>> > index 7e7b8ec17934..7f20c0bae009 100644
>> > --- a/Documentation/trace/ftrace.rst
>> > +++ b/Documentation/trace/ftrace.rst
>> > @@ -1036,8 +1036,12 @@ explains which is which.
>> >  		be printed here.
>> >
>> >    need-resched:
>> > -	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
>> > +	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
>> > +	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
>> > +	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
>> > +	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
>> >  	- 'n' only TIF_NEED_RESCHED is set,
>> > +	- 'l' only TIF_NEED_RESCHED_LAZY is set,
>> >  	- 'p' only PREEMPT_NEED_RESCHED is set,
>
> One thing I was curious about in current code, under which situation will
> "only PREEMPT_NEED_RESCHED is set" case happen? All the code paths I see set
> the PREEMPT_NEED_RESCHED when then TIF has already been set. That kind of
> makes sense, why enter the scheduler on preempt_enable() unless there was a
> reason to, and TIF should have recorded that reason.

True. And, the only place where we clear PREEMPT_NEED_RESCHED is in
__schedule() after clearing the TIF_NEED_RESCHED* flags.

> So in other words, if 'p' above cannot happen, then it could be removed as a
> potential need-resched stat. If it can happen, I'd love to learn in which
> case?

Yeah, AFAICT the only case we might see it alone is in case of a bug.

> Also considering all users of set_tsk_need_resched() also call the
> set_preempt_need_resched() shortly after, should we add a helper to squash
> the 2 calls and simplify callers?
>
Just to explicitly lay out the reason for these being separate interfaces:
set_tsk_need_resched() can be set from a remote CPU, while
set_preempt_need_resched() (or its folding version) is only meant to be
used on the local CPU.

> There are some "special cases" where only TIF flag need be set (such as setting
> rescheduling from an interrupt or when rescheduling a remote CPU). For those,
> they can directly call the set_tsk_need_resched() like they do now.

The remote case, as you say is always handled in the scheduler. So, maybe
it is worth having a set_need_resched_local_cpu() which takes care of
both of these things but more importantly makes clear the limits of this.

That said, these interfaces have very few users (just RCU, and the s390
page fault handler) and both of these are fairly sophisticated users, so
not sure yet another interface in this area is worth adding.

Thanks

--
ankur

