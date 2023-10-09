Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607507BEE02
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378826AbjJIWEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378789AbjJIWED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:04:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB11CB9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:03:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-692c02adeefso3632827b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696889039; x=1697493839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ys7O5oFEmO1QCviYjPEYrUnc2jO2bomITSGGcdISQfo=;
        b=H41bVc++pRQxUSD3+HPGj9CapgckzkFj4jkAdPm1+DGXBZbpusDYBC46uK9GFNkqNn
         j1sh4axWxLNzu1/iAWtaru8sYZDbTIPbAgW5zKkqDjBVKxZLUcK7u1nIeOiTaj4VTOv0
         GR+Whk96oyvFM1uPoujx/244EYhlhg2R4e1E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696889039; x=1697493839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ys7O5oFEmO1QCviYjPEYrUnc2jO2bomITSGGcdISQfo=;
        b=T1/9MRjnLWRaxrDsjlE8H0Bdto6PzE2OiYq8Z+fzsTs3MCHi/+tiDD8xU2s2aAxKmR
         MJtPRhQZeJvEGsu2RPLnHVouHdtgfVxnSpTxeOvdoPErQj2cCTMt4OzFhQWcJvCxLTx8
         WAqpTZrR1l0nAiV01podmPaC3TKSIJEDrKll+NL5N80mR1+Nef+WZHjlUG18w+0z+p/8
         MTb3dhZw969DpqaSFROjCackUcEKNbZDHtN2pgwhyv18sV5UNCnp+xoTtGVpUiVOO2uh
         gMWgq7T0qJinzX3r0jxNkBkkTEO4q62KbzpsmhgerBOuPBKr+Lreie65sKPyAEMsNfeI
         xHEA==
X-Gm-Message-State: AOJu0Ywy7h8Ezbl4MqzzH7oabGI0IUup0aLiinC4Vy7Xf0FU0lrQHTXt
        TMIQw21k758oQecutkMDc/DqeD8RHDya3oE99i0=
X-Google-Smtp-Source: AGHT+IFjPnCNTHgmoj8ii2/P0s9nH6rj/IoWKH7/YKY4P8GJP1oGAXAR6Ca7aG9HVdB+DAVpWTaDCg==
X-Received: by 2002:a05:6a21:338c:b0:159:e0b9:bd25 with SMTP id yy12-20020a056a21338c00b00159e0b9bd25mr16823979pzb.57.1696889039248;
        Mon, 09 Oct 2023 15:03:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a656aa5000000b0059b64b153fcsm120296pgu.17.2023.10.09.15.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:03:58 -0700 (PDT)
Date:   Mon, 9 Oct 2023 15:03:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: sigmadsp: Add __counted_by for struct
 sigmadsp_data and use struct_size()
Message-ID: <202310091503.E59363D14@keescook>
References: <ZSRvh1j2MVVhuOUv@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRvh1j2MVVhuOUv@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:24:23PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() and size_sub() helpers, instead of the
> open-coded version, to calculate the size for the allocation of the
> whole flexible structure, including of course, the flexible-array
> member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  sound/soc/codecs/sigmadsp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sigmadsp.c b/sound/soc/codecs/sigmadsp.c
> index b93c078a8040..56546e2394ab 100644
> --- a/sound/soc/codecs/sigmadsp.c
> +++ b/sound/soc/codecs/sigmadsp.c
> @@ -43,7 +43,7 @@ struct sigmadsp_data {
>  	uint32_t samplerates;
>  	unsigned int addr;
>  	unsigned int length;
> -	uint8_t data[];
> +	uint8_t data[] __counted_by(length);
>  };
>  
>  struct sigma_fw_chunk {
> @@ -270,7 +270,7 @@ static int sigma_fw_load_data(struct sigmadsp *sigmadsp,
>  
>  	length -= sizeof(*data_chunk);
>  
> -	data = kzalloc(sizeof(*data) + length, GFP_KERNEL);
> +	data = kzalloc(struct_size(data, data, length), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
> @@ -413,7 +413,8 @@ static int process_sigma_action(struct sigmadsp *sigmadsp,
>  		if (len < 3)
>  			return -EINVAL;
>  
> -		data = kzalloc(sizeof(*data) + len - 2, GFP_KERNEL);
> +		data = kzalloc(struct_size(data, data, size_sub(len, 2)),
> +			       GFP_KERNEL);

Since len was just size-checked before the alloc, size_sub() is a bit of
overkill, but it's not technically wrong. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
