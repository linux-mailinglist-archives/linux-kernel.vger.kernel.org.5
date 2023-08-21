Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE3D782772
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjHUK6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHUK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:57:59 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1660D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:57:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb6yk8nR+0kpdmNSndvNXj0hP/j6RVeWQmYMlbQBTIFpEHf7BslVHVJKxY4wAgoHD0pI5E1lNUMl9sQIxnW6DsbFDy6Hjc7+YQqDUG3ErCr+4umUfieYsBmHlp46uqaWHfumKW763gezj5wHl7eUkgibeNc0vqgNKIr9Dsq7fpLJwV1I6I86Wqd2GA302fHE4UvTbk7FMLQxsvTFJ43fqN/6+IzRJZgCSoWdhoUtztTifG+f/g1saN/nOMToxhXIqPYclbuczHogZPwKeiMbx1modGDP2/eV6hsbbWKNmLoyfzbFggSOWbDPI5HGHuIo9zrEjbIqRWrbo861HVu3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TXqI3mcbxLMCUQ0PuHiMfqKj94AA/wwfRKhumfWBmk=;
 b=RUhsWNkXNbxPXuAAUPlgKHoxQaBHtIK0+Njq/BqhMAsdnXp/Mk7sjnM66hq7VLf6Knk8KXtv3jnJj0tionj4WsQ8tqILequDcdZ8QapUU9UooDTbhAFkAg4OUreZDnjAu9/zty/Lv5O8XJkaY1YmmpOghvOWYPvmP+vutXa0vAQMn8Y9Oz//Ns+RQ0dS080uKI6g07KJKtev3ACs7vtu0GqZ6iEpsYQE0FW1mzWZBtj6haToiib3iAqMxg7s6BxRbNhU5YNJUtWzQyvtp1i8ehhNZ2E8W3DKHVBX8YOHav44Slbvw/CdY5hG7MbdaQqDDAOYRrY99yCLguynXcRMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TXqI3mcbxLMCUQ0PuHiMfqKj94AA/wwfRKhumfWBmk=;
 b=2pSmuNHynCmUxVJhq7zRaTmPLhqv5BM1cixWMr20mp7NwWVJ55tEMzqTceyCbHANf8/jup67+FH2ayAqrxdsZAcsVFQvGmzwlS+v9utd5DbXjWaKnL5b0kE7c9jYYB0SU/T36BlwRSZKv5E89rfT8v29dz83QuZ0Vls8omg80GQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Mon, 21 Aug 2023 10:57:53 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 10:57:53 +0000
Message-ID: <4f1dc1c5-ce18-5595-6667-3e6ce1d0e36c@amd.com>
Date:   Mon, 21 Aug 2023 16:27:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 3/3] vfio-cdx: add bus mastering device feature support
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
References: <20230810084409.4922-1-nipun.gupta@amd.com>
 <20230810084409.4922-3-nipun.gupta@amd.com>
 <20230816114610.79c9eccc.alex.williamson@redhat.com>
 <2d94cffa-7ebf-a8ab-4f43-fc9ab1be41bb@amd.com>
 <20230818083737.7ad97c2a.alex.williamson@redhat.com>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230818083737.7ad97c2a.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: aa32fe9f-235b-47d7-730d-08dba23577a9
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8A0EK5pQD42G+8gWWybmy0mzIpDJJOC0WLo4pKZFZNBjFsijqtV8vbXvSie+EUsjRFesiz/lgg8UJris/izDxjZ9F9dBazE0UU8DCO2j5G9lRniwntpEXO2OvT+lICSCAGvG3GQnuTdnBEOQNpJW/vXBmQ0idtDnXEHliDVPLSJJy54AvZfKrnhJryaBMvpwSLnlUe3Pl3F8IsFy76B3K8BUYjHh+pjddMI3mYvX5VXWJo4z2fI+zMbidobhTpHR8DQjiv9ubuseFwcRWusQMB59xuy50cU2srFCzIUVnPkf33rdrjwjvjd3bEn4elqStf/y9BOC52Rv6FOKiYfu/1j7LAJkfi+/Z/Fbd8X4dNIhDILIns7b7xGWTyqy3Mf5p/lR2uxvWbiQM6+QQwCvWtnTT4PuFoYsh3JlzG92ZC+q9Z3Y82pQfV/L1mItonhs4iYIIwOiYUEYCh/1mkL8pgx6tJxGtWROtik1/8JlsPhUHlJfpyNIEl8NaqDxTwRsguLe3ViJPFHlFWV6sZABOlOje4ib8j98cvFZ4LuHp8wr5VFXgifPmRc7G1xN54JFscJ+miFALiFCEOSi8cTRcmXvnwqGnGXejNFq3bRP1GXWNbw3FlIEYouhGPt+DJAlXCaAe+NCM05+O+B5PYgBSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(186009)(1800799009)(451199024)(2906002)(83380400001)(4326008)(6916009)(66556008)(6486002)(66476007)(53546011)(26005)(6666004)(316002)(6506007)(478600001)(2616005)(8676002)(5660300002)(41300700001)(8936002)(66946007)(6512007)(86362001)(36756003)(31696002)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzlVRXVvcURhQ2RzYkpxMS9lK20raE5hNGk0YnJxOFYwVEt0WXBjbm9NM3ZP?=
 =?utf-8?B?bzhCNWd1UkVCSVo3dFg4RlhGUHEyWnFGMFhORFJHdGF5eWxGNkhSNE1HZ3NU?=
 =?utf-8?B?cGoybDNFZkR3KzdSTnJWUXZ3WVYzUmFYNGhIUTJ4S283d00zSU9aRmRudzIz?=
 =?utf-8?B?akx4NmJkYlEraG1oZ1RGbS9lRmRVM3loSC9ybEhyN2tJaE5vYTNhbmJKWUwr?=
 =?utf-8?B?NnBrc0Q5NGdHUVNVSTBvYWZKVTBMZEdlam1hODRTTFBsVG52bnNvajlweGlp?=
 =?utf-8?B?NnM4QmtySyttS2FYQlI5UDQ3S29DcFlmNUc4NEZmeGJBaENBZXlPcjl4VjRN?=
 =?utf-8?B?Vi8zMWVxWUh4T1RTUHZLY0xjNFkyNkRyT2pXVE0rREpDREdRazJUTHcwdGo0?=
 =?utf-8?B?eW92WkVKVWdUVXpEbXl1aTV6OXg1My9VeWpEaE9tck5odFhKcTBRWlV1ZkFE?=
 =?utf-8?B?RHZUbGZZOW00V3FiR2pURGlWTE1LU2VvOWR5WG9RbFNXdGtndVArTGhjWXdt?=
 =?utf-8?B?bzFRcExsVTlSRHkxOVJOMWRMNGIvM1k4aitoZEN6ZitMc1dDZGNIdFNOV1Az?=
 =?utf-8?B?VjQ3UTNVSEVLcGh3U1hrTVFlbHJqMTloaElFNmloMG9lV000OGdQRVI4blI1?=
 =?utf-8?B?cSt1TW9lQ3ZUS0hybmRudS9tOVdMYUMyMHlxamd0ZlpSZ25NMm9iNXFOZmVh?=
 =?utf-8?B?MTVMTzA4aVQwY1dnYXlLYmEvQ1ZpRzR1dXkzeG8xbk1aRk5iZDNWUUUzNTFv?=
 =?utf-8?B?S3ZJMWlOV1NNVlhuNFZiY3hrYzZKLy84dHpZZ2VXOFZxbWRRN0daR1g4ODFX?=
 =?utf-8?B?bTVkWm9PZ3NVU3hHS2xKaHlIR1Y3K2haMUg2MkNjNmkxaWlJN0Y1enFEL2l5?=
 =?utf-8?B?VmtUM3Vra05ZN1BVU1pEMFJyOU5hZCt6Sy9wZ05VWktUQXdrd1AyOS9CK21x?=
 =?utf-8?B?NWk1anVQUTZmREZub1hKczNsQitrQlpwcGtWRnkyR3ovR3NjNGR4ODc4bXM1?=
 =?utf-8?B?MVlqbjVMeGZDTU9TU3FuSjhOK0RGZGpTS3lvaVdmSUl1N2hIaU9tamZ2Smdp?=
 =?utf-8?B?L2gyblh4Um1HRDVmS1NlRTYyOVpERlRGS1d5ZFltS0VtZFdkTlJ3RFBCYklo?=
 =?utf-8?B?dmlld3NNYW9Lem8zeDFKSzlMYnlxRkRqaUJRWFlSWFdRZ0pMZzgrVGxjWnNn?=
 =?utf-8?B?WWVyWnZFTDNueEJNUHQzUitRdjBsVEZERHJpUllOZkgzemdzTURLWkY0UWcx?=
 =?utf-8?B?eFY2U21wc2Nzd0hZdDlsTEk1M1lndlJTVmk2bmltZEZFYlJZbW9FNkNjV3d0?=
 =?utf-8?B?YWkyYmRoVzg1YnlBZmEvWEw0R2cxaDIrOUlQSmZRQWEwd3JSMjFKTFlDOUxa?=
 =?utf-8?B?NW1oTU51aDF1M3lGWHZEbHVwWndSc0YrL3hvemk0aHBoZitSeE5vcEtWUGVr?=
 =?utf-8?B?SHBYRDcrUG05d0pCRVJRTTJVQmdxRGV3bkNBOUtyOXE5c3luTGxub0NYUHVq?=
 =?utf-8?B?Ny9CN0RlZ2pDWkpLY2pqNHF3OGxFK1dCbitHTUNnQkErS3NLcVIrTng2bklO?=
 =?utf-8?B?Uy80Wk53dUxNK0R2VDNLZmlodjJPOFFEYW1qYzY3UVF4amZISkdzQVYrSFdE?=
 =?utf-8?B?cVJ2U3RDMTBVdnd5a0NVdXRLeXFlcUdlMFNEVWNUK21TTG1BcFNHZ0RFeWla?=
 =?utf-8?B?Qm85Tyt1N1QxQUlvUXdpRmRiZ0ZXQjRpb3VwYXVONDNqa0l0TzZXU2JjeHhY?=
 =?utf-8?B?U1lxK2Vma1VVcDRZZWVRMEpUWGhZSVE4MUdOWEZOaFBLUU12akF6ekdRbzNS?=
 =?utf-8?B?RnJUUHhIbjNQVGJhcmJ2REdqajB1bFJPd3lLUFdGZjBjMUZCcjdOa0tLcnAz?=
 =?utf-8?B?bXR1QTU2UGFYT0JyOUlTT2RtOEo5SnRQOW5RWTZKYlEwODNDYUgzRE1BcE5V?=
 =?utf-8?B?R1pHUzNNbjY3OUFEOTFiNUt2dEh0ZXVyVno2dEFDb1FWRTBTOHpaOVVkRGRN?=
 =?utf-8?B?TSs4Y1hSMzRBMzNpRGEvbFpmQ0I0VU0wSStkWDR6VTlyUmpTa1dMWHF3dC9G?=
 =?utf-8?B?L25SeUF0SzlyVkpVdEJKMzRVKzBXN3o1ZXRSeXJFRngzVTJrRGV3cG1jUDNo?=
 =?utf-8?Q?eeC/MHFmxT5DEeAG51P4cVBgk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa32fe9f-235b-47d7-730d-08dba23577a9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:57:53.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzHGK+5CppKg3aJr3furzCJY5DebQCRBEI7yVwYbSoD323HXbI+pbIpFlG3P1O9/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 8:07 PM, Alex Williamson wrote:
> On Fri, 18 Aug 2023 14:02:32 +0530
> "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
> 
>> On 8/16/2023 11:16 PM, Alex Williamson wrote:
>>> On Thu, 10 Aug 2023 14:14:09 +0530
>>> Nipun Gupta <nipun.gupta@amd.com> wrote:
>>>    
>>>> Support Bus master enable and disable on VFIO-CDX devices using
>>>> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
>>>>
>>>> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
>>>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
>>>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>>>> ---
>>>>
>>>> Changes v5->v6:
>>>> - Called CDX device reset at cdx_open_device()
>>>>
>>>> Changes v4->v5:
>>>> - Use device feature IOCTL instead of adding a new VFIO IOCTL
>>>>     for bus master feature.
>>>>
>>>> Changes in v4:
>>>> - This patch is newly added which uses cdx_set_master() and
>>>>     cdx_clear_master() APIs.
>>>>
>>>>    drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
>>>>    1 file changed, 44 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
>>>> index c376a69d2db2..bf0e1f56e0f9 100644
>>>> --- a/drivers/vfio/cdx/main.c
>>>> +++ b/drivers/vfio/cdx/main.c
>>>> @@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>>>>    		container_of(core_vdev, struct vfio_cdx_device, vdev);
>>>>    	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
>>>>    	int count = cdx_dev->res_count;
>>>> -	int i;
>>>> +	int i, ret;
>>>>    
>>>>    	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
>>>>    				GFP_KERNEL_ACCOUNT);
>>>> @@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>>>>    		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
>>>>    			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
>>>>    	}
>>>> +	ret = cdx_dev_reset(core_vdev->dev);
>>>> +	if (ret)
>>>> +		kfree(vdev->regions);
>>>
>>> AIUI, this reset clears bus master, but per the first patch in the
>>> series the ability to set or clear bus master depends on whether the
>>> underlying cdx_ops supports dev_configure.  Apparently all currently
>>> do, but will that always be true?
>>>
>>> It seems like this could make a gratuitous call to cdx_clear_master()
>>> to validate the return value and only conditionally support this device
>>> feature based on that result (or fail the device open if it's meant to
>>> be required).
>>
>> CDX bus driver does not explicitly call cdx_clear_master during reset.
>> It is triggered by device implicitly and hence device_reset would never
>> fail due to lack of bus mastering capability.
>>
>> Do you mean if cdx_dev_reset() fails we should not set the
>> VFIO_DEVICE_FLAGS_RESET in vfio_device_info? something like:
>>
>> 	ret = cdx_dev_reset(core_vdev->dev);
>> 	if (ret == -EOPNOTSUPP)
>>    		/* make sure VFIO_DEVICE_FLAGS_RESET is not returned in
>> 		 * flags for device get info */
>> 	else if (ret)
>> 		kfree(vdev->regions);
>>
>>   From new device feature added for BUS mastering if cdx_clear_master()
>> fails due to no support, the bus driver will return -EOPNOTSUPP, so same
>> would be communicated to the user-space, so it seems fine from this end.
> 
> It's inconsistent to the user to allow the bus master device feature
> probe to indicate the feature is available if it's going to fail on
> every call.  My suggestion was specifically relative to that, a
> gratuitous call to clear bus master, determine if the call works, then
> the feature probe could succeed or fail based on that result.
> 
> However, now that I look at cdx_dev_reset() I notice the inconsistency
> with dev_configure.  The reset path unconditionally calls
> dev_configure, but the bus master paths tests dev_configure.  Is
> dev_configure a required op or not?  Are reset and bus master control
> required features of CDX?  If the core CDX code requires these then the
> vfio support gets easier, we don't need to make all these conditional.

Hi Alex,

dev_configure is a required op for CDX bus controller. The check in 
cdx_set_master()/cdx_clear_master() is just precautionary and can be 
removed.

On the other part where you mention making device feature optional, I 
was not able to locate any API/flags to export capabilities to the VFIO 
user regarding the features supported by the device. Though it is not 
required as all CDX devices would support the BUS mastering.

Thanks,
Nipun

> Thanks,
> 
> Alex
> 
