Return-Path: <linux-kernel+bounces-99792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2A878D71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD481F21DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2BCAD5A;
	Tue, 12 Mar 2024 03:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dOuVIPDu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lbPjX/4V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD8AD2C;
	Tue, 12 Mar 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213422; cv=fail; b=pYxH58Re/4PageXDA8bmEAv0No3dkA+5LrxaxY4Ebe7HmlAJELy4LvDSxse6vLvOTsLakAja0e8u+d7sS10K37JuodC6aoK7cnykLqeQC8eoNLawBQ11xesHbuxLKVbguioXfzyNH/5fcwRwDF8wsZ94iVP+kc2MrRnjWSRXMMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213422; c=relaxed/simple;
	bh=mRnTAXa1RW+9+PUHSY4PzxZE8a1JOYlX6tXWuPfgbqA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=qgnJEyx90fcs17pXdfmM77w1AlwFKDy1rGu+xj3R03JQTvTe/Mj6r/RJT12sPelh3DtDN3Z+0mrtLmJi2Dx1BmHII9dFY4xFvh8J3zk75/LTTzqu4RagRSlIjpAZBShe1beTR5/NcLHPyOpiFRVa9SiFpoD0JYNJ+wJYv+zM6cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dOuVIPDu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lbPjX/4V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42C0xI33026232;
	Tue, 12 Mar 2024 03:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=m6Q/vQ2y/kdUWFN1Fd/9pldJdXoBv6cb3pNKvJkrbvE=;
 b=dOuVIPDuw2jLRkHjj+D4ql8oBkZlZunlevdENXAIhC9j3+6npB57qv6S3r2JKBvOcRp6
 yZYhCiniUvLQ2p8v32rSGqcXS/uygSeT3mFX71wq2jV0acJtRGVLWDxzHXUMUCUm4KZv
 crjEn5jFfb5kzuYx7UQu0BQL7k7S6SSG9n1wYTsW+6svfCtaF3SgfcCGlyQflJfccqF2
 ddAwAKgNocCLCI2bcAJ5Q+KG88+B6GXyoATCuzuOU+2neLjEXDQE3TUYyUrgHIc/9XxM
 orYzf0SSImCt1Pghj3K36uh4/Q67bojlUjpZT+Gql2mGByFsBgjDelgxC9PG3g9idRef TA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrgaumrkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 03:15:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42C2ZYNl009116;
	Tue, 12 Mar 2024 03:15:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7cu817-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 03:15:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+3wyTMgiige2nogzjhbigPrpbOE6rOwYMgEDDoImqvVf4sqUlCpFxu6gNsZeNYT+dRKm0hOaF+1/7Lq0Y4E/BVBD8Z5oNHrgRbfBdkdJXGcGp86t4HsKhGos18lmsVF4+TIVUZYC5aaHVZRLxtmvK3SUOlDJ3vJdtgGlCe/x1hxDYJz/QwUXM8Qf8+FkidPUR5gWfJwQpaSoue6gq9mui2Za5teBsdZeE1EflyQbnpjBAH+GjfXJwYU2M1KqK/TZsTcorqMFeId8GVPKIAqU0GWx9cjUi2a2sOfayWitKaPdkZulUnyy6bRh/NyAT5Dtibla+5l6COkDJMaQqI5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6Q/vQ2y/kdUWFN1Fd/9pldJdXoBv6cb3pNKvJkrbvE=;
 b=HHExKq78URPME1TyO43/79DRJIiaiEJrLM5iue+3LFn+ATrNnWRVOWY0/AAYFLZcpvl2c3xJTmO1JkO/YNjWGPnW59gelc9HsuCl25WF+zp+xk7i3sA+HpvCr4c337OZHuq2fSmDjwGKv4ctxbGnFo727G6yiK39bLNkfdjhxmihL19Bo/qcjmWSuDUalFUUyGVALrm5Rh2vhPyB2X6JtHXXussYMJ2Qun/b8lEYoCJ7FDPiT0ICt33rPG3qM2fgi3YGqAHKqPXeJNEeu5wxNYa+QqtMKUrdOKITkR8r/AagYY37YLwBvL/YPfXCzXRMR8i/hAdPcRCCRYixQViDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Q/vQ2y/kdUWFN1Fd/9pldJdXoBv6cb3pNKvJkrbvE=;
 b=lbPjX/4VueuBqC0ejRS6SOAAX9jGglz+EzFo9g6CvZ2OsufK8WWgvIQbmF2Wr/ZMo/j87rI5tII++PfxWP6mtCWmN4EuOsBllbGSd+hx+/JUX246jRlJb26XmH/Mw043cEbbNsioi7Yga44Zn+YxkI1DdCpuBUCQu7NwGGdXlrA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB5803.namprd10.prod.outlook.com (2603:10b6:a03:427::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 03:15:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4104:529:ba06:fcb8%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 03:15:40 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
 <5b78a338-cb82-4ac4-8004-77a3eb150604@joelfernandes.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
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
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        rcu@vger.kernel.org
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <5b78a338-cb82-4ac4-8004-77a3eb150604@joelfernandes.org>
Date: Mon, 11 Mar 2024 20:16:12 -0700
Message-ID: <87msr4f8cj.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR2101CA0035.namprd21.prod.outlook.com
 (2603:10b6:302:1::48) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aedd639-68e3-4320-6c94-08dc4242b1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t6IiCkgmaDr3oSI8H9QHkggWoMzY1m6GxiJdErv54bsL1XiAWGB1BSIp4/riq+HUllQbpPzWF5PE7J3JOtCG/78sAPdQVZK1QE1/D208exJrB4SApcCvgdtYqQq/V6xBzJJ1HQKDz9mNKa//YyK+R5wi34Rh/gXe/Us+nl9q4Sz81Zu6D7YH5zUAGR8xBERxunlKfl09Q3ET4i1cBwf+kNNZJ3DimHt1XCp3qNT83qfzEAuY9uaf/mWSzs75bCREzz2wKh6pUdfmMUWEHxh/dzxrMnrYedLDuiEDgW4uJ915y3YRNwNNx2cOZfK6zDdm/arEoKGz/id6E0pE7APiIaIwQa2XqL/5IF75ZC1u88DKwyTXwt33dx4iiCfUvG/JZ/FZ4M49V/UPlWCsbK/qwFf1Xi7miJrRYQTJx0R4jpMgDmcmxaQXbqdmaFrHfgb8XFvyw3ZcM4FL8icRMn+SRqBOQ21LUbz/9Fl8FWqDX/q/BdAlJQbE97tC7i6DbgysQ2JOm5m9JTyOvLc+h7DpOGL/LZTp94JgYZf4EphAoesjPVl1w7e7htg1PcP8vzuknk+S6hIZ5PhGUvvGCyLQZ3MR02emjJaSMTZeJk6uwy8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vIEasew2LRTSlr8yz8jx/G4d+XylDKYtEWD+qGlNus+rwHHtbJDgovxblCH5?=
 =?us-ascii?Q?91ghR49vsHPr1VPk/063Qv2Ukly/hkAGL6FhJ5Lf7SsVg30cMD7n4z5lhG29?=
 =?us-ascii?Q?iV/h7m3Z1f5VQ4gtVg+k/t9+CJnjaqczi5+dwa37TKXCF+wW4qUtqxKurUxr?=
 =?us-ascii?Q?iZcI6xHHbFRwxqFlGBbX6WD3N13mGqyJf6Qh4wZi+6A/bnDCAAm5qEs2bsC1?=
 =?us-ascii?Q?EuDkws+bQjbLiocufKXgfep1oAWd6aP+/l6aZhCbx3ERNq805l2yfsdjitaQ?=
 =?us-ascii?Q?5LBXZHpIi7UD3DGvYFkv7wRRf6kGYPNllweX47bKdN8cJlMriTqAAfQiAQOM?=
 =?us-ascii?Q?0p8gOe9FTmfQDP89352NuKsADMc4YuFHXpnTSCEDh4Ia0eTbDRyvzlksQ/l7?=
 =?us-ascii?Q?Hh3xUmnCrFqABt5kRitCM4hAzo8X0NWwlvTTDi6DAJTKWdViQwmqrrNyzt0D?=
 =?us-ascii?Q?UlM72BAlo/Kve0BeCR7ViCR3EDvUA0vLV+iozGPp6WMqWKoTiFgoTwbkdIJH?=
 =?us-ascii?Q?t2+ymcW65N1bZhPfrzL0FpIwouGutdjyLImLEBZl5q8BqkoVs9m8gC681pUR?=
 =?us-ascii?Q?sLnlchZst8EXRrRmZUxKygYOjRPwgfMtreHZKX15NSxUGpLbGGUITDOrmzjX?=
 =?us-ascii?Q?Sg4G+ZxrbaHPQ3nbjY+K2adE2mSovyLP39lh7nnJI6E70dnPUouvKxzh4aQJ?=
 =?us-ascii?Q?oJv0cyRw1lokgSnMQwZaMhr+DJQSQPy5IyyzGzlSxzYP35jFJQtOXi8jLG2c?=
 =?us-ascii?Q?Rqh0VwzOau4+ukz3rL2+QAAyFRTOzAQL8f97mU2qtB7FmNz0m9cHKqtB2HEc?=
 =?us-ascii?Q?ckNTcEuwpZIP+GKHuEKXqfSftFE9+L43BsSl/nyTF90ey7t1ZPJhnM5LSsGd?=
 =?us-ascii?Q?MXmXyAptqQsfpAaka8MgI+xiySlovnMVtoGzbML2B2EJi9SCTIz4jXE+Icb+?=
 =?us-ascii?Q?WaVLkxvd6pUWmbyZwRUAPoLmGPQcS2t1es1GPkGlvaosWC8VEn6bLkfYvj8h?=
 =?us-ascii?Q?YwfuKsMgK/IPHfI3ayzVVc2DHUld5KvMq8eY8RHgIPUEg+3JBL7In6Crc9Ze?=
 =?us-ascii?Q?Xdx0mjROe1u7d2E5URCLieyMpi/jZwrwQZWxMJPuvJGwvNgF1EpJmVj3OiYQ?=
 =?us-ascii?Q?OAbi4uJp/GSt+DY1AEy9lfASlsIZag+82vBAdQ1NOc7A96diGuVJ/dWSt4mx?=
 =?us-ascii?Q?LqT2m+GGpCaXKHkKOWFopuwA2XWXjwCXOe77rbzXPqzNrDmNpermdo8wFYVq?=
 =?us-ascii?Q?hUYkzqy8lpgBhyydLBvkiLfQiPjRi17DaW1TeV/R68/DQirR5bhWLBX9mR0d?=
 =?us-ascii?Q?629jgRgJkJDo3hSnLXYYTBGL5jJemAvQ8BW83G69ji3dDjG/UOgijL6ldgVu?=
 =?us-ascii?Q?DE6IkY8JgC9O7VT96T9Izare/Iys6hUphyg4xQuovCHQAg7ljfiBF0D0rNlJ?=
 =?us-ascii?Q?HYbFxn6FMPfpcsocxBs/MTzVZMMDNnXSTSlidZRLxY+3w9DqezfYGAearprE?=
 =?us-ascii?Q?xTtadUJQBgYAyJW4j+Tft2q02nBfZOdmNSr7nZ1kjfZ4Zfg4SdG8vTsHJo2D?=
 =?us-ascii?Q?LWloPEGL4dSK0IqWZbYYHT9+v6UIgIcvEgd5cwSGMfNONfcoPTbZQM5snGP6?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Um0gcGoVMVGLFWSMrI7BFaQ4UAIX8uo43m3cIP2lpEXU6IDC9XGyg2BDs/U4p3jNMT8clcJy567UMSxMwt49xSga0fCwZW8aCIkIpJqPcdxFdhL4FDryr88jwkiAJgfoUqt2hYN3WdKavYjy7T4rEMkhP0RB6ZjRuMrBCyje2c0MlLCdP+S/r2QHDMLtslnt0uD7oLgQAEsjvFq89GEZCa7Vjc5Fn135C8Od2MpNRjhU1Jw12TOcEyRpiEYHCJEy6Z8QbOQ/NEGdxjLFsjIKkccDP8j0ZS2JJs9scaswu1GYJqDfKM0a+W6a7DbvQPsn0sS1+2GILVhuw+/0H5dhlq/saYh1EKWZExNBRiF/O7MlKB6Cm5HuFr2JWNR99wOuMaRPTBf9vsoQ1m6+Hgbv3ZWdkbrqdJnE2FDWZyl3c8OuZJXn7JVTE4GbyLLfHLL0cn8qIlU71jvdcagmkZ5yemxCrpqGQBz+DY8wwed4IQTQqtg4kS19saiFsdqWWTi28jb5r2dMJgr41NvLx9wy13t2ow3m5RYLr9u3zSv9R/zD/aLylSxx8m4P8VRFzFXOi/gNFV3rlcp5JO0u3AhxHzAm/zf9vJSobDlfyyu/qpE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aedd639-68e3-4320-6c94-08dc4242b1f2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 03:15:40.2675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsWHdc+fYmYqEHgRlcKO2UktnLdB0hhfgRaijwXuFtkZYw3inCOUxZKp+flmxX2LxY79YC9WjN2YFJAocwpK7G0w5nZyD19b02NyctIsbpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5803
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_02,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120024
X-Proofpoint-GUID: 9RWi8GXA2qZYevKGBXSInQLiXx-G4rVR
X-Proofpoint-ORIG-GUID: 9RWi8GXA2qZYevKGBXSInQLiXx-G4rVR


Joel Fernandes <joel@joelfernandes.org> writes:

> Hi, Thomas,
> Thanks for your reply! I replied below.
>
> On 3/11/2024 3:12 PM, Thomas Gleixner wrote:
>> On Mon, Mar 11 2024 at 11:25, Joel Fernandes wrote:

   [ ... ]

>> What's wrong with the combination of PREEMPT_AUTO=y and PREEMPT_RCU=n?
>> Paul and me agreed long ago that this needs to be supported.
>
> There's nothing wrong with it. Its just a bit quirky (again just a point of
> view), that for a configuration that causes preemption (similar to
> CONFIG_PREEMPT=y), that PREEMPT_RCU can be disabled. After all, again with
> CONFIG_PREEMPT=y, PREEMPT_RCU cannot be currently disabled.

I think the argument was that PREEMPT_RCU=y is suboptimal for certain
workloads, and those configurations might prefer the stronger
forward-progress guarantees that PREEMPT_RCU=n provides.

See this:
https://lore.kernel.org/lkml/73ecce1c-d321-4579-b892-13b1e0a0620a@paulmck-laptop/T/#m6aab5a6fd5f1fd4c3dc9282ce564e64f2fa6cdc3

and the surrounding thread.

Thanks

--
ankur

