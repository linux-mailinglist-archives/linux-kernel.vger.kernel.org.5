Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129117A2775
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjIOTxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjIOTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:53:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF1B1738
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:53:22 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fdd5c1bbbso1850792b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807602; x=1695412402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CERIXMszobECCcmTb35olIeJedTz3jO0YWogNpKALzc=;
        b=k0XG+2aoqM+iN/MfW6LcKsFc1Iofq/lBwx3qPRLKj8qZ8eedBy5PZVuts7KdPhew/3
         nfPin5P6gPOoLJD3dJKjeumHylWN1FRu+2mfI4nQ3ceYLUrI1W9UiY3+d7DJpxFzgBOz
         mo94Et0y6Kj/mnHO6zc/aMTjM/um9IBEvOK3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807602; x=1695412402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CERIXMszobECCcmTb35olIeJedTz3jO0YWogNpKALzc=;
        b=RWvyaRAqV4/4iI/BWMLi9i5lMxpgC76f27U5Yync5Sv0BE5fSZsUCpGu9z5pMXmDil
         wEjpOJmsN3htkKDNQZC4F3mzK3Wz4f4tDOckVKxdz0+X59A6gWboFL9n4hC/avH/1If1
         2Yd6utKdY0QW0DHcoJWVRzAsQpXmclGPnZa21InLnvTO2mYrLZazWnCTavfmtaxIEEzF
         378dbDeqfPsnC/grY1VpBCdNMm0Vzg6WjpaceTtwPsaTcV5FJnlBLVF1py2oM73EM+VK
         P34Iq+Z3pMjA2thSlt0TBAgMTO7CX3XwqeHPb0cQFyIE1+o924dfuaV7OsNrBKqV9YfI
         FX0g==
X-Gm-Message-State: AOJu0YwJ12HauUoimf80IVHGP/3kQ1YgHgKxiQOz8YjzLdZaj18qtMzr
        lp5SqXWHtsGFrn7fDlBdU4jh1Q==
X-Google-Smtp-Source: AGHT+IEPvKFh8vTTzZWluYNsudPUjGFO4rE/xMIMo+tGYyEr5KiifbvSDLT3mH3As6hXoBlLo3SNkA==
X-Received: by 2002:a05:6a00:1a11:b0:68e:2c2a:5172 with SMTP id g17-20020a056a001a1100b0068e2c2a5172mr3314996pfv.6.1694807601720;
        Fri, 15 Sep 2023 12:53:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78551000000b006878cc942f1sm3307731pfn.54.2023.09.15.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:53:21 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:53:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Geoff Levand <geoff@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: spider_net: Use size_add() in call to
 struct_size()
Message-ID: <202309151253.844C8BFCA3@keescook>
References: <ZQSvsLmJrDsKtLCa@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSvsLmJrDsKtLCa@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 01:25:36PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
