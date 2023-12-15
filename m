Return-Path: <linux-kernel+bounces-716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEF2814505
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11827B22702
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CAA18C09;
	Fri, 15 Dec 2023 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W+MngA5O";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nCk2OS17"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E3518B1D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF9iWSh027668;
	Fri, 15 Dec 2023 10:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qsgOW1Pz9y18IAgaDsJ1Az126pxtTUEAV3mie3sa4zM=;
 b=W+MngA5Oh4hvYh6EQqGtjiXxGEX3GAYZNsU8YDaR+jpPx5LP/hrIWOxj44Fywy4NZ6C6
 rSeNm4KwqryJxo60XHfYzxOuSHctDAnKAMRC+PauV2SOL+Fk/HT+IzwjdzQoOvjCTOg6
 0ApwUwDX9ugzyi+A2/EPJ5ysMfrawODDB+B/P9eN3Xs6cGWNGJTaY0cEWQxWMXKh/Oxu
 485g3hmHTa/SFC2IwYGLKG3UN4DEAIRXEaOwSmQYXvlCRj+yuH0vX3sb9o+x7CEVqOtg
 X8BWZb+IMsnIgGo/F0HgA+nibWgvCfzu6dzjnUDpV6DRot7gYRdv3TBgkMnNS3oKYbdE 3A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ux5df9mqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 10:00:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BF9Mson018681;
	Fri, 15 Dec 2023 10:00:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepbpa0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 10:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmH44mdbQvDtuNH2pCG+W07b1ORyb5f2T1Xn3x04puCnRFpykChGjfsVIcUVaPmHA4/u1vJ7GkdJtUznFWASFBDCuZsKYnceb/6V+ZiyJfISVjE3g2FM56q42XqXgRh1tPj/mw9BiRL7gDwclGvRPJLyNa/hle50dflN75ELuUWKD9q9BbbPgOfKmKY7dDSfRDMLKZcvBZ4n+Ma+3UI6jwFNQnVmYdvhZSw8JIvJL7fA5i+BCKIBo2EUOojwNryJZFApgJ/09dYVRKA6S9y3QFAM/u+Mun6VqV8b3NPdh/Siw5uUcVJrxTuVVLvyLoyu2vRZTx/kqOBqxfs55tinuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsgOW1Pz9y18IAgaDsJ1Az126pxtTUEAV3mie3sa4zM=;
 b=kh0pUPmbe23hng3TFFoCLI0zPz5m0a55vf5wJ6hIpJWWyMAuKI88oFwlpMwqxaHCYIyhQMue9UKKwvS8oy5eFtKrQ4GD1NzHxnvDgTOubP63TC7rJK1m03U65ZzSZBTgkJZrLN9Scqb4GneNSdwoNlldcG6ptSN3QOIa5ovlI7WjXbnvyrLH+Qu5Me+pV7u78LFmy2MYgbTH6jlN0hwgyjVXQEFrDluHbsjex7dzPzMGvIp0QtxXR59Y0U28aGccpMSqz+Kp3dbkeBipbgeT1uHYS/XSlHI49khwoytZieieENGoso4hVBKZo/z55BGyP6FBMdqWPayqjrvOCGFZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsgOW1Pz9y18IAgaDsJ1Az126pxtTUEAV3mie3sa4zM=;
 b=nCk2OS179jdx829+mJSx6JQd5j1rBOzBWv82NdvDkuOBNvx3LpK4y9N6UsHTsRPhGkbI8kwUodUT01M+oV5/hvvUznbZT57oEIaBUVn6wD8bWhcMqeeSK47ffc8WWsQ/0N17XywyUeZVKWfHJwpyN2g3CS8zqYVikItpr3Sijow=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM6PR10MB4252.namprd10.prod.outlook.com (2603:10b6:5:215::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 10:00:00 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::5a0:6591:b3e7:75fc%6]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 09:59:59 +0000
Message-ID: <d8507f86-2458-4b01-a774-5102473e657e@oracle.com>
Date: Fri, 15 Dec 2023 19:59:52 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: fair: reset task_group.load_avg when there are
 no running tasks.
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
References: <20231215052652.917741-1-imran.f.khan@oracle.com>
 <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
Content-Language: en-US
From: Imran Khan <imran.f.khan@oracle.com>
In-Reply-To: <CAKfTPtD85OSem=7RMquLWokVp7gffvDaY3mtwevkxp1mSSVVqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|DM6PR10MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6c8805-c93c-4ca6-c614-08dbfd54995e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BzQ06QY2hlJ1ubpr99+EbuAWee0qC9TgUDhxSzrLzekOrYHEroWxJ8Ombp+mFuqjrfS6hie9dGQ7BxMDjRrllm/b+onog+3FdenWngvteV99m2GXrwdJx1feIUEOXRj6szFA/5JZd/8FXyf40QZAmZeUQRfS8ougyN0HhjdQg/ouPhvj+zM6VWMP0FNY6pxWfRFYGGF1HGwwvslI+2F/NY2WeH4CNCZjPooAibATX8uqWEEIZgcUM4VIP0IVPrPqJRa3FnMZkb9Qf94p3xapLDOMSOBqsyMPkKr8qBmfuen64sJEW69PXl8G57SxYHXPFIsZpk+Ww03zj+Quh+DlKxEHx1OmoKEHGf7oyb3ZzYJQQP1sZg1HeheQ6BaG04DYhG9NTwc7eB7EQwQIMq5WCUJSw07CKRbH759067tHNHwKnrPFRYG/QI5NumDY+Ftu6udos395qpcsl0rAvBFyXwAm+yZtZRB20s/nKMchnFGD+qNZbdNlp9Xx7CBG9lm0+/F3UMTEp1Mfz5CvayNBve4EpcGFCNw4UpL2m3m7BMq6/mCw93wdSOtgeUt/B6HSAVq4eFAKx3FJ2V8P8AO35+AARGlAml5XfFWUoNuqcfCscy6BcWlLA8FlSY6vBf/Kim/tW89lvd+8RahryoDR0w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(6506007)(6666004)(53546011)(6512007)(83380400001)(5660300002)(7416002)(4326008)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(66946007)(316002)(6916009)(66476007)(66556008)(36756003)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEtWdGlMZjFGWHk4THV4dmQvQ3pVZU8veFYwYTB4YXhuWWljQ0paangwZ0Vx?=
 =?utf-8?B?VStMajRtYUQrMUhmZmpPZDhQSzZhcE5UVTBrWS8yRkgrTWRzOTFJUDZSM0RB?=
 =?utf-8?B?d2NvWUUxNHFRdmFyLzk0SUVvSUZiYXdkRDd1MFRUbTdSNkdlMnA3TzFkYkpC?=
 =?utf-8?B?RTQvY2NnYWR5dG5IaTRmdHNtUzlpT0l2aUk4RW03MVZyU2kzVlJrOENydm1J?=
 =?utf-8?B?cG5NSVhpSXgydmlwa29uVUh4bitnNHlUeEY5MTBqWjA3NmpNT0Jmc1g3QVNm?=
 =?utf-8?B?MGxyT1h6eHZwYWlsdjM2amVFa3RxMjc2NGhoWTVwbGdRaWhaeU5HSzBFbTZi?=
 =?utf-8?B?OXdjZ0s4a1lNbGFzWXRpUVFka3ZsWk5tYk9WQ1piaVZsMXd2cExwcy9US0Ra?=
 =?utf-8?B?eTFTUFg3dW51bG5XbWxlaUppQW13NE1ybkh1bVFNeThhcGgva2dodkZXOXYx?=
 =?utf-8?B?UjVVd0JkblBoejJUakp4cWtrZUtGRklUbitvb0diM0VTYkxyNXNFQ3RJVmtz?=
 =?utf-8?B?UGQrdzNKM2Q2MXJ5ZkxmN1FUbTBTVzkrMjQ3ZHovNmNiczVNOUgwZW9KQWtw?=
 =?utf-8?B?N2pESVhXUWh4TktZcTRzQVk3VXptSVBrODJ4bHBoRmVybnMxVVEyRnI2YWhR?=
 =?utf-8?B?U3BkYzV4UVVJQWt2WjBzQnhtaUVzRzFqOXhHYVZEWml0MExacCt0WENneE5C?=
 =?utf-8?B?T2Y4bGxURFFleGZaSFdQbmJhanc0K1I2MnBRMnlwMlRuZGJEWDZKMDB4UzZz?=
 =?utf-8?B?RHk1SkluTG92SERsNjFyei9kWjRERitzSlprKy9uMUJ6bWRZenozLzlXWUkv?=
 =?utf-8?B?bDRxUjYxWWM4K3pEZG5pdG9pWmZGWG1HaW5xazh0UHFsem1BRjRiYnNyeFJD?=
 =?utf-8?B?bFNybXM1cU4wZmRvb3hiZlpUYXNqS05DamdkUDR3N0xrb0FHU1d4bXVPdkpo?=
 =?utf-8?B?YkEzTkg1WVJkVnp4NE1NSGl3YzVDM3NQdnNZcnJrTGZJdzN6bERlNVJWMTlq?=
 =?utf-8?B?ejk4L0JxdWxLVzdJNHRiVXJGaXRKOHZmckhJbVZMa0xGU0dMMUNmTjdWMTVy?=
 =?utf-8?B?eXRiNFVhdmEwViswak9OVUZJSHpuaENEdGJxMDRTS1ZHVm9XbHF4bzQ1aHRW?=
 =?utf-8?B?K2NvcWxRVmpUVXpWQk9SUnBCVkk4R0FDb01MemNrQm5ZSlJtYWRaOElzWjlj?=
 =?utf-8?B?QmZmOUsycllOdXZQSDdPLzFhbm1WYkhQdUFLU1FHZGYxeDd2cmx5NDIrWGND?=
 =?utf-8?B?R0oxb25aVGtBZGVwSUl5MDMvQmJBSDQrRFU2Uys3ME1vQlREb0MrOEpPMllC?=
 =?utf-8?B?QWlKbUQyUDRNMnlhNXBrWEVzMzNFaitDaTZuRU1nb2VSZ2NlZzNpUkZETVV4?=
 =?utf-8?B?SjB5VTZ4NDFycXA5L3gzaTQ5VmVMWjJoMUwxNVlweUNMT3hwMXpQUllwcXZZ?=
 =?utf-8?B?cUJOanpGQWYybmE3WWN5ekEyVGtuWDRDL3BEWEp5ek5xSEtBeE1lYWhSU1JR?=
 =?utf-8?B?ZVh5SXdYL3hRWnlWM09LM1IyWXFqcEIwV1ZHM1N6bGk0dDgyNW1UNDBVTy8v?=
 =?utf-8?B?WEVDeWZmdnBsVHdSOGFzc05MbUdNcXBSNVh1M3FublpoWFBscmIxTTVXbEVR?=
 =?utf-8?B?V2JmUGo3bXRSNVRERjVkc2FqZFFUSStZYkhNdVVSRk9YOU9xOVozNkNrRk1q?=
 =?utf-8?B?REZ5QzE2eGYwTnpzcHkwZzNNTER2Z3ZyQm1lSE1ZclZheVdOaC9LZTNmcVE2?=
 =?utf-8?B?Q2pET0NFcmkwNmI5b1QzdzBnbDZDTUNQMGlHTDZpOEE2Z2lEOFV5ZjNwa1o2?=
 =?utf-8?B?MTFyM0FKUUp1R3dpbXpCQk0xeW9LVUZyQVN6amhxWk4yZmpyTkhNT21sYk1p?=
 =?utf-8?B?SjRpZ2FwTHd4S2dMMkJoUUhIdkdEWFRtc3FjeHBqYzNQQkRNM1RYRHNYMWpl?=
 =?utf-8?B?bVJVdXFVSXE0L1IyOWluS1kwL3phQXFZWktubEp3dG9hdmRiV0ZQMUl4U25o?=
 =?utf-8?B?azBpR1Jxenl5dURKbHN1emZ2a2ZONXF1Z3lYa1ptRFhPemVOcE1yeEk3eTNx?=
 =?utf-8?B?c0Q3d21WdzZHaHQ4Mm9tNW93b3IzY1VMVDZFNzVsL3RDazNMYUJ4QjlOVyt6?=
 =?utf-8?Q?2sEGkjzfQKvZCowVcX+BMlQ50?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cB5hq1pi5/TwWYr/GN7I6MDASFnGCcqDdz/b7Kp1cigq5t+XUTLhIiXpHBRB4FG9pzZkV8z+ed9G02vL3ZRb8lkFokL4bqYBQIZ0pdHxIH2YCdSvXgQZxPL3Eh2mV27q9coCdBuDB3EhJA8ipufGXMT4GE5yfjEOTm1Bo+ZH1EnUWfY8s0tsBPCyc6Jm+/ABEOkpXbEOIk5GyZl68byBXtRGhdLZibnLV/hWblPOaLhKOlsQfc0RWy0o85J1oiaIg4flXnGjsWKnj31YBK6kiDfot31+XqYhET9Zd9F2T+xp+OCY66FoAdQI3LmC/sM6hGHkO3I3Ztg+wixlLEdeVGeTGcM17l9LIGgdEBV1LnxwrzJXR9M/lr5VS4PmjDWb8/StC4r6dkt77VIS2aFQMe/CFSe8eR/OfRuF2Ap9KIx+Ukp5qRTQoJ2zFtHl6/LRDo48IjvK+as1LVzrq3KkYncii/n2++27ocSlYOj+iCgIMnct47AbEZRu62nYBYVcV4/Gqz7q+Z8n2ipYmFttPwLWtU+p9LQ6TcZGFHxpJ2VSCILtNN/DcXfH7R/ZpijjM1vU6ZouKmxMEEwBVFken5wAojgrYkDPgmRv2eucX8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6c8805-c93c-4ca6-c614-08dbfd54995e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 09:59:59.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evZJGd1TBttTgHkXcwTzUD+TQWqtiru8LD+8vjh9yuB8VtLxsw18tJeVa29H1lD7yBZYezxxT1ZlbeJOmrbpfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_05,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150067
X-Proofpoint-GUID: pvYfxExChSbXhJDomNNMKkJtRMn-Lz85
X-Proofpoint-ORIG-GUID: pvYfxExChSbXhJDomNNMKkJtRMn-Lz85

Hello Vincent,
Thanks a lot for having a look and getting back.

On 15/12/2023 7:11 pm, Vincent Guittot wrote:
> On Fri, 15 Dec 2023 at 06:27, Imran Khan <imran.f.khan@oracle.com> wrote:
>>
>> It has been found that sometimes a task_group has some residual
>> load_avg even though the load average at each of its owned queues
>> i.e task_group.cfs_rq[cpu].avg.load_avg and task_group.cfs_rq[cpu].
>> tg_load_avg_contrib have become 0 for a long time.
>> Under this scenario if another task starts running in this task_group,
>> it does not get proper time share on CPU since pre-existing
>> load average of task group inversely impacts the new task's CPU share
>> on each CPU.
>>
>> This change looks for the condition when a task_group has no running
>> tasks and sets the task_group's load average to 0 in such cases, so
>> that tasks that run in future under this task_group get the CPU time
>> in accordance with the current load.
>>
>> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
>> ---
>>
> 
> [...]
> 
>>
>> 4. Now move systemd-udevd to one of these test groups, say test_group_1, and
>> perform scale up to 124 CPUs followed by scale down back to 4 CPUs from the
>> host side.
> 
> Could it be the root cause of your problem ?
> 
> The cfs_rq->tg_load_avg_contrib of the 120 CPUs that have been plugged
> then unplugged,  have not been correctly removed from tg->load_avg. If
> the cfs_rq->tg_load_avg_contrib of the 4 remaining CPUs is 0 then
> tg->load_avg should be 0 too.
> 
Agree and this was my understanding as well. The issue only happens
with large number of CPUs. For example if I go from 4 to 8 and back to
4 , the issue does not happen and even if it happens the residual load
avg is very little.

> Could you track that the cfs_rq->tg_load_avg_contrib is correctly
> removed from tg->load_avg when you unplug the CPUs ? I can easily
> imagine that the rate limit can skip some update of tg- >load_avg
> while offlining the cpu
> 

I will try to trace it but just so you know this issue is happening on other
kernel versions (which don't have rate limit feature) as well. I started
with v4.14.x but have tested and found it on v5.4.x and v5.15.x as well.

Thanks,
Imran


