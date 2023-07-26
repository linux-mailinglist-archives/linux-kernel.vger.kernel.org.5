Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033EF762A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjGZFEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjGZFED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:04:03 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308E1FC2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:04:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bbd03cb7c1so338335ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690347842; x=1690952642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmNxf7H0BywXLtYlbyzZ0cohOxG3KN5qwoqWHBea/DE=;
        b=i8e5D386JPazAaCSpTbvVvQTdkpO/Ce+xooq5vf1A56euX8LkYV7aNAeJur95KwXHH
         ycurDepI7RCrgNILIlWlKTX7cyLGIWzf4CfyzwHQWGa8r30kjLHPbjR9KGdkvoeh1xvl
         sFpkufDwIYceHjLLxu80f6mvHGi7o4Hh+AyhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690347842; x=1690952642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmNxf7H0BywXLtYlbyzZ0cohOxG3KN5qwoqWHBea/DE=;
        b=kby2PyvctWroQC9YCgSSjYW4s1ykayVOJMGTxSHZ/c1mkk4I2RWNsiuHvKwAgufpWk
         QgC3fj8ehQKhykYIdmAaP8YW4TPlk1dcSncjLyAxPv5gLXNJmaLxmVPCOG5kpOBrCJOZ
         +LwMpH1QJuq8TYA9GX8HfPe+cWH+8qcbAPIKA0BOlWFi0xAfkI61HQZoGDm+ckKLe6yR
         pbVCPkx5a3q0geP/2grkog8OUjX7RSFpG284uSLh91MDdOyNLhe2GG/ooxESll5u8KV+
         mPNF2WXVWZtaIA4Az7ORLAgB//kCU47MVQT28JDHR8fiP9sYsSq2HMs6ymDqAd3HwVrT
         DZIw==
X-Gm-Message-State: ABy/qLY8ya/xIoqFNHlRCiOp4BP9TXZqjM/cnn9Vnn3z3vyMiX0MWu3r
        L3egfa0GowriPsByVUN4R9Zixw==
X-Google-Smtp-Source: APBJJlHCsyMGDfR/HSI4jTFBKt05j4ib5fipfp9CPEPiAJolZuOa93xPQomZb9+LBBoHaiuhXeFkKA==
X-Received: by 2002:a17:903:120d:b0:1b7:c0b3:b17d with SMTP id l13-20020a170903120d00b001b7c0b3b17dmr1003936plh.5.1690347841574;
        Tue, 25 Jul 2023 22:04:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709028a8100b001b3ce619e2esm11893529plo.179.2023.07.25.22.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:04:01 -0700 (PDT)
Date:   Tue, 25 Jul 2023 22:04:00 -0700
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
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] ASoC: intel: avs: refactor strncpy usage in topology
Message-ID: <202307252157.90B1933@keescook>
References: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725-sound-soc-intel-avs-remove-deprecated-strncpy-v1-1-6357a1f8e9cf@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 10:08:38PM +0000, justinstitt@google.com wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1].
> 
> A suitable replacement is `strscpy` [2].

For future patches like this, can you include the rationale for _why_
strscpy() is suitable? (i.e. how did you check that it doesn't need
zero-padding, the dest is expected to always be NUL-terminated, etc.)

I had fun looking through this code -- it's a bit of a maze! I can see
in the initializer for "route" (soc_tplg_dapm_graph_elems_load()), that
all the strings pointed at from "elem" are being checked for NUL-termination.

That this code is doing an in-place rewrite of the string is pretty
unusual (i.e. specifically casting around the "const"), but it looks
quite intentional. :)

> There are some hopes that someday the `strncpy` api could be ripped out

This can be rephrased, perhaps, as:

There is a goal to eliminate the `strncpy` API in the kernel, as its
use is too ambiguous, instead moving to the unambiguous replacements
(strscpy, strscpy_pad, strtomem, strtomem_pad, strlcpy) [1].

> due to the vast number of suitable replacements (strscpy, strscpy_pad,
> strtomem, strtomem_pad, strlcpy) [1].
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> 
> ---
^^^^ this triple-dash is going to cause some tooling to lose your S-o-b,
as it indicates the end of the commit log.

> 
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>

But otherwise, looks good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  sound/soc/intel/avs/topology.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/intel/avs/topology.c b/sound/soc/intel/avs/topology.c
> index cdb4ec500261..45d0eb2a8e71 100644
> --- a/sound/soc/intel/avs/topology.c
> +++ b/sound/soc/intel/avs/topology.c
> @@ -1388,12 +1388,12 @@ static int avs_route_load(struct snd_soc_component *comp, int index,
>  		port = __ffs(mach->mach_params.i2s_link_mask);
>  
>  		snprintf(buf, len, route->source, port);
> -		strncpy((char *)route->source, buf, len);
> +		strscpy((char *)route->source, buf, len);
>  		snprintf(buf, len, route->sink, port);
> -		strncpy((char *)route->sink, buf, len);
> +		strscpy((char *)route->sink, buf, len);
>  		if (route->control) {
>  			snprintf(buf, len, route->control, port);
> -			strncpy((char *)route->control, buf, len);
> +			strscpy((char *)route->control, buf, len);
>  		}
>  	}
>  
> 
> ---
> base-commit: 0b4a9fdc9317440a71d4d4c264a5650bf4a90f3c
> change-id: 20230725-sound-soc-intel-avs-remove-deprecated-strncpy-2bc41a5a5f81
> 
> Best regards,
> -- 
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
