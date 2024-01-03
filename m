Return-Path: <linux-kernel+bounces-15636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74606822F40
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406C91F244AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254341A5B7;
	Wed,  3 Jan 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avEkThse"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022A1A592;
	Wed,  3 Jan 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG3J3R/J3hTFhiiGd7isbvmdDtcgMEQVKzuC3D9os/G+YE6KvKG7KiZGLDIW8XjOMcKvFlhLoFj4zF15a690CtSe2eFDodJSHJL6ZtZf/rKyFqVXQMZtmKmWyrbo38ZWMtkAXGGuyTIvGH0RuMcrvbiesX7Gq0TGmsKH5LATa0GMmiPP0KQsnd9SwqjGsqBv0CxFWzec4SgYA4WUqhO59DF+2dUFT/crRcw5KQz7101xR1WNLXjBede3o+J7KJEbU+zodtuz4Oc1KGPhHa7ZywzTrlNCtbFuJP54MXcwRxd/WSdLR4mrJQytFGon4KsGBsBT5pFqhWHmcSzaMt/kaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIpfd6KGmxYH68oF1YzgWVubmXTZjJem1opCSrub4d8=;
 b=dI9sA7Iv5DazGH5mJrwFNYGId2wMYCQpMBkoWeeZobGm7td3Xhr19WAEpXEGwCiRC6Q29+FIVDihFzRJDQL4xvSnlzVz1YE4znCET+pdJCW7CCbVaJSqCqcK69WW8LYeP/yUVm1sJYn2o2qWPnBrK3u3peLpdFUm9YubHIxX3v4dDo0d1DIgcQtNlR6A0uaNNacskNMAyKicqgY6TBuHmelbBnU4P48skhN51AEL2y92+pSjDGJD4T3QDxDK+icSv6argKghmVP0UC2f1tlJXLjxXTAwTDct2f+Gig7CPPiK8QfZH9lHkFigG3IEPwjKfjVSFqln7RqI1mU0+HoIcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIpfd6KGmxYH68oF1YzgWVubmXTZjJem1opCSrub4d8=;
 b=avEkThse3UvbT+3WnUht/VcXKBISdl9VKjQcFWX8jy4BsmhxcyCgu4a/X8eg/vfoJvmBBBnEmUxLdefFt92RqfQJiTyqqF/NsNgjM8Di0nKpxTEId98A6dHzGuo7v09m8rKoysznXpZGo0HQ30xFPENQCQIKKxzySU7kx9X/+hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 14:16:04 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 14:16:04 +0000
Message-ID: <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
Date: Wed, 3 Jan 2024 19:45:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231221095307.GB2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0039.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::15) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1957b3-44ac-4ef6-c6b3-08dc0c66855b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vXhPLDv075cjHH8475N708axLDaELCN2DMiG2Ymj5bB8qNkjh/bV+MZXpBl7F2pGVEWqxyuPQ6hB6uE3Wjmp9XmvNG3FWCkKIj/d3WlJjHn2LgfKSQQW+6WWY2vCFLfNJVnA1ox+kdJYn93L1cwA0TY2QCFvaszAYlyXCtKGqW2BydQRGq7ZPUpsWKrmtmLEqadu5UBUMQX5G2iesq09qOSgR3MOKsnbearAjM+KgJCnwWGCC29zw/Qq59iUNIBIw+ZIwWM9i68kEKjP0ZdnbELJk/CFA/vkgOAhV2/e85msJkdZpanXOFLu/rf9Z5Yx6tT8v5vz2xV0smUsHE2Gfpw0i9UZEpgHptszWFFjFqC6ZrwTL6tgZHk3E6sAPfMwswnXfr4kZxhJPouO3b/nKqyMM5BWkuhIGbeAfgFvE3/D3PYWsXw+6n9ljNLvMDaCXbGdroX4cFqjofutEm5XaxpAAUXxoDL4tuHpz1+nOLxxWoTD/TUuJngF174soYBQcUGsjXrgxhAM/zrdl/6onttmdxd/MQoU17sPjYr86nTrIdpWtclpLipzNk3HA25m7i4y0lUhWC3CBRc3aQfsf69fBLATFp0puLWGNuzf+AdtyALyK7r0rovhajw9q4PIKtVPX1H13OFSatRWX71kTw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(6666004)(26005)(2616005)(5660300002)(4744005)(6486002)(316002)(8676002)(4326008)(478600001)(2906002)(8936002)(6506007)(6916009)(38100700002)(6512007)(53546011)(66476007)(66556008)(66946007)(31696002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tzTXEvcUNIaDZ6TTQwOVlkWERwdkgzaTRtUzAwdTJ6ZFB2bTd4SEFrNDk1?=
 =?utf-8?B?NmxyUjZXQk5TdHZvZ3I3UmhhU3lnc25kUHIwNUR2bUk2TS9FU093alFFcUl4?=
 =?utf-8?B?bTlsbkhqWldFWkRqNndneEF5aUIvcWwvR0VDdUNFUCs2NDVMT2U4ZUNFaU15?=
 =?utf-8?B?MmQ0M2NMQ1FvekowQWtCdU5VYjI5UWNONTd2S3RNZ2kzTGFUT1ovQ2xqejdT?=
 =?utf-8?B?WklnLzJFTWZiSDlVSFJhRFo3QzJnenEzeFpQTSt1REs3YUs0UEl1Wi9LVjU2?=
 =?utf-8?B?VUwvSm5FbjB0UUlXM2M3Qk5sRU1hYjFxUjlsbUFiQWlXNDFaNWdNMFRDbjZH?=
 =?utf-8?B?NUE4U3NkSW9zQVVPcHVPUjI0MHg3REphQ05jN1BIYWRjeEJtbnNNcGpUckJn?=
 =?utf-8?B?alNFL1k0TUZuUUtJeWtYbVYrVlNnWWtRVGYrdDBqYjBST2ZGakgxZnN6VVZM?=
 =?utf-8?B?TkQ2YUtPWGxpK2E5WEo1QTRzUUl2dE1tb25odGNMcXgyZXp0cTlwcG5vZUJP?=
 =?utf-8?B?aDJTSnBuMWtVdUZQcCtsemZHVFBmV28weTk4VDZ5N0NHYXc3dlNmQ1pXYU4x?=
 =?utf-8?B?bE8relllMm5mOE5Ra1A2d2RyenVrcThFcnB4RUgrSHN6ZTBMektzMEIxQW51?=
 =?utf-8?B?eEZXMjNGQkd3YVVQaFhEazRwMTJ3Vnd5d1FnUC8vL2NUWUN1SmEzUUtHbzBt?=
 =?utf-8?B?RXNZbk1Oei9nQmhwUkNEWVBiaEp3MTZGOFJpeTBWWXdFRVF0eFBqMmw0eExB?=
 =?utf-8?B?WTdsTWY1M2hpdjQvUllwZGVGRkp2N0c5QjZwWEwvWlJQK0dVbGZ4WmpVeGx1?=
 =?utf-8?B?cWlBZ1J5Vk1JY0JlNk5PRnordEdVRlloWmhoUnFZakUyK0RJcWk4ak1Ick1s?=
 =?utf-8?B?NHpJYytlTUFTcmVwYTVGbTdlZG9oWXAvbE4xZENkS1MzUWRGKzZxWTJuR01I?=
 =?utf-8?B?UGowQ1pveERvUzZOZVpWejNaWDJPYWxka3VwUmlEQUpXQjloV1Q5cnVqVjFQ?=
 =?utf-8?B?OVRvZ1Y2a29wRmgyYkhiNUo4TGxBeGF4Y1VmRWZtNDZzWUZFVVhWakNUYUh0?=
 =?utf-8?B?Tnc1ZmJMSTJoZnBkWXZyZVY4TUFsaENlVlB3WVlsMEVCVkU2R0wyVUxtQ21I?=
 =?utf-8?B?UFpOZldjME9aaUxiemljTzJpajVuSGdmS1hlUlhBKzlyaFJqWVQ2cWV4WTNw?=
 =?utf-8?B?USt2dDhOWjR1YURTTHUyY3JjT0JEcEVwSU5qR3FwSlczRHJpbm5qcnYzMGpT?=
 =?utf-8?B?cit1REduNjczeEk4LzdYUENiVUlCeXRyYm1ZNmtCVkZJclZRTWZXZ0VKVEls?=
 =?utf-8?B?ckVsVTFmOVdiUHIyaVhoa1lXTjArNG15SlROSTZQazhzNGkwNm9OcFhXdHc2?=
 =?utf-8?B?SlJzc2VrSkpYSzNEQ0ZkTGpodU1NWWpSOUtqYmtGTnVYamVRRWlocHJDQ2dI?=
 =?utf-8?B?Q1RJNURYdzg4bFVVaDRZNG95MG1sdU12MHlwaVhNU2NTWUpuMkJmeTZ3NlV4?=
 =?utf-8?B?SU5hR25Wc3VidHNOVDNJNWVIVHhJejhjNEt5eUtRalRTVmlpdkovUTZDaTZy?=
 =?utf-8?B?aFIzVHppOGJlQ2FCa0ZpU0ROckZvcjhPazJCazZyV2VhbDZpQWY4WHhWUVpS?=
 =?utf-8?B?dFc1YnFJaDRYa1hqaW9ZZGhQUWgyY051dWs4RFl0NjlOdCtlRitKdmllWnlz?=
 =?utf-8?B?YXoxNEJobnhKVVRiaExabHFkNWJ1YXE5cHhvdnNSQjUvMEQ4RDBPdSs0cDJj?=
 =?utf-8?B?dTdvbTRMc3JTcU1QcGhzNE0rVmVIbzJlUmd6Um5tL0FVbEdrdlU1c3gyVGo0?=
 =?utf-8?B?ZEZBR3JvdFprYUkwMmg5SjlTRy9BVG9jMEhYSXJzd1IyaUwxTVBPS0hVM1lB?=
 =?utf-8?B?VHNFZkFnZHVaaUR2cGk1SGxRNUt5NmMvWVRiTktJUmxJNDEwZXdmOFcrUENh?=
 =?utf-8?B?clE1TDAraTRqTWt6SWVWQ3Q3NlBkUmZpMG9MS1g0dHo4dG9OSjdUcTV1SENx?=
 =?utf-8?B?VEIzQmw3bmJYSmJFZDhwUG5FaTU1STBjdXJaM2JtS3g1NnFBMjV0WHZMejdx?=
 =?utf-8?B?UEFKNG5iZmdYbXliSlg3V2tHcGRzcHNqekgyQ2RhOTdPVVRXclVJY1lMaWhn?=
 =?utf-8?Q?D5IuDymOUBLEB039dt5rCIrCf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1957b3-44ac-4ef6-c6b3-08dc0c66855b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 14:16:04.6857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORIUTiordxzjJ51iHv7Req3ZRLlDiWzEKouKbpTt7/+Xcmdj5j3nstCtOSAWNm7nm1HpEy63+za4BOonqC8DLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785


On 12/21/2023 3:23 PM, Mika Westerberg wrote:
> On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
>>> Sure. I'll check with these combinations.
>> Can you name any docks that meets these requirements ? I'll try to get
>> hold of it here and check.
> Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
>
> I have some hardware here that I can use to try it out too.
It seems that issue is seen on Dell WD19TB too. So this fix may have to 
extended to TBT3 as well ?
I'll give it a try this week and share the observation.

Any luck from your end ?

