Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353397AEDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 15:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjIZNHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjIZNHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 09:07:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA178101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 06:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKgEtPZekYuH0bZX+gkJGfGeFi2ZYz0E7cdVaY+i58Ih5Zq9NXbW5vJMSBFwLhrmhkSf3kdLTz9XRht/SpE4kP3ZYj/fyAADRDqbd3bn7d5BUXVEX18ogI0oUZRY9W161svWoBHeMq8Nxql7m8RkICkDTPoxJIRShVSDlOo2jwIA8AOCutlT2/QIsWj+FBHTHb5GDK+YpCaPlLp8rFOJsW31H6vu5PwapLx1+yxyi/EJslEZGM1gz4qSOOzPyh0PwN1dU0LiAhyDb46uovj7ruOqdwD9xQLe5jsLVDX04l4QsicaOB7vkYG9lUN3eYslqU4d+0b5aiuxGOCiDM/ABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JK/WsHAi911Q8uNr3YT/GtjXkRpHAfCKvw6DyrXkwUo=;
 b=cNjk1dJMkPydDNTQpY5CeEPmHohc9pdSgHxo4wIZcJgycnzYZ5KAvr/jbIYwM0tCkhXUWkB+FNQNA+HKeZ24ibZIAN7VVkVC6PUaalvJ2jnPIQLFNEl5Ik56Vjs5TmFp1Tc/spQfHz1ldpoNcyBVTXboyd6N1NPaOxDkGY+luNkpJzdWEAV3hl7N4OyR/3ERmKco9q1mCBkMoJmCWpXHh4EAhSbGB7sFpWjCnrQhjeQiRwkr3EePU6e4oELMfvhcp8EGBLyTwQYzKRQWtL+RNS6g7enQp4CG4X9xnSCwXC3zo5oAbNER9QcH6t1kZMt9bZ1R4vd3QUgY+p9DMh8PkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JK/WsHAi911Q8uNr3YT/GtjXkRpHAfCKvw6DyrXkwUo=;
 b=4u5LD1uXk7wHv1BeFuynTO5QFwNFxFLIw5eoUcRbjTrfMRB7mMUwKVn7lkEa0QivxvfdHu53GMboB8VQFCmQ5XdjrcVc6GFbxXl0I9KTTvRVURH6RqxNTFwctOAem5LWkDAV4kpHMWgs4qI9Iw7mM8rsMG1vkZQKEhItbl9m6X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8308.namprd12.prod.outlook.com (2603:10b6:610:131::8)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 13:06:53 +0000
Received: from CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f]) by CH3PR12MB8308.namprd12.prod.outlook.com
 ([fe80::a652:eb45:86f0:f68f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 13:06:53 +0000
Message-ID: <592f6e76-92cd-fc80-95a0-d1a4aaf81bca@amd.com>
Date:   Tue, 26 Sep 2023 18:36:38 +0530
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
 <6127727d-cb4e-7729-5216-83c93fbb22ee@amd.com>
 <2023092602-zen-legal-4910@gregkh>
From:   "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <2023092602-zen-legal-4910@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::14) To CH3PR12MB8308.namprd12.prod.outlook.com
 (2603:10b6:610:131::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8308:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: d1880862-449d-4078-63ff-08dbbe9173f1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmKRmVe+0SG4LxmoULSlw5yeQSLao7o2GOEO1VtVj2I+pfiHT/7JiOxRHuV6IOInKrMPI6U9dmR7rdFvdu1c2sZwem3J6L5w5YB7FSwI1u0Jhaf4fea5n8EK7J6yVT1UkYXl57Lxic/vFAUyTBiDPz8fwMHADt2gsyZi7ZMQfZTbV5EJjtfc7KpTg08ME1b9AxDr+ykYi1WWUA+WFapU9AAfVHRJNDKjnb1uYLm64ZuxtTcYXWHpy70fLl1Rm9zzjCs59iz2XKKExCGpZfXz5vrl3rnwKZmPGIC3djOLEbfDS6vPciI4qJKa463BuyjZ+NKTANLO/16PxY0dATNfn9l5yaNyEisG+vuybj5DmAG2KF9rhHhwWN2Cqn2bRVs2s9EHkdfML0P46vQqnOSHh73eck8fVaBse/pzNARP29ezI+mySFu1MHNsMv3TvyasOO7rest5uy0XqdgdZn5pLcomXhpt/S+iE3TzEvaQh6/fkVzsae172GBuinDdqPsvKnIqdy8IUlyU7q82+EUNldXsMKamX4SbqSwBlUkfAuoICAam1rWbNCAAajmN/p92/ScnavnsSimk9ji9ECcaTcqOi4hiIe+5k5rdMtcS8ud6CIfKcp5dtvaNYseQBAUV3O5qIVYoMABbsqxzm823ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8308.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(1800799009)(186009)(451199024)(2906002)(83380400001)(38100700002)(6486002)(66476007)(6512007)(66946007)(66556008)(5660300002)(26005)(53546011)(6666004)(6506007)(41300700001)(6916009)(4326008)(8936002)(8676002)(478600001)(316002)(2616005)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1hTmlVMGZtdkNlRC9YMTAwbElNTUJBRys0eWhhQ1BaVTM2TVZ5anc1SHhU?=
 =?utf-8?B?R1UyZFFsSkYzVmk2TFBQMGVsRVFKUCs1RUlINWtFaHVwMHM3ZmNDWW1Fb2Nh?=
 =?utf-8?B?QzVxQUVCVFJOUkJ4aEU1RHd5T2V5dkRBbHBUTG8yYWxNODV6UWFPTjlkNGpa?=
 =?utf-8?B?aGNXK1lOT3I3RW1MSjNvdnl5QlBSeXdhNFU5b1Iya3RpWmpJUnlrcGd2NXBK?=
 =?utf-8?B?TTdHK1IxaWU5cjZnS0NrT1hGY1RXUkkzbWNaY2xGOG51TERONFNKQkJ5clVm?=
 =?utf-8?B?aFhXZDBEejU2L3JrU2lCUDBRYXlHREpTbEcxbmxCaWxYcDRxZUk4cit3TUI4?=
 =?utf-8?B?SnYzbC82MEY5S1lFRlN6RWE1bmIzTzc2MTVGVFIrYkJLUitLU0Y0TWdvR0tM?=
 =?utf-8?B?RFM5cWFXWXRFZzNwRlhHN1lEU1F5a3ZnWE1rYmRiUFNLNEEvekhkWXJ2MWIr?=
 =?utf-8?B?MlVGZVhCbkU2cVdsaS9ORDZtUGEzbnNzZ1VFZUpGb2VscUd2dUppMlRvN05x?=
 =?utf-8?B?VjNVVytCZkN1QjFwM2RxN2ppYmpYQUs3dUZDWnR2b2NzZHZJOG0yVGR1aVUw?=
 =?utf-8?B?SmVpVFRucGxJcHpHd3h3K0NBa05NMnhtSHpFQU1RMkVlWjE3L1VSbTJOb2VD?=
 =?utf-8?B?OWpJV2dCSC8vb2x6UXlsbXBQdzVXeEE2dFJMZ1B6c0lUdmFYckE1UG4xOGNr?=
 =?utf-8?B?bmViTW1YSTVaTnRnUVF6TGJ5d1hmZU1RTStoK2F0OG1XTU9samQ1YnYrMkps?=
 =?utf-8?B?anU0MEI2RjJUa1NidlVNWGUxM2dLM3pQbVNNaytTS1JXVUQxZVJSWFphYnZJ?=
 =?utf-8?B?cDRpUmQ1KzdUeFUva2RCWEtvako1L3ZJQUgvUG43Uml4YjFyUmRYTEczK1Y4?=
 =?utf-8?B?NFhSbmdZNWg1NXV6ZStMaVQwdUUxanpkTUYxallidjdycDY2elMzdnJqdUh4?=
 =?utf-8?B?Z1ZrWDJST3hsMlY2TGN1bk4yNVpZTVV2S3pmeWFLTUJ4VVplV3Q4Sm9HVEJY?=
 =?utf-8?B?Tlp1UHd5MW0xMFo0MVgyWVRUZm13SlR4ejlQNm42cnpCOVY0YzYrRnBTSldI?=
 =?utf-8?B?a0NKWEFxRUhHRm5QSXVSemp3UUVQdkpHblYrOU1pM1JnakxuQS9ncXF0eE5R?=
 =?utf-8?B?V0VlYTNUdG5kNVFGd1lLZW5xM0xpWENoQlV6RFNuSndBZE5zWG01ZnM5VmlK?=
 =?utf-8?B?c3hidEtwQ1VldW90Ums0Rm9Ib2M5N0VOZHVHUnlLMGNkSXZLNlZkYkoxdlpN?=
 =?utf-8?B?bldMV1VyQlZlYjVtd1JvenBNSVRYMnpnSDBmbXo1ekhXaU5jaXZ3a3VQV1Vm?=
 =?utf-8?B?OVp4OW5nS0ZnZndtS3NESU93ZWZmcDBydXdoWU43aVJZWVM2L0gxUC8xeUtZ?=
 =?utf-8?B?OWI0TGJOdHJZbkNUdDUvOGxhclU2YmxTTERwVFpHN1lYNEE2SDVxdnd6aC83?=
 =?utf-8?B?d21mRVkxUlJxY0tpVzNubk5jWU4yWXFUMll4Ym5mUXF1WHA5K3JLbnVTNEdE?=
 =?utf-8?B?VU14QnVKWFVwVDhCOXNFakRaNnVQbEpXZmNMaFBsYktnaDdJVU1DU1RGc2tD?=
 =?utf-8?B?R3h0aXNPMkNwUkx0cUtubWYwV1p5S1VaMHhHVktjUkRESjBvYXg4RURFcjRl?=
 =?utf-8?B?Qm5tN0tzeStoeGFvK0ZHZlBHSHN1S3kzTS83bzNFMHFaL3RGTTJMSmNMUWVr?=
 =?utf-8?B?Q3ZFM1htOTVYQ2cvekRMUVJXa0g4NHN5OUU4dkJLYjdPMHdmK01VTTk4cjVW?=
 =?utf-8?B?UjB6WjN1UmNOL0N6Z2UxMll4YlJyWmpMUEFRQ25QNW1TVVFEZjZWTTh1TzRv?=
 =?utf-8?B?dWU1bFNmcVF5SGFSUXJ0NDFjbDh1UjV3aHdxNm9DU2xCb3lVK2dyRjlmZmpm?=
 =?utf-8?B?V2plamc2UXV4U2lWQm9hQ0krL0lpa0R1R2Y3eTUva0owQnBNRjEvZ2lVQ1VI?=
 =?utf-8?B?WVhJaUhCNk5abE9YSm5pOEFCOUtPU2ROYTgyNU9ZaEIyUDJJV2IvNlQyaGRl?=
 =?utf-8?B?aHE5aDViUGZnVHFweXFDRFJ5VUlGNVc1SG9xSGhHVGl6YmUyWHY2eko5MzBV?=
 =?utf-8?B?WnJJSVNRVDVUczNpSW0vQWtJUGdQdUtFd2VCYTRpdTRDekVrM1RPMkd0S3Nk?=
 =?utf-8?Q?JWHXrZftY2gq9gr2VikjX8z1u?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1880862-449d-4078-63ff-08dbbe9173f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 13:06:53.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yrR/GYRfP+8j0DhfaNKTPQtcT/Yevb4pFM3gTZnbx4rySgLsa1CBrxq3RFKeRdJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2023 3:25 PM, Greg KH wrote:
> On Tue, Sep 26, 2023 at 03:18:58PM +0530, Gupta, Nipun wrote:
>> Hi Greg,
>>
>> On 9/11/2023 7:22 PM, Nipun Gupta wrote:
>>> Add CDX-MSI domain per CDX controller with gic-its domain as
>>> a parent, to support MSI for CDX devices. CDX devices allocate
>>> MSIs from the CDX domain. Also, introduce APIs to alloc and free
>>> IRQs for CDX domain.
>>>
>>> In CDX subsystem firmware is a controller for all devices and
>>> their configuration. CDX bus controller sends all the write_msi_msg
>>> commands to firmware running on RPU and the firmware interfaces with
>>> actual devices to pass this information to devices
>>>
>>> Since, CDX controller is the only way to communicate with the Firmware
>>> for MSI write info, CDX domain per controller required in contrast to
>>> having a CDX domain per device.
>>>
>>> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
>>> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
>>> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
>>> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
>>
>> Please help in making progress on this patch. Is there anything that needs
>> to be updated in this patch for CDX bus?
> 
> $ mdfrm -c ~/mail/todo/
> 2031 messages in /home/gregkh/mail/todo/
> 
> So perhaps help in reviewing other pending patches for other subsystems?
> It's in my queue, but have been traveling for 2 weeks for conferences,
> will be catching up next week when I get a chance.
> 
> Also, you need to get the msi/interrupt developers to agree with this,
> why not get their review and acceptance first?

Thanks for quick response and sorry for prodding. I will check with 
Thomas/Marc for their feedback.

Regards,
Nipun

> 
> thanks,
> 
> greg k-h
