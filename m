Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCE47BD71A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345742AbjJIJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345449AbjJIJdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:33:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C794
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:33:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-65d0da28fa8so26801956d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696843982; x=1697448782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc2DaCMixY7eiqSJldB8Emg0r+LnGTFB1CXp+Shw46Y=;
        b=ZkUHVoP25SnWGu2A1PrgyFt7gg2cP9COV67toW1tUQFnmBga2xUMY8Kinxu2vUR54Z
         Jzjvpvd0sCuqwHzERslJAxIi1p0HWNBwfcP4gGW3qIFYr8eOc6Du0FAQ/pfpHRRg7w4s
         IHD9Knm+JY8oStciKoVM0Zm+1XXFdSdKoAUPVmAnLHSKWMTt9j0nYMgI6FUOAbHmEiay
         PW460qcNvCNwUB2qcnOPqHFGke0LawuSy2pDim645CRg1XBiOTkCmXPYGkX0f+HE1FHj
         bZv56K0nfo94hjLt40oK68nckQj4UWxvflIO6hSU+Vazjz5bOq6OtCXEwlZgQgx3qCIX
         L7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696843982; x=1697448782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc2DaCMixY7eiqSJldB8Emg0r+LnGTFB1CXp+Shw46Y=;
        b=FM8idtfm0CuCsLIfiGXYyK81eUHNGB/fu7thH8u7J0re5SeFj3Xfm0TQyCpv3/BNVK
         qAy+nyaGQaR9EMd0YqSiZoFv1aPHBptsVZvAxrrTNKSWaax7+sBQ5B46bobHx9ezQcmM
         +MlrUMN6tpI/p2HMNlhm2hmMVGE32E5iksDv+5/SWJG2rc/mrqbjbLqtJfQV+EMoIuty
         9bkqlnC73wRb+vhhaqjBgrcMDMVIw+QtwtsyDDNgWWciMiJbNqYsbtHTqoVYb6/ra7VH
         +uPcXHTJ8MZY1Gu0yOoJU7U9v9skI1r0wC0ON3e1HTHwSYRkqaHIub08sTfJitymUZ5l
         7QOA==
X-Gm-Message-State: AOJu0YyBQnOgLbkenZ1i65pZG8vuGmhVkIrElhKEZ0+6OG/0vfGcRdcj
        yb0n+ZPljExTkuQv72GHpvRh6o8OQJ7mqvKoO2MwlQ==
X-Google-Smtp-Source: AGHT+IGYFEkoEFx5fSqinLsYfBdsayGsUjjYWAQ6NOBZFbc+HFaPsPz8uTFTw6ue3oWdQPjKZvNq1SIT4gjNqrY4rJM=
X-Received: by 2002:a0c:8f0a:0:b0:656:3352:832f with SMTP id
 z10-20020a0c8f0a000000b006563352832fmr14547557qvd.32.1696843981887; Mon, 09
 Oct 2023 02:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <b70a6d84c438ae20105ff608cd138aef5cf157e6.1694625260.git.andreyknvl@google.com>
In-Reply-To: <b70a6d84c438ae20105ff608cd138aef5cf157e6.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 11:32:21 +0200
Message-ID: <CAG_fn=V13PRuq873BgkfP9oSd=_0VAeyxNJtbpZOzQvQNxCEQg@mail.gmail.com>
Subject: Re: [PATCH v2 10/19] lib/stackdepot: store free stack records in a freelist
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 7:15=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Instead of using the global pool_offset variable to find a free slot
> when storing a new stack record, mainlain a freelist of free slots
> within the allocated stack pools.
>
> A global next_stack variable is used as the head of the freelist, and
> the next field in the stack_record struct is reused as freelist link
> (when the record is not in the freelist, this field is used as a link
> in the hash table).
>
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
