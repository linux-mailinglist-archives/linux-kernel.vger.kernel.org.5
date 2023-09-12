Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF26179DA5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjILU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjILU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:58:44 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB6210D8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:58:41 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4135f97435eso39240291cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694552320; x=1695157120; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Js1sPIN4tSpqKzVh+cdl+vbQOEHreHNkNpfHbtQhoUw=;
        b=ddmzdnpk4+27RF87GVG04p1/sQF+fXbsOhjj5QAjkWcc8LyKHgRRGVkXbQxQppXjd5
         Lww+ruRPoQDWfrG8G6BbcGeKAmX92dMQC1eg1YBvNPGOn1e460zxX2pFO3QGchJpIula
         1npW3aAh/ZtFYNRI+0Rc9TyGbl1qbvbn//1/be4S9NeD/MMVUbAtudCZTx3dGR1q/B5u
         1XalBzIz9/+hUnyltup5YX1ocZ5/dNhnYI7kEgPQcBJG4AFmXl7/n+G1bkMDxLshE+SG
         BtWymDWmUeyekkcAJIO3ARhqwxHSi1eHxQwuQL28hNfRyPyelRH1xEtqqH+HTzeqxnhc
         98nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694552320; x=1695157120;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Js1sPIN4tSpqKzVh+cdl+vbQOEHreHNkNpfHbtQhoUw=;
        b=AwhN3MSfZh+6+fNYSurPJSAO1M3rKJuN6PbyHu0925kXyLD3Gp8AXHOqZ8VTGh59YC
         +SP4SmZAm8T/7s9Nz+Vw7Sm1XoBSB2Fve2tKZl7zX2sTXtqc4IL5rDqAJQrt1gIjRYQ8
         zqtC4RBcefGiKWafq9rj5mIiGrm6RPyrFgpiJc4HkePqdOdLq5D3g9ua3i4rKBX3pHDt
         lu0Lw+Hx2tX0pqBdYGSkKlYd8TyqPIa0ihnwZVS2q95blZ53PhhVurP42rRIe6ad/041
         2Yia7rdMhM3m5yrqPg/iOYqt46Uu7bKkAKc08LGLNihOVnXGVjXMmZw4uED34Wri6WKx
         0eRA==
X-Gm-Message-State: AOJu0YwOcdiK/In2QJ2n+iZqxGhwKGe6CeY8OlhX3yBX3PHRERtG3RKH
        p7tG/aUzCP4kede7V5+rBLtH
X-Google-Smtp-Source: AGHT+IFx1FFRoXcJqvM1S2NAgyMm6l7izDLmyHVvc8gF1o9Jby+x6eU/Q7lfnMg6XgyGLr2S6gCrSw==
X-Received: by 2002:a05:622a:3cc:b0:403:a6e5:9aad with SMTP id k12-20020a05622a03cc00b00403a6e59aadmr576960qtx.47.1694552320183;
        Tue, 12 Sep 2023 13:58:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z24-20020ac86b98000000b00414e93d940dsm3572106qts.50.2023.09.12.13.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 13:58:39 -0700 (PDT)
Date:   Tue, 12 Sep 2023 16:58:39 -0400
Message-ID: <c91bb958ddbfd9b9572d51d96cd857b9.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] selinux: Annotate struct sidtab_str_cache with  __counted_by
References: <20230817202210.never.014-kees@kernel.org>
In-Reply-To: <20230817202210.never.014-kees@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 17, 2023 Kees Cook <keescook@chromium.org> wrote:
> 
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct sidtab_str_cache.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: selinux@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
