Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0CE7C8B9D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjJMQjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjJMQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58EDC
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:01 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53db3811d8fso4682065a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697215139; x=1697819939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DusE41HCZYYOq6cvLQapgn6LNZ8b2XM66rg5HL3Un08=;
        b=XD9i1GsA+QBYeT85JXXUGdhCfhLPaWJqYfHiQ43m5dpO6dsoUqHAxVcrKzgOVV9JND
         BIr+UVws5TVINE+xKF05PvmYmQl9IZWYDVOt6y0jbUcaHqrb6XpDUyX0fb1F3AEnDlYC
         5Ibw+SZAHM5/5g4SAdUeAckQYo0WbOTPbaOBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697215139; x=1697819939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DusE41HCZYYOq6cvLQapgn6LNZ8b2XM66rg5HL3Un08=;
        b=ITkTC081GQZcyto1GCkX0Eqv7rA3obRIkP1WHGB/o0a8RGQP0yaGW9ePa5OfK3eraX
         4ASpv2+cTYLgFNDl0o7KTdZFif7d/GWCnFfdf49FUT1c/d4S6R4Mk1invTvkfH5dRBWm
         7SkjFyl9ke5GDoMgQjT5f1BAg5H1Ek/BK56Mws2ECdDRlyc2N99LkeiyYg79Jntx+0aX
         CAL6TA/y8oLf1bwAeFXQExTaJefRu1ZuOcsr/LmDMXtGrHgTltPU4iv85z83daWScetB
         ZWOCSj7tL4ddLei58QWK6PfDvxeOMpzIyFskp+wIAVlwdMR8HkX+PSDKYW3dR7oBlqOS
         qdNA==
X-Gm-Message-State: AOJu0YyU7PizvRjZK6EJhumzr4uIYyso6HX8+EL38fhqq+XWSFdTHQFC
        VT5n+p6lLA5j9P2Y1UdS5QgggM3vdRcCAstyfNGYdg==
X-Google-Smtp-Source: AGHT+IFiXIldoLnYnc735weMfGEdmBPsiJo0vdrw7HsuK7Kk3i6+rHpB6vDiHUbDeR2RjG8aCIMxTQ==
X-Received: by 2002:a50:ccdb:0:b0:53d:a18d:73b4 with SMTP id b27-20020a50ccdb000000b0053da18d73b4mr609466edj.12.1697215139429;
        Fri, 13 Oct 2023 09:38:59 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id w22-20020aa7dcd6000000b00536e03f62bcsm11730560edu.59.2023.10.13.09.38.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 09:38:57 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9ae7383b7ecso726363066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:38:57 -0700 (PDT)
X-Received: by 2002:a17:906:7949:b0:9a5:c38d:6b75 with SMTP id
 l9-20020a170906794900b009a5c38d6b75mr607299ejo.15.1697215136941; Fri, 13 Oct
 2023 09:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
 <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com>
 <CAHk-=wgUwPruc3MP6=vode2SawVpNgb8-szV1HYoc6E1wAaw=w@mail.gmail.com>
 <CAHk-=whzhXdRz1UNaQWTSY2ue8biGqfS18VXcEQasQNCyg_AwQ@mail.gmail.com>
 <CAFULd4ZdfUQszrp6hKzKXosj0-yzizx+-4BZG7SzEpZPCdUFuA@mail.gmail.com>
 <CAFULd4Y5JocT9yRwS0Zkro-pAHihmOHP2D8fMLR29j8_Gy_nNA@mail.gmail.com> <CAFULd4ZfdWchq9nAQ-YGoaS9OjM-=4Lnd5YbDmrUipbtRgDdTg@mail.gmail.com>
In-Reply-To: <CAFULd4ZfdWchq9nAQ-YGoaS9OjM-=4Lnd5YbDmrUipbtRgDdTg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Oct 2023 09:38:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTfDNK9bt24Ton_=Tw6pYYhr5FSei5Wx3MjDJKDcxGcA@mail.gmail.com>
Message-ID: <CAHk-=whTfDNK9bt24Ton_=Tw6pYYhr5FSei5Wx3MjDJKDcxGcA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 04:53, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Maybe we should go with what Clang expects. %a with "i" constraint is
> also what GCC handles, because
>
> =E2=80=98i=E2=80=99: An immediate integer operand (one with constant valu=
e) is
> allowed. This includes symbolic constants whose values will be known
> only at assembly time or later.

This looks fine to me, and would seem to be the simplest way to have
both gcc and clang be happy with things.

All these uses seem to be immediate addresses, as any actual dynamic
ones will use a proper "m" constraint (and no operand modifiers)

               Linus
