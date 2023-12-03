Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F94802855
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjLCWTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCWTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:19:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E983D7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:19:47 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bc8a9503fso5144561e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 14:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701641985; x=1702246785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XxSLnXnoAjCjK6iVjpX9yAFivNoKI2p2SiVqVRW5JU0=;
        b=hTDjJ9T573MjIrIwfQoC/Inn0xizhqdBcolCwd7W5VK9RvZyVXDpV8aGSe2Nx+6FXC
         yBLW2gQ+7EeiQGnlUhkiV/133TWzYfFpRCLkJgG3P2Pr96RC5l4yz++FsLtSkL6qiMly
         3Qsd8vdnhXQPX/k2ylmbylfcfe7/NzRmNm7Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701641985; x=1702246785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxSLnXnoAjCjK6iVjpX9yAFivNoKI2p2SiVqVRW5JU0=;
        b=kWxkO4Xl51XPYvY5ecdA9eHJU4N81M8J0Yihcj4/EamRJwnYGJ4bsZqY4mTtMoPb9e
         6+uJGpw9hgMBjWYBlF/U/I5KO3MgU+lhiTe/7QhtEnV0aGUWLNelG8XoPM0EgSHNvpMS
         QFlJBWfl7hYxH3IIrlw7lij01RDXRELaYpcUFvAx8S8taJiE8FStFftzkgOJhbeXx913
         h//iVBZ5a18K1j9tWJ3rZt6iB72X/qiO9N9Mdjt0GG2LV5UUUVEM/QnjJFpeAsUsYveJ
         xVjjfp1y88clHM9BIvDtcOtom+loMQOof0SNQmp4NgKyPQVl/LBDy7ePLBco02fdSX7N
         eVCw==
X-Gm-Message-State: AOJu0Yzp9SrX4Skq55rAFqtoQXougaTL1BBXc73sDkV5fU/qCVjaiI1g
        8jYObiN/Amt6Y51K7v/3UnXsRDGL5GzRfGnoiK5cKlOZ
X-Google-Smtp-Source: AGHT+IEwzysvg3P6SIPzfGFmZgWE3sXtKcgSpBvL5cafJP5Ix0ullzm1ldZHbNVmdWD8FIIiWBAmcA==
X-Received: by 2002:a05:6512:3e0f:b0:50b:fad6:2f86 with SMTP id i15-20020a0565123e0f00b0050bfad62f86mr86942lfv.126.1701641985370;
        Sun, 03 Dec 2023 14:19:45 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z10-20020a05640235ca00b0054cc22af09esm779780edc.46.2023.12.03.14.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 14:19:44 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5482df11e73so4976764a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 14:19:44 -0800 (PST)
X-Received: by 2002:a50:cd93:0:b0:54c:b88a:7a69 with SMTP id
 p19-20020a50cd93000000b0054cb88a7a69mr630794edi.73.1701641984245; Sun, 03 Dec
 2023 14:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20231203221151.794615-1-ubizjak@gmail.com>
In-Reply-To: <20231203221151.794615-1-ubizjak@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Dec 2023 07:19:26 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiS6nyWNjaTW_XL1ec3+-=tOszj+_sWGfPv9RG5WX5isQ@mail.gmail.com>
Message-ID: <CAHk-=wiS6nyWNjaTW_XL1ec3+-=tOszj+_sWGfPv9RG5WX5isQ@mail.gmail.com>
Subject: Re: [PATCH -tip 1/3] x86/percpu: Fix "const_pcpu_hot" version
 generation failure
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 07:12, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> +/*
> + * The generic per-cpu infrastrucutre is not suitable for
> + * reading const-qualified variables.
> + */
> +#define this_cpu_read_const(pcp)       ({ BUG(); (typeof(pcp))0; })

NAK. Absolutely not.

No way in hell is it acceptable to make this a run-time BUG. If it
doesn't work, it needs to be a compile failure. End of story.

                Linus
