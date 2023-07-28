Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5D767766
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjG1VFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjG1VFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:05:06 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905E5449C
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:05:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26814e27a9eso1485800a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690578304; x=1691183104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzLjWb2IvKpNxetuxpIL5OUHvXbEPP7sO5JHMTXgoFM=;
        b=DUzSJHWXkFm+UzMm4dk0GxmM2lh2CU0cXH7uio1EOVxzROxMN7PSytZUTv1i3Fc6C/
         QYKcvelkqpaycnCFRoG9PCzQj62E5541Mh6NnAQ2Y+sSq+1L2mIq4t2+1j081dAuDtvH
         Bx/QPVhFvOADdzXk9Rl9p0j13NdbQZKN2REAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690578304; x=1691183104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzLjWb2IvKpNxetuxpIL5OUHvXbEPP7sO5JHMTXgoFM=;
        b=gbw0KlvE7YG6GDsBLNYxKVgdZQW1dITvHtJxPgvcZFKMogTvBHIR+zbGvl4hsENmWj
         doVG3Aro3XhwJ2+lXJJklbICAxCuwYE4y0OM0atVigr2xzwaZIE63s5lxUVD33EX2KpL
         qQKjsSdoPguiCdymbSNN42D/A2aIPoqHFjGrJdo9aKgBV6j2qlIexWU0soYXNNLnCTpa
         2naEZXrgCqhffiCAQ2cYNSOleTbADCzQ2Q9pmVeZBPV8cgy2jq8QGBp0MDVicbqPh8B5
         OCpzNDB6abJ7PuK7HhzkKjN9Qanq9g7nmYtewfUpiuKv6sjVciQsiIAXUvRtvRIlibAw
         b7rA==
X-Gm-Message-State: ABy/qLYtUVd4Fokh2GGGqTQd3vFrmKgs4aFr1fGp265P5rpAd2UVdmWz
        3VIFUILf9iut91Vl8RZ+ErOuTmqfJscWoawoTVs=
X-Google-Smtp-Source: APBJJlE/Bj0YDv8/cqAifhSQW91oOrA1CcZeDO76w2S84U8EV7YhttyyW5XGorEq/S0odyjPHkgqcg==
X-Received: by 2002:a17:90b:4c0f:b0:268:553f:1938 with SMTP id na15-20020a17090b4c0f00b00268553f1938mr2398856pjb.4.1690578304059;
        Fri, 28 Jul 2023 14:05:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a19c900b00267f7405a3csm3176140pjj.32.2023.07.28.14.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 14:05:03 -0700 (PDT)
Date:   Fri, 28 Jul 2023 14:05:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: 88pm860x: refactor deprecated strncpy
Message-ID: <202307281205.175FD2FC@keescook>
References: <20230727-sound-soc-codecs-v1-1-562fa2836bf4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-sound-soc-codecs-v1-1-562fa2836bf4@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:46:13PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ always the case for `strncpy`!
> 
> In this case, though, there was care taken to ensure that the
> destination buffer would be NUL-terminated. The destination buffer is
> zero-initialized and each `pm860x->name[i]` has a size of
> `MAX_NAME_LENGTH + 1`. This means that there is unlikely to be a bug
> here.
> 
> However, in an attempt to eliminate the usage of the `strncpy` API as
> well as disambiguate implementations, replacements such as: `strscpy`,
> `strscpy_pad`, `strtomem` and `strtomem_pad` should be preferred.
> 
> We are able to eliminate the need for `len + 1` since `strscpy`
> guarantees NUL-termination for its destination buffer as per its
> implementation [3]:
> 
> |       /* Hit buffer length without finding a NUL; force NUL-termination. */
> |       if (res)
> | 	        dest[res-1] = '\0';
> 
> [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> [3]: https://elixir.bootlin.com/linux/v6.3/source/lib/string.c#L183
> 
> Link: https://github.com/KSPP/linux/issues/90
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  sound/soc/codecs/88pm860x-codec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
> index 3574c68e0dda..d99b674d574b 100644
> --- a/sound/soc/codecs/88pm860x-codec.c
> +++ b/sound/soc/codecs/88pm860x-codec.c
> @@ -143,7 +143,7 @@ struct pm860x_priv {
>  	struct pm860x_det	det;
>  
>  	int			irq[4];
> -	unsigned char		name[4][MAX_NAME_LEN+1];
> +	unsigned char		name[4][MAX_NAME_LEN];
>  };
>  
>  /* -9450dB to 0dB in 150dB steps ( mute instead of -9450dB) */
> @@ -1373,7 +1373,7 @@ static int pm860x_codec_probe(struct platform_device *pdev)
>  			return -EINVAL;
>  		}
>  		pm860x->irq[i] = res->start + chip->irq_base;
> -		strncpy(pm860x->name[i], res->name, MAX_NAME_LEN);
> +		strscpy(pm860x->name[i], res->name, MAX_NAME_LEN);

res->name is (perhaps) unbounded in length:

struct resource {
	...
        const char *name;
	...
};

So reducing struct pm860x_priv::name's size _might_ have a user-visible
effect, but probably not.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
