Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6F7A14A0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjIOEBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjIOEBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:01:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB39F269D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:00:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c328b53aeaso14505765ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750459; x=1695355259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSXFfyqgPwKVqMylZWaZxOwMkCRZt/DukldIcyDr7/Q=;
        b=OLrBWk+HHUIEagXG9HPi9FmVAexOREXK8DbV4Qa9njdBrjDNZ5qiM3QaBAAGlZqgUS
         84DVS843GER+iS3+9N1WMDQKv7VVywrngGQG/KZnAFFXGXI41pMQih2gh4yqU3fyWnWw
         vtPQ71EdCJ1HBaCHm/K6UabYgv+1faZsGG8Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750459; x=1695355259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSXFfyqgPwKVqMylZWaZxOwMkCRZt/DukldIcyDr7/Q=;
        b=b/SKfL3rvAguKR5Z2UrukxTbpGyr1cCRzPO6WsAfWaTr5CEsLZuiRPDh114pX1kAtY
         HwkHyaP1FGxmbP6crOEWzdKcpeyaQkcBJcau1vWoZEQS8zOleQ7g96ltiG2liJdTg3q8
         xTomITc8TKkcTIVu+V0p6sDscdCZ3jITDaqzCFlmnj6F9T38jMJ75TiEKjjCxbCLhNEr
         tOKfPuRZU8wfRhwm9dzkB7Iuu/bHHGIr8+VYTs1LqBuajqSxiRrB5lKRpM6Femb7IC65
         Ujl93S6JfnkV62yxLZ/zlWrr1gk54KBxUUh0usdoMFwd0+SYOPIRJAmjqwuqqMtY46x4
         /4nw==
X-Gm-Message-State: AOJu0YyN0tJz5fu00ZgudhJi9FyDfl8I6/6wbr8UIO64EUb8jOs+nMGI
        ivO4vgWRmNvmKV8DcSWf2e+Q1g==
X-Google-Smtp-Source: AGHT+IGrfmym+Yfc4T+2FuFkeWde43uGhYIAgsRNS/mPDe3YUyp9Q/Gpkh8qdFQgMFLcFHhnM1UsEg==
X-Received: by 2002:a17:903:2302:b0:1c0:afdb:1e6c with SMTP id d2-20020a170903230200b001c0afdb1e6cmr691210plh.8.1694750459263;
        Thu, 14 Sep 2023 21:00:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jb4-20020a170903258400b001c0cb2aa2easm2350777plb.121.2023.09.14.21.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:00:58 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:00:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: tegra: bpmp: refactor deprecated strncpy
Message-ID: <202309142054.8D93862@keescook>
References: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-firmware-tegra-bpmp-debugfs-c-v1-1-828b0a8914b5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 07:38:44PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> It seems like the filename stored at `namevirt` is expected to be
> NUL-terminated.

This took me a bit to establish, but yes: buf[256] is used to store
filename, so it'll always be %NUL-terminated with the 256 bytes, which
is the same size used to allocate virtname, which means it will always
be %NUL-terminated.

> 
> A suitable replacement is `strscpy_pad` due to the fact that it
> guarantees NUL-termination on the destination buffer whilst maintaining
> the NUL-padding behavior that strncpy provides.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

This one looks weird because namevirt seems unused, but I assume there's
some kind of DMA side-effect happening somewhere?

But, yes, after digging around here, I think this all looks right.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
