Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3067CF90F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbjJSMfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345491AbjJSMfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:35:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F9191
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697718912; x=1729254912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aNuHrmvvV3ES+I56hhsLohnyPRQbxLRSYoV5qh1Y31A=;
  b=L8o66SmYEf28ojKvH7PILExwxToQ/12VzYL9Ow2PyCrpDUKZKqhweZ+C
   AYDgi7itlsm5r4O+SKQKJSqLkcfrIoj6PsstvHdOslztJt9P3g07Bxe2T
   cjDTYd2MKWxmckP+jPSlFq1jOWiQRc4JD/NJUxcY4SNr+kd2tVRri+LUZ
   6zb2jF6oyxcfbeG045Lj3hjo1NI9TWE9TiYt+dQmngNxORuVVX3J0BeqD
   uJUGzqErHbzNJVlB1wLKNPQtvtpbbi4L5N0xdhPBCZ1yH2pPSnX8SOb+f
   CFmKsZFfjHG4xFwkd6GEw3JX85bIpGrtyT7WpbHgl1z6UWsKNCr5JM7KJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="452707378"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="452707378"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 05:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="757005011"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="757005011"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 05:35:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 05:35:07 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 05:35:07 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 05:35:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxPUqALGmFdUQfmPexOdpTsHZJE64ogDkNMamwUQsK7P0JeeYiDUJoSrSlG+l8YeRqmUrwZ7Gsp/oV/TabXFhvIYJBGYWcKRjJfOBMOiMcK2GjtWD9AaxiqZIaqvYcWyzbiVCp/u87mrXChrHsqAZPXwlLiIq+zwdi9+9b37nyuvIvpHfWO3jmoYTM3vQa5F8MF0CLLSti86HJyu88wLGUwRoG8WvyBNB+Aw0gv6QNDFP8RHoj4qGVk9ti3XStJtNvBi6YvwCofagbxFpLJ7gIfncri/QlB+RuissoqVF0LGCc7jjYn6sr/icwNzJmdd6utfdoO5a3nQQfdwlRNTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/+k+P04c5unQ5v7POxix5W0IM5l76zZh2Moglp4DaI=;
 b=auvQyg+6WH4qiGF3UTnUNcFPEciJXN7qyG6qTbSrrB+bbBio2FrgWEL3hTxcHsZVwR1jUZgdGwIMRBxua4UER8XhuZr6z4wv4QgAlcvnwJIbq07S0MTqj7Sjb6BQzh0nwdK51SAQxGjg8wvKYqWzw/MLXlc3ZjX1Jag0Om5whtrGq0ayicKrRciGK8kKIiYtYYoMaIGTkMmaGWBqOVLv4sEWrQ9zHLc2kodp1o8plXCa9LXVuPX9pfOGy8FC0YPk8DZQxAy4J/9sVzmKTP6KW29TacP0b5jAM2TbUewLV9w/Y/13b6FCAqog3JYjTZTfWr9uLihMhSXySWFnqbPRUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by SJ1PR11MB6275.namprd11.prod.outlook.com (2603:10b6:a03:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 12:35:04 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 12:35:03 +0000
Message-ID: <15af6841-17f5-2bf0-cf57-597ce3cf9b6f@intel.com>
Date:   Thu, 19 Oct 2023 14:34:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
Content-Language: en-US
To:     Calvince Otieno <calvncce@gmail.com>
CC:     <outreachy@lists.linux.dev>, <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <ZTD677iqMkRPxT27@lab-ubuntu>
 <93a6d8b0-140c-983e-1b78-6f5a4e03e62e@intel.com>
 <CADFX3OTHX=5jNm8aaUyC_RzDPntiL4ZC=Jj+8bZPjHNmZwUs9A@mail.gmail.com>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <CADFX3OTHX=5jNm8aaUyC_RzDPntiL4ZC=Jj+8bZPjHNmZwUs9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|SJ1PR11MB6275:EE_
X-MS-Office365-Filtering-Correlation-Id: dc151d4e-0e28-4d84-05ad-08dbd09fd111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rEgtjE2/Kl6dOAGu5VcJO71rZ6AAcKCFBXvE3mrbLrY5cyUQCxdfZ8w8XjUVZ98SfmB9GuviMY0kZnlr9CRx4GgtvBranu0e6T+RmZpJknhujOWgl2mD17+9AG4XMz6pmdOWE8cmTTScYoC1PbfESzjAwLku7SijmY1OyJoq5A537/LMp0JLx2TAdAySWtrnUYtuuxUUSrbj12BeW82ZZ390tcB9bgdK8Oc1OzcYz3pboHS7VLfN30ac/9ILTHU+h4W7uv6rBa7E1ZNdCRTUvUMnmeQkwQWtOIFSqBQ/m0Gj2gd/a0Gfk3Y5KqbzAfgXbc8RLQNy7EiIHTyPV7mOO8Nf8LbxmEbNyltp+2v8rED5l7resKF1tXCk7Wg7qEC2S/Q7wZ7zPrE6Md8dR247UuYVr6qdnNCncVFp4rzbreqPwCuVh4LMo1FcffbXNAe/V7E0vRvn6px5nGP6UE+12dITQZR6TKpo6aG6zU/JM0maJyQua/DFHjco3YT99rGptM09OO5X6gPSdJjzUeY/XKZ5j2YHMy6EaxK7msfWThGyW3P0NmjMqzLjjdqFgrp2WiELAZFwitiZbxR4pujDPnXHYPU3Bdmy3QFZoQB842TeLLkX95l5JYNYKB+FnT/fgK9RFudlbI5qWtr1x1etdU7p9/PeT+cmQCng9esrpzHeEqiwopcAeV1aATmJm8bS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(31686004)(66556008)(66946007)(966005)(478600001)(6666004)(66476007)(6486002)(6916009)(54906003)(86362001)(82960400001)(38100700002)(6512007)(83380400001)(8676002)(2616005)(53546011)(36916002)(316002)(36756003)(31696002)(5660300002)(41300700001)(4326008)(2906002)(44832011)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZnSTVPVnoxZkgvcThlaVl5TENoRDREOE5QelZjdVVPd0VDK3lQUEE1ZlVI?=
 =?utf-8?B?YndudHd2L0s4L3JiV1djS1JteEVGY1MrQlJFRWFlT3YySzdQSEsvUnUyUDI2?=
 =?utf-8?B?MTkrRkt4cHE2VHFFYzZzWHVxeCtWYUFMaHJDNVR6Rkp2MkVYd08yTHoyRG04?=
 =?utf-8?B?NVAvT21IdmZodDVTQUMzRTBtM1RKK2JXc3ladTE0Vk00eUE1UmluTDZYWnNS?=
 =?utf-8?B?VWFhY0pRUmdTVERnQ3ZPbUN1S2FZRExVeTh4UXB1TmgxK3VINFh3aUhRKys1?=
 =?utf-8?B?S0c5ckVCeXN2eTZnYy9ESVZWWG5yaTJ5SHVKdUVDK1NYbGFIdjFWUFFGSjVq?=
 =?utf-8?B?SFFtK2NIZEptTjlZcG9XM0lYVjExL3k3RHAxWEhRQTU5K0RzdUFJTDFYRjBa?=
 =?utf-8?B?QXVxdXpnUkRQaXZVdERuTFhCSVNzMjd4TGFRZHd0VmZuakFhUVhSRFFyUExr?=
 =?utf-8?B?QlZ2R0NiNmpYcURIdi84L0tRU21KUFNIZW9aVjRzSWVHSFM2cXAvc0ZGZGxz?=
 =?utf-8?B?MG5aMkxwamJpR0pwa21oajVIdUFQWEVRd21FbVd5UHViejZaZXRsNzdHcUJK?=
 =?utf-8?B?UDVWSS9EV1NGektoN2VHSlBjMC9UTEVhV2lLVUhzRG5CVVgzWTkwMDI1b00z?=
 =?utf-8?B?dmJLUUNjdm1JUnFFdm5SUEE1eTc5K1lCVHdIYTN6anVaVWE1N2dnZUZxa1RX?=
 =?utf-8?B?SlZQUjVEOSt6eHVLZmw5aGI1OWtzZnNPd2g1TG50L01uTEp1bWlZNFRsVWk0?=
 =?utf-8?B?QVR4cGVDWDBBa1FkQTAvTCtiK0gxR3VFT2tnQUFEa2tJTWREU2lkZkRpMHRD?=
 =?utf-8?B?dk9DOGlERm1rcWx4aWhBdlpWMjhQQ1VrYUpJVFZRcTFPRUxnWWtoUlJoZmE0?=
 =?utf-8?B?dG10dTRCVmU1VVB0Ymc3QldXcWFHWG5TRzhJZUZ5WERZbHArcTY0bE5xRnha?=
 =?utf-8?B?VThVckdnVk1ob3BVdzZKcCtZOVZqMjFDRkVlTDZzM1kyajBTMm14cE40K014?=
 =?utf-8?B?bVFkT1lET05sTm0xSUIvV0ZxZ1RCanNsc1oxS0UxZVVpdElwd2s1RUU3OFZU?=
 =?utf-8?B?Ykpob0xQbTUvYnNoWFVXZlAzL3Raeld3NnU5cVdET1ZuUW5ZWWNpTnY2dTFI?=
 =?utf-8?B?elZEcldsWlUwWGg1U0JYdE1zYlpYWExpdmx3dTNCek5CRy81N3lTZzBKd0Z0?=
 =?utf-8?B?OTFmZ0dCM2svTGVoUHRCK1E4NDRRVCtLWUU3SlhobTRhN2ZwTGE5QnNlVTY4?=
 =?utf-8?B?MHUwdXpqK1Fzdm56MzVvRXVMcWpSWkF4d1pTMnJsVjV5eFFYM2NKYU8wakNy?=
 =?utf-8?B?Rzg0RFh3TEwwMjNqZGx0OHAwZ2ZVdzhBbG95N0hkVXJDRnJvUWxqU3FNeDc4?=
 =?utf-8?B?eUFwYVRFU1ljU01hQmhMays0cjkzS0owRDBkRDMyVERZNkRoWmVRVGNSeVZY?=
 =?utf-8?B?K3lDbSs2V2VpWjd2L1QvVG93bi9oUHlNZFVtWWZ2NFJKWDR3cFRCeCtYeUpL?=
 =?utf-8?B?OGVOa1hLQjM5OVoyT213L1poSHZWYXZGVU44VStyQm9VUlFCd3FaOGo3S1NR?=
 =?utf-8?B?RlQwVkZSY1prQUFLWWw4WGJKMWRvbUFrVE4xdzdteFZNWDdhbWh4cVI0bUlm?=
 =?utf-8?B?dERyZDR4MXBhUGtDYkprTHVRTW44RzRibDNiMEJ3RjJydFdqZ1dtdHFBcmxG?=
 =?utf-8?B?eS9LemFJSVVWL2s4TXJkUFg3dXYxV3ZPTGZ4RGx5N1BCYzNvRWtwQUd4anFU?=
 =?utf-8?B?RjFCejBEQU9iRlpUT2pyVUNRQW9ETXpBV3JFMGNaVXdlK0NqdXk1V3ViemUx?=
 =?utf-8?B?NHhBTXY5MTh6dEJQMWhIL3Fyc1duem90M2VJM09uY0RkcHI4UE9YT0w5ZVZw?=
 =?utf-8?B?SkxnVjVGVitBMEFCdnBiNTZEVGdseWRsaW40dlFVcnFaOVBOVnZhV25aS3Iv?=
 =?utf-8?B?aUNwcFVlOGVTbkJhQjlrbXdBRVRBNlBUYjZ0NGdTbGpNQWp4YVVmWkRjVTFi?=
 =?utf-8?B?cnQ3d281c0xyZVJ6Y0huNW0xbVA3d3pUMll6OGFscDM3d3FDTjA2eGI3L2JT?=
 =?utf-8?B?RzNkTGtuR25jOXpQY0pkOTV6aGpxeTE0YlFiR2FrMmFIaENOVEFLL0tUWnRk?=
 =?utf-8?B?ZEFUcVNEWVRTV2t6dlNLam9Cd3ovRFV2YitzREFkQXJiZktIZEpMTnhaYno0?=
 =?utf-8?B?cU85NG9nam1xMHoxcmowS1ArQmthcjlkSERGdFJkbmZrMFphQU1QeW53b0RW?=
 =?utf-8?B?Y01aMldxa3JiZnR4N1pzaFRPb1VBPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc151d4e-0e28-4d84-05ad-08dbd09fd111
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:35:03.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEQgOH/26ooNJ3nBmS95kGXT+9E+rrbK5FgOXzSQHbGyiXpQFJfT7PvDuRhkMuVFO0XZ54NPdzsJ7pOLqDn6lKodogOOz5iE6LqFpAd/nvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6275
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.2023 13:21, Calvince Otieno wrote:
> On Thu, Oct 19, 2023 at 1:55 PM Karolina Stolarek
> <karolina.stolarek@intel.com> wrote:
>>
>> On 19.10.2023 11:46, Calvince Otieno wrote:
>>> The functions vchiq_debugfs_init(), vchiq_debugfs_deinit(),
>>> vchiq_debugfs_add_instance(), and vchiq_debugfs_remove_instance()
>>> are declared and defined but contains no code or statements.
>>> They do nothing.
>>>
>>> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
>>> ---
>>>    .../interface/vchiq_arm/vchiq_arm.c              |  3 ---
>>>    .../interface/vchiq_arm/vchiq_debugfs.c          | 16 ----------------
>>>    .../interface/vchiq_arm/vchiq_debugfs.h          |  8 --------
>>>    .../interface/vchiq_arm/vchiq_dev.c              |  4 ----
>>>    4 files changed, 31 deletions(-)
>>>
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> index eef9c8c06e66..b802d1ecc8f6 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>>> @@ -1806,8 +1806,6 @@ static int vchiq_probe(struct platform_device *pdev)
>>>        if (err)
>>>                goto failed_platform_init;
>>>
>>> -     vchiq_debugfs_init();
>>> -
>>>        vchiq_log_info(vchiq_arm_log_level,
>>>                       "vchiq: platform initialised - version %d (min %d)",
>>>                       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
>>> @@ -1838,7 +1836,6 @@ static void vchiq_remove(struct platform_device *pdev)
>>>    {
>>>        vchiq_device_unregister(bcm2835_audio);
>>>        vchiq_device_unregister(bcm2835_camera);
>>> -     vchiq_debugfs_deinit();
>>>        vchiq_deregister_chrdev();
>>>    }
>>>
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
>>> index dc667afd1f8c..7e45076e5ebd 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
>>> @@ -228,20 +228,4 @@ void vchiq_debugfs_deinit(void)
>>>
>>>    #else /* CONFIG_DEBUG_FS */
>> We need to have these definitions, so a kernel with no CONFIG_DEBUG_FS
>> selected builds. Have you experimented with this config with your
>> changes applied?
>>
>> All the best,
>> Karolina
>>
>>>
>>> -void vchiq_debugfs_init(void)
>>> -{
>>> -}
>>> -
>>> -void vchiq_debugfs_deinit(void)
>>> -{
>>> -}
>>> -
>>> -void vchiq_debugfs_add_instance(struct vchiq_instance *instance)
>>> -{
>>> -}
>>> -
>>> -void vchiq_debugfs_remove_instance(struct vchiq_instance *instance)
>>> -{
>>> -}
>>> -
>>>    #endif /* CONFIG_DEBUG_FS */
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
>>> index e9bf055a4ca9..76424473c32b 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
>>> @@ -10,12 +10,4 @@ struct vchiq_debugfs_node {
>>>        struct dentry *dentry;
>>>    };
>>>
>>> -void vchiq_debugfs_init(void);
>>> -
>>> -void vchiq_debugfs_deinit(void);
>>> -
>>> -void vchiq_debugfs_add_instance(struct vchiq_instance *instance);
>>> -
>>> -void vchiq_debugfs_remove_instance(struct vchiq_instance *instance);
>>> -
>>>    #endif /* VCHIQ_DEBUGFS_H */
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> index 841e1a535642..953f39f537a8 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>>> @@ -1185,8 +1185,6 @@ static int vchiq_open(struct inode *inode, struct file *file)
>>>        instance->state = state;
>>>        instance->pid = current->tgid;
>>>
>>> -     vchiq_debugfs_add_instance(instance);
>>> -
>>>        init_completion(&instance->insert_event);
>>>        init_completion(&instance->remove_event);
>>>        mutex_init(&instance->completion_mutex);
>>> @@ -1297,8 +1295,6 @@ static int vchiq_release(struct inode *inode, struct file *file)
>>>
>>>        free_bulk_waiter(instance);
>>>
>>> -     vchiq_debugfs_remove_instance(instance);
>>> -
>>>        kfree(instance);
>>>        file->private_data = NULL;
>>>
> 
> Could you kindly clarify what these definitions are doing.
> At the moment they do absolutely nothing, I might be wrong

These functions have different definitions, depending on the value of 
DEBUG_FS[1]. If this symbol is defined, these functions create entries 
in /sys/kernel/debug, which are useful for kernel developers. Please 
mind that these functions are defined twice in that file. For example:

https://elixir.bootlin.com/linux/latest/source/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c#L206

https://elixir.bootlin.com/linux/latest/source/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c#L231

And like I said before, we have to also define empty functions, so no 
matter if that config option is selected or not, the kernel can be built.

All the best,
Karolina

---------------------------------
[1] - https://elixir.bootlin.com/linux/latest/source/lib/Kconfig.debug#L626

