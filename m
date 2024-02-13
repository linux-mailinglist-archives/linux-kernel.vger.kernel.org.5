Return-Path: <linux-kernel+bounces-62961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760DE85286A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AE21F24BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CEF17755;
	Tue, 13 Feb 2024 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nN4XiDc2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hq2hi/ky"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527521755A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707803820; cv=fail; b=l+7F5JmUYjNzZbGBgEzFdtgIf/q4TsygTE6apt27DJtR59+8gUiMpkt3Nn+bqhsW1T9wTfA2ddjex7OWUtPZCcdlObabGwaLkJBE3ptZbCZF8goVpP4A65YXkGkOFEnpeghxh95CCIHHFsKljHPsjP8zwk/34z9kpBboeU7Fi8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707803820; c=relaxed/simple;
	bh=c5aoa06uLaFqzpqTyRQALJlmMtWX84tL8prjP6W6Gl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bB0XArtno2Dao8jthOMAoX/g6zV5yo8t+rpzkzo8MrLLSXL9hGur5OX34blOh3ALtz41PK1kbL75iHPVlqSf3KQaToorsC0U4ZUrCVvD+6jQg9Piu//ivuvllbePnhESr6niyUWlkhR7qAAjOcV1I9EPh8W5DBkAjWWanqgDg60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nN4XiDc2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hq2hi/ky; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5YtxR005928;
	Tue, 13 Feb 2024 05:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=BWOjIhuEiE1aoMAgsLTjONO2NO8uIgFA2F8rCNlfaqQ=;
 b=nN4XiDc2HtprlrKdWEwL+gnTAhDPfA7ZzmzyphZpedjj4VPES8VRHwdJYc/2VBIoAuEs
 hfcfJ0XFQoSLV4f5r0la7PgoiycsvlkHC8SwJkh60BEjZGY9+9XUKgGcLJZRzXqweVIQ
 vJkdYvlOk5TxQd/cKLQOJffh/DTEIOpKeofVxkNPm17Ewan03Xi8We2N0caNyQuxXYLo
 7cXvgLJsXEG6Daj3WKR2RPpK39XUlISksN7xRqIERAad+y4vM+d61CzEZobwmedaHPzx
 e8XwpNr0dMoG5AP9Asdclejq7378tnnCmlwMS3b8pTLOYbhhiqqA0RF+lBJ3ENdV+Qhv vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w82d7r1ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:18 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5EER7015017;
	Tue, 13 Feb 2024 05:56:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk6k8gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 05:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hh3utZR/4J5tE7FzVARTnkDYbUBeG7cjwUIr93dPxQyoTAUI1BdERHpZRfztm0fsEKxnMQnVL94kw/+Q6DiGdbT5H9016JzON/pNL2Ce+wNlw4MqCvHLGMo637WagunS8320gKWdAO71ym+CxiHUUwZNEmDZL8N9xd5bnLiu/4lO/9NM+ul7sHAq88kvPQ0mgiu1uSlzuv4SF82HqYWxC6lirP3XPfjh9TY/G/zc725uzBIGoeavPdpmqUrNQKWsVpgj/yDDcz0PMHYzKsCw4bzDpqr6eM6EjT4bp9Pz3fquODQln3hz2mEOvFKsHAOC1BJ2h6Fkehot4FfxkD5XgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWOjIhuEiE1aoMAgsLTjONO2NO8uIgFA2F8rCNlfaqQ=;
 b=ZZgFxl92Me2sA2oR+PUSiq9+RPoqgMa8PfkcyRkMlgHmPWvbNcwjc1Hwl7QKVNIIOlnGREuJFf9hPm8XoJhAHhowDug4ePuQej3NH9luUrVQyAE3e4/asLwubModuWTqVVuQyg60QWjFpB/tcKQCuBVgzZWTeE0yxrkYxEvj3X6fgP+CGVRG11GCYkkQs944tCAaqWqzvhuWor/U8AvCFlvJF1fbvUigpkQhzNwlVKohtFFVh4hLzOSDnZyGZ38fkqj2PWSQdVlEi8ZLazR9nBrKFFhNlcpiYfToj1hEv/vDjO9I0myWMdWJ8hLXhRW3v8g/usnsdNzR79zax15unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWOjIhuEiE1aoMAgsLTjONO2NO8uIgFA2F8rCNlfaqQ=;
 b=Hq2hi/kyp2+kIxDHb6F8y7GBRD11xe+S28ithVhwPOdh6Uvk0m2vj+qRjKdX6XsQpzxBemMjF2kdMQwwPiSq/E1a2Nmhg8DYX35vM2TwmTu5ClATPuIFa+x9fqL+2SqVhF4EAdJOG86Fg9KzL4ECJ+h9GF0sPuIdLB4YZk6xOfc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB6906.namprd10.prod.outlook.com (2603:10b6:930:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 05:56:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::91b3:fd53:a6ee:8685%4]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 05:56:15 +0000
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
Subject: [PATCH 14/30] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
Date: Mon, 12 Feb 2024 21:55:38 -0800
Message-Id: <20240213055554.1802415-15-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0293.namprd03.prod.outlook.com
 (2603:10b6:303:b5::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB6906:EE_
X-MS-Office365-Filtering-Correlation-Id: a941a476-0361-482f-f550-08dc2c587d55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OAgf4K81EcG+nLCxrarAXGWccZcFIF0kl3MtSPuSrKjH1CvRayE2MY+ti5qoC5es7wDa6RDxf4Q6rKk4nCrwv9LlD9byEMH7kYzR02+rV6x+CFHajCrkwPaxTWD9XHNqexfG5ZsWtonPj7bYCBsv/5TjrTQXeOva0zV8WZ1+Kz7u3gjKvYuzaXS3INsMJbtvlsuWw6WawC/wUqZ9DzH283RjL2N2wV5Be899kUQfPtSa6ymfD9jl8jJcrm5ro7lRFhD37gpRHcdjP4lQtqLCBu9EFau8dKp+lLOzam9TUvASn8GRGpKDYgoCjfNl4tXCCmiop8ufofmm6z58HvYmxaEd/LemutU8WzAs+fvf5wH2Hs7rcmgiFdQ4bSkm2KCu0HIdX7zYZslwNA7lC0/rYoblyppQSZDKIRtxSSa8efCeyIUduo4fZtG0lX4Np3jgI+MQf2VJBMvBISkkcpE1oYg/Ocjo3sPsRXWZ+JJcNRVAKCzKvxZOPmSi6VtOse4+v8hC/GSZ5a0hKQvbhzMSST3CmHmbzETAOd0caSY8bHo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(7416002)(7406005)(6916009)(4326008)(86362001)(41300700001)(1076003)(26005)(107886003)(2616005)(36756003)(83380400001)(6666004)(316002)(6506007)(6486002)(966005)(6512007)(103116003)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4fuBaLbJwFFoa85otIIr8NVml3pcW/VwBgaQ7kt3axj6gB71p/Gk5oaxpCnh?=
 =?us-ascii?Q?EAT2eCNcC4fHDgiA4sImpN0J5tWGA4XLvbfUFFYOQIUYOqQp74+Be+VC1LVi?=
 =?us-ascii?Q?NdP/tW8lFm/MY0v4nHZx5oUKyBmYWHGAqC2dfwWOqBpDButKHnEjlVmCYZXg?=
 =?us-ascii?Q?b/gv4wReagnh8UXQTFlQ8lEeav8NXvttewJvg7hVbYunsWrtMWtyA6ZQT3LO?=
 =?us-ascii?Q?1Ddo+lah4qsbhzMPJJapSAYMpVxXGHLAcpF/AbE9KyJSmhvMr303CKhj3ium?=
 =?us-ascii?Q?H9ORYz/DftEqNIs1zGySt5ys8nz4i6M0U6y9TkZALdT9bDm+oTNABfGD+IBF?=
 =?us-ascii?Q?i4VhbbcSwRkHZU0zaq35LvpgUNY/JLKRmS9KwjBEH8d8Z8QnuwSS9mapiyur?=
 =?us-ascii?Q?f5fl4XCLoqZZKNAhfbykXRD/ulk16EL1bK8cwN66x0PgchX31IgqMgCuMSiY?=
 =?us-ascii?Q?vXz/PrSrrFbyOixAt2UWBTtZB9ddHPoPjYO9P5d4XoqLsFbDT7fkkp+iTkM3?=
 =?us-ascii?Q?gs4msLn2JTESfrS14jrZYZxr41muCeYYFqlglBVXIudU5hFzxfz/gWOrQ5PT?=
 =?us-ascii?Q?C93QWd21+h+lviD8CCsUVX1yiRPjidnrQwLqxNad+CBep6xlzSU96DPyYX7n?=
 =?us-ascii?Q?6r/ouw15VKgnrgdBzKV6tWQfwy1biguskxKR4W2vQivnOWQov/b5PDaBv33B?=
 =?us-ascii?Q?/6UQ3TmbELXMbcyBPyy/5Q/Bb3ICAXrntj4rfYCLlrmYqf398CMokcQ3+dvo?=
 =?us-ascii?Q?uCJYf0GcM7dZpsKnswOKE7G02DSeBomF52lJDPIaYTWO/gJk6fLDWkKC3lI2?=
 =?us-ascii?Q?I4Tb1d+kBQjPyXcr70sWIPGBzgPNbAS2LQxhMXpnpr9KpcZJYXs+jgB1Jz+g?=
 =?us-ascii?Q?WtqVaARotpe7Sorvy6r64J/a4OeC+3ruUxrHspGp/E97tRaqLBrF4VMowNxR?=
 =?us-ascii?Q?11ljOpm9lDdsFUSxkdfTtuO+lvT19yqoLc1HtCsoe/R8716B3RNdYESHMTeM?=
 =?us-ascii?Q?eltoqSRDC+b6TsEUiz1wmJ/zutCvcHQEHtO/lwlfxy9k71Cm1DDCU6napcpB?=
 =?us-ascii?Q?4JlWJUElMFxSxhdllG+7z0jsMfuJ2ACNczdgVQBa8R4HxvUzeAPXBHuD0Rmm?=
 =?us-ascii?Q?XH6RuSThehVbIgcGQReBAYCmQwFn5oAuy8mXXcg/V7AmiQy2hQbsRh2O7dik?=
 =?us-ascii?Q?XVxlM+uqjHTS3s5ZPAlmKqQphIFOuTMEHFPsE9UgJftDtM27Xy8TCG/CrwGe?=
 =?us-ascii?Q?nGbIEc2U4FsSkU10FDylnQYQlTy9Sa+QqXycCexRNl1Ua/7JYVn8bFmxjYBd?=
 =?us-ascii?Q?7h1yUUp+NMaM5i9B4lVUZw/PXbZ6/Jy0EV1fwL+cZP3t3x9+8M4YLApjBoe/?=
 =?us-ascii?Q?ZsBB8LXwltCli+U5arTmGh3DmgniAkIhpGvERkKZllyEX0v5AHvx2RVKHK2u?=
 =?us-ascii?Q?Klh1fFtIz5P2R1X/IhANHEYy6sZIWFPSOW7+cVZk/SBQNDISaLII02sGcxCN?=
 =?us-ascii?Q?RXMhCNOE7WWxEwuhb/4kQX5YKE/22PBliXx7sn5YbzCO+TFHXAnqkUEC4cUf?=
 =?us-ascii?Q?tsqCrx+hiJXcTaCXvfjHBNLzl9oywpzIcUd8HDRVdulm33CteigEtPyxhsq1?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	HfR41PFKv3pFuse5klcH37QBJ45XRjIDlrjNvB28atbzO1Dzq5H5/S3LqXESQMwJ2ShKf7lmzN5/lLHujFDbuH1OBM+fzebYqBQ0JV/H5hdjDFRMBKW8zMvUTkcI557jLeX8wqkogEsu0O8GYHpivRB88Kn1nvANMf4I7G2MyrNsk/LR3XAwG2ms11zDJ3OoADiznNFgi0PMY3UYOVwt6ptcreXydZbYhQlqQMDd+iCIiTyxHm8EMShunYFoMFAGsgtjr8LuaZIZHFlkNFNZc2/u2wiD4mzTaAHTpHEeSaoogJrSDN0QC+FrEyUhCiaPwkMmBD8QQ9ho2Y5Z+EwQAFzKjaGOUTlJ80hF+9DGbTafDugSptr6c3rnkUqL+c6/+MUsdxvGfBL+nhleZlplav/tFrFX383dE6/YKCVIzGi6L8+NT41ljG5QBy2QIOGEA6nLGc+Q3IsSM4sZI/Th2/yt920SNiD3jSFYeZN2XMRLIUPGEWS80XRxy8lRjun3n1GO7j/0GRLjyEuQgi/vJbK3yZEf/flITe1CAkEP7NfBdlpUFZL38fjNZ08cVgwTZi/VEh2Uc1Xn5Lj7Kaqpb6cMYHjjVJgKrkQvO/5WoJI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a941a476-0361-482f-f550-08dc2c587d55
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 05:56:15.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9TZVWkoLhsGLvVv3EHHg3MCRSaRikGInhDoJZk/7Y77b4E3TK+EzUJbgxWuXaolmtKkWpfMy2/9j/DSwBoq55sCdyL3a27GGBNr8BuJ9XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6906
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130043
X-Proofpoint-ORIG-GUID: pWfdXM9vxQe9m_RDSgPOOkT7fAqry-9v
X-Proofpoint-GUID: pWfdXM9vxQe9m_RDSgPOOkT7fAqry-9v

The combination of PREEMPT_RCU=n and (PREEMPT_AUTO=y, preempt=full)
works at cross purposes: the RCU read side critical sections disable
preemption, while preempt=full schedules eagerly to minimize
latency.

For now, warn if the user is switching to full preemption with
PREEMPT_RCU=n.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/lkml/842f589e-5ea3-4c2b-9376-d718c14fabf5@paulmck-laptop/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e5d631197f35..425e4f03e0af 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8922,6 +8922,10 @@ static void __sched_dynamic_update(int mode)
 		break;
 
 	case preempt_dynamic_full:
+		if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
+			pr_warn("%s: preempt=full is not recommended with CONFIG_PREEMPT_RCU=n",
+				PREEMPT_MODE);
+
 		preempt_dynamic_mode = preempt_dynamic_undefined;
 		break;
 	}
-- 
2.31.1


