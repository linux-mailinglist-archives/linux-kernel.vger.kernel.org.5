Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086A678FFEF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346822AbjIAP3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345396AbjIAP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:29:32 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DE710CF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:29:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so37874461fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693582167; x=1694186967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5l3JwwWVrV2EjXXwh71SJgTd61hiM3tGe0OpAkkaoxA=;
        b=X4aeixMxw+Q/trooiy3NK322zQHLI2R0UoxTdtC1g1TIe7MP7ccZC3fNwgNCkEAo2r
         jx7LC6UQKndGLV9oii/BDYrbpwqL3Kn8MGQ/BwtQjJbdnRPfBdPnPYs0eGQCz/5DClt6
         ySoGaa6EGUaxrm5f9JdV8tZ+qnqlTKOW8pQRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693582167; x=1694186967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l3JwwWVrV2EjXXwh71SJgTd61hiM3tGe0OpAkkaoxA=;
        b=ZEWQmInU8lN+h5B8BktuGsgvxdE5wHPUCBiLz65E12eJ7Bmr08PCO6rvSSHW338lEH
         P2TdRfjBfJ0h0wGzfa+Ii5c5yye1ptZtfWF6MakuPTl1VwHZlQ3JZjBXFgpbQFgWKJVA
         2neAwxvcOP/0g+HYJ+nubCVlnWQfcIN3K4CY+K6QFAPG+QSwm10TSPpW+0IFyXqg0Ots
         6wNIh2W3AE7cYkbZv5N6ni5SsktrVm84oNfZUhTQxQ+eAkpAmRbRrhVkl+cYu79G/pX2
         16GMCV7OKycbIZi1eBTyjLMRClQTOUZTWOruKTU8tcjRzfymdpQZUHQwKPip1EOko3Ae
         F0Uw==
X-Gm-Message-State: AOJu0YyVmHs16tsqdw+K6GO9PvXf5KDokGj4BwB0axOu1JAwILzjP1My
        wFNEG2lQqjDXnU2WDAJXuHYdPnRDoqrDLqd9vrLxNbgE
X-Google-Smtp-Source: AGHT+IHd5LYZSvvq4wW0QmBQcjnJMfCN1dqtABjQmQO6cSnpX9rdUI8qifJGg7aI3i8s+SjbyRD43g==
X-Received: by 2002:a2e:90d4:0:b0:2bc:eaec:e23f with SMTP id o20-20020a2e90d4000000b002bceaece23fmr2185752ljg.43.1693582166633;
        Fri, 01 Sep 2023 08:29:26 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id n18-20020a170906119200b009a219ecbaf1sm2088722eja.85.2023.09.01.08.29.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 08:29:26 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9a6190af24aso126441266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 08:29:26 -0700 (PDT)
X-Received: by 2002:a17:906:519d:b0:9a2:96d2:b1e8 with SMTP id
 y29-20020a170906519d00b009a296d2b1e8mr2255791ejk.54.1693582165864; Fri, 01
 Sep 2023 08:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
In-Reply-To: <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Sep 2023 08:29:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7MDktwhh9FPFRTEQOLEgFxNcNhm+znsMevSyY1+aLyw@mail.gmail.com>
Message-ID: <CAHk-=wg7MDktwhh9FPFRTEQOLEgFxNcNhm+znsMevSyY1+aLyw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Sept 2023 at 08:20, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> cp_new_stat and the counterpart for statx can dodge this rep mov by
> filling user memory directly.

Yeah, they could be made to use the "unsafe_put_user()" machinery
these days, and we could go back to the good old days of avoiding the
extra temp buffer.

> I'm going to patch this, but first I want to address the bigger
> problem of glibc implementing fstat as newfstatat, demolishing perf of
> that op. In their defense currently they have no choice as this is the
> only exporter of the "new" struct stat. I'll be sending a long email
> to fsdevel soon(tm) with a proposed fix.

I wouldn't mind re-instating the "copy directly to user space rather
than go through a temporary buffer", for the stat family of functions,
so please do..

> So I was wondering if rep movsq is any worse than ERMS'ed rep movsb
> when there is no tail to handle and the buffer is aligned to a page,
> or more to the point if clear_page gets any benefit for going with
> movsb.

Hard to tell. 'movsq' is *historically* better, and likely on all
current microarchitectures.

But 'movsb' is actually in many ways easier for the CPU to optimize,
because there's no question of the sub-chunking if anything is not
aligned just rught.

             Linus
