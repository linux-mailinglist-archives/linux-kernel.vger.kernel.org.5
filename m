Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39C2758815
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjGRWCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjGRWCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 18:02:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7990210E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:32 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403ea0a50f7so20957141cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717691; x=1692309691;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iB17Jv7PgvBBPUCqrI904aat99RgLB9MM/LvaZNwOgk=;
        b=MYcK6JaYHAX0r3neYL0Kkn06nMaHO/DZdTsjDcFU5+/rIOVbP2RLLNOVKkNKcIId9k
         0F8OUwyTcZ9RVNrKw62Ckw5uW6OOC4xtqFFOkP5WTcr6P5jKDbj9z8NuLoRj+1LTTZbA
         vdDVdi8gBhZZ5io6cRq4WTX+telf2TWQBRxUN4axhhjryBAdW2eXv9Dx+4cJlewsHFYw
         8X9JNKA4yBk1GWSfR/s8aEyTYjAaNlxO31XVCzuS0Ssjr+B9m9rKFngAS5N9Ms3cvEYe
         VRa3GNPnolJoBP1E7AGE4WZB9OPKymYpwGneIWv+JnODGa67ks9gIAbQx/N6m7VVyhan
         YZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717691; x=1692309691;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB17Jv7PgvBBPUCqrI904aat99RgLB9MM/LvaZNwOgk=;
        b=FSHxyPH6DHqTKgQ4qSwCHxrzHYMcna3KE5hGw1npcf9A4PG9iAaVJyaLReDgMV8Vr+
         9dWk+MFFzGeeS/vY9bVb9EnYjIgUSRqFfeNtYsUEvdcqUiUjGNGg1IF2aIT/05LJJRpZ
         0Hqifv2IcyyxVvQxPt23+rIUxE3+2PvqETSI+oZi9LoHmfX9/RxQfsdpJfIsxxJBnqKV
         55D283DENTRuvtBqcAjICtOl5NVraEz8nKS+rRdfkmeDp2e5drzzIx1AJZG8nl/LJ5dI
         wXObP1tM/e1GvJFD5eFEQon/4Z6lwvmAZeZjq17VQwV9oktwuwDw8I8+foO0pOxWuQ7V
         l6fw==
X-Gm-Message-State: ABy/qLabpop0/9TpidXuVqbC5//or+XQl3Bi1PWte9I7SB8V684GUF23
        iH7HQQtGyvyC8wQFgrHNaSgEuuEb3vTC8v8cJQ==
X-Google-Smtp-Source: APBJJlESDXO0qHMTm9i0eA4VEKzte/GwD08DCTjWQ1XgIDusoRm5StlwTyCbsLFfK/MBtka1mTVPzA==
X-Received: by 2002:a05:622a:138d:b0:403:6fe6:3160 with SMTP id o13-20020a05622a138d00b004036fe63160mr19894246qtk.61.1689717691201;
        Tue, 18 Jul 2023 15:01:31 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bw15-20020a05622a098f00b00403fa130c60sm687317qtb.55.2023.07.18.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:30 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:30 -0400
Message-ID: <43e37428022b198986e232da34c65e26.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 20/20] selinux: selinuxfs: avoid implicit conversions
References: <20230706132337.15924-20-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-20-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use unsigned loop counters where the upper bound is of unsigned
> type.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/selinuxfs.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

More loop iterator declarations inside the loop, see my previous
comments.

--
paul-moore.com
