Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB6B7EAB51
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjKNIGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKNIGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:06:41 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834B71A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:06:38 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7ba0d338367so2151635241.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699949197; x=1700553997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LGBUC9KsVeG0zIgCHu5xE4QSpLiIpSfaSXOL0b9rF8=;
        b=IiRdUCYQbFjr9/sDs8KQqqCO7B89W/F35GafT+ceeahygeU2k1rtibLo8VFlGItvza
         7WPGYcsLL7FFCGNuYbgD+0QgJRNC8hsR6zqym+9nISZPW+W1rhAvaoM5k4fyNEsx8KUl
         nG8TeEfzmnbSg1J4j7GOP8+39QCf57Fqe4qhX9iSJrNwXqjrRuzJ5BUGn3wW2CkmEwY6
         09WASEZQG6qam3P+ZxY8JeBRIFP/stwyMrPG1Fuu8xeuSoo/3dORugqFgPBBrbdBLU0r
         0UFwRtMkjCHOzGMGzg2W+WdeAw2vljA06mOuL2PJvD+aeftZ3JTu/UKFbyOr4qWwSWvF
         mfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949197; x=1700553997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LGBUC9KsVeG0zIgCHu5xE4QSpLiIpSfaSXOL0b9rF8=;
        b=tCR74QXASXeEndaCwaEUonmbNMgU7w7TFvnHlIO6xyd7uqoSZxvxx/4lBfAQdyIKDp
         Ar08LJZn/UIYKHJx4EkSpdv182P1S8tSbevMCTz4o/vK+CYwbXcS49LM5KsZUZzHv/cg
         JlVSHiBY9GBT+aH2PKM663aLbpDce51VldLZ46zw2X4dW77NyQhaM1NCjVpMMrown/xN
         7/aQnKB5oZIdddUJjTVIzukEcRUaTMH+FHzB3dF8YI1fenZnn/vfRRrVNH9RYQGjrgO1
         GZDre7mSDuV/aZqEm7vUDDqEPZKtK+FCKf/CO2OXyaWADTQCx0mnktMyWLtqhNQp07wH
         QImQ==
X-Gm-Message-State: AOJu0YwvBlYytngx7ezCAt6InU0U+IPaF61IvDIlyX9n7Nvo1LPHKNOI
        0XMAnjm69nvY4EPoHs3fIpYbxO21FS35uLc1HlVoNg==
X-Google-Smtp-Source: AGHT+IHRIIJ2otFiB28Ipx0WgE1WaXBMqJrx1/oRb4fjPk7Cj1iPewjxrE+pVnHo7BMp6gIpNsFRoZRKbs2enis0SEY=
X-Received: by 2002:a05:6102:474e:b0:452:6178:642c with SMTP id
 ej14-20020a056102474e00b004526178642cmr8315473vsb.1.1699949197540; Tue, 14
 Nov 2023 00:06:37 -0800 (PST)
MIME-Version: 1.0
References: <20231113191340.17482-22-vbabka@suse.cz> <20231113191340.17482-30-vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-30-vbabka@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Nov 2023 09:06:01 +0100
Message-ID: <CANpmjNNkojcku+2-Lh=LX=_TXq3+x0M0twYQG2dBWA0Aeqr=Xw@mail.gmail.com>
Subject: Re: [PATCH 08/20] mm/slab: remove mm/slab.c and slab_def.h
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, Mark Hemment <markhe@nextd.demon.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Remove the SLAB implementation. Update CREDITS (also sort the SLOB entry
> properly).
>
> RIP SLAB allocator (1996 - 2024)
>
> Cc: Mark Hemment <markhe@nextd.demon.co.uk>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  CREDITS                  |   12 +-
>  include/linux/slab_def.h |  124 --
>  mm/slab.c                | 4026 --------------------------------------

There are still some references to it left (git grep mm/slab.c). It
breaks documentation in Documentation/core-api/mm-api.rst
