Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121087514D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjGLX5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGLX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:57:06 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ADF1FC8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:57:04 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a1c162cdfeso121060b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689206224; x=1691798224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYROqSK0oGJBA8nxTpmL+2rtwtyb8ppjHpWlTiycuKo=;
        b=AZTKaFYYXON4rgsnRbf3f/htNSktLIa7GziRaeoZhHru0aYHY04rcSunBeh8mzMsgm
         eu7l9CedpWX3IP0/3g0x/1pegm3t7l8KywxFZiQFuffX6Dh6/e+JZCzwvgtTTKBFlBoG
         fIwMbca317JWpsuBHvDBG/TdYvbf+VF72ppTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206224; x=1691798224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYROqSK0oGJBA8nxTpmL+2rtwtyb8ppjHpWlTiycuKo=;
        b=UrMzXCbEhMdk+v8TFGcAJ0TdwIe5znWb01RIIWKxSZKMGlxpJBoK2lSl/oECrhazfF
         xOytnN00koMGAmXDDafQ6OZJxTT194KP8McVMzXyzW8t8rMkPaxEfPFVyN9huK8TWpZi
         3sjLkZ9Byxt+fma1q9FroO0bDNf209bR4HYUNV3AkiyQ+9rHDbbZsBDjBvGCJ8uZ4eF8
         0nmylBYoQ5+iT94WE5g2kKc0v4skiofK1aN0GlxpaKq7oGfpq0z3zd8otTvoaRwjJqHh
         RuI1S+h5ED8+419EFw6BJgpt4+3861z0RuDYccQK3sTQE9+ffKsSM0lIcGvXoHw3gt6V
         QRyQ==
X-Gm-Message-State: ABy/qLa94nGs60s/sUS04oEeBpnqCtWSmEkXKOCa7eGtpLUP+FNfZ1Ji
        JjmXhUjeysQeDHuWhvVaNo76MA==
X-Google-Smtp-Source: APBJJlGkuv3xzrFZa1CbUFIQB39M3wGoMPlRAgtPPH6QwfuF1YKCuvoHZyltzxMVwxohnGxyvw0gqA==
X-Received: by 2002:a05:6808:130e:b0:3a4:2460:2b9a with SMTP id y14-20020a056808130e00b003a424602b9amr5257820oiv.34.1689206223773;
        Wed, 12 Jul 2023 16:57:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g19-20020aa78753000000b00663b712bfbdsm4163550pfo.57.2023.07.12.16.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:57:03 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:57:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-hardening@vger.kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH] um: Remove strlcpy declaration
Message-ID: <202307121657.9B32681D6@keescook>
References: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703160641.1790935-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 04:06:41PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
