Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A879773E5A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjHHQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjHHQ17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:27:59 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A7612505
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJIfXYjzrOKMxgLSLs7BjpBmLIfBeEueFG2zoh1qM8r8YIPn8vhCd/MBOSJ0bakyIoNqvBIFbvQ0JMn4VR0bCvpzHE5VhJbf51x2+hzAm7JKtPJsSW8kpeA20Y7totAsf0ICbZCnVLIp147pi0IfFGHwT+Oz3mZt5j/XnVkngkBdKaDwKvjkyiWI5IYR6d9Q/vsBBxxEyB6c6Q6/Y1bjuTwJ/0cgPkipKTIm+Ioq8J0sAuJ2tN6IXxGifFsLzCmswj9UArzJUpwwbgq6Q7U0hhuKSBtrqsO458Uv/VoMMXtOWnvLcNvy4JVDtOMKiXEoJBiCgXr1co0MUaV2Lr10Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HnvgkDZVjlx/1O17zg+1DQ+V+JjyXnkWig8YcKfY0c=;
 b=P8nF5mfWkywYXbUNVvBGg9d6Ap09MQjP8NlU3MaLsCI6+pIsh08/7PFrabWfjpedW7APkW4NbP6XRgwwV98ImiT37L/Gy7Ui8TIAGiQRy5Sk9Am6eMgtZQR2Dl3u3+6M5Ldoo/nLEGFIQ3AJxrpWTwlUcesxxjCsgk0wy92CWGyYMsC9T0ogGRshOmDL0ro5siqDOfqgY9Hplw2gg4NOMSGTxRGkfreb0M7tlglVIEqXh2m3P4tKC/M6/TrUBWdYwr6YPLi4GTkoOiiA83HMb+LIr5v/bcVtvzch7p08qWqfeh112X8upM5L7uIaKjq1Nu/UhrFWRGKnRXnA3ENT2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HnvgkDZVjlx/1O17zg+1DQ+V+JjyXnkWig8YcKfY0c=;
 b=XVuNxypKy0J7Go/EPnTXrMnxUju2AFnnlRGp23+SLod7uL918Dkp0mn6/mAOWp6/q/iARgcvomUaFPGTP7bOzFGfxAMDoJVew3fIB7PlnJWzv28hd/RMhd7CBtyhEjEiRH+P6OZ5FwR4sC98g0ad1KYteUxeXQb141TfpsxabXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:39:47 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 10:39:46 +0000
Message-ID: <909360ba-1e52-ab7e-2340-413cdfb50489@amd.com>
Date:   Tue, 8 Aug 2023 16:09:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/3] vfio: add bus master feature to device feature
 ioctl
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
References: <20230803143253.7817-1-nipun.gupta@amd.com>
 <20230803143253.7817-2-nipun.gupta@amd.com>
 <20230803160016.5b299ae7.alex.williamson@redhat.com>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230803160016.5b299ae7.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::16) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baf0bec-c6ca-476c-4219-08db97fbc867
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX873GSrWtv8d2PymqdNI8viRZxrJm+6RPqdKKNLug0URq5Q5Lzbi83TwW+r0yQfe3G2IoUx3p8a/DzDWTCjE66QWrbl8bzWZQP2h3tzeJfLvPrlJ10Z9IKDly7vaOBEKY0m65Khil7iERAi7gBSeQJCcEoewM3PUW7pLGQJPaRrSCi4omI3+DN8sy2gZLgAZrxz2hP0bo0rWVsZ9E6zRTydjWrT8FtHPPT/A8rknz4ZeR9YRdOZp3xYreT5DmTm1UAGMXv+J68eD2E7K4J1WgoWv+TrvHpfLkJxVfPM2Jk96leXKHujn3NvJUeQ8kbvUrlq/ZNQs5QK+x7zOotmmEkkSUaxD4w1RUw0XGpCdGSHvGBKTSBCXhBUMZDq6HO8TdSlxD6uw0vhn1Ob1Pt3MAJVC9Gct97UHlIAgFhRswUlWDN70P8jiIotqlbi16pNPBSlT8dNggCCbVmRG/VBPbUmmytBblVvmwqNdVF4saOs3t4mIfW12QXJ6Wlxru2kSZtuGc+tL1mJcIHI+3/txRg2cw59ABud4aJCXFbJKj7QWzo369lS6sedC9Kzv2VrP2+ZokiRZuVdyn32iAjPIA0yyOcMUFrcbNK6tNA1e8TaSrqYQ0Z39+WcuLlfwqqKCx8gzOrTxISEqJrOMc4NoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(186006)(1800799003)(8936002)(8676002)(5660300002)(6916009)(4326008)(41300700001)(316002)(86362001)(83380400001)(31696002)(2906002)(6486002)(6512007)(6666004)(2616005)(26005)(6506007)(53546011)(36756003)(66476007)(66556008)(66946007)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M01JdHhWK0VZV3ZCR2JJSGxOc2FwYnptUFJHQmFMajZSVE00ZVIxUU5sZ1lR?=
 =?utf-8?B?R1BaVllpc09WandZbllta0ZhbEVaL3ZuejRFOThKQytsSm44eXJnRDNnc3ZX?=
 =?utf-8?B?RDk5cENlS09kaWRFM0J5YndJN3BRNGZGQndZUE1SM0ZnaEdTTDZoNCtxYndT?=
 =?utf-8?B?S3h3Z2kvRHhMeFFFWlcvRGJMTG9qU0d2RnJmTVNxREUzdk0yMmNyV0RkdUk0?=
 =?utf-8?B?SjJJZllmU2xPSXlIS3ZQTmdvTGxuSll3QVFUaGF4b3dzdU9ETi9FeFFoTm1P?=
 =?utf-8?B?ODhLNk0yaitJWXpDcjZ5V3RMa1NHM2dkM01CVWozSTE5bEhSdm9Sbjc0NlAy?=
 =?utf-8?B?M1B2aGlmSW96Zmd5eTVITERRVDBHLzVkRG14Qk1ORnJiN0hTNzZDSFc3UEI4?=
 =?utf-8?B?TWU1TFhUZXVlYkNRdTQ5YVhxNWs5TC9ZMHIrQ0JHT2NSbzJudTdnN1N1dUF0?=
 =?utf-8?B?NmR3REIxZW5YYnRWeE84QUpPWDkrMElMR3ZTTjJNOUdvT2pVUFVERytkRytX?=
 =?utf-8?B?czVYbGlnZTFrd1NMTjV4T3d4dWdrUmE2c3l5RmFvYVBVYS9JWGhqSVBpVVUx?=
 =?utf-8?B?VktvQVBqclVXVzJZeDJKVnFQV3hJUXlLZ0JwM2V1M2xTMDYxS1l0c05aVGZ0?=
 =?utf-8?B?bkFxVmN1ZXlIT0kxczdoZklkMFo5Y0V5alBrZElSWWx6VDNVWm9EYnhQeG5Y?=
 =?utf-8?B?VmNIMHFDc3JZSFN6d0FWdGFTWnFIOHVtbmo4UmNWUWZaUmlCUTBueEZaNFZB?=
 =?utf-8?B?dDZzdUlCVjR2VC9wdEpVL2JreE4yeHlWcWswVTF4aVNJaXBnV2RTZHhiWHhl?=
 =?utf-8?B?L0xraU1Lc1hqekMwY1VlUTB5ZjAxTklRSTd4cW1KaVRyWXMyNEpsTGFka1pD?=
 =?utf-8?B?M2VJVVpqVUJ2emlVNk00QjRxMGloK0VyUFZmZGFRR1BLOC8yeU1YdVRETFlu?=
 =?utf-8?B?VEF6TkhpSzN5dGtseUltWkJxL2xMbCs2SkpaZEtkR3IycjI2bG9GOVVRc2tr?=
 =?utf-8?B?eDJpMDVlY1QzNlBvL3B3R3I2YVVkWkIxeFJCa3dLWjVuMlprU2U4aWVXREdw?=
 =?utf-8?B?bk10NVQzaUIyNE85M2FvUnRRUWVvMTBpcVdvVlRNRmRFeGRXRytEQ2tXYm1E?=
 =?utf-8?B?Y1NjT2drQnRRL21wUHp6L042cC92Y2NReGVNV1B0RTJRYTJLREJjdWxSY2JQ?=
 =?utf-8?B?YnVndTVjY2Y0VGJnVGNOR2hOV2cyVlpYNVBCK0pZNGFDLzVNWlVjdU1yVWJv?=
 =?utf-8?B?WHdJRnZJRXo2ZExtRklIRXExbWdic0hmc1RFOUlXS3NERmNaRWNwVmNZR3Q2?=
 =?utf-8?B?VW0rSjN3bVM4dlEyMzhDc0FVVnprMlJ3Z1YwYmxhK3JLTkk2bkFTVnpqTWFY?=
 =?utf-8?B?MjdsQ04yWlZhdGhpN205a1lBOVBwSGJ2QmpyMlZmOFZkU0R0c283S01rR20x?=
 =?utf-8?B?RG5adjBNa2RLYnhPNStjRDFNSjZFREdtS0ZsdG1BbEVtK2dTTkdUdE82Wlh1?=
 =?utf-8?B?dHhxNWd2SmVpMXZZY1lhbk1lZXdMSFFDd09xeFVsdUhiNkx1TnZFT1paNkJx?=
 =?utf-8?B?Q2xoSVk4V05ESVBlLzJhcFNvVUcxblBoSzg5UVV6ejlkWUNrM0VudDZTNWd6?=
 =?utf-8?B?Z09nZG5MYktrbWZTRUhUTmxQOG1RYlQ4dUhXaWFERFVJc1A0VXFKNFoyK05t?=
 =?utf-8?B?SnhQalFBdkxRQVdjcHpNTzlhQmI0U2lVOW1QaXMxRWQ4Rzc3bkdlUDdYbnBQ?=
 =?utf-8?B?YWF6dGc0YlJCdDdRM2VLa3VzQ1hlOTBSTE1nTUpsM0x1RHNZMVJ3V1lnNVpI?=
 =?utf-8?B?TkY3Z1Q2dmdwWVRrZnIrVGppRUNUdE9hbzd3Q0VyU2ZXVEpiSmJZRzFZUDBm?=
 =?utf-8?B?VmZULytvMVpuUUF1YXdjODErb1pMYTJTTnVmVEtkZTdDQ0NldzV6bi9EcTVC?=
 =?utf-8?B?SmlKQ0s0b05RVnFEdHAwN1gwUTZVV1pGeU1lcFRzTGZUM1Zqd2VSMDBuSExh?=
 =?utf-8?B?QzlGdEFPbUU2YVZCYTFiZU8yMFVtb0xYSnI1SWZKZmxORVB2dE5aNmxvc0s2?=
 =?utf-8?B?dXdIWEdiY3dnejlTYy96Z1lXU3poaGU4ZEg2djlZR0ZOT25IK2N3SFdQV1lt?=
 =?utf-8?Q?r2W4fI2wNum1I3eFjMnJnociT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baf0bec-c6ca-476c-4219-08db97fbc867
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:39:46.4520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLFvxwIlbDxaJ/RVdNpUsLDQeedLW3YtVr+AHsEVzd7K57bVdHyzcX4H/FqMIqEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/2023 3:30 AM, Alex Williamson wrote:
> On Thu, 3 Aug 2023 20:02:52 +0530
> Nipun Gupta <nipun.gupta@amd.com> wrote:
> 
>> add bus mastering control to VFIO_DEVICE_FEATURE IOCTL. The VFIO user
>> can use this feature to enable or disable the Bus Mastering of a
>> device bound to VFIO.
>>
>> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>>
>> Changes in v5:
>> - This patch is newly added which proposes a new flag
>>    VFIO_DEVICE_FEATURE_BUS_MASTER in VFIO_DEVICE_FEATURE IOCTL.
>>
>> ---
>>   include/uapi/linux/vfio.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 20c804bdc09c..05350a2f1eab 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1287,6 +1287,22 @@ struct vfio_device_feature_mig_data_size {
>>   
>>   #define VFIO_DEVICE_FEATURE_MIG_DATA_SIZE 9
>>   
>> +/**
>> + * Upon VFIO_DEVICE_FEATURE_SET, allow the BUS mastering for the device to be
>> + * set or clear based on the operation specified in op flag.
>> + *
>> + * If the BUS MASTER of the device is configured to CLEAR,
>> + * all the incoming DMA from the device will be blocked.
>> + * If the BUS MASTER of the device is configured to SET (enable),
>> + * device would be able to do DMA to host memory.
> 
> CDX is clearly not the only bus that has the concept of controlling a
> device's ability to perform DMA, so I'm concerned about this
> description.  For example someone with no prior vfio-pci experience
> might be confused reading the uAPI and then not having support for this
> feature in vfio-pci.
> 
> One option would be to make this CDX specific through the name, ie.
> VFIO_DEVICE_FEATURE_CDX_BUS_MASTER, but maybe it's sufficient to leave
> it general but explain here that this is only implemented for devices
> which require bus master control and have no means in the in-band
> device interface to provide that control.  Going on to state that PCI
> bus master is controlled in-band through config space and that this is
> initially only provided for CDX devices would be useful.  Of course the
> PROBE interface can be used to determine if this is available for a
> given device.

Agreed. Will update the comment to reflect the same.

> 
>> + */
>> +struct vfio_device_feature_bus_master {
>> +	__u32 op;
>> +#define        VFIO_DEVICE_FEATURE_SET_MASTER        0       /* Set Bus Master */
>> +#define        VFIO_DEVICE_FEATURE_CLEAR_MASTER      1       /* Clear Bus Master */
> 
> Ultimately it doesn't matter, but this is a strange choice, set = 0,
> clear = 1.  I think the reverse would be better for raw debugging.

Yes, makes sense to use 1 for set and 0 for clear. Will fix in next respin.

Thanks,
Nipun

> Thanks,
> 
> Alex
> 
>> +};
>> +#define VFIO_DEVICE_FEATURE_BUS_MASTER 9
>> +
>>   /* -------- API for Type1 VFIO IOMMU -------- */
>>   
>>   /**
> 
