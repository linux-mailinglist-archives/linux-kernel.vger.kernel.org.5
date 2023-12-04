Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C83803E39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjLDTSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:18:34 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A030DE6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:18:40 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d880219f01so786010a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701717520; x=1702322320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWNzZv699g9WmaMge8Xt2XGWr8M2fBvBoGU1E608xn8=;
        b=ogvbZv288l9hOeOHP58Zsi8eOI/g8vnxaXwHTjoqELNgUGTZgezgFk8KTjOp/RoZmW
         BUgwfSSHi+95sYPbKRxXNe3SBZHlJV5b8I4OyPrFAII4FClPXkyvp+sucAIs5ATbMw1p
         m1iQJ/9Pl1KNn6Ye0XjtCFzhIKMLx6f5mF5bwrFR9dyEgPoq82kZzZiDmGuFFu/pOn2o
         A+PcH7g7LKPt8qT+J2SAOxG5++6Iut2Fbt7iV71mBD2pOt2p3XqPEeexJiFraWg1/Wz7
         bvsRLwqVld+vT2Z7FUQQlIFANn00FnRQ+2td9V1obTI2aXDM9boRIyJoNZGEaW3qlf7W
         WrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717520; x=1702322320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWNzZv699g9WmaMge8Xt2XGWr8M2fBvBoGU1E608xn8=;
        b=Os419G1ar6IuyfS+Vm6Ovsv7xWK1ZXRs7m+boq5Mt8n/ia8aQ+L0eB+VfoQln3zAN4
         TPkc/Gskmne47eITlACX/htZ/QdljVD26rIn9NfQULmRO3w7pEekettveigDLzfRYcn+
         PlapsRLWHs3pWPVIXFKq661RyIYN8zDphXQW19thpQRkQfpwfGL5/O3IUa/EfYNvY6td
         qH1KXdIZd+PhUrrCUR3hXMS264liqfEZP4zIjeqBCF/+4YB1fM8qH+2vAvHPzHlpCt2E
         Jnst5opDCNfqL/zzVs7r3TSgUqrpcoUGNA/e2F+jZhUB73dd2pk5P25Fw8QdTSfyCGUC
         cldw==
X-Gm-Message-State: AOJu0YxV2ByHcMTzZAGA89Yz2b/+XRRvsX0CeQ2sWzKUIGXRNOOBiyjy
        fSdiAus9ZRQscSrcH6OLtZOXJO0leEFS9Q1dxWkCvA==
X-Google-Smtp-Source: AGHT+IHyqGlUNEc09zfk+7C7spFR2KrAlLytNjHQMZMVaTcBh0jkMo0aAva0Taxeji7L30FkvzDde4ybRx0p4piiiZw=
X-Received: by 2002:a9d:4d02:0:b0:6d8:75a8:8455 with SMTP id
 n2-20020a9d4d02000000b006d875a88455mr2668679otf.50.1701717519644; Mon, 04 Dec
 2023 11:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20231130133630.192490507@infradead.org> <20231130134204.026354676@infradead.org>
In-Reply-To: <20231130134204.026354676@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Dec 2023 11:18:03 -0800
Message-ID: <CABCJKufv1z0-+an7iws8J2v-c_Jg1Nfu47Um9rhCnVLxQfC6ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] cfi: Flip headers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 5:43=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Normal include order is that linux/foo.h should include asm/foo.h, CFI ha=
s it
> the wrong way around.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/riscv/include/asm/cfi.h |    3 ++-
>  arch/riscv/kernel/cfi.c      |    2 +-
>  arch/x86/include/asm/cfi.h   |    3 ++-
>  arch/x86/kernel/cfi.c        |    4 ++--
>  include/asm-generic/Kbuild   |    1 +
>  include/asm-generic/cfi.h    |    5 +++++
>  include/linux/cfi.h          |    1 +
>  7 files changed, 14 insertions(+), 5 deletions(-)

Looks good to me, thanks!

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
