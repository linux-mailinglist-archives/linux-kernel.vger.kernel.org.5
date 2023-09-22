Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE27AB316
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbjIVNwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjIVNwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:52:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D5E8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 06:52:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38MCxFXC025266;
        Fri, 22 Sep 2023 13:52:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=j7ExKY9MV29zilPvOP6Z4ntHQI0klF2Y2OWrMAMNvGA=;
 b=LhYYCWLuHk1oJh2fSmG9jlmG+1do3zRZBopnWGLBRlxjbAFIl/X8z6epm7CB1t9wezFK
 CLtOdm+ADNPKW73jDRhYxAY97VasAQhmRwKgH2xsEb+1d3LtVeLHTdG5hEa9RYSGmAk7
 K1E2R5D2uPFX4mOPHlSSe1S7fL+A1v4d88cA+qvrlmHq8dJM9v1bdNdHETqi+P3jeXac
 JLOG3l09764rDtWFuENMccOpwwDlsws+fj+9imft502fL+ibsMK4D/RAOr/gD/0PKT4x
 /4UC3D2FUkaAMCSiFoPN4xmYoKPNvae8pP93UV6sdEf9qQwKAonD4QsbSgd6CbKJ92r6 sA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsv1uep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 13:52:01 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38MDWu41016695;
        Fri, 22 Sep 2023 13:52:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t8u0v2hbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Sep 2023 13:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq7zWEvVac/nBbJCgANa6wTOeVMB0ZkqOzKh9nmj+0du+LyvJueEaWQi9pRipjmS7V9zOV6y7I4cIx0l5VW2b+evX593Gp4hOhZbiawzr1Z3yqljY7LSoZOzpZdLRxKR7n4FQzcYMSBbuOqGnBSQCkSMs1PIpoulk+MGfKS6CywFEH+438sznDrV8RC18w2P6kQH5xEzqQUOJiLy93vS0TNLDpuaVhINncMQUUyayz7nSJ6VZJjXvcMJ1i9tK/S9xcyEn8mXZ6ufMC5Q7eNQFsAbZR6LxHDAC/xd6gasN7Hn7PsUeaB8O7eo2npqBsvoug/yiEscIrGVEi+dBwNfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7ExKY9MV29zilPvOP6Z4ntHQI0klF2Y2OWrMAMNvGA=;
 b=E8gv+QdrYuUQ6HueHVwmMccOjhGKGWarpsSiRdWE9LbkAVvoOwi/kKMgN9l2gWycKXrXhBrQVZe/PftyYYtrBy4wQGJrvngZXji6o5K7GdZuaNIjGja60zlwYKvSSDJC/ywh+efRhty/BN4EooMm7WYmqu6i/DM2StQGMZwt9y9yVarVsQVw70mRtos6PyL3XIBGxr3FULHYUqL2vNSX9fqYMDaNJkleiW4hvPq3Pn98THlkdqHlfM2PUo+6651tb0YcX3vC+GoHib2KFzTOD3O6uv4feAMN3wKSyMO/SpsxhYeWBkvUaCqV/rVwDq/DhB7GjnhVlNpwWG2zp3VoCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7ExKY9MV29zilPvOP6Z4ntHQI0klF2Y2OWrMAMNvGA=;
 b=NlYFwQBcmW/sRSZrM7Sgf68tiiZwQwl0MRKExW/Q3DDFX43H9gYYemonAN9sgIIxBp/X5BrAlyk3EvFnIFYhKJb0t5xidMKvwYuD4GKP5j7/nysg07kIe48HzhvI3MTNz6VTKlgWkozkxNdZSAWzVfC5rn6y0oRd2WgjOdVsjJ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB7393.namprd10.prod.outlook.com (2603:10b6:610:146::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 13:51:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 13:51:57 +0000
Date:   Fri, 22 Sep 2023 09:51:55 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: maple_tree: KCSAN: data-race in mas_topiary_replace /
 mtree_range_walk
Message-ID: <20230922135155.tqrelea66hcj5cog@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9c1549f9-78c2-441b-8617-3ea3c080a5a4@alu.unizg.hr>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0201.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a30813-4d30-4ed6-0b97-08dbbb731649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9I1N9+TMzp0ZulG6yJxIUnXM7VdBP4IKkaL27Zl3L14BxriB8Zj34EyljBneQZeXZFLV2qWXwWraMgZCBEKMbsYrYkLkesWy0TOr0uBJsUqpN3d/XnzzIZTsnqXoR72TcKoYv+/vw6XMFj0KCG5fpHf4rG1i7dePxD+GqO1u+f8VoPBR6znTqdekv/ww1MDWyk2HF5w93pe9nJmHXbZYmdYT/uUq8qwMhghSe7ABGGwSOBPO+4CG2PUhUAlEiYU8uOg6qW7qqq8HxzpUiVHomVBkZmjyVkIJS0yfH3NAeTIElXNZuxtTq7c685K7OgEinPYGs5qnSXE46t4GDBF/VCIWceeeFC4vk66fn3vMjkiqGVIA7WOkVV+q7Y2ctrSk0TgJJLxZr74pcOtMQaj37ZgzuU+hfI8RdhA20xFwEy4TGgoJ6KYi3ut/0/XEctwI+5hNeovNC6Nst3cBSSXfGmRc+AINBZqDtvQo7klhC1DdzXB7Tr9GmF+gG1hXtNi7kL5wZTMWbH7UcwNd4JKWlSAyM4Hxibg8+B7p1dFBwo/6SQsR5t9FzS2XudfjTfYe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199024)(186009)(1800799009)(38100700002)(86362001)(6916009)(478600001)(316002)(41300700001)(4326008)(8676002)(8936002)(30864003)(26005)(45080400002)(1076003)(2906002)(5660300002)(83380400001)(6506007)(9686003)(33716001)(6486002)(66946007)(66476007)(66556008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzEvSWRneDNSVVZRM0RCTWdiNDB4QTNvYUE5RUJKc3FDLzN4YTEyd2k5NFVp?=
 =?utf-8?B?cG5yT2RBMEpDMG9DR2dNSFpjbkdaa2ZUSjFHUGJlVHl1b1VnSzhJOS91MDZa?=
 =?utf-8?B?MkxWNVFGQmhSWUNyS3J3ekx1SE1zSWJ4bDNPTEpHZmFKTmpVT0E0QVBFVXh6?=
 =?utf-8?B?em9XMWh3Rk9QZU1qK1gyQVRSbWhwcC9vWDI3TnB3NVMzb3RjQ21HWVlhU2Mw?=
 =?utf-8?B?MVFvSVJKbW9lNFZJS3dUSmhxWlJGSWpKbSs2N0J4OVBYa254djhhLzhoSysy?=
 =?utf-8?B?VGQyU2JkZXZuQ08vbkhiVEpzSE5neGQvNUtLL3VaM2E3SXpOQ1diVFpZNktG?=
 =?utf-8?B?Q3hNRVU4T1ZqdyszMTdPRnl6YW41aXFsbExjbVI5TGY1VXZNNksvSUFXMWZ0?=
 =?utf-8?B?RStZcmZRRjBCUXR5amxTYW5RK1Q4ZkRGUDZTamRWOVV4MWRGZzFRMVZOalNO?=
 =?utf-8?B?cFk3dW9mZUo3ZVlCNjRMSFQzVFphZkFObjhTcEY2VCtiMC9vMU4zSjVyOUUx?=
 =?utf-8?B?b2M4TjEyd0UrblZCMFIyUjRhcjZvdnFCYU13R3RScDh3ZEJXOWtxR1dEOENr?=
 =?utf-8?B?bXFSMHB3MjJIZkE0SDROUjJrekdualV5TlhtSlVpTDNhNlowQ2JyZzNTOW5U?=
 =?utf-8?B?MHpkWVdxT1hvcDVrWDRoVkFFaG10Wk9jSGcvdnJlZ0NWMTZjb212Z21oNGVS?=
 =?utf-8?B?STZXZU9kN1J0QStIU1BWMjJYdWxLLzgyWnVoZXhkdWM0MEpCYThtbTYyTzBr?=
 =?utf-8?B?OHZSTXZQczFIV3JwY1pIREdvM3BFTnFFdnlKaENjQUFBZlVzcU1RMmxadmVV?=
 =?utf-8?B?ZjZVNi82UVpUa1c4ZGtBSjJVQzFURHVUUzRiT2NuU0VsTjc3K0JPd3RxNW96?=
 =?utf-8?B?N1FOZndGYmxtY2w1WkgyU0tYY1l3aVROdlJNUWhKdEl0S3RoV0NMSzF1c2lj?=
 =?utf-8?B?dUhzbzdGQVAwdHNqYUQzMUNHYTlDUkE2d0dvcHgrcElGcWFMdjZrYkdFb05x?=
 =?utf-8?B?Vk1MaldhelVFT3FhOExPc0Z0dFhldnJ0emhNWDVwNHpHUWIxRmpmcCtuY3Fu?=
 =?utf-8?B?b0tOMXlwU0lIV1FSVWYwT21KTFk3ZHZMczUwYU44bXY1R0FPT1RTSzl0MjRi?=
 =?utf-8?B?eE4vNUdnazhocTh4Y2NlOXJQVnN3c2d5UEJNWkk5OUdsNG16WTlhTG4yNm4v?=
 =?utf-8?B?TzJpd0M2Mnp1NnN4RWZ2U1dvcFVNbGJUems5Si85NXNDMnJBQWl3NGE0UzNV?=
 =?utf-8?B?MVVYbHkvdXVpMkdGVHMrS2Y3ank0RmZValpHNGRucnM3cnAzRzNGeFYwRVBu?=
 =?utf-8?B?Rmo1MStCUUVkSVcyTHRxenZYR3R4NE16OTMwNUJ3eDgvaWxmUXdBSWJrM3lN?=
 =?utf-8?B?UHpEMnk4UTBmZDQzc3E0K2NSeWVvbGNOUkJkbUZPZ2duTW15eGZsOWJUbGVW?=
 =?utf-8?B?YkZ0RHR2bWNtd29jeDc5RkM0ZW5VSk9OMmxCeFlvU1BxeHFSR3NDU2lMM3Q2?=
 =?utf-8?B?NnVYQ2V4UDQvenlzSkxLS3JuZ1VLc2hlOWw2M0l0WG1WakVnakhhbXEzQlVs?=
 =?utf-8?B?eXpJSEl6dUdrK2JRdjI4ZExDYkZIZkZTYURSZFJSM1dGRTV1cmdTZ0l1dkUz?=
 =?utf-8?B?QVJaQzF3d1ZWNWJzM01MRFVlZWhwcGNVa2d4MFpWVzBDMm1sWEd1YmttSXFa?=
 =?utf-8?B?NmlZMWlzaHIzd2Qvall2SjQwWU8yWUpuS2dBYy9KeFBJeGhrS0dOLy9UU2Ri?=
 =?utf-8?B?RUlZMndvaUJnelUwVC94WER6SFlXZmVFM2M0MUgwcGhoQTE1R0FRS0tkaTRv?=
 =?utf-8?B?QnpQeHFmVUxHWnVzMFIvQ2lIem5HNjFoeWtiTzQ4eTV4VElBZlhwZ1hCLzhz?=
 =?utf-8?B?T0xMRlFwU1BoMnFwbkdLQmMrM1ZWcm15Z29TK2prZXRRbVBRRTZwQmFOVmRB?=
 =?utf-8?B?M3ZZaTliODRVUGVtR2gwcGdsV0hhWlJmRHE4ZERDR3I5dkI3T2tpZm9qOS9i?=
 =?utf-8?B?R2xlaTdPRW5mSGtJbzFTOTFMOE5KSEE5R0ZTdVlnRVRaVVhRTTV6dnNVaWJ0?=
 =?utf-8?B?MXFaTkV4czQ4U3h3S1doMjVkdGtwL0FxQTJ1dEV5SmRycWI2TFE5TUY3R2FL?=
 =?utf-8?Q?hrWowIE2quNLK2dx4NTGgVrk9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fBfDuHRH3S8vp/LF+E22jyquPax5k9P4icdtOhJgrBOagxABC57lRHg+PVDKBr8o5QHN69iQklomUWrLX+Nd4+Q2Z6wMa11fudKq3y0xuqfVP+NiI/5skzbpANQd+B1pZ/DrE92fJ1nOYTm1BYmAv2dtFXkRruK0sEH8TLgHoUXEOcC3ybbpDvQCp7TxrMM73d9WQ1COJdDey/bQp5Av2sYwwZqqYybYyzLYPOlEZO1cFwLb4z76/V6go9JAi9jMT1o24emtz9wTWhSk0V0YfSNluo+G2V8R0iY17EQQxqDh0fUYZytdnFu5/d9FP/Ima/3Y0mm2J/7eAH+fqrxfzjfjutCfNAX408cweFDTERBRG9DmCQ4Toke5YNWyZm8TG2Q1dQf7E1Jl2kkSqVbM+tIc7+MZhRLUisLIzg8Y0GQ/1+/ug17n312oxwvgVgQN/w91Q93QL/YhXvYIEQWQ/9KKRSTX3RD/1F3xyi3qG6I2xDWXyahFeRcE2ISpKA0ZrGJLHldgdAYwl1N1y1HV10eKEOS6D9jOoEx37ENNPJBFe8Ex+p3m8nqrKCpr+9S+n3Vr0Db8vJqla4Gzl9ghQLISbZg7bjn93FBX5u79B9x7pEuq5tkv9v58cQqJ0EfeBRBRuCmTC8L2jJwswmtfUumXyVGjS9AcbFdowOToUJturM9L2WRwrB9SgxY/Jffg4gZ/xrGEBaa0c/QEgns+xQEwHagfgnpKtsn7jwjMv5zjmBb+JGRYUwXw1GmqAgG/efEv8ClLW3OROimgX2ABZ4Cq1gEqLezXsgfymyiEwGXguKpps83l9cFXMDRJlLoY5L+oa9Jjo7Gmpl23WZdouucSGxuAH7TvQkzvqiqUsXIAZq0qwtYER2keeco3VH5N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a30813-4d30-4ed6-0b97-08dbbb731649
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 13:51:57.3977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EVhQS19lHMFyYw0Jh+DUR8KJl1iX2LH7qKj3Z6ie90fIxkXgwY3zedcKmaByvaFT4naotSBPh/AOSD/al3erg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_12,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=757
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309220118
X-Proofpoint-ORIG-GUID: YeolXn1Va6j9ArGUb0GoBWZomGz5wBv5
X-Proofpoint-GUID: YeolXn1Va6j9ArGUb0GoBWZomGz5wBv5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr> [230921 17:01]:
> Hi,
>=20

Hello!

> On the 6.6-rc2 vanilla torvalds tree kernel, KCSAN had reported a number =
of data-races:
>=20
> [ 6413.367326] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ 6413.367349] BUG: KCSAN: data-race in mas_topiary_replace / mtree_range=
_walk
>=20
> [ 6413.367375] write to 0xffff8883a0c5db00 of 8 bytes by task 5475 on cpu=
 24:
> [ 6413.367386] mas_topiary_replace (/home/marvin/linux/kernel/torvalds2/l=
ib/maple_tree.c:491 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:17=
01 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2590)
> [ 6413.367399] mas_spanning_rebalance.isra.0 (/home/marvin/linux/kernel/t=
orvalds2/lib/maple_tree.c:2664 /home/marvin/linux/kernel/torvalds2/lib/mapl=
e_tree.c:2961)
> [ 6413.367413] mas_wr_spanning_store.isra.0 (/home/marvin/linux/kernel/to=
rvalds2/lib/maple_tree.c:3894)
> [ 6413.367428] mas_wr_store_entry.isra.0 (/home/marvin/linux/kernel/torva=
lds2/lib/maple_tree.c:4242)
> [ 6413.367442] mas_store_prealloc (/home/marvin/linux/kernel/torvalds2/li=
b/maple_tree.c:256 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:540=
8)
> [ 6413.367455] vma_merge (/home/marvin/linux/kernel/torvalds2/mm/internal=
.h:1127 /home/marvin/linux/kernel/torvalds2/mm/mmap.c:1005)
> [ 6413.367466] mprotect_fixup (/home/marvin/linux/kernel/torvalds2/mm/mpr=
otect.c:632)
> [ 6413.367480] do_mprotect_pkey (/home/marvin/linux/kernel/torvalds2/mm/m=
protect.c:819)
> [ 6413.367494] __x64_sys_mprotect (/home/marvin/linux/kernel/torvalds2/mm=
/mprotect.c:837)
> [ 6413.367503] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x8=
6/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/comm=
on.c:80)
> [ 6413.367517] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/=
torvalds2/arch/x86/entry/entry_64.S:120)
>=20
> [ 6413.367534] read to 0xffff8883a0c5db00 of 8 bytes by task 5558 on cpu =
11:
> [ 6413.367545] mtree_range_walk (/home/marvin/linux/kernel/torvalds2/lib/=
maple_tree.c:539 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:2789)
> [ 6413.367556] mas_walk (/home/marvin/linux/kernel/torvalds2/lib/maple_tr=
ee.c:251 /home/marvin/linux/kernel/torvalds2/lib/maple_tree.c:4844)
> [ 6413.367567] lock_vma_under_rcu (/home/marvin/linux/kernel/torvalds2/mm=
/memory.c:5436)
> [ 6413.367579] do_user_addr_fault (/home/marvin/linux/kernel/torvalds2/ar=
ch/x86/mm/fault.c:1357)
> [ 6413.367593] exc_page_fault (/home/marvin/linux/kernel/torvalds2/./arch=
/x86/include/asm/paravirt.h:695 /home/marvin/linux/kernel/torvalds2/arch/x8=
6/mm/fault.c:1513 /home/marvin/linux/kernel/torvalds2/arch/x86/mm/fault.c:1=
561)
> [ 6413.367602] asm_exc_page_fault (/home/marvin/linux/kernel/torvalds2/./=
arch/x86/include/asm/idtentry.h:570)
>=20
> [ 6413.367617] value changed: 0xffff888341d43116 -> 0xffff888340f92116
>=20
> [ 6413.367632] Reported by Kernel Concurrency Sanitizer on:
> [ 6413.367640] CPU: 11 PID: 5558 Comm: ThreadPoolForeg Tainted: G        =
     L     6.6.0-rc2-kcsan-00143-gb5cbe7c00aa0 #41
> [ 6413.367653] Hardware name: ASRock X670E PG Lightning/X670E PG Lightnin=
g, BIOS 1.21 04/26/2023
> [ 6413.367660] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> For your convenience, took the trouble of finding those suspicious lines =
of code:
>=20
> The write side:
>=20
> lib/maple_tree.c:491
> --------------------
>   456 /*
>   457  * mas_set_parent() - Set the parent node and encode the slot
>   458  * @enode: The encoded maple node.
>   459  * @parent: The encoded maple node that is the parent of @enode.
>   460  * @slot: The slot that @enode resides in @parent.
>   461  *
>   462  * Slot number is encoded in the enode->parent bit 3-6 or 2-6, depe=
nding on the
>   463  * parent type.
>   464  */
>   465 static inline
>   466 void mas_set_parent(struct ma_state *mas, struct maple_enode *enode=
,
>   467                     const struct maple_enode *parent, unsigned char=
 slot)
>   468 {
>   469         unsigned long val =3D (unsigned long)parent;
>   470         unsigned long shift;
>   471         unsigned long type;
>   472         enum maple_type p_type =3D mte_node_type(parent);
>   473
>   474         MAS_BUG_ON(mas, p_type =3D=3D maple_dense);
>   475         MAS_BUG_ON(mas, p_type =3D=3D maple_leaf_64);
>   476
>   477         switch (p_type) {
>   478         case maple_range_64:
>   479         case maple_arange_64:
>   480                 shift =3D MAPLE_PARENT_SLOT_SHIFT;
>   481                 type =3D MAPLE_PARENT_RANGE64;
>   482                 break;
>   483         default:
>   484         case maple_dense:
>   485         case maple_leaf_64:
>   486                 shift =3D type =3D 0;
>   487                 break;
>   488         }
>   489
>   490         val &=3D ~MAPLE_NODE_MASK; /* Clear all node metadata in pa=
rent */
> =E2=86=92 491         val |=3D (slot << shift) | type;
>   492         mte_to_node(enode)->parent =3D ma_parent_ptr(val);
>   493 }
>=20
> lib/maple_tree.c:1701
> ---------------------
>   1682 /*
>   1683  * mas_adopt_children() - Set the parent pointer of all nodes in @=
parent to
>   1684  * @parent with the slot encoded.
>   1685  * @mas - the maple state (for the tree)
>   1686  * @parent - the maple encoded node containing the children.
>   1687  */
>   1688 static inline void mas_adopt_children(struct ma_state *mas,
>   1689                 struct maple_enode *parent)
>   1690 {
>   1691         enum maple_type type =3D mte_node_type(parent);
>   1692         struct maple_node *node =3D mte_to_node(parent);
>   1693         void __rcu **slots =3D ma_slots(node, type);
>   1694         unsigned long *pivots =3D ma_pivots(node, type);
>   1695         struct maple_enode *child;
>   1696         unsigned char offset;
>   1697
>   1698         offset =3D ma_data_end(node, type, pivots, mas->max);
>   1699         do {
>   1700                 child =3D mas_slot_locked(mas, slots, offset);
> =E2=86=92 1701                 mas_set_parent(mas, child, parent, offset)=
;
>   1702         } while (offset--);
>   1703 }
>=20
>   2562 static inline void mas_topiary_replace(struct ma_state *mas,
>   2563                 struct maple_enode *old_enode)
>   2564 {
>   2565         struct ma_state tmp[3], tmp_next[3];
>   2566         MA_TOPIARY(subtrees, mas->tree);
>   2567         bool in_rcu;
>   2568         int i, n;
>   2569
>   2570         /* Place data in tree & then mark node as old */
>   2571         mas_put_in_tree(mas, old_enode);
>   2572
>   2573         /* Update the parent pointers in the tree */
>   2574         tmp[0] =3D *mas;
>   2575         tmp[0].offset =3D 0;
>   2576         tmp[1].node =3D MAS_NONE;
>   2577         tmp[2].node =3D MAS_NONE;
>   2578         while (!mte_is_leaf(tmp[0].node)) {
>   2579                 n =3D 0;
>   2580                 for (i =3D 0; i < 3; i++) {
>   2581                         if (mas_is_none(&tmp[i]))
>   2582                                 continue;
>   2583
>   2584                         while (n < 3) {
>   2585                                 if (!mas_find_child(&tmp[i], &tmp_=
next[n]))
>   2586                                         break;
>   2587                                 n++;
>   2588                         }
>   2589
> =E2=86=92 2590                        mas_adopt_children(&tmp[i], tmp[i].=
node);
>   2591                 }
>   2592
>   2593                 if (MAS_WARN_ON(mas, n =3D=3D 0))
>   2594                         break;
>   2595
>   2596                 while (n < 3)
>   2597                         tmp_next[n++].node =3D MAS_NONE;
>   2598
>   2599                 for (i =3D 0; i < 3; i++)
>   2600                         tmp[i] =3D tmp_next[i];
>   2601         }
>   2602
>   2603         /* Collect the old nodes that need to be discarded */
>   2604         if (mte_is_leaf(old_enode))
>   2605                 return mas_free(mas, old_enode);
>   2606
>   2607         tmp[0] =3D *mas;
>   2608         tmp[0].offset =3D 0;
>   2609         tmp[0].node =3D old_enode;
>   2610         tmp[1].node =3D MAS_NONE;
>   2611         tmp[2].node =3D MAS_NONE;
>   2612         in_rcu =3D mt_in_rcu(mas->tree);
>   2613         do {
>   2614                 n =3D 0;
>   2615                 for (i =3D 0; i < 3; i++) {
>   2616                         if (mas_is_none(&tmp[i]))
>   2617                                 continue;
>=20
> The read side:
>=20
>    527 /*
>    528  * ma_dead_node() - check if the @enode is dead.
>    529  * @enode: The encoded maple node
>    530  *
>    531  * Return: true if dead, false otherwise.
>    532  */
>    533 static inline bool ma_dead_node(const struct maple_node *node)
>    534 {
>    535         struct maple_node *parent;
>    536
>    537         /* Do not reorder reads from the node prior to the parent =
check */
>    538         smp_rmb();
> =E2=86=92  539         parent =3D (void *)((unsigned long) node->parent &=
 ~MAPLE_NODE_MASK);
>    540         return (parent =3D=3D node);
>    541 }
>=20
>   2767 static inline void *mtree_range_walk(struct ma_state *mas)
>   2768 {
>   2769         unsigned long *pivots;
>   2770         unsigned char offset;
>   2771         struct maple_node *node;
>   2772         struct maple_enode *next, *last;
>   2773         enum maple_type type;
>   2774         void __rcu **slots;
>   2775         unsigned char end;
>   2776         unsigned long max, min;
>   2777         unsigned long prev_max, prev_min;
>   2778
>   2779         next =3D mas->node;
>   2780         min =3D mas->min;
>   2781         max =3D mas->max;
>   2782         do {
>   2783                 offset =3D 0;
>   2784                 last =3D next;
>   2785                 node =3D mte_to_node(next);
>   2786                 type =3D mte_node_type(next);
>   2787                 pivots =3D ma_pivots(node, type);
>   2788                 end =3D ma_data_end(node, type, pivots, max);
> =E2=86=92 2789                 if (unlikely(ma_dead_node(node)))
>   2790                         goto dead_node;
>   2791
>   2792                 if (pivots[offset] >=3D mas->index) {
>   2793                         prev_max =3D max;
>   2794                         prev_min =3D min;
>   2795                         max =3D pivots[offset];
>   2796                         goto next;
>   2797                 }
>   2798
>   2799                 do {
>   2800                         offset++;
>   2801                 } while ((offset < end) && (pivots[offset] < mas->=
index));
>=20
> As it is evident, ma_dead_node() expands to:
>=20
>    527 /*
>    528  * ma_dead_node() - check if the @enode is dead.
>    529  * @enode: The encoded maple node
>    530  *
>    531  * Return: true if dead, false otherwise.
>    532  */
>    533 static inline bool ma_dead_node(const struct maple_node *node)
>    534 {
>    535         struct maple_node *parent;
>    536
>    537         /* Do not reorder reads from the node prior to the parent =
check */
>    538         smp_rmb();
> =E2=86=92  539         parent =3D (void *)((unsigned long) node->parent &=
 ~MAPLE_NODE_MASK);
>    540         return (parent =3D=3D node);
>    541 }
>=20
> as above, but the smb_rmb() protection is here, so the KCSAN warning shou=
ld be double-checked for
> validity.
>=20
> But I do not really understand maple trees to their depth, I am only repo=
rting the symptomatic
> outlook of the reported data-race.

This is the most complex part of the maple tree, and unique to the
ability to store a range over multiple existing entries.  I recently
rewrote this particular section to avoid a potential live-lock issue.

I am confident that the parent pointer will not be set to the node
pointer as checked by ma_dead_node().  But in an abundance of caution
and to resolve this potential false-positive, I am looking at this in
more detail.

This race is to see if the walk down the tree into unchanged data will
be seen before it is placed in the new subtree with its data also
unchanged.  Since we know the parent can never be the node, I feel this
is safe - but I'm not willing to live with the complaints from kasan.

>=20
> This is all-in-all a very interested subject, and I wish there was a way =
to just slurp all those
> interesting kernel intrinsics into the brain, but it just ain't that easy=
. Forgive me for being
> open ...

I appreciate that and your detailed analysis with code pointers of where
this happens.  Is this easy to recreate?  If so, how?  Can you attach
your kernel config?

Thanks,
Liam
