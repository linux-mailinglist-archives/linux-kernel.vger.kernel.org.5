Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649A87BEDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 00:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378627AbjJIWAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 18:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378238AbjJIWAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 18:00:53 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0320A9;
        Mon,  9 Oct 2023 15:00:50 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-59e88a28b98so43203227b3.1;
        Mon, 09 Oct 2023 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888850; x=1697493650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaFaP65UCsCQ7UFZs55oDxqvd/C/aEIgYAqZMLZc35k=;
        b=QRCJjEXmn2gwi0XYp+xDv/TLLOhjeSuKIRzEfql676/7UqQG7PILVET/iAlqtAPcl0
         MfofxQ80AXgrsaNe5eOlQypUfTuT0lc4DdrayDWUmLYC7zTEhv4JbFu+pF7gBJ/+NXQq
         r0e4w+DaVA9E/WWYTKA9zH0EPt7S5wHcb21FnOFPRO8iulFuk0F/4vfYCI9Ha0hty5t/
         QS5XWTMRsYcd9xxyH6gTD7AaHhJEcajPq35JR5TAao0Q7DMfsKB9RReerKYpR73jyZ91
         +M08jCMKhTzxedOdyMhbfC6dixEqUVbrf7wOVfRo73ZiVqZLwmRnB9gssZp6bqqxeIg7
         F+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888850; x=1697493650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaFaP65UCsCQ7UFZs55oDxqvd/C/aEIgYAqZMLZc35k=;
        b=APBq+IxXl7DTEFwCoSgHE/WiEzkQL3YksvVmP0iD3l4WI1LoB4kqAJZC3cQq8+339W
         aGlFfeJJzuZF8s38+o1dj2vHnzYHd6xhHd/bkwoUWwzh5SQQrRmdfaJbvSQNCWSi2GV0
         Z+gDlvSnEJWlY4Otlhth7F29exn04odnF/11W5/BLalRruEzKZGxR0OQUr4vnHzUD1mA
         k6Q8X8m0j0j7VBCZgc/xdBwiQ8zAQ2RePjLVS4AbsC+suBBkeCtN1tbyOIMkOR6/aE3o
         4dxgAnNAH5+UCugJh/WMBnmePnXORcwJNTPOqL0lAMV/JRXVUx719HBIS0Yhk3mU1gcz
         OdOQ==
X-Gm-Message-State: AOJu0YxmgL4vA6Afl5gbn7dKXQkdKyGDqxZSU3z2rMis999+s4gKYWFu
        UoB6gz4ImYY55RjYnR3hGQ9fj41RMoRTW1qR24c=
X-Google-Smtp-Source: AGHT+IHJn5aLVv8I0nHEAFYZqkKXk9+RdR00KxRNGwBs89E5Tf4VBtacqDxZFEYWVNFBVlRVBv9vOmV6h2CUAHAtCNw=
X-Received: by 2002:a81:6e44:0:b0:577:3f8c:fc60 with SMTP id
 j65-20020a816e44000000b005773f8cfc60mr8032221ywc.1.1696888850022; Mon, 09 Oct
 2023 15:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231005214057.759089-1-mmaurer@google.com> <CAK7LNATBBk-a0EJcxpWGJ9n+9BHQUw3a4s41LTtC-R8fYrVMpw@mail.gmail.com>
In-Reply-To: <CAK7LNATBBk-a0EJcxpWGJ9n+9BHQUw3a4s41LTtC-R8fYrVMpw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 Oct 2023 00:00:38 +0200
Message-ID: <CANiq72=Dsaa77n-OKDZCcv6TWgxZf7R00n=X137WbsUzwgU4RA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: Respect HOSTCC when linking for host
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 5:38=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> Acked-by: Masahiro Yamada <masahiroy@kernel.org>
>
> if Miguel picked this up.
>
> Please let me know if I should pick this up.

Thanks a lot for taking a look Masahiro -- either way is fine for me.
If you want to take it, please feel free to add my `Acked-by`.

Cheers,
Miguel
