Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2B97A5D58
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjISJFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjISJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:05:01 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179EA128
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:04:55 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-496d3e18f19so562862e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695114294; x=1695719094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ofKdvgR0Mp7BMJehnfbK34RyoaC5p+eN21rHFUIhas=;
        b=IAINc4WH9M67yAENIjtsVTkXLpXi7p7B+2vpbi39N6F/53A4JZOz+Bq7ERt15Pj0/R
         2engt+W9nTs3hcUsJ22N+sUnvbQZ04Pszlm9x5e1+Xzut0qDa+ET2BkdnlV5F5MtJ2Pa
         67j8SzUFRGHL0SSNLNEq07Wl7jWwsDnMT/YOcfC8ZS5g8qf62DT12ZusL+DyagSY1Hvb
         hmqJTbYz0m0kN9KOcl7LaTWog6TRWzUEtaGYJpJtgHVplV01MpGeJevx2zDccBIsGr4m
         Cxx2mdLcMC6zfXVaR/wWEBA2VUhJVje0p/tmW3pVMHH16w+wvE1JF5C9KiV/QpqXx8km
         Lfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114294; x=1695719094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ofKdvgR0Mp7BMJehnfbK34RyoaC5p+eN21rHFUIhas=;
        b=m0FjALcvGqA6PGe6dPvQ3TvcFG9sLuhcvymn/frCd9e93ZUIt/RJ/LXSgxc4sexlDt
         sQl68GXUpc6iRCj6Cdj2IjkxUh0hk70iF+D+oTq9uDPpEi08vHJ3Tv55Udu62PVnrrVq
         Q4etvmWEhPybSWGNmWVupkTgc1IySIJi/t73ld1hq3g6YwwdW8Zac0hbmC/vdjL9iarY
         Q9R5gt+3g7+g6wkBzRRyy8GfOrbN3EQB0qqaaT45h3O+0jMT69mXb9hcaJ+QbLncO/zm
         6Y+t0L403tMth/4O59wnW55gUzdxNA9jmcnwKNAbNqa1fwfJ2BS/zZrrVU8bulvRemso
         PapQ==
X-Gm-Message-State: AOJu0YyBHeDDkik/MCB1xpr+tjUvRgTjjR3sK24FzAJqYvJP42wfbdtA
        JIcb35rfh3HmFjDB9RHBEjBOZkrYqxQN9+0jg409uQ==
X-Google-Smtp-Source: AGHT+IF9wWLmsx1f7jpe7ADkq/lXgpDNO86t3lHVkZ79WCeZacV4Y43fgL+YNhZyVI7fqNj6fQdT/fVBkwek9KloEqU=
X-Received: by 2002:a05:6122:4699:b0:496:ca46:f0c8 with SMTP id
 di25-20020a056122469900b00496ca46f0c8mr3925766vkb.16.1695114294084; Tue, 19
 Sep 2023 02:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230830165949.127475-1-ojeda@kernel.org> <20230830165949.127475-2-ojeda@kernel.org>
In-Reply-To: <20230830165949.127475-2-ojeda@kernel.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Tue, 19 Sep 2023 11:04:43 +0200
Message-ID: <CAH5fLgh5=cDu1BZBn82dGeboLinTV=rzU3=rn=eD29jKq8tH1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: add Maintainer Entry Profile field for Rust
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 7:00=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The `P:` field allows a URI, and we have been adding information
> on how to contribute to the Rust subsystem to our webpage for a
> while now (and other relevant topics, e.g. branches, third-party
> crates, Rust unstable features...).
>
> The webpage/document does not currently follow the headings of
> the Maintainer Entry Profile, but it does nevertheless answer
> some of the questions we have got so far from contributors and
> it covers partially some of the topics there.
>
> Thus link to our "Contributing" document [1].
>
> Link: https://rust-for-linux.com/contributing [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
