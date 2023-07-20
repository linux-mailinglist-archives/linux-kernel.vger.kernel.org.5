Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD8875B003
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGTNb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGTNbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:31:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD5130C7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:30:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704970148dso7844637b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689859810; x=1690464610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjG54K9UMvND9YdSZpiieZAi2mI+0cYK9bWMBk2vtjA=;
        b=X8llH09LLmS+Qw/lSrOllIHi+4dmRIBX/dXsgg6Lib23gGuPm28NtMAWavnDcRMqDW
         Ade1jagBfeBBB6WvukKwd5cI+jaDOdbyXcTHZeW12bE44KI9ONgPxMAPpqKjS9OFyNQF
         NVmUDiFEGvXOOmGkitR+UOruNdAs7lCfnvd3T+GF0oDCZQo2Oc9PYQ/+6cPUG7Tst4U1
         eXOmKDxZ8B2M5NT8a+h11SM/RUh//iLmYJOsDLM3NeWZkHykJVAgwj0iu4YolCQA0ibd
         Qaf7ZWuTQg66vr+cJLrkR2pEwo1u1jTEXsKQAcr0Xd8y3qF714UeyMTz3wM+DOtwG1pI
         0h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859810; x=1690464610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjG54K9UMvND9YdSZpiieZAi2mI+0cYK9bWMBk2vtjA=;
        b=OvozoA2aMokWhW7AZCaAEB5TYe9+D9B+cOfqkzRxSkmv6IZhbAGWerRwQuoK+AiaHD
         Rz6oy6PlEKSX45rK+ZrK75FDwDiH60lQrImaiWZkhBKGgMFeKEXjSKj8e1+v5QmNiiBF
         7wK+lOGAgnjVaP/I3g5Zsp62HowAEw6POdhRIsMsCLm0TdhjRuZmJAed/ty0AToWo8Vf
         yawmVsv7Su9xZZJ8mbD4kHPF2Vla4zfBYFvspG630EQsL1L1f4O/jKEqydpCh7Bs5r1L
         LTW97fAxn/puDmg5eNAe/kkF73fHBNzo78SsGFD7Uyz195nfqDvSGpGqPI1CeG0TCEV3
         4PIQ==
X-Gm-Message-State: ABy/qLZGnP7YgaXYIAY3ODbTbLNg2nNkbOUQy2cUC5qgQd5hfTudC1iF
        REEyddmfhRIgBBnYBl7VAX7RnwxJHQlorr4=
X-Google-Smtp-Source: APBJJlHh8OTAMhUc+zd62yYjSroTZ83K3aOglIxna4ipPRiay62Nb2MGLCYg7ujuKQKtxT5uTxldXcvJkoo/iqo=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:410f:0:b0:562:837:122f with SMTP id
 o15-20020a81410f000000b005620837122fmr208475ywa.9.1689859810179; Thu, 20 Jul
 2023 06:30:10 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:30:05 +0000
In-Reply-To: <20230719141918.543938-9-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-9-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720133005.3545184-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 08/12] rust: init: add support for arbitrary paths in
 init macros
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
> Previously only `ident` and generic types were supported in the
> `{try_}{pin_}init!` macros. This patch allows arbitrary path fragments,
> so for example `Foo::Bar` but also very complex paths such as
> `<Foo as Baz>::Bar::<0, i32>`.
> 
> Internally this is accomplished by using `path` fragments. Due to some
> peculiar declarative macro limitations, we have to "forget" certain
> additional parsing information in the token trees. This is achieved by
> using the `paste!` proc macro. It does not actually modify the input,
> since no `[< >]` will be present in the input, so it just strips the
> information held by declarative macros. For example, if a declarative
> macro takes `$t:path` as its input, it cannot sensibly propagate this to
> a macro that takes `$($p:tt)*` as its input, since the `$t` token will
> only be considered one `tt` token for the second macro. If we first pipe
> the tokens through `paste!`, then it parses as expected.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
