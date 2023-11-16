Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7407EDBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 07:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjKPGqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 01:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjKPGqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 01:46:10 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB8E181;
        Wed, 15 Nov 2023 22:46:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcfhmq2XrnYJxXCBOyv5Zvoq/0EuhWNcMnYIJnEMd9JfKMPOHxPa2iywdoNKPxdpRbUy7XRTjrgTntaKbv/XSjHTT+97P7/VXSgZL0vGXa496o+KMLLTlP8X+1v/6HWUYG4f1bqv7QI4R09vYjYJJU4WcgpkUW+CU9et5gV0VKalWsBfNWhKbKGmyhvQh/lCiNo0ZndD5MuWLfgmBa61Ix5VJmaT9j6c+jvuAiquFHBcRL6GVAUt4zrHVP/evP/lMrqhWN0hqaFD0dOrulkzUQLx43UILMNwDD8Bc9/ZSqNzSxrrgvkKiYr6OXw2jxsG2QlzP91BaQvrLCOz1VB9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMOG0WR0LlpzjGpYtor46tsUQ2rKdyFkxqyyAGraOh8=;
 b=EGYEDqfVVua3BIeK8U2jOSfpPZcypVJJiUSQTnUS0Kjex9NbgajjgyWgOHCHfhSbNi5pmBGAEWfshrWnSWsyIejmxFYcyZ8SQAHP0TCi9ZSAk2r0qBJWE0JXHKV2rvqMEcTuP7fQvItIFTqoqyKnOdEqEHnRJOpNJFZsyfFJUCf8IUnUg3W4ohn0Tvo82d01ZaxxS3OIBCP0ND1V499+vADEhHcWkb9NPSJQ7ZBM6dCdYkfzIeiq6lJ2ORuWAqswB4fBwwysx5uOSBF58LPVEsmPEXE0MECs+JvgsolGgFG0NX5l7Wq+s8IUJerscSHStV7DM/BoRDg84UK8CFUiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMOG0WR0LlpzjGpYtor46tsUQ2rKdyFkxqyyAGraOh8=;
 b=kvuHvpx5b/MFZt4BAfBAmhjzefGJzLHgSpbRineFF3MDIbT1nl5NMW3cX2oWcdWDDTfAyQ7VKYL5jSM/LoZo9fA1T58cPfohWytdWH8If7VrzCq61G2P4uz7e/O+gb/KmuRJPUUe/soo8jKSGakZuP9die4fLMI6j3mLgSz9lOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 06:46:02 +0000
Received: from DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6]) by DM6PR12MB4123.namprd12.prod.outlook.com
 ([fe80::59d1:c9f5:2c67:1da6%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 06:46:02 +0000
Message-ID: <9c7c794e-f6d7-4092-90f1-13d44c2111f8@amd.com>
Date:   Thu, 16 Nov 2023 12:15:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: amd: add an error code check in
 amd_sdw_clock_stop_exit
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Su Hui <suhui@nfschina.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
        "Katragadda, Mastan" <mastan.katragadda@amd.com>
References: <20231115095407.1059704-1-suhui@nfschina.com>
 <3e461bb5-fa6b-4729-8ff5-ccc1d2887066@linux.intel.com>
 <5729c613-182b-43d2-a2ed-caff046b68e7@amd.com>
 <05147111-e46b-42a5-9e99-ec289e61730f@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <05147111-e46b-42a5-9e99-ec289e61730f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::17) To DM6PR12MB4123.namprd12.prod.outlook.com
 (2603:10b6:5:21f::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4123:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 39eeed03-5c58-4bcf-b893-08dbe66fb2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C79Yraf6gaae3j1Qq6yFwhHa8RCwM2hFBVPpF5BS16esNGHjg/VNEKRewIqZ/wMVptMdwIE9v7DykAsRRiqcm9hkZxrgkIXuSIAeGum6vZkv5XGGMIdSeiRKVi2Bh3v4r4zdL6ow7lfKPuSeU9YVbqvTfQWsxG+M1a3oO8qTqflLBGM6mkdKeXIZeT1AjP+Zr2Ey07+Wt75G2KXV2Im2LYd8f5m5UE1v5XrnfDbgmhVmOxf2EJ79ipErVyVOmFK+JZfmGSuEs2yyq5aaeq9NGSlCYhWFB6xHK//qqUIHVIkG8DTcByfDAyanLXi7jxZrSkDSaKyAMNSpaKcyjTbrLz630SxoJ+cZZEGzoXo22kS2xnLtd48jCnI0G7YpX+f+w/LHT3KmboWqJAWiGOyuLN3KHKRlfLAwYRJ9VjhNVktLx6DHkV/N3WRs7rP950rdqV05cxOO5Z1w3bomWlrG3e8TpA4wOv0aENmTCgAOEn+2aKFgtE2ac5MFQ3QLd72kzLc3wlIxaCTxDZ3AO+c0AY55/8aWKoNK/zTVahPP9grUuVMHBQMQz4SEMivdntN38bEodOVf3Am/lgNlgnFFDiRWgWOfM2WogQUMWPzAkHwCLZ7aKT91U7U0zfgO+/HGuzdJKPqaULbY1uzdtak/Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4123.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(66556008)(66946007)(66476007)(54906003)(110136005)(38100700002)(36756003)(86362001)(31696002)(83380400001)(6512007)(26005)(53546011)(2616005)(6666004)(6506007)(478600001)(316002)(6486002)(2906002)(8676002)(5660300002)(8936002)(4326008)(7416002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGhXYlJLMlZuTzZaMndIVS9wT0tUdHlLbXFuRGpjQkdvSWRpSFR3MzJtTkdp?=
 =?utf-8?B?YVFvV0diaVVjYmVISTNYWVp0Vzdmd0VkWC9ZZDI1UFJvKy96NWR4alM5dXBS?=
 =?utf-8?B?YmFSWVVmZ09Sa0FXc1I5NkV1NkFHdC9JZFU2Rm5pSS9OaW1BSTVxelN4c2s2?=
 =?utf-8?B?WlVEWXZoWEhDK0E1RVI3Q0wvWjNBNU5mejZXejd2RkJMVWJBSFowTXY1Z3Jp?=
 =?utf-8?B?SWF0R1lmUkl3UklKOW9VMzNwRFJmS2h2NjRrM0VteGRZY0NVNFZUOUlHNy9R?=
 =?utf-8?B?cXU2cTlDSXpWMzZkaGR3WkVCYnp1SnQwY29KRTZ0QThicWEwbnN4dVhUdE5M?=
 =?utf-8?B?djdRWUc4dFZKUkl1N1BzWlZsT3FiL25Lb3JhS0J3RFNqKzYwS3BVNERzdERJ?=
 =?utf-8?B?VGJEaVNuYkZ1NHRMaEtKdHJLdnkzeDVRc1AwM0FPWHp4MEt6Vy9Pa2p0TVI5?=
 =?utf-8?B?Q1BKQWtRWmNOSHBqTklHcVQyemx1Szk1MVR6ZUVMY0lzRkM1ZXE3Z2pOTjNH?=
 =?utf-8?B?WktGdnAvdnhaWnN2VjU1a0dzWTQxSnE3aWpkWmtmcFo5UVk1ZXJaWDIreERF?=
 =?utf-8?B?b3NZMjU1RllwajVXQjdGT1k1OWFvRy9jc011VlFsUXNZREFTV1hLVitkUTVz?=
 =?utf-8?B?bGRGMTUyZEczRFhrM01wempITDNONXlKaTVRSnpWTW8vbWo5c05zOVhpN25l?=
 =?utf-8?B?RzJXOGJDcy9GRXcxUHIyZWV4V2lJVzhoTFRTRDJqS0JDVzlDUkIyODNqREtE?=
 =?utf-8?B?RUFsZTM0SXEyTEJxeFRwR1F5NVBTVWd5amV5WktWUmpRSHNyUWxhcnBIdFVy?=
 =?utf-8?B?L1ZTdG5MNnluU2NYNWNkZnk1MEI1L0cxU2x4czdWSlJzUU9RU0lzVVB3cS9s?=
 =?utf-8?B?QUdCMFZvOXphbG5KVDZJVDdkYzRhVFQvYWtDYUdQK1drWVNxQVhRd3pIeDVy?=
 =?utf-8?B?aVJRdC8vR2svQkhmeFIrMmlWNTdUYm5ycHlhLzdYajVMb3I5UUx5TVpaMnM0?=
 =?utf-8?B?bGZOVFFqRCtNY3NJMTNwRE9pUUp1Y3ZQQ3A0em1keVN5VXhyZE1ianVkN3RQ?=
 =?utf-8?B?NmFiek1EUDlxRWNUcm9ONVpkNXBqL0ttT1hpditwU2lPa1VETWhTZGlJbnJG?=
 =?utf-8?B?amZETUVSVVBFOHBnTEdjRnB5L1BJUEI5ejdmN1djRmh0dFdPUWMxMGttUlBS?=
 =?utf-8?B?eHNYbTVseXJkSnhlT3dpNjFWV2o4T0d3Vk9sTjdUZXVIVTUxRTlycUJOc2ZZ?=
 =?utf-8?B?eEM2ek1pZkx6N2J3b1h1ZWNpSnArOThud1NZd29WVGZvQkJ2am1TbmxKbDRs?=
 =?utf-8?B?N1BIQ2d2Q0U1azlLRmZEVWs5UiszYXV3VEUrdVRaMm9Dd1Y5L1E1UzRDazZV?=
 =?utf-8?B?d0xaajNHYld6d0dKVVBmYnk2ajZscVZrMWlQVFNpaGNEcmtwaTY1M28rdjlW?=
 =?utf-8?B?K1E2THRzQUlBUXdtcmFBOWNiU3ovdU5Fd1NaK2plUnBPdU1jVU1vM2k4eDJD?=
 =?utf-8?B?VnA1cWxwNUk1aHlxaUgvbzhubk9kUDRGaXJxMDAvL3ZmN0ZrM3ArckRNUEZY?=
 =?utf-8?B?alZ6aEw0MWF6WktwSXM3SG5PTWlKR2lpQ3ozTnlrb1BJU3d4aFlSVGNLUEdP?=
 =?utf-8?B?ais5WGZvbTNRbEtzWERzbjhxaS92dTlFZ0s5U3hQaklid3h3ZWRhUm1pa05l?=
 =?utf-8?B?aVJZUHhDaHh0Y2FCbkxOUzZ6V1NPMnhkblh2aWtSdXBtakVVWEVHN083UERK?=
 =?utf-8?B?UXppZWZORW5ldFU2d1dHdGV6aHZwUWdHUUJpd2VTbU5UUzhveFl5NndxMXRy?=
 =?utf-8?B?UllpcHhWeE93MTlDOFNBZCtLZ0pjb0c4RCtTekd6MkxXL3g1VmhDT3B2S3dH?=
 =?utf-8?B?WEFpZ2V5LytySTdFckt1RWlBK296V0FnRjErNGl5VlVuaVZlUXBlU3htQmhq?=
 =?utf-8?B?ME4wVldyVzBYQmQ3MEZmL2w1eXhzTDNJcWU4NHZkcCtXWStPRG9LbzJDWHQ3?=
 =?utf-8?B?WTEzZVNlSVBBa2wxVG4rdHR0aVFNWVFTNDQ3K2JsdzhUano2VWxTb2tJQ2xP?=
 =?utf-8?B?SHZlbDNLYTNrV2hnUkd1YTl3L0JLS3dLbTdrZjYwaHlwOExObHNoaUZZOFRr?=
 =?utf-8?Q?ytmfRRLfYL1hlIBaorq86ZLV9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eeed03-5c58-4bcf-b893-08dbe66fb2c8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4123.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 06:46:02.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0m/JEUunvN3/pUE8xlDQSt4WwoLtql7Iq7b59pJimJ59d7XMcnt83j5YS9XdHuoR+ZqidB+LVTq6NES4XnoTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/23 01:21, Pierre-Louis Bossart wrote:
>>>> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
>>>> index 3a99f6dcdfaf..f391b541f4b7 100644
>>>> --- a/drivers/soundwire/amd_manager.c
>>>> +++ b/drivers/soundwire/amd_manager.c
>>>> @@ -1029,6 +1029,10 @@ static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
>>>>  		ret = readl_poll_timeout(amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL, val,
>>>>  					 (val & AMD_SDW_CLK_RESUME_DONE), ACP_DELAY_US,
>>>>  					 AMD_SDW_TIMEOUT);
>>>> +		if (ret)
>>>> +			dev_err(amd_manager->dev, "%s: timed out: %pe\n", __func__,
>>>> +				ERR_PTR(ret));
>>> Is this really the desired behavior?
>>>
>>> This patch fixes the static analysis issue by logging the error code,
>>> but does it make sense to continue resuming here and trying to exit from
>>> the clock stop mode?
>>>
>>> At this point a bus reset might be a more relevant behavior...
>> As per earlier discussion, when we sent the initial patch series,
>> It was communicated that even clock stop sequence fails,
>> return '0' in suspend/resume callbacks that why we returned
>> status as zero.
> clock stop is for suspend and clock stop exit for resume. Different
> problems.
>
>> In this scenario, it's not continuing resume when clock stop exit
>> sequence fails. Even In Intel's case, if the clock stop sequence fails,
>> just code is exiting from that sequence.
> that's right, in the Intel SoundWire drivers we never prevent the
> pm_runtime suspend from happening, and discard any errors. In the resume
> step we do a bus reset anyways.
>
> But that's different here, this is the clock stop exit which happens on
> resume and IIRC there is no bus reset. If the resume fails, what is the
> expected behavior? If you keep going then you are going to have other
> issues down the road.
We will check and come back on clock stop exit sequence failure
adding bus reset sequence.
>>>>  		if (val & AMD_SDW_CLK_RESUME_DONE) {
>>>>  			writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>>>>  			ret = sdw_bus_exit_clk_stop(&amd_manager->bus);

