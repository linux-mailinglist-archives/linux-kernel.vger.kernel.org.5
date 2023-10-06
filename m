Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E86A7BB38D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJFIw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjJFIw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:52:56 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7283
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 01:52:55 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-45269fe9d6bso887588137.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 01:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696582375; x=1697187175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxeu+1oR48xD2Gd7sf1n3o5+xMOLz2MYkIZCLI1NQDM=;
        b=11sI97Qs14SPAr3bSU+ATGMvzlEmRpvOtweT0YXm+VUkn5sEOc8TMjSWaHbzVpGQyr
         O6aYzTDNXW94LKt35kmJuH9F3xtpwkZapMzE6ZiRKpg6RXenJefYffsqvG6DdRVlpXIq
         lYgDIwW26OxOcgVyjAGhLx3Dap7We8CDgRE6RiHULNdhV7HW/jCpCoRdqs4DMd43rjCo
         Vpy9tlFmFfCRUKYRzPDEgr0Cayy9aTfhTNulk+Ad6asOhYjoEMOTOUoHoN2sMVuPutj+
         mQjN9mw6fKingy10mWW4icMoNW5AdM6kWT6f7MKrPpYHITBlX3XxvBGhO2vybeHthF37
         tXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696582375; x=1697187175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qxeu+1oR48xD2Gd7sf1n3o5+xMOLz2MYkIZCLI1NQDM=;
        b=Fpe0homVv5TfT73EdhNce0AjMA5LGveLK/4dFpyoA9LOWQ8YEmK6j/UzSknf7aBCPa
         mzvRmuLjfj2uE3itAbB2wZEl+wSHo1WCoYnLClrctGvuuHR/yk4zOVRW7M6lyyzuaPo2
         GwhHlg+IYVyuh4/WNruBiLyZ9abLPo0bFdzk1Ehl10xzSP4HTL0lX8CM+uMtkwJDmFv2
         mJ6XSGg2CNXY4dgkpq8omvsssYSKMx4VtiLjflqz3wGhuSZYZ/qiusYo4WgyoeIFXRsW
         OsC4eojnDUkMzGcEGU1t7sgcevTOSsrIlDMJj1BSKXI9iIK+s2D7P7h92Ii5dmPfHln5
         nfzw==
X-Gm-Message-State: AOJu0YyDJb6v5MFpU+PP461Ibsu4Kyo3ctVdgEfNFk9SEeg0mwblgQ0S
        fwuLM3B/pxSyQayYcHt7LW40TwkvN5j4S6bAl5oShA==
X-Google-Smtp-Source: AGHT+IGpa9oDupsxw07rqioIpfopJAPI0Ytv6CAxXQQ9ojG3965uvekx2SZ/ff+/vZJ9EI796i4mhJoVjm+u2xK7FaU=
X-Received: by 2002:a67:bb06:0:b0:44e:9674:7781 with SMTP id
 m6-20020a67bb06000000b0044e96747781mr7243449vsn.15.1696582374867; Fri, 06 Oct
 2023 01:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231005210556.466856-1-ojeda@kernel.org> <20231005210556.466856-3-ojeda@kernel.org>
In-Reply-To: <20231005210556.466856-3-ojeda@kernel.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 6 Oct 2023 10:52:44 +0200
Message-ID: <CAH5fLgiqCyV3OJ_mvBrSH0rX+GhQ9f6EpY+eZ13g_ebmue1TNg@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: print: use explicit link in documentation
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 11:06=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
> The future `rustdoc` in the Rust 1.73.0 upgrade requires an explicit
> link for `pr_info!`:
>
>     error: unresolved link to `pr_info`
>        --> rust/kernel/print.rs:395:63
>         |
>     395 | /// Use only when continuing a previous `pr_*!` macro (e.g. [`p=
r_info!`]).
>         |                                                               ^=
^^^^^^^ no item named `pr_info` in scope
>         |
>         =3D note: `macro_rules` named `pr_info` exists in this crate, but=
 it is not in scope at this link's location
>         =3D note: `-D rustdoc::broken-intra-doc-links` implied by `-D war=
nings`
>
> Thus do so to avoid a broken link while upgrading.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
