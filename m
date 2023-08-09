Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FAA776CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjHIXHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjHIXHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:07:47 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D545D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:07:46 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63fbfca1302so79366d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 16:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691622465; x=1692227265;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=li/9TOw1D/al0BgcWpvzxPhzRc7oZy+uOQFsKnuD0nc=;
        b=VsgR3qiNN+VuZuH58/kL0XOyT5r0+EUKZKvFDLAYBNNEL6QY5BLbea3/fsWoOrepON
         1J9WYmT/sxrpqc/g+FT8PiebEUrRrnHGrp5HBz/GKO87cFAQF+B02NHzQeWXFG9u37ic
         bygIceYeq8MxC5bqcJ3loTL94SEZUqMLVV+Y0ZrXh5J6sCKs1uQu+HjxBHPmWNXOStXj
         QQrMZAljeAubu5D4pxANJTbpKpFu/9UGCu0ImHNkd+mVXM0RJ2pukjD7lt/jfFElIyLb
         c+EcJTe3S10nGDaYLhbWEaNs/JCnsJU7OD67hscB8ClWezuccWHlmO72NMpgjL2SlCEN
         q4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622465; x=1692227265;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=li/9TOw1D/al0BgcWpvzxPhzRc7oZy+uOQFsKnuD0nc=;
        b=Xe1cXvpJlsoO1FO3forq4ang0VZd7i4PehMLO7tiP+P4ySkhezGzcbiQO/d2qF5iXM
         XDRvulgNUDIdqWOzRuPrdLfNd7gHo4E4rf8ZioAr/suAoi//E28qmqN3EV8i5ZCjS7Uw
         o5s912AnD24+irQQmySq+UIb2wvMhvBDRdOYFxUSwFDA93po8Zg7oHlCrW5gE1jiZQG0
         dhpLjrOonEq1IaeoHV+Ldl3qhvszYLlUU62qd14dGRSdsR6iCAsT9v4Kix4Wo5Yer8Bt
         oYX0l7soqG32Xzq5fREo32rzrlb98rYubrW8OofpyWsHkiKxPtdPIKDuGYP+ALcDITZq
         b8Ww==
X-Gm-Message-State: AOJu0YzWm1NaPZTq30lUr0i8zMlIGp86MbwUBwPfsYYo2BB74l07fBPr
        j5MwcJJHVvooPDqVh81It245
X-Google-Smtp-Source: AGHT+IHJIdx5ep6T3i7VbU2Ri4DPcNW01+EfvQ176cqLxGeLFkTzHtE8Qipt4tOk6Yj+5eS/iXXa6A==
X-Received: by 2002:a0c:f54d:0:b0:63c:d8b5:ee6d with SMTP id p13-20020a0cf54d000000b0063cd8b5ee6dmr582494qvm.33.1691622465178;
        Wed, 09 Aug 2023 16:07:45 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d14-20020a05620a166e00b0076c5ad6750fsm45819qko.102.2023.08.09.16.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:07:44 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:07:44 -0400
Message-ID: <651d3c359cdfd599482a94104c35ee05.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] selinux: avoid implicit conversions in selinuxfs  code
References: <20230807171143.208481-4-cgzones@googlemail.com>
In-Reply-To: <20230807171143.208481-4-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug  7, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use umode_t as parameter type for sel_make_inode(), which assigns the
> value to the member i_mode of struct inode.
> 
> Use identical and unsigned types for loop iterators.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v3:
>   - drop leftover declaration in init-clauses of for loops
>   - use unsigned int instead of u32 for loop iterator with loop bounds
>     known at compile time to be small (<100)
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/selinuxfs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
