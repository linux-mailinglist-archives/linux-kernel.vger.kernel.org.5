Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6003784B93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjHVUod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjHVUoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:44:32 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A0F113
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:44:30 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-64aaf3c16c2so29100926d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692737070; x=1693341870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIY4BW1aShtZa8JhSL2vZaOBbImwOM8Yqv8lPXle2d4=;
        b=RcPLdSE9Ac5lJwP/U4M8b9GIeQR6l6KExTMV2aSQQE77I77CnilBs59Wkshg1gVvA3
         JABSuD0Lg7N6cjRi40QQsmrh25uU+nVjapA4oAfyHkGQlIUZZIhTkOUExuCxEWSYzYpY
         Xvk819cryQL2TlWiG2i59IVhQrhtMuaYxtaEY4EdELY3NUAXWIKpgR3gvNALmqILReMF
         qIrn9K5gEMmiBN1DjtuIszZoRtEPHo96H/+E0cUg/J2nKaW4XYfXwDiIuMe2hv60UANq
         0Qvr3ZG/IdnO0/flDup/x+Tlur1UAXnClfrFi+f5JgiinlK6+oFkKOp44oOSxx3UZ1Bw
         BJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692737070; x=1693341870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SIY4BW1aShtZa8JhSL2vZaOBbImwOM8Yqv8lPXle2d4=;
        b=PoIU5cegqfCNxNBHATA4RChFmPwW0xPQk3+zN7VZoNSK6Qq7JEMlNoYG828yjV0lx5
         QYwYv98CrVrxf7OLQI9WFGttys3EfqyEn/1vKkEWUyXHW7lViIVZAUg50JC6qKnUAJck
         kFksPtsCWM4efu1bL4q0NI2CpKsymWdCK5ESv3REhz92eovdJ1SAcH2SKwxM1KMKM7rV
         FHMWMOREGU/5UOmaFemnjpOk9a706MGrHoylZQ5LOg+8BENqPw0Orayq6lzj9IqyiAIs
         4dkyFAE6Iz7pQGbf1T2Gfk9LuX3Z9jVHOpAi8mW9HAdtaMUQNw2A2P/FdBDY2wcdcBTA
         5Rxw==
X-Gm-Message-State: AOJu0YwjbvgxwmXOWI7ll/o73QMSjp5W5e8ZLJGadZz2ts1J/tB6zGCb
        48EwIshObuwH+KfnLq4qbH0wm537sAwFMq0Ga8tKZQ==
X-Google-Smtp-Source: AGHT+IEItiIS99pEWxLjSoVieTI8R1IXYPDlmg+/E07xYdBbSqpqBuMdrVaREPubfqFIjetTFi9B9cliBbZ4ltM2+GM=
X-Received: by 2002:ad4:4bb2:0:b0:647:2a0e:573f with SMTP id
 i18-20020ad44bb2000000b006472a0e573fmr11695239qvw.8.1692737069673; Tue, 22
 Aug 2023 13:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
In-Reply-To: <CAFhGd8ryUcu2yPC+dFyDKNuVFHxT-=iayG+n2iErotBxgd0FVw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Aug 2023 13:44:16 -0700
Message-ID: <CAKwvOd=p_7gWwBnR_RHUPukkG1A25GQy6iOnX_eih7u65u=oxw@mail.gmail.com>
Subject: Re: selftests: hid: trouble building with clang due to missing header
To:     Justin Stitt <justinstitt@google.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@google.com>
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

+ Ben, author of commit dbb60c8a26da ("selftests: add tests for the
HID-bpf initial implementation")

On Tue, Aug 22, 2023 at 1:34=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi, I'd like to get some help with building the kselftest target.
>
> I am running into some warnings within the hid tree:
> | progs/hid_bpf_helpers.h:9:38: error: declaration of 'struct
> hid_bpf_ctx' will \
> |       not be visible outside of this function [-Werror,-Wvisibility]
> |     9 | extern __u8 *hid_bpf_get_data(struct hid_bpf_ctx *ctx,
> |       |                                      ^
> | progs/hid.c:23:35: error: incompatible pointer types passing 'struct
> hid_bpf_ctx *' \
> |       to parameter of type 'struct hid_bpf_ctx *'
> [-Werror,-Wincompatible-pointer-types]
> |    23 |         __u8 *rw_data =3D hid_bpf_get_data(hid_ctx, 0 /*
> offset */, 3 /* size */);
>
> This warning, amongst others, is due to some symbol not being included.
> In this case, `struct hid_bpf_ctx` is not being defined anywhere that I
> can see inside of the testing tree itself.
>
> Instead, `struct hid_bpf_ctx` is defined and implemented at
> `include/linux/hid_bpf.h`. AFAIK, I cannot just include this header as
> the tools directory is a separate entity from kbuild and these tests are
> meant to be built/ran without relying on kernel headers. Am I correct in
> this assumption? At any rate, the include itself doesn't work. How can I
> properly include this struct definition and fix the warning(s)?
>
> Please note that we cannot just forward declare the struct as it is
> being dereferenced and would then yield a completely different
> error/warning for an incomplete type. We need the entire implementation
> for the struct included.
>
> Other symbols also defined in `include/linux/hid_bpf.h` that we need are
> `struct hid_report_type` and `HID_BPF_FLAG...`
>
> Here's the invocation I am running to build kselftest:
> `$ make LLVM=3D1 ARCH=3Dx86_64 mrproper headers && make LLVM=3D1 ARCH=3Dx=
86_64
> -j128 V=3D1 -C tools/testing/selftests`
>
> If anyone is currently getting clean builds of kselftest with clang,
> what invocation works for you?
>
>
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> Full-build-log:
> https://gist.github.com/JustinStitt/b217f6e47c1d762e5e1cc6c3532f1bbb
> (V=3D1)
>
> Thanks.
> Justin



--=20
Thanks,
~Nick Desaulniers
