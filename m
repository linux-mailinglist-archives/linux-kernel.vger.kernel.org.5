Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19397ADDBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjIYRRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjIYRRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:17:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01EF10D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:17:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690d8c05784so5105399b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662253; x=1696267053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh8DqYJ2SwbIqpzzYZaUHPp5PasBm1tKXhMFi2b/M3M=;
        b=auVOZIDFNAxr9Vgv0qza15dkVmMNPEeW3sab25uiXkrOyMWHtRDypNrAVaeqm/5rfl
         w5D4DTNUj1s1dRAZfk1REwy7irJXXs6Rx7PQwf+0t2xhaX893VYS55SRj8KOx6JuBGFN
         dmLLZixHt7ZBWcPhm72lMDb/10XSjQ+XyS3I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662253; x=1696267053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jh8DqYJ2SwbIqpzzYZaUHPp5PasBm1tKXhMFi2b/M3M=;
        b=ePJVIFlxJISw9WhTvv6PovluA9vhRofEQXvgc9Z9ZZXkzppRT4c69TdiBjxi0FMbd3
         mjlUEfaRi/f5zn8x//AxP26ulugM+h9AXafwUgqcJT1EhLRprukwcHxoqlG3/s1kJC6l
         tqpbbIpBC3qAeuuBsAWUhF1a2RXLbk44HsIPME8LoU8aV5b375gKL6oy/sKKzS+K1feO
         UDsazHVkIWGeU2rVNpa9lSLnpZFlZOd1QG0Kp5TLt+Lw6rq7mBkDJ1MlLjFPHDaLyToB
         b5tLLy3uSeQ9fp6bJcHZNldpCPGJjFuqbJKL0asMP1yfajXecpjo5Xj5grNB/UFCzu99
         HJ5w==
X-Gm-Message-State: AOJu0YwUnLaD51UDxVhtu7e0ho2CpcBmQCmOI95lJBgGOmmGRVtr83g4
        PSiWczKxDPlF88Hwzj8zaFrVnw==
X-Google-Smtp-Source: AGHT+IEthMrGJUlIHLvFMqKnkR1JjLvwrAVSHFpBA55LiKKvZb2xEbera8+CZE1rcTc6k8edakLzyA==
X-Received: by 2002:a05:6a20:1593:b0:138:92ef:78f9 with SMTP id h19-20020a056a20159300b0013892ef78f9mr6679763pzj.6.1695662253260;
        Mon, 25 Sep 2023 10:17:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n26-20020aa78a5a000000b006889664aa6csm8377453pfa.5.2023.09.25.10.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:17:32 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:17:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Annotate struct linereq with
 __counted_by()
Message-ID: <202309251016.DEC84A52@keescook>
References: <20230918091553.1103567-1-andriy.shevchenko@linux.intel.com>
 <ZREuqs2LkkF3jqD8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZREuqs2LkkF3jqD8@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:54:34AM +0300, Andy Shevchenko wrote:
> On Mon, Sep 18, 2023 at 12:15:53PM +0300, Andy Shevchenko wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family                                         functions).
> 
> Kees' patch is better, please ignore this one.

Oh! I didn't get CCed so I didn't know you'd sent this. :)

Thanks for taking the initiative on this, though! (But, yes,
initialization order matters.)

-- 
Kees Cook
