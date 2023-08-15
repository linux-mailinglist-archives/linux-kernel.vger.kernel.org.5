Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84D977D493
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjHOUrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbjHOUrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:47:06 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DC1FD7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:46:40 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1c50438636fso1535423fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692132397; x=1692737197;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VaIHc+gFTv/gCTaNkA6eGeAJslVqFsij3m6nG8kuwbQ=;
        b=BtUF+COVfEoHH4ObDCfa8UZniGPU0b3si4iqFKuVip+tVxTiT7c+k5vhwcSpRM2qVv
         e/fD581IC9g0wfwo7Hw5lmY9O4uTBEkiAXviNuLyaSWP5oMvm9n/ElQ5/k4q5tSZdrd6
         7XNtl36ytsmoedPMWeDPK32he8IXGNeGXKFeOb65ptuniXMm47nJpqSw4VA50AWZWdAE
         5aril4u1K7Q9Q/ncBbuGZPlqTrWIquwBOSFmQeEOOo5izk57QXjpXTQmxlZe/jM/xiwF
         fTkZvfsL9QsDm332StnxKO7pAA98yeWeiXNRzNI/CrCeR1otZ50L+HSj/zwCVNmoohZI
         +Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692132397; x=1692737197;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VaIHc+gFTv/gCTaNkA6eGeAJslVqFsij3m6nG8kuwbQ=;
        b=fjX8ZgT/W40nSAY0MhpSGxZVHYZqFI2XCzpE5fINnQefk8ndm4iI0Bk2DetHbdRrS5
         n6JSzELWXKtUdXOjvjhkI1GbFwCb/DzTp1ue33cCfb7xd06EB7Ft1n/fdw7t0JLBnIbI
         ieYp+MWATuZAHiMqMRWtjYOuGt4kWiDmsp6/SzK9ebxWcL9UKCQUTxrOVrr2zkJb+9On
         otvQErAzP+95SD3CxB56yXChTRZhX/8GXO3egQEoyU6m8N8MvpwqoFLcBcUsVY9Xpxwy
         t/nGdeJfs3ViI8Sha6AJoPnYVvnxrthNrVjMitsUWaRgqngT3uMdFssJqKypEEQetM/q
         bG0A==
X-Gm-Message-State: AOJu0YwQL64kzO51lx0aYOvQoDWY0PRancAAJS9QH7b+Twysp7oVcrsw
        NF5GxMP+WTW86UvzuKTLzEwewYcAHA==
X-Google-Smtp-Source: AGHT+IGIcu+xaJ09yTpMfBilaQOCvslUE7RUnQyVistmiDU9ejNDPAdGiWvFAJ3utTuKFPtcgU7wpw==
X-Received: by 2002:a05:6870:601b:b0:1c3:c43d:838 with SMTP id t27-20020a056870601b00b001c3c43d0838mr15178841oaa.39.1692132396755;
        Tue, 15 Aug 2023 13:46:36 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id ef38-20020a0568701aa600b001c4b8a9ef88sm4779365oab.24.2023.08.15.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 13:46:35 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:77ae:9090:5436:3099])
        by serve.minyard.net (Postfix) with ESMTPSA id 91B5C1800E8;
        Tue, 15 Aug 2023 20:46:34 +0000 (UTC)
Date:   Tue, 15 Aug 2023 15:46:33 -0500
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
Message-ID: <ZNvkKReuMsDCktsH@mail.minyard.net>
Reply-To: minyard@acm.org
References: <20230809-cbl-1902-v1-1-92def12d1dea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809-cbl-1902-v1-1-92def12d1dea@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
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

Ok, this is included in my tree.  Thanks.

-corey

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
