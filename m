Return-Path: <linux-kernel+bounces-73782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 687C585CB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F27D283991
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA1154437;
	Tue, 20 Feb 2024 22:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HAG+T6OK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N1crjxPf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4EC1468E0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469478; cv=fail; b=fiCF1IXBL//luXGh6bXGa8mxk2DuT+p3fNTbWbp9lJpCQ373X80JAnM9qQO0FHdy6XJehqpIxWedPMoykr9UFLHRqpz3NwEb0McZfCaX42ziaA1KbAkDVddI/IaLauX0Q6qccat98Y2NsN/DNDUK8X80yUqemdjBVmKRghmH21U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469478; c=relaxed/simple;
	bh=GNrn4AlKhKeirljkZakDivC22O5kaSRFLHWaG09cNGI=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=NxdTZ/ZX8MsAb/UhFqmrK5K01V4YPhY47pby5QjNJoTvO6V/WAFdVx+yXtnX0UihEIpVIG5yuDyKL0EYe/Jx6xhh/sn6l8g9/1L119x4vPx+bCkQENNLN9bUQoNv5Tr6/3k/YorRxeqnWeMh3+rs0W0dvB2zYKeMFWicsrZhbeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HAG+T6OK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N1crjxPf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKT8Kc005983;
	Tue, 20 Feb 2024 22:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-11-20;
 bh=iEyLWuNZDMneKIDVgTKitLCD95XeMAeGJB0Tj8qMd7k=;
 b=HAG+T6OKbbCvQxuLM2/yVz2QVgAXmnf3ckcA1rrioaV4D270zEzYsjJ0dYii4fvmdO4r
 gcRkxcfG3rXXpb/gUtLaTxU3k2MkvRqWj8Qw4D9X5+5ikd/avmc9ufkLe+V+9wvlKpcS
 lG75hzZS6PbaR27UVu0SlB9874C+rKJnBT94eaiiFHaMURM2psjQ25u+q8xloxOtPAyu
 13RrbY7LpbmeFvr+khEBuRepgXzPEWiP/Y4FiCSdmJ+46p7EodqGPvuJh/Jkm7OqHhU1
 YtQVB+fa92iUOfTGDVMLkqTzkBMPFAvzJJ/CB1HDNjzJH3A45mjd3RUSUBuGAvU/dtGj Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakd28avh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:49:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KLMdJV039648;
	Tue, 20 Feb 2024 22:49:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak882uva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 22:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaNShWLtmf/GN8RKf47It4mKZjKoUFL1u9s6wOcW+TcmdNX0LJv9q4zRHjTyJeOScoi8+YkD/Om0owlS1PigQe3LPu0olgQfyti6eFhJd9h2vUa+D2Im2F2xtS1l/sn7rs6tLdwc0YcFXJQmo/kNNECLO6+P4K6kAagX7zGiK3L1olMh4t/9NRjfQe0/l+dGBJPMYRvj2PvUf+FwuzmPs576p6SxOHkJAFyI4jRFsYijUz8VuymqXMi6sJLDZVNsm2eUCVsn/xp4xspksLMnC0InN1GBnsIxvhLcERGPmyiD3Qr7e5rZ6A4xOA1/3wXm3bB2E9QXdKhrhTm68sVWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEyLWuNZDMneKIDVgTKitLCD95XeMAeGJB0Tj8qMd7k=;
 b=jNq9a+fUo6dLWHjcZ9/Whu6TECM1M2BK4YqQOmmGTdxKDmCdJZzBEz32ATReH8vWLwnVCunsXa0/7czl3OmE0eFdUUHuqawUcfAdGLHkM+3+ToZP0y1NCZNweOLVfZM5BmaXPn8O+V9PB1NqWxg1VZPihcogcbdytd3lzlweezHzz/GRtODeVDelXs8SZSFElvgm3METzc3e6Ewd8Be7VGZ3BKJpMVCaRn8Ljr22fbQIqh9z/iTEmxbldTxltCBFP55SVFsv3z5qEQTt713gLCmMKOjamJeTajDFLy+BbxunyE7v6le0WGywxgJ2r7pCbI4BfalV1PWcu6eeh1oYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEyLWuNZDMneKIDVgTKitLCD95XeMAeGJB0Tj8qMd7k=;
 b=N1crjxPffLjXKSLvVo8R6TOSywvtx+v7KiOPiTL/VaS+GoUSGX4aehny1iKS/Lg0Ci+MIURfrqu7orEMCK23TaSBT1M4ga0F3WtcRSfioiY5eD9ZBTmZCtSN2yt0vspajAuH3pMfU6pOB871J4CVoUJLWpUhW2T6cvtzOrsssLo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB6500.namprd10.prod.outlook.com (2603:10b6:806:2a7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 22:49:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 22:49:56 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-3-ankur.a.arora@oracle.com> <871q98a3h2.ffs@tglx>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 02/30] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
In-reply-to: <871q98a3h2.ffs@tglx>
Date: Tue, 20 Feb 2024 14:50:18 -0800
Message-ID: <87ttm2hhsl.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:303:6a::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: a16fffa3-00f9-4bc0-07c8-08dc32664235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jxyyK8BjpCZuOVDONhV8JzESYmUXScUwbnQa8WUH6woFMYjOqcV5CZz9A0Irg2/U5u0ielw4SmdwwjG2Uz7lKLIGBkZ242F2c84YsEj7CMpnefoqHZh+U0kCpJmtRHoqUK+zl/YcqQjV1Ea1Cf14S6Ug+SqcKHNtC9kzEkzKvYp7bbRU//lIx8FFh59HA0PeXRq9me/7JS3uINGNh2lsZrdWceMtGp0kVGzgGgzFD2Qr6aFqQzWuu9NDQkiRCxXLJ1nSZtYN9foEqehDLABcdds+n7Jei96ENAS6UtiNQKJXm5zI6IREJ0MLul1QurINdhFJCsc1Lp9qeq+vnqQpODgAAWhG8pi/Cakchg1GtU8Vb2826bWtmk8goWWfFKUELhH3Xwnjfpz3Q8BHMX7yBYqgIY1EQf7zsiVHbSmj5M2K9xjkhSJkOKrfaQ3vTnDviQMjkPalrrPAIl2YDwZn1w2mO2ZSngO+bRDk4pHjTJHU3/HDvRHatrZ70wAHnKSNujzL15+5ailsMEsTv7diT2YDMQk+z51K+d2+Lh3oBpI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+ksjBZNSuBGH2Ks1t1FlZMiwW34UzTdES2ZXuKJJyPfMFNWIc+D+1oFArYLQ?=
 =?us-ascii?Q?5Q7cuzhu3SI26Nquk3CoUEH7lnEKOMaO8kseGGyYsqK+1z7dS8ZdyXP5wDpi?=
 =?us-ascii?Q?xOR65MoRw6D2BFEJ+JJZUS8KaUwErkMrMjslixEx1lwD4x+vdKpd1O7vkuWa?=
 =?us-ascii?Q?dHdFXxUVmZPESMfTqOfFs7+klTqwYYdwqp9Q1MZIL0RK/QESwsF6txFkp9D7?=
 =?us-ascii?Q?Krn05fBEwKygfPKiF+R9Spoj91XK3MN2rL4HYe1z1okv4OdJBsOkt3FR7TvG?=
 =?us-ascii?Q?WhvxYuXghLfcS5AaHMQLWeF+NjTphc8TTtMoGdeMcDvoHaIRvOskTrxjByRY?=
 =?us-ascii?Q?L0eHN2WR3BfRkxbtnNNjpmzm5P3akNm0SGi2I9Pxm9qLvSg2DikwU2pyEOYJ?=
 =?us-ascii?Q?nYz+ZVTsncyEDnyMpMSDJRweMB8VBwwFHckGwN6gn6S4jX+51PUHZwVG7wxL?=
 =?us-ascii?Q?SLkX+baB2I3gnJvdka7GybwbUNtlTU4+b6Ss8VbF0+cn9BwrytYBVuMuEpX9?=
 =?us-ascii?Q?2NLitcJ8gzTRFbzhFLLQKvuzVVwnPPwAxBJlLDCS3z8CBcExSXYpjf1zyRKg?=
 =?us-ascii?Q?U3EVu1jlfZ/2hWGLv1ZjybiXqIw+n+tKrEURqZg7kzI2lcnSIYysNfbxQy21?=
 =?us-ascii?Q?q9KI7ka1L+c4khs5CHU4vBdNzfFpQ3MkXk7dIGe17jm0T6Cwm1w9da4+G8lv?=
 =?us-ascii?Q?mEA7loK7uWu3Dj3yeQ5YPc0tyuxyYfMM6vRzvZFflaWcZFjc8hgmaD+csiiw?=
 =?us-ascii?Q?UUNFkkPUZJmM/PEabVrdHy+wMoba01a50AYbDeB7Q/5q2ETFDsJjbLiY8DiK?=
 =?us-ascii?Q?j0HwZ/Zl529P9WzNRTuiUnOaE7qjmUsVMiQTRkPQlWh0UluQzDKcC7EPvZMw?=
 =?us-ascii?Q?tSO6/6w9rODH6PKI56U0M8VI9fzD4YtePQrodjA6ZNW2OrwgV7C3TcXQXLSi?=
 =?us-ascii?Q?1cCpGcNmAuDX7qLdqQXFnloLTymb6AQBv5TYBihk52lp/wqc3NHus1eDvM6d?=
 =?us-ascii?Q?TYUNSnZ2IBT+P8DYNMSc/PbWT/0AGJDzetkAOoAnKmc4A3iC8MsgMZNJRcy3?=
 =?us-ascii?Q?yiDTdl1yLatvTOoWZMbQT73qdu7+n4Idr660aKgpVvw8MP5foJTAQsNKWzb4?=
 =?us-ascii?Q?x0S8GJh0zSFfXJlonJE+dpRT9G5rSyCFFEZQ+IJv5bvUNIwc/iBRqDlUuggd?=
 =?us-ascii?Q?mfrhVt9w7BH5jOPlF1Rne7/3bRnUE9P4A6oi1l/mIZHnsv4rNTCwJLrvOkmP?=
 =?us-ascii?Q?yEac78JVXON1fu/xS1o7Eh2qLgKA+ZgYFaFut3W4Op08EKrKYmaQeZ930Q00?=
 =?us-ascii?Q?P8mv4WHfC7dbrN/BMa+QIA6cPPYsN4iExhOb0kbVORyAWGMyyrnOdbmYb93v?=
 =?us-ascii?Q?6C3dYB1HJYRo3x96zSeBNvP1tOPK5VcEexC0pyU7t9IpC7RXFUu/ZyBj5JzM?=
 =?us-ascii?Q?o1keIElUgHzZxthr9kaPF3a6YqbpBVCDJ0lTn1AOEkju/bRzLwJQMhReh7i7?=
 =?us-ascii?Q?RR04Rb2UbD2ZROFyd5aD2v7ZSgLZ6hG1qn5tKnUVh+Tv7C3aqrQ6VEbQX1Hr?=
 =?us-ascii?Q?A4IUL+S/+DEY/2dyOFItNPDOXUHR4Wn35db+4hw8/ImeyMF3Vz9+xeZSgLjA?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	q7TZhqbAEKwFo7afeAet+W4JWFjbY/6pRgO0eUbXWrTFUeVzfB/FBL8QeXT9Qvr/ZRTkwp4R1Cr/zRqlEPsnue6o5QFm17HTkV8U7sdoysj1XsszdNPCOitnvehmlVakBJyFqDXEulxFFRPSnsOZ9wLlVb4VI0CN+IPfyqzDGCIopqfpZMQpHv0gzcqK5S7Jq7ocZBrC5EuQIR5NaWHVyGt5QWhhxg98qSLotsGWkEKfkRJaBdlVnCKa0zY8LmXQ4wWnYj7KfutlZmKFEoLgrtNi+vpd1YIz4wAhi7nDkG31AxoCCDhJht90YBe/1OkqXYabuu9rWgff8rkfrFcqpCunnSpZ/Ak4CC51jRAfVtIcEolHobzJCvrEJcI9ZjKa6WnQIpssvs9MtEm1Bt7p18vTLy/rYfCEgtZThrLmrasetcI0NaD64rdTRQrVZPNk7xMy3sHK3ADEKWZpnOszBmNmhypCl/eiLAl4LYoaZZ+Gyq/vl5HGT65ND77a7+qcXqeldmUf/oPHHgNODW841NMgBKko9jdVj1TA0lGCfjXF3Jr8daSekEXLW3ZIC/VUZUCuSbxaKKazR+tAYt+ey/c4x/CJDnCL+k2cS7w5gTI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16fffa3-00f9-4bc0-07c8-08dc32664235
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 22:49:55.9565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8tzPlNhjLETHAqhLmLh2LSA6kS532vbSUIgATOoCU6Nyn8gB0krIoUQOEt6cVOM52U0ORst8Yhk4u8GW6xlFrKsdzkWrRI+lawq0TtdjRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6500
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200163
X-Proofpoint-GUID: t554-GNGal6P1axvHupAfy6kOE6itktv
X-Proofpoint-ORIG-GUID: t554-GNGal6P1axvHupAfy6kOE6itktv


Thomas Gleixner <tglx@linutronix.de> writes:

> On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>>
>> +#define TIF_NEED_RESCHED_LAZY_OFFSET (TIF_NEED_RESCHED_LAZY - TIF_NEED_RESCHED)
>> +
>> +typedef enum {
>> +	NR_now = 0,
>> +	NR_lazy = 1,
>
> Just a nitpick. Please don't camel case the constant. Can you please
> write out NEED_RESCHED_* as NR is generally associated with number?

That's a good point. But,

__set_tsk_need_resched(NEED_RESCHED_LAZY/_NOW), or
__tif_need_resched(NEED_RESCHED_LAZY/_NOW) seems a little repetitive.
Plus, there's the risk of confusing it with the TIF_NEED_RESCHED_LAZY
flag.

How about, something like this?

 +typedef enum {
 +	RESCHED_NOW = 0,
 +	RESCHED_LAZY = 1,
 +} resched_t;

Still, not ideal. But I think it's an improvement over those two.


Thanks

--
ankur

