Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB937D2494
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjJVQa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjJVQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:30:56 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6BC135;
        Sun, 22 Oct 2023 09:30:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7be88e9ccso26354437b3.2;
        Sun, 22 Oct 2023 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697992254; x=1698597054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABn/n+8mmup9EXD/zAYttFkzLIK8/Nr+mSKJhZ5ZCv0=;
        b=jDMgq8AeNsg7PYdr7bTzY/JIWIy3hOd2ImX0MVw83aJ5YYjvwuJd7hzHzqVRVM9AxO
         DA7aUzeOqKUJuqCO3N1xhbiQnO9LB6EbiQaVpEqsxH6gYoUgarqWr2IqGcfSnNDtoaok
         T8uHX7ivzzcT36PMmKHJ9amLTGud8g2y744/J8c7vuqDnpEMQer0PfJeo3lQtYWzZTAs
         B8XAqmOTHxQSSVf19CnEx7oTuq8TztjP9/UI8974GXCtDtQCQZZmljRcJvByLOJxSbcw
         Zz/qAJMKRk5ExT9GYo7K+E5eAB5Hc5MtnsKOVvkrZr5/qcELR6CXtenwhzeqDp+reO6D
         WWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697992254; x=1698597054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABn/n+8mmup9EXD/zAYttFkzLIK8/Nr+mSKJhZ5ZCv0=;
        b=R5k5ByRMi/77hheIaQulnyLW2njLW940zUvCRM646yWOFxbRYQz8xpVKmaGHACYZeq
         IIqk9e0e602dM94L364e2pe0vFIHrCW9+PNm3OvHhTQh3XgBQXWYRpl01+CwJQvSzRoV
         2vimA1OdyqPMpS4iY+ijsozbInqECaooDSSJAJUUdDYl8QeWzHhw+5Lby2zaGAwVeiH7
         FjIKM2E09xTmkv0iyun1JKr6ueE6JAyoM3uZlE0mJRFuM+5myK2eB3GiMxVZuaFpnCG5
         EtB4H5Ytv0DFdnHnrerfC7yd9QMN1cX4FugCwMMzZ/cjxphzYqlHFdUwshH5DjyDEqxH
         zeTg==
X-Gm-Message-State: AOJu0YzRkzcHiw5WWflxw5+dsOZ0lBX6dIbhZg2c2astMTEVQtIH3Y4L
        Q02DNpvB9iG1zXAacZpW87vpiNefl9YZO+CAoUw=
X-Google-Smtp-Source: AGHT+IEvRijoap0xQAKUpEH23qyv597Q3XJ39xgXEx10SClDSdTuyOSsBZvCAhVsHIc2RG4GfCdW+wNMH8BbqgSHd6A=
X-Received: by 2002:a0d:ea91:0:b0:5a7:aa7b:cb9f with SMTP id
 t139-20020a0dea91000000b005a7aa7bcb9fmr7674024ywe.14.1697992253997; Sun, 22
 Oct 2023 09:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231006155739.246381-1-yakoyoku@gmail.com> <20231006155739.246381-2-yakoyoku@gmail.com>
 <CAK7LNAQhPRkSpBQcn44dPMmnBVR=aTxMpG3vS4-=FkgQ5T2PVQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQhPRkSpBQcn44dPMmnBVR=aTxMpG3vS4-=FkgQ5T2PVQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 22 Oct 2023 18:30:43 +0200
Message-ID: <CANiq72na6KoYPKoCYpv9Jyih0M7Z742+XiYUP=T5C6YsmdgNaw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] scripts: Build per module Rust crates
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 6:22=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> I could not understand how this will work because
> there is no explanation how to use *.rlib in the later
> build steps.

It seems linux-kbuild was not Cc'd in the cover letter -- I replied to
Martin there: https://lore.kernel.org/rust-for-linux/20231006155739.246381-=
1-yakoyoku@gmail.com/

Cheers,
Miguel
