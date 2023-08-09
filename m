Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473CD776B32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjHIVpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjHIVpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:45:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB2E7F;
        Wed,  9 Aug 2023 14:45:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5841be7d15eso4189497b3.2;
        Wed, 09 Aug 2023 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691617546; x=1692222346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsRnz7jVORsZvX+PwahsUqWKNeWTR7k0593BA2MOHsQ=;
        b=Z3uTZ75DkNUA9rN35JY6ca3I99SOlBwXvat3dufkEBM38EsBFae4QkeggxVGHkBnQR
         BNNcBztanLjClYQlL6uBHbSqt9AuSDX5Dj412uMGFVKimhDNz6IybWBIPENnNPMo9Ske
         BoRTnvJshONgVnVj61RIfu1LxNEmd7Pv3PBAxfRQ0o9qV6NuPUxkuSTnCqtoXe1ZNrHq
         a8bjEg06ME6gu7pFOs/njZXQ58TtyIathOqwPPX2eIHRGIXEv8qEuF2Hf70/7ryfsJBg
         SV3iqPmCOdimFCc8xiic9L35z3EYHg07uMAgJ8YpkENY5qbbUv2NJT5vFqQ+4UP+qEg3
         GtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691617546; x=1692222346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsRnz7jVORsZvX+PwahsUqWKNeWTR7k0593BA2MOHsQ=;
        b=RiINut21hmIwIJsC2nvIVQYyhALkRLrSvAftxs0LFG6/2q+v/HeU9yfkyuL4SpwsBq
         X3lBu26mlVCZBU8sdqgFqkqi7iBGZhaCVTCQQOt0JtSq4Au/8W5jr4pOsXx0NHAQAT2f
         cE5/V928zA8hF7PL4wG4AjMzFx8W534owPb7v9PgITLKwNh1BnRmM0I+VDDqTRyLAi0k
         Y6v+R7B3opz81uuGXxInl1U7G/Yd2AMp6L4GOYqFDRcyNzjSLU28APKV4HxczkIJyZsp
         0wZd3kuxI9pl+BmJQ13f3CN19+4CPLfq3kr1RcpFvuO2jOcnL5C42kxK+cz+/xn/6/6o
         azpA==
X-Gm-Message-State: AOJu0YzRRO2QkYoH523YVD78bXv1VTUJtDVXX9pk82rsMLLW3pRapGN3
        cFFB+zIogNSM2Z0jLmCAMZN2jBT30ZyzzPsHPx0=
X-Google-Smtp-Source: AGHT+IEi1aQHkjwQ1KcNESt+dCxO4vUrQOr3z/zX0f4Fmo4/LhX1MbtMT6tl+TJx5LvM4sko0YnNZkGCDRYHhVMfCFM=
X-Received: by 2002:a25:dad7:0:b0:d08:7ffc:c0eb with SMTP id
 n206-20020a25dad7000000b00d087ffcc0ebmr830623ybf.19.1691617546054; Wed, 09
 Aug 2023 14:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230628171108.1150742-1-gary@garyguo.net>
In-Reply-To: <20230628171108.1150742-1-gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 9 Aug 2023 23:45:34 +0200
Message-ID: <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 7:12=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
> new file mode 100644
> index 000000000000..42fde0930b05
> --- /dev/null
> +++ b/rust/macros/paste.rs
> @@ -0,0 +1,94 @@
> +use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree};

We need the license identifier to apply this -- is it our usual one?

    // SPDX-License-Identifier: GPL-2.0

If so, for the record, could you please confirm it is? Then I will add
it on my side and apply it -- thanks!

Cheers,
Miguel
