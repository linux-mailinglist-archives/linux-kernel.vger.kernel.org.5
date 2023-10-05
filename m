Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E4D7B9DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjJEN4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243823AbjJENt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:49:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04529469B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 21:57:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-694ed847889so456949b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 21:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696481859; x=1697086659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ou7qEyDSpNR2vhTsDc3jo4hVQ4chmkItyDd1XYYoY9o=;
        b=Bx4pv63uBmHtJMi9oE7YWaAe2LXWmUYg4hXLP5NhaWdj+DpaNDFshrBE+s72WBckAj
         byXbNKSpj+Axb8bLarJOhD/hyj8vyv1pLDQdaf1RQSBY8FMMSOA/Vr4OlhsB1vDF25em
         FdgpcND3QzuUpV5mJEOnw4yNRmLgwIkCJomzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696481859; x=1697086659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou7qEyDSpNR2vhTsDc3jo4hVQ4chmkItyDd1XYYoY9o=;
        b=w4Zn0LYn3raE9s1l+zvhdaV/exe65oRhVXjNlfTXMX2nsWX+jGuTJUhg44pSZmmI+7
         oEdVmC+sI18UZ+LYb/abIj7pTfWfulBKexuzLnJcfWdlejKcJO7rBIYwLtij4IcnuwNa
         VnrKn3+IKO46o8mNuFLoAVhWUTeL7J8LLlpKpQXP+QSmThxKZeuWSXi1zn4gQiUbXdBn
         UvY57fSBcgoUxhU+GTXzkRr2zvWwlhlo6xAopWNVxfUfBTcTwmYVC4gaQ9J2rTSHMRa7
         aP6MW42gx4Dt1Qex+LEYfkG+UsA9i/OqfynGak1d7Oyf+E+ZIp/4OHFYUDNaQA3B0yQf
         eKQg==
X-Gm-Message-State: AOJu0YxN6sDryg438nJjckYmuDlin+qFegBzpz89N8eOhabu0+U49cd1
        05IvOz8cY8F8jby5j8nD37bQ/g==
X-Google-Smtp-Source: AGHT+IHfFzAk3jZc8/kmyYED56n0qFpH0frjgyDXlmQrCoyoXKErciD3RmqNnW4gsjvX/+xSlxs3fA==
X-Received: by 2002:a05:6a20:8e05:b0:154:bfaf:a710 with SMTP id y5-20020a056a208e0500b00154bfafa710mr4952481pzj.41.1696481859488;
        Wed, 04 Oct 2023 21:57:39 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bu3-20020a632943000000b005657495b03bsm435576pgb.38.2023.10.04.21.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 21:57:38 -0700 (PDT)
Date:   Wed, 4 Oct 2023 21:57:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: atheros: replace deprecated strncpy with strscpy
Message-ID: <202310042157.D314C6D7EF@keescook>
References: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-atheros-atlx-atl2-c-v1-1-493f113ebfc7@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 01:29:45AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect netdev->name to be NUL-terminated based on its use with format
> strings and dev_info():
> |     dev_info(&adapter->pdev->dev,
> |             "%s link is up %d Mbps %s\n",
> |             netdev->name, adapter->link_speed,
> |             adapter->link_duplex == FULL_DUPLEX ?
> |             "full duplex" : "half duplex");
> 
> Furthermore, NUL-padding is not required as netdev is already
> zero-initialized through alloc_etherdev().
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Looks right; destination length correctly updated.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
