Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F211178B179
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjH1NRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjH1NRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:17:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440111D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:17:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-58dce1f42d6so57730567b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693228640; x=1693833440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGYTgGJyz9hK6P1W5cYWJ37ojkoun6scwiaYLpf40GM=;
        b=PDCzEuB4+vOFbmlh9WJaVjW8tsiEFTj81FSUQotQQVuJyuddJBEM6FCZABer6pd7gz
         qZP9Jjhj7qU+ei9c6IIh1aVkpKKiXLZxr1qnGL9qczFSYStHkCYvpRv8JTnM7UF/705j
         gOpAC2ZDoVUm2R4RV/xkBw/VcwedpwWOiBS6k37BLE3C9ihOwrn0uCEGaiGE2ug+0LKa
         uO5mhSGt4DE13AGsazbGDfCsya1jdMG5KrKt+5b5Am4HsMtGpn5A+/YztZfQo+gBQzJE
         lVP0EqmMGzwE9nyUKvlROzTt1GMY0rNpAs8fTnre9C8bq5H19nk0OZBW1ZfKwSK74dkO
         g8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693228640; x=1693833440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGYTgGJyz9hK6P1W5cYWJ37ojkoun6scwiaYLpf40GM=;
        b=SdrVnTHoPZtntWFU2gYslR9xHTojqA19ZSRMFauZMiM7rDMIHKeYmoKfwb2MHprZpi
         Ipqy/bSrBxL6nBFFPu/WUsdsv1pO8dwkPuQR49Um6r0jrFRKAwWCRvOLaywWuUHZxTCs
         2BNJs+kDJ7cDDzbDRVdRfijjL5EayBCDzL9vEzAOSRQQaBzEG2hXEq65W5/7+ScGu4GC
         zc+j/+8BZuG3Odaw/b2c5eovBjDYQR41dm9WqRzvtY3kWc/K0AxZnWPOXoQ1rmAdT9za
         5Z9VBwLd749EIq/L3qgLK3pKHraE8T9ghfPMRyaZFEVLlP0DE3p1FS/E5/KYL7+2/yfv
         WDAQ==
X-Gm-Message-State: AOJu0Yz3Ann4Vp5yvn+9aKXV83bzRvPJn5cGYUOnbJiyYaxbmUeRbosO
        45zT1zxfVRkzxBaVGQbIOhiEked+GV2+AN4KgQKswInedGuhYl15NByenw==
X-Google-Smtp-Source: AGHT+IF472zwt+zJU5bvh6KBEPeZ/osWrL9kS5Td1S0IJH6vipNayQJ/MzpTXVzXkB4GiGqUispoj9X4m11CdMwjvSY=
X-Received: by 2002:a25:27c5:0:b0:d66:9fcb:1fc1 with SMTP id
 n188-20020a2527c5000000b00d669fcb1fc1mr22835256ybn.24.1693228639796; Mon, 28
 Aug 2023 06:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230823160244.188033-1-ojeda@kernel.org> <20230823160244.188033-3-ojeda@kernel.org>
In-Reply-To: <20230823160244.188033-3-ojeda@kernel.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 28 Aug 2023 15:17:08 +0200
Message-ID: <CAH5fLgjDf9VP4BWp9zX1iv9KiUhA6y+p2Cp2L6-3mR=KS_ExDQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: upgrade to Rust 1.72.0
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org
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

On Wed, Aug 23, 2023 at 6:03=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
> This is the second upgrade to the Rust toolchain, from 1.71.1 to 1.72.0
> (i.e. the latest) [1].
>
> See the upgrade policy [2] and the comments on the first upgrade in
> commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").
>
> [...]
>
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1=
720-2023-08-24 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1012 [4]
> Link: https://github.com/rust-lang/rust/pull/112403 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
