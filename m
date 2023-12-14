Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DA6812851
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443227AbjLNGin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:38:41 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FBA6;
        Wed, 13 Dec 2023 22:38:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJghHoq7owcwL8/1kOWKZEzpUo2G90tptbBIoBT/oenPdqfECe97aMmVnoiXYcguHQAnNxnozIBpfDfzwSZeCpUvZeKgIJfKzJlMWZpuzDkJpyYcohVuKxKIl1T4SLMImPI4topP6ZIKet3Xv50bZuRr3bNdqwxlFY6191fzDCUDB8RDpJmqjy+ttuDxSbfTa44MZzGCQqjCTbSDZUox+v6Riuf6dPEqlvDhLhHXMZnyIGixsDdxX5JkzB4dwskei7GUVQRoptebZKvLdOjQDT+58EJ+1ZRNogY7j4EGSHWiW4Dnqyopf/7PADX0ioBTtNDDMd1d8mvWVsRaqqx7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXqj2MRy8brXhrPvgbBjaTqaDVFF5BvKXfpSj5cibbM=;
 b=e2At7mWD8Ihe4BsCYv09NrpSXrOQyImvJArULH8Ie9N4b4W77h6NmhKlWhmSYjL+V1Iu7THMd6VpCNURsMyhWXhLhu+UrmiJBiWoXfXe2vp6/ArfJZ+Lx4jAT0RrOgy0qfY+VtMZX+gopS+vCfepPwe9vaDAKep0x9z1Lb7sW3XLAJqq4gGpEGXl2EVyxu12WzZ4tu0P9wPkDJ2kOmUvmFqSDoQFQwFLMpk88TsoEXU8KJuM8E4ZHu5wpwZYyR0BHOOQhFBiSFiDTwWKSdnrqYBKfbqs8o5nEgCswR8nVsTZBeYAJzsjbV0RbBSuSOn2aRXMCcctc4BbX88rykxDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXqj2MRy8brXhrPvgbBjaTqaDVFF5BvKXfpSj5cibbM=;
 b=WHcDBqSEizZ2mfaHaKPL1gQhFXoc2r5fRe7rLB0B5iSfewkbQ0r1FG/MrBlyRDSWqFMaO7foy4rtrDSxd+OAc2hYA+ODW/MyqZ5esR2/ITG67tc/ZxgC38diKtUlSP3WoSpS1vrTA1WcATqWjr9SnPbfQasu9g3DeRgifrEPGSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Thu, 14 Dec
 2023 06:38:44 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 06:38:44 +0000
Message-ID: <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
Date:   Thu, 14 Dec 2023 12:08:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
 <20231213054914.GI1074920@black.fi.intel.com>
 <20231213061805.GK1074920@black.fi.intel.com>
 <20231213062306.GL1074920@black.fi.intel.com>
 <adcc6446-8c30-a258-e19b-76fca2c50d21@amd.com>
 <20231213115256.GM1074920@black.fi.intel.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20231213115256.GM1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::19) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f89361c-1339-4318-26a0-08dbfc6f509b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bqOJPSMmwJLktoW8Jw53Z2CaH86wd63u4MsYSIqS1WSU46aBL/dlssNzCOTZpVWBEABJBhqJtJvMjWioSte9PKv296oEdqbZDx9pFLxnxySnmTniU/sQCdT/rF42l9bDlbJkpwqpjixsOx1JLgZa4Z0gkyh6yq2Cksqz1drecw4bhLCYcRBEcXCyyWknd96HD5hNydk/FxgVeIhXaFhgl8M41FVSlnmqn6St4QG4F6aJq0kw0l0VEuASsSoD84V8n06Ytg+wwE7rUxpdQaH7LIAt7tPG/Od1hanE2Ted3OmeMFrv2tTpRJ8VmzofnU30NCJF7sLH/wi3BawPInDgJgLCbpaYukYSZX6Lbmkh7wVG13/EYwlJrEawWxZgOlZC5It2MsccUEbu/Nc8oGmxOlkKAYY3g5D3TKOB22y45GeArhtyxvWmQ2aTuqGVA4GMcDYxS1RqTfsGBaZU+5NOFlGwVh7KqKkphBtol62cTMTlk+DLKDRbspQbGvnF9F13Ly4J25iVQx9Oz5ZXYFGU9x2axqBLR5Ly4kzqoMOBtV3GhQOi80usflVt+1ANrmcF0LwCTMgRFGVPx0WOC22tH7TTZewKZ6FuknBzmUJHw9KQVAKnB0SQGHvE4YyxL0uuYW3Ukj9T/8E7+fNSKZkCgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(2906002)(41300700001)(31686004)(478600001)(6486002)(66946007)(66574015)(66476007)(66556008)(6916009)(6666004)(316002)(38100700002)(4326008)(31696002)(8676002)(8936002)(6512007)(6506007)(36756003)(53546011)(5660300002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3Q5RDE5MFVMWnBpam1SRlpkUkhUYm1zYXhKUElkUDNHL0p5Ymg0NHB3WW15?=
 =?utf-8?B?ZGRsZGlPY2FWRGtOQlYyMitrTG5tNEFKd0dRMHpmWVp1VjQzejFFaWtkbmM0?=
 =?utf-8?B?ZFZXNDl4T2tNbkZZQ0doYlZ4ZlltckRjby8wWGxqbVVFYkVqa2JkOFpEb2lQ?=
 =?utf-8?B?OHl0QTNKMUo4aGVkTTZLb3daMWU4K2FOUDFwcm5NQ3N6WWVkYjdpcElCTjFv?=
 =?utf-8?B?cGY2cUxFZVFqUXBzWVNMQlJ3bGtQdXU3THp5a00xTkI2QXE2TXJUMUtMNE9Q?=
 =?utf-8?B?S0N3V3REeUpKSS9wWlQ0NjJ3VXBPUTFmbmFIYXBIa0VNWnhSMDB1Y2hRdkh5?=
 =?utf-8?B?MVU3VmN1R3gwTFM1bklabTNPWW1sMytMVlNDRWdGbWNnR0ZDRk1hNmtXRmgv?=
 =?utf-8?B?bkZoWStrNk9hbG81WndLbU9IN2VsQ1dRTTRrMDdlMVgvOXJWWE9tRitIdkNi?=
 =?utf-8?B?dzJHcDdBcmF6NG43TlB6c0c1T0d1c01PUXZrV1BuZ0p2Skc3WWdETmYxNDlY?=
 =?utf-8?B?K2IyaTJCTldiR0dsR3pyYkkwdVloY3lvVGVWSkhWWUV2TXJpcGt5UHV2Q3ZZ?=
 =?utf-8?B?NVFaSFhpcGROb3hKWTI1TDRaVEd1U0RWMXVZTTV1N2Yzc1Z5a21QWDljRWpn?=
 =?utf-8?B?cklyU2REbGJsWktwdmZxdVpncVc4RjdXUWJCRzl4NnJqZUk2T1EvRE5xUDMx?=
 =?utf-8?B?Q3ZwTDlHZ0NvbVk3ZGlBU2RuVHNnTjFOb01oMTcrRVMzWmg0M0V4Vkt0VkJl?=
 =?utf-8?B?d2hhK01JTElWenBqVHhwZTFSMmtxNEhWWUlBb2FuVWdyTXZMeGQ5L1ZydXVt?=
 =?utf-8?B?Q1pxME83eUhzMlUvWFY4U3JyOFdWRmNmeXNSblJaV0ozeUI3ZFNOcXp2ODgw?=
 =?utf-8?B?MEJRVVY4bzREVnJUOFpMejUwZXJRWk5qQUxNMlNJTWd2b3ZLTGZhY3pVNTlv?=
 =?utf-8?B?SXBQcW5aUXhzSTFRUTR5SktqQ3F3U251OThFV3dZZklzZjFTT1dyT3pyKzJP?=
 =?utf-8?B?MWU3Z2E0ZitYMHF6S3pNc2Y5TmdIQmUvWjdVYWdqeURTYzVKUkNlUmh0aVV5?=
 =?utf-8?B?U3BkUXRlbEU0YnBFYWFIU0hBenVHbE9sdWx4K0k3cng1Y3FiZHJNWWtKZkUw?=
 =?utf-8?B?cTIxM1dTUTgvT28zZlNiamZZbWFSV1EwYS9RQ2gzTXJzWGNjL0IyZU44anZ2?=
 =?utf-8?B?T253cjd1VGZXcHplOG5UTmN0M2REOTZBT1dGV1cwQjRlSWxjblJtTFlJb0hC?=
 =?utf-8?B?M2VJQ0Jkc3hxdm1mUklZVWRQaTR2VTluQXNXa040UmdkTkYzYUZCeVd3RW1J?=
 =?utf-8?B?YmxMNU1JZFoxdjFoRFJONWt3Yk55cE5DT25RMDE0MVRHckQxVytoemtWNE1V?=
 =?utf-8?B?dGhMbjN2VW8vQllQSDh0NWJJaFZlL24yZnEvbnBFNk8ySjQ1SHkzN2ZITkhI?=
 =?utf-8?B?a3Q4LzRuaHJJZi9IWUgxeGJrNk1uMDNSeXhraEF6WGQwRDB4bTR3R0k5WWQw?=
 =?utf-8?B?L2FkMmxuazkxcjdkZzZGSjJCZEhwNUFHSVR6Rkg5aUt6L09zNE9iYXVVdzlj?=
 =?utf-8?B?bzJyTFliUGVLOGkwdDBiR3hPc2tMOXRSUHVJMnZPbEk1dkpIVEllOG9sZTZo?=
 =?utf-8?B?SEZYT3ZiTW5xM3h2UTNTNGZNRVZpcU1LNVFXR0t1dng1NW5zWU8xaVdVSnBN?=
 =?utf-8?B?S241TDZKcTUxYnRQa3N3a0t0dVpJdGFPOUxZS0FvSnB6QXlpOEJOT282RkFz?=
 =?utf-8?B?T3pXMVlLRk93cTB3UHB4eXUvVE1hTlU0bThNM0NYeXN1blN3Ky9jMGpGcmxB?=
 =?utf-8?B?VU96RGV3dEtoNExtelVjNWxKcXdPcERkZEYwcittdjRYK0R5dnVQWjUvL2dw?=
 =?utf-8?B?N3hlYnJaSXRubElsc2lZOFFjbjBHTWgxZCs3YXJYNlpiSk1JMWs2SEhlMW1I?=
 =?utf-8?B?NHpYT2tEU0o0Y0YxOW8wSmFQUUhTc0plcWtqRk94eXNDcG1oVUttbHFYMkFz?=
 =?utf-8?B?TURsbjVScW0xeWM4Y0F1NGV3MjhQMzlRYlpUS0pjMmxGTmxKUWM5K29zSWhW?=
 =?utf-8?B?MStYRHVyWkNsdzVOdkd3OUQ5akJYRzlVbUVHVjI5Vm5pNk1DeVpvaHdXZTB5?=
 =?utf-8?Q?nTezvCFTHHG2D0y83+KrEWNND?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f89361c-1339-4318-26a0-08dbfc6f509b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 06:38:43.0057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: da6uMoe9hSUFPjOhl/cdIPQzxwdG2w1DxLtJuNTi3miqadCzoIGOxOq+p6Gd0utdnN13yyH2tFvWTdFRpEJ34w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/13/2023 5:22 PM, Mika Westerberg wrote:
> On Wed, Dec 13, 2023 at 04:04:57PM +0530, Sanath S wrote:
>> On 12/13/2023 11:53 AM, Mika Westerberg wrote:
>>> On Wed, Dec 13, 2023 at 08:18:06AM +0200, Mika Westerberg wrote:
>>>> On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
>>>>> On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
>>>>>> Boot firmware might have created tunnels of its own. Since we cannot
>>>>>> be sure they are usable for us. Tear them down and reset the ports
>>>>>> to handle it as a new hotplug for USB3 routers.
>>>>>>
>>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>>>>> ---
>>>>>>    drivers/thunderbolt/tb.c | 11 +++++++++++
>>>>>>    1 file changed, 11 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>>>>> index fd49f86e0353..febd0b6972e3 100644
>>>>>> --- a/drivers/thunderbolt/tb.c
>>>>>> +++ b/drivers/thunderbolt/tb.c
>>>>>> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>>>>>>    	tb_switch_tmu_enable(tb->root_switch);
>>>>>>    	/* Full scan to discover devices added before the driver was loaded. */
>>>>>>    	tb_scan_switch(tb->root_switch);
>>>>>> +	/*
>>>>>> +	 * Boot firmware might have created tunnels of its own. Since we cannot
>>>>>> +	 * be sure they are usable for us, Tear them down and reset the ports
>>>>>> +	 * to handle it as new hotplug for USB4 routers.
>>>>>> +	 */
>>>>>> +	if (tb_switch_is_usb4(tb->root_switch)) {
>>>>>> +		tb_switch_discover_tunnels(tb->root_switch,
>>>>>> +					   &tcm->tunnel_list, false);
>>>>> Why this is needed?
>>>>>
>>>>> It should be enough, to do simply something like this:
>>>>>
>>>>> 	if (tb_switch_is_usb4(tb->root_switch))
>>>>> 		tb_switch_reset(tb->root_switch);
>> If we don't tear down of tunnels before performing the DPR, the PCIe
>> enumeration is failing.
>>
>> PCIe link is not coming up after DPR. Below log is missing without
>> performing path
>> deactivation before performing DPR and hence PCIe enumeration is not
>> initiated.
>>
>> [  746.630865] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>> [  746.630885] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>>
>> I think when we do a DPR, it internally does some handling with PCI Path
>> Enable bit(PE).
>> So, deactivation of PCIe path is necessary for DPR to work.
> Rigth, it should be enough to reset the protocol adapter config and path
> config spaces. I guess using discovery at this point is fine too but I
> would at least check how complex doing the minimal "reset" turns out.
>
> I mean in tb_switch_reset() for USB4 v1 routers it can go over all the
> adapters and perform "cleanup" or so.
I gave it a thought yesterday and we can do something like this:

We are already doing tb_discovery(tb) in tb_start. This would
discover the path configuration done by Boot firmware.

Now, we can place the tb_switch_reset() right below that api with
conditions suggested by you.

And tb_switch_reset() would internally DPR for all down steam ports.

It can look something like below:

     /* Find out tunnels created by the boot firmware */
         tb_discover_tunnels(tb);
     /*
      * Reset USB4 v1 host router to get rid of possible tunnels the
      * boot firmware created. This makes sure all the tunnels are
      * created by us and thus have known configuration.
      *
      * For USB4 v2 and beyond we do this in nhi_reset() using the
      * host router reset interface.
      */
     if (host_reset && usb4_switch_version(tb->root_switch) == 1)
         tb_switch_reset(tb->root_switch);

With this, we are making sure while we get a unplug event after doing a DPR,
We are clearing all the paths established by Boot firmware. This 
wouldn't be possible
if we had not discovered the paths before we perform DPR.

It would create inconsistency for a new hot plug if we have not cleared 
the path configurations
of previous hot unplug events.
>>>> Actually this needs to be done only for USB4 v1 routers since we already
>>>> reset USB4 v2 hosts so something like:
>>>>
>>>> 	/*
>>>> 	 * Reset USB4 v1 host router to get rid of possible tunnels the
>>>> 	 * boot firmware created. This makes sure all the tunnels are
>>>> 	 * created by us and thus have known configuration.
>>>> 	 *
>>>> 	 * For USB4 v2 and beyond we do this in nhi_reset() using the
>>>> 	 * host router reset interface.
>>>> 	 */
>>>> 	if (usb4_switch_version(tb->root_switch) == 1)
>>>> 		tb_switch_reset(tb->root_switch);
>>>>
>>>> (possibly add similar comment to the nhi_reset() to refer this one).
>>> Oh, and would it be possible to tie this with the "host_reset" parameter
>>> too somehow? I guess it could be moved to "tb.c" and "tb.h" and then
>>> check it from nhi.c as already done and then here so this would become:
>>>
>>>    	if (host_reset && usb4_switch_version(tb->root_switch) == 1)
>>>    		tb_switch_reset(tb->root_switch);
>> Is host_reset necessary for USB4 v1 routers ? I did not use host_reset in
>> this case.
>> If its needed, then we have to modify to enable host_reset in nhi.c as well.
> Well you are effectively doing that here, no? You "reset" the host
> router therefore tying this to the same command line parameter makes
> sense and allows user an "escape hatch" if this turns out breaking
> things.
