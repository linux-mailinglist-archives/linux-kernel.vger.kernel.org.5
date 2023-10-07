Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4317BC61E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjJGIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjJGIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:44:11 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013FD9C
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 01:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRD31W+NdeKmSkxim/usnmFr1Ua5BU04BNBKUsCZhO64l3eX1kNv3YJu8+XDf/HwaigFsxQ/5nAtOls8SG0xzh4xW6QnXORA4IBczKyeD7ji2D2owSea15TVmR8OzFVYNR/IFl6hxds8rtn3w6MHKcAY1Y7/DrG635dTATlESiVHTMwoYvdFSlfVBr7dEBxz6kifjydA+mX/9a9gfyI6yqHOBw/XBIuaLpErb4wd4whpeCpOQ3atPZf0YcW2p6kmbn6XJAuuhkJOEiHhNDiJtdLukQaFNLW7yxVPAlpzyuOsLoJZ5Wo0nW1TOObvQaL1uTIoxdDzF6Rp2EC9pjwm3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU75YZXR8enNrh0WYMSRpKgLFMDiecoxSIt01wQ+JKo=;
 b=DtavhEyexnMZMnmKAevZwaUTvIZmnfpX4yudCN4yhHbOq48JB9Y/+W56ltjmbNcWqkD/4R4z6riP3ZnGP1khNVhgl/Z7LGPKHiZSYK84ZHufiauG1TpWKybORZbEj0W6ovuWjlY4LQjXt/Jj6z77/QvbhVkADJWHSOZC+3Mc4b82j37CFGfAbtqXYlVKe7g0c50IaMaSkfbyZgyaH8d2v4wvZdktatPj1hjtqnrCjbKoor5500w4Vnvdt9LVhAswJxoJjJWiXt0IXz9jYMmwY5QtO8iC0VEGH0GtFj/CnfZMBTUm0cxWWkhGOFDeaMFr2cNenvcC+Y2vMRIcASg5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU75YZXR8enNrh0WYMSRpKgLFMDiecoxSIt01wQ+JKo=;
 b=ge9cRucN5jSKtQM6ytQrHoWnLYD119dNU+xELrt4FmxA8AFrh1aHE5ZUST5nuHEJkJE+qoWseFLbIY3fC41XC/yGlqMN4qeG0PsdwAlDK0rD96pdOindXYw4Hn9PqyssuTXLrnlGeGOPV9FPUilfqboEmRH/FxI+r9eW/JXW8Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by BL1PR12MB5271.namprd12.prod.outlook.com (2603:10b6:208:315::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Sat, 7 Oct
 2023 08:44:01 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6838.033; Sat, 7 Oct 2023
 08:44:00 +0000
Message-ID: <5388fa5c-a4e7-6a51-c363-1a0da75b163a@amd.com>
Date:   Sat, 7 Oct 2023 14:13:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] cdx: add MSI support for CDX bus
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     maz@kernel.org, tglx@linutronix.de, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org, git@amd.com, harpreet.anand@amd.com,
        pieter.jansen-van-vuuren@amd.com, nikhil.agarwal@amd.com,
        michal.simek@amd.com, abhijit.gangurde@amd.com,
        srivatsa@csail.mit.edu
References: <20230911135259.14046-1-nipun.gupta@amd.com>
 <2023100531-matron-oversold-4a73@gregkh>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023100531-matron-oversold-4a73@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::19) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|BL1PR12MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e796314-8bca-467e-48e9-08dbc7118d22
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yez7YbqyqhziNrBNGSy6r8V1YNgPgnr1+2S0dDnYg6hGkngAIJ9v/2Gay5AQsm9OjWcoJ/ueVeqC7kBHP88qAmFBXyRuYt5omB5dBTtoriZmKY5EeWntEXPaFKD9UjV7UhtlRJxWbIRYT4qC4lAoeOND4j98QyIeMWyZqDlUq9pxcgHmD0ejwuZPzNg5k6IWF+CpLkYio2JaO1ccWpmsHpZYfyLffkFBbLrmvaPTOLrIxGtwr6dllAMEQGTyTJV/gc0MjaOr+PwWiWG4DWIqX2b2nbtZzlq7okqOSd8i5Qw32w+p2TZQWoUnarSOV1CZo8fFG6ilh/Gi8SzcZ9GePiJ51dm6DFM7mQaeJMqXu6BiGiRnNa4iH6e1ZVcnztmTPDmer0mzVdhWSp94GNTXFZqfdkUzCegKyao9vDwg5WOp2Gp1fZx8pRITjoUswLj/lwoxiWb+HXzuszEQZflVl6ZYIry2hJ5z5+b/WGuAmB2rRSZrglNDpIvZK1KAoQ+YLzg/kj3HK9A6loomkjHCqoxkXFkvgUst/CyIRxe1cXbd9E0cDglkD+Quh1CuKH4xLqfYXr+Sg+f3SMZbotQTz+dRJLv8eObGd7l02LjZXJA/Yk+L/eLW5d3Y6m5yFsB6xYHFpvaXYcKxjh0GTek9aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(6506007)(2616005)(53546011)(6486002)(478600001)(83380400001)(5660300002)(2906002)(26005)(30864003)(66476007)(66946007)(66556008)(6916009)(4326008)(316002)(8936002)(41300700001)(8676002)(36756003)(38100700002)(31696002)(86362001)(6666004)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBkTGw4Z0ZFZkRwWUU0YlliaXRkTlM0T2llWndaY1JtZnluVXFmdys0SmZC?=
 =?utf-8?B?NXl3ZWp2dlVYYURYcVNpSWJ3VlFRb3B2R0UwTFJ5dk05R0YwU0hrczFkYWtL?=
 =?utf-8?B?TEc4QXFjL3hKOVFNSlJ5SzNqRkhiU0J1TmMwSGdWQTYrUlpKMUgrNUM5STFk?=
 =?utf-8?B?aXFRdGhES3NSdFpiYlhnaHFmRzIyRjhlYjRIWHc1WUJEOGltdVQ4VEl1Z1oy?=
 =?utf-8?B?cW1tNHVhck0wUzgzU1Yxc21nL01RYUNKT3RWQ1B0TVRTaXAzb0xSMS9lVkpq?=
 =?utf-8?B?RmxMeXgvNTc2ekFqb0IyajdwbzZob2loRExrSzNSUUtuaFlIQUxJdXlmeUNM?=
 =?utf-8?B?blhnb1dVNlFEUHBuRm12RHowTEJ4SjFybkNiNVkwZEJ3a0lteFNuUE9ZM2ZX?=
 =?utf-8?B?RXphWGNQWUZsQm93UlZyakl3M2JKR1Vva0JRSTNoSXUybmk2YlU3UzZJV1JP?=
 =?utf-8?B?SklGcFUrL1lZdHB6SEpNOFg3L0VnOFl5WjIxTWpxM0xDSUR4Tm5ZcWpnbnVR?=
 =?utf-8?B?WmxVVGtUUzhoR2s2SGZxS2VSYVZTTUhPOVVNVlE3TGpPUXdyYTNxT3FXSkpD?=
 =?utf-8?B?c0s3OS9WTFZWNXBLT1lsOTVqbzdlU2xkMWRKbXBsWUxUdVh1enl5SC9VY3Zv?=
 =?utf-8?B?ai9IaHd1UWxnNUROY1NjSzFzZVZ5S3JOaEp0R1pXRXY3VWJza1lYcUFVcFNU?=
 =?utf-8?B?Z1hQZU5YOTFWWTVHU25jdTE4STdYdXY0a3hiZnA1enJGR0g0RFc0S3NtRTVo?=
 =?utf-8?B?S2tGbU84RTRrTDViekhVdEN1Ui84QlVWaDZpWmJ4cE83VWNCazIyczJzRWdv?=
 =?utf-8?B?ZTlFSEtTZFdVSWtwMXBWR2RKenpnVXlyUEdBWTQzVlNoa0xnS1RpVGlLRWdE?=
 =?utf-8?B?SnFPeTN4aTVnc2pvWExzNEptKzR5cnFqL1RhcmlNcDVXMUpQVEdtV01jYzEz?=
 =?utf-8?B?cVhvRzJTTUJOajJTR0I4NE5ZY1N6b2F0V2k4R0oyN2pDQzMyZ1FzNkNIZm9B?=
 =?utf-8?B?ODg5N3BDNk5uZjE2akNyUXhheXpxUEVZaEpBdkR0L0JXb0dGREI1cWZIbEFP?=
 =?utf-8?B?MlQvNnVtZWZFc3RJSmpvcGRRQnJBRGd1amRSTjE4VFkzM1hXSUM5ZkUwenNR?=
 =?utf-8?B?YnpmZUxZZXp6ZmxJMGNERWhMWUlNMmhpckFOL09MSFp6Qm5tQmxoVzJyWllH?=
 =?utf-8?B?NWg4WHhiN1lKUXhLb3dmUEpzOXVMWHJlUHpLOEFORDduNlhtb2h6b0ROQmZs?=
 =?utf-8?B?bnBjbCs2RTJTUnRDL3VqeDNwSEFrM3JNVldkWHdvcWU1NitrUy9mZ2w1VDMz?=
 =?utf-8?B?YWc4OTQ4N1UrTGlSa0dBdjl2Z0hBN0VpcHkzQ2orRE1BUmk5TkhFd1I2STVK?=
 =?utf-8?B?NWZxbzFlVjRqMEM0VFViZXJTeGhmU1owWjE4K2NYenJVaDB4bzVDUFpGSS93?=
 =?utf-8?B?UEtwM2VDemZpVEVqSW05aDd0aEd1bzF0Z1JHcTZ0OGdvc1JhY3haV0JmTWxV?=
 =?utf-8?B?dkY5S1JLS2dzMVZQZG45QlBVRXBlMlZkYUZpaWl3aDU0QVdnem5uNEZXcTVi?=
 =?utf-8?B?QjhYbkx4bWdJNCttV2hDRDlNK2M2T2p4azl1ZEtDMS9QMEZPM3J0RnoyWTdk?=
 =?utf-8?B?THJPYm1SMk9nVmRzaFBIWWNsTW1oNTJ2YTJuQUEyT2RmQjlFcjd3eEdTN2Zt?=
 =?utf-8?B?R3Nuc3ZXd09zVUQ4d1huR1JCQmkrNTBwS3JlWXJJRzZRRFBEMVU4YU1senJX?=
 =?utf-8?B?UHYraDdGVWQ1NUhjamVBczNBblV3Vi9mZDA2OVYvUlltcmMzNUp3ZjRDZUlN?=
 =?utf-8?B?YU13b3VYWCt1Z2tvNHRYUy9HOE5XN3AvRDIyd2hoU0RXRlZKY1p2eGJEQjFT?=
 =?utf-8?B?OXEzM1ZBYTNsY1VJUVA5OTZIVVdhT2Vadm9FUUpBa1V1UUF0SjJHQUowaERI?=
 =?utf-8?B?V1RpNXlGS2k3bTFkenNEaVh6L1lIYmxpNHd0NUl4M2xDWkczSzk2clB2NWNR?=
 =?utf-8?B?eVpPRndzQy9PeWVxejkvcG9RVFJiRDVjOXRRclN1dlM4N3VHd21RYXlFQjFI?=
 =?utf-8?B?MytNcWdCWlJyRHFpOFVCSjJsaGNRYTAwbURLeU1SUDM1YmIzUWZydFVmVFBq?=
 =?utf-8?Q?nHz9IRU3RZLhxuEsz6L3tnf+a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e796314-8bca-467e-48e9-08dbc7118d22
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 08:44:00.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uoIgEn0jSdyXsVQj5DdlIH4Ue43iZMQpN01vNo05zUb+YSksmr4ubnIR+yhUPSn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 3:54 PM, Greg KH wrote:
> On Mon, Sep 11, 2023 at 07:22:59PM +0530, Nipun Gupta wrote:
>> Add CDX-MSI domain per CDX controller with gic-its domain as
>> a parent, to support MSI for CDX devices. CDX devices allocate
>> MSIs from the CDX domain. Also, introduce APIs to alloc and free
>> IRQs for CDX domain.
>>
>> In CDX subsystem firmware is a controller for all devices and
>> their configuration. CDX bus controller sends all the write_msi_msg
>> commands to firmware running on RPU and the firmware interfaces with
>> actual devices to pass this information to devices
>>
>> Since, CDX controller is the only way to communicate with the Firmware
>> for MSI write info, CDX domain per controller required in contrast to
>> having a CDX domain per device.
>>
>> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>> ---
>>
>> Changes v3->v4:
>> - Rebased on Linux 6.6-rc1
>>
>> Changes v2->v3:
>> - Rebased on Linux 6.5-rc1
>> - Used FW provided 'msi_dev_id' as device ID for GIC instead of 'req_id'.
>>
>> Changes v1->v2:
>> - fixed scenario where msi write was called asyncronously in
>>    an atomic context, by using irq_chip_(un)lock, and using sync
>>    MCDI API for write MSI message.
>> - fixed broken Signed-off-by chain.
>>
>>   drivers/cdx/Kconfig                     |   1 +
>>   drivers/cdx/Makefile                    |   2 +-
>>   drivers/cdx/cdx.c                       |   9 ++
>>   drivers/cdx/cdx.h                       |  12 ++
>>   drivers/cdx/cdx_msi.c                   | 183 ++++++++++++++++++++++++
>>   drivers/cdx/controller/cdx_controller.c |  23 +++
>>   drivers/cdx/controller/mc_cdx_pcol.h    |  64 +++++++++
>>   drivers/cdx/controller/mcdi_functions.c |  26 +++-
>>   drivers/cdx/controller/mcdi_functions.h |  20 +++
>>   include/linux/cdx/cdx_bus.h             |  32 +++++
>>   kernel/irq/msi.c                        |   1 +
>>   11 files changed, 370 insertions(+), 3 deletions(-)
>>   create mode 100644 drivers/cdx/cdx_msi.c
>>
>> diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
>> index a08958485e31..86df7ccb76bb 100644
>> --- a/drivers/cdx/Kconfig
>> +++ b/drivers/cdx/Kconfig
>> @@ -8,6 +8,7 @@
>>   config CDX_BUS
>>   	bool "CDX Bus driver"
>>   	depends on OF && ARM64
>> +	select GENERIC_MSI_IRQ_DOMAIN
> 
> This config option isn't in my tree anywhere, where did it come from?
> What is it supposed to do?
> 
>>   	help
>>   	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
>>   	  exposes Fabric devices which uses composable DMA IP to the
>> diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
>> index 0324e4914f6e..4bad79d1d188 100644
>> --- a/drivers/cdx/Makefile
>> +++ b/drivers/cdx/Makefile
>> @@ -5,4 +5,4 @@
>>   # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
>>   #
>>   
>> -obj-$(CONFIG_CDX_BUS) += cdx.o controller/
>> +obj-$(CONFIG_CDX_BUS) += cdx.o cdx_msi.o controller/
> 
> So you are always building this in even if the build doesn't support
> MSI?  Why will that not break the build?

CDX bus will select GENERIC_MSI_IRQ, so I think we can have this only 
with CONFIG_CDX_BUS?

> 
> 
>> diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
>> index d2cad4c670a0..8d777cdacf1d 100644
>> --- a/drivers/cdx/cdx.c
>> +++ b/drivers/cdx/cdx.c
>> @@ -56,6 +56,7 @@
>>    */
>>   
>>   #include <linux/init.h>
>> +#include <linux/irqdomain.h>
>>   #include <linux/kernel.h>
>>   #include <linux/of_device.h>
>>   #include <linux/slab.h>
>> @@ -478,6 +479,7 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>>   
>>   	/* Populate CDX dev params */
>>   	cdx_dev->req_id = dev_params->req_id;
>> +	cdx_dev->msi_dev_id = dev_params->msi_dev_id;
>>   	cdx_dev->vendor = dev_params->vendor;
>>   	cdx_dev->device = dev_params->device;
>>   	cdx_dev->bus_num = dev_params->bus_num;
>> @@ -491,12 +493,19 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
>>   	cdx_dev->dev.bus = &cdx_bus_type;
>>   	cdx_dev->dev.dma_mask = &cdx_dev->dma_mask;
>>   	cdx_dev->dev.release = cdx_device_release;
>> +	cdx_dev->msi_write_pending = false;
>> +	mutex_init(&cdx_dev->irqchip_lock);
>>   
>>   	/* Set Name */
>>   	dev_set_name(&cdx_dev->dev, "cdx-%02x:%02x",
>>   		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
>>   		     cdx_dev->dev_num);
>>   
>> +	if (cdx->msi_domain) {
>> +		cdx_dev->num_msi = dev_params->num_msi;
>> +		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
>> +	}
>> +
>>   	ret = device_add(&cdx_dev->dev);
>>   	if (ret) {
>>   		dev_err(&cdx_dev->dev,
>> diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
>> index c436ac7ac86f..ece11c04d646 100644
>> --- a/drivers/cdx/cdx.h
>> +++ b/drivers/cdx/cdx.h
>> @@ -21,6 +21,8 @@
>>    * @res: array of MMIO region entries
>>    * @res_count: number of valid MMIO regions
>>    * @req_id: Requestor ID associated with CDX device
>> + * @msi_dev_id: MSI device ID associated with CDX device
>> + * @num_msi: Number of MSI's supported by the device
>>    */
>>   struct cdx_dev_params {
>>   	struct cdx_controller *cdx;
>> @@ -31,6 +33,8 @@ struct cdx_dev_params {
>>   	struct resource res[MAX_CDX_DEV_RESOURCES];
>>   	u8 res_count;
>>   	u32 req_id;
>> +	u32 msi_dev_id;
>> +	u32 num_msi;
>>   };
>>   
>>   /**
>> @@ -59,4 +63,12 @@ void cdx_unregister_controller(struct cdx_controller *cdx);
>>    */
>>   int cdx_device_add(struct cdx_dev_params *dev_params);
>>   
>> +/**
>> + * cdx_msi_domain_init - Init the CDX bus MSI domain.
>> + * @dev: Device of the CDX bus controller
>> + *
>> + * Return: CDX MSI domain, NULL on failure
>> + */
>> +struct irq_domain *cdx_msi_domain_init(struct device *dev);
>> +
>>   #endif /* _CDX_H_ */
>> diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
>> new file mode 100644
>> index 000000000000..d7f4c88428d6
>> --- /dev/null
>> +++ b/drivers/cdx/cdx_msi.c
>> @@ -0,0 +1,183 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD CDX bus driver MSI support
>> + *
>> + * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/msi.h>
>> +#include <linux/cdx/cdx_bus.h>
>> +
>> +#include "cdx.h"
>> +
>> +static void cdx_msi_write_msg(struct irq_data *irq_data,
>> +			      struct msi_msg *msg)
>> +{
>> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
>> +	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
>> +
>> +	/* We would not operate on msg here rather we wait for
>> +	 * irq_bus_sync_unlock() to be called from preemptible
>> +	 * task context.
>> +	 */
>> +	msi_desc->msg = *msg;
>> +	cdx_dev->msi_write_pending = true;
>> +}
>> +
>> +static void cdx_msi_write_irq_lock(struct irq_data *irq_data)
>> +{
>> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
>> +	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
>> +
>> +	mutex_lock(&cdx_dev->irqchip_lock);
>> +}
>> +
>> +static void cdx_msi_write_irq_unlock(struct irq_data *irq_data)
>> +{
>> +	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
>> +	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
>> +	struct cdx_controller *cdx = cdx_dev->cdx;
>> +	struct cdx_device_config dev_config;
>> +	int ret;
>> +
>> +	if (!cdx_dev->msi_write_pending) {
>> +		mutex_unlock(&cdx_dev->irqchip_lock);
>> +		return;
>> +	}
>> +
>> +	cdx_dev->msi_write_pending = false;
>> +	mutex_unlock(&cdx_dev->irqchip_lock);
>> +
>> +	dev_config.msi.msi_index = msi_desc->msi_index;
>> +	dev_config.msi.data = msi_desc->msg.data;
>> +	dev_config.msi.addr = ((u64)(msi_desc->msg.address_hi) << 32) |
>> +			      msi_desc->msg.address_lo;
>> +
>> +	dev_config.type = CDX_DEV_MSI_CONF;
>> +	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
>> +				      &dev_config);
>> +	if (ret)
>> +		dev_err(&cdx_dev->dev, "Write MSI failed to CDX controller\n");
> 
> How noisy iks this going to be in an irq handler if something goes
> wrong?

sure. will remove this.

> 
> And you are doing this write outside of the lock, is that intentional?
> If so, why not document that?

This is required to be done outside lock only, as Thomas pointed out in 
review (https://lore.kernel.org/all/87ednnes6o.ffs@tglx/).
Sure will add a comment on top of this.

> 
> 
>> +}
>> +
>> +static struct irq_chip cdx_msi_irq_chip = {
>> +	.name			= "CDX-MSI",
>> +	.irq_mask		= irq_chip_mask_parent,
>> +	.irq_unmask		= irq_chip_unmask_parent,
>> +	.irq_eoi		= irq_chip_eoi_parent,
>> +	.irq_set_affinity	= msi_domain_set_affinity,
>> +	.irq_write_msi_msg	= cdx_msi_write_msg,
>> +	.irq_bus_lock		= cdx_msi_write_irq_lock,
>> +	.irq_bus_sync_unlock	= cdx_msi_write_irq_unlock
>> +};
>> +
>> +int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
>> +{
>> +	int ret;
>> +
>> +	ret = msi_setup_device_data(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
>> +					  0, irq_count - 1);
>> +	if (ret)
>> +		dev_err(dev, "Failed to allocate IRQs: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
> 
> meta-comment, CDX really should have a module namespace one of these
> days, right?

Agree would evaluate and send out a patch soon for this.

> 
>> +
>> +/* Convert an msi_desc to a globally unique identifier. */
>> +static irq_hw_number_t cdx_domain_calc_hwirq(struct cdx_device *dev,
>> +					     struct msi_desc *desc)
>> +{
>> +	return ((irq_hw_number_t)dev->msi_dev_id << 10) | desc->msi_index;
> 
> How does this make a unique number?  Is msi_dev_id guaranteed to be
> unique across all cdx busses?  That's not normally the case for most bus
> types, unless you are guaranteeing this in the cdx core somewhere?
> 
> And why shift 10 bits?  That's a fun magic number...

The msi_dev_id_is unique in a domain, and thus it will provide unique 
hwirq for the domain. I will fix the comment above.

> 
>> +}
>> +
>> +static void cdx_msi_set_desc(msi_alloc_info_t *arg,
>> +			     struct msi_desc *desc)
>> +{
>> +	arg->desc = desc;
>> +	arg->hwirq = cdx_domain_calc_hwirq(to_cdx_device(desc->dev), desc);
>> +}
>> +
>> +static int cdx_msi_prepare(struct irq_domain *msi_domain,
>> +			   struct device *dev,
>> +			   int nvec, msi_alloc_info_t *info)
>> +{
>> +	struct cdx_device *cdx_dev = to_cdx_device(dev);
>> +	struct device *parent = dev->parent;
>> +	struct msi_domain_info *msi_info;
>> +	u32 dev_id = 0;
> 
> No need to set this, right?

right! will remove.

> 
>> +	int ret;
>> +
>> +	/* Retrieve device ID from requestor ID using parent device */
>> +	ret = of_map_id(parent->of_node, cdx_dev->msi_dev_id, "msi-map",
>> +			"msi-map-mask", NULL, &dev_id);
>> +	if (ret) {
>> +		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Set the device Id to be passed to the GIC-ITS */
>> +	info->scratchpad[0].ul = dev_id;
>> +
>> +	msi_info = msi_get_domain_info(msi_domain->parent);
>> +
>> +	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
> 
> Do you know that there will be a ops pointer here? And the msi_prepare
> callback?  Or will this always just be:

Yes these would be set as we are setting these in below structures 
"struct msi_domain_ops cdx_msi_ops" and "msi_domain_info 
cdx_msi_domain_info".

> 
>> +}
>> +
>> +static struct msi_domain_ops cdx_msi_ops = {
>> +	.msi_prepare	= cdx_msi_prepare,
>> +	.set_desc	= cdx_msi_set_desc
> 
> This structure?
> 
>> +};
>> +
>> +static struct msi_domain_info cdx_msi_domain_info = {
>> +	.ops	= &cdx_msi_ops,
>> +	.chip	= &cdx_msi_irq_chip,
>> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>> +		  MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS
>> +};
>> +
>> +struct irq_domain *cdx_msi_domain_init(struct device *dev)
>> +{
>> +	struct device_node *np = dev->of_node;
>> +	struct fwnode_handle *fwnode_handle;
>> +	struct irq_domain *cdx_msi_domain;
>> +	struct device_node *parent_node;
>> +	struct irq_domain *parent;
>> +
>> +	fwnode_handle = of_node_to_fwnode(np);
>> +
>> +	parent_node = of_parse_phandle(np, "msi-map", 1);
>> +	if (!parent_node) {
>> +		dev_err(dev, "msi-map not present on cdx controller\n");
> 
> Is this a requirement now?  What about systems without it?

For the system supporting MSI, this propery is required. The system 
which does not have MSI, would not be calling this API as this is MSI 
specific.

> 
>> +struct cdx_msi_config {
>> +	u16 msi_index;
>> +	u32 data;
>> +	u64 addr;
>> +};
> 
> Are you ok with the "hole" in this structure?

This is only a software placeholder for information to be passed to 
hardware in a different message format (using MCDI).

Thanks,
Nipun

> 
> And I really need a msi maintainer to review this before I can take it,
> thanks.
> 
> greg k-h
