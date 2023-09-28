Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856F07B11DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 06:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjI1E6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 00:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjI1E6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 00:58:33 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B48F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:58:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso93671115e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695877110; x=1696481910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xGs/aA9aOh5XsFAEpc2ofFBAtNcAT8wgme2oNok1KUc=;
        b=QOOKyWC3dh/7siPX5DKwnDATYdX9lZjUFXqHQu6TTNNWoNzTegSWBsXHn43jT2Q82r
         qUerBoh/bbBL1qO9a3zEe1mZUndKCy5nHZFTtt6P+HWMgFPVn9E8yA3wiN/ivEpzfPpV
         U/LL/e8lprxOxgNxwLT1DF1rx4JPziHs9UKaS8aLVNvvbcr9Ietjwol+kjFNiw4xR30P
         x35lyJk3yIc3aJdIl8i8BKRXC+R6wBNjhjTQfmXdyc7mLmqL6a06bhDGZU2YSRXXxI0Z
         DwJc9xh8fwTsipn5GvE1W7hRsnbSOlTEUrqWZ9GfqS438ZoyKzkLy39OgAf86l3gPmFb
         vswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695877110; x=1696481910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGs/aA9aOh5XsFAEpc2ofFBAtNcAT8wgme2oNok1KUc=;
        b=UIN8wWnzI/ZMrE4wQcMR6Tqj+yjpSh8/B4yUTZGJBzTrQ0gUrMQYNaL4cMMTU4WDlY
         zkYbyDnsSQNU0AYmLj6zSKvaRVUu+ffuCWHtQEPpmLwDVqeYo9gLarbWSbxO8R3ZDy2T
         sFZ4pb3xgDSj0Kisz+Qz5tZ0kOx0NX2IFuqFz/OxAnqCXGt7jHaZ9Bg6GulpH51ZAyzf
         KLyFSRXf8B3doP1VvD6+PbIeXWEknP3op226u9iLvDBXdld4lIrhbCvmBTkDycwl69Yl
         0B0ztG/l6VpnN0QK2BWYuHw5RY073Mmd25VybelK2jjI2jWrKEod/pnVQrbyE53nNliZ
         jbRQ==
X-Gm-Message-State: AOJu0Yzoex9bEBF9OoMcQ+xzj1CqjodNrl/Or+u9MpoS/oiEH6pkwtYJ
        AMofOQMihieEoaABfluS/Jq3vfJF+K85A2onXSI=
X-Google-Smtp-Source: AGHT+IG0Cv1pjWH7ZQwQVEN+3+R9m7dfeHRMc2ejLD4pjtTlo4Pni2aZ7HIRQilezMRQ3XpTvgYUpA==
X-Received: by 2002:a7b:c858:0:b0:405:40c6:2ba4 with SMTP id c24-20020a7bc858000000b0040540c62ba4mr159135wml.5.1695877109938;
        Wed, 27 Sep 2023 21:58:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm19278473wmo.40.2023.09.27.21.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 21:58:29 -0700 (PDT)
Date:   Thu, 28 Sep 2023 07:58:27 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: ieee80211: renamed duplicate
 variable
Message-ID: <469feda7-80db-4f22-8396-1eb10d07567b@kadam.mountain>
References: <20230928033220.31783-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928033220.31783-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:32:20PM -0400, Gary Rookard wrote:
> This patch renames a duplicate variable found in both rtl8192e and
> rtl8192u causing the preprocesser/compiler to compile without error
> when in fact it should throw an error/break the build.
> 
> Prototype in files:
> rtl8192e/rtllib.h      remaining as ht_update_default_setting
> rtl8192u/ieee80211/ieee80211.h   changed to __ht_update_default_setting
> 
> Function in files:
> rtl8192e/rtl819x_HTProc.c remaining as ht_update_default_setting
> rtl8192u/ieee80211/rtl819x_HTProc.c  changed to __ht_update_default_setting
> 
> Referenced in files:
> staging/rtl8192e/rtllib_module.c  remaining as ht_update_default_setting
> staging/rtl8192u/ieee80211_module.c changed to __ht_update_default_setting
> 
> Linux Kernel Coding Style "cleanup", no change in runtime,
> staging/rtl8192e and rtl8192u compile/build before and after.
> 
> Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
> ---

This doesn't apply, and there is no Fixes tag to suggest when these bugs
were introduced.

regards,
dan carpenter

