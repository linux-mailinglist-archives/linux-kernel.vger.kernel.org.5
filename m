Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307457C750A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379624AbjJLRrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379549AbjJLRre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:47:34 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4EB8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:47:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso205210466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697132849; x=1697737649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XwbTrkbxDIFSg05UbqbWKfMPoF8XcfYtFUblxKnNE4s=;
        b=VJ7nwvbV2MxMYJLoN3Sx5NCv8Jv+HnhnubmYeT6p47RU8pKp6wq6uEvYPsWn0rNLWp
         yG19VXX38sN8J8scDKwMPheII/k/WX+bmozIJlVxtUq3MNGYfcLNvm3q9k9rytueDwHD
         JKPn+if3Id8Mc4maqQO/Xz8pqPg/6hPeJziUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132849; x=1697737649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwbTrkbxDIFSg05UbqbWKfMPoF8XcfYtFUblxKnNE4s=;
        b=N9wdvPOkn3UTl5+2m1TmAn6TBYY0WzsN5URTAve7Gv92x2y3fX9goSr0NOG8tjcrvz
         jlyNuaecvs+xzQ/qeqt3bGEwYBYhijMSgpRMNJSD2x0OE3TivgYwg32N0f/JXyWehRsG
         0IBQL7KakIL2q6dXVrqqCwKkMKF2x1ECo7U1CVVr98pT26chUnxWytFZvIVyK6x+hFtH
         gh/HBkSdamZRJC76G7du8kOAXS0ik/IB2m1dJJMwrzIpEEA4nzQ0V9F/CUem/EDxROt0
         /T67FmITDBkC2ZnKh0Z7gAzech0Bq5cuMn0y65XOD8MT0zNxxFPglCkrYIo5oCP2I6hi
         Q94A==
X-Gm-Message-State: AOJu0YyveYxiIy2ayuptyiQslVMJeBf0tlfY4L47+r84Yyp6/N8MTz0D
        2X1FGqdxJHRRyGWzN+1pW3O5JWT6DYMpb0ikss86RYNS
X-Google-Smtp-Source: AGHT+IFkXPACYD6Enu8Tx6OOy1TXuQ8YmVoUNydMzehOuzGStD5uE19xRjbsQn3vp+p5Sp8ft5XZlQ==
X-Received: by 2002:a17:907:7636:b0:9ba:4163:1801 with SMTP id jy22-20020a170907763600b009ba41631801mr6955484ejc.60.1697132849443;
        Thu, 12 Oct 2023 10:47:29 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906b20800b009a1b857e3a5sm11333986ejz.54.2023.10.12.10.47.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:47:28 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo2144786a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:47:28 -0700 (PDT)
X-Received: by 2002:a17:906:191:b0:9b2:b7f2:bc7a with SMTP id
 17-20020a170906019100b009b2b7f2bc7amr25226560ejb.34.1697132848272; Thu, 12
 Oct 2023 10:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com> <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
In-Reply-To: <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Oct 2023 10:47:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com>
Message-ID: <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 at 10:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The fix seems to be a simple one-liner, ie just
>
> -       asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")       \
> +       asm(__pcpu_op2_##size(op, __percpu_arg(a[var]), "%[val]")       \

Nope. That doesn't work at all.

It turns out that we're not the only ones that didn't know about the
'a' modifier.

clang has also never heard of it in this context, and the above
one-liner results in an endless sea of errors, with

     error: invalid operand in inline asm: 'movq %gs:${1:a}, $0'

Looking around, I think it's X86AsmPrinter::PrintAsmOperand() that is
supposed to handle these things, and while it does have some handling
for 'a', the comment around it says

    case 'a': // This is an address.  Currently only 'i' and 'r' are expected.

and I think our use ends up just confusing the heck out of clang. Of
course, clang also does this:

    case 'P': // This is the operand of a call, treat specially.
        PrintPCRelImm(MI, OpNo, O);
        return false;

so clang *already* generates those 'current' accesses as PCrelative, and I see

        movq    %gs:pcpu_hot(%rip), %r13

in the generated code.

End result: clang actually generates what we want just using 'P', and
the whole "P vs a" is only a gcc thing.

Why *does* gcc do that silly thing of dropping '(%rip)' from the address, btw?

                 Linus
