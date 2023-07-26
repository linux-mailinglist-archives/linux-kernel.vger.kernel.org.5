Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7457764230
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbjGZWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 18:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGZWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:34:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FEC2680
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:34:49 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686b9964ae2so288194b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690410889; x=1691015689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6w8VhI1tk0nbJkJuK2Pgr9+I/2HSSEWHGbvHhOGVr0=;
        b=MDSzK2GGWDQaVDiugDXkQzVkMDMY24BHrqfDNMHZYw5//XnmJWJ4+M/zkGp9BHCfJS
         wY5HWu6H+bWg1buQsNwJNB2ADKb7sMcMvdNQZv2TB49Lw+4Y6uN0cb50krwJdtgVKcVe
         0v2qCojo9/Epjv+QQg/83tZXts6hFyovv7UHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690410889; x=1691015689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6w8VhI1tk0nbJkJuK2Pgr9+I/2HSSEWHGbvHhOGVr0=;
        b=UUbSpwqZXGLbSbb6Mt4mCL0FxjRmgcVVw0pQq4sNrXoF8TFwjDU/WlUAOICv7XG4kz
         5uX41jscsARl0FhKMEe3nwjN40uj1DRrXyYIvv31ABNNPfFEdy9JLBpJLRNH5cdLHSF0
         V6wQEFm/BxpaEpWPHoB/DuQqvzQgsfNE5dATFnFPIE6++qJlougim28AyOfh7wuTm35y
         UuEzYOV8n6djXF5RYchib3rPjBIDNS+csU77VIToVUxalJSsY5XPxCFS1M6vDsF552p5
         DPcfleLPTcR2DdCbTtUXNzxEXvcoidfOV43TkcKYkDoxdSeUOz4r0oM8ncrZsfoVLD4h
         Ue8Q==
X-Gm-Message-State: ABy/qLZoOM31h9NB2dBHQ+nCKbMiNMT+t4nMHu+239jXwrY2/Wgd3ls0
        vxC6GqDYybkiXeBV9WtS0Umi8g==
X-Google-Smtp-Source: APBJJlFYSi/2EqdK53JZP66OEANSKSh8FOVfXLOR/d6VUzsQzuojiQ9yyqmqmVyNQz2uMUcCYgAHbg==
X-Received: by 2002:aa7:88c3:0:b0:680:f6fe:8908 with SMTP id k3-20020aa788c3000000b00680f6fe8908mr3521901pff.9.1690410889247;
        Wed, 26 Jul 2023 15:34:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n9-20020a62e509000000b006749c22d079sm92392pff.167.2023.07.26.15.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 15:34:48 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:34:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     justinstitt@google.com
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: Skylake: replace deprecated strncpy with
 strscpy
Message-ID: <202307261532.3EFCF04F1@keescook>
References: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-asoc-intel-skylake-remove-deprecated-strncpy-v1-1-020e04184c7d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 09:12:18PM +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> It was pretty difficult, in this case, to try and figure out whether or
> not the destination buffer was zero-initialized. If it is and this
> behavior is relied on then perhaps `strscpy_pad` is the preferred
> option here.
> 
> Kees was able to help me out and identify the following code snippet
> which seems to show that the destination buffer is zero-initialized.
> 
> |       skl = devm_kzalloc(&pci->dev, sizeof(*skl), GFP_KERNEL);
> 
> With this information, I opted for `strscpy` since padding is seemingly
> not required.

We did notice that str_elem->string is 44 bytes, but
skl->lib_info[ref_count].name is 128 bytes. If str_elem->string isn't
NUL-terminated, this can still hit an over-read condition (though
CONFIG_FORTIFY_SOURCE would have caught it both before with strncpy()
and now with strscpy()). So I assume it is expected to be
NUL-terminated?

> Also within this patch is a change to an instance of  `x > y - 1` to `x >= y`
> which tends to be more robust and readable. Consider, for instance, if `y` was
> somehow `INT_MIN`.

I'd split this change into a separate patch -- it's logically unrelated
(but seems a reasonable cleanup).

> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> Link: https://github.com/KSPP/linux/issues/90
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  sound/soc/intel/skylake/skl-topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 96cfebded072..67f08ec3a2ea 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3154,12 +3154,12 @@ static int skl_tplg_fill_str_mfest_tkn(struct device *dev,
>  
>  	switch (str_elem->token) {
>  	case SKL_TKN_STR_LIB_NAME:
> -		if (ref_count > skl->lib_count - 1) {
> +		if (ref_count >= skl->lib_count) {
>  			ref_count = 0;
>  			return -EINVAL;
>  		}
>  
> -		strncpy(skl->lib_info[ref_count].name,
> +		strscpy(skl->lib_info[ref_count].name,
>  			str_elem->string,
>  			ARRAY_SIZE(skl->lib_info[ref_count].name));
>  		ref_count++;
> 
> ---
> base-commit: 0b4a9fdc9317440a71d4d4c264a5650bf4a90f3c
> change-id: 20230726-asoc-intel-skylake-remove-deprecated-strncpy-9dbcfc26040c
> 
> Best regards,
> -- 
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
