Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6E77CB4FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjJPVAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPVAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:00:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25F1B0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:00:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so126369166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697490003; x=1698094803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoMScRfK8cWUdYKqO6aPdGhvxLOi2B22QQaZqfT/07A=;
        b=IcaGIYIefiuGySjjUruDRr9FBID8JBRT2VKYN0Y9Dzh72VOuyVHja5tx0Gi0cTcTer
         JxKD9W/QsbOse7xhVOiOQGiB9VQv0PCE1hTEX9WhsgKvnCiNgRqN/C8XQLkYGABGsW1f
         XspgLaa40PEJy6uwf18d6f4IuCdRKXlMJtUHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697490003; x=1698094803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoMScRfK8cWUdYKqO6aPdGhvxLOi2B22QQaZqfT/07A=;
        b=W9mbhDoZ7T1dfvkBnhUwom49Kx/TKZE4JTOX9d8a2IBohKy7yhJOn+JBm5UHt/4mKO
         9gLEvh3NWN24TJy5L6nCnSQZCa91FNgi6kuusGcMDqKp5sajea590REXFEjnxQTUfB++
         lDzJiyKe4rIWumXR8xhZhfMQ3X8w4TGHLrxAvKXRGARpyNY0rq/v3DYirgOP0uC/N9PV
         25y34Ng/PF7Xu5FCZnWW38lmBjx4jMA1s8JyjujwmPzEiGl0n3zJzQhuPR6lOUJm5z04
         6tJ4asCp76jOGOtmsk7UORzSdXS4K6g5z3v/VLowuoBkHTMI7W04ODK1kBABtcSqjWIS
         RQ2A==
X-Gm-Message-State: AOJu0Yyqpd3ZQLJ1X4dyFCk9ggAKIIeUhzCvSREaatUEGKWsbWH4gzE6
        4iID4pjZxGkBckYR0t0ePiR79b3tWdD/1uQSvWpDBmyr
X-Google-Smtp-Source: AGHT+IFUek/F0mZmYw6dR7jnQWRoPKBkfi6gJRmoGaiI6hRIIyF9xIljI0IKvFEM1lpHIr0R076dhw==
X-Received: by 2002:a17:907:a08:b0:9a2:ecd:d963 with SMTP id bb8-20020a1709070a0800b009a20ecdd963mr141972ejc.44.1697490002985;
        Mon, 16 Oct 2023 14:00:02 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id mm12-20020a170906cc4c00b0098951bb4dc3sm4672301ejb.184.2023.10.16.14.00.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 14:00:01 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso6315497a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 14:00:01 -0700 (PDT)
X-Received: by 2002:a17:907:706:b0:9b2:b95e:3825 with SMTP id
 xb6-20020a170907070600b009b2b95e3825mr155914ejb.39.1697490001479; Mon, 16 Oct
 2023 14:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com> <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
In-Reply-To: <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Oct 2023 13:59:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=wC_QWn+mTB5KozH6QaCtG2P8oWSTmhum_JR9NVh+=A@mail.gmail.com>
Message-ID: <CAHk-=wj=wC_QWn+mTB5KozH6QaCtG2P8oWSTmhum_JR9NVh+=A@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Uros Bizjak <ubizjak@gmail.com>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 13:35, Nadav Amit <namit@vmware.com> wrote:
>
> I don=E2=80=99t think it means that it the aliasing does not work; I thin=
k it all means that
> it actually works *too well*.

Hmm. The *only* case I can think of is __switch_to() itself when doing that

        raw_cpu_write(pcpu_hot.current_task, next_p);

and arguably that part should never have been done in C at all, but here we=
 are.

I do think that from a sanity standpoint, it would be good to split
"__switch_to()" into two: a "before stack switch" and "after stack
switch", and change 'current' from within the asm section (ie do that
part in __switch_to_asm").

Or maybe we should just keep the single "__switch_to()" function, but
make it clear that it happens *after* current has been changed (and
maybe rename it to 'funish_switch_to()" or something like that to make
it clearer).

Because the situation with __switch_to() right now is outright
confusing, where it has 'prevp' and 'nextp', but then implicitly uses
'current' in two different ways.

Ugh.

               Linus
