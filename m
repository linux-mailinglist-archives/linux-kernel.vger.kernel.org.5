Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E057CED65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJSBTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJSBTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:19:05 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A80113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:19:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c08b7744so90787707b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697678343; x=1698283143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgp6z1oSdgUt9IWRR9iqkN0+S+6uNUFzUlZ52E0GfRE=;
        b=RMvBUOSuSQCX8LvQNCehtRVgw0wL99GLaIgJSU/bnR+fEmFggV7rWCGvyK6hLiIHg6
         QTKCknMBM8KKfiJWt1ctRNhT3qnBrMy7U7EzTOQTPl/e+9V9jD45SxzA0NTmBAO4/oWQ
         lfLvi4tUuAoEBKkrrZlepge+e3Jmt0ocS5IQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697678343; x=1698283143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xgp6z1oSdgUt9IWRR9iqkN0+S+6uNUFzUlZ52E0GfRE=;
        b=J/Lg+VUgoqDQ0NBbfVCgImSvia6gQRlLKqLylGHxhmVqsyU57D/oueQUkHNgbxbkZm
         r1vIbcUBoNhICRreb9dXPvK+a96bE22K6yog3urBLahhbYx3E60P0YEyB3qZWM8kxJTi
         sRW+/ryjh3/Cx54Rd3rNdy4lOAQpJyWoY9zoCB0F3cmwMrG05MbrrJzLDpTP6MVHh/nY
         icQ3txd073rnAbQtTqYJlS7sdmFzm5cajbDoaxm8leo4cnxE32QUkRPLgFtSYQbBtHhE
         gbQhNz02ExIjfMHWOTLGcWpprMSkap88MghsW3d5hkrX26F3F5PiAzPa/wgIT+TNKePr
         WyFw==
X-Gm-Message-State: AOJu0Yw9hO0kCvUUssHVwaQ2Rfdc29NqDXGC1meGiBWwK+dgGc5l52+x
        0TAemXDlREFXVSiRW3nM3vE56Q==
X-Google-Smtp-Source: AGHT+IG3mAP8gw66SVpkc5giu589EfWx1B2jkhPIkaRjNV7e1LI2HxlT4Gr/1DydCq2HbLeRe8PkEw==
X-Received: by 2002:a25:d50:0:b0:d9a:d61d:17dc with SMTP id 77-20020a250d50000000b00d9ad61d17dcmr915811ybn.36.1697678342824;
        Wed, 18 Oct 2023 18:19:02 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h191-20020a6383c8000000b0058953648c27sm2318856pge.88.2023.10.18.18.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 18:19:02 -0700 (PDT)
Date:   Wed, 18 Oct 2023 18:19:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ipw2x00: replace deprecated strncpy with
 strscpy_pad
Message-ID: <202310181800.C6F7B42@keescook>
References: <20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v2-1-465e10dc817c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-strncpy-drivers-net-wireless-intel-ipw2x00-ipw2200-c-v2-1-465e10dc817c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 09:48:15PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `extra` is intended to be NUL-terminated which is evident by the manual
> assignment of a NUL-byte as well as its immediate usage with strlen().
> 
> Moreover, many of these getters and setters are NUL-padding buffers with
> memset():
> 2439  |	memset(&tx_power, 0, sizeof(tx_power));
> 9998  | memset(sys_config, 0, sizeof(struct ipw_sys_config));
> 10084 | memset(tfd, 0, sizeof(*tfd));
> 10261 | memset(&dummystats, 0, sizeof(dummystats));
> ... let's maintain this behavior and NUL-pad our destination buffer.
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> To be clear, there is no bug in the current implementation as
> MAX_WX_STRING is much larger than the size of the string literals being
> copied from. Also, strncpy() does NUL-pad the destination buffer and
> using strscpy_pad() simply matches that behavior. All in all, there
> should be no functional change but we are one step closer to eliminating
> usage of strncpy().
> 
> Do note that we cannot use the more idiomatic strscpy invocation of
> (dest, src, sizeof(dest)) as the destination buffer cannot have its size
> determined at compile time. So, let's stick with (dest, src, LEN).

Yeah, these interfaces have external buffer size declarations. In this
case, MAX_WX_STRING.

This is probably one of the most difficult set of callbacks to track
down. sysfs might be worse...

But, ultimately, this is a private ioctl handler, and it is all boiled
down to calling ioctl_private_iw_point() (via ioctl_private_call()),
which does the allocation of "extra". The size, which is not passed to
the handler (*sob*), is determined by: get_priv_descr_and_size(), which
is looking at drivers/net/wireless/intel/ipw2x00/ipw2200.c's
ipw_priv_args:

        {
         .cmd = IPW_PRIV_GET_MODE,
         .get_args = IW_PRIV_TYPE_CHAR | IW_PRIV_SIZE_FIXED | MAX_WX_STRING,
         .name = "get_mode"},

So it looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
