Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626C5780731
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358614AbjHRIdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358662AbjHRIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:32:59 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D43A9A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geQR8ywgkMSxdYMvF4/e7xo7l4OHiAH+PUNDFcsjZyn7ondAjMxY+gNDJBz1yCbsInUq4idhaSp+R8RwwEY1BiiFFuo63g3TdrNyVkalN1coT4hCDYMHIleoBhFOWCskJbjwiDgI2yPcfGtDrwJQ+JQFYqQWJGzbTYO6qupkpoTcvEht0KOhb/oM7SHgxZzpQmxRGLTn6dXI+RmOFrpteGsEldkvtJlfVCRH1daay/SRwrW+j66k2ypBMknW4+iYigR9D3ig3FzINbtjbFRc10V4itbN27lq2148jWDqG0nnRpJIeWGUiSMlt9b+k+GXSYRA8jIIaCSO3OZMicLqXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NIr8VFbGJSEdDofSTxIuDEDvndC1BbKVPeGo7dIl7A=;
 b=BvO/nsYZUzRa5STeRgC8DYqiIJkwA6J01JpXJF+t0y86/XFwXjEfk8TYX8CeJcsQdTGwSI2J0IcM9xY60Kpz7D6yh8tFs2uFxXvq6Lo4zjORuetATqQEoXIlURWij8oPARV4bvlJhUWMbgE0mzXX9fI44s73OkijJpseMZ0/eiev56udJ3soDcm0GeTXjjWbHGg1TUD4HDYvb8b4I/ZUN/ORMMmhxQsn+LIkn3ngvxriDAOXIiXBhOMON0o6g0F8hG+JEdIwp+bw6VDkHzMoj5O2JbN8rL1tBgUyPqhViL0zPXBHbNmsyGGva1Cvdb8WpJMhx9sKMOMtXd2c4PBTeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NIr8VFbGJSEdDofSTxIuDEDvndC1BbKVPeGo7dIl7A=;
 b=JaAWoar69FMkhzOkuLXmUczOptj+APT2RR0rk7wA4M1eCyGME/spbslzqwyZnkqbdSZ/WvNBLkjkdUBTkcfZm6I/D3hu7fFhHkKDJoeTox7168wGOMz9O8Z1NZ958Yn57PDDZulu1zvAjta1Lqhu8ujGMdeJCny3iQumiK5HmeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by SN7PR12MB7106.namprd12.prod.outlook.com (2603:10b6:806:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 08:32:44 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::7eed:c168:1b20:c628%4]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 08:32:44 +0000
Message-ID: <2d94cffa-7ebf-a8ab-4f43-fc9ab1be41bb@amd.com>
Date:   Fri, 18 Aug 2023 14:02:32 +0530
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
Content-Language: en-US
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20230816114610.79c9eccc.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::13) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|SN7PR12MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cffd15-4af4-4b71-6d5d-08db9fc5b14d
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCYMpIMZCYHQRbVRBLOjjOHS+7vnUfapuecJdssJIPuGabqDYmA1TS3ddZk3H88Q/oNQcKMQLdO9Bp1x9ZGs6JOMgTZkteBM04Rh5KDHQUJtolMyNgg+1fE/yuEX7/X5LuZCVqYlD774ITMWWTWlfuiH933Aal21uAOjUZXDZYHNdK2lXdCGysDDn+/UjxRgYV0jIPH8iyZowFetUpsspR//3IuSmdhnpVG1O9ye0Gd6mTa0TibqmYAYnAb7Fo+IkmwcMMQjVs38hC8oXSvWVfYIXPd2P8k946tr7ySRd0VLh0G0Cafhz5rZnO/TW/WBYUKzqMmWZPz6k4Qf3bvj2cBXJ8MLeOiiVN2xU8/EuA6k9qXexRy13sPqvR8CxmGnW4slymKxcyHr7kVo5Q6qFoBOus2DMoeXsKY6YyPuAmO9IWlU0n1YtBuwovVlcZWT1lbEtfb+Q+CdGhcL8gj0by2dCPK6Ej0Gid4o41Ltq1t8WSXhtK8OuKvf/5szK5ypUAk7gIwqyJrJZwJh9NLE5H7HHx8bHbaPXZIzx+ITkaCs0KkUQF0rGYn8k9vNzR8NTmejZ+Memk5KMBUZhBbNr7TWoB+WSkDPpyym6itrsZ94eo2cktNiG2sFp3F6mEL8VGy/vFpDj5GOIv+EMiAMng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199024)(186009)(1800799009)(31686004)(86362001)(31696002)(36756003)(38100700002)(478600001)(5660300002)(2616005)(6486002)(6506007)(6916009)(66476007)(66556008)(66946007)(6666004)(26005)(316002)(53546011)(4326008)(6512007)(8676002)(8936002)(41300700001)(2906002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzNuUnpYRnVrUHJlUjRiZkhCTzUzMnZ4QlZFSzVYUk1HREswNGFiajFNK09v?=
 =?utf-8?B?clc2aE1Tb3MybUJiK000Y1BBdzJGaU5jRGlQZ3pZWWhobXB1WTlkMUo4UzBx?=
 =?utf-8?B?eDFVdFk0c1VXWUhXek9BUk9rK0ZGUnpFTzU3QkZDUFIzRG5BR0VZVHJMdnBJ?=
 =?utf-8?B?RWpKZTdDOVMxN29jS0lXcWo0YnFZeXF0YVdoYS9LWlQwTzhwc2MrMms4VDlm?=
 =?utf-8?B?V2xLbWtkQkZNMVkrbzNKcGttSk5ScDd5bmxKckNoQ25WU0tCeWpVUlFoNVBs?=
 =?utf-8?B?cFMxQXlyWnI3a3cyUHFHRnVIeWR5VnVUeWxsTGNQQWFRM3MwdjliY1FaT3V4?=
 =?utf-8?B?MmNPNE1jWlpwais5OTc1ZmkvLzdsSjZjOXFwYlBnL2VtYTAxNnJ5cmZQaXBW?=
 =?utf-8?B?SnE1NHBHd3lVeHQzYTI1K1hWNUVldDhNNUM0b1AvWk1iTk84R2F5dzJLUFVJ?=
 =?utf-8?B?cVlqNEhQd2ZkQk5NZTJtK2pjNVVvZWJRT2ZteEppUm5iN2pSQUJROEcrV3FD?=
 =?utf-8?B?MjVHWWMwRXlOeHUzTUlzd0VUZVdPK2tYTXhDeklZWmNDbVBLejhNMy96dzFP?=
 =?utf-8?B?QVp4TEtVc001bDgvVTEwRjFsSEg4OE15bUwrdDZiL1dONEUzY0Iwc1Y0QXZn?=
 =?utf-8?B?UDVOaFhvTnliZzJPVzZMbFJPUFkrb242LzFwa0FxR1FxL0g1YldGM3pKbkRL?=
 =?utf-8?B?MjRtMitPQjlQajVGanF1TWlSOElFLzVnQWJrKzRmM2w3N2h2RjhzR0hRanFO?=
 =?utf-8?B?NjN3dkFBU3FCYTB3N1NKMU9pcXBFbHhzbld2aGJhMllKeTcvN09VWUpiVjR3?=
 =?utf-8?B?elBxYjk1aXhNRWQwOTNleHloYysvOThPN2FCZEN5emRDbHBkZ1cveXhZN1dS?=
 =?utf-8?B?Q2JVYzArbjZRbndvKzZhYWlWK0FjK2hTd0pHd0pSYnRRRUdVUmx5YzRKRytm?=
 =?utf-8?B?N3hzMGFWcjB6ckJxdEJSTEZPOHJwUXByWm1BbEttL1RjRkNDNGZCT1g4aE1l?=
 =?utf-8?B?Mm5OL0hXeWh3K1IrdTBoT0w3djZVNnh1T2ovcTJuRjJWd0ttcS9zUnplNjRI?=
 =?utf-8?B?OU5MYVh6aVdSUXRPeUxaTGdnVHkrRTMxR1loUm1pQms4T3EyM29nQy9Sallh?=
 =?utf-8?B?N1dTWG1Tc1E1ZE41M1FneVV0NXVza0RKSzJZdklLcGF3c0J3MS8vNGFEd2I1?=
 =?utf-8?B?SGFHWlprazRiTHdnM2dQdGdORnRFMUNBNDYvVWp0d0xodVFlZDgxZmUzTmRk?=
 =?utf-8?B?WTlWU0tRL0dTTFpvWWdaYkpDby83WUpoVUxwWm9vMmZLc25TSXJIdUdNZTZo?=
 =?utf-8?B?NG1INFhKUW10dnUyMG9yTWVCb2pYdWlDQkp5cXc1eFJUQ0pVNmVJTER4MDB2?=
 =?utf-8?B?MWVrYUhVWEViODN6MGRlcWE0RWN1NDdTcFJPZW1SUWFuT0VNL2lVRkdYMHhY?=
 =?utf-8?B?aXdiUGk0RUlybklRTTNId1lrWU1KME5QendHSkhxOVpJanZ0YUF4anBuUlBo?=
 =?utf-8?B?YnFSNit5bDYrdlJhVXpGV1VoaDJCOUpJYXZSZ1p6YnBubkMycG03NVFMTmVa?=
 =?utf-8?B?VnVaT3hjR0phWnVibmRLL1Z0MWFzOUVPRVNyd0NhaTJEdlArQUNwTlVYdERa?=
 =?utf-8?B?cFNBMDlYdHEweUFiZ1lQL1QyWDEvMVJjUkY5bnhMTU03VWJja1hZRjY1bTNq?=
 =?utf-8?B?ZTVNbGQ0TDRyQXZEQm9RbnlZMXFsaEg5SXVVRzB0eC9BblVOMkpOYXozQW41?=
 =?utf-8?B?Ykd1STRWMStkTFArWHFzc0ZoQ2wxcHNWdzA4NmZZa3h0V3JFZDk0Q216Uits?=
 =?utf-8?B?NVY4OEQ5MVU4b203eWpuQWVoajIzN0U1bkZYT2laV090S2RpUE9QajVNVXRC?=
 =?utf-8?B?K2ZFdzloU2R5UUVnTkFtM1NHTnJwVEZhcG5hbVE5bk1PWU9hZEI0U2I3YitV?=
 =?utf-8?B?WktEdTU4NWxvN3gyZUc1RHBqQkhFNk1ENnZPQTI0VVIrbC9XcGxHTEZxVG5k?=
 =?utf-8?B?M3FTL2toY3FNcitzaDNlZjJpZGY3cFhjV3p2UXdXaS9haWRvcDIrak12N3Mw?=
 =?utf-8?B?eElSMXYrTWtvTi91amdsRFpJNkhza3BSNFpKazVIVzJxemE4c2wrUUk1NUpF?=
 =?utf-8?Q?ibCeKhYPLdUHq4q3/yCHZemIa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cffd15-4af4-4b71-6d5d-08db9fc5b14d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:32:43.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 347Qa5gRctwwlAVJ88MLYc7iolSmy75moVDido47XdcpNFoQuLHGKwu1mV03pOYm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7106
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/2023 11:16 PM, Alex Williamson wrote:
> On Thu, 10 Aug 2023 14:14:09 +0530
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
>> Changes v5->v6:
>> - Called CDX device reset at cdx_open_device()
>>
>> Changes v4->v5:
>> - Use device feature IOCTL instead of adding a new VFIO IOCTL
>>    for bus master feature.
>>
>> Changes in v4:
>> - This patch is newly added which uses cdx_set_master() and
>>    cdx_clear_master() APIs.
>>
>>   drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
>> index c376a69d2db2..bf0e1f56e0f9 100644
>> --- a/drivers/vfio/cdx/main.c
>> +++ b/drivers/vfio/cdx/main.c
>> @@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>>   		container_of(core_vdev, struct vfio_cdx_device, vdev);
>>   	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
>>   	int count = cdx_dev->res_count;
>> -	int i;
>> +	int i, ret;
>>   
>>   	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
>>   				GFP_KERNEL_ACCOUNT);
>> @@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
>>   		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
>>   			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
>>   	}
>> +	ret = cdx_dev_reset(core_vdev->dev);
>> +	if (ret)
>> +		kfree(vdev->regions);
> 
> AIUI, this reset clears bus master, but per the first patch in the
> series the ability to set or clear bus master depends on whether the
> underlying cdx_ops supports dev_configure.  Apparently all currently
> do, but will that always be true?
> 
> It seems like this could make a gratuitous call to cdx_clear_master()
> to validate the return value and only conditionally support this device
> feature based on that result (or fail the device open if it's meant to
> be required).

CDX bus driver does not explicitly call cdx_clear_master during reset. 
It is triggered by device implicitly and hence device_reset would never
fail due to lack of bus mastering capability.

Do you mean if cdx_dev_reset() fails we should not set the 
VFIO_DEVICE_FLAGS_RESET in vfio_device_info? something like:

	ret = cdx_dev_reset(core_vdev->dev);
	if (ret == -EOPNOTSUPP)
  		/* make sure VFIO_DEVICE_FLAGS_RESET is not returned in
		 * flags for device get info */
	else if (ret)
		kfree(vdev->regions);

 From new device feature added for BUS mastering if cdx_clear_master() 
fails due to no support, the bus driver will return -EOPNOTSUPP, so same 
would be communicated to the user-space, so it seems fine from this end.

> 
> It might also be a good idea to set vdev->regions = NULL in the error
> path to avoid the possibility of a double-free.  Thanks,

Sure. Will update.

Thanks,
Nipun

> 
> Alex
