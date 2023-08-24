Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAC786D46
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240911AbjHXK5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbjHXK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:57:37 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD1E58
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 03:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3XWX6cHuRQXPtez6XPQb2BKmm18Mbg0ZThh+tDSBsWpdLv1j/T7Fb5Y9ELJHXn1+YOsLD2qpu1EGlnCZi6gAiCICyxDPsOmsSVSuM0Qn+xoo5xuxYL5FdBhSrFYToM3186Vi2q2On5+BlIsNZFamMDObqjAxSheW56fk9vrphhC2ie4UDsQbT6NWEgAwLUWR2u5xCH+Sk0ZExAq8BApVDqvsWVQtBPjZc2Hm+l0PrevtR/JPBw/n53kW0VDwxjCEKD+K5IUkESVg/Fk+kkJqdPVB9RdN1SWeeQ/P/vfToJ7hISpqs5ZJnsD916CGz1Wwk4kJ1mx84WbNwP6DHraHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkVjQQ/i7AOA1R/jmjnq21oX8WnsvQ9SZBnkz96A3vQ=;
 b=Bejc4FlYWCwMNg+iRh88KdNKAZ/zyWCYhhvClqSNj31NZoE+ES2FsDBDlKlXBIBUSapULBjbfLs80W202TcTyeglGj/4Ktu+P/YrsUPVgQF8vaZyl6k6dFap18n9FJq6BsSyihQVIFjihkaLe9xV7kmQqmLAdB6Hc5j5EhyQkIU9+cwdsmGABWAyzvGVlu53vMtmzJRfjcP8+xiiVy9Y6mmQou1IFX31/ukYGzNdke06es27xMAnecElJ33jwCmYwxyGMPWZRGN6hzJn25W5fZVMuGLVZW2fYkdoieMrLbIKSb4lU5gaKtX4ixX94oXwkTQwYf4yJo7CiOKYgBgGAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkVjQQ/i7AOA1R/jmjnq21oX8WnsvQ9SZBnkz96A3vQ=;
 b=M3l4rIKyT9x6Q5Ta8D1MopKKpKXFXAx8kPFt7NlqkZjbuu9d3Kk/hPSPT7xMLRTnykxNEvR97/wHEEHaJOX8iqjD3j6VBKYI343geOUeIxlv405yxboktweqtSfggVZO85p8DgEf8G0sLktuoF0buoj2TcoePR+BHUO0kvXq+DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:57:31 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628%4]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 10:57:30 +0000
Message-ID: <907c8e87-c923-eae2-84fe-5e4041c073db@amd.com>
Date:   Thu, 24 Aug 2023 16:27:14 +0530
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
 <4f1dc1c5-ce18-5595-6667-3e6ce1d0e36c@amd.com>
 <20230821150738.63ff73b9.alex.williamson@redhat.com>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230821150738.63ff73b9.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|PH0PR12MB5500:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc6fdde-a6cd-47fe-f41b-08dba490e926
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RciAtTd6fcQq8WnspX8yi2MVH3hrPqn7bPhUdGE1lCYOLDGpl6BrZhJOerfgncmkgF6dln65tgZFlDv7xaeJzj541H13Rr6R0kMtuwf1oyMXUO9ejH+X+F0fg+8DylBw6ZierxVrw8u4VxVw1ivLrr2is6re6yUjCypeBi5M3jJcU6RRnZe7qzq6Njhicv5bgRuiOc/PceBX5IXEjAUN5ie9OrcOMtmIBVluSKH8JS/qUCnkXP+iveb/0ZwGuBYUtlQ6SM5G6FlbsZrbr9C76VCwQGx7gnZ/4wV/wHDGhFu6Nl73icB5yuEctI4H6AihK75g6fsXVZ+fGzC9IFhEC8H53kobI+L2NJCh9sbcLA0rKap2VyLz6RcMF2S2L3CW0BFqd0+LBnFsKWnkhg2nXXYhwg2H6tyFIrcDmvfWvD0JRyj0hx8P4ewnm0sDbnlq6LjCTBzqtgiNSgPpbmP9gQ7BDynAEY1118fGh4a+jwPZKZbxDJSTP+Unfm3CdEtdzZitLvS9DR6Wy/iFNfYzgRbn7CB9eYWVvg8fFVO1Ww5ooEPMc4qqBru6FmfIAlFt1AeIJEzFewA/9uvPH0dRI5Zj1EoIIHvcBP7jEp8ff/ilRu2vgsv2tVRCBDroc9RFyDc9FHmajWAQGH/uwk2Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(186009)(451199024)(2616005)(8936002)(4326008)(8676002)(83380400001)(5660300002)(36756003)(26005)(6666004)(38100700002)(66946007)(66556008)(66476007)(6916009)(316002)(478600001)(31686004)(41300700001)(6512007)(2906002)(53546011)(31696002)(86362001)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3prY3d5aVY3TlRlWXordTlyWU9LcDAzTDFxdHB6Q0w1Zy9RdURZbHJ0enpz?=
 =?utf-8?B?dm9jSmw2MFpkSFFkN05wV09rM2JGN3hwTk5JZGkxQTR6QXpDUFFXWDliS2dV?=
 =?utf-8?B?V2NLcG5FZ3dpbkk3Vlgyb2RGYVRNUUJabkNBY2dsQy9HRnVMWm8yUTk5dktq?=
 =?utf-8?B?dnFvam5qN3BoYnBRTFNwY3p0Y1ZvcVNkWXozZHBKeGM0emNSQ284ZktiY3RU?=
 =?utf-8?B?L0NZSTZSejkzM21aREVSWGhSK0lST1VOUmxldXdDOUpZeTIxdzlxeTJLT2lm?=
 =?utf-8?B?bm1iNWJsMkZKRkdmWUFTc0pKaWl2NHcvVEZ1eC8wZ05nZVV0T0VhQVhOY0VC?=
 =?utf-8?B?VjVyaVJnSG85MitYN2RwOG9Rbm5TcUR4UVdXWlZLVHF2N0xhdC9GMyt2R2RL?=
 =?utf-8?B?dUtPbkNEdjhtdTJ4YzAvaEpNWmxaYlNScWFJQVM1dThwUEFSZ0E5UVRzbFdR?=
 =?utf-8?B?NUFxRUEzOEhSMUFNamVOUFBKRjc0L3c2R2ZOc3dlVXdOWmUxVGN0YXNkeHhJ?=
 =?utf-8?B?ODhVaEVUYlhzZERtbHJaMmk0QkV1dWUySE5lVHhpQzV5RndsZ0xIaWlHK2ZV?=
 =?utf-8?B?YWxGbElYUkxnK0VZQit0UGU4ZUFiM24yZzNzTG5teno2Wmdpa0hVSlpGR1l6?=
 =?utf-8?B?S0RsVENYdEIwTFlrSTAwS1VZYkF0S09CNTM4WHcxdERQbzBHWVVhOTU3UkdD?=
 =?utf-8?B?Wlc2ZnJ2TTFYR3k5d0Y3UzRlSitscnkxRnhoSjBEamptYkViQVNyRjlsUHJ1?=
 =?utf-8?B?V1FsbDh6ekNQdUFVeWNmdWZTMWdLeHNGR1NSdGxzOEdTYVc0V1RmZkU4NVBU?=
 =?utf-8?B?UE4xZnBQYUZBNjAva3lHSm1Pd0FhaG81ZUpUS0R4RVJqYkdqUGFwVnlkV1Rj?=
 =?utf-8?B?MVVUaXF1TGVrZjR2TDNYUzNJdGQ2ZUdCTnlBQ3BPZGpkenFmSmtsY3orcytN?=
 =?utf-8?B?OW1jczV1U2NpWk5vcklJRnErQXJSUDA1M3JPVWhiS0V3MlZmRWtGcE1yYXA4?=
 =?utf-8?B?NExZVWFKU2FGakhDR0VKKzVac1FtcDhHVUxORjI1NHhPNysyMkV2VEl4V3ZG?=
 =?utf-8?B?OVlmTmVvVlppYlMyZStKYnpIU2Y4WHJObkVMcEdETzRnbXRXK3QydkxITith?=
 =?utf-8?B?NTl5VWswN3E1eHBkcGFtb0kwdmlidjZ4Nm11Yk5lc1VRYnZVRGh6bXVBM2x5?=
 =?utf-8?B?eFM5UlExZlU5Q005aDgvMGR5T2lWSGxBdi9mS3FTa3poTXVVUmZEbGtTa1Vo?=
 =?utf-8?B?TUFKKzU3WmdaY1hGRmxGa2k3dVg5RUNPcG5veEhDRVhaa2ZJdVd3TE04Tzgz?=
 =?utf-8?B?bXRweXhXRW9BUTAxUTNWdHczUk1oZTU5TEVLWG9iNDFRR0lWdmNsMzB0VHVU?=
 =?utf-8?B?WnNsQk5VZElsQ0ttUDlqR0grZ09JbTZNbHUyeXJoNm1zdTBjakVjN1JrR0ZU?=
 =?utf-8?B?K3hsenJEaE9WaldNemgzcFpSVWxZNDQvaEp5T3V4SGtqM1VPcnFGUWd6R2pv?=
 =?utf-8?B?amZYZDRwR2RBdW5yR01BWURqOWtJMWhIMy8xNDNjYVZORXBldWE0ZjJRbkV5?=
 =?utf-8?B?a1czR0lRQXRHbysvTUp6WUxONGZKc3h1dUt3NENFaUMrbjlTQWZDU1kzSVN3?=
 =?utf-8?B?Rk1oUXBMdnlubC9XYUxVSlF6ZFNBVkxoVzVrQmwwc1lOMFZkUlNIeVFjb1kw?=
 =?utf-8?B?ZkZDMzBLaWJPQUF4amo1V3RKNzVwYXhYYlhkWnprSStMZmxCSi8rMUVuaWdj?=
 =?utf-8?B?MWVaTmlCT0VCd0dVQ2k1M1NVNmVrL1VXNFNwQXBhdVlZN29iZHRNWVdEeFVK?=
 =?utf-8?B?cERlOFd0Uzg5T1Z2bS9mZng4NkVZc2lSRzhremZvR21od29FamgxL0FjQTBK?=
 =?utf-8?B?N09McTlvT2F5QnFNeFJ0RHdvVWVVaEFUWXdscGRqejRqZklZWjdnek9yMU10?=
 =?utf-8?B?bU00T2VGMWQvOXE0NW92NW1WOC8vczlXZnpuTnBIdFQ4VTZpZG02UVVVNldW?=
 =?utf-8?B?OWFmdzQyd0FvaEppMlcyem15RzFWdGRleEJEdTBvdXN4SndUWS9Ea2FCU1lU?=
 =?utf-8?B?c28rckZaYVZtak0reks2QmFJZ0dONmdReWQrY1MySUY3MkVmeFRTd2lmSGdU?=
 =?utf-8?Q?RWlleRjVncwwlGbJGZH9qrVHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc6fdde-a6cd-47fe-f41b-08dba490e926
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:57:30.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4qkuzHMjt9nGzD5kaF+hj0qo2AtM7dEfbjuijSljL+qnRcDrd3dX9yOznWqJvM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2023 2:37 AM, Alex Williamson wrote:
> On Mon, 21 Aug 2023 16:27:40 +0530
> "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
> 
>> On 8/18/2023 8:07 PM, Alex Williamson wrote:
>>> On Fri, 18 Aug 2023 14:02:32 +0530
>>> "Gupta, Nipun" <nipun.gupta@amd.com> wrote:
>>>    
>>>> On 8/16/2023 11:16 PM, Alex Williamson wrote:
>>>>> On Thu, 10 Aug 2023 14:14:09 +0530
>>>>> Nipun Gupta <nipun.gupta@amd.com> wrote:
>>>>>       
>>>>>> Support Bus master enable and disable on VFIO-CDX devices using
>>>>>> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
>>>>>>
>>>>>> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
>>>>>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
>>>>>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>>>>>> ---
>>>>>>
>>>>>> Changes v5->v6:
>>>>>> - Called CDX device reset at cdx_open_device()
>>>>>>
>>>>>> Changes v4->v5:
>>>>>> - Use device feature IOCTL instead of adding a new VFIO IOCTL
>>>>>>      for bus master feature.
>>>>>>
>>>>>> Changes in v4:
>>>>>> - This patch is newly added which uses cdx_set_master() and
>>>>>>      cdx_clear_master() APIs.
>>>>>>
>>>>>>     drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
>>>>>>     1 file changed, 44 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
>>>>>> index c376a69d2db2..bf0e1f56e0f9 100644
>>>>>> --- a/drivers/vfio/cdx/main.c
>>>>>> +++ b/drivers/vfio/cdx/main.c
>>>>>> @@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>>>>>>     		container_of(core_vdev, struct vfio_cdx_device, vdev);
>>>>>>     	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
>>>>>>     	int count = cdx_dev->res_count;
>>>>>> -	int i;
>>>>>> +	int i, ret;
>>>>>>     
>>>>>>     	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
>>>>>>     				GFP_KERNEL_ACCOUNT);
>>>>>> @@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>>>>>>     		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
>>>>>>     			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
>>>>>>     	}
>>>>>> +	ret = cdx_dev_reset(core_vdev->dev);
>>>>>> +	if (ret)
>>>>>> +		kfree(vdev->regions);
>>>>>
>>>>> AIUI, this reset clears bus master, but per the first patch in the
>>>>> series the ability to set or clear bus master depends on whether the
>>>>> underlying cdx_ops supports dev_configure.  Apparently all currently
>>>>> do, but will that always be true?
>>>>>
>>>>> It seems like this could make a gratuitous call to cdx_clear_master()
>>>>> to validate the return value and only conditionally support this device
>>>>> feature based on that result (or fail the device open if it's meant to
>>>>> be required).
>>>>
>>>> CDX bus driver does not explicitly call cdx_clear_master during reset.
>>>> It is triggered by device implicitly and hence device_reset would never
>>>> fail due to lack of bus mastering capability.
>>>>
>>>> Do you mean if cdx_dev_reset() fails we should not set the
>>>> VFIO_DEVICE_FLAGS_RESET in vfio_device_info? something like:
>>>>
>>>> 	ret = cdx_dev_reset(core_vdev->dev);
>>>> 	if (ret == -EOPNOTSUPP)
>>>>     		/* make sure VFIO_DEVICE_FLAGS_RESET is not returned in
>>>> 		 * flags for device get info */
>>>> 	else if (ret)
>>>> 		kfree(vdev->regions);
>>>>
>>>>    From new device feature added for BUS mastering if cdx_clear_master()
>>>> fails due to no support, the bus driver will return -EOPNOTSUPP, so same
>>>> would be communicated to the user-space, so it seems fine from this end.
>>>
>>> It's inconsistent to the user to allow the bus master device feature
>>> probe to indicate the feature is available if it's going to fail on
>>> every call.  My suggestion was specifically relative to that, a
>>> gratuitous call to clear bus master, determine if the call works, then
>>> the feature probe could succeed or fail based on that result.
>>>
>>> However, now that I look at cdx_dev_reset() I notice the inconsistency
>>> with dev_configure.  The reset path unconditionally calls
>>> dev_configure, but the bus master paths tests dev_configure.  Is
>>> dev_configure a required op or not?  Are reset and bus master control
>>> required features of CDX?  If the core CDX code requires these then the
>>> vfio support gets easier, we don't need to make all these conditional.
>>
>> Hi Alex,
>>
>> dev_configure is a required op for CDX bus controller. The check in
>> cdx_set_master()/cdx_clear_master() is just precautionary and can be
>> removed.
>>
>> On the other part where you mention making device feature optional, I
>> was not able to locate any API/flags to export capabilities to the VFIO
>> user regarding the features supported by the device. Though it is not
>> required as all CDX devices would support the BUS mastering.
> 

Hi Alex,

> The flags for the feature itself is how the user determines whether the
> feature is available.  For example here we're expecting the user to
> call with flags (VFIO_DEVICE_FEATURE_PROBE | VFIO_DEVICE_FEATURE_SET)
> to determine the VFIO_DEVICE_FEATURE_BUS_MASTER is available.  This is
> handled automatically by the boilerplate usage of vfio_check_feature().
> 
> In this series we introduce the possibility that there might be no
> dev_configure callback for a device, which would create a scenario were
> the vfio device feature probing indicates support for a feature that
> maybe isn't actually present.  Then, even if dev_configure is
> supported and required, it's just multiplexing the specific op via a
> switch statement, so we need to make a leap of faith whether every
> future dev_configure implementation will support these ops.

Although there are no CDX devices which do not support BME feature, but 
you are correct that we should provide correct information regarding the 
device feature support when (VFIO_DEVICE_FEATURE_PROBE | 
VFIO_DEVICE_FEATURE_SET) flags are used. We will update this in the next 
version.

> 
> I wonder if dev_configure is really necessary or it wouldn't be better
> to to have .reset and .bus_master callbacks on struct cdx_ops.  Then
> the cdx subsystem could properly enforce required callbacks.

dev_configure is per CDX controller, but there can be possibility some 
devices on same controller support a callback feature but others does 
not. So current implementation also seems to be fine.

Thanks,
Nipun

> Thanks,
> 
> Alex
> 
