Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA407778EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjHJNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjHJNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:00:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E42691
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 06:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691672402; x=1723208402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XAFRjI39t8Q8MiQyxRvHys4lXjxeKC98m9Ty/dzfFx4=;
  b=H/4YQKrUY2uH+VRAjBuvY2KSWHOBaSPTxj/VzYLDCV9UnavI2M37pwUH
   HJadoFFSKeDF/ct0/HsRQbGsc6ojB+Gz+EEVitmPXk7EKH7EPUcCjnc+w
   doe0tWBQVhTLVM4GLW550eA+TNeGg3ePL67cZ8IupbWPfYh/X5sxUcrDZ
   Le1DFOeurdXeyNGhHodeiIKF7TapfAYjZCXjQKABxWTVYwefq8id7dBXE
   vjGCCYDXoxgzBZFvoUCDv22ZQ2LqqFcXIZBWq4s9ec7YnoOp+bEYABG2S
   bP3/xVhon7PpF/UBljDC4S22u6wz8Ugojnf9AF8ZsdVKf+OYXquXcIY1o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356356046"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="356356046"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:00:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="709137872"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="709137872"
Received: from dhoeflin-mobl.amr.corp.intel.com (HELO [10.212.101.20]) ([10.212.101.20])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 06:00:00 -0700
Message-ID: <3cbac915-8177-e30d-8e31-2aa27feebac9@linux.intel.com>
Date:   Thu, 10 Aug 2023 07:32:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH -next] ASoC: SOF: Intel: Remove duplicated include in
 lnl.c
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, perex@perex.cz,
        tiwai@suse.com, lgirdwood@gmail.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230810005555.4610-1-yang.lee@linux.alibaba.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230810005555.4610-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/23 19:55, Yang Li wrote:
> ./sound/soc/sof/intel/lnl.c: hda.h is included more than once.
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

yes, thanks for the patch

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/intel/lnl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
> index 3d919b0b6891..db94b45e53af 100644
> --- a/sound/soc/sof/intel/lnl.c
> +++ b/sound/soc/sof/intel/lnl.c
> @@ -16,7 +16,6 @@
>  #include "hda-ipc.h"
>  #include "../sof-audio.h"
>  #include "mtl.h"
> -#include "hda.h"
>  #include <sound/hda-mlink.h>
>  
>  /* LunarLake ops */
