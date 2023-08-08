Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3C773E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjHHQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjHHQZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:25:47 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C368920
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGSNHFRMgwlkMNS74BhQgo/dFhjQTdBzf51Cy7LCNC7P0LiGpjpiuVbssdwNDMlmTxckSvGrDYN9uG8iLzAKLpcHRXN7lzKUPmAMw28tJwguqv8jdg514Ul+5TKhnJR7f6vAr71GgC/71tOi2BizbuLwRq9xgDRd3kfLID9/Qa+HAFEtNPtboSytBMgw8EVEWshyZT/rXOCckWauv1F4OyI32N4gHQzjXtKC42uIwqizYCnoWEtZZR4a6bn+4z9EAk9/KUCBVNxuAGEo7UfP1XxQBfAhw9EQnOPq78tgn/BRW4a7lW4GNthaJ0MiybP7c/jVKlIYxOTeWn0rJNLysw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Jte0OUclu2bH09D2hN2EOkZLRWbNyPg0/DjTwPt+N4=;
 b=IDlMQr60JCHbDs+O2f3u9RkeFVJPWsirDftlNZHbtscw5TGv9HmMYcaa8Tij6BDfAKsotIo5+stBkgJlyjucpalT2xvk5ZsgYmmNfydFuwUw+meyQA5I/HcSUuDpMppOoL/4hbj1ffPEhHCQzl7Am/tsC9Sg17YD5Jvfb/1QfYE+3WiEHQ4wyhjWhfjgWUe9PWXnuoMS494CMMygtRBQqYX+KXLtgpCZa4yrsbTL2vZZpxZ9oOjTftEXDefJhfia55I1n+2NNzlkwDh7FoGUpJuPY40rK/mLHpfpD9D+5RMgT3SpAMqo2kILfMDzX6YYyTqYzYBosl96f5Dy6CSsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Jte0OUclu2bH09D2hN2EOkZLRWbNyPg0/DjTwPt+N4=;
 b=RzuObS8M9TFbmnwhHvzJilZWWrXRRpnSRk5sUxdA3l9hq9VnGKPsFiisesu6suuwI4J+q4U29u5mtxg9YU5oixAnsFRlsX5n8vtaSa3f2vCyemO3Zt40iLN9T4FJ0X8MJxOfuqI8DDC0fd4WJnrpCSS0B1kC8eWSbkuv7g/4wA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:49:25 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:49:25 +0000
Message-ID: <3921846a-5560-44fd-c4ce-329acad454c0@amd.com>
Date:   Tue, 8 Aug 2023 16:19:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 3/3] vfio-cdx: add bus mastering device feature support
Content-Language: en-US
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
References: <20230803143253.7817-1-nipun.gupta@amd.com>
 <20230803143253.7817-3-nipun.gupta@amd.com>
 <20230803161736.52dd2d33.alex.williamson@redhat.com>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230803161736.52dd2d33.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::16) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8b9516-8aa1-43a4-29d1-08db97fd2196
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUwZ4OLQioYJoX8ctpq0C7OhC+HzLWOY1xfSou12aKZE9hk4GyoVYcZYU8hNMk1pi03m/+cRf9BEQ+MQiTmHKjg/sSppUIArT3e+9e2XJ3QN77iQMXF1iICG3vNqppepBbE9nnZgf6YuSh1Gf3Z6VU3cGimrCaR6AYq62FMQw2RadRU7dcjS/m4VVHF20HyNsOucNxhPOuI2GmKKusxIhlI5wqonAwrN2Ogkphn8a3H7iJXDaKUxpQbDBeJPG09Zd3GbksXWXm9ZWB3W5yhfmgLk0P3Ha9lEum1i0hzRs9DtlvIn92xJ8sCiLnMurjCQNNz7emqafj02psMCOQaQjYcTlPrPIYAAxNPHh4Gees4UuYPOFTnaHWq3fgM9YXlkTXlwDN/pX6olNamNo0SpA6js6TMeAneFtz102+TrKFzo8r69Iji9ig8X935fk3ENsOZTearbwa5b/SaPgQbGzzfE9uMce59cYb0F4bym2nWW96C9JIjQaA7NdrXcx0BYOz8TOdhE+BkxBE1mltvqlwTYRLqFghadnS5/DTpN1BRxnWXUoRcLQ+jolJwrkXid/3Km86pLNiPA+gJJFEyjl3lFC+A5LeTBdRnjVya6xZWlyJcln+353HPX288SUJjWBDsz+XE3ayXsRJychXIG+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(186006)(1800799003)(8936002)(8676002)(5660300002)(6916009)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6486002)(6512007)(6666004)(2616005)(26005)(6506007)(53546011)(36756003)(66476007)(66556008)(66946007)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlFNMG55elhnRWo1c25hTDFXek80emFJcHFjSDFEdXZEWk1INWxVSVFQekNm?=
 =?utf-8?B?OXFOWkJqK3RjdU9sdTVJZVhRNG1WbDRoRU94QU5ydGFrbG9KZTNURnphUWhU?=
 =?utf-8?B?WlkxWkRqdkhHNFVYWWg2SUhleTZLQnY2NFZrQXJOUTdjZkZPLzJVSnUwYUFE?=
 =?utf-8?B?a2JzQlh0N284YnRmU09KRUw0K3NMUzhGNDQ2ZUVGWnFwOGRva3JvNEtBQTJP?=
 =?utf-8?B?bHJQOFVMOFhWSFkzdEMrV0Vic3dIMExVVkFtU3JqMjdXeEduQSszTlhEei9n?=
 =?utf-8?B?ZTR3bGRJWXloRzl6ZFhoTW5YNVdGZ0JSMDdFZ0lWZ1RKbUdpRzhscXZJd253?=
 =?utf-8?B?NWtCZ0hlbS8rd1M3YlAvS0QwQVBHWlRkSFpKQWJueDZIOUx4aTlZSit5dmNS?=
 =?utf-8?B?RDNqUFFlSEl6MUhpdFBwd0dVUVdDSk1BckVhMkZSWGpDWWhyODlFTXJNSVQz?=
 =?utf-8?B?RzJZZC9CemZNbHkrN0s0Tk9mS0VXbHg4OEhMVWJMNzQva2FDNldZYm9MQUIw?=
 =?utf-8?B?R3JsL05nYXJ4QmZsNFFEMkRLK0FHSnJ1ZVZ1RUV2TmNaZ3I0bUNRK1lEeTll?=
 =?utf-8?B?Nkx4N09SVHJEaCtmTHVCNDFjckh2Wkdvd21tNUhYODByUzE5bW9ZYVFSYXlI?=
 =?utf-8?B?MTFWUFdVenpQa3ZIMm50RzN1UkQvN1VCeU9EZi9XYmYwME1FRlFiYlZvVm9q?=
 =?utf-8?B?QnB2a04zMFlkbWNpdjd0NkM2VlI4dXBuME4xbWl0L0NGME8vcXFrUTZUTVJr?=
 =?utf-8?B?cXRYdlVKRllPTWxqeGJxREcvd2RqUk52b0Fuby9uUS80dHV6b1JjNE8vVDQx?=
 =?utf-8?B?R3dYNm5yZ0lKWDV1US9VUFQxQWhTOFUrOW1YRWNYNGxxb1Rqam1nVkZmV2Np?=
 =?utf-8?B?cU5sdkRUSmdOQTZIcVBQSUJuU2JabzZKTWRCTzB6dDFjSW4zdTBxY1dUKzNm?=
 =?utf-8?B?OFlOVllJYnZFRSt3NUtRUmdndCtkY0ZXcFQ4djhWN0t0WE9COWllemF3TzdS?=
 =?utf-8?B?L2QvazhNUnVlT2NCMFhWbm1TVE40b3RZRGZYV04zd3RGNitWVDR6eGNtb3lY?=
 =?utf-8?B?cUMvcWF1M3AxbzlvbjRuaHFLZnBFZDQ1azkyL2lyOVhFTmhSbmRQZEJqWGhS?=
 =?utf-8?B?dHFYeHdmMFhPRVdBckRzS1l3U2x2NnUvZzRqekpZeTFuazUxcEliK1Y3aXRh?=
 =?utf-8?B?ckpyWlB1UUp2TmtmSjgyNmVweVFydXVuYTRiZiswaGZON2NVajBaYldLUnV4?=
 =?utf-8?B?cnlTMTZFWHlaRURHTzE4ZUxXVnQrNWVyeEhlYVZOaDZWU1l6ZG56YU9Lak8z?=
 =?utf-8?B?SFlRc0pudWszcEpTUldUL0ZRQ0htSTNZLzRtRG9qVHVKVkVsS25MYW95V1pt?=
 =?utf-8?B?Si9SU1J5Z21XcnhpbTg3ZVNjU3BEdXprUnJwYzl1MlNLT0V0eVBabVlPYUJu?=
 =?utf-8?B?UzVlWmwvdmZrb2tkWDBoYTQwd1IrMUZHQjQ3Njg1amRZZlk4eC80N0RtZ0RR?=
 =?utf-8?B?ZkptR0tNM0FCdVNCcngvb1dkK29adUJ4VUIwbzdyY1M2K2hWUzBsSFhpSFpY?=
 =?utf-8?B?MGRDM0JBZDlYSkVnVndWaEVNVHU2TDhMWExadWc2SUd2OTJxTzB1a0RkVENi?=
 =?utf-8?B?TVByWHZCNTQzU1hpL0UzM25PcEZDR2tyb0lldWFKWHdkVlV6TEl2WGVOWm83?=
 =?utf-8?B?M1VpV3RoNUJuNnZDNnFxMXlOMk9zTHJaTnVHVGxvYWF6anlFT0h4VjJ4OVB6?=
 =?utf-8?B?aFRkeWhVRVY3TkJXY3hLQXBqTzZWb2VJS2RDck5jVmNkUHdzMDVMREhvRzhu?=
 =?utf-8?B?bk42MUtZRmZBZ2tYbkMxczVmRlZZU1RvQXRudFYxZnlRODE1cW9OQjc5ZGll?=
 =?utf-8?B?Z3cyVDZLZ00wL0t3RTY4L2VuZmhVaVVFUXRkaWpMeHlWbEE3WXpRRmpxbzB6?=
 =?utf-8?B?QmFKdm5iSnduMkVKay9hbjk2R1p5aFBoMmM5dFoxdTF5ZE1QL3RuSWtkNWpL?=
 =?utf-8?B?emZNWDVPSUpJMFYxY05NbjlieEdYaW9MUDFpQXVGNElIZWxvWG11cmxEVVZ0?=
 =?utf-8?B?SUxtS1pBQTVad1d6NEpkZERHWldxNW1acXY4bFh5dzUzbGxNZ1JhVDBtNUJ5?=
 =?utf-8?Q?Uv0EWr8igf1eG3BKTkitH0zHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8b9516-8aa1-43a4-29d1-08db97fd2196
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:49:25.2986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8FrCDhwOEX/inymzdzFFL9XgGTOidBDgKQXr+ojRNHvTw+4WE339jUtoTVqmp5q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 3:47 AM, Alex Williamson wrote:
> On Thu, 3 Aug 2023 20:02:53 +0530
> Nipun Gupta <nipun.gupta@amd.com> wrote:
> 
>> Support Bus master enable and disable on VFIO-CDX devices using
>> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
>>
>> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> ---
>>
>> Changes v4->v5:
>> - Use device feature IOCTL instead of adding a new VFIO IOCTL
>>    for bus master feature.
>>
>> Changes in v4:
>> - This patch is newly added which uses cdx_set_master() and
>>    cdx_clear_master() APIs.
>>
>>   drivers/vfio/cdx/main.c | 40 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
>> index c376a69d2db2..6420cf6eb2f9 100644
>> --- a/drivers/vfio/cdx/main.c
>> +++ b/drivers/vfio/cdx/main.c
>> @@ -52,6 +52,45 @@ static void vfio_cdx_close_device(struct vfio_device *core_vdev)
>>   	cdx_dev_reset(core_vdev->dev);
>>   }
>>   
>> +static int vfio_cdx_bm_ctrl(struct vfio_device *core_vdev, u32 flags,
>> +			    void __user *arg, size_t argsz)
>> +{
>> +	size_t minsz =
>> +		offsetofend(struct vfio_device_feature_bus_master, op);
>> +	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
>> +	struct vfio_device_feature_bus_master ops;
>> +	int ret;
>> +
>> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
>> +				 sizeof(ops));
>> +	if (ret != 1)
>> +		return ret;
>> +
>> +	if (copy_from_user(&ops, arg, minsz))
>> +		return -EFAULT;
>> +
>> +	switch (ops.op) {
>> +	case VFIO_DEVICE_FEATURE_CLEAR_MASTER:
>> +		cdx_clear_master(cdx_dev);
>> +		return 0;
>> +	case VFIO_DEVICE_FEATURE_SET_MASTER:
>> +		return cdx_set_master(cdx_dev);
> 
> It's curious that the implementation of set and clear in CDX call
> through to functions with non-void returns, but we simply ignore the
> return in cdx_clear_master().  Does something prevent clear from
> failing?

Would update cdx_clear_master() with non-void return.

> 
> I also note internally that true is used for enabling and false for
> disabling, which is effectively opposite of the proposed uAPI in the
> previous patch.

Yes, will fix in the uAPI.

> 
> If the idea here is that the user should assume bus master is disabled
> when opening the device, what happens if the user closes the device
> with bus master enabled?  What would cleanup that state for the next
> user?

cdx_dev_reset() clears the bus mastering and user would enable bus 
mastering once ready for DMA. Probably we also need to add reset in 
device open. So user should assume that bus master is disabled when 
opening the device, and close would also clear the bus mastering (by 
calling reset).

> 
> Is there a use case for the GET operation in userspace?

There is no use-case for get operation in CDX as of now.

Thanks,
Nipun

> Thanks,
> 
> Alex
> 
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int vfio_cdx_ioctl_feature(struct vfio_device *device, u32 flags,
>> +				  void __user *arg, size_t argsz)
>> +{
>> +	switch (flags & VFIO_DEVICE_FEATURE_MASK) {
>> +	case VFIO_DEVICE_FEATURE_BUS_MASTER:
>> +		return vfio_cdx_bm_ctrl(device, flags, arg, argsz);
>> +	default:
>> +		return -ENOTTY;
>> +	}
>> +}
>> +
>>   static int vfio_cdx_ioctl_get_info(struct vfio_cdx_device *vdev,
>>   				   struct vfio_device_info __user *arg)
>>   {
>> @@ -169,6 +208,7 @@ static const struct vfio_device_ops vfio_cdx_ops = {
>>   	.open_device	= vfio_cdx_open_device,
>>   	.close_device	= vfio_cdx_close_device,
>>   	.ioctl		= vfio_cdx_ioctl,
>> +	.device_feature = vfio_cdx_ioctl_feature,
>>   	.mmap		= vfio_cdx_mmap,
>>   	.bind_iommufd	= vfio_iommufd_physical_bind,
>>   	.unbind_iommufd	= vfio_iommufd_physical_unbind,
> 
