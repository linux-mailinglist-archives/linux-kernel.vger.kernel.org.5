Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BE777BFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHNS1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjHNS1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:27:23 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B7610E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:27:22 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64189860374so22789276d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 11:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692037642; x=1692642442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nPuEr9ffpYT50uyWOuooVLtYp6gPFgUGgYmMYDLov4=;
        b=Wlxhu0KdWj8ZVGoijMtkrysJPPemVWlBkEgZOkzmwA5DNaeXwZjX0FRU1upqeNLTBt
         48uqIG9wGyX5KhMNEZgPIvFKo8gUn4dp4S/NeChxokry2p2dTgMUrRC4b/cJ0NOGqfmW
         peUrIZiLMRqe4/UNDqrRsX12TkukhP+cEhndXBo00cTIU7qPoqKFu3kJaRkrmIg9Lrgb
         rx0GpweY+pQ8EqM8M3c2BNyOLq3fQ2fV1abF+dEBQmoiMcXShDn8a3vl1R23z/B77CpQ
         spIc84p7f5LLhX1OoH6gkOlLfYxHMsy0Hjz1UFU14JLOMPWMkP2PPF6xO7ewvI5UvxUc
         Llzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692037642; x=1692642442;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nPuEr9ffpYT50uyWOuooVLtYp6gPFgUGgYmMYDLov4=;
        b=dt9UdumUE73ZA6UcHLI8A4LzZ4pehLK0gkMX295s2mWVl1x1R7H+WLtK6ktKBZwahk
         YjZtPP1Q1EYiidGQjNMrZLXQ4LwS94lpY88DAaUv1+5vgbQAA9l5FfqvWBc+zgBjyy52
         sJcn/xl9MEtoPeEUTUJXFmj5eTxgkAWKMtfZiMgJ+C7ieqfDc9yeIIESlzsdrsUt409h
         K7pbZwmKiSjMMH+SGTnzGU2kDd8/49KNmJswv13f8/dPJ/fuiE6Qsu8iVnAbgaWw9phU
         S/2G/u9OGcPV7WUNAtCdU6vi4yrZY6l50xMp9AIk/7ygEuJiyWJrg9tninTjfXZi6eBA
         qFJA==
X-Gm-Message-State: AOJu0YzuS4Pd6cpihA8fFxb+x9ujnv1pQh05sZKafPB1XAzIwPXr/EPv
        FDS7C895nl0RDlVagL9oeJTdh489lHg=
X-Google-Smtp-Source: AGHT+IELD0G6gNdWODHJZgKpOtSH1OwMRJbFfQvyhV0CUwbDzBPhFqTXk986IgyUUYaCkunLDvJYAA==
X-Received: by 2002:a0c:8e0d:0:b0:646:8466:b416 with SMTP id v13-20020a0c8e0d000000b006468466b416mr7351911qvb.44.1692037641715;
        Mon, 14 Aug 2023 11:27:21 -0700 (PDT)
Received: from localhost (98-159-221-50.static.firstlight.net. [98.159.221.50])
        by smtp.gmail.com with ESMTPSA id q10-20020a0c8cca000000b0063d366b0300sm3596828qvb.89.2023.08.14.11.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:27:21 -0700 (PDT)
Date:   Mon, 14 Aug 2023 11:27:20 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bitmap: Fix a typo ("identify map")
Message-ID: <ZNpyCGCjcSz940Zl@yury-ThinkPad>
References: <20230814173708.1746905-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814173708.1746905-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 07:37:08PM +0200, Jonathan Neuschäfer wrote:
> A map in which each element is mapped to itself is called an "identity
> map".
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied in bitmap-for-next. Thanks!

> ---
> 
> v2:
> - Add R-b
> ---
>  lib/bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index ddb31015e38ae..24284caadbcc6 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -988,7 +988,7 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
>   * to @dst.
>   *
>   * The positions of unset bits in @old are mapped to themselves
> - * (the identify map).
> + * (the identity map).
>   *
>   * Apply the above specified mapping to @src, placing the result in
>   * @dst, clearing any bits previously set in @dst.
> @@ -1037,7 +1037,7 @@ EXPORT_SYMBOL(bitmap_remap);
>   * the position of the m-th set bit in @new, where m == n % w.
>   *
>   * The positions of unset bits in @old are mapped to themselves
> - * (the identify map).
> + * (the identity map).
>   *
>   * Apply the above specified mapping to bit position @oldbit, returning
>   * the new bit position.
> --
> 2.40.1
