Return-Path: <linux-kernel+bounces-16724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77D8242FB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97181F2501D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A933224CE;
	Thu,  4 Jan 2024 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bLV+dqNv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20A224CB;
	Thu,  4 Jan 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBE7XapJs6LDTSoa3N6RcWQpeYy7lVMiSSLU2TpC0Yo+GufkMPiFpAJupzn9osOs319H8lOD0IFsfubYoGUAw3tMctfROwIcyAg5c3CXuauzueYNY5K8YHIj4IjWlQ2ee3DbhpvGszuaZH6ZJYqj/wI1781fKo4nPWcK6zRGk7i6KGutSfIO/1g8696D1yDbcwGePP82oFPu/RsVrpyXTEPQI/8iziKiRhjoUJGYB9z9KQ0Z5LJw9gORnFgQbdLwDjxeecNzi3oOty8SwzV6LtA7zvyYg6o/opAZIPHuzeFsXYJHER9LbHwnGdRlqHFMoXoiAjyOZnDpdHBv8Y29Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPXO6NRqsF75xnNNyd8R9SlWlUZHtKzmer9F+eDV4VM=;
 b=IZCinq3Rdehc406qTm3EdLs56yDtu3yL/oL6Q4qNBQ1BL1oEzIV0xxakfxV+ReWxOPjzBDtGtGJHwjutU1bNwM3jILzT7GQGFc+vM7LI4KVhy0HfHiJDI0lNTqD6rAeUNtID2FgqqjtVaEi0a0UWdg9Eqvk9TrLB3c9Zsr/0DMXHQNkG8YaefXwaXR5p5kwyuO5g9xIRfG57LhglYcOVCBTeDLaRhX2im44q6DaLh/SKRQgnM/Aj+p8ekvGbSkJa9SU2F0KFhaIA0Ggpo1glOzlSxojK/FK2uOQ8eeL2UdgrCtEIG4NEeemqC3/La+wmfHK2EdXu1vX/gMRCW+wEPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPXO6NRqsF75xnNNyd8R9SlWlUZHtKzmer9F+eDV4VM=;
 b=bLV+dqNvc8laeRHYYk9fZFZoUQxyMfIWgQLAnoqPLqLk6KNkOfAicmXOSXFjvqs9ed9osTZEMV1Cm/jeW8WAs1/qLoiAi4UmfWXFK5m4rsF1k+9pG6JNx//QxMu2aeVJjP7rDLab4G22WRe9ER0hG5V1qlC5hgR1RkS3diRVl9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 13:47:35 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 13:47:35 +0000
Message-ID: <c3ab155d-cc21-e61b-a690-56c695c45979@amd.com>
Date: Thu, 4 Jan 2024 19:17:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
 <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
 <20240103171709.GL2543524@black.fi.intel.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20240103171709.GL2543524@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 885737f7-8177-4b2a-4b4b-08dc0d2bb49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ewroTNWFqJiZ9QbTJhUZ5swZA23Jo0+EDYArjGKnp3tXZkjdPxh27nqPFvQncY7LDShcLQXz2s0Cye2K3LPxGGnwAjF8xD60E4kQ4WvnkrbuvLyZ8ZFqShuB+r/ai6L9vBGwn35/E9RxIRLEFBpiOGlo7xAMt5rtMQripAX5Y++aoGq5lD23/p51YMSeLBrQ9fdsnyFDbK23kaE5bo96w022cFsXV9EnZkPQPXgEg/NQQXCcsevjFijWXc1k0yKtxSfmFckUiv/22erXBxIElwECHGrC53UuYuXRp/LqVHU73oqK4Gl0avC8OHeitKy5EFRDwQDJsTJ5YLLjDE3PtChOYHNDUHQoH+C/Y6gQBFJHzYO7VRumuZo2jDrci64Mqhs58ZuXIYMnelKs/McTl51eMddhqzkTDEAlqs5HD3OSafwOGs5A3ESPtJh7uteMW9iNegn1aV8LtWy1Vq46lOST1I+FWSMWYHylm9DVvxMXiaESuML2lM1bZTTfnyfKphT4ETZ08HspGw6TmXXtwDS57EJF727h0B6s181LL4gTmnqPdSCOoZML+jJjl8118tD4MuDF7LwWSkYoTnYwpkDkFxzHlMD+Ez+rsyuKCq8XlrrNQ1NpQBYKU7MR3BR1g6X7acFVbzSMpEZlRiarxg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(2906002)(5660300002)(31696002)(36756003)(41300700001)(316002)(6486002)(8936002)(53546011)(6512007)(6506007)(66556008)(66946007)(66476007)(6916009)(31686004)(4326008)(6666004)(2616005)(8676002)(26005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUtHck8rcmxibWpoSGNmRHdKc3BvNFVhR0ZpZjNrbGQ0a0xRZGxENDYrSTZ2?=
 =?utf-8?B?a1Irc21FVDBzVUVBUEpKaXFXQm96Z1JabU1jWDZJMHkrNFBnb3QyUDZzQldG?=
 =?utf-8?B?UHF1ZHpYYVF6Y1NRT0tQd2w4RWxxdjg4emxwd0V1K253b2wyVmtDUHM5R1dK?=
 =?utf-8?B?b3MrMWlBYjN4QTBZNmJDUER3VmpxanNvT1VobEFOVy9ETWVIdUtuNVMyMTQ1?=
 =?utf-8?B?S2xWT1dFcVRJbllISys1RFYyQ0dUUFlhb3UwMDN4T2lTOHRlbnhZWTdlcEM3?=
 =?utf-8?B?ME11TzBUSUtJbUJLeWpVYUF6a3h4enQrK0RaWldTNi8vSEE3ZDJhMGhTcjE3?=
 =?utf-8?B?WGcyZVBzZjA1MkJUc0x5czdWdm1mQlhtdEwyWWtWaWtlYWtMMnNLZURJZzJP?=
 =?utf-8?B?RUo3aTJJZGdXUDUreWNRZXd0YlJaMTc3TVFzQlZ2MkRiNm5zWUFjeHI0clNE?=
 =?utf-8?B?Wm52UmhmcjVrc3hoYWdLSWJQU3lTWHVZVWZQc1NUTy9qTVl0aUdTZkU3T3d2?=
 =?utf-8?B?ZDFjRG52NFB2MWptaDJYK0d6b1RLbWJIeTJ1c1cwcG9mSFNUSXNYb0l1NVZL?=
 =?utf-8?B?akF6Sk5OWUlITTFXRTBUalF5ZVhRanBKZG9nSHZmL0RMdjRNdjZrZ0J3djk5?=
 =?utf-8?B?OTlEZnV2TzBZNEw0bFVqNFZsNmxTVVM4RVRrclgydWtBN3ZuWkJjbmxOSVRN?=
 =?utf-8?B?R0Vnamd3bzNaRWNvRVdqSDI5Sm9YN2VnVGVmWjZuQm1vZnpwYjNOL1BaeGxM?=
 =?utf-8?B?bVRsbkJVeDZxeHg3aVA1Y0ppeCtENTI5cFJmSU1iZXhGYTZIaXNVNjVvcGhS?=
 =?utf-8?B?RXVwYmFIZzh0MWZjY2czNzhQbTBINGhvSENVdmhrSWR5QTVtNHY4QmsyU1N2?=
 =?utf-8?B?MlNScHl1SnZnNnJodE1ocTlVR2tDNEwzVW9kUUZvUWNtSjRMS2dMdGtpS3Ey?=
 =?utf-8?B?Ky9BVEV4REpnYTdRakMyV2xmenprVDk0eGQzMzlVVXRHT2l4QW1GSXVyNCs3?=
 =?utf-8?B?ZXY0Zkc3Y3Frd0x3dml3d0VSY204WkVVam1JZmNoMTVyS2NXU01kTS9pWFVj?=
 =?utf-8?B?UHNPZ0RBc3BZOFhTNU5XTjJIUzNNNWtlUVhJZndkTFZENTRZNWh2OXZQOHJI?=
 =?utf-8?B?VHBzdXZmamRpNU1RRUpVc0VmUW1aaHVEcktxYzZsUXMwYzJQWi80ZVR5OUZG?=
 =?utf-8?B?L1hja3RTeGJUcG1McFBVQUx0aDVoK3N6RVFRU01Gck54NVYzWFNHUXcraTli?=
 =?utf-8?B?TnFickRZd0ViQUNJWlFNTmo0a2NqeUxNRENwMm01cjJQU1JMUnlBMVBLODhk?=
 =?utf-8?B?Z05FV09tWGtaTG9OdldEai8yckV6MGZPUDMrVllVSWphRms1MlpjMFRzK1NR?=
 =?utf-8?B?Q0tkZWZ0akdmbi90RGNtd2M2Mzlha20vSEJJWU9URkpWeTJQUTNmaXFqZWF4?=
 =?utf-8?B?emRwdks2SkNleDU2NTJtd2NPNlhxVjlnWFhFeVRtS2txYkxjVnFCYUlaWVhV?=
 =?utf-8?B?a0Z5OHBUTkxJSDY4b2tINkZDOUUyN3VCZmxDS3VONjdlbzU4UVZSWDVDZWRB?=
 =?utf-8?B?Q2dZa0NoVCtrTmk2N29NSDQ5d1ZCUTNPczI4UVdRL1hzb1ludGFEcVFnQU00?=
 =?utf-8?B?U1hkc2dvL3R5U284WldiOHgvb04zd29UVktlYmRwQnVrWUVGNm5XbmJHQTVs?=
 =?utf-8?B?ZE1hK0RVSit1RnA2L05PWW9aaXhZeDU5ZDRvUk00S0lSMlVwRDNXV1BmVXN6?=
 =?utf-8?B?eWVWSlI1NFpyQ2JJM1AxM0dmMERoUWx6UVdnVm9TKzRnZVpOdUNONWh1dWc5?=
 =?utf-8?B?THFoSE5LZnQxZ1ZvbEVjUmJ6UUFiZXdJYXlyUVVUcUd3SUZGdzlsZnJOSFBO?=
 =?utf-8?B?Qk9vYkFraFBoUnNMYVRTSlFtYlAvNlR1WTlOaFVrR0pnT0hNK0VralM3THVP?=
 =?utf-8?B?WXJGOWdabWpUVnlhY0RPUENJUitOUFZUTk12R0F1REx6UFVLeHBHdU9hWERi?=
 =?utf-8?B?N2EyT2tjRlIvaml0c3kzU1pIeHR2TWdHWXgrakdFaGpSbm1yNGtPT240OWFy?=
 =?utf-8?B?Wmh5Ump3akZYS2RtT1J1NThnVm9RbTNoTlpDN3Zram52ZDdtKzhCYzE2dWI1?=
 =?utf-8?Q?/NZ4iP40WGX94TLNE4Y+hye8I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885737f7-8177-4b2a-4b4b-08dc0d2bb49d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 13:47:35.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbSA0qq32RzEU5vWcvLEqHfAVjOxKgnRCNwSzwEGRikuZFDkuwk4zARZ606sO4aJG8wekkSQFtfuxYn2qCZWhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539


On 1/3/2024 10:47 PM, Mika Westerberg wrote:
> On Wed, Jan 03, 2024 at 07:45:56PM +0530, Sanath S wrote:
>> On 12/21/2023 3:23 PM, Mika Westerberg wrote:
>>> On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
>>>>> Sure. I'll check with these combinations.
>>>> Can you name any docks that meets these requirements ? I'll try to get
>>>> hold of it here and check.
>>> Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
>>>
>>> I have some hardware here that I can use to try it out too.
>> It seems that issue is seen on Dell WD19TB too. So this fix may have to
>> extended to TBT3 as well ?
> Hm, what issue? I thought this works accross all the supported devices
> due to the DFP, no?
>
>> I'll give it a try this week and share the observation.
Got my hands on Dell WD19TB. And it works!

Here is lspci -t output with and without fix

without fix:
            +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
            |                               \-04.0-[07]--
With fix:
            +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
            |                               \-04.0-[07-62]--

I'll send out v3 with with splitting into 2/3 patches(Will see how it 
looks good).
Any other comments, we can take it on v3.
> Okay thanks!
>
>> Any luck from your end ?
> I did not have time to try it out yet unfortunately.

