Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768CB7BEAE0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378433AbjJITvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346683AbjJITvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:51:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C13894
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:51:40 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-694f75deb1aso4347897b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696881100; x=1697485900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2qK3/RPJGcH/Y4e4B3fj0OlYjfNOjt5OVjwpAAdhYw=;
        b=RWW4Vv7ZBjTnjdSaOZsWTZ934w9WMWvGtMzJhHsD6b7A+MzCg3dciS0VjCE788pSU3
         zXjzrUyNkXXz85DQdO6aEM/YZcUfAapzcc/2pUzuase9IJcJC3DgjBTkGgRT//XgYbLn
         4ccdiy8geLYkbU/nIe1wbJxAXOaPZKF6wh2Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696881100; x=1697485900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2qK3/RPJGcH/Y4e4B3fj0OlYjfNOjt5OVjwpAAdhYw=;
        b=ABDPUCikfDwGRHR0Ax1ZvGLsdYvkHMKt8H0r8oNbOgzvS63vJRx8j85f++xBP3jixF
         ZOPFtXBovOfDpfFEWJO+dmEzePLApxDznJ2Uf0QCoJinOrn9LYhp4G1T4ilFPxhUWA6A
         vopG87cCIyrE+z6nQ3CzXrN3qFm8X2PKMCgUN1n4hTvbotXbJp4lc1UbmgF9x3qVYajg
         RqjDzxRqNhGgsnYrCtgKMYX04jH2+gh7nXBROLLgw7FThfx5XIPOogM6FlCY7jMlIXFG
         cO39K6bTW4C+DbymP+QYtuCtco0995s6LoCcpFhY+SFl2/iJQpXX5ASVViCjggo0dco1
         ytPA==
X-Gm-Message-State: AOJu0Yz8PFQGn7tixNwPsehGJ+d5lAcnHVCbkEX98aLzlLP97BGo/l8k
        jcG93rVOmied89iiqaICwmo0zA==
X-Google-Smtp-Source: AGHT+IErKu5nijcGQNO4C5TTmPCzq/DLxiROmTLvRJ5rM8E6o7Mvo2fsCJGqYmjn1eMmUSEOjczf4w==
X-Received: by 2002:a17:90b:4d8b:b0:27c:df02:88b3 with SMTP id oj11-20020a17090b4d8b00b0027cdf0288b3mr787340pjb.8.1696881099801;
        Mon, 09 Oct 2023 12:51:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ct19-20020a17090af59300b0026b3a86b0d5sm8806769pjb.33.2023.10.09.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:51:39 -0700 (PDT)
Date:   Mon, 9 Oct 2023 12:51:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ASoC: apple: mca: Annotate struct mca_data with
 __counted_by
Message-ID: <202310091251.B877B4AF@keescook>
References: <20230922175050.work.819-kees@kernel.org>
 <202310061321.E7247C52B@keescook>
 <6c7db067-78f2-4637-8064-3dc7c0489b90@sirena.org.uk>
 <202310090958.27F5025BDB@keescook>
 <6d665575-7658-4619-a763-438e0d3aaf2e@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d665575-7658-4619-a763-438e0d3aaf2e@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 08:43:44PM +0100, Mark Brown wrote:
> Off the top of my head I'd say wait at least three weeks for this sort
> of patch before doing anything and then prefer to do a resend, that's
> should avoid most issues.  If you're going to just apply things yourself
> I'd suggest waiting for -rc6 or so before doing so (assuming the patches
> were initially sent reasonably early), that does seem like a reasonable
> backstop so things don't completely miss releases.

Okay, sounds good. Thanks for the clarification!

-- 
Kees Cook
