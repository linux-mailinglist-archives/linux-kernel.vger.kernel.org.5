Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8297A14A2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 06:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjIOEDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 00:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjIOEDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 00:03:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAA7270C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:03:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so1362173a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 21:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694750610; x=1695355410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bdckIkCIpFym7NUpRG7gX2O8Kgm1I4+FpTJ9+N9Nf8w=;
        b=esQwlkVDCg0AEMMAu81jaIgDB7TJXZTvEYj+Lw0TbrqWJ4jCs5JfMw1ULHWt3w+0uV
         9i5eYpW39cdLGlAfLhH8ZbEruBai0g4AuMR372XYpbwmHAhJksMsvmSUbIgyPwlkVOZP
         6UOkm5iEQCBM/flEgnKHqAtkDZtCMBG06f2jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694750610; x=1695355410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdckIkCIpFym7NUpRG7gX2O8Kgm1I4+FpTJ9+N9Nf8w=;
        b=DBJH9YP+f6FSG59+s3R4f8iZbB8W1VvhDqaRN5fV9kxna9+ipwwnODj4bJDMKytCBS
         uMcPoMJ1dq6E08mnBq+6xhK7Vh0gdV7uLK+6nvg3ZqGjCwaYBXgdBUS8osoT7G6xEQpc
         S7mydliLHcNLyKLW/njS3VUOMiFNizYd7TczU/Jb5ck7wfJFjj3dk1N806+V8jxNZCTO
         ilzkHg4Sl7XVqSwI8fucVLiaAehFaJfhHjDsD/z96zBZcCLu2UiXqAGuDdo0KZ0PcPUo
         qHk5Y+kS4S3eywC4fYupy6JuwveZwryg3liEAgGF7zRy8qbYzyU03URbms634v+g4UAz
         vtKw==
X-Gm-Message-State: AOJu0YzSUnI15ip4vZ/LauR6lfngQ1SxfzI+kKQQ+C0beIKDlOlw2tG9
        AfNLYD3IjOkyrXaHFnNIHojKuw==
X-Google-Smtp-Source: AGHT+IEE1WYc4bw/B4ik03Qzn2D6jVmzYFDS1WbU6ybgM/bCKoZwSIktSE3iQqs/niV/77/brIgkqw==
X-Received: by 2002:a05:6a20:3ca1:b0:14d:a97c:911 with SMTP id b33-20020a056a203ca100b0014da97c0911mr866067pzj.5.1694750609891;
        Thu, 14 Sep 2023 21:03:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001bf095dfb76sm2336357pld.237.2023.09.14.21.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 21:03:29 -0700 (PDT)
Date:   Thu, 14 Sep 2023 21:03:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] firmware: ti_sci: refactor deprecated strncpy
Message-ID: <202309142103.6DFFDEB@keescook>
References: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-firmware-ti_sci-c-v1-1-740db471110d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 08:23:02PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> It does not seem like `ver->firmware_description` requires NUL-padding
> (which is a behavior that strncpy provides) but if it does let's opt for
> `strscpy_pad()`.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
