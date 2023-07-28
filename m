Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AA6766B19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjG1Kyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjG1Kyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:54:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C7B212B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+c4e3g0cWlYILZSWkFJdQeU9Z2kK8Iqqvl3mplQhs8ldJPa+4AKrsOPsPSFGTZMMtZSfVDZFDGXC73np1cSgNXeHTlJ8NuvFD3huwydajGJmax/5DMYRbP1wuZOIUeN0b+T3taNFHZ+VT7Rwmi+HuKx+f0mP6yCDsBxF1hQ+YlKPJVwDX6FWbPRw5EBrYp0JJ7ulF0DXvJmyILK0il/+Zy9ulWS82IAyL6P57XA2iXR8YWUrcaJx+7mw/LWqeQU+YMY6Q+fPU6t7chp4pFEWZPSHoUmUuZr3HgeZaAmOP1Xc08ZM+J9GOaHudGZRJjtyys9swJrKbNDmTJsALEyWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsf3456AqN86Vp7X0dqmugPEsWeDTR6oqn5jCun82FM=;
 b=XP3aQ23yzgwfhE7PZ3od0WAo/kUOHPXRYXhVd9QB6YRWFujWz/2oGSjkOMi6pk1Iu+/kHZNNOz9XJelORXpazqFi0Wvc9GYnxqKKjPb23GSCOL9NXyLjdQ4U/vlI6IxOFVPVrRKjiHbFx8gnS2Zd7vGnBbYfl5zJ9gDqQa/bLNxX8wuKkyCPLxpNCuztcBs3vn+raEVJM8Ste3TJ0mFvwnm4ZpisUaULGFTiatEqCAhA3tBJQtRtL0zMM5uWyZbUNqFdpTuOLXXC8t5Hpcj2j0skAIeqTOfkp+SGhPk/BCXvhPV9Xk9zmXR+3UZNeYggosLW4o9mpgdzOh6O4p1fVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsf3456AqN86Vp7X0dqmugPEsWeDTR6oqn5jCun82FM=;
 b=BWlb5RjM5QCi8NuL6CFnWd9SJRSr9x5xHdZC1TrDMjLNrfLuVOOlY5Ptq+VxlNtIt1oN2raAjsAHsvb2ooSZ6t9wG0ylkm2onIgMPwGJKdQB0wuu7wFMCn0HU6/rRQ/gk8zJOJhRRftkViNfhfstc5Ewtt2Qf6unifUEOWv3j3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 10:54:46 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 10:54:45 +0000
Message-ID: <27dc2387-a27e-3991-c933-5b293d4f8046@amd.com>
Date:   Fri, 28 Jul 2023 16:24:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2 v4] vfio-cdx: add ioctl support for bus master enable
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
References: <20230726110220.26486-1-nipun.gupta@amd.com>
 <20230726110220.26486-2-nipun.gupta@amd.com>
 <20230726110322.7074371a.alex.williamson@redhat.com>
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230726110322.7074371a.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::17) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5760c3b4-95ff-4bfb-7e5a-08db8f590e25
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spZq/g4+Rj07gNx5x8vUc1JcGxrQfjFk9Ef8mW+icFpmPKPVOTN6+JrQGVzyeV1mn440jtxgax5sVSRqkDXcsWiLvBr5E8pd5MR2m0jxhNOinJc0mRhQ87G1eUflLZvEAUrTPPwKnQloxG9EONd+8tqeVWnh914s9BZoZnMLH9JeprmJXY4F23YY/SI1IzDAJD2NtjFoW1GXjWJCayWs/HMBMPhc3IiroL79sY7Eiz0faPos6dMjGgoTAqa4NONjnN98UAuXDpc1q6NuKX5ND60zmGOoW7xWJ5OYEtSGh+wwCsWp/drp2h83Sh/wDNHG0Ay54G3kxGPG8UqkuYuhX5Tpet/1Zs1LK+7b3Ng1488I1CvnmjfCkefUvzB97LvnP9F3zDxDdEZ40EW2Em1h0UdmPe3wQj3QZ7GVM1F4iZiTIHbIpKdmGOa3j0FhEoJTxspzlTgpMeZZkPYRht+yRtWUKXrQTl5n5S/TbuluSQvVEjWLc1f30lDItLLnv0V+XKKFPD+/ltnicy/QY2INN1zri2PeWUQ/p8EHgwFxggRj9uxjIycQMsR1xXT5pOYTV0LPk0KByTiYYxQJC5acUJZXwMFT26SjbaP0khfKMSyRfrbruY6JsxzkGnw70Gw5HY+Sft3dk8QV8N+a1/Ug+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(53546011)(6506007)(41300700001)(186003)(2616005)(83380400001)(478600001)(26005)(6666004)(6512007)(36756003)(6486002)(31696002)(86362001)(2906002)(66556008)(6916009)(66476007)(4326008)(66946007)(5660300002)(8676002)(8936002)(316002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjN6MWhVOW5RTDh5ZjUwZ1ZkT1FjL3gwWFR6ZnRjWERsNmUzay9SRHRVSFNF?=
 =?utf-8?B?Mkt6MzhKd3hnWlZCN05LKzIzWXBvM21ENHRqdm1ObDNYZ0xoUGRVU0J6dEFC?=
 =?utf-8?B?eUJhRlhHZlBueW14WUl4TmFRc0VVUHJPekRoMEEvWkd2TDArQmlqQ1l6VXU2?=
 =?utf-8?B?aVpSaGZNOXRRdlpwMk91b0cwMTM4b2h1MWN6aHRLOXgxd0dYekNjTjA2VEdO?=
 =?utf-8?B?dTVjNWo1WjVIak9QYVZvQnV5T0E3Vks4OEgxRzhNb2pXK2pvTVpJYmEraTU1?=
 =?utf-8?B?U1NBZ2pjS3p4NHNUSVRFNkY4dmF2dkRtUlZjL1Yzamt6eFpHS08wUy84Nkgy?=
 =?utf-8?B?ek1hQXFxOEl1WEM5Wittbm9MUnBYano1TEl6WnZtRi9DQkw3S1FwV09DUDZq?=
 =?utf-8?B?RitwWDdPcFlWVUhoT2pENWxxaExwbFlGNGRqSDlPS3hNRUFYK1hSTmp5cFo3?=
 =?utf-8?B?Vi9hbHlEYWlibDBkeU9KTEZTc2ZlaUg5MVNMT2lreGNFZWEvWXQrZVk3cVA0?=
 =?utf-8?B?Kzl6cWREelZpN2tHR202cTB2UTI1dXFRekFEbnl1NlZETWl4Y3kvMFNISklU?=
 =?utf-8?B?bXBBYTBuY0dFUmo1TnlDMUJucFI0Q0FEZnREZGx5eXZ2VzlBZ1lCQWJYNlNL?=
 =?utf-8?B?WlprRmw1cXZRemRaNEhabnFGQzF0dTljVlpZUGt6a043eDRQN0pDWlkyOGto?=
 =?utf-8?B?c2p1WnZ5VnphWTZIVE1PYm1ZYUFIN0J4U3NoZzI0c0x3YTNsQkhCeHZRYXRi?=
 =?utf-8?B?VkJlTGhLMEtFWnFoQTVWVXBmNWFXeG43K0Nac01sN3ZWRXRmQ3RVY2dPallj?=
 =?utf-8?B?Yks5WlR3SElpdDFHVkFsZ1VMM0VFNFVZcW1PQVFNenJWY0FTWGpPVURyb0Iv?=
 =?utf-8?B?emIzMVMvUm0vZjh6MEdRckZYamhGdEgvTzUwMGo5VENDQW9BTHJLUWRjSFl2?=
 =?utf-8?B?cS9UK3hvTXhCOVVMSFlremdrMDkxVUMxVytMcXNVMHRrQktER2tIWm44NXJs?=
 =?utf-8?B?aUw0Z1gwSnBPdjBtbjlXWkIxbUR6VXlYa2FXekRqbWFvRlVuc3BIMC9hRGpt?=
 =?utf-8?B?UzRXSG1oYTdQM08wMXFqbllTMFdzek5kdG5rV3lwWFRKeDVHTUhGOUZ4ZVpv?=
 =?utf-8?B?RExLa0wzNE1oTnpKd0hYOUgwdFIrSUVkQjVjY2pFRFNrUGtJUGUyNkVGYzFs?=
 =?utf-8?B?UHNVY3p3aTZodHBGUnVvN25qRUFXdHViNlNEekNoQklMK2RDa3ZMRTIybzVr?=
 =?utf-8?B?VU9OVDlCa0JXeElNWUFoUzVHK3YzQjM3MWdaWmg2NjJzLzJ2Zy80dzRLYlhS?=
 =?utf-8?B?V09aVEh0UzVvbHpBTzBpTi83Q2pIMDY4OHIrSyt2b0xWMDFzQUZZQ011T3hi?=
 =?utf-8?B?T1hqK2l3ZDJmRkM3b3BCdVRhMHJ6RnQybklQV0xGeStNc0JlNGlDSFdUTWhU?=
 =?utf-8?B?TkRiTlQyZFlmbjlvajNUb3JnY2ZxSjRxOGszSWVEYnJkODAxeUxOM0x5dWZx?=
 =?utf-8?B?djlrK3pNcnVBczhSVFdGMW1zT1IyakFiQkJQbUk2dTZEaEZKQk1xdE5ZcWJu?=
 =?utf-8?B?TDRWamYzSWJHeHB0UHp4RllsNTlyQU9LOXhRRkl2VlJWN215U1dLY216eEw1?=
 =?utf-8?B?NjdUczNIMVEvdkpXKzJ3OGZESG91YzBFbkNYUTVCT2FMWXVRSTVMOSt5VTV6?=
 =?utf-8?B?OXl2cXVGOUJZaWo3N1FZQlF5OU5PemF5WFBDMGdicW9SbFdIMVRaamJncE10?=
 =?utf-8?B?cGo2SDBLZGFtV3VqUGtNc1dQU0ZoZkJHZDUxL0RvSTV1R3gvZUJiTTRFd2ow?=
 =?utf-8?B?RDgwdXBacUM3bzR1VFpaWHJPTGRCM2RGZGpuTkRVa2hobUQ1UjNieUxmYjVX?=
 =?utf-8?B?SUxTdEFucVpkNC9mYW1ZWEtBUXFVenA3RytQSkFYQnJ1bVUrUTVSa09ZQVZs?=
 =?utf-8?B?NmVSQWhwMzFGdmNLc3dGanV2cFZFaVBpMDNmdlFIRTFjQ1AwSGFGNTJLVTZi?=
 =?utf-8?B?SEZ0WkUrdnkvL3U5bTc3SFFIWDR4STNmNTF6RStyNS9wNTZBa3hBdlBPeHk4?=
 =?utf-8?B?MW13TEYremJ3YkMvUWorYm9lbTZENzFqSlVmSVA4ckN2dkZ5K3dVZmR6T0Uy?=
 =?utf-8?Q?M6g0p99Gy0eXKKozxfv/WP9qb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5760c3b4-95ff-4bfb-7e5a-08db8f590e25
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 10:54:45.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IunZx+7uA5mHgdI2pL1A8DTA+w09TRRI/XDWlpWYwOqUcIZStn33wY9fLo2X9p8i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 10:33 PM, Alex Williamson wrote:
> On Wed, 26 Jul 2023 16:32:20 +0530
> Nipun Gupta <nipun.gupta@amd.com> wrote:
> 
>> add VFIO_DEVICE_CDX_CTRL IOCTL to expose control operations for CDX
>> devices to VFIO users. Support Bus master enable and Bus master disable
>> on CDX bus control.
>>
>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> ---
>>
>> Changes in v4:
>> - This patch is newly added which uses cdx_set_master() and
>>    cdx_clear_master() APIs.
>>
>>   drivers/vfio/cdx/main.c   | 26 ++++++++++++++++++++++++++
>>   include/uapi/linux/vfio.h | 14 ++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
>> index c376a69d2db2..c39a965716f4 100644
>> --- a/drivers/vfio/cdx/main.c
>> +++ b/drivers/vfio/cdx/main.c
>> @@ -98,6 +98,30 @@ static int vfio_cdx_ioctl_get_region_info(struct vfio_cdx_device *vdev,
>>   	return copy_to_user(arg, &info, minsz) ? -EFAULT : 0;
>>   }
>>   
>> +static int vfio_cdx_ioctl_ctrl(struct vfio_cdx_device *vdev,
>> +			       struct vfio_device_cdx_ctrl __user *arg)
>> +{
>> +	unsigned long minsz = offsetofend(struct vfio_device_cdx_ctrl, op);
>> +	struct cdx_device *cdx_dev = to_cdx_device(vdev->vdev.dev);
>> +	struct vfio_device_cdx_ctrl ops;
>> +
>> +	if (copy_from_user(&ops, arg, minsz))
>> +		return -EFAULT;
>> +
>> +	if (ops.argsz < minsz)
>> +		return -EINVAL;
>> +
>> +	switch (ops.op) {
>> +	case VFIO_CDX_CTRL_CLEAR_MASTER:
>> +		cdx_clear_master(cdx_dev);
>> +		return 0;
>> +	case VFIO_CDX_CTRL_SET_MASTER:
>> +		return cdx_set_master(cdx_dev);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>   static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
>>   			   unsigned int cmd, unsigned long arg)
>>   {
>> @@ -112,6 +136,8 @@ static long vfio_cdx_ioctl(struct vfio_device *core_vdev,
>>   		return vfio_cdx_ioctl_get_region_info(vdev, uarg);
>>   	case VFIO_DEVICE_RESET:
>>   		return cdx_dev_reset(core_vdev->dev);
>> +	case VFIO_DEVICE_CDX_CTRL:
>> +		return vfio_cdx_ioctl_ctrl(vdev, uarg);
>>   	default:
>>   		return -ENOTTY;
>>   	}
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 20c804bdc09c..5f6a58f9f8e2 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h
>> @@ -1649,6 +1649,20 @@ struct vfio_iommu_spapr_tce_remove {
>>   };
>>   #define VFIO_IOMMU_SPAPR_TCE_REMOVE	_IO(VFIO_TYPE, VFIO_BASE + 20)
>>   
>> +/**
>> + * VFIO_DEVICE_CDX_CTRL - _IO(VFIO_TYPE, VFIO_BASE + 21)
>> + *
>> + * Control CDX device.
>> + * Variable op is set as per the operation required
>> + */
>> +struct vfio_device_cdx_ctrl {
>> +	__u32 argsz;
>> +	__u32 op;
>> +#define	VFIO_CDX_CTRL_SET_MASTER	0	/* Set Bus Master */
>> +#define	VFIO_CDX_CTRL_CLEAR_MASTER	1	/* Clear Bus Master */
>> +};
>> +#define VFIO_DEVICE_CDX_CTRL		_IO(VFIO_TYPE, VFIO_BASE + 21)
>> +
>>   /* ***************************************************************** */
>>   
>>   #endif /* _UAPIVFIO_H */
> 
> This doesn't follow standard conventions for a vfio ioctl.  Not knowing
> how CDX works, is there really a need for this ioctl vs enabling bus
> master when the device is opened and clearing it when closed?  I think
> this is effectively the behavior of vfio-platform.  Otherwise, I assume
> this is not a high frequency operation, would the VFIO_DEVICE_FEATURE
> ioctl be an option?  Thanks,

Thank you for the quick feedback. There are few use-cases where VFIO-cdx 
users need to explicitly trigger bus master enable/disable. As you 
suggest VFIO_DEVICE_FEATURE is better suited in this case, and we will 
move the BME handling in this ioctl.

Regards,
Nipun

> 
> Alex
> 
