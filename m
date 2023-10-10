Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB317BFA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjJJLoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjJJLoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:44:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A41399
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696938250; x=1728474250;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bYFAUlgOPjYtVjB056qbcCJ/Q6kmV/vVU00luhR0qZc=;
  b=YGd7ukiDHKJsm5sn3/uiCkW083UG8xXc8J58Ru39vFFV77MpqQK5cg7u
   EsdZQGFKxeC+yUMqxNsHsG9js5rwi/NL3xHJRqzgsOXRY8tf90qwo198V
   +XNbJpId1bkBYQSkruvsGhReRAv2OuX3L22sSQtNCR3TeS8jgII1qjYQg
   H9bVMNj4V5i7lHIey+YDBIfJY4qZ6ZqPlzhVo0p3RY9gHkybBY+q9SIRn
   FYIXAsH2rzZ4TtvSIBp2gRaSY3Tvs4KCvfSDD6Js2AZJxdS9oDf4+esAL
   i2PeCLuVWYUiPZZPMvQLkfK2MRkeEmLubLQMTWsy9QI//u039hLCUv/hw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450869016"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450869016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 04:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="753376754"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="753376754"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 04:44:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 04:44:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 04:44:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 04:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFD5KrDDw5rpU9ejEMVGhxgjbWQyV6GXcluWKv/qTgE6zPWHlaq9J6sei0kgfFSKU5uUjhQa5+YBkEQZJMlzHFk6EIoDMqyNgoO1p6xfq363nT/uUz6Taod6q2n1ucIex1oaqJbhV6QbmKKVAyQ1SvZO0XypxwxWXjzFzbWx0lagh3Ksb7zLrJHTv042bnbsRnd7XVLi2etw9RmE8CVNW/tJtrKV5XGzQ2uB5sQCSyXc8kAuoEgGZ5Yo7xJ4sP4L9ProIOHUL9o/9Y8mUSb4zszckZg4OaEMJ6CKOJ8oUlvJ7YH+tHgwX0YT8Mqg3R6G+nY3QanOOglUnpGs8zAamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgUjpwuBV/rBIZp7z/oSr4qc8g3ju7E7qOEJnyGJb+8=;
 b=XrhS8nTY2zXnhDaOnbTj9ETf+qrShVCR0ZX4mahaqALczrb1UQrTsd0gRBh+/sgBqShpslMNapTiKlSkc0WIs8Dbwx8Tczeoc0rH85ti6UxkqJq0iT9WD2ugCAbtuG7dpJUovGau9fUm5N1sTeA4z1KL/srXFzknhbc0iMnuWkcoPFt37Fxf+Q5z+PXGKf7haZ5VBlkC2rD+pKt1U+HRe4SgHFdqAloaw/JoXLO/+4l6O4ALyMgPmUuGqmYS4L/URJY3oZfA2MIQ72NzoumnnGOXj7al/ho8l99TZ3NJX5PHl9aeYSsXUsuTsBLwZT9Ogpbn2ryo5KrapIKuH8Pn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 11:44:06 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::ecc0:2a4e:16c3:2019%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:44:06 +0000
Message-ID: <4374f40f-b1ab-a009-8d7f-1f4b6f6355ee@intel.com>
Date:   Tue, 10 Oct 2023 13:43:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 08/12] ASoC: Intel: avs: Move snd_hdac_i915_init to
 before probe_work.
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Daniel Baluta" <daniel.baluta@nxp.com>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
References: <20231004145540.32321-1-maarten.lankhorst@linux.intel.com>
 <20231004145540.32321-9-maarten.lankhorst@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20231004145540.32321-9-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::14) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|CH3PR11MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e9edb2-98a5-4f17-d96d-08dbc9863558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u62za2x0KJqLJSVw+J2wKFmdVTqO3LMglpXKDrRO+nZ4O4xfMnXpvi4aat5Eff65bXFW0oAYvNmQuwy4nIFhUFVSwBQfspQbqE7eXhDQU3pmSlJu2sVSm6nlqQDwDRDqyt7Q6Mxw1MQEUNOWxt8Yp2tB8ZCMyGXyg3fBauvKmd9HEEQWHvSMH+eHKA2J0nwO03bssHZ4/76WL3F14/3gy9H8GdEZMkFllDere0yZ+rzXiuKx9hrb7hQ1aV4PHjQ8O6TqPh73J6LZaR7Ia73LX6ViAVcR4LCa+HaHlMcrYYhbsrhksASO0fuatUgMhc4pZaZZHa0latd+eVKcllW0OKfyFnDYSPPPwMJuHQXuwOVEZJlv7/GBC7dK0k49bZpjXpUDUJFcfKwb61c/+SSj7WLp15RwKbkmYuTrny3IdCKaBga3hY4NSF6YSBNy7orSQZhpGTxzXmHU2CcRdtEL29KVA1EX3r/71ZUqvQkN8hQFNeHFisOq3dVEBjcni0FzyhmYuCj2khVp3vfeNExhLt97ue82c5PJIxRAvx5SZ1GiOSvPvm1E+8b39kkAXMfnD4nPWoEJuVhC1DTMjoP8v/lRwmifVusgeI73xhZzuPaQ0RK5gQI+RGokjXkhP9InrQxfNXIp3bpiKEXae7AwUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31696002)(82960400001)(86362001)(38100700002)(36756003)(31686004)(6512007)(478600001)(2906002)(8936002)(6486002)(44832011)(8676002)(41300700001)(5660300002)(6666004)(4326008)(53546011)(2616005)(6506007)(83380400001)(66574015)(66946007)(66556008)(66476007)(7416002)(54906003)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHlOd0NzU3M3ZGIwZDF6ZjhxY0ZPVjRPb3ZSWUFLUVc0RHczVmc0NzhvU3Vq?=
 =?utf-8?B?V2hwOVNwRVY1T2p0K2w5SGU3bXFVbEJRN2dBUm9qYTA3dEFFSEs4S29zUWMr?=
 =?utf-8?B?QlkwVEIxQ2VOc3oyYnBCdElwNzVkaUcySEluUEF1U2xPVWVOTzVwaHJzV1A0?=
 =?utf-8?B?c2M3R1NzUGplYUViN1NHYklha29hZVpOOVh6NzFvNjVPVVhNRUR1ZWprTjdw?=
 =?utf-8?B?cVY1bXJLUXFRVU11K3VqL3ljNjZncFFxWWJwM1JqWVk3c2pGMDZIclQwT2hp?=
 =?utf-8?B?eTJneGxjcXBKWm03S2NOZWhaY1Vha3R2U29rei82Yk9wY0hlU29IN0pEQnQy?=
 =?utf-8?B?OU5PbWdtcTJqeEpPWHI1dTRwcDVyYjgvZGRIYjlqa1l2NEJBcVdHd2NsN3Y5?=
 =?utf-8?B?UGpOWGVSZ0EzSnhtdkpuYndBRU96Nm5LVGJ1LzdIVnNCdVgwcWFVVFNjR094?=
 =?utf-8?B?ZGpTRklmdGpBQzNsR1gzL25KaDZyblB6bzBTd1lBbzZodDVka1RrdVJQZ2hK?=
 =?utf-8?B?M0x6eko2UW9kVWZPVFJBeDVNV1JqaDlnSEZSRW43aForQUY0TStyeWhYbUU4?=
 =?utf-8?B?bFFFNkYwSTJuZTVoYklvM3grL3lUdDVUWnZ4bCtWMjFkVHgwVGwyNUNldU9L?=
 =?utf-8?B?VU82d1IzSFlIYm4wdEN6MGdXa29OcXdIUXRtdmh6V1R6S0xPS243Zlo2RzBI?=
 =?utf-8?B?ZWE5ckc2QlhrQmh0TjNJVVdPUE01cXVobnY0d1M4bFgwVEIzS3JUcnk1c3JE?=
 =?utf-8?B?T2dYK1lUV0ZXeDRSV01wNlRhTENwY3c3d2UxNnJLaTU4bWtXRmorcTdrQ3Rx?=
 =?utf-8?B?ZER5WFV1aFY1S3E2cFdLU2hKa0VZQytTeXB6WnYvek1iamM0SUhxQmRPZDNa?=
 =?utf-8?B?NERvSG1rK1EzNkI5ZlZvTFE3RURaaituU25DRGJMeDVNUHFkTjVBZUVxRlhH?=
 =?utf-8?B?N29Ib3kvWmlTY3NKanFrOTY4Vk1pZ3BBNkh5Nkh0Um9LZnpyRmV0S3NyTytT?=
 =?utf-8?B?NFU4dTlHUGZSaHBKVElsUkdsaVFuZm9nazlYSHlLeFpQa0ZWa2IySVZrNVpV?=
 =?utf-8?B?d3dTOWNEbDZ5RHRWaDdlWUFxbDlnY0ZEdlJXZ3ZxOUliZmhjbzkzU3o5SEJq?=
 =?utf-8?B?RHdydXM0NHZ0NklJWlJzSGhtYzRJZG5wRTAxaG9VK0RoWVlUT0FRczUxakpt?=
 =?utf-8?B?WnlraFBORnByRHBIYThrZlRKcTUrbDFNckxaYWN4citYdi84L3lnNi9OaFI2?=
 =?utf-8?B?NGt2VGk0KzV6bkg3TDBwNUtHSGQvMFNkWVBHRzNtaHZmekwyM1liZk1oT0J0?=
 =?utf-8?B?T0daNitHekZldEw0Z1o3eVpzNHByaUVQajNaSmhCbWgvaVUvU2lhYUs5TWli?=
 =?utf-8?B?LzIrOVN3bFpnSi9VNS9NZ0lJUXh2TWV4bFZJVHFOcEU5WHZOTzFLcHM3WWNo?=
 =?utf-8?B?WVlpUkR4b3IrT3U1WkFoKzVwTlRTMGNqb2N3Rm9OUklMcW8zWUt5UFNWT3dy?=
 =?utf-8?B?QjF2ajBjYjFLclA3WnUwQmovQllZTU1WbU8yVHJ1d0R3Tk04dW8xWXU1dXZ4?=
 =?utf-8?B?SkFwVmpQeHFEekdBeTR4aXkvZkxEK0JzUlJGSkNSN2JSR1FBUnBaN2tQV0w3?=
 =?utf-8?B?U1JzMUtwRkNSVE9LK3lSalVZMEYzZXErbEY5L01NWnpKVHFJcUV6dVJBa01Q?=
 =?utf-8?B?NFBNdE93MkZHd29XR3pDMDh1QjRDeC8rdWxCQ0xPaGxpVUhCL2d0UU4zQnJq?=
 =?utf-8?B?UkIvREtiNE5MU0hvQ2JLUHVZcHg0WkZ4eHQ4TXVVYnVyUzRlUmtKYjh1dm5k?=
 =?utf-8?B?OE9vTlI3NGJQcnBLeWtsdUU5MEZEdDdTRlQyZEpOWUpsZ0dHSjYvdHlvVDE3?=
 =?utf-8?B?QjVWRUF3UHI5d0xQU2dtNUhEUzdyYmdIUkRhbWViV3Y0Ulk2TEZYWWtocmIw?=
 =?utf-8?B?R2FUbDhISHdaQnNzNEZpalFMLzQ3ZXZpWmE4NnhiYzJhV1Eva0dvSDdlZVlu?=
 =?utf-8?B?WHBIbHI4aE80VnJ0a09STWppdnN0OExYamtBSWphT1hGVVJGVVUrc2ZYR3JM?=
 =?utf-8?B?YWRKbjIwQjFTWUF1WTBaSWFVdDZZRnlzZVdRR3ZXL2NHbjJ4dWNtY0hFbXhz?=
 =?utf-8?B?RzhoRHFRdi9HYVMxblhmVUJEbDkzZG1udFBISzBUNVFFdjBmTnNFU1BEOWxu?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e9edb2-98a5-4f17-d96d-08dbc9863558
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 11:44:06.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBSqurcSLTLKsqa82YADYc/NOrCjMZyHpFaEpm/bbM8dlkDfVKCGRqArj/m+r2wSFwoYnM5aqZeIpv8KhP/Mo6pD8eeDaSPTCbNL3agsrDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
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

On 2023-10-04 4:55 PM, Maarten Lankhorst wrote:
> Now that we can use -EPROBE_DEFER, it's no longer required to spin off
> the snd_hdac_i915_init into a workqueue. It's likely the whole workqueue
> can be destroyed, but I don't have the means to test this.
> 
> Removing the workqueue would simplify init even further, but is left
> as exercise for the reviewer.

Nitpick: Half of the commit message is redundant. From the 
reader/maintainer point of view, presented opinions and suggestions are 
fine as a part of cover-letter but not in the long run from git log level.

> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Nitpick: commit title is not a sentence, should not end with full stop.

> ---
>   sound/soc/intel/avs/core.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index bbb40339c75f..8a2063958248 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -191,10 +191,6 @@ static void avs_hda_probe_work(struct work_struct *work)
>   
>   	pm_runtime_set_active(bus->dev); /* clear runtime_error flag */
>   
> -	ret = snd_hdac_i915_init(bus, true);
> -	if (ret < 0)
> -		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
> -
>   	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
>   	avs_hdac_bus_init_chip(bus, true);
>   	avs_hdac_bus_probe_codecs(bus);
> @@ -465,10 +461,19 @@ static int avs_pci_probe(struct pci_dev *pci, const struct pci_device_id *id)
>   	pci_set_drvdata(pci, bus);
>   	device_disable_async_suspend(dev);
>   
> +	ret = snd_hdac_i915_init(bus, false);
> +	if (ret == -EPROBE_DEFER)
> +		goto err_i915_init;
> +	else if (ret < 0)

The 'else' part seems redundant. s/else if/else/.

As I'm aware that this is v6 already, my team can also clean this up 
later with separate series to not delay the merge any longer.

> +		dev_info(bus->dev, "i915 init unsuccessful: %d\n", ret);
> +
>   	schedule_work(&adev->probe_work);
>   
>   	return 0;
>   
> +err_i915_init:
> +	pci_clear_master(pci);
> +	pci_set_drvdata(pci, NULL);
>   err_acquire_irq:
>   	snd_hdac_bus_free_stream_pages(bus);
>   	snd_hdac_ext_stream_free_all(bus);
