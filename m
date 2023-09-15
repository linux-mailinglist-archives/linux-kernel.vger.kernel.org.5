Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9BE7A147A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIODif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIODid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:38:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF074270E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:38:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc0d39b52cso14578515ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749108; x=1695353908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9bsEeGJhGQLCD2Cb52vXww1fF+hyPOxNnrIsUJnCkg=;
        b=R0IL86eVQXwSGyu12W5/gdVhaQEJu4JIoV70x5Gd6s8N/v+rj9abipjn8LNivzKdQa
         l1S7iGcVKRnRj1ogL/q/YW7NdK77ExM8uX2E1gw6ZekIAXp3smaVgjZqaaK5JTj/AlHJ
         BJnyM2Y94lJdntH938iQ9uF92bUxHhgiHi4qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749108; x=1695353908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9bsEeGJhGQLCD2Cb52vXww1fF+hyPOxNnrIsUJnCkg=;
        b=rYkg0ciNKqC9eXfhD62oGF2GCwVs5+ZxH4Icna4AMZQqaybPQwQnga+T6gSrf6u9Zx
         j5YN40F9zXZL1k1kZjiZeKX6ozFD+cYUE9apVXJ/B1kWtiVF46eHRWQYPYN8Y42nenYz
         hpPuy6w+zc4wDaQORCuApthye5UhCp5cKgvYUddaxoc7QOJCYZoNqKVCja/n1NF86XnG
         jWeE4ZjjKa5jNtGJzziBJIA339iybADItqcFmw5GHtSUDe4w/H/6uRsdjd5W+8eux/DC
         iBMS50nXO7rrF8vpuJdxMR6kFwfZ6cYXZxScrfySvJKXmpU+RDtUODIE9qMkfJY8aDc7
         /HaA==
X-Gm-Message-State: AOJu0Yzh5G8QRHn1mSHJ4kBzBGVxTo1V0DxUSXHa5y7NxF8DsQN8/ezI
        8v26t0CCNTducWAnizxuNBzgWQ==
X-Google-Smtp-Source: AGHT+IERNqEJym7j7zmwKFthi95ngAK1oA/fJ85WrRMxD/dztnczJ8CSvvkTC2fIU+1XhUu9RNqxrA==
X-Received: by 2002:a17:902:cec4:b0:1c4:21f3:4be9 with SMTP id d4-20020a170902cec400b001c421f34be9mr471656plg.62.1694749108396;
        Thu, 14 Sep 2023 20:38:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b001b890b3bbb1sm2332311plt.211.2023.09.14.20.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:38:27 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:38:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium/nitrox - refactor deprecated strncpy
Message-ID: <202309142038.696D180@keescook>
References: <20230913-strncpy-drivers-crypto-cavium-nitrox-nitrox_hal-c-v1-1-937411a7bc7d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-crypto-cavium-nitrox-nitrox_hal-c-v1-1-937411a7bc7d@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:32:31AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We know `hw.partname` is supposed to be NUL-terminated by its later use with seq_printf:
> | nitrox_debugfs.c +25
> |      seq_printf(s, "  Part Name: %s\n", ndev->hw.partname);
> 
> Let's prefer a more robust and less ambiguous string interface.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
