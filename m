Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E977DA847
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJ1RqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 13:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJ1RqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 13:46:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A576E1;
        Sat, 28 Oct 2023 10:46:19 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5ae143e08b1so25235977b3.1;
        Sat, 28 Oct 2023 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698515178; x=1699119978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFhnQuUqv8UTHRqRrIkRXb7c02Iw0Hc4wKGalfdouzc=;
        b=YnDDXvYhdL916cjF5wonSCIgWZ4G2Bza81/N8rr60y6PLDgcTM3Z7bQFcUjNw3kcIS
         87e5WhA3F9UQw9fj+m3fg9tIMsh9awOEV7DERJy+46YhjXVnTsRILgGLnEDNnLdRbSSK
         IRCd/l8Mjjr47HgjL+85/wGDg71pxwzK1/9FpAvvZ2x+XeLeM85LWFrjpCHnrrxVYRnk
         yQM7EyW2kzmbTfr3/uYoWPfWD+1tnIDgWB5+wEVYDDlC+kcPllWKfE8DNymnmpdMP97o
         U965+KCEtyfcUkw3DEKOJ2/SXS48j++wKGaqYV1shizN5HnOrTBch9ZcsclcZgSC/QJ4
         nFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698515178; x=1699119978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFhnQuUqv8UTHRqRrIkRXb7c02Iw0Hc4wKGalfdouzc=;
        b=aTy9MQ70Dv2oJ0Sp5DEUJOng5kIK0D46KXWI49l/fOGCt7ro+jSaY51CTihzBagSUs
         l1eQY993ND4vmp2IxlQeBsDft1jvAyfqoqrWR7WR0AGsJ2lfNOcH8bjF1/nWHmJMFkkw
         9ZPpvg3SRarsqoOFBAL4yPpi9zo4/+rhgligxwV9q5oUY/EOfPiz523S0oZSz2llfES9
         DjGK7lmaisfXHHetrrvtPrvsGGFzDxjgXerC4254LILZJqfm9ZCQgIBq1VJM4W6HpEaE
         1zXZ3v0LRuTQHgQiicnP/7fW+dF8FBfRkhu7nRSjGQ6C671Yn1xlp0nyA2BJ7MAh67Qk
         P+EQ==
X-Gm-Message-State: AOJu0Yxuo/dkO7UUfvQtbkXYs/JSU6e9TOpuovS7naHLVZpCgfeEjDgu
        qGudeCWHGlXdc7R52pEVTOeoiv0zAiAlVflmboU=
X-Google-Smtp-Source: AGHT+IHAxMPBGirG7gH46wHtSu0aBHOeNtb/ZOn1UoqO0DTDtNy8aeRXKoNbZJXOEdCZkY6oxpO+PxGDP+soAskdUW8=
X-Received: by 2002:a81:e445:0:b0:5ae:b86a:f384 with SMTP id
 t5-20020a81e445000000b005aeb86af384mr6227239ywl.2.1698515178514; Sat, 28 Oct
 2023 10:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231023174449.251550-1-ojeda@kernel.org> <20231023174449.251550-3-ojeda@kernel.org>
In-Reply-To: <20231023174449.251550-3-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 28 Oct 2023 19:46:07 +0200
Message-ID: <CANiq72kmtSPp_qi7BWexfr5eOBCSVMgkkYaivtboRrNexKWMpA@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/rust: depend on !RETHUNK
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andrea Righi <andrea.righi@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 7:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The Rust compiler does not support the equivalent of
> `-mfunction-return=3Dthunk-extern` yet [1]. Thus, currently, `objtool`
> warns about it, e.g.:

I just realized I did not Cc Andrea when I sent this, which was my
intention -- done here, sorry!

Cheers,
Miguel
