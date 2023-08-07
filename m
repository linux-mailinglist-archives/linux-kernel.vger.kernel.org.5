Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096C5772853
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjHGO4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjHGO4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:56:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F5C10CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691420200; x=1722956200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WdpaDUvecnhweQASsk5g5/dbHTSyH4Xy8Pc9wywxPhQ=;
  b=bKfK9s0k/fgtR66bVTU3U5YztWOW4iXe9T4uEUQkeErrHh26rBLVat/m
   AhdIrg0w02IF6kq1cBDJR6+TV3/0epngP3IyXBCdSP7xQe/VsihHzZd+z
   kDznAo5k+v46X87adEGVb/YBHJl4sA5NCuDHiW0rDprYeYIivd4W8qqEo
   gOoHD+0a0/6yeX/JtJZ6c5TfkML301w7+toNCOyNPijUduM53KpYzT55Y
   zFDLmYq9b5SdK1H1fV4LNxWfyU3azXKMLuORi4ulbWeUllY0ivm3Etj7m
   ydlWnP4DoU+TI/dByslr9nsntV4GRZEEo+EKnO7W8JisbEw+uqz5Eqd8d
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="434410591"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="434410591"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1061623864"
X-IronPort-AV: E=Sophos;i="6.01,262,1684825200"; 
   d="scan'208";a="1061623864"
Received: from hweelee-mobl.amr.corp.intel.com (HELO [10.209.181.215]) ([10.209.181.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 07:56:37 -0700
Message-ID: <451ab8a3-7c75-4aab-0b8b-554d9c44c34c@linux.intel.com>
Date:   Mon, 7 Aug 2023 09:08:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/9] ALSA: hda/i915: Add an allow_modprobe argument to
 snd_hdac_i915_init
Content-Language: en-US
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     Maarten Lankhorst <dev@lankhorst.se>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20230807090045.198993-1-maarten.lankhorst@linux.intel.com>
 <20230807090045.198993-4-maarten.lankhorst@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230807090045.198993-4-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/23 04:00, Maarten Lankhorst wrote:
> Xe is a new GPU driver that re-uses the display (and sound) code from
> i915. It's no longer possible to load i915, as the GPU can be driven
> by the xe driver instead.
> 
> The new behavior will return -EPROBE_DEFER, and wait for a compatible
> driver to be loaded instead of modprobing i915.
> 
> Converting all drivers at the same time is a lot of work, instead we
> will convert each user one by one.
> 
> Changes since v1:
> - Use dev_err_probe to set a probe reason for debugfs' deferred_devices.

You want the changes below the --- line ...
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---

... here


>  include/sound/hda_i915.h        | 4 ++--
>  sound/hda/hdac_i915.c           | 8 ++++----
>  sound/pci/hda/hda_intel.c       | 2 +-
>  sound/soc/intel/avs/core.c      | 2 +-
>  sound/soc/intel/skylake/skl.c   | 2 +-
>  sound/soc/sof/intel/hda-codec.c | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)

