Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EC97C7636
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442009AbjJLTDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJLTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:03:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F961C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:03:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c8a1541232so11967425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697137418; x=1697742218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h+UW4+U9HpV+E9ycAwBZg91gnF7Sw/DTzJeLz9wATvA=;
        b=KAubfCj1S+bG6xkRbpfls3howND2lMjegG8CiiMKTaPC8AMb+PvBdSRjPOsXLwhPSB
         fS9A82A0uL45C32+q87qYWAl3lXBX3VnIxkqFO9irHAyAS4mR6A8YaCSHSVTKa3n8ohC
         veutWPALsUI0ecF9zfAtDRJpnb7ACVCbr1pJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697137418; x=1697742218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+UW4+U9HpV+E9ycAwBZg91gnF7Sw/DTzJeLz9wATvA=;
        b=iwrLLOAd0vmbty8Wa5qfjjnOIrI19oAZrtfh5siOWVNfrNBmPiWxhdrjbHfx58MpWQ
         kRh+vGURfyjhReb0JqXnpwwFSTFBY63ftaORs3+WlEImsbT4tAztyYEOdhMiqjGTb9zz
         CUE4S7JfrK6Qhgm8bLPnw7tCxfnpSfe20fDYuFKq2/6A/Mp7e9yE2ja5GibYscM56Ib6
         AZjfk6Dd52YaluV9cqH79CjAkcJ2c+qym1ouTjIlMiAU8Ij6f/fPTIiWxZVjlhtVwN/T
         hDqAYT10aRY73pmzR6Mdpl5X0P6sL7vqU+N0A564RGkfSvKoD9c+SJNgv2ews8XI3Sjw
         wxLA==
X-Gm-Message-State: AOJu0Yw5mOKSeMNMpnG0VE2iw5OyWbf0hztvLziznPC+h+u70M+b8NRt
        1QvzaTT+oNyPItMZfZCrQQFj0Q==
X-Google-Smtp-Source: AGHT+IHX6L/aLX9NNOcwqRVmh9iizTWqDKSZdokhOeYvlGzRhloHgIdhhspGR9BXHTu8NSRDETlQuw==
X-Received: by 2002:a17:903:120b:b0:1bf:2e5c:7367 with SMTP id l11-20020a170903120b00b001bf2e5c7367mr28527771plh.42.1697137417668;
        Thu, 12 Oct 2023 12:03:37 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709026b0200b001c75627545csm2324737plk.135.2023.10.12.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 12:03:37 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:03:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] qed: replace uses of strncpy
Message-ID: <202310121203.0415E3B@keescook>
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012-strncpy-drivers-net-ethernet-qlogic-qed-qed_debug-c-v2-1-16d2c0162b80@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 06:35:41PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This patch eliminates three uses of strncpy():
> 
> Firstly, `dest` is expected to be NUL-terminated which is evident by the
> manual setting of a NUL-byte at size - 1. For this use specifically,
> strscpy() is a viable replacement due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> The next two cases should simply be memcpy() as the size of the src
> string is always 3 and the destination string just wants the first 3
> bytes changed.
> 
> To be clear, there are no buffer overread bugs in the current code as
> the sizes and offsets are carefully managed such that buffers are
> NUL-terminated. However, with these changes, the code is now more robust
> and less ambiguous (and hopefully easier to read).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, this looks good to me now. Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
