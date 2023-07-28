Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0275766BA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjG1L0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjG1L0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:26:51 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9230D2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7GC9ASkAkGQLBwpLPxNpTnuPn9c9kscutPUleIJnARBsfCg38WPTjSS2VJIYq5EQiMB11pk0oCpetoOSL6G4jqJlAb4nZmVMqLWnGnWhgKZnUKq/NlVQ3eWqkwoIRvSNhpZV3tkp1faBta7fUXjeGrb9E4QeomDiRTtTYwRITwLmMhbH42Fsyte4diiTGhd8/h/9W5uGCbvTFHh6uRHYOCYSSWZfFlMf1WXuT+R0ECNYULO/kLpGggfpeXy9PHmmZtinV2h9EfOEgTtW9uTkKOkt32euInDvOi2lFGScfInuOIZQMAzHdcrk9NiTkthHN++tu2Z0TxH5ulYVbPAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMA8B35Gl2eGfxlkrtXvRSt9E6LlA/jPAn22bX7BKrw=;
 b=ZqNN6TZGVKJoJupk4tOz72LXm+TctGHtP3wsJv3yl5Z+BsMCLEBdnyPmxXdi2JiURkSb1Ru+54wcPjAJBcRSQSQErBMRgrNZsdlkxP2DiLryaZGYOy0VUkXJ1sgKQVBARQATKKj0QBSNOwf9B/yloE+KmPYlF2W/JVHBM1zzxcn6PTgYJl50D6CQVpj97sur+0VOY6TSlpxtp7RkJ7xtxR4jwCftBRmJl3pHvQVlBSt6wPgtpJt1fkv1wp5XFuN4Kf8ZxU/4oqyEFp32oWnF2kmUHY4Zj2A/h8zlupUBWf2sls1Rn1vfHBqaVpm/3B+q8uIJ7R8F6LLRIhPFrKSR4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMA8B35Gl2eGfxlkrtXvRSt9E6LlA/jPAn22bX7BKrw=;
 b=gqWTOeB/od3Cet5VLpKj9kNbfjT63jXHchvTLNkGElnLJrB9OZ+s6068fR4dA4JSYB+FoIqMFhqW2ZhhsxbZMlP3wjwhicXfRDS997u7Db/6PsCEt+ymwbHbZrchG+xn1faxl4Ffmucl14X165kKiO/EWWtLx8RAw8WFpMizPsk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by CYYPR12MB8853.namprd12.prod.outlook.com (2603:10b6:930:cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 28 Jul
 2023 11:26:47 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::e6:191b:9eb8:e73a%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 11:26:46 +0000
Message-ID: <b3548b2b-7d80-ecf1-d221-f8d47eb05711@amd.com>
Date:   Fri, 28 Jul 2023 16:56:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2 v4] vfio-cdx: add ioctl support for bus master enable
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
References: <20230726110220.26486-1-nipun.gupta@amd.com>
 <20230726110220.26486-2-nipun.gupta@amd.com>
 <2023072622-frolic-gave-4965@gregkh>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023072622-frolic-gave-4965@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0140.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::25) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|CYYPR12MB8853:EE_
X-MS-Office365-Filtering-Correlation-Id: 797c0096-c724-4684-71e5-08db8f5d86d1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzzKVWpueh/OWilIBUHWvRA4jBFgbgiVf+QKIWY1ZtmN41fL4pTKCZyDgsxkJJZFqfLxV9kOoEj4GV/Xni4ek3o7dDBOOHpBk6RupwMzc4haQi3O/4PVInup4CZSWTVgHidyJlnqK20ngHV/Z+GMeqWIGt4UtNDx/Sw1XCPpROOAS/VfXU1o+ZfnxhMkh69zl86cbspOw/+0juRg23fF+t8olA4wj+Q3ynXH2xpFJqNxDBtuksI6SI01FeIr+U43j59eDZ7E6/5i8VZMQWsSAViJrYa6e8ZFBLLeMe2QfWJ91obZUUySMMqftcyTKXTEEVUGSKgoWMZ64XXDeauJXA/9CthJy5AcaXpTLJqzMhPmqFzOIUMRr2Gb9/F8HBw6WXn41RWajYjrM6uWmqoGAZWR4zixgZ4yPClJP1IQmWGTHDl7G9pNqUhaE2hYThItI6wAesyuYLgQRrKxoJfDkNNtTVDY8ol63vYYntJMCRwDyFAAWVkut+glF1YOJWyLy30kDuv6wGKLRLJ4DALWC99P/pUsFLUz0lVSmtNAiwFayPPeDWGHKWxnJESzwFFEIpt/NPWh6MCDnUbTf8+GVbULzxM95DN6kmqs6JlPSAgFw0cYJwNliFDJFHubfmrn51I0saoiZl4HtRrjekqJkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199021)(53546011)(6506007)(41300700001)(186003)(2616005)(83380400001)(478600001)(26005)(6666004)(6512007)(36756003)(6486002)(31696002)(86362001)(2906002)(66556008)(6916009)(66476007)(4326008)(66946007)(5660300002)(8676002)(8936002)(316002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty84QkI1NUd0VDArSWNKd3c1RTdKcFZ6Y0hlK1lYbWI4eW5kaFE2VDBiZVgx?=
 =?utf-8?B?cEV5dUI2VkQxRytrL0RyYmFMa2NPQisyR0g0citONnd3TjFPRmkrL3NVVUtr?=
 =?utf-8?B?NnY5aHRJOW5NcHR6azZJWktqNTl1WEVkdlJsdFJMRHlXeWpQVkNUWEFCM0xn?=
 =?utf-8?B?K0thdHJ3R2pPbjJ0dUdFN2xENm9iTktFaTYxSks3YXNVazFsTUJKSk85VTR3?=
 =?utf-8?B?dEdUMUtkV1BaQTZHaUF4ZGxpM2dXU25JWFNFUWJYSmswTG9oRmJ1VXN6ck5k?=
 =?utf-8?B?M1NnNzdVcy9ERW8vRklIUlRhbzVScDVvdkcwRVJibHBwMnJERE8xbjBzd05p?=
 =?utf-8?B?R1pXNjFwMmd6RjUvS0YwUEVGQ1JzQit4UTVtUDIyMVpoNEpXZ1lTcEZ1SlBN?=
 =?utf-8?B?a01PbjN0L0pOVENyMFlXMzZDRksvQW84dkxGYXdQcU8ydGhvWHRQc0dCUnRs?=
 =?utf-8?B?ditCc3lsbG45U0pQTzNGY0xodDNxcHBxWjR3ZHBBNE1seU1MS3NYRVZDaUdw?=
 =?utf-8?B?Rzlnak1SMmcrWG5xS2ZKNW5PbitrTkJWZ2lrWFlQSXBKWitFNjVHbUdFUzFR?=
 =?utf-8?B?ZFBuenZxS0phZHRDbGU0am1mM0dyOHhJSWtBTDkxamx5VVhCVTIzdFl4Mi9Q?=
 =?utf-8?B?NHorb2hGZHorN2RGT1JYdFVTNHovdEQ4NWMrbGlvL2hqeUpzL1VOak1VWUpU?=
 =?utf-8?B?UTdKbjZYV0V0dkRkeU9HS3pjODdCVW51UFVKcTBNQTNpWUhQNE1zRU5HbTdX?=
 =?utf-8?B?ckdleXVKVG5nbEpOT0d4djUxNVg5anNOY0xIMlVNeG9KS2MwWkROck5jRWdj?=
 =?utf-8?B?czQvWXJ1blRTY3J6VlVhU2d1b0ZLUytaZlZvcWo5bDcrV05TbnFHZ1NRQXZ6?=
 =?utf-8?B?VlN5Y3RDMHkxby9rbllES3UrVGxXcUc3bHV5WjdZb25Xek0yc2cvZTVPZnN4?=
 =?utf-8?B?TWZqK3A5YmRiS3hBSWxHU0VWN0Z6SUVBQllrU3VmWkR1a2NLcDhkL0FFQkpP?=
 =?utf-8?B?TSs1QlBhZWxWenBpSTlZakVVQjVFclF4dEo4WGpzRFBUZzFhR0ZEaVJwQ3BL?=
 =?utf-8?B?Wm5xOGJ6R1lqRGRDMUJ6bzlDWHZBNVJ0cUFZbnIvOFBUalZyaWRSTjhPVzZY?=
 =?utf-8?B?em0wMC90ZVlmajJoV2JJRG4raGVSMXN1Uy95WnJxOFdPVDJncGRCSlBuS0pK?=
 =?utf-8?B?bVk0bVBhaXQ4dXhPelhZdkpHSkltT0RQUWNpbnFZeFQwY016bWpDSXAyLzZX?=
 =?utf-8?B?UDBqOXNlT1ExOUNkWURPV3RVQ3cxWWVZbUxiM1Y4VExCdmNhdzNCR3BFaC9a?=
 =?utf-8?B?N1hKUEpaaDE1SFd4Zm5ERm1MdTQxRmszS2M0dzNmL3ZhV1NKMElScWEwcFlC?=
 =?utf-8?B?T080bGhuUzlpM0cxcmREYTc1RGFFNXhpOVR4VHp1UzR6bXU3SEJCcXVmNytp?=
 =?utf-8?B?V1J3RUx2eDRIUTVJcTJCVi9vTDRWRXNGRmhmYTNEMUlpSkhCT3F3dG9EQUsr?=
 =?utf-8?B?enEwWDdrY2d5M0NtNThQdzBtdHBPUFhTakNlNFc1Q1pvL25ReTNPbmtLbzBZ?=
 =?utf-8?B?NUpqKzlIRm12Q3prSDJtcVRiOVk0OURMcko0NVVLVEl0TDhlSUUwMTcrZ0Vy?=
 =?utf-8?B?QnM2K0M3dm5pN1hwc3J6QlBGRS85OW8wOWRoRmtNZCtpQzNrR0tKcG84ZFlT?=
 =?utf-8?B?dCtZUFNlR3cwMHExODFFRS91TlB4SHl5K2RLckd6OGMzNThDQ1p5RVppL0ly?=
 =?utf-8?B?dTBlNFZ6a3dQMFA5ekMzcy9abWI3N0krYU11U3JzQ1RJbnAyd21GczF3WW9E?=
 =?utf-8?B?bWs3MFNCNEp3TmJWL05QUHFWeVZwWkw4eTF3UTJxVEJYd1NqWGxFUDhOUVJY?=
 =?utf-8?B?MGFtY3NXMDh5dU9KN1BldG5DdEp4dkJUdjlOZ0VCMVViTThJMjlLTllXSWVD?=
 =?utf-8?B?aHRZUWFNbkRBTU5hRFJwbStPSllleDJRTnZDR3d2TUFwaTI1ejFlUU5pOWdB?=
 =?utf-8?B?WUo3a2VCbitabTFmQXdyMlpDZFNBTWZ4SmlkNlZObmtSdGNqb0tQeDMrVkxK?=
 =?utf-8?B?NGk4dWg4d0tmbjNWNWlGRG4zNDgzK2pON3pKNzFrNWNpVFQwU0ZORFZONDVP?=
 =?utf-8?Q?EyD6fTGpw6JF8G/pMDvQbQ8g8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797c0096-c724-4684-71e5-08db8f5d86d1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 11:26:46.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Exvk8i6nvFYIApDY2BJmr6vVfaPzTokQLFclsZQ2P3+ZA7BjMXyVfTbdy7JN2rAr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8853
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 4:55 PM, Greg KH wrote:
> On Wed, Jul 26, 2023 at 04:32:20PM +0530, Nipun Gupta wrote:
>> add VFIO_DEVICE_CDX_CTRL IOCTL to expose control operations for CDX
>> devices to VFIO users. Support Bus master enable and Bus master disable
>> on CDX bus control.
>>
>> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> 
> Who wrote this?  The signed-off-by ordering seems odd.
> 
> 
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
> 
> But what is argsz set to?

This is required to be set as size of the data being passed; which in 
this case is sizeof(struct vfio_device_cdx_ctrl).

> 
>> + */
>> +struct vfio_device_cdx_ctrl {
>> +	__u32 argsz;
>> +	__u32 op;
>> +#define	VFIO_CDX_CTRL_SET_MASTER	0	/* Set Bus Master */
>> +#define	VFIO_CDX_CTRL_CLEAR_MASTER	1	/* Clear Bus Master */
>> +};
>> +#define VFIO_DEVICE_CDX_CTRL		_IO(VFIO_TYPE, VFIO_BASE + 21)
>> +
> 
> Doesn't vfio stuff require a spec and agreement on the interface
> somewhere?  Has that happened here already?

As suggested by Alex, we can use VFIO_DEVICE_FEATURE which seems well 
suited here.

> 
> And why an ioctl?  Why would userspace care about this type of control?

CDX devices are by default in bus master disabled state and user-space 
drivers will set the bus mastering once appropriate IOMMU mappings have 
been set-up.

Thanks,
Nipun

> 
> thanks,
> 
> greg k-h
