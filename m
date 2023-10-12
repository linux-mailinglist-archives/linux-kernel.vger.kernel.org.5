Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4F97C6F82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378876AbjJLNnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347273AbjJLNnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:43:43 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8328C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:41 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-49e15724283so331475e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697118221; x=1697723021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5UxfBdj/6JrF2qHbkJWuAP1+z4BtgpnwOECrshG7uA=;
        b=gm6vIwL0lCFg1F/OVNH2S8Xf6IlaRAhDZlruNt+wJ5yFeMgkY4TB9N5EqFQPtV+Y+o
         h2npIhs8HoAL0duy0bS8qY2QDxh+Km3g6Oxf4UdnmTt2dnfY/wMpAbNxype1tsOWTzPE
         7c6RTZki67ukHP7z8fhZEGdcd0ds7tOwwTJcIILDBortEpFEippIkjaxyanX3KGjpkF1
         PMX4n/CTL6H6wmscOyEEEFj1KVAWXoiQYb8KWk1PUITcaR8ad1iqusnzM3XiV3VRbRzf
         QBmM4Ifvq4iOdsq+KwwiF9umA0inZtgT7OindRF/6iw9KL/zRCNQR1lb3aL8+eH8BxGY
         6tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118221; x=1697723021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5UxfBdj/6JrF2qHbkJWuAP1+z4BtgpnwOECrshG7uA=;
        b=squUn55dPaCMI3saNLEcNzwT8zWiQtQvIjZbxzigM/rsqikmXM1xdM8fhtE0voqBED
         U+UP+eC0SBqjpEMqW9lf3M9U3oxW+o3fK0D4PNS8GLZkXwiN+b9sgit+ekrmrfcvq/5Z
         ATnStpb5+YXJgXHVL7gd1LkJeIFyLNgMMBCFApQcuUmVxJf6DnELVnTrpqPQeCYg7yGi
         fv3K7gzUymbSxDW42x6aQQeVosizZrA8neD6W4GP3e7uiYH7UesA21Zink9/7+/cAVBC
         XbzHFiLKBlqWzDbbQduH3Qgi3ves/qhc/wfHE5dxgoLal6s3aM+ZLyEBwxs1aw7ckiwz
         Yo1w==
X-Gm-Message-State: AOJu0YyTlICiDAwKSTPGVyH1ac2bzTjjfnAl5stpXJhWT8TmQH64zTYK
        8ySdnNqcT9sowQFebO35SPj2QNwVs8E93uAsOhPnTA==
X-Google-Smtp-Source: AGHT+IEtzmuyswh9BkchHbtxmapjfde5JaFYoo08OhEksgVyX9vJ3Lzx6rWSdYd80NGUK2zgO4emVZenhzszDQU6FQo=
X-Received: by 2002:a1f:ed41:0:b0:499:e671:1682 with SMTP id
 l62-20020a1fed41000000b00499e6711682mr20231744vkh.3.1697118220736; Thu, 12
 Oct 2023 06:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132131.300014-1-benno.lossin@proton.me>
In-Reply-To: <20231012132131.300014-1-benno.lossin@proton.me>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Thu, 12 Oct 2023 15:43:29 +0200
Message-ID: <CAH5fLgg=AmuR-93vuVmdr_oVUYCYuYas7Unrm0UFtQ2Yc3x6wA@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: improve `#[vtable]` documentation
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 3:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Traits marked with `#[vtable]` need to provide default implementations
> for optional functions. The C side represents these with `NULL` in the
> vtable, so the default functions are never actually called. We do not
> want to replicate the default behavior from C in Rust, because that is
> not maintainable. Therefore we should use `build_error` in those default
> implementations. The error message for that is provided at
> `kernel::error::VTABLE_DEFAULT_ERROR`.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
