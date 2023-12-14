Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7DB8134D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573832AbjLNPau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573801AbjLNPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:30:38 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE01115;
        Thu, 14 Dec 2023 07:30:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSHLdwM9qniW8/MMLSxLOpmx6lk4lecz5kQzevl76cFWVLF+AZwSgUjAC7ACiGhtTqTpKnxgPyHau3ZZhGWycsibe1/Wis3kzgAyFb4OvE/zGZHsMa/4gbulQpqetpJcjuglN1p0MM+c5CmpaHA5JIw2yuq52XGtSxMc4L8bWMj6tmT62ij3cBjpCQ+5sfR7kGEdACFR/pyazLrffcVV1TE3KNbgzfwzS+79ASDOoeiQlokJTQkuj4utNgGFN3cOGgdMiO1HrfJjL18YKHdT1rSqfCBKnQTsCCicIDfTqZFppV8ps4AzKLSmJIt+mF3767rf5hgLDcshHIFwroPe2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkNwV7uwD/tAyz7NKE8wrbDGqzUiKHU4I23hpdde97I=;
 b=RL/w33YjfwXC/tlQ9Tkf9D02BJDsW4pNhZqJOs2ZYe4QCuWs83LQHdZuhO1q8j80L8ZS+8JJ7Cqu7doXjLl/V74gBrTvi40pTf+0rLB65/SpE7JqWLD+CVUaM2D3RA6LGHEoEUbdidARrCQ5aszVKoxLB8bjoH4IRZKNAhz0WR2cmdeeMoGl5lRvlqVQ969dZRQkxeFf/xybrI3rqgdGpq/M2Pu8TLGEuY5Nb38CYfloPyQIp+3R3gnKpklSxPbHNNmZOggrXR1VTyDM2zIvs2LC09AL6l3bCNLMlwH2VvnZvsdZP3BURnP2XT5wl8F05cAM//wAb8LbW2K51IoJJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkNwV7uwD/tAyz7NKE8wrbDGqzUiKHU4I23hpdde97I=;
 b=UWwALhXUFhsjmvrHtR53Id2ufp0jqKMClav23hUnQxtFpcWOlcWnHTYkij/EEk8Z3jblGhxSXJyU328DmdqduDR4F0YPTQ6XtFVbqkR9GbaKZPeLrrJ9riLm5buue5e0wmPCmt0lgr7sZEfxKDmRy1W8iIEjK40hJ9mVchoOhyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 15:30:37 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 15:30:37 +0000
Message-ID: <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
Date:   Thu, 14 Dec 2023 21:00:29 +0530
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
 <32163f49-8387-0754-534f-1764e731f26d@amd.com>
 <20231214073242.GT1074920@black.fi.intel.com>
From:   Sanath S <sanaths2@amd.com>
In-Reply-To: <20231214073242.GT1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::19) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 281055e1-c7ac-4088-cf6b-08dbfcb99f5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 521zsfxF/waMYT5bRBJO8KjweTVZc7DP4kLrGh5HRCrIbiUGoJmdaIQMm7qbUustuyYpbE1/+LST2lHpgMTe5FTW4BwYl/5BJuu+XvxHObS1rI2/OBTJgkDHfyn1i61KXmx6GgeGY/3Rwwts7DpSVGfNMhcvFh8R/XAdNfY+a99bGwHCPSwh8g6DO5e6miCmIxygO+hscTIyvcxJ5BEes2M7KjNHeZfqEfl6/dM1vifOW+RfPXsqGtsCpnZCczQqBXFWm0gCn7O4xKmjc8P+BZ191RP8glqutgaM/dci+SKcTQ46A/wmJ8m0JRUMOWbFmxsK4y0FV8XtpY5n/NPf728zltv5UcexmUBedybmg0OgLamIv8Xux1sV6Zv+kkIcn54XzZuzPbUyz2gHcAnk8hjdWwLoeD49AtLAemZxNnxOfdAJHH6xtYmPrlYKV8tfC5DU05pAcJzesVUV7b3VGJlVQh92slxKdGY+C/yVXtCF/xmotdl9/KOmCkPgt/vdGFr2FyLfy/N0A1RbCnapxt9dnRU/0z8PxLWSD4f/ppfr9bEsOLeN/AfyNEyTrvjPdQsO+I967ZY5deQKxHs8I86A4Csc92xhmTGrMYf20Lnc5G0R4JwSgEjEwQ4ktRLHQ34b0Wi89cy0ZYXYS264Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2616005)(26005)(6506007)(6512007)(6666004)(83380400001)(53546011)(5660300002)(4326008)(8676002)(8936002)(66476007)(41300700001)(2906002)(6486002)(478600001)(316002)(6916009)(66946007)(66556008)(31696002)(36756003)(38100700002)(66574015)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnI4M3l6UWR0OGhTSVp2UkIxTlZCL0VGZGN4c2ViaUFkN1VZa3MvU04vS3FM?=
 =?utf-8?B?a2l1SG8xRlFsdDdCYUdlc3h0bUlobmphZFAvZlVzdGhncmxJNlRraVE0Y002?=
 =?utf-8?B?VUZUd1lWeVBwM0NSQ1c2Nk5kSDlEYmRpanoxT2JYb2FYZENIdEtuMVNvUWJv?=
 =?utf-8?B?WWgycUNxUVkrdUVkOG10QnBhakhFcm1ZK1ZtcjVxUXlWbVgvSHdmNElCeEVt?=
 =?utf-8?B?VVBqOVl1STlLRENzYUVlSzN6ZDJnOVczU01IdWlBTWJVdFg3QTdKeEtNMGNR?=
 =?utf-8?B?SVJ6WW5Oams0SkorY3N0djhaWXpUZVlFTm43eG85MURnM011bHBUZ1J0Z3No?=
 =?utf-8?B?WDhwNWp3UnFVL00yTFZKZXVMVk9Icm5rQUIvZEh2RHA1cVE3ZVRKeWdhbEUx?=
 =?utf-8?B?cnFLMmMyRHlLWEV1TWYxUDd5VmdXNWQybUpqSUNXdW5oSXNzVGEvN2hzdDU2?=
 =?utf-8?B?R01pcDlaWHUxTVdCYXNyZXJlZlZXTXRrZEhBNzdWblgxY2lGUTVUNzVSdW9k?=
 =?utf-8?B?K2hVOFJha1cyWXNxUjFMTmh6ZTNQSXNNbVNXU3owYXo1SVp5bjZnOGFVTkI0?=
 =?utf-8?B?RlNjbWRwQkt3VzVPak5UNm5pc1diZ0ZCSzhHVXFKczNINW1ZRFd4anZvMXg1?=
 =?utf-8?B?TnI2Zlk1TU1jbGlTY3hwbG5sQXZjREZNWlZEUEtUMTlQWlBBNWhaanpVS0c5?=
 =?utf-8?B?UW82eVVndDhqUFdLc2lTWnJHS3hXUWQ2cVQzUVlwR2pVN1lvaTB5TEpRa0pB?=
 =?utf-8?B?KzgycjBYdzFGdmVYekg5SktiRzhDOTc1RlNObUZxVlpIVlR0RW9Za3RGY2kz?=
 =?utf-8?B?dE4rWC9LUFNTbUtDVGRmRzVyVEYwbVRRVjlBM0lYNStoTjlkTFBHUE9Ta0pi?=
 =?utf-8?B?NVRMWjcrSFM1MTY1eE1NT2dNYjAwY2EwWno4YU00aUR6OVI4WTh6QWxER2FX?=
 =?utf-8?B?M3FCdkZoY2pvb2puSUk0OTY5NE1LTGhQSEg2RGwrL3FGN3pkUGNFMVg0ZmZv?=
 =?utf-8?B?YlZaM29sMmx6ZHRGL28vUUNSZHByTWhnL2RjdmgvK200Y25PMWNDdWZuS2cz?=
 =?utf-8?B?cFNqYjhEbU9xRFpJaS9FWEltb0doL3hzcitOeDBUOGNuMlVQVkw1UHM2dmFV?=
 =?utf-8?B?T3ZQR3RmSEIva09MY1Z2d1ltWmM5b3IvUUlmbUhrTEFrS1o1T1ZzelZZQ25L?=
 =?utf-8?B?aE14UnUzYmdGeWlLUkE4SkxlRzRKMlgraHdNSWZ0SEN1SDFzLzFqdk9NS1A5?=
 =?utf-8?B?QXlITWZvSjV3RUpXV0Rwdk9PTWVNNDhISXozbW84bU1JU1JJNHFuRVlWZW1S?=
 =?utf-8?B?SjU2Q1htbGQ0Uitzd3lDMS81clMrbHM1Q3hoaWFHTEtGSWdzVkxEOGhPNDBp?=
 =?utf-8?B?b2JqVndROUx2Z2NBMkNTRkpjL2p2NFBRTkpUcWx4bWJrUVAvTklRdVJtd0ow?=
 =?utf-8?B?ZnZpTlFXY0JWaG03aEN2bm4xNVRRWGZKc3RTLzVIU3pFRGhITTN0d1NYelk5?=
 =?utf-8?B?Mll4bnhEUjdCZFNEZ1ZpZ3l0WFpTdEk5bHEvVTlwSW9idXVVOFdxRC90VFV4?=
 =?utf-8?B?ZGpOT3Q5a0hRSTlSZmxjRk5pWmVCYmlpWE1kdldFQ1ZZM05yT0pHUzBQRVIr?=
 =?utf-8?B?QWJqeGk4cEdBd1Y2UEdxR0lPSms1MVQwTGx0ZFBVMGtFUzRnTHFjaWFkQnRh?=
 =?utf-8?B?SjdxZWQrazdIbVZpYUN2RDZGZUVIbUpxWFphU3ZXUDdlNUR3TFpkU1pFOHpO?=
 =?utf-8?B?VzY1M0p0SUs1VmU5ZGhEeFBub2hpR0w1YnhOeDlnbzdMVHNSRUpTaWZ5Smxl?=
 =?utf-8?B?UDg2Y3lsMGhGdVFMOVN3aXdxTitOT3BhVTdZaStGSmwvZEVHcHVIalo1YlUr?=
 =?utf-8?B?dEVHMHMySjhBU1pXTyt0V2xnZ2wyUG5CN2lJNmdITmFLSkg5cGtLQlhsNWFs?=
 =?utf-8?B?OTU3L1V0NGNvcUM4OVFGdm52QitjQUF4ck5DM3pUTmxvVnVocEJnT0k0Tk1R?=
 =?utf-8?B?YjZjcW54Smk0NlJiWG04L05oTVZXLzc1a2pWcm56STlHZ05RNTdpNlF5SEZj?=
 =?utf-8?B?b1VZVVR3dnNyeGY0K1Avb2NzSXYrMmhHeGtla1Y3RkhianVESmpIdmlxa2dP?=
 =?utf-8?Q?+p5QxzbSVm7xxSiDCXvGryJGu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281055e1-c7ac-4088-cf6b-08dbfcb99f5d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 15:30:37.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLswWPrCI2hk6uJcjYgVXD6mfRn2vZlHicpteN9xiDBQWjCmLqufjX5hXPPoGa8/9/VbDn4Qa69nJ6578JrAKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/14/2023 1:02 PM, Mika Westerberg wrote:
> On Thu, Dec 14, 2023 at 12:50:21PM +0530, Sanath S wrote:
>> On 12/14/2023 12:37 PM, Mika Westerberg wrote:
>>> On Thu, Dec 14, 2023 at 12:08:34PM +0530, Sanath S wrote:
>>>> On 12/13/2023 5:22 PM, Mika Westerberg wrote:
>>>>> On Wed, Dec 13, 2023 at 04:04:57PM +0530, Sanath S wrote:
>>>>>> On 12/13/2023 11:53 AM, Mika Westerberg wrote:
>>>>>>> On Wed, Dec 13, 2023 at 08:18:06AM +0200, Mika Westerberg wrote:
>>>>>>>> On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
>>>>>>>>> On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
>>>>>>>>>> Boot firmware might have created tunnels of its own. Since we cannot
>>>>>>>>>> be sure they are usable for us. Tear them down and reset the ports
>>>>>>>>>> to handle it as a new hotplug for USB3 routers.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>>> Signed-off-by: Sanath S <Sanath.S@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>      drivers/thunderbolt/tb.c | 11 +++++++++++
>>>>>>>>>>      1 file changed, 11 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>>>>>>>>> index fd49f86e0353..febd0b6972e3 100644
>>>>>>>>>> --- a/drivers/thunderbolt/tb.c
>>>>>>>>>> +++ b/drivers/thunderbolt/tb.c
>>>>>>>>>> @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
>>>>>>>>>>      	tb_switch_tmu_enable(tb->root_switch);
>>>>>>>>>>      	/* Full scan to discover devices added before the driver was loaded. */
>>>>>>>>>>      	tb_scan_switch(tb->root_switch);
>>>>>>>>>> +	/*
>>>>>>>>>> +	 * Boot firmware might have created tunnels of its own. Since we cannot
>>>>>>>>>> +	 * be sure they are usable for us, Tear them down and reset the ports
>>>>>>>>>> +	 * to handle it as new hotplug for USB4 routers.
>>>>>>>>>> +	 */
>>>>>>>>>> +	if (tb_switch_is_usb4(tb->root_switch)) {
>>>>>>>>>> +		tb_switch_discover_tunnels(tb->root_switch,
>>>>>>>>>> +					   &tcm->tunnel_list, false);
>>>>>>>>> Why this is needed?
>>>>>>>>>
>>>>>>>>> It should be enough, to do simply something like this:
>>>>>>>>>
>>>>>>>>> 	if (tb_switch_is_usb4(tb->root_switch))
>>>>>>>>> 		tb_switch_reset(tb->root_switch);
>>>>>> If we don't tear down of tunnels before performing the DPR, the PCIe
>>>>>> enumeration is failing.
>>>>>>
>>>>>> PCIe link is not coming up after DPR. Below log is missing without
>>>>>> performing path
>>>>>> deactivation before performing DPR and hence PCIe enumeration is not
>>>>>> initiated.
>>>>>>
>>>>>> [  746.630865] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>>>>>> [  746.630885] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>>>>>>
>>>>>> I think when we do a DPR, it internally does some handling with PCI Path
>>>>>> Enable bit(PE).
>>>>>> So, deactivation of PCIe path is necessary for DPR to work.
>>>>> Rigth, it should be enough to reset the protocol adapter config and path
>>>>> config spaces. I guess using discovery at this point is fine too but I
>>>>> would at least check how complex doing the minimal "reset" turns out.
>>>>>
>>>>> I mean in tb_switch_reset() for USB4 v1 routers it can go over all the
>>>>> adapters and perform "cleanup" or so.
>>>> I gave it a thought yesterday and we can do something like this:
>>>>
>>>> We are already doing tb_discovery(tb) in tb_start. This would
>>>> discover the path configuration done by Boot firmware.
>>>>
>>>> Now, we can place the tb_switch_reset() right below that api with
>>>> conditions suggested by you.
>>>>
>>>> And tb_switch_reset() would internally DPR for all down steam ports.
>>>>
>>>> It can look something like below:
>>>>
>>>>       /* Find out tunnels created by the boot firmware */
>>>>           tb_discover_tunnels(tb);
>>>>       /*
>>>>        * Reset USB4 v1 host router to get rid of possible tunnels the
>>>>        * boot firmware created. This makes sure all the tunnels are
>>>>        * created by us and thus have known configuration.
>>>>        *
>>>>        * For USB4 v2 and beyond we do this in nhi_reset() using the
>>>>        * host router reset interface.
>>>>        */
>>>>       if (host_reset && usb4_switch_version(tb->root_switch) == 1)
>>>>           tb_switch_reset(tb->root_switch);
>>>>
>>>> With this, we are making sure while we get a unplug event after doing a DPR,
>>>> We are clearing all the paths established by Boot firmware. This wouldn't be
>>>> possible
>>>> if we had not discovered the paths before we perform DPR.
>>>>
>>>> It would create inconsistency for a new hot plug if we have not cleared the
>>>> path configurations
>>>> of previous hot unplug events.
>>> Right. I would still check if doing protocol adapter "reset" + path
>>> config space clear in tb_switch_reset() is enough and how complex that
>>> ends up to be. I think that's all what is needed.
>>>
>>> If it turns out too complex, yes I guess something like this:
>>>
>>> 	/* Find out tunnels created by the boot firmware */
>>> 	tb_discover_tunnels(tb);
>>> 	/* Add DP resources from the DP tunnels created by the boot firmware */
>>> 	tb_discover_dp_resources(tb);
>>>
>>> 	if (host_reset && usb4_switch_version(tb->root_switch) == 1) {
>>> 		struct tb_tunnel *n, *tunnel;
>>>
>>> 		list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
>>> 			tb_deactivate_and_free_tunnel(tunnel);
>>>
>>> 		tb_switch_reset(tb->root_switch);
>>> 	}
>>>
>>> With proper comments would work, no?
>> Yes, this works. Tested it too and works fine.
> Cool.
>
>> Probably we can move tb_deactivate_and_free_tunnel() inside
>> tb_switch_reset() to make it
>> look better.
> Unfortunately that's not possible because tb_switch_reset() lives in
> switch.s (and should live there) and tb_deactivate_and_free_tunnel() is
> part of tb.c (as should be). This is actually why I would like to try
> the "reset" protocol adapters + their path config spaces in
> tb_switch_reset() as then that would work with any router and does not
> need to have any knowledge about tunnels or tb.c internals.
Ok.
To perform a protocol adapter reset we would require upstream and downstream
adapter ports. So that we can use tb_port_write() set the 
ADP_PCIE_CS_0.Path Enable bits.
Challenge here is to get the upstream port without discovering. I'll 
think more on this line
if its possible to reset the protocol adapters and its path.

If you have any reference here or any idea already in mind, let me know, 
I can give it a try :)
