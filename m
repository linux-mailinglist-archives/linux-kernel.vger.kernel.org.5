Return-Path: <linux-kernel+bounces-62985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5A852886
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D5D285D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8825A50A83;
	Tue, 13 Feb 2024 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0u5NpBY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aglmZ36X"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89C50268
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803879; cv=fail; b=NgaiFwdilISOkCSAKzOIsnF138xROe3qQH3yzkYwUIdFVK3dilAIZ2RVJALQAHXwEKIJamBycpsY4uNTjo+rBcyQ3dsb07Wji7hLEUzEiQPcL5iJQUMtknqOHZZ4YpWxn2CeEkTvnT7/UEyu+4ooEVeRz/c5gNxCa55Nhnqbzm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803879; c=relaxed/simple;
	bh=FNQMu8YhDbr2MUMb66k9ed7hDgUXcs2hgjnC5X1ydDo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZN40BV3qwCkhRjCpncnaqON8OSgGZ69VrJhmiZB1/HomkAzGcKGiPHy8P1ter59vK+zh1U/1XUw5bhRcaYvotk5DUL5FgeBmHpHa5k30svb2Ec0gvaJf7oUt6iG9uCkf7MwvTQ7kbdU3hSdXGZ4JHktfmxVzjrgPFBHeT/LcBp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J0u5NpBY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aglmZ36X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5ngWi028876;
	Tue, 13 Feb 2024 05:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=gE7irObtoq0nTvIx4+u0CN8B39f4Bzk1KjFzpyKSFBU=;
 b=J0u5NpBYSvIX41YUBDOf7w579rY59Pd0HnVbH2khmMXRCsUSvVV70ji2xJHDVXHxPGq5
 y8whhnhEmJlblaeVnc3IGv9jxMZl/zHeFpSqcvsf8PxIHjpzacZz4NQrp//n4eIpmTh9
 KIGHKwBFlYbwmHoRgVpepz30GPTlBj2zkm6+LsE4avRNhiVCmY04WUxx3+tWRACJnqu2
 m8sccUs7A2BWe7LFEEwfoVhBO/cBXk730zN3mcYsRrzv8ApYuaYLn4N47YZRR9LGxzwa
 pcMUQUHR9vhCoyZeDkYr4wF5uIEdtgQe8bVgxbniApNm0mM0R3WNeZ+NH/O9QSRXkIIh Ag== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82m480kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5oR4G013773;
	Tue, 13 Feb 2024 05:57:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap9gpjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:57:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeCsUur9sG5Mym5f3wv1Te88d7opzIjYBmW969w8c3NdfPMk0/w5bkb46u231/sSO5jxQ7TmXCA+7WLeFvrZyDZw7rCv0xV0twOeYRKKpKy9iuyIP3hSmzQ7sljmTfl1OohNZ5xB9nRRlO1rvpHIKYnBjFg/1Eoh2bqyMrkDJsuDTFH3dcXTDJo0cPacxtG703RlhxLZuTSuqdPIeuG7mEWll3lZdaD3HMBHyd006bF4zRFI5tudW2Ewk4iM+YKJn7OQKuXk4+a2HltMAFRNvafFcsjJPV4ZHBIqeFmTbcuw/YY6OSz6yUFynFei8e+lpmN7H4hgHFHiC5wfaV8JCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE7irObtoq0nTvIx4+u0CN8B39f4Bzk1KjFzpyKSFBU=;
 b=Ow2OdIjQcUkDJ/YurjBIwy5TkbgQaPmk3+7SJahBvzOr4W3v4hVjk4juAWRLmlF3l5asgsL9+qeS8xkVgnXF5y+hqY60DVmHm1jTVL1BcT4kA3iLTorlwR87jzQGDShgUGUx9lJgKcmaX/K1wtk2xpxutcDWIMwR7M1+8B7p/TeXN7YRTnioeHMOSnU+bxaLaCwr0mKOwEpV1q1ArACEaMbo/zry3nlITpxV554G3aJV+qrPgCZtdarQs9RKkk6TwQlwh8z74FB+NCqDN0r9IOjSgRgBwqOq6sNm2SF+tyG/41UMB7+cCJZU2YlcXVRN15az6wbg9A0uNyiuBMnH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE7irObtoq0nTvIx4+u0CN8B39f4Bzk1KjFzpyKSFBU=;
 b=aglmZ36Xg0/lsjq9NsAzoRR3HhQ7d58t2JlZLAls+AZKXRQTbcCZE0Dk3EGtPsmxgDwj3iuCI6AGvbFR8Y9w5f9KYis1zDMw3febEEbqCcquQG1SUGRTbTDwHYJ4FccSb191wTPD1xMSqOeFnQG3TVGRomIHu8ZYvJE+x1gzAc4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:59 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:59 +0000
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
Subject: [PATCH 27/30] sched: latency warn for TIF_NEED_RESCHED_LAZY
Date: Mon, 12 Feb 2024 21:55:51 -0800
Message-Id: <20240213055554.1802415-28-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0172.namprd03.prod.outlook.com
 (2603:10b6:303:8d::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6d2261-1dde-4e92-cee4-08dc2c5897d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	d78Ckh9ipsAlfoOgv6f7fU5VJ8LjYPn+kz7I+Db+Py+FWWQu0ju1/LncrVjA9/PzWabS1pXyiNLeXhcdzBl/yu9DaRFBjCjcJSZi1mZp5/kQP2s7UwVSIzh7HdBeu8uuNPtJ3j8kPtyhA4ZsDTEUWh2IFWsGsn9jo4qAaKOnHIs9Q9bTpR01N5Txr6tZHJVdV0Tn9P5gZmE5jykB6w2OjKqEAjOMLvL322Vpw0jqxyuvGpH97DhC1CVjVN8MMR6isMoeE99bmguY5toIRnj+zdkLCUeR3bBAgXCVO5qFxeRlsYpnJdtZKDg459BVqnTR3amONOevnczH7L0lWfDIaiXyu0oGx2ax9mQrwVRGc56Z5Uv1pyt+wXS/IANtdhvctGASmMlqshPzVnk0q8SrYlgl0Zjtf8wKeWSfgz3xmB5OVRmGdo5t6A2Xj83uHTTipT36B8U/tcyBcM1EtrSGBBCJL6ZNFJwFJ7zY9/IuVPue3lf5pstAhana0X6jJqH0dghBZtnEI5Ducx4EQE5seFCsXmn6A8QNkahqI/HjttMNoNXiDnktBJe6siv9ozOG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bPyW1ev6xKZmLdJ3AzbSmFKjh+/Rv4P1ED6E0oRPh56fREIa0uu+9tZ1Hms2?=
 =?us-ascii?Q?2d5zodxgI0WydA6sTBVDHEl3FljVVSIE2VMrfoJHAmFHSPMHD5zKP0yj9HTs?=
 =?us-ascii?Q?1A5lpLi+iJotSxwkSQNhNYA+wG6/tRw1LSrKhap3ZhUKEZ9i+RqOWXiOKRiB?=
 =?us-ascii?Q?Z73MRoBjobP7WYNKW7IfZIRodhtkz1Pe4a5zVR4fELWWxoQQOrsR90aNn3km?=
 =?us-ascii?Q?rjZ5bA9memuxrk9FbH1Cbd/xjj55PZgmXWVOrl5uOSK07tHyEZrW+zk6Gus6?=
 =?us-ascii?Q?IhBEJosOJ0doDhTawqNbQA1NmRHOcS2WkBif/vwJo/6Yu+ExBk5T0Zh7SC3A?=
 =?us-ascii?Q?mycGlkdCSuJIvXjh/fcI6NMfk+3we1qCPGOvM153N0qBMuTm0RSz9ozgBU14?=
 =?us-ascii?Q?lpE8TTK5c/7hXjO/UUdQhmEQOulOLuORShMxcA3vKgAgXx1wkHtQ2j906K8c?=
 =?us-ascii?Q?ojliSixthc4qOJmIw5CKG8joNWfBd4j8kh7E9PrIO8dkxxTbv47XNafVy6YV?=
 =?us-ascii?Q?eGBzcNQVuNOEzDWy8KEQ3ktLaNAAD8Cue5EL0RMm7nk3+13xqVXi0bctE7v6?=
 =?us-ascii?Q?AEzy428X28DY71LpkE5LGxlLcXNZ5UlHzO/KL6SGIWjkJ402C7D/STuWVaeJ?=
 =?us-ascii?Q?XhNwL0x5dW8Ej5aXHsbeTjEguAbhfzYCBMRaeKAXwJpmMLaNjQtYBG3Bje+Z?=
 =?us-ascii?Q?ggAMtV8pokhe4niRQ3zmN2N3tq/Yw0y/j+d6tm3kIS0Dp8GF2CxH7Yk+ZTJt?=
 =?us-ascii?Q?012dWyVkA6OnnxzS2fnXyINijTWRD9UVJ95GAP3RmAVIwE+piQRZ4LQZ9YFV?=
 =?us-ascii?Q?KbfYakrqcR7xuhk1AOv0g2nEJGTaRhVoBGwLVCJd/xSCGUirepliq6nx2K/8?=
 =?us-ascii?Q?J2rqp51UgIJ/AzlrrLrrrAGOT80o9OkG3EFljpLDlfsc6bIdBE3e1QSunMdN?=
 =?us-ascii?Q?/1gVmg3nO+/27AdmgWqOOL+nexJ2c0DY8VhB50Ab/RAb15mFeF0ldFsMoMaU?=
 =?us-ascii?Q?MQ6SYHe0q8es/tD2YQO5WiO0lMdNpOWpHPsU1MuVnX9L4wFuiqMF4uBSYxnc?=
 =?us-ascii?Q?H/udCCvn3fpFXtwDZ7xPc9p4g5lXishOBLFJBlRa4mH9/HpneXCFD9/doHo5?=
 =?us-ascii?Q?Hgti5ZtO+XQk7Lj02EdhovZreaB+vHgFraMcHii2ndmylQ1/+igc39Ts55Iz?=
 =?us-ascii?Q?DL7M8Xunoy+cUegCBtJjemyOix9cnTJ3kk5aH3NXaasgsg1Di4iLQ1oBwS6Z?=
 =?us-ascii?Q?DiwFRytrd1e/B9Dn+gUsduyJccPVbJFFKKX7ikDLp2c/E0O7f0cXT5WXXj39?=
 =?us-ascii?Q?d9rGY8AM4VelilyI50KT8v6pIV/suyCo8Rml17nO2M3JAjJnvSV+pmktp6VK?=
 =?us-ascii?Q?yNcvSbLROIiw+gq61XOLV6M7LRQwxj5EAFKku6satGKJe+Dlk2oolJtU5VcU?=
 =?us-ascii?Q?9Q7t51aoUy8g9VDW1NgHtZYLfdnAvu6TVgYQLfoCIvWzVEQj3cQMRkeeHnQR?=
 =?us-ascii?Q?8B+liRcsNc2GpR9UnASTdc/+s5MGDr+tHfB/JIbHJ/UbluGyoEtAKnawqJ9m?=
 =?us-ascii?Q?B167kpjFPccBx3SS7S2aEJUQfhyzklGuZscBh1cKNG4++yjX/cd+DCnyJKpv?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	CyAPiJElFVgU4zVTdiiOIxqzXvSHzsuVrYHFear/520Zjv3Lchx6bcrRBp5fody0hkqgfgw3sVCcP1g7F4aSv1SjIpVRu3jrn7FJsiu1oB7wrbi5RdrvVdYy7s6ab0QQfELMHtUfyEHtWfH0n1pk7b8gyPwTn2Zmk4BLjzDmikqHkW9baanfBkkrygpAO2WagRYxWIND1m9BkwHanYt5CSub1xdxVYpETZ8excNbqwM0HsKUZxsUkUryyXmamZMCKYTgy7+M4zW1iV/RnjkzYarv7nCU8CwQ4OqARSZQ/aSxIg6mfYXVEIYtl1/VmWG1cHJe+/f3JRitUtJsuQLA14fdt96CjtM1fSSfdGQJRIgw4Ayh6+ccNthN6x3Zq1tfWp7PaskB5dWySYdwxJ/QtJ2bJHfzGpZKmJc4smyxO8rXJDdq0aM98cEg9dk3Bc0OubhF3oy5m5lPE2bSy1XPegtSseI4WSxg3vMMCnKdhsLVwmIvpwFAjHgWv60e9Typ6vrlkOxQ+N1R876NP9Il6UOnBHiaW0vnHJUwqxVvpz1aATi4ZV4qp5TgX9PmvTaweM48cFKL6LHuFVsQSETsUrTKUpIr+Rx+Fb/q0FHAjOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6d2261-1dde-4e92-cee4-08dc2c5897d2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:59.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItYNgoKl+mfjsCVE796iDedzpAUTuTh7XvPpTZ0r3KmTEMKszNHOcxDTcrtX1dxuRIhLls+8uBeRyLvrJx+mtNBp2CTOV3xYr8u0/qDFPVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-GUID: UB6fNBix8VZudmMcdR9WmDz0v3Tti47a
X-Proofpoint-ORIG-GUID: UB6fNBix8VZudmMcdR9WmDz0v3Tti47a

resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY
is set without rescheduling for more than the latency_warn_ms period.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/debug.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aa31f23f43f4..cce84ba0417f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5670,7 +5670,7 @@ static u64 cpu_resched_latency(struct rq *rq)
 	if (sysctl_resched_latency_warn_once && warned_once)
 		return 0;
 
-	if (!need_resched() || !latency_warn_ms)
+	if ((!need_resched() && !need_resched_lazy()) || !latency_warn_ms)
 		return 0;
 
 	if (system_state == SYSTEM_BOOTING)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e53f1b73bf4a..869a09781f2e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1114,9 +1114,12 @@ void proc_sched_set_task(struct task_struct *p)
 void resched_latency_warn(int cpu, u64 latency)
 {
 	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+	char *nr;
+
+	nr = tif_need_resched(NR_now) ? "need_resched" : "need_resched_lazy";
 
 	WARN(__ratelimit(&latency_check_ratelimit),
-	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
 	     "without schedule\n",
-	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
 }
-- 
2.31.1


