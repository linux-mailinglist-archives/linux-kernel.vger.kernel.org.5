Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0D80A114
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573642AbjLHKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573741AbjLHKcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:32:48 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A22136
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:32:32 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-46603b0de2fso173499137.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702031552; x=1702636352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnvM9UPay+TWsNcwFyjBL5jOimK9gNCNxA7H2kn5h2o=;
        b=ksud81eILSXwCWXVAE37lJK7fBuSUT6v+PExFGYkBrbYme2WUSHM/0HVn/vHYlw4NV
         V51q6EkdEUE5iigYrzcyH+ga/JiC/nHrazQmMkPn6TJwTpy9M/8HWr3dmzTEaipL7c19
         F2DAXycXOOHgjsvt93Z2Llev/0GSql5adCtClIreZA8qGgkz2dJaYVJ6i2d8uhtDU6J1
         hQgZBwD06zLyBi0H743ClRYgTVE1OkhK7Yi2Z7A7fJiIbtnNd/yyNpmTWmYs0CHCzKr7
         FJYi9Fcd4aEvfnJcsBiX+oN0aTqOwTIZpSlDIT/T/AFmeHmby/+eEpDlHL6yZ9upaKIi
         zGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702031552; x=1702636352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnvM9UPay+TWsNcwFyjBL5jOimK9gNCNxA7H2kn5h2o=;
        b=CPKlybi27DS5izCkS61H3EEXxFCFuSvzYovEUfCLAUqBJGWAuVqmNyzKsp4/U0vHSC
         +j6pZDTA6VGsw75OwLPZftXUhOlQh/gHDZCL7r6KSr158lXPQfQ0DcSFUsPIB6rCtCly
         xgpVsS5FKulgJI1tvokxYOmj3BgWvLuYOnWBfORPb8JXKjQKPAqTR49blk/F4ljXZDg/
         2HYMdymxSavhzPYaPwkHhUq2ZmQITnganhas9U9kNzErt29G13blx60hfEfY7LBOmcDz
         +j0DGyRcwhh/2AOnp8D5CQhDptrNzLNqBednRvNlxJ8kdSWAnmbve8qczb+ib7e3hUzR
         5A1Q==
X-Gm-Message-State: AOJu0YzIBSM0ADGjEpCWhF3968IqTMDCz/+zexDR7pAs0u7dAWa05391
        4nPVXkF6bK/2C7jFhEqrYRMDyb8iZWqnSLdQdEluOQ==
X-Google-Smtp-Source: AGHT+IFG5wfI7dO2maOsIJsX/n4bsVO+E2Ku1qwKyiajAw6j6p6fJzIra0OgEwMTf7hlFjr5oeYt41iqmDzUDBKXC+0=
X-Received: by 2002:a05:6102:86:b0:464:9b1f:c718 with SMTP id
 t6-20020a056102008600b004649b1fc718mr4280794vsp.33.1702031551819; Fri, 08 Dec
 2023 02:32:31 -0800 (PST)
MIME-Version: 1.0
References: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
In-Reply-To: <bf0d4ff21bc25d1ba3a31e49a32bde06dcaf6e44.1702030679.git.viresh.kumar@linaro.org>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Fri, 8 Dec 2023 11:32:20 +0100
Message-ID: <CAH5fLghkMXfND9Kbg51JZf+Ry+pCvGLGSHtpqOdWK5gHkfU7-g@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: Clarify that 'rustup override' applies to
 build directory
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 11:18=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Rustup override is required to be set for the build directory and not
> necessarily the kernel source tree (unless the build directory is its
> subdir).
>
> Clarify the same in quick-start guide.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
