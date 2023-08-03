Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0011976E8D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjHCMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjHCMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:52:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C130EF;
        Thu,  3 Aug 2023 05:52:30 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d124309864dso959329276.3;
        Thu, 03 Aug 2023 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691067149; x=1691671949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtdQi92sqIjn65WzEZ0r361+I8jHLPQqis6uitzVKco=;
        b=STWzZQV4SszUsLigT2mzxppqX1jvWFDrqjzk4bHnrZI7mR3UL4EJOxGzmfLC2mkDA/
         C7Y3i0cjFos2sTMNii4LTk6QP429j1tzOi2Ptq/42Mto4Z7pKW3v7aKeO12c3FIXGsXL
         l4RBzUmG/P/3tUVjMZavlPKRJRVvThlWCbSPdM3Js7DuA3pOMt5WlJ/QK4sRyReWsiVp
         RLr4Uus/hbTafhoRN4LJMaOBNTsHCMC9sKbZim1rQ7NTHvBZaLZT7t6FyLldzdlirEqQ
         VBKjOQ5xJOcTMnfbnaIlj6pDXxyyE6Ddxb0j16dkPeKIaUFJtlKBAaeLEgtFLX45j/n0
         xkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691067149; x=1691671949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtdQi92sqIjn65WzEZ0r361+I8jHLPQqis6uitzVKco=;
        b=Hs5EwyP8ikamA9wwvaeRybkW2s3hTHYp1hYaNup6hGTppwtPF6udgb/aoKmDosvFNE
         VK3csqIUaC1IQzDX/6eR+LnF8vZ8xOC2ha3BLl6X4cH8eNzytQeOu4nVtt+aUYppqZ7F
         ntPC2rDAkV4EvALmIO5n5kEHIRKHVTmZI9Xt+EHHHSRLK1vTrD1drfdiMPmEet+6kB8x
         cm50N8E6K51u3Cg6iwI1FVOblE69T1qUH6s4w/idkF++MQpBSiEll5oCVjF0iz828ebM
         VeN0h0t0FR4FA8VvEOWUW0qCUZfdvhzfI0epjklcUAhfa0K3CS17gV6lkEoTiFc5UZVF
         nAFg==
X-Gm-Message-State: AOJu0YxecEqaKVx1PBaSLCon7qjrYsaVvXkE5uS16M1Q1m+Rdv+4gxee
        fLH6h/DjHNoXJSu9crRqPlbn6MxHYJRhAiULJQM=
X-Google-Smtp-Source: AGHT+IHoLUXg6Vo4mH6359RdrTfC4vfDaELuKt4xB0Ibo5o0DJPqBXhlWM8JnFBZROfR2bZOCnm8REn9J3axrnp8Vxs=
X-Received: by 2002:a25:244b:0:b0:d3b:137:1877 with SMTP id
 k72-20020a25244b000000b00d3b01371877mr4958514ybk.5.1691067149508; Thu, 03 Aug
 2023 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
 <20230802195020.3062950-1-aliceryhl@google.com> <20230802210208.4dce7501.gary@garyguo.net>
 <e7c4a61b-19dd-1bb5-e0a5-7cb55286c994@antgroup.com>
In-Reply-To: <e7c4a61b-19dd-1bb5-e0a5-7cb55286c994@antgroup.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 3 Aug 2023 14:52:18 +0200
Message-ID: <CANiq72k2FH9bE3971QChM-EsVMhYpwaWQE33cXUJkr5TnCzJuA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, alex.gaynor@gmail.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, sergio.collado@gmail.com,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 11:20=E2=80=AFAM Qingsong Chen
<changxian.cqs@antgroup.com> wrote:
>
> According to the suggestions of Alice and Gary, we could do the fix
> like this:

Could you please send a v2?

I removed the patch from `rust-fixes`, this is the reworded commit
message I used, in case you want to take a look / reuse it (of course,
updating it for v2 as needed):

    rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)

    If we define the same function name twice in a trait (using `#[cfg]`),
    the `vtable` macro will redefine its `gen_const_name`, e.g. this will
    define `HAS_BAR` twice:

    ```rust
        #[vtable]
        pub trait Foo {
            #[cfg(CONFIG_X)]
            fn bar();

            #[cfg(not(CONFIG_X))]
            fn bar(x: usize);
        }
    ```

    Use `HashSet` to avoid this.

Thanks!

Cheers,
Miguel
