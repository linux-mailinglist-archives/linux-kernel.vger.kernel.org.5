Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6A760CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGYIOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjGYIOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:14:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976F8E53
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690272893; x=1721808893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W8mV1wjIqvrGQnvQyNg9bRQ5AyE3RsOi23YmwOJilmM=;
  b=X48L6Bfyv9C13e78YV6MxWrhBdpk/uBxy7B+GWwlGV9bv2yDn0/3LjND
   29JBzh68NL+VwCFVKf+XzqJaBngtbPRZhv9Sohq1q92YpX2dWnC8bTz7H
   wuO2ugiz5hvi4N+n122ed+lUIRk0xG/yeMrDGjhBVk70VoZbCoW/pUj4/
   L/JUwzvxjSF4zhYndbRI/3n3sBf8GbAgNn8agwL7nIuD4G7UKCDoWbF5O
   JIFw054zupmjPR38TUv64Q+nBWJYYpe5NuIH1IiTgB3NmN2mxOUd7A268
   W9jt6cg7xI3Udrze10QioOCFYn9PRSddH6dZQyfOq4jx+8n5fF2LUiU0G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347926620"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="347926620"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="729262924"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="729262924"
Received: from dmacnerl-mobl1.amr.corp.intel.com (HELO [10.252.34.151]) ([10.252.34.151])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:14:51 -0700
Message-ID: <01518d81-0b1d-6190-631c-01cc00da2bb6@linux.intel.com>
Date:   Tue, 25 Jul 2023 11:16:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: fix application of sizeof to
 pointer
To:     sunran001@208suo.com, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
References: <20230720073836.3285-1-xujianghui@cdjrlc.com>
 <74739aaaa05f52084757b526bc8348c8@208suo.com>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <74739aaaa05f52084757b526bc8348c8@208suo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/2023 11:43, sunran001@208suo.com wrote:
> The coccinelle check report:
> ./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
> sizeof to pointer

Please include the maintainers for patches to enusre they reach the
correct audience, if in doubt who should be on TO/CC, use the
scripts/get_maintainer.pl <patch file>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  sound/soc/sof/ipc4-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index a4e1a70b607d..2dbe87dbd239 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -218,7 +218,7 @@ static int sof_ipc4_get_audio_fmt(struct
> snd_soc_component *scomp,
> 
>      ret = sof_update_ipc_object(scomp, available_fmt,
>                      SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
> -                    swidget->num_tuples, sizeof(available_fmt), 1);
> +                    swidget->num_tuples, sizeof(*available_fmt), 1);

The second last parameter is in essence unused since we only update a
single item.
The patch is correct in a semantic way but the original code worked
correctly.

>      if (ret) {
>          dev_err(scomp->dev, "Failed to parse audio format token count\n");
>          return ret;

-- 
Péter
