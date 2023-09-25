Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF17AD019
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjIYGXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjIYGXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:23:38 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDC1E48
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:21:51 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-493542a25dfso1744073e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695622910; x=1696227710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLHjhG4Jgg46eldzbxhJ6TWX0/Um9RrKLUKna1Lh+yI=;
        b=p5cesLcpOa8ybp8vAECV+k0cYJG4lW36uZ52482URfrq86dl95NnETn231tutDYPUP
         G5I/lILyW7dYo3Xd3Dw3xzM/Fb+FEzKb6lhigiSJ2o3tlA0m/g5HFQrOp+b25+hGxV7t
         42sSBylZeo+O1DS6oFHB84lr81Oex70gSF/XYg4e0XweeiWFJhvf+yrHVntr2uL8isLM
         bXY/jxKWl7UTzccIPflh+hmPXOvRhjOEGXBYloHwXV3saalkZZsX6fA2nbbgQkrR+Qer
         qprOeHjiXBLS41w9sDLqtmmzg8VSZk4Ne/xpJxcikyRjMkVPGbIOXe1bm0FRYpnaPxuk
         a2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695622910; x=1696227710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLHjhG4Jgg46eldzbxhJ6TWX0/Um9RrKLUKna1Lh+yI=;
        b=LwgJ6dI/e4N06Tm8xEcM0tqed9e+K5oDqiRFI4eOsybDcKIXUrTxAoA8ibiZUIBcdg
         v1l8AcxV1q3p8niAyQcXnR8/T0YO5SLCtwjTot7M1SNTdUUxxgU/YdnaJTSeI777TCtk
         ra1I5al2FbdCmO28SLXoacRYaQcxpm+PXdjxVanU2QA5M2mb0VVbZ6BAi5z5P3Ht5RK2
         kzOb0Bl4Ef3QoFowYPdfWpF7AMksP8NiinPnHOYYZXnT/M7sC28SquTRWLLqANlJD1P7
         dMNe+4lVt99KmwaaTdhUQXUC74SvMEGhlbKFCaqcXPs0UIjOTIB8nCVvbydJphlmefzd
         3Irg==
X-Gm-Message-State: AOJu0Yy6WD4ofvbmPlyMW/FRzspA00ZQ6R16lJwv2cggklthmLNOLgYi
        H1TnSHaXpI4xkaNGtzdkadctqhPXtd4ao/4cfj1QCw==
X-Google-Smtp-Source: AGHT+IHpmREQJdbNmA1t9SJ1rozZcrM0ZQpmHgFOzejqaCZOu3l0fZSDYVwVWivumeTttRNf3O9Immav5TvwGj7SsHI=
X-Received: by 2002:a05:6122:1781:b0:49a:3d72:fe7c with SMTP id
 o1-20020a056122178100b0049a3d72fe7cmr704324vkf.15.1695622910216; Sun, 24 Sep
 2023 23:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230923144938.219517-1-wedsonaf@gmail.com> <20230923144938.219517-2-wedsonaf@gmail.com>
In-Reply-To: <20230923144938.219517-2-wedsonaf@gmail.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 25 Sep 2023 08:21:38 +0200
Message-ID: <CAH5fLgiMiynY+EnKChEhcc3MeHW=bpvriOG2CFkprnGASGy=Cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: arc: rename `ArcInner` to `WithRef`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 4:49=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This is in preparation for removing `ArcBorrow` and making `WithRef`
> public.
>
> This is a pure name change with no functional changes intended.
>
> Suggested-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/sync/arc.rs            | 20 ++++++++++----------
>  rust/kernel/sync/arc/std_vendor.rs |  4 ++--
>  2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
