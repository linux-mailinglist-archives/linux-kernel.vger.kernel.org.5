Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35427BD2A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 06:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjJIExq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 00:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjJIExo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 00:53:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71038A6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 21:53:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkwOtHr41daTNIVTq9r/5vIBpkC1Nb1PxdwV4saA83qPYZnBMkvW6YM8jVDMeIxQ7vBGDOig0Qom6MMZPaZ3OrcMc/Yy1XyGUcBHM6mkAVokQujDqH+DKB+ZAgYhCyRDh+vsB6vKxuT7/kcFVcSOMrCq4PxqDxZi58MfgPFo0aIKvfd8LAgw2v46eBQ3MTBz0nWGL9ux/Jj97+Xk8AM0fEMPAYdRTl89fVcDAyCcp8eRZFSP9tcJZZLj/k//hcahAgsdN3H3DH8V3a5wwruA8uUjMaBsmGjb88mKpPTMktlAY7olZNJoBMXZe14LuSI0H1NhZ6JFYGXuyjFADAYwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4WJ4XaHjgsnNRsO4Yf5tYvxKHGMWcJvcOffbYlbYDo=;
 b=dKvanN5pVdn7Sj37qegwubczWmitQFsWfBF+hkeiWp5tjpCH5RBnG+dg90SYO/0REx3jJNsvee94r0LzF7M4ylWB0Z5/PfDVco8rTYk6wscEDLbKemOWFCU88ABUArAl9CfmKhkxtkTo1YlCagk2+0f9sFFwN3NEKcbuUb+sMZrWg8VIcYcora9K7EL8SEmyU/54mRMrYfU1eFvTJmt6InIwJHr6wQuOmIn7oDrWP6BZTUWfPv/IbkqkFB+cqU1zNIxKCYcagO7oevBpBDdSSUndtbufEOnXl05lm7sVTnhBu1RrqtKtDwW6lpcBC9EEnRm2/lX2pKmIO4vkf5wx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4WJ4XaHjgsnNRsO4Yf5tYvxKHGMWcJvcOffbYlbYDo=;
 b=dBpE0VjvQqDyJHQRZWDHWUsWz3KsuMYA1XC9LnuKIEID7RcGWNiECFiO/vGCu4zrldHqSmd/wHT+VfxHnlPRWZinUZxYlDvLgdIuLo0hmq56rddkltSYLT7/6nxSXlYTYeIbR87uyj+nILQYTqtX9M/48rS5gmLWtWFkQGB2j8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 04:53:38 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 04:53:36 +0000
Message-ID: <5f093f2a-6f3f-dc09-ec62-a7e793ffbe7a@amd.com>
Date:   Mon, 9 Oct 2023 10:23:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
 <5388fa5c-a4e7-6a51-c363-1a0da75b163a@amd.com>
 <2023100705-tummy-salami-477e@gregkh>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023100705-tummy-salami-477e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::29) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ba4d2d-8fb2-4569-9f3d-08dbc883b240
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Qzmua+vziQ+jT6fGDO7Pcxbs+tMsxq2fPh5RiW+D83jYxTGIT+KLDckLdYTm5ey2iQHMTcPejZudqWXJI+DIraAmQdgBb4agR4eo/ObORD2BwJpPYMFP5xK9O7+j1OtmHL3butFvzhLAzm8os3Tm32md4aC79dyNvnmAOE5Y0B8bGGYERMyOqXmAyL5W+Jb3biQ1ZGo+bgn40aPFihzE9HtZ5t6mkXqTIDNHBgUZbdHH3c9cmhEXWXE02d8P0Fg6YpLv2yKhBuNmlh2Xi1F6BDlkjSQXADqoMGgZYSmBIn+nNo3RujJIieHu2HWx4q6Nn3qe0dEJxsu2/1cUrnK++sSkjg2oyCDYDILomZSk3AdYgi395aR4ilrow5ELlhiDZhGgh/kzDIbNKXLt+wqgN1TtkpYnjjg0Yriuq4jz9SUm26b64nJB2kFYstwtEvGaOd5L3WJZgcyT/On6QOIaEG0rGjyKtEKVCGITMS+GjRo3+l/eXralkGPPMFAkjEvVPYAfAH2SJJS+3sIhKHQRebilip1yJBfYj2Ul9sxsQSyYUE3whDejaFnvH1ktmzJg7PVdCvy4eZSHo5gzz7xAGMoMuxbyJXr7i8fWKnOG+l5BitLvE2MlcLn6/Y2TVbMzXs1RPBE+MN5LgsuU7DJVl7y0u57aKR1qg26lc0Cf0sh3NdAtvu2dZ1+JBgbtH4G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31696002)(38100700002)(86362001)(36756003)(31686004)(2906002)(6512007)(478600001)(6486002)(41300700001)(8936002)(5660300002)(4326008)(8676002)(6666004)(53546011)(6506007)(83380400001)(2616005)(66556008)(66476007)(316002)(66946007)(6916009)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFJ3WkJ5YTBSRnNkUnJ0WldTVjFQRzVidFN3dUc4SnQvcHY4d1V2YmZIWFRZ?=
 =?utf-8?B?Wi9FZ21YbnRMamFHQ28ramhacVJRYkw0aFE5OHg1Uzh5S05YRlNlcktXaVlu?=
 =?utf-8?B?Z3JtSWh3TXVpQVl6blBKcWNTQzJPdlcrdHlFOTJSTm5ycG5GQUMxME9UT0ln?=
 =?utf-8?B?cWdFRUNpNmpLS0g3K0QwMW54UzlFRm5acWZhWVI4K1ZJdGJhbnRIcCt0cStk?=
 =?utf-8?B?TW16TE5RaXFGVHZjKzdaSXhHZ1R3S2ZCU0x0QnBvWWZOWE1RUko5a29odWxT?=
 =?utf-8?B?c085YVBwSlN2RmhJdU1uWW4vcWxPUnJaRUZ0TUtPeTc3QjdDWlZyOGlRcmw3?=
 =?utf-8?B?bmRGa1F4ODhwSElTdTRmUUgvS2xEYXU2bGdJb2hmQjRxODVIMkZtMXVzMm5T?=
 =?utf-8?B?OW1QVjNvM3VQd25kSjZ2M2Q4VUFybVJTbGxFT2FGNFhiQitha1FZUEZ5TTlI?=
 =?utf-8?B?bTlWeGxKTXBvbk9tSGgwc0JtQ21nVXEwV1Ftd205Zkllbk9WbGY3ZGo4S2lG?=
 =?utf-8?B?bXN2U05RSExBN2dBeW43dVA0cW0wZURvdlNTdW81cGY2VjRPbEl1bXBraktx?=
 =?utf-8?B?MjFraGVXV3RiNmFLc2Jyd3owV2Z0WjlMbnNUU1JOVnY3TUtJYXpBTGZncFF1?=
 =?utf-8?B?bFplVmxTWGMvU2dGcDBqQUxWTkM3YnFzV2xBVUwvSEVCb0hoVDVDTFFudmNT?=
 =?utf-8?B?ZERka1NZbWFzVDZrMHZHYzBMSVhUN2ltZnBYZmlubWk5TGlXUGNSc3pERFJ2?=
 =?utf-8?B?SUJtcmdhMmtjWkVVV0krQmpGRHNOVmdZWFZIVTg3bStCVnFKNWl4RHMvRk9Z?=
 =?utf-8?B?cFJZNjRnTDg5NTVjc0lzdVJvNG40WkFoTWxOS25CTXhlczI2SUlvcVI0emFR?=
 =?utf-8?B?c3RpNlo2S2VZUjAvUnhQbjR6MngxWEdRYjZpalR5aDJHWHNOV0RXbVNndTJ0?=
 =?utf-8?B?ZXpXMHREZTY5OVNPS2ZydHI3VUxaMkZHelpKOWF5eXdhK0cySDRXN3hiL282?=
 =?utf-8?B?NkZhejlvVTNneVQ4aVFpVGpLUnJiL0graUg0bnNsVDMwN2JicW83OTlWREdh?=
 =?utf-8?B?SHRWeS9CRTBuM1hVRXhiSDM1dlFidGsrZlYyZUVoOHRlWkx3WlF6eldBVE1w?=
 =?utf-8?B?b3k2VWc0a2ZtanFtbW5qeklVd1l3UjJzTVpkVmFtUXVSbzRRTW5Qa05lTWN5?=
 =?utf-8?B?dlJDK3NJeXJKWSt5VWtSTk9TSkRpbmlUaHEvWk44bHJkRVlQZ3ZVR0MxK2pR?=
 =?utf-8?B?TkN3YkMzVi8vaXJ0NXVBK0ZmYloyU2NLSUdtMFIvOHZHOW03TDdKenRxdEpj?=
 =?utf-8?B?cVlNR21CUGoyUjBnMlQrT2ZVaG13TzdldFhPNDFOMWQxTU02YjZvdjBIUWJa?=
 =?utf-8?B?eFVrbTlQQm52UXljT29VdGdSSTJJRTRwYWdtYWhaVVBWSzJiaWJrb0VQdi9V?=
 =?utf-8?B?NjRNSWRNcGN2VE1Ranh5Q1NicFVSSk9lQ1lxQ2F6ZVU1ODJtckF5a3kyNlhK?=
 =?utf-8?B?N0ZadUZ3SjBOeVZJRzVvWjF6dm81QkR1c0dLdDJvcmlkSEFjc2ZCcERlZmN4?=
 =?utf-8?B?eE5UeWVTblNHQ3Y5OHZmanRjSVZWWHMxeUpZT0orNE5pVG84cGM0MXpyVG44?=
 =?utf-8?B?UjhPeTFSV3R0aS9xU2VkUGZoUGZ5WHZoeGRjSUFHOVVGYUg4b0c0aGx4M0hw?=
 =?utf-8?B?WUQ3Sm51V3JwRUVTSjBXVVYyU1p6UnNJMFBsVE5EdlRsbTFZWGd3aDVSSEJM?=
 =?utf-8?B?d0VJajVRLzBjN05uajF5b1RhSEJ2Ti9LL3lzamRkdWdnT09HTERhUjdjQkZJ?=
 =?utf-8?B?c2V4ZVJBZ1N0ejZUMy84SksyU2hkblRjZGp6U2hYZG1tejhYNWhXTFdSbjB1?=
 =?utf-8?B?R21YeHVqa0FKeVRpbGJnUVk0VFlzdmI2N0RPOWJhQy8zdndWM3NYUDJnVzFr?=
 =?utf-8?B?cENLNDdrMW91TUdXU2JTUGJjeVpER1FIU2Y3SEZFVXBtb3k4L0J3L3VvNk5i?=
 =?utf-8?B?U1kxT0V1enNqSFlzYXNrcWFWdk5YREFLbFI2cGpTaUJUeStXT29oYk5NcW82?=
 =?utf-8?B?VGVCMWxxbmp2M0RrbHRBdkR1TXVUT1BrVktFYkhiRGQ0VVhBbDBuOEtsSzdH?=
 =?utf-8?Q?eP9CM5SZJjYZuhDKH0B5iqxWd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ba4d2d-8fb2-4569-9f3d-08dbc883b240
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 04:53:36.3246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzSpGccUrVI7UEbO6jAedUmB9P0rDmspoZwYB3qtmK2C4nJ4BZRKVzaGEBLFAr4H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/2023 2:21 PM, Greg KH wrote:
> On Sat, Oct 07, 2023 at 02:13:15PM +0530, Gupta, Nipun wrote:
>>
>>
>> On 10/5/2023 3:54 PM, Greg KH wrote:
>>> On Mon, Sep 11, 2023 at 07:22:59PM +0530, Nipun Gupta wrote:
>>>> Add CDX-MSI domain per CDX controller with gic-its domain as
>>>> a parent, to support MSI for CDX devices. CDX devices allocate
>>>> MSIs from the CDX domain. Also, introduce APIs to alloc and free
>>>> IRQs for CDX domain.
>>>>
>>>> In CDX subsystem firmware is a controller for all devices and
>>>> their configuration. CDX bus controller sends all the write_msi_msg
>>>> commands to firmware running on RPU and the firmware interfaces with
>>>> actual devices to pass this information to devices
>>>>
>>>> Since, CDX controller is the only way to communicate with the Firmware
>>>> for MSI write info, CDX domain per controller required in contrast to
>>>> having a CDX domain per device.
>>>>
>>>> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>>> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>>> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>>>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>>>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>>> ---
>>>>
>>>> Changes v3->v4:
>>>> - Rebased on Linux 6.6-rc1
>>>>
>>>> Changes v2->v3:
>>>> - Rebased on Linux 6.5-rc1
>>>> - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.
>>>>
>>>> Changes v1->v2:
>>>> - fixed scenario where msi write was called asyncronously in
>>>>     an atomic context, by using irq_chip_(un)lock, and using sync
>>>>     MCDI API for write MSI message.
>>>> - fixed broken Signed-off-by chain.
>>>>
>>>>    drivers/cdx/Kconfig                     |   1 +
>>>>    drivers/cdx/Makefile                    |   2 +-
>>>>    drivers/cdx/cdx.c                       |   9 ++
>>>>    drivers/cdx/cdx.h                       |  12 ++
>>>>    drivers/cdx/cdx_msi.c                   | 183 ++++++++++++++++++++++++
>>>>    drivers/cdx/controller/cdx_controller.c |  23 +++
>>>>    drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++++
>>>>    drivers/cdx/controller/mcdi_functions.c |  26 +++-
>>>>    drivers/cdx/controller/mcdi_functions.h |  20 +++
>>>>    include/linux/cdx/cdx_bus.h             |  32 +++++
>>>>    kernel/irq/msi.c                        |   1 +
>>>>    11 files changed, 370 insertions(+), 3 deletions(-)
>>>>    create mode 100644 drivers/cdx/cdx_msi.c
>>>>
>>>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>>>> index a08958485e31..86df7ccb76bb 100644
>>>> --- a/drivers/cdx/Kconfig
>>>> +++ b/drivers/cdx/Kconfig
>>>> @@ -8,6 +8,7 @@
>>>>    config CDX_BUS
>>>>    	bool "CDX Bus driver"
>>>>    	depends on OF && ARM64
>>>> +	select GENERIC_MSI_IRQ_DOMAIN
>>>
>>> This config option isn't in my tree anywhere, where did it come from?
>>> What is it supposed to do?
>>>
>>>>    	help
>>>>    	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>>>>    	  exposes Fabric devices which uses composable DMA IP to the
>>>> diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
>>>> index 0324e4914f6e..4bad79d1d188 100644
>>>> --- a/drivers/cdx/Makefile
>>>> +++ b/drivers/cdx/Makefile
>>>> @@ -5,4 +5,4 @@
>>>>    # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
>>>>    #
>>>> -obj-$(CONFIG_CDX_BUS) += cdx.o controller/
>>>> +obj-$(CONFIG_CDX_BUS) += cdx.o cdx_msi.o controller/
>>>
>>> So you are always building this in even if the build doesn't support
>>> MSI?  Why will that not break the build?
>>
>> CDX bus will select GENERIC_MSI_IRQ, so I think we can have this only with
>> CONFIG_CDX_BUS?
> 
> As CDX works today without MSI, why are you adding this requirement to
> the codebase forcing everyone to have it?

Agree, CDX bus can work without MSI. GENERIC_MSI_IRQ can be selected by 
a controller if it is relying on MSI. Will update the code accordingly.

> 
>>>> +struct cdx_msi_config {
>>>> +	u16 msi_index;
>>>> +	u32 data;
>>>> +	u64 addr;
>>>> +};
>>>
>>> Are you ok with the "hole" in this structure?
>>
>> This is only a software placeholder for information to be passed to hardware
>> in a different message format (using MCDI).
> 
> Great, then how about reording things so there isn't a hole?

sure.. will update this in next spin.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h
