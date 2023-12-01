Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5973C80182C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441931AbjLAXys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAXyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:54:46 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75771196
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:54:52 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4b2899dcb2fso909689e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474891; x=1702079691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pol7hI1Hy96E33miCesPUidUjW/JKgnpIaa4LePlFSs=;
        b=cHNbxQH58fP/SljUhRwXB5T7I0grZWfdt3leYdcSrhUDIuOEmwkUY4Jylj3HazbfNC
         1bY23dJMdKyVvj1J0UCM34FzGGZswVcE6IkaVix/N6gHz4bOC7lQ/h1AZbcfNVEMvLma
         wzeodblYt0ENFV6PiJW9wYAnRALmcrJV23FFWH/qQNM9neS+b8DGLtK+3iJ1NivsrVgN
         IjnqMdRZA5WYghTKR/hzs1sXSH6eeQele6KmQq80jzEr1Jf4VRNBX0BmhpPtp5waLW1s
         b/AKaAaExWgN300EjUmpE8Mxtr4XXxJicGfgZQbKeKEPf4hbSSjAw5dlUwz+yN1P+H8v
         gkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474891; x=1702079691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pol7hI1Hy96E33miCesPUidUjW/JKgnpIaa4LePlFSs=;
        b=irbo1KS+OaMe3W6Vi27oankzerNHu6EeWcpfcNe+TxiSTM0XQDIJY91XGMV4EAYPAM
         XYnOZXi4E3d0LcN6ApVbtcxSVWkPzsWcRHQSdTc9tTHwbeV0Ncy79akOkPe17b6BLhUX
         YuGjcVGChujGYrmNkIJNlw0HNbpOggU/+DYNRtFQVPQ2TbSRo75/oeGizuWsN6/kCqS7
         hCWn6roXowDOdFeY3LAsGCTwqBBwEIMg78rNx5A0ID/4yaBvA0/YpkOuXxpV12KQDuQC
         xz2QymBLP63N3t9Jjo/iHqQrkrWJ8BIt8IioZk2X0BsOEIk9sMwiXRNNcvzfeH6UuAMn
         pU5w==
X-Gm-Message-State: AOJu0YywA3ZkKFS2rncJaBBKNvWGXllSU+jeQ1sethuh1qMc0Kcju5NT
        ejqaIDQwC6xyEFKtGez30VBeuIsSmTQ7fIQmvzkc8Q==
X-Google-Smtp-Source: AGHT+IFhYdGfLbE8mSyQJ9sVITWjwja5raT5mVt0aQs6YqvlVg9Hcm3bf9FfCdJYLNUrv209BolhENIl06CXXpMM8rM=
X-Received: by 2002:a05:6122:319f:b0:4b2:c555:383 with SMTP id
 ch31-20020a056122319f00b004b2c5550383mr302268vkb.25.1701474891180; Fri, 01
 Dec 2023 15:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20231120144642.591358648@infradead.org> <20231120154948.708762225@infradead.org>
 <20231122021817.ggym3biyfeksiplo@macbook-pro-49.dhcp.thefacebook.com> <20231122111517.GR8262@noisy.programming.kicks-ass.net>
In-Reply-To: <20231122111517.GR8262@noisy.programming.kicks-ass.net>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Dec 2023 15:54:13 -0800
Message-ID: <CABCJKufBiJjUdmnuy=HkV+dDnZ=xne-OBwPSfJ21RX9c0AzCZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/cfi,bpf: Fix BPF JIT call
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        keescook@chromium.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        jpoimboe@kernel.org, joao@overdrivepizza.com, mark.rutland@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 3:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> So the kCFI thing is 'new' but readily inspected by objdump or godbolt:
>
>   https://godbolt.org/z/sGe18z3ca
>
> (@Sami, that .Ltmp15 thing, I don't see that in the kernel, what
> compiler flag makes that go away?)

Hmm, that looks like that's what we emit to .kcfi_traps. I suppose
Godbolt just doesn't show the section directives?

https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/X86/kcfi.l=
l#L30

Sami
