Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C67D79D450
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjILPGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbjILPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:06:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2731BB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694531178; x=1726067178;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y1EwiLn55memF6BEhBO+KbsZJyctVBaVPdfY3mjLNw4=;
  b=eTC38Vo4m6lEqPWoR9qGom1ekst0Mo7+OMIhzybbbXKZ9HAGK4YC/SHn
   lmCHkZhXFOU/zXd7/fRtLxgSnfDCAKJjHI84dYLrlaW9JfcECaNjUn0KE
   0teIBYuEjGBlDfe6zY6v1gQe7LNA9VHK4KdOiwsDQvwNGVHp3nwLVcdWK
   UqRCnSF7/N8zQt9McQAtJClhl7xC+4tucfpIuL45fqwhVXw55Bthshvpp
   05NB/0laDqfcvFobcBR/G7IReazctaSLWzPwQNDmlLJvJ/txtsGWHCBnW
   MQYIqNrpOiQtoDq9vvPDt5D/B7fd6qq9PKlQfux5r/wPxBAPr8VHXa8y0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382210788"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="382210788"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917452655"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="917452655"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 08:05:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 08:05:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 08:05:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 08:05:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib8EVOJ8pATfyi7v2Azkvhaagj6nUQAPMW1tDjvprFHN03jsH3+uN/yA4blgfYLbmiCdi4UsawjNFC4l8sIKVbNrvGK5NASBLCMd8q2VkJcOfn4sur29tkg1BiDdR/+1AMQDrHQrY48Nr1c5iHvY9kH+TcMEb6RpjnlBsKougIDvUorDeqfPy4V1PH3fzspVLyM8KoQrbuH5sBd5XABIHvZiMyLSgTL2rUPBxn97ySApWydBpyBB7laT3LxgDUMO0Ym41dOxG+bXMF6YZljn6CafpWZB4HQg6D/NENnzkyZI64z9/uHaaY+n8UMwhOLclhfsXNKvJDAEWUlo8hxPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkP9B5UUEJ+5lLDjNQ8j3GxtqpPqiyrV1Un76y2YVSs=;
 b=GO0ubMuTm30K3M7W3w6Tmr6QQqQka899aZ5RM9jeMZA/JB54hFrKNG5eYoQLLMYIQjwXpvwRoV1uDfKz47IKhns3pqUezNLt65YmhLLf0yuy8ygrYpNcEV9QdKH2iWJ6GMRwJqvy8qTjj8oMQfChEr6OmkqZI/gfDAbaVSrmOX9jXWFj5SjzeMOH5YS6NrbJIO6CK/SFwXv9RUXLI7IJWgK+1BmRW3cOiS1VfqTiJTpJ0KiLz9JcYC7vQjDJmoTw65MKSoCHOfCiamSCjtbJkywfmPeixIXQJKVQHj21959cRWvGrXpjGdU8AJ4Ncq6ttqDpZJZu8m6ALHWR2bn0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 15:05:21 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::4b20:e34:71f:139f]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::4b20:e34:71f:139f%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 15:05:21 +0000
Message-ID: <5521adaf-724e-4de8-ae56-74dc349b66c8@intel.com>
Date:   Tue, 12 Sep 2023 08:05:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/xe/gsc: add gsc device support
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
CC:     Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-xe@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20230912130835.2488728-1-alexander.usyskin@intel.com>
 <20230912130835.2488728-4-alexander.usyskin@intel.com>
From:   Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <20230912130835.2488728-4-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PH7PR11MB7605.namprd11.prod.outlook.com
 (2603:10b6:510:277::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7605:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: deb31454-86eb-4f3e-5bfa-08dbb3a1af43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdQb+RuA8DrBrClsC9NFln7GmUT8Pngk1ebZFCeBAH8OV2/ee4qACMaA1Ev9Rw3iswTiMu2DkKKDF73iMOv5fDuAf2bBstcerOwH7oTYpuPR3m2zlpNT/u1016VQgeWRnhyjhga4iXDpaVxU3OT5m0NfgOSdRTU7aXjVqORAFwtun1LfWxEwftrroXMiJi1y+LM/L7HDvUTCMqz3bRUwxGvy7ILXTfAJ2wtZG0GCef0MUr+M/NSl1rqdaPB+8Oj7QGUpiz6ldPQnctt3XFv23cFuHiwd1sOA+VU/GLYscx0tV1g1OLMDapnNIoCmKr1pLFAnAa3RNVUDNrq3YTIO6q3km5b2ii4F6umhsmBGtqhp2vOTcpTPdiOyQhW8d6HsMFwOZL0ZrTDAAikfhcC6IgjfGSKk0k7eJ+KFZrcuhmWZM1DYmrK8+UUdXsogYaG9tyD+y8fx/3hCk7fmxlxE2W8SqzFzy8g91ycAAIBhH/cG4ts7delmHtcXOEZ7HxOrOcETuC16iafQKDmVCAepjL5kJa7MZx07apRlMdBjjBhz2S+Z7du7JBryeJFTojE5goOHX2NvoWemTsmenJhJTxoJyTQ/YAaDdYMXnLEIPUXt2VN+USOQS/SnM116oi9c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(66476007)(41300700001)(478600001)(83380400001)(4326008)(5660300002)(8676002)(8936002)(6486002)(6506007)(6512007)(53546011)(6636002)(26005)(316002)(110136005)(54906003)(66556008)(2616005)(82960400001)(2906002)(31696002)(38100700002)(30864003)(86362001)(66946007)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzljT3FpZjgyb3V4OHVTSFd0UzNQbzhyL2dWYXZhTndlMWN2SExXdjMzSk5L?=
 =?utf-8?B?bktTOU9DeVZvOGpvenduZ1FyYnI0MDNjTVlnaVhTMGRzMnlQVC9BNE10MGJt?=
 =?utf-8?B?dVlkdWJMZ1lFY0xBbGk4UjJJcTl5L2wyZWRkcXRjNmZGcXZYaEhJZVBxQlhh?=
 =?utf-8?B?bTBYUVltTGYzc2UzcGozbkZpZ0hMNUp3QnVhbGZEOXpZblFiM2YwUjF2Tkky?=
 =?utf-8?B?U29aMFZTTjNVaTdwV3YzcDhZYXA0bXRlWUZXbHNLb3VpQ2VmMzAyam9MTXBh?=
 =?utf-8?B?QmUxM2U5YlZ5aXpQWHc4VTMwaTVLUElsRFp4N2tRQUo2bGo1aldCRERhNlZl?=
 =?utf-8?B?SmxFV1V6Zk81VjRNRHFGbXI5TndDd2pZZVlIYTFCL2NodTVvV1I4ZUdQQWFB?=
 =?utf-8?B?WEJEelBDckszNG9SdWY1NGV3WjNpcnNhSDEydnA1MUUxUjdRZ0NoQ1c4SGFa?=
 =?utf-8?B?anRHbVFNbnBHNEx2KysvS1VtakJIK1p6QlpTZUpIT2ljdjROYnpIU1dnNkNR?=
 =?utf-8?B?dW5MMzVVdlNoTVFHQmRSSUFMNXBHWG5CeVZVQjFhNmlaUjNuUjdKa3pHbllS?=
 =?utf-8?B?eWNORG9sQU53cmx3dEFPQVB3akUzRmNRU3lKd0pLUDlNQTF6T2Q2dEVncDR4?=
 =?utf-8?B?Z0JuTTIvTi90dHJIMTgwM0pZRExqZjVvU2V3TTZvNklST0ZUVERmUloxQkMw?=
 =?utf-8?B?c25QRWlHQzZYMlp6VDBkQmlQejdxKzBDWFE2M04zdkU1YytRU0RvdGRvVC9X?=
 =?utf-8?B?U29RQUZNWU1ROUQ2Q2dmWVhTRHUrdml5blJKQzFFaVcrejBhdmNFaHZTbWdE?=
 =?utf-8?B?UlFDL3NMTXUrMDNxTmQ3eEQwb1ZybG13M2N1TC9Sczdha29QSHMzL0orOGNm?=
 =?utf-8?B?TnBLMU53MFNJMkZZcVpjOHVGRmVoQW5FWlA1bU5tbzNVbVpWWDdKZWFaZ1Nu?=
 =?utf-8?B?eFMxVlg3UkFPZGZjOVdTbHRNRHNaUUtwOXE5T0s2emFrNVQzV0h0d2xCYU1i?=
 =?utf-8?B?clg0UG5SbFNhZ0NZZ0VrQmc2Z05nZjNUYVN6dWZFa0w2anUwVTZTT2hENXRC?=
 =?utf-8?B?Y3dmUWJrRENqbFRIV1MvUC9QY1FMSGJxemViaGMyamtKcXZYREVRdzk3SDdZ?=
 =?utf-8?B?UjREZWcveXA4WXJuSzBhajZ2SlRKNWxhZ3hvdTBRVWdyS2U1aUVvaGswV0ZV?=
 =?utf-8?B?U3RNdHdZU3NiSm9LS0RabjN6T2J3cnc4K3lqSUlxVUI3R2ppTWJHeUpvY0tl?=
 =?utf-8?B?OEJnV3pacSsrblhVWWRDN0g1ZTRpOGZxazBlcW5paE1BSyt1UkxlN2g4c296?=
 =?utf-8?B?MnlNVFBxZXlxcmluQ0s4MUtnak85VUw0bGxNbGFyOVJlRGttQVJnbE9OL3lD?=
 =?utf-8?B?bkl0WmNkUlBCUHNEVGxpcHh2UnZ2b3ZYSXZpeHBVSXMyemROTDh1dlhOM245?=
 =?utf-8?B?YWRqY2E5OEkwK3ZyeHR6bDBISW5vNlIvUmFKTndBM3ZuU09BRW5oQ2lIYkRT?=
 =?utf-8?B?RTFrTHNkZ2hwZnRQSmVFQTgySVdjOUtUYTZHV0pTdUMrbTkwTUNVekxhNWdY?=
 =?utf-8?B?OGNwOVNTc0ZYdGk0YUVTZ091V3QvdkpVc29nc0k0S0RWYVg3KzU3YTEyODM0?=
 =?utf-8?B?YjgycVhnR0ljYno3K1N0c1VaTSthbGRFWnZmTTVVUjFHMVZKbThSQWYxdVk0?=
 =?utf-8?B?WjdLTy9IRGpYMHZxcFZ5K1Vac0EzZk5oQWFkS2g2MUdqK0RMNWFnQWMxZFpq?=
 =?utf-8?B?cXRnZ1oyaGY1a3hUZndrc0hpbGNGTTByR2ZiR2dQM2ZBNTMyazlwVDM5eVdN?=
 =?utf-8?B?aDVhaXV2K05TUVJ5Y2FMdEUwWlAyVTJ3RnQ3UEFQVG9rMG9WLzZoWm0zenVZ?=
 =?utf-8?B?dGFEMGducm5SdjBidGRodUdxbHBlUm5HQ3V3NWE2V2g0aUNDa2ZGOUJtUDNr?=
 =?utf-8?B?THFubUdXczByUVVGMjMxc1M1ODFvQUI5RFEyeTFYNS9WZVcyQlpqenBHOVNU?=
 =?utf-8?B?blF2QURDRURSRS9KL2RaYzRCcjk2Y3FyMFRtNlpmcUlLMDVBK3BKbjRaLzdl?=
 =?utf-8?B?NVZoVzh3M1Q5Sm1Uc3p4enRxTWErUWsyUm1XYnhIc0pvRVNlTXRZT1NIV1FT?=
 =?utf-8?B?UDF4azlMYVltTGZSL0o4RW81c3gwYVhlSzdnRWFKLzJrY1RNaUdiY2pFSU5R?=
 =?utf-8?Q?1jWsJmG1I8eLe2668VfO81I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deb31454-86eb-4f3e-5bfa-08dbb3a1af43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:05:21.6998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hTTuHCEcjanaQU81LRDe0fuPfhrnzNMlFMf04JzScEYd52ksRkM+ugqthcy2NIsrXLhdSNEKAKUdYyTmVmA/2BCHbMG5COTlz0lamDu+jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/2023 6:08 AM, Alexander Usyskin wrote:
> From: Vitaly Lubart <vitaly.lubart@intel.com>
>
> Create mei-gscfi auxiliary device and configure interrupts
> to be consumed by mei-gsc device driver.
>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---
>   drivers/gpu/drm/xe/Kconfig       |   1 +
>   drivers/gpu/drm/xe/Makefile      |   1 +
>   drivers/gpu/drm/xe/xe_gt.c       |   4 +
>   drivers/gpu/drm/xe/xe_gt_gsc.c   | 218 +++++++++++++++++++++++++++++++
>   drivers/gpu/drm/xe/xe_gt_gsc.h   |  36 +++++
>   drivers/gpu/drm/xe/xe_gt_types.h |   4 +
>   drivers/gpu/drm/xe/xe_irq.c      |  11 +-
>   7 files changed, 273 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/gpu/drm/xe/xe_gt_gsc.c
>   create mode 100644 drivers/gpu/drm/xe/xe_gt_gsc.h
>
> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
> index 0a4ea965645b..9d396ca7708a 100644
> --- a/drivers/gpu/drm/xe/Kconfig
> +++ b/drivers/gpu/drm/xe/Kconfig
> @@ -36,6 +36,7 @@ config DRM_XE
>   	select DRM_SCHED
>   	select MMU_NOTIFIER
>   	select WANT_DEV_COREDUMP
> +	select AUXILIARY_BUS
>   	help
>   	  Experimental driver for Intel Xe series GPUs
>   
> diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
> index 9a2245ffede2..9ba9389a2cfd 100644
> --- a/drivers/gpu/drm/xe/Makefile
> +++ b/drivers/gpu/drm/xe/Makefile
> @@ -65,6 +65,7 @@ xe-y += xe_bb.o \
>   	xe_gt_sysfs.o \
>   	xe_gt_tlb_invalidation.o \
>   	xe_gt_topology.o \
> +	xe_gt_gsc.o \

I don't think this should be inside GT. The HECI GSC is not inside GT in 
HW and the only reason it was added there in i915 was because it made 
the interrupt management easier. This is no longer the case for Xe, so 
this can be added directly under the xe_device and match the HW.

>   	xe_guc.o \
>   	xe_guc_ads.o \
>   	xe_guc_ct.o \
> diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
> index 4c7f66647a04..f373c139e1a1 100644
> --- a/drivers/gpu/drm/xe/xe_gt.c
> +++ b/drivers/gpu/drm/xe/xe_gt.c
> @@ -76,6 +76,8 @@ static void gt_fini(struct drm_device *drm, void *arg)
>   
>   	destroy_workqueue(gt->ordered_wq);
>   
> +	xe_gsc_fini(&gt->gsc);

I'm not sure this is safe. gt_fini is called from the drmm cleanup, 
which means it is called after the Xe driver has already been detached 
from the PCI device. That seems too late to destroy the child device, 
IMO that should be removed before we detach from the PCI device.

> +
>   	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
>   		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
>   }
> @@ -460,6 +462,8 @@ int xe_gt_init(struct xe_gt *gt)
>   	if (err)
>   		return err;
>   
> +	xe_gsc_init(&gt->gsc, gt_to_xe(gt));
> +
>   	err = drmm_add_action_or_reset(&gt_to_xe(gt)->drm, gt_fini, gt);
>   	if (err)
>   		return err;
> diff --git a/drivers/gpu/drm/xe/xe_gt_gsc.c b/drivers/gpu/drm/xe/xe_gt_gsc.c
> new file mode 100644
> index 000000000000..ed825c883da7
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_gt_gsc.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright(c) 2023, Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/mei_aux.h>
> +#include <linux/pci.h>
> +#include <linux/sizes.h>
> +
> +#include "regs/xe_regs.h"
> +#include "xe_drv.h"
> +#include "xe_gt_gsc.h"
> +#include "xe_gt_types.h"
> +#include "xe_device_types.h"
> +#include "xe_platform_types.h"
> +
> +#define GSC_BAR_LENGTH  0x00000FFC
> +
> +static void gsc_irq_mask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static void gsc_irq_unmask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static struct irq_chip gsc_irq_chip = {
> +	.name = "gsc_irq_chip",
> +	.irq_mask = gsc_irq_mask,
> +	.irq_unmask = gsc_irq_unmask,
> +};
> +
> +static inline struct xe_gt *gsc_to_gt(struct xe_gsc *gsc)
> +{
> +	return container_of(gsc, struct xe_gt, gsc);
> +}
> +
> +static int gsc_irq_init(int irq)
> +{
> +	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
> +				      handle_simple_irq, "gsc_irq_handler");
> +
> +	return irq_set_chip_data(irq, NULL);
> +}
> +
> +/**
> + * struct gsc_def - graphics security controller heci interface definistions
> + *
> + * @name: name of the heci device
> + * @bar: address of the mmio bar
> + * @bar_size: size of the mmio bar
> + * @use_polling: indication of using polling mode for the device
> + * @slow_firmware: indication of whether the device is slow (needs longer timeouts)
> + */
> +struct gsc_def {
> +	const char *name;
> +	unsigned long bar;
> +	size_t bar_size;
> +	bool use_polling;
> +	bool slow_firmware;
> +};
> +
> +/* gsc resources and definitions */
> +static const struct gsc_def gsc_def_dg1 = {
> +	.name = "mei-gscfi",
> +	.bar = DG1_GSC_HECI2_BASE,
> +	.bar_size = GSC_BAR_LENGTH,
> +};
> +
> +static const struct gsc_def gsc_def_dg2 = {
> +	.name = "mei-gscfi",
> +	.bar = DG2_GSC_HECI2_BASE,
> +	.bar_size = GSC_BAR_LENGTH,
> +};
> +
> +static void gsc_release_dev(struct device *dev)
> +{
> +	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> +	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +
> +	kfree(adev);
> +}
> +
> +void xe_gsc_fini(struct xe_gsc *gsc)
> +{
> +	struct xe_gt *gt = gsc_to_gt(gsc);
> +
> +	if (!HAS_HECI_GSCFI(gt_to_xe(gt)))
> +		return;
> +
> +	if (gsc->adev) {
> +		struct auxiliary_device *aux_dev = &gsc->adev->aux_dev;
> +
> +		auxiliary_device_delete(aux_dev);
> +		auxiliary_device_uninit(aux_dev);
> +		gsc->adev = NULL;
> +	}
> +
> +	if (gsc->irq >= 0)
> +		irq_free_desc(gsc->irq);
> +	gsc->irq = -1;
> +}
> +
> +void xe_gsc_init(struct xe_gsc *gsc, struct xe_device *xe)
> +{
> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
> +	struct mei_aux_device *adev;
> +	struct auxiliary_device *aux_dev;
> +	const struct gsc_def *def;
> +	int ret;
> +
> +	if (!HAS_HECI_GSCFI(xe))
> +		return;
> +
> +	gsc->irq = -1;
> +
> +	/*
> +	 * On the multi-tile setups the GSC is functional on the first tile only
> +	 */
> +	if (gsc_to_gt(gsc)->info.id != 0) {
> +		drm_dbg(&xe->drm, "Not initializing gsc for remote tiles\n");
> +		return;
> +	}
> +
> +	if (xe->info.platform == XE_DG1) {
> +		def = &gsc_def_dg1;
> +	} else if (xe->info.platform == XE_DG2) {
> +		def = &gsc_def_dg2;
> +	} else {
> +		drm_warn_once(&xe->drm, "Unknown platform\n");
> +		return;
> +	}
> +
> +	if (!def->name) {
> +		drm_warn_once(&xe->drm, "HECI is not implemented!\n");
> +		return;
> +	}
> +
> +	/* skip irq initialization */
> +	if (def->use_polling)
> +		goto add_device;
> +
> +	gsc->irq = irq_alloc_desc(0);
> +	if (gsc->irq < 0) {
> +		drm_err(&xe->drm, "gsc irq error %d\n", gsc->irq);
> +		goto fail;
> +	}
> +
> +	ret = gsc_irq_init(gsc->irq);
> +	if (ret < 0) {
> +		drm_err(&xe->drm, "gsc irq init failed %d\n", ret);
> +		goto fail;
> +	}
> +
> +add_device:
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		goto fail;
> +	adev->irq = gsc->irq;
> +	adev->bar.parent = &pdev->resource[0];
> +	adev->bar.start = def->bar + pdev->resource[0].start;
> +	adev->bar.end = adev->bar.start + def->bar_size - 1;
> +	adev->bar.flags = IORESOURCE_MEM;
> +	adev->bar.desc = IORES_DESC_NONE;
> +	adev->slow_firmware = def->slow_firmware;
> +
> +	aux_dev = &adev->aux_dev;
> +	aux_dev->name = def->name;
> +	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
> +		      PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	aux_dev->dev.parent = &pdev->dev;
> +	aux_dev->dev.release = gsc_release_dev;
> +
> +	ret = auxiliary_device_init(aux_dev);
> +	if (ret < 0) {
> +		drm_err(&xe->drm, "gsc aux init failed %d\n", ret);
> +		kfree(adev);
> +		goto fail;
> +	}
> +
> +	gsc->adev = adev; /* needed by the notifier */
> +	ret = auxiliary_device_add(aux_dev);
> +	if (ret < 0) {
> +		drm_err(&xe->drm, "gsc aux add failed %d\n", ret);
> +		gsc->adev = NULL;
> +
> +		/* adev will be freed with the put_device() and .release sequence */
> +		auxiliary_device_uninit(aux_dev);
> +		goto fail;
> +	}
> +
> +	return;
> +fail:
> +	xe_gsc_fini(gsc);
> +}
> +
> +void xe_gsc_irq_handler(struct xe_gt *gt, u32 iir)
> +{
> +	int ret;
> +
> +	if ((iir & GSC_IRQ_INTF(1)) == 0)
> +		return;
> +
> +	if (!HAS_HECI_GSCFI(gt_to_xe(gt))) {
> +		drm_warn_once(&gt_to_xe(gt)->drm, "GSC irq: not supported");
> +		return;
> +	}
> +
> +	if (gt->gsc.irq < 0)
> +		return;
> +
> +	ret = generic_handle_irq(gt->gsc.irq);
> +	if (ret)
> +		drm_err_ratelimited(&gt_to_xe(gt)->drm, "error handling GSC irq: %d\n", ret);
> +}
> diff --git a/drivers/gpu/drm/xe/xe_gt_gsc.h b/drivers/gpu/drm/xe/xe_gt_gsc.h
> new file mode 100644
> index 000000000000..91dba19e47c1
> --- /dev/null
> +++ b/drivers/gpu/drm/xe/xe_gt_gsc.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright(c) 2023, Intel Corporation. All rights reserved.
> + */
> +#ifndef __XE_GSC_DEV_H__
> +#define __XE_GSC_DEV_H__
> +
> +#include <linux/types.h>
> +
> +struct xe_device;
> +struct xe_gt;
> +struct mei_aux_device;
> +
> +/*
> + * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
> + * The reason for this is to allow growth for more interfaces in the future.
> + */
> +#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
> +
> +/**
> + * struct xe_gsc - graphics security controller for xe
> + *
> + * @adev : pointer to mei auxiliary device structure
> + * @irq : irq number
> + *
> + */
> +struct xe_gsc {

Please use a different name for this instead of just xe_gsc. In Xe we're 
likely never going to fully use the GSC via HECI, only the GSCFI/CSC 
part. In MTL and newer we also have the actual GSC part being split off 
and placed inside GT (behind the GSCCS), so if we call this just xe_gsc 
as well it'll be confusing. I suggest calling this something like 
xe_heci_gsc, xe_heci_interface or something like that. I had actually 
suggested this for i915 as well 
(https://patchwork.freedesktop.org/patch/509653/) but Tomas was 
concerned it might make backporting fixes difficult, so I dropped it; 
this is not a concern for Xe right now.

Note that this means renaming all the exposed functions as well.

Daniele

> +	struct mei_aux_device *adev;
> +	int irq;
> +};
> +
> +void xe_gsc_init(struct xe_gsc *gsc, struct xe_device *xe);
> +void xe_gsc_fini(struct xe_gsc *gsc);
> +void xe_gsc_irq_handler(struct xe_gt *gt, u32 iir);
> +
> +#endif /* __XE_GSC_DEV_H__ */
> diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
> index f11da12d3146..1b8ab32b488d 100644
> --- a/drivers/gpu/drm/xe/xe_gt_types.h
> +++ b/drivers/gpu/drm/xe/xe_gt_types.h
> @@ -13,6 +13,7 @@
>   #include "xe_reg_sr_types.h"
>   #include "xe_sa_types.h"
>   #include "xe_uc_types.h"
> +#include "xe_gt_gsc.h"
>   
>   struct xe_exec_queue_ops;
>   struct xe_migrate;
> @@ -267,6 +268,9 @@ struct xe_gt {
>   	/** @uc: micro controllers on the GT */
>   	struct xe_uc uc;
>   
> +	/** @gsc: graphics security controller */
> +	struct xe_gsc gsc;
> +
>   	/** @gtidle: idle properties of GT */
>   	struct xe_gt_idle gtidle;
>   
> diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
> index 1dee3e832eb5..1ae4cc9f1522 100644
> --- a/drivers/gpu/drm/xe/xe_irq.c
> +++ b/drivers/gpu/drm/xe/xe_irq.c
> @@ -128,6 +128,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>   	struct xe_device *xe = gt_to_xe(gt);
>   	u32 ccs_mask, bcs_mask;
>   	u32 irqs, dmask, smask;
> +	u32 gsc_mask = GSC_IRQ_INTF(1);
>   
>   	if (xe_device_guc_submission_enabled(xe)) {
>   		irqs = GT_RENDER_USER_INTERRUPT |
> @@ -180,6 +181,9 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
>   		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER)) {
>   			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, irqs);
>   			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~irqs);
> +		} else if (HAS_HECI_GSCFI(xe)) {
> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, gsc_mask);
> +			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~gsc_mask);
>   		}
>   	}
>   }
> @@ -227,6 +231,8 @@ gt_other_irq_handler(struct xe_gt *gt, const u8 instance, const u16 iir)
>   		return xe_guc_irq_handler(&gt->uc.guc, iir);
>   	if (instance == OTHER_MEDIA_GUC_INSTANCE && xe_gt_is_media_type(gt))
>   		return xe_guc_irq_handler(&gt->uc.guc, iir);
> +	if (instance == OTHER_GSC_INSTANCE)
> +		return xe_gsc_irq_handler(gt, iir);
>   
>   	if (instance != OTHER_GUC_INSTANCE &&
>   	    instance != OTHER_MEDIA_GUC_INSTANCE) {
> @@ -470,8 +476,9 @@ static void gt_irq_reset(struct xe_tile *tile)
>   	if (ccs_mask & (BIT(2)|BIT(3)))
>   		xe_mmio_write32(mmio,  CCS2_CCS3_INTR_MASK, ~0);
>   
> -	if (tile->media_gt &&
> -	    xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) {
> +	if ((tile->media_gt &&
> +	     xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) ||
> +	    HAS_HECI_GSCFI(tile_to_xe(tile))) {
>   		xe_mmio_write32(mmio, GUNIT_GSC_INTR_ENABLE, 0);
>   		xe_mmio_write32(mmio, GUNIT_GSC_INTR_MASK, ~0);
>   	}

