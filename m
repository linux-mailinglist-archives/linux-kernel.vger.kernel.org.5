Return-Path: <linux-kernel+bounces-66279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F4F8559A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2673E1F24E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 04:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816D779DD;
	Thu, 15 Feb 2024 04:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R9RmyhPa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QPyyv3Ko"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31A7475
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707970166; cv=fail; b=YAxdy7HhhLFzS2mKZOI4vxZ+A57brt78OTgNba1BHwdjLPCFho37Q1r3BsbxRtsdx1swwd7fYSscVhvgWhjHggh/c44s8R4HvQLfNvYfi0ldsJ8WVKSVys36kwa67ZIxyRztdHGlnE0yAJT1Mg702Qz8nZto/OIoiGIQDOzzhmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707970166; c=relaxed/simple;
	bh=D8G8q36XJp7KORj3yAOKqgQgQfjro9VayQvjeRaH0fo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=F+q2uIEhGqn0zoMhlEwMkGv1pCWD8OY6AYXgatKs3z9zuc8d7uvCmoA3qBuJZSwrXGVh5/YD8W8n4qIXceecOz9gcVW1tUL7Zr/zS5beDKpAgZN5lb5fkQLtIJp8Zk4F9dfRtOwaRt4aFNGQpznUcdpUyDhX4GuhN3wdRa2kaaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R9RmyhPa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QPyyv3Ko; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiCh0014097;
	Thu, 15 Feb 2024 04:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=XI87vBC/c/ueaZKBnpTEwgnvxjDHlBx4HTzpB1Y5cks=;
 b=R9RmyhPaDd3bXab8J3Id9evrpqEr0MbliaQFdWeQOF0wWr8eR/dQdYldBXFDgrhY5NJq
 Mgy1wI8cjh47ulYfTDHmVaLy//IxkfY9SEHV35+4XxcY3wqkVxrerzDC2RhZYJHQSZVn
 UczYiGjkhmu0rru/tjZhpy8BNMRRcQlmuEzoo9d5IXYulFsM8RjUwWryRMAtlUny8vcO
 nfbk2Nx8D38De/XV+GAouogo4SnOinITe1gcfsaezIwVmaQX+dQ/+J6vBR9gJGRz5o54
 NueZgYGFjAbHW88gPrP8WPcROYzcAHHkMRSZOEf9JuwroYS+iESBlAs9q7VkpW2BdfWU hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f016m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 04:08:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F3Zjwh000604;
	Thu, 15 Feb 2024 04:08:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9xc8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 04:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2cgujlrgRwI04J3MEwjEwfo7k2PDH9O2M9dSLJsvOuO4o4zTyy07Fyvxsbk8jYauFkbwu8LWf/pIa+H0XTo+c9oJpMVrHoooXLSW03yuz51Iu8cn4QBn9kOGqCKCAQhZo6xtUrioqslyWu2Jwtuj5w9fLn0iYU3NF0eo5j9xu/OHvil0WW+fQ8RqhWWhDfABc7yj83+q85B292BKcth7+aJH+Qw1wYMj6YeUajOvCOq7CoraCekKjQMFMGDG1FSyO3pYnPkGtXjT+klWp0lGTfBuF5p/YpHZ10yVdX1xTBcWTCw9uHAYgoSTzy/x2y3ZFu9fNQhr+GQFQmeMOwxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI87vBC/c/ueaZKBnpTEwgnvxjDHlBx4HTzpB1Y5cks=;
 b=i28cJmX9VG/edzVTPI+IsDl7RPtYnDaMXTWy/4jpH45eb/HsYWaApFfwXPFXKvoq2ldbbKI0TTcjjo3RlDvkKN3WQNkMqwciqo6hmCPO/Le0wsMdJ0mS9ZSOxeVON+mL1VRNrJ+ZyhP3r25b//K66caBzQxwyTKxBU/ESnxOlO60aFbsVrMJxhbyQ3hBYuc5SITDVQ+MQcPi23ogrny7Xt1ZPf0KD2uXApCRn8s9YeaWUvaXIW+oyL3YF/VmfQpTYrFhQzjfdBPR7Kq+inNc73i6iPlnDa5V9oR1lrTRCRF1L2a1SPPrFCMyUn3PU2OTlee40a3kNXDRYfxUQewBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI87vBC/c/ueaZKBnpTEwgnvxjDHlBx4HTzpB1Y5cks=;
 b=QPyyv3Kool0kZdLlmSwSDYnopM/LHUkJdOcImKNSFX0cUGhS/e/gec+8Y5In1ZQnLeFxqvLYbGWyRseG9esLzjtCDZxayJgU3a6Zj+GH5u9RhQDmlY/Yx6emCl+xIXqlxTavwJzkhH8PDB9I2CVUYP5zLlGqV3lL1jE21ZJi3Bg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB6351.namprd10.prod.outlook.com (2603:10b6:a03:479::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 04:08:11 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 04:08:11 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N>
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Arnd Bergmann
 <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
In-reply-to: <ZczJU8uZdbRKvcAE@FVFF77S0Q05N>
Date: Wed, 14 Feb 2024 20:08:30 -0800
Message-ID: <87il2qmksh.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0043.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7343258b-1a40-499c-8b60-08dc2ddbb992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EOm4aDOzxRMBgZZvIQ/vKGLx0bSoXwBDSfp42OCnH4RdVNLzh2M3BmuyWAnLpFV/Xgaik/Z22AYAKWEB5bLVq1E341H+4cbmV4qNhEbY7BP3dSxfK9HZH7KWYiRrQlSFd23dapoxGzG+X2ngB5+jYPD8AKHoF7towmasHi7QOqv6kq2y11tpoFyoWhD7OhLx9KfXBNGsXWTW5zAU5UvUy4NF6ZNbwBsS7ohM+7dXjDJkvhgoBCjbZzKbI8Dlq5Zhs2fjmoTJWEy44/p2qghnKbDnw9gq0dCx3l1q/UBPN4FPGoe2EGj2U0pjtT8irRKDQUtH4eK9b6G4YDSX9nfrNq39LFf4w4qgXU4tLnPKbOavlRPCUK4HlluInRU8JP8BJ3puXuh51TUadnXdVLmK3S0kDuGbSq65I41dmd9vhdzfn8QzusMrPEd6XuHQteUnwrM5iMewNor9YSvrSY4iGyC+ZsfWPKMYJXNvTH2y2cSWU3FwBVF5oII7PtK4+fbzXgnQ8eJd4Hie8W/bKWAGGvDth5Q5HgxorMIaaayxwkTgPEpnJBLujX34cEwnpbdY
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(6486002)(478600001)(41300700001)(66476007)(66556008)(4326008)(2906002)(5660300002)(8676002)(7416002)(8936002)(7406005)(66946007)(6666004)(6512007)(6506007)(54906003)(316002)(6916009)(83380400001)(2616005)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GtOLznAnNuAQcfMSwRS1Zk0dMwbiMj1bFM/KPV3GS8rAK4WfStasuNsEYVMz?=
 =?us-ascii?Q?dBg7mBpJY0+nLB9592/MlG4ZyV+v9SVHf4Q5YaKSfOHx25pPyt+i3urmkDmV?=
 =?us-ascii?Q?w2T+8RUJItJ36ErYW18IrtadosKX9c7KIErmOJIrKb5usNJFmauZwkPzPSRk?=
 =?us-ascii?Q?ODSTiBXDAFxiMauHjsG8VDrpBkY/Ht0gGdCpQPl/eoh2WNBLAQLZIp8hj5Wi?=
 =?us-ascii?Q?0jAdjfp4/6l68Dw/M7gsuBuvBZI6g30L/FcU/k+VUDS6u9VxjQ//jv7oon76?=
 =?us-ascii?Q?mBG0mDZF+Z2d1J4DzDoJyDymV1FC5MA9o1QQ7EZ7mmoAfYJ2xrQYWJ5woMCS?=
 =?us-ascii?Q?J6GncV+XfG9lq5m0mINOisBBb7eD4bMFPTPkXCmlqsq9M2lLFgCOuYH1nCkJ?=
 =?us-ascii?Q?wvf7KkTyPtc9IyCMFnm8nJHOLaZQ5urdz7mledvMHzWZlSKSJSttnE1o41s8?=
 =?us-ascii?Q?68kasMV+eaMExk5pIqxq14WPiE465/7CFohPAfhVidvwAJWk7fNYSIynt558?=
 =?us-ascii?Q?1mnfi5YxzFXNco9BBfZ6beNefp3vg89RC7oqXfWcu47Dr91Tpu0lHDkVBEUj?=
 =?us-ascii?Q?mSmOTJ9zT/nXCmMNARpe5agjsJhbH1zs3GST8uW15NeNsxBUtbjH+SyFKF2Q?=
 =?us-ascii?Q?rxFBpF0VpAGFwUkHrR8203qZ7kkQfYJ7NliCG51zai+e1jL9wkw3r9SUWSbZ?=
 =?us-ascii?Q?Xb/e9/JCAeGiYvJ9p73yZ8QVkqUO1nGdHdXoFVxP+FkH+1xgOznm8Zj2Uzmv?=
 =?us-ascii?Q?/pdd+Xp9AhBJlbtgrGmsHvSE683EA0jhyn3+FSYtiHIHaG+ukqYsQ81ciftb?=
 =?us-ascii?Q?U40pV7X8joSmneL58APmUG+3r07o3uJH9Q/mJpVUlUTATnYcR6/xE662Z5jf?=
 =?us-ascii?Q?BRzyfOaShzUtu/r+EOzLi0bUHjAwZAvzWdsfvxktzSWFGRJPYrvTEP17A+36?=
 =?us-ascii?Q?c9D8JQ1d9hlwUUFAlCpP+kmFPaXRWZ8wi16MXeAVxzX/uEsKuWulFkwI9iZ6?=
 =?us-ascii?Q?V6imbtWrXHn6IfK+xORZgCClQFGKW53gu0G/PJyy8ieJgOVKKijc+todJlTW?=
 =?us-ascii?Q?ku9RN7Y2t29mQxyUUCdaiyBoo1gsnQcQ/EkRDajzp4yV7y8GtVi7RuqiVGyn?=
 =?us-ascii?Q?vt1rnqGwnq0YybG37HKQlKNS4R2s0w/x3RvyU99FKbUUNPoBExj4S1HHnRwj?=
 =?us-ascii?Q?nVeOQXFnrdZHMReuArm2ZgfE8xcZpxg+QFPNpVHn00oKk/H6eDeHEwDHT2Qr?=
 =?us-ascii?Q?tomroUZ7EZyeYjFwkU0LaPGWkgaStLmQj+ZBu7w+TUa2ovKsu6fBRTt2mJnN?=
 =?us-ascii?Q?IFquH28fFnSpmyWVTqcpKie4XPWshB/LlVJK6l8yBTZzmjzOePT72r7PvWNo?=
 =?us-ascii?Q?VlaXMb1Wx8IXGeCmceG+7N64ANMkUSi5T9eoibBBz2den8C818gVwxzFBjOM?=
 =?us-ascii?Q?V8dbQWuY4VSGIn56Lr6VS7CxoaNVvF4YzqSbd78i034/mk20Fy6ET8W/WCEB?=
 =?us-ascii?Q?TgU7A2SOsyUoKK4ea54uVLmQShBI6p8BO3Sq9wFlPqxQmshiv5RB0OPF17Gk?=
 =?us-ascii?Q?SBhGQZWcHANGbwAfm0rxMgLy9rxL32InQMbmD18I5eRFp+fWF5uG+8hfqkX9?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MAaAZXPOdflalpRAn3648kai5pUyM08R61U4sQKRulTDby8DqeIab6caDFlO4Tbw6KhcBiPzngsdFQdpBI1DDDrxMg07BO0ZR2JW6qNnv+CTNeS4y+gHJlN8NU93p6qkq2qnpBc+2+k1uQSJbIqcODBz4WYb1bFOm7FEqpa9JZlOECmyd8I5HUzsArd1XeLNupCVDKe/jIvWUcifVCxWmv+GKjzqV+eaYF3sG2pRWMkfm9lQARABmGQ2LEdpAzQvwNIh+CJL87qZDkJIi2GYY/Wq/LPshxEFQrmZCfxIr8wtvQACe+0IDApzUldZGeQZES0yO7F9cAzDZtkm6psf5Vo3YlMdV+vCmzY7tw4fLVtGiRpdt5xom/tFuNMdAe03It09QeVbS5Xgc1KyJyfx3bp2vD1mp2qp57EfpWQ9Zfu+Vk7nkRCvZFxKHLpZsmVC+iaM4Ms4Qo/cnw4yuOzuG1jYl69yjSpm5RbTeqUYw4Wgj5OEnOKna2WzhJPXcNHrF2VhIRd8OZhM3/lnBoa6ZJTKPQi/PfrKPZW2mnsBk7Vdp+mhTobctihnMDmfYVvOkQOJ1GymJFz6D4BADNb8dW4hBWB5WqQzPc3mTZao4I0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7343258b-1a40-499c-8b60-08dc2ddbb992
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 04:08:11.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUMx5HHCdDZ5xn0ebeAZH0GcK6T12RB0B4ASvoGO9VDI5w9hdmqIG0aAUcV8AfmjU1zcmWy9sTUT0zHbofx2ZDIH82GZIvkHHfMHG05kklg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=959 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150029
X-Proofpoint-ORIG-GUID: ZqQZyrvHICg2Vc2ELhSv-yEl9aXrGfrk
X-Proofpoint-GUID: ZqQZyrvHICg2Vc2ELhSv-yEl9aXrGfrk


Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Feb 12, 2024 at 09:55:27PM -0800, Ankur Arora wrote:
>> tif_need_resched() now takes a resched_t parameter to decide the
>> immediacy of the need-resched.
>
> I see at the end of the series, most callers pass a constant:
>
> [mark@lakrids:~/src/linux]% git grep -w tif_need_resched
> arch/s390/include/asm/preempt.h:        return !--S390_lowcore.preempt_count && tif_need_resched(NR_now);
> arch/s390/include/asm/preempt.h:                        tif_need_resched(NR_now));
> include/asm-generic/preempt.h:  return !--*preempt_count_ptr() && tif_need_resched(NR_now);
> include/asm-generic/preempt.h:                  tif_need_resched(NR_now));
> include/linux/preempt.h:        if (tif_need_resched(NR_now)) \
> include/linux/sched.h:  return unlikely(tif_need_resched(NR_now));
> include/linux/sched.h:          unlikely(tif_need_resched(NR_lazy));
> include/linux/thread_info.h:static __always_inline bool tif_need_resched(resched_t rs)
> include/linux/thread_info.h:     * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
> kernel/entry/common.c:          if (tif_need_resched(NR_now))
> kernel/sched/debug.c:   nr = tif_need_resched(NR_now) ? "need_resched" : "need_resched_lazy";
> kernel/trace/trace.c:   if (tif_need_resched(NR_now))
> kernel/trace/trace.c:   if (tif_need_resched(NR_lazy))
>
> I think it'd be clearer if we had tif_need_resched_now() and
> tif_need_resched_lazy() wrappers rather than taking a parameter. I think that
> if we did similar elsewhere (e.g. {set,test}_tsk_need_resched_{now,lazy}()),
> it'd be a bit cleaner overall, since we can special-case the lazy behaviour
> more easily/clearly.

So, we have three need-resched interfaces:

1. need_resched(), need_resched_lazy()
 These are used all over non-core (and idle) code, and I don't
 see a case where the user would find it useful to dynamically
 choose one or the other.
 So, here two separate interfaces, need_resched()/need_resched_lazy()
 make sense.

2. tif_need_resched()
 This is mostly used from preempt.h or scheduler adjacent code to drive
 preemption and at least in current uses, the resched_t param is a
 compile time constant.

 I think the scheduler might find it useful in some cases to parametrize
 it (ex. maybe the scheduler knows how long which bit has been set for
 over long and wants to pass that on to resched_latency_warn().)

 But that's a contrived example. I think this one would be fine
 either way. Will try it out and see which (tif_need_resched(rs),
 or tif_need_resched_now()/tif_need_resched_lazy()) seems cleaner.

3. *_tsk_need_resched()
 This is is used almost entirely from the scheduler and RCU.

 One place where I found the ability to parametrize quite useful
 was __resched_curr(). So this I would like to keep.

All of that said, and I wonder if we need these new interfaces at all.
Most of the code only uses the NR_now interface. Only the scheduler and
the entry code need to distinguish between lazy and eager.
(Plus, this way lazy and eager becomes an implementation detail which
doesn't need to be known outside the scheduler. Which is also kind of
the point of PREEMPT_AUTO.)

Say something like the patch below (and similar for tif_need_resched(),
need_resched() etc.)

What do you think?

Ankur

---------
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 58e6ea7572a0..b836b238b117 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1953,7 +1953,7 @@ static inline bool test_tsk_thread_flag(struct task_struct *tsk, int flag)
  * tif_resched(NR_now). Add a check in the helpers below to ensure
  * we don't touch the tif_reshed(NR_now) bit unnecessarily.
  */
-static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
+static inline void __set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
 		set_tsk_thread_flag(tsk, tif_resched(rs));
@@ -1964,6 +1964,11 @@ static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 		BUG();
 }

+static inline void set_tsk_need_resched(struct task_struct *tsk, resched_t rs)
+{
+	__set_tsk_need_resched(tsk, NR_now);
+}
+
 static inline void clear_tsk_need_resched(struct task_struct *tsk)
 {
 	clear_tsk_thread_flag(tsk, tif_resched(NR_now));
@@ -1972,7 +1977,7 @@ static inline void clear_tsk_need_resched(struct task_struct *tsk)
 		clear_tsk_thread_flag(tsk, tif_resched(NR_lazy));
 }

-static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
+static inline bool __test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
 		return unlikely(test_tsk_thread_flag(tsk, tif_resched(rs)));
@@ -1980,6 +1985,11 @@ static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
 		return false;
 }

+static inline bool test_tsk_need_resched(struct task_struct *tsk, resched_t rs)
+{
+	return __test_tsk_need_resched(tsk, NR_now);
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return

