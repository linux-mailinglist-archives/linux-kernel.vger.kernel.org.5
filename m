Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B787BA4EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbjJEQNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbjJEQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:11:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4418EA2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7OaQxhEidueX4Gg1Z/H9z0FLCzdIAynR5J3GFT2OU4jtzp8QwLoBpUwsKpcmgBk8qX+lYqNzXkVEFSksaDw0PuOgh242xSh7NJSmjBEznXyQlhGGmhCYpNUdZ4EvkhYz2ALguL161SAmaxFCsAha5++FQm+P7xP4UizjQeILOo21DOyMhOQYqWi2O99A6daBvr0fIkhor1zqoajSM9t5KayAxZLBN6crQuq+njU1SV3JITdndp6xTWDV558EUHNvtZUxR0B05YY5fa0ta40jCeGLOerMQJbhgMIpOwf/aMHiHiFWmouSjjd2miCX+FYi7/aTV3Ltl0HudhmgeeJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmOa9GkjA1UmDCD2L4jdYMdA8BG/erq5Y0st+2Wh9qs=;
 b=Wl2/KJl1KzNTxXoY6i6pV0RbGttvv4wQT0i8AL6lOktPe/3+Kt7+cd2GCbyIOiADW2d91r5GXh/gSAZ7oGoc0O/Ik+EHYdJqh9zO+4ts88+BU8uquI4r16oLXvYOI5R1dQnSsnVTiQASn12nJuf96W+UavnG/3UgHBCEje/jLP0YXk/K4iNWJ4ITolWL6sAqhovgYkpPIxsqDz1d7G0swVncBIqB2LrlsNNNShHBhbxzf8tgi1gGGPX8xgHCpWA3p7dvtWg46GUFn5WERkwRjTdPki2PEtMNNj8JxmKovNB/OoPv7oX5AiGdG4iujT6kOWyR0rYyJ1jvoY1hQb72+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmOa9GkjA1UmDCD2L4jdYMdA8BG/erq5Y0st+2Wh9qs=;
 b=nHOIaOvG4zzNvblCDxz01kV1OhRk3LWioIifw3AkTD9SsnV+KffxlgUSY5wGgyF9kUFkB1XWqYEB0ZDTSTf3qllE34eQUnh6dl9ajD4LuKAcvx5dGn3rIiHUuSP5qVxXNu15g2gGz5GTTBRxBDsn9pKESbTvmrvWcbs/9msGtVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by PH7PR12MB6936.namprd12.prod.outlook.com (2603:10b6:510:1ba::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 14:37:52 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 14:37:52 +0000
Message-ID: <51b6606a-fdc1-de11-2260-863ac08071fd@amd.com>
Date:   Thu, 5 Oct 2023 20:07:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
        git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh> <87wmw1p4g5.ffs@tglx>
 <2023100547-retool-chamomile-d581@gregkh>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023100547-retool-chamomile-d581@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::8) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|PH7PR12MB6936:EE_
X-MS-Office365-Filtering-Correlation-Id: db524a7f-1643-4378-7e03-08dbc5b0a6bd
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q41wONfY+ZMcS55p9Q6yhvt9Bsn+mUiSgc8Yu8fd3nYeUScORfrweS3tpGtU6JvCZ3flCRvprSYXuAAoIXJdXBvl+bcsiW42Su5noS/GptzR3vptMWLKhwDoHX8aoG8sE/3B4McLWIFMY9BT+tqK750hf2GPDaLOS2ysN8ovUK+dboLkiOmBG3OKVm3VIRHKBx7BYGmI+89Tcj8aNT9Ff9UnTAMBr5BQAOa5DZNRXD6LyXWV38YQDrX/jYTpjhmsT13ecCOmtsuuCpMUkNIf383VmPBKQH79mGjLo10YORby75q9LLMzEQYwq+gJX/ykb/W7ExOLyQi1pL7oLNDYNLCVOfqI8sIeWpoTV+xU5ekwmNXh4FCLVh5les9eKvrzQQD3e4vR8h8g+PinpJKXrmeFbYfboBRSO5+yIrCZC3j7tmUATAIp0MHMJs71dc64bnlRvwRMtgDCBCX1EmLEGKBX6cT8R7P36hv2e9uaNqzVmQWEycO0iZ2e6w+fqFAlUIClJGIHcFEaWy4vXpMtOvE368QY+sY8bn3nSdiKoxc2Wkr85MDl08wsiYeOGa2l7wOzZBqQmjchf3g67tKr0WCB0ECVL6pIGsmQXxYgWzW4Q/pFx0xr0XQoFKWmsT9pcfzlRpiQlTFtp8racwOA1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66556008)(66476007)(66946007)(316002)(41300700001)(53546011)(2616005)(6512007)(26005)(36756003)(6666004)(6506007)(478600001)(6486002)(38100700002)(31696002)(86362001)(83380400001)(110136005)(31686004)(2906002)(4326008)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVFHOVMyTWhGaTlCOEM4Wjh2a1cyOGsveDJUT2toYm9STnhzUE5iMDN3YVZx?=
 =?utf-8?B?Q2F0cW9GTVA4VVlabDg3N3VPNG8wUGc0MkxuMTVJMmpVTDlxNEJqVVdpWjYv?=
 =?utf-8?B?d3NZVUw1emg2T04yMDJPTUhYdENuM1p6ckJaZFdvcFFTK3NTaGN6ZkRtVjRz?=
 =?utf-8?B?Z2wwRURrMWJCK1oxQi9wRkh1am8rQmlHbDE2TDE4NGJVWjRqS2pGOS9GUUh2?=
 =?utf-8?B?aHNNU2N1UTBiZHVTZ0xid2hET2psK3pLM3RGTlorM1FqSkl4cXZPT1hSeFRl?=
 =?utf-8?B?M001N3NEZ2tYRkNkNkZwM09hV3g2VHFHanNrakZQNUtVak4xb2p1MU5LTDdl?=
 =?utf-8?B?a1VSSWY3elM1a1JDNit4SmJrbU1iZko4WGxZbENUeUN3c2NXVHdVeFR3K0Vk?=
 =?utf-8?B?bWJQcS9rek52NWp6b2J0ellDVzV6eUE4R2IyODZUUWQyQTBCN00zbURlMXdX?=
 =?utf-8?B?dkJidUUzR280ODlZQTVMUFAwTFM0NkQ5NU51MzdoM0oyZDk0d0FFbTdzVmNQ?=
 =?utf-8?B?QmxwQXZCYzZoMlNQU0IxdlpxajdwREovVkNKVGV6SFRXZGo5dFJnYnFKUHgw?=
 =?utf-8?B?QWtjc0hJd0gzUnM1eXhnTHozSWZUL2RZUEdSNUVLSi8vVVdCNXFHVnhxSlo5?=
 =?utf-8?B?Mkx1NzNWMXBMNTE4L3NvL21pclJmbnBmN3hoNVcwODR0cnNtTXBKNDgvaTN1?=
 =?utf-8?B?OCtqOG9aQjh4cWxRUHVZZDA3akZoNmxkMm5XdUs4eW9BZm15ajdIa01LNDVY?=
 =?utf-8?B?YTVGd1VpOXBpSFZKaHhNN2MvZUFIckNpMTdQUHB6MDZ4UVRkblVFVmZmYUI1?=
 =?utf-8?B?bTh5YkNiNndEb25vYVk5MGpabElNT1RtT1lvWWtQZFljbzJUNlQyeWpQWHlW?=
 =?utf-8?B?MlU0TzFja2FaYXljQUF3YWpic0Q1QmF3M2VzZTUvRlhqT29ENG5qYTFyS0lx?=
 =?utf-8?B?M2phZFZWL1B4aWRvUFZtMThENVdDanl4bHdMR3BodHpwTmlOaUFYMUk0c3g1?=
 =?utf-8?B?M2dXWkFFTi9Ydnl2ZEpRbDMweGxJMHhFc3V6TXVhMUdrL3VrWUVzVFZGMEIw?=
 =?utf-8?B?Uzc4eXM3ZkgwQzRjM0srQ3dsNmhJeGt6dThQcFE5cVZtV20zeVNCellZUWdV?=
 =?utf-8?B?M1ZrenJtRUpuZ3UzU1pVcTBRRW5qTFBFelhBS01ETjMvVE1SUklKWm0wK2g4?=
 =?utf-8?B?U2g3YnpEMkhBcXJXVWZ0VnBGYUxackJZZ2VvYkZ5SlQ2Qlp1cVZtNlozU0dY?=
 =?utf-8?B?ZlVmQ1ZJTnFMQUc2QnRWa2JrY1BqRTlMd01aT2d2aEhPbUpoandRUDE5VXJT?=
 =?utf-8?B?eXNGTFZkUTFWV0dJcUVwTkVEUnd3Vk51T0JORlowM0tYYzdjY1Z0V3BEaUl4?=
 =?utf-8?B?Z05VOUxRRVM1VkRBODQ2SXdMcndvZG1HU282cjllSndZb214ck45ajdMck5y?=
 =?utf-8?B?Q0lJRVM3LysrYW5SS2wyNFVCbFl3aTE2K2hyUEtzeDFUUkZlemk2N25mZ3JP?=
 =?utf-8?B?d1lURVgvS0UvbDdKdlBoRnIxaElsbFlZT3YrNXBId0JjckFINzliMEVsRTlw?=
 =?utf-8?B?QkhnK1lpT3R1MHNFTlVIN3hqMEt1VDI1SmVnanhIVW9OVTBiNFE1RGFTYUM3?=
 =?utf-8?B?cVNYK01ST1dSQ0dJMjA0Q0JXamlKdFc4YjBjeGtyRnhDZHBnOW1LSjczTHJn?=
 =?utf-8?B?TVlpT0N4cENkblcyYnQvMjR6NmVvN0ZYcWl2WmQxaVFlUE4rZFpHR2w1bjVE?=
 =?utf-8?B?TDdTa2lHbzJRaVFyKy90N2hKWWhjbCsvQWhrSGRsVGlTT0VhL3BVZWFZblBL?=
 =?utf-8?B?cGRqSUU5RjZKQ2hhWTU4b0JPYWl4Wm9rZDR4WW9hTnNpVi9pSVdiQWdSTnFF?=
 =?utf-8?B?Sm9Ua3IyaExHM2VBL0I4L1hNWlI5K1dlTHN4aDAxallURkxVTllEZVNTZk9M?=
 =?utf-8?B?K3VtZ0NYdFZ2QlV1RHhYcnowY3lRVTBSdUpJb3h1LzJ2WE1iNGMxV1NtdVdx?=
 =?utf-8?B?TVRucDMxZENkdC9LZ1FiRFlVYkV5bDhQSVFuU1MyUUNpbkpWK3djaFNwMW5G?=
 =?utf-8?B?ejF0L2ttODRtQXQ0d2xSRzlCeS9KZVMxajd4T3lxT05ad0pMS2RwVGJVWFpr?=
 =?utf-8?Q?eFiCdRI+grCKjEscoX6PSW5Vy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db524a7f-1643-4378-7e03-08dbc5b0a6bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:37:50.8941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSKUdt266QvgAWQq0OjHxOXmXdrrPbwsLnjqk5u05loPXoMRXdv05h+tfyQ1kdzr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6936
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 10/5/2023 7:30 PM, Greg KH wrote:
> On Thu, Oct 05, 2023 at 03:46:34PM +0200, Thomas Gleixner wrote:
>> On Thu, Oct 05 2023 at 12:24, Greg KH wrote:
>>>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>>>> index a08958485e31..86df7ccb76bb 100644
>>>> --- a/drivers/cdx/Kconfig
>>>> +++ b/drivers/cdx/Kconfig
>>>> @@ -8,6 +8,7 @@
>>>>   config CDX_BUS
>>>>   	bool "CDX Bus driver"
>>>>   	depends on OF && ARM64
>>>> +	select GENERIC_MSI_IRQ_DOMAIN
>>>
>>> This config option isn't in my tree anywhere, where did it come from?
>>> What is it supposed to do?
>>
>> 13e7accb81d6 ("genirq: Get rid of GENERIC_MSI_IRQ_DOMAIN") :)
> 
> Ok, so this hasn't been tested since the 6.2 release?  Wow, I think
> someone from AMD needs to take a deep look at this and verify that it
> actually is doing what it is supposed to be doing...

The patch Thomas mentioned renames "GENERIC_MSI_IRQ_DOMAIN" to 
"GENERIC_MSI_IRQ"; and in our testing "GENERIC_MSI_IRQ" is also selected 
as 'ARM64' is enabled which enables 'ARM_GIC_V3_ITS' which in-turn 
selects 'GENERIC_MSI_IRQ'.

The patch is tested for MSI functionality on 6.6-rc1. We will re-look 
into the config dependencies to avoid such issues, but please be assured 
that the patch has been validated.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h
