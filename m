Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A19F779889
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbjHKU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjHKU12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:27:28 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266310F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:27:28 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-586a684e85aso25788847b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691785647; x=1692390447;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UbK4nnymHvPms4qLxQwbH3NM35gMPbEu4WBWUEgE1g=;
        b=o7DUElapNyvjmyACrVVOC7+p6ZhVxbT+HsfcVJ6xyq28u+Dhi7Ru9ReuEGNdkOyFnU
         XjZSESoC1/pAOPLHT/2ElG6/JM2ngkQyoiYCdchEJreGZvjKcOwDbB96ctiZwwb1+mzU
         8r9ob4k+1OxsY5EIJEKP2Mf9MPF5fNIrjQxdtn2F81CuB3qbEkgMl8Db2dxZ5uiYt2aM
         a/3s2CUllV78jDpS/UGf/MVZtJN440MTANe5E9lh+3zSMI67qVyueE/IZAXFY5bqAdkr
         ZdICJj/5Er3Vk0NW4nrHc/J7g1hu124/N9Xockd+puGL6F8r9BcBPH7JJEkkhXfq1uc4
         3BVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691785647; x=1692390447;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UbK4nnymHvPms4qLxQwbH3NM35gMPbEu4WBWUEgE1g=;
        b=aZZ3e96IotvvsL6ObFB+LK86e4vCnVb8WKbbhyJzKJxg0vlI8vEJ+2JWjglaGmu2yC
         4vsZh0n4qFPjulYekI6sJV9K2WymjZzfEhgE9b7bgnI+PWNlZH3NmBszNhmDTjVYpHgL
         6cNXqVYsOv2tudebNH1dPUi4t1zWgKn5AtDW5lzlzPftYd6KHpbwnZwegmUPyTQdLfIF
         h78FNBmdIxbTl/Wy8lLbMrQE/UNhPqz4t1eZrPwWlmc+mkHKY3IpGwhQmsR1283jpos0
         N2KkYSHXDmYX7aDsadilBSa1sDO/Fuf2oQYnk8f4rt/mjo+t/P73WEypE1pKyh4XP8C7
         ZoKg==
X-Gm-Message-State: AOJu0YxCV56FvmdRQ/e4099laapmKCDffa1RANQ01Xel6Om/sAjzAO8g
        JHGef6/loHNWBDYcaAL6Mg==
X-Google-Smtp-Source: AGHT+IEVW3hz+iAn9LZuVHgGCUAJz9pTjM8+y7T/OfekbKp6pqC7IRoYZBPbj3XM/hqz7mROvhV5yA==
X-Received: by 2002:a0d:f941:0:b0:583:523e:6569 with SMTP id j62-20020a0df941000000b00583523e6569mr2706967ywf.17.1691785647070;
        Fri, 11 Aug 2023 13:27:27 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id y6-20020a818806000000b0057736c436f1sm1203438ywf.141.2023.08.11.13.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:27:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:e34a:4ada:ffd0:e7ff])
        by serve.minyard.net (Postfix) with ESMTPSA id 5FB071800E8;
        Fri, 11 Aug 2023 20:27:25 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:27:24 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ipmi_si: fix -Wvoid-pointer-to-enum-cast warning
Message-ID: <ZNaZrHEs5FP7Lf8A@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230809-cbl-1902-v1-1-92def12d1dea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-cbl-1902-v1-1-92def12d1dea@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:05:17PM +0000, Justin Stitt wrote:
> With W=1 we see the following warning:
> 
> |  drivers/char/ipmi/ipmi_si_platform.c:272:15: error: \
> |       cast to smaller integer type 'enum si_type' from \
> |       'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> |    272 |         io.si_type      = (enum si_type) match->data;
> |        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is due to the fact that the `si_type` enum members are int-width
> and a cast from pointer-width down to int will cause truncation and
> possible data loss. Although in this case `si_type` has only a few
> enumerated fields and thus there is likely no data loss occurring.
> Nonetheless, this patch is necessary to the goal of promoting this
> warning out of W=1.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1902
> Link: https://lore.kernel.org/llvm/202308081000.tTL1ElTr-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note:
> Arnd had mentioned that there perhaps may be some semantic differences
> between GCC and Clang regarding this warning or family of warnings. For
> now, this patch (and others following) will yield less noisy W=1 builds
> and hopefully materialize into this warning getting promoted out of W=1
> to an always-on warning.
> ---
>  drivers/char/ipmi/ipmi_si_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> index 505cc978c97a..0d509d683c0f 100644
> --- a/drivers/char/ipmi/ipmi_si_platform.c
> +++ b/drivers/char/ipmi/ipmi_si_platform.c
> @@ -269,7 +269,7 @@ static int of_ipmi_probe(struct platform_device *pdev)
>  	}
>  
>  	memset(&io, 0, sizeof(io));
> -	io.si_type	= (enum si_type) match->data;
> +	io.si_type	= (unsigned long) match->data;

Wouldn't you want to use intptr_t or uintptr_t?

-corey

>  	io.addr_source	= SI_DEVICETREE;
>  	io.irq_setup	= ipmi_std_irq_setup;
>  
> 
> ---
> base-commit: c1a515d3c0270628df8ae5f5118ba859b85464a2
> change-id: 20230809-cbl-1902-7532a747b731
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
