Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557FD7BEE10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378842AbjJIWGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378741AbjJIWGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:06:04 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D37A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:06:01 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690d2441b95so3658575b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 15:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696889161; x=1697493961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=845MK78LxhnwOhYyBjmLLC+lpa1q0nrX/E0dElEn/Cc=;
        b=chejwi6w0gnStM8GPNcL5n3DcdgQYMRYnrMOSRFqRvgIfwGKtXcJxTHp7/dupjFFEN
         yZSF31fEKqHW6wKbi1DPo5tDElBXywPfxDGQq0jkQHC9vDNAGMIvK8hD9MBJjfD5D6oI
         2Xr8Hg5NcmzdW2dfmWnyD9Aclv63i/RVCzLPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696889161; x=1697493961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=845MK78LxhnwOhYyBjmLLC+lpa1q0nrX/E0dElEn/Cc=;
        b=wakPZZZLZyFGGAx5uZ1w/Xfg+Ss46wtC1dGtolAMdV4MC6KBLAHD7FFECtLS5cAR+d
         LAZ8/bm0n0zBlFUfvYAiiuNAesO29WX+bqjUBwq8tV6aqTUzO3Hx4wNbXSFZ6j2jpg2R
         GEUavsVUa8giJVqWYT7FoVz1J76vtTsoEQzp9gQaDSJ48u8JeLxO33sFojU0d5bIhqhx
         ROHugsz6dO7LGxg+Ofb8NxD/YOkuH7MH6NhhwWniFeEwiHH436MhuzBmGors6zydGzlo
         67arqGA67Z3oIFf7UwTXpolMqrBNAh+4+jxg3S4+yuoc7Z0LJgUa7vBf6KrNiFonPUYH
         yWHw==
X-Gm-Message-State: AOJu0Yz2viKFJXPDLSTcxdLeFKGVs2RTgCdqN5u4EpZq48S/NiKk2KLB
        ki8zRPGvr2UX6+I2RqX5Xy1FLJr08KkMgB74MLk=
X-Google-Smtp-Source: AGHT+IHqaBNQQQRLJKp65sZWW9PKzkYfF+M26/Xgf+6qN4PKsORHoYdOSJWUwzqVcOHLSVA68vcuuw==
X-Received: by 2002:a05:6a00:2d94:b0:68f:cc67:e709 with SMTP id fb20-20020a056a002d9400b0068fcc67e709mr19253695pfb.16.1696889161154;
        Mon, 09 Oct 2023 15:06:01 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c17-20020aa78c11000000b0068c10187dc3sm6849915pfd.168.2023.10.09.15.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 15:06:00 -0700 (PDT)
Date:   Mon, 9 Oct 2023 15:05:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
        Intel Corporation <linuxwwan@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
        Liu Haijun <haijun.liu@mediatek.com>,
        M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
        Ricardo Martinez <ricardo.martinez@linux.intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: wwan: t7xx: Add __counted_by for struct
 t7xx_fsm_event and use struct_size()
Message-ID: <202310091505.49082C790A@keescook>
References: <ZSR0qh5dEV5qoBW4@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSR0qh5dEV5qoBW4@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 03:46:18PM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> While there, use struct_size() helper, instead of the open-coded
> version, to calculate the size for the allocation of the whole
> flexible structure, including of course, the flexible-array member.
> 
> This code was found with the help of Coccinelle, and audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wwan/t7xx/t7xx_state_monitor.c | 3 ++-
>  drivers/net/wwan/t7xx/t7xx_state_monitor.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> index 80edb8e75a6a..0bc97430211b 100644
> --- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> +++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
> @@ -445,7 +445,8 @@ int t7xx_fsm_append_event(struct t7xx_fsm_ctl *ctl, enum t7xx_fsm_event_state ev
>  		return -EINVAL;
>  	}
>  
> -	event = kmalloc(sizeof(*event) + length, in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
> +	event = kmalloc(struct_size(event, data, length),
> +			in_interrupt() ? GFP_ATOMIC : GFP_KERNEL);
>  	if (!event)
>  		return -ENOMEM;
>  
> diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.h b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
> index b6e76f3903c8..b0b3662ae6d7 100644
> --- a/drivers/net/wwan/t7xx/t7xx_state_monitor.h
> +++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.h
> @@ -102,7 +102,7 @@ struct t7xx_fsm_event {
>  	struct list_head	entry;
>  	enum t7xx_fsm_event_state event_id;
>  	unsigned int		length;
> -	unsigned char		data[];
> +	unsigned char		data[] __counted_by(length);
>  };
>  
>  struct t7xx_fsm_command {
> -- 
> 2.34.1
> 
> 

-- 
Kees Cook
