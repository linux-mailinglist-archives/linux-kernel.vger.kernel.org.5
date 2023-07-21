Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB5775BE28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGUGCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGUGBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:01:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0003AA7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:01:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143b88faebso1330573f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689919271; x=1690524071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6wPB1oqvrAfuXOneG/koIMJSYYKGh/zyRvxTmEarSg=;
        b=DCr++gWHC6M1cwUmnINttDgQuZ24bhZRNUevKMh3vglrWRTmThcHbIUvBFCYo8B5Tu
         zq75gKuJfjsWV7u4e3hxgfZ8nOje54X3L+kDUaqm3guQ65ssq9aywj6yNlZNQ7QJqs9w
         oNE0VhpyUmIwo34MI3/g2LJVCNi42bdT0U8Ku0edXOeaC+pjEd//MiEjiFE15/bc4SJG
         6Jf/U1UpFvmaIzLoMCqhbGXQtSnLT9sgg8/AESXF0et2iE+Svqp1XBHjs0YnX55aGqf5
         KArnos3pXvOxMVLbbFuIrGtFRwR23faYBxlQw83fO/8c6DwtnM0Wsh2KkeyF7oyQsp08
         8NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689919271; x=1690524071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6wPB1oqvrAfuXOneG/koIMJSYYKGh/zyRvxTmEarSg=;
        b=Ddt5U7oKmqu+IGwjDKfA18QT838lG5wLSu+ZlgMeLcWRpMvx0VmL5AMrg8NjKrElWn
         7i6+ldiV9TCN+GxBa9fArJghmxYElkUKlmLHsQTJSuJbgHyNzkTyj5MJLoeLftKK/lj6
         01dj4W70aaTJn+mPan2w0h1XIc9XhKii1q/ME8ac0q6eqB8jdJsXeFCZs9KN14bd3LJS
         BQ3bHOP0WVsrz+cE2SljgzVEsYeA5mPU5BiAVx1RYzHyAWajR4eDweY+6Cmm64GrKzpj
         fRCRHDxTz20HbA8wVR1IKpO1RnSqnpKNimb5cDT9wFerejCwl4n+uANfndlwjLxwuCk8
         PRlQ==
X-Gm-Message-State: ABy/qLZSyeDIIlwBS4D5Sth6yrlQITVG5ILI4XVZqMHi7MCKNOM2jH7C
        SElAqOiYCSyeOQTyO1bihXYKL1GBKvbC35y3w4w=
X-Google-Smtp-Source: APBJJlFqofJ/Db9+U8m0UpVwQZ8mS94VziVkNs8TI5/dr6nC0QbHrBQHPN0UMAsb15PuBYUNTX1Sjw==
X-Received: by 2002:adf:ef0f:0:b0:314:6252:d4a8 with SMTP id e15-20020adfef0f000000b003146252d4a8mr663757wro.43.1689919271320;
        Thu, 20 Jul 2023 23:01:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d6584000000b002c70ce264bfsm3187978wru.76.2023.07.20.23.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 23:01:09 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:01:06 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Sergey Rozhnov <rozhnov.sergey.89@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Remove redundant braces in if
 statements
Message-ID: <5db3658a-2594-45db-b76a-4aa40950ebd5@kadam.mountain>
References: <ZLnoBYlsTiLixTah@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLnoBYlsTiLixTah@terra>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:05:57AM +0400, Sergey Rozhnov wrote:
> Extract masked value to improve readability, apply fix suggested by checkpatch.
> ---

I like the new format, but you need to run checkpatch on your patches.

regards,
dan carpenter

