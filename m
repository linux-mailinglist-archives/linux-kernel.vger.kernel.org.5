Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE30C80F6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377113AbjLLTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376876AbjLLTaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:30:52 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97DEB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:30:58 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4b2c0ba26f1so3430745e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702409458; x=1703014258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JMbpC3BtNOe8bELQw2u1EoYqYVQ1htSh7I5QpYrW3xA=;
        b=pbYGhgul+UFqBfkDuPqrMbpHuoF9z/zOJcwGleQBmqO0WZpACoYJGPSNe3+O/rKtGR
         AqH3jswz7viMtusiuVL8eUQFGxISAfqauXtAUDV0qhtfNyy72rOy+sBqoaiYZN65Lzlr
         NewBU70kMGA/8SY3rXxs3o2fvu3wf6wFMNOEiXh89R0pmOx3YU6HREuZsl5n5tHmUzdq
         vd8pc6QOTHDB07o9cbc4ysnkwiEXssqiBY6aobofZuLZGw6OelcA9ximluCgdtq5EwSC
         1e7srkd6NbtqjWXf0mqoupJHAoZ8dl3dfWR9iIDExDcvfyNmhjUWa/UIXifhRm2xTOOU
         bKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702409458; x=1703014258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMbpC3BtNOe8bELQw2u1EoYqYVQ1htSh7I5QpYrW3xA=;
        b=FZfkNiR74HL0Wp9Icgzm0aba04JDLAI5Rm+N2DMOEdwHxKS4kNbKXafDc38/OQ237a
         Eg2AyLiv9FDuT4Peor0X8HHc4JxlHsdytEvGLRZxJIBEXAL4nwq/w79mDKWyo7AFDG/b
         7Dv/9+vjAkad9Y6wz/7OGgqy0duvyGRY9bg+FHxU++1kjbkpv4JMRpjJETNBL00gGtxE
         UWTzgle6vyWN4nWLqpIcigNajpr5RtvshAYE58/k7Aeo5/qn+pi9myV+siwK8vzU8CUh
         iN8Olm3eL9mwZ6OluXzoU/QCxF59JFA206+5zYFMK42bZVQR+LIRbYd+5BCg6QzF8+TK
         ICQg==
X-Gm-Message-State: AOJu0YwM3Qw56ImnNCxRQuQBVmDresqNixajLOXRpr4B3PSmjbWjihEK
        yi1vmZvggrGJkdtnwL2YFLY6e6vrBgefGW73GcvO7g==
X-Google-Smtp-Source: AGHT+IHf7d5CcXr/TVP+L1FlIZ9Fn4F/zutgCp4SJT3RGnoULvaqlFqvgNWjwKLM+X2MXAweCfM9gtIbt64Q6lyq69U=
X-Received: by 2002:a05:6122:c9f:b0:4b2:c554:cd04 with SMTP id
 ba31-20020a0561220c9f00b004b2c554cd04mr5816814vkb.16.1702409457619; Tue, 12
 Dec 2023 11:30:57 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <c8bf7352aca695ea9752792412af9ee66dc2ca17.1702339432.git.andreyknvl@google.com>
In-Reply-To: <c8bf7352aca695ea9752792412af9ee66dc2ca17.1702339432.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 12 Dec 2023 20:30:21 +0100
Message-ID: <CANpmjNOkMM4BLEsNWAwduCFCbUFrnW8eOb1gA-j9RLNO+eh4Fw@mail.gmail.com>
Subject: Re: [PATCH mm 4/4] lib/stackdepot: fix comment in include/linux/stackdepot.h
To:     andrey.konovalov@linux.dev
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 at 01:14, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> As stack traces can now be evicted from the stack depot, remove the
> comment saying that they are never removed.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>
> Can be squashed into "lib/stackdepot: allow users to evict stack traces"
> or left standalone.
> ---
>  include/linux/stackdepot.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index a6796f178913..adcbb8f23600 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -11,8 +11,6 @@
>   * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
>   * stack traces often repeat, using stack depot allows to save about 100x space.
>   *
> - * Stack traces are never removed from the stack depot.
> - *
>   * Author: Alexander Potapenko <glider@google.com>
>   * Copyright (C) 2016 Google, Inc.
>   *
> --
> 2.25.1
>
