Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B3811D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjLMSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjLMSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:43:51 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7FABD;
        Wed, 13 Dec 2023 10:43:57 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cbcfdeaff3so73084037b3.0;
        Wed, 13 Dec 2023 10:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702493037; x=1703097837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlpBQmPd6QpuhOh431yGXR7s63nxRPGroAAUiDpV+JM=;
        b=UmMAVc6Xg4oogjTfHSixHUF2oMnumc+gxPPFWW/nn7VGg8UmTPvnHud4oQPM031+Cg
         teOsnphQ7+Rbieokx4A8xL6HTgzoG1GQg0J0/+Xt0MHpoXtNxG2KrEeIP3usR2uWZPWQ
         bxspAvM8usf5TT31mdnhUB38jWcYR2OFCcFLre2FGzguoaIyW+ZO+nG6z1teexIsxHiM
         44v/Svnrys5PUCWt18VFCFx9f95ZZDXPZsm8wI829AgHOZcpqQ5tHHr+flgirIxr+Kmy
         VHHvnjfHsoVtqeRXNtgw72qPOlbUXaXsRMU/Yys3T6did+ZiyBq+KgeChq9pHNRzcsWS
         eNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493037; x=1703097837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlpBQmPd6QpuhOh431yGXR7s63nxRPGroAAUiDpV+JM=;
        b=uslsB60tlFU+kYbksr45optWsEWbyChQ8NBa9QXkvwAQPLl/JvQFLRMUPJZrIyB7cx
         47qpw93Ya4pM/MGgxAKsahKjrel9QkshsMlDM6fFGLLBi2KhUZ1HpYpwuJlqxiN5lCj+
         Xkw7FHi8LpPDhbu+W+Akx6nVKnx33tTOAoDcYYgezwMrCP4Nfm0waGJ3qJAztQsoebRA
         iQjhpj4QNsfsl8dHMq3ipgNORPZl+j5e/V/+8hRjpwosB5pFcWSBINZD8HF7qNO68Zb3
         uxnv/JOoUlDWu2pi9SmQdGhCY5ZITVQd6BGzq8zO1HzmdEQmuh9aH2RzH4vrWArBePry
         ktyw==
X-Gm-Message-State: AOJu0YyCRtXwkeC71br72epOHV7ULCR6WPtXDMAj+/ktgKJjNMluA6YG
        VvQ7dSgD4MoRpTZzx3dsun0SgprngRS5/IMon9g=
X-Google-Smtp-Source: AGHT+IGqXUwHu6BzYwoUtZBpauwQao/mdvVDo33sZsIQPltI1zp8m8aQvW5Dwu1qAfg497LQRMXfkENb2An+gJFZpPg=
X-Received: by 2002:a0d:eb16:0:b0:5e2:77b0:7877 with SMTP id
 u22-20020a0deb16000000b005e277b07877mr1829572ywe.11.1702493037062; Wed, 13
 Dec 2023 10:43:57 -0800 (PST)
MIME-Version: 1.0
References: <20231124142617.713096-1-masahiroy@kernel.org>
In-Reply-To: <20231124142617.713096-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Dec 2023 19:43:46 +0100
Message-ID: <CANiq72kHw5gHdxcig0eHqjkPAo5rLpr+qN1+_p_2beYKfTSuHw@mail.gmail.com>
Subject: Re: [PATCH] rust: replace <linux/module.h> with <linux/export.h> in rust/exports.c
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
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

On Fri, Nov 24, 2023 at 3:26=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> <linux/export.h> is the right header to include for using
> EXPORT_SYMBOL_GPL. <linux/module.h> includes much more bloat.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to `rust-next`.

Thanks everyone!

Cheers,
Miguel
