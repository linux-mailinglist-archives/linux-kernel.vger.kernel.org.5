Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309B8128F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443261AbjLNHUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjLNHUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:20:30 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0EB9;
        Wed, 13 Dec 2023 23:20:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jlv9IvFBTY+whM/DbbLamZ6WJf2Ww9TjzoKFWHgbTn972bX/7Bq4Y1VVZIhjYUGMYqDiStT7simyyVQxoZV6o/DArMBZDCY+617ZnxWq+tEZ0483T1A9Xhaxqy96Ntrc/ypYNUO973k7xPvSLqr4axE3uf+cCgDeOOpTo54C8pobjWkMzoqU7jVOOVdwFCPorSzSMJ3zmgQtcVSHo7wX88/Wx4FAamlOysDpKRwQ7LskfN60zVEQZMK23Gczm4+U7JNRlWnXt4ugvn/Ll+AzOiMZTav8r0+t32GbhEqtJh8aPMqGEc97Y03pVODhEvlx+CyflPnJRPESScBvKWKyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tO3FgzNxyc5S8sl0ZAZ1cxvnNZBHila28w0PAi+s9Y=;
 b=Bhdqpnp2O4amI/rS5lat09dyJDBKFDBonEb+zEkyB5wYBwmNvLBtNYsKZCfjs4ZHz6IXv+u9BAXDKQ/F9tpWHpx+NzK0v5Pl4KqBD8CbIEMIMstC9UWk6FDxCk0dGyC201pPFEhD+PyC3AIxmH57OsiGljS7kwqW3QOwjCrew7/LdqPT7svSnHDLZui2jLWLpWnuAd69vgAjvOnUeb8G2JsczTe28ZuNtFT0iFfjcB7PqK+xIP6a1RamZG3EbIBRu3o4tkT3PIiXXaSX2e/FWLAd8FF023VvTj6dw63vrwOR1a9L/etHEFe9cyxvhHkliboU6y+Qwxv8BSTklyuAxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tO3FgzNxyc5S8sl0ZAZ1cxvnNZBHila28w0PAi+s9Y=;
 b=abCwziKCGEVKXByJOlXrOfqm+pTivJwRryXfWwm63+x4Vi4RPAKRROFcCQ3b3ZodbMZzAGOJAX5vUzcIVeNQFJVYwPZLmSVNTh2zTouTif32N4mF6RreU1qxVwyvNgyB51SyueZtpjN8vhIvgwR1cf8z3IWtzUVf7XSfBWPhDwo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 07:20:31 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 07:20:31 +0000
Message-ID: <32163f49-8387-0754-534f-1764e731f26d@amd.com>
Date:   Thu, 14 Dec 2023 12:50:21 +0530
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
 <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
 <20231214070746.GS1074920@black.fi.intel.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20231214070746.GS1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0229.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::11) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|BL1PR12MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a9bc99-df2a-4ae3-63d7-08dbfc752792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxIgjAf3KzA0i5Efmp/88xBC2uRwCczLA9CDgHDZHgMk5iPq1gwJ7ePFixk+st63OoUXnMWHixa31TPP3ve9/dNFxNji0H7QBhq6q4Jid4p6MgSopsTldk7nbgCJTwzBeGeTw6g1uTgcFs7/00CV7UmC03FxuyDgc3C+L5OGnkIVRgyItXpSWHqfbx6bWp76qV5zaJxJgRVHk0exekGMW2vuqFzKIRlOOwJwoirJWDzAOnMRThtKR7xp0WOMCHaVr19Hvpntz7g2t+DN3lwhcrHKUmZh3MyyNSdz/+MdFb3XOqji85UJxcXGoYwfkFUWoBVitRaUlIqAIUHew9BrLWsWLt3Zz9vAB2/EPwy5bDp50eFnGl26yK28QdSNbV4KoflzcBqhVAMmb6FzVJVSWz4IyOaRtINFn+E4nAsQOLd4ag2fD/SJCUzITk05CsUaCuvCT2gK7vGOWZMoy0nfzFD3wzRj7vYuaHiE+7UPK9PzX9geVkF5YqnYQ5cnSYoWigZMK/3ZWlQ+as5zznTSDUa/i2ZhqKRrB0Wi/UZcvLtLIsCzAb+YKLMfwfu81rOe2h1AG09iIbTODkrwLLkwddDtpqoK6fZMXJ8HMPScS9SHtTBdNLAeTzjxfHn25QnASZiGsLLjgTbWoC5K5H9+ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(38100700002)(5660300002)(6512007)(478600001)(66556008)(66476007)(316002)(6916009)(6486002)(66946007)(6666004)(31696002)(8936002)(8676002)(4326008)(6506007)(53546011)(26005)(66574015)(83380400001)(36756003)(2616005)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHl4SngzUG5BQXM5WndhSC9kWHRvMlB0RzdOdVUwYTRhMURDTFNDT0Fldkc0?=
 =?utf-8?B?QmY1VTJxdnliVm10ODlDWGNTLzluR0JFT2U2NHhzSUVxcFVXaDhlRWgrcWNF?=
 =?utf-8?B?NlErbXdpNlhCcjRYSTZjdElZaWFqa1RtNldzWTdaSUhjcXdubWtyRFloSW9v?=
 =?utf-8?B?NXZWOUNoaFVrWHpLOWd1VEVySVcrUzd1bUJWaTM0VlJVVkw5RmpSQjNGVWZx?=
 =?utf-8?B?LzhJSitNd0hPNmNmdnhHM09iK2w1THZ3eWN0UG9oUkR5S00xMzZXR3hSZkxD?=
 =?utf-8?B?QXFZbzNJUkxSdE1oRklUMmh6RHJKZ0QxV3dkZWZKNEVqNUFPemFHdXRFOVBP?=
 =?utf-8?B?Rkhpa2hPMEJ3VWJpMGRTSGc5VithaWRpdjBINExyYUxjTHZ0dHVBNE5FUEVC?=
 =?utf-8?B?bTJzODJFdnRYeGIvdWlqQ1NqVzgwMURabTcrQi9jL2c3VWltUnRWRmFYQWU2?=
 =?utf-8?B?ZmNvUWU1VTdydnI0OE1vSlFsaXNRZUpvbENLeDZydzY2UHoydlNEUUs3K2R3?=
 =?utf-8?B?V0Q0ZjI5Z1d3aWg1Y1JYSFB4aElxejhkRHRVeklhU1JmYUZxNGUzNDFIcWZ5?=
 =?utf-8?B?QkJiTlg4NHlzTTJ4c1BTY1Q5SkxmRkl4OC9wOXY3MnZHWm9Lb2xJNWMzcTdh?=
 =?utf-8?B?WGhlVWxKSjdLOXlJYUpNV0IwOFVoUnJTbWJGU25SMmdCeWZCampIUFdJTURS?=
 =?utf-8?B?WjZxY0lweGhxYmJ4OXI1Qys1TDg5M1FzN01tUThnSElYOTBtVjhZUmhOTnVZ?=
 =?utf-8?B?UVg0UUNpY1V3MlBKYTJFRklxTkxWcDNnZnpFQ1BYbHNTdndqSHFJNjd5a2d6?=
 =?utf-8?B?YzZyRU50dnJZVzEyVk5WMEtDWktwY2dGV1l0aXY1T21EMWFzRmxwUEhjSkU3?=
 =?utf-8?B?dlVxaW9DcTNINWZSTC9UOUJiVm90N3ZiUGxudUh6RjNmaG5pVStWaHEybjNG?=
 =?utf-8?B?NDZ3TlpZcnhNYStsZEdYdVAvR0Zlc2pFVGtKRkZHMW5JRkx2MUUyOVFZTUxo?=
 =?utf-8?B?M1FMeHp4OFpjaG8wRmNIREhVQnkxcmkzK1NmSUVEeGZVYzEwdWtpeDVmM3Jk?=
 =?utf-8?B?bDJWSEJHSlFiQk1tbG5GdWhmV1hSQjVXYWp3QmtkUnk1cWN0QTNJUUllMWxS?=
 =?utf-8?B?WldYMktBaHI0L0FGcVdRa2E3cXRyZlZKM052K2t1Wk5ndlU0VnJFS1Z4VzFh?=
 =?utf-8?B?dFVvZUpFRHovSml2OEw3d2gwWnFlWE85b3paK3c2Z1JYVklzdVZUWUJwckUz?=
 =?utf-8?B?U3FyVHhES3c3dGpsTHRKOFQ4TDV0QjczTzFpS1lrVDRyKy83SUZhOTI3Sk5Z?=
 =?utf-8?B?N01UUHlSREN0U2hKUUpDSXBTZGFybnlEVmI0NW1TTU52K241UTFDNytRRUxP?=
 =?utf-8?B?cE1LYm02elZBU0ZURkIwdjliWGtNVmovdEZNamFMbHNuNUhJbExYV1JlbVd0?=
 =?utf-8?B?T1RwUWJPYVIvTFowNFcrL1ZJNHVQS2dNamxSYlZYMHBLbU1XU2tBMTZ1L0ZP?=
 =?utf-8?B?dEVvY3hBcXZ0QzhSc0t3N01Tc2YxajhPcTFnTVlLejFNRDcyZ2kyTUxHMzI4?=
 =?utf-8?B?QjV4c3QrdTVvdjVKcWhoZkdaVVJodGQyWUxSMGtTWjlsbEZNTnlZZHhZWDVR?=
 =?utf-8?B?T0ltY3B5OE9HU0ZPL0Vsb1NaWFY5RzBmcnhYbTVCOFNET2JnRVVvS3JyeHdy?=
 =?utf-8?B?d0dnd2RZdHZIbExwQ0pnZThQMzhyeThHZDMvdUlmNzAyd0VmS2FrektmVnhy?=
 =?utf-8?B?YW9GaUVoY0ljcCtiQkJiQWpkNW5xR3Vrb0FwazVMaE1SeHR0NEJtYm53S3kv?=
 =?utf-8?B?N1RJdmdueWRLU1FQNEZRY0s0d3lEUGVrMUtxdUszdWJMbTMzZjljNVExdWpO?=
 =?utf-8?B?aTlJOHhvOS81MlBQVGJvbDROcEM3SVZSSU5BeFl0RWJSc25mZ0ZFbkF3b0tN?=
 =?utf-8?B?c3FIK2xUdG9oOTJERTB4U2xIbi9CUEY4RFZldFk0NUowbzNaZzUyK2xIU05l?=
 =?utf-8?B?NlJyZk91RWxTU3VXVzdVVTZVMjZBVXFTOUFuUzZQclhRUzQ5anJmSzZtQ0JO?=
 =?utf-8?B?WGladWtWaTlhTWVPcndXVGU4cUVWWDRSem1DWEo3OW8rR2wwVWk2emM0bmF3?=
 =?utf-8?Q?hFfl7p7u6FV9fVzj/XcQMHOys?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a9bc99-df2a-4ae3-63d7-08dbfc752792
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 07:20:31.1595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlpcTTNEw8ncMTmNU8mSG4p3hyWV84g5WMqm7bo9CiV2gbmetHSE9veHYzP3D4+nXPZqQJ7uTpOmBFW4copIsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
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


On 12/14/2023 12:37 PM, Mika Westerberg wrote:
> On Thu, Dec 14, 2023 at 12:08:34PM +0530, Sanath S wrote:
>> On 12/13/2023 5:22 PM, Mika Westerberg wrote:
>>> On Wed, Dec 13, 2023 at 04:04:57PM +0530, Sanath S wrote:
>>>> On 12/13/2023 11:53 AM, Mika Westerberg wrote:
>>>>> On Wed, Dec 13, 2023 at 08:18:06AM +0200, Mika Westerberg wrote:
>>>>>> On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
>>>>>>> On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
>>>>>>>> Boot firmware might have created tunnels of its own. Since we cannot
>>>>>>>> be sure they are usable for us. Tear them down and reset the ports
>>>>>>>> to handle it as a new hotplug for USB3 routers.
>>>>>>>>
>>>>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/thunderbolt/tb.c | 11 +++++++++++
>>>>>>>>     1 file changed, 11 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>>>>>>> index fd49f86e0353..febd0b6972e3 100644
>>>>>>>> --- a/drivers/thunderbolt/tb.c
>>>>>>>> +++ b/drivers/thunderbolt/tb.c
>>>>>>>> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>>>>>>>>     	tb_switch_tmu_enable(tb->root_switch);
>>>>>>>>     	/* Full scan to discover devices added before the driver was loaded. */
>>>>>>>>     	tb_scan_switch(tb->root_switch);
>>>>>>>> +	/*
>>>>>>>> +	 * Boot firmware might have created tunnels of its own. Since we cannot
>>>>>>>> +	 * be sure they are usable for us, Tear them down and reset the ports
>>>>>>>> +	 * to handle it as new hotplug for USB4 routers.
>>>>>>>> +	 */
>>>>>>>> +	if (tb_switch_is_usb4(tb->root_switch)) {
>>>>>>>> +		tb_switch_discover_tunnels(tb->root_switch,
>>>>>>>> +					   &tcm->tunnel_list, false);
>>>>>>> Why this is needed?
>>>>>>>
>>>>>>> It should be enough, to do simply something like this:
>>>>>>>
>>>>>>> 	if (tb_switch_is_usb4(tb->root_switch))
>>>>>>> 		tb_switch_reset(tb->root_switch);
>>>> If we don't tear down of tunnels before performing the DPR, the PCIe
>>>> enumeration is failing.
>>>>
>>>> PCIe link is not coming up after DPR. Below log is missing without
>>>> performing path
>>>> deactivation before performing DPR and hence PCIe enumeration is not
>>>> initiated.
>>>>
>>>> [  746.630865] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>>>> [  746.630885] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>>>>
>>>> I think when we do a DPR, it internally does some handling with PCI Path
>>>> Enable bit(PE).
>>>> So, deactivation of PCIe path is necessary for DPR to work.
>>> Rigth, it should be enough to reset the protocol adapter config and path
>>> config spaces. I guess using discovery at this point is fine too but I
>>> would at least check how complex doing the minimal "reset" turns out.
>>>
>>> I mean in tb_switch_reset() for USB4 v1 routers it can go over all the
>>> adapters and perform "cleanup" or so.
>> I gave it a thought yesterday and we can do something like this:
>>
>> We are already doing tb_discovery(tb) in tb_start. This would
>> discover the path configuration done by Boot firmware.
>>
>> Now, we can place the tb_switch_reset() right below that api with
>> conditions suggested by you.
>>
>> And tb_switch_reset() would internally DPR for all down steam ports.
>>
>> It can look something like below:
>>
>>      /* Find out tunnels created by the boot firmware */
>>          tb_discover_tunnels(tb);
>>      /*
>>       * Reset USB4 v1 host router to get rid of possible tunnels the
>>       * boot firmware created. This makes sure all the tunnels are
>>       * created by us and thus have known configuration.
>>       *
>>       * For USB4 v2 and beyond we do this in nhi_reset() using the
>>       * host router reset interface.
>>       */
>>      if (host_reset && usb4_switch_version(tb->root_switch) == 1)
>>          tb_switch_reset(tb->root_switch);
>>
>> With this, we are making sure while we get a unplug event after doing a DPR,
>> We are clearing all the paths established by Boot firmware. This wouldn't be
>> possible
>> if we had not discovered the paths before we perform DPR.
>>
>> It would create inconsistency for a new hot plug if we have not cleared the
>> path configurations
>> of previous hot unplug events.
> Right. I would still check if doing protocol adapter "reset" + path
> config space clear in tb_switch_reset() is enough and how complex that
> ends up to be. I think that's all what is needed.
>
> If it turns out too complex, yes I guess something like this:
>
> 	/* Find out tunnels created by the boot firmware */
> 	tb_discover_tunnels(tb);
> 	/* Add DP resources from the DP tunnels created by the boot firmware */
> 	tb_discover_dp_resources(tb);
>
> 	if (host_reset && usb4_switch_version(tb->root_switch) == 1) {
> 		struct tb_tunnel *n, *tunnel;
>
> 		list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
> 			tb_deactivate_and_free_tunnel(tunnel);
>
> 		tb_switch_reset(tb->root_switch);
> 	}
>
> With proper comments would work, no?
Yes, this works. Tested it too and works fine.
Probably we can move tb_deactivate_and_free_tunnel() inside 
tb_switch_reset() to make it
look better.
> Regarding "host_reset", I think we can actually keep it in nhi.c and add
> a parameter to cm_ops->start(reset) that gets passed to the "CM
> implementation". Or something along those lines.
I will check along these lines.
>>>>>> Actually this needs to be done only for USB4 v1 routers since we already
>>>>>> reset USB4 v2 hosts so something like:
>>>>>>
>>>>>> 	/*
>>>>>> 	 * Reset USB4 v1 host router to get rid of possible tunnels the
>>>>>> 	 * boot firmware created. This makes sure all the tunnels are
>>>>>> 	 * created by us and thus have known configuration.
>>>>>> 	 *
>>>>>> 	 * For USB4 v2 and beyond we do this in nhi_reset() using the
>>>>>> 	 * host router reset interface.
>>>>>> 	 */
>>>>>> 	if (usb4_switch_version(tb->root_switch) == 1)
>>>>>> 		tb_switch_reset(tb->root_switch);
>>>>>>
>>>>>> (possibly add similar comment to the nhi_reset() to refer this one).
>>>>> Oh, and would it be possible to tie this with the "host_reset" parameter
>>>>> too somehow? I guess it could be moved to "tb.c" and "tb.h" and then
>>>>> check it from nhi.c as already done and then here so this would become:
>>>>>
>>>>>     	if (host_reset && usb4_switch_version(tb->root_switch) == 1)
>>>>>     		tb_switch_reset(tb->root_switch);
>>>> Is host_reset necessary for USB4 v1 routers ? I did not use host_reset in
>>>> this case.
>>>> If its needed, then we have to modify to enable host_reset in nhi.c as well.
>>> Well you are effectively doing that here, no? You "reset" the host
>>> router therefore tying this to the same command line parameter makes
>>> sense and allows user an "escape hatch" if this turns out breaking
>>> things.
