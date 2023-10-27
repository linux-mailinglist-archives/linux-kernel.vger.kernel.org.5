Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8767D9DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjJ0P7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0P7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:59:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB318CE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:59:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b9390d6bd3so1011419a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698422373; x=1699027173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIpZiRguR5ztX72Jx9GSG1nVMOc1X7wxd/73UnubI+4=;
        b=XmMbTyk06xcZR+tb63HhYGNsnuXyNpdeD+oxiGcYlEBWG7Y8w2DJoGlW5jlDrdV51d
         Ibj+XFKXfgG3v09VjMIpfVdZMwqxXTjJd5vgUMkjVLl8G7OaivxHRFT4X6z1Cvh+IBw5
         HGjzV7wMw6apQn30K/22vXi6/UE3nkrKEe4DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698422373; x=1699027173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIpZiRguR5ztX72Jx9GSG1nVMOc1X7wxd/73UnubI+4=;
        b=Q9lLdPuEmyCdeKiOIqmVr+jbK/RsqW7KsKLxZfuYp1kZFqQWeA3IKDdefR+08YLrTN
         DAusSMxnYr1+15No10UIZccfp2Fwf7vVI/+IqQ/WrwZAqqn9kZrE50dCbN81eR+7QU3k
         OwHnbpgn8x0WlrbaBtL6kyJVx9b9SpqnVcsZHqxsHcDZCwIxSoWZNX9XDvEA6uZfxc0A
         Je1Y2Cij3cF2KKVxla6ZgR54kyKzLxM0r/2Wj+jU75a1UmOzm0eLxT4RWaN1+ouVkPHw
         WsViFrVzAykIO0W47BrVNZPKNSS1lqKYXvXmYWDR6DLLAF3fsUzQHHMHf5HXjj5lk2bQ
         xf1g==
X-Gm-Message-State: AOJu0Yx94C0rbMsruSQYx6KKiTNjnrEZiYnSNzlDIKJ1N35wxeCpHcof
        Ww8+nfA1tvsD9krTBlYZmZjziA==
X-Google-Smtp-Source: AGHT+IHCPZdNAcRG+t1M2xwWBMvbdltKNplZZ5qGLIJGn/zQD7Qk2n9PkgKPFNuyQusVj5VdP5iidg==
X-Received: by 2002:a17:90a:4ca5:b0:274:7db1:f50f with SMTP id k34-20020a17090a4ca500b002747db1f50fmr3784895pjh.15.1698422373079;
        Fri, 27 Oct 2023 08:59:33 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a2e0200b002749a99318csm1376715pjd.26.2023.10.27.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 08:59:32 -0700 (PDT)
Date:   Fri, 27 Oct 2023 08:59:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] airo: replace deprecated strncpy with strscpy_pad
Message-ID: <202310270859.8EB5599A@keescook>
References: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-strncpy-drivers-net-wireless-cisco-airo-c-v2-1-413427249e47@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 11:19:18PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> `extra` is clearly supposed to be NUL-terminated which is evident by the
> manual NUL-byte assignment as well as its immediate usage with strlen().
> 
> Moreover, let's NUL-pad since there is deliberate effort (48 instances)
> made elsewhere to zero-out buffers in these getters and setters:
> 6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
> 6130 | memset(local->config.rates, 0, 8);
> 6139 | memset(local->config.rates, 0, 8);
> 6414 | memset(key.key, 0, MAX_KEY_SIZE);
> 6497 | memset(extra, 0, 16);
> (to be clear, strncpy also NUL-padded -- we are matching that behavior)
> 
> Considering the above, a suitable replacement is `strscpy_pad` due to
> the fact that it guarantees both NUL-termination and NUL-padding on the
> destination buffer.
> 
> We can also replace the hard-coded size of "16" to IW_ESSID_MAX_SIZE
> because this function is a wext handler.
> 
> In wext-core.c we have:
> static const struct iw_ioctl_description standard_ioctl[] = {
> ...
>         [IW_IOCTL_IDX(SIOCGIWNICKN)] = {
>                 .header_type    = IW_HEADER_TYPE_POINT,
>                 .token_size     = 1,
>                 .max_tokens     = IW_ESSID_MAX_SIZE,
>         },
> 
> So the buffer size is (strangely) IW_ESSID_MAX_SIZE
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks good; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
