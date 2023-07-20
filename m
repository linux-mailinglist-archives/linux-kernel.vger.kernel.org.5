Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9AB75B708
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjGTSnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGTSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:42:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBAB272E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:42:52 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-576a9507a9bso33645617b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689878571; x=1690483371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bq95Q7U+QOIKz0vHUb4d1FI2vT9hkM28X99pRDYL0qE=;
        b=uIUVfXxTgi0P2U/RLVJMCpurhtZ6gDjcode14GccHcTlX3nzGBTmyF3gKAYRe3fN/h
         +MFkDo3sV6KWULrSEsolNQNp5cKlH2HQzmTyiowklcYRdwn4fAruoCuL8RlfqQuKY2Wu
         cOGrdawBqhhImFQbb1mhzxIiHDXMk5EtXQ/xaT1tS9W9u/C49qUTUmsEfy2FFpw98o+1
         C5PHGFfAv+B3kJtULC9JMx/Esox5hL6A1fV4AcODXUAHS38CGVyNmAWc3Ezu91QJC404
         t4mzg7MhslWGAW/gJNcGbgjiKCiciP7OberHA9W+LC44+cxgzkADef56+dfdnknBWXq2
         U3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878571; x=1690483371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bq95Q7U+QOIKz0vHUb4d1FI2vT9hkM28X99pRDYL0qE=;
        b=Fmeti8diDmkRESUwVX+Of7vErCs+dA7T/TZ5w6tKVqb/cTJKsnV4iYQDltzQffx8hM
         kcEoPgnS+xem5+ArfDhIvgStqy+Q2Vs2L54KUpQge6sGBeU+E1QI/gcy3MWBulinZ+Pj
         iNErAlwi0xfIZUtORo1DdXfKupGwaU22+Dr7n1msbpg7iRAyhprD/2iv/TejIq3cAEoS
         CvurX2HDXnzbbp59VTXIVkdsj0VY1W0tz/NFLKWA7BCVZMR5uhWzd1Pu85/BhBMxP0tq
         qwsFsBZJbQpNY75wRGfiq20QoFcAnnpO2SkBAMakRZU0MlWwxN844ZQES1csraWKcqw2
         6zFg==
X-Gm-Message-State: ABy/qLZs2oJ4YIUomLKtiRwXBL9dTqgj669eusagFS+vdytm/PSKq8EA
        RdVjZCm9/0sQSKhSTFzkyC4hA+AIFr/ErxR7ez+NAw==
X-Google-Smtp-Source: APBJJlHh9Zacubk9eW8d7gwMS8CGEipLyQbrEEtuDSDftVQe8IiowHox7x4OmRjdAClXYuJk3ZSgA0znuoBMUQ8r7CE=
X-Received: by 2002:a0d:e64a:0:b0:56c:ffe4:4ca5 with SMTP id
 p71-20020a0de64a000000b0056cffe44ca5mr6641722ywe.10.1689878570912; Thu, 20
 Jul 2023 11:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221124094845.1907443-1-debug@rivosinc.com> <20230720001852.GA572618@google.com>
 <CAKC1njSaR2d-T_UnVJDZYbROT5OLEjBJ+Aps-UHPFTefDc8=6g@mail.gmail.com>
In-Reply-To: <CAKC1njSaR2d-T_UnVJDZYbROT5OLEjBJ+Aps-UHPFTefDc8=6g@mail.gmail.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Thu, 20 Jul 2023 11:42:38 -0700
Message-ID: <CAKC1njTb4=mnvNzvwU-afQvXbr+i-BzJBtp-tO91cEFh2QN6Vw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     palmer@dabbelt.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 11:38=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> On Wed, Jul 19, 2023 at 5:18=E2=80=AFPM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
>>
>> Hi Deepak,
>>
>> On Thu, Nov 24, 2022 at 01:48:45AM -0800, Deepak Gupta wrote:
>> > commit 31da94c25aea ("riscv: add VMAP_STACK overflow detection") added
>> > support for CONFIG_VMAP_STACK. If overflow is detected, CPU switches t=
o
>> > `shadow_stack` temporarily before switching finally to per-cpu
>> > `overflow_stack`.
>> >
>> > If two CPUs/harts are racing and end up in over flowing kernel stack, =
one
>> > or both will end up corrupting each other state because `shadow_stack`=
 is
>> > not per-cpu. This patch optimizes per-cpu overflow stack switch by
>> > directly picking per-cpu `overflow_stack` and gets rid of `shadow_stac=
k`.
>>
>> Are you planning on resending this patch? I see it didn't gain much
>> traction last time, but this looks like a much cleaner solution for
>> selecting the overflow stack than having a `shadow_stack` and calling
>> to C to compute the per-CPU offset. The asm_per_cpu macro also would
>> come in handy when implementing CONFIG_SHADOW_CALL_STACK, which we'd
>> like to have on RISC-V too.
>
>
> I personally like the approach of using percpu because I found it cleaner=
 and easy to maintain.
>
> There wasn't any willingness to accept that patch because list members / =
maintainers thought the best way to fix an error prone mechanism is
> to introduce another clunky mechanism which is difficult to maintain. So =
no plan on resending that patch.
>
> If there is motivation to use the asm_per_cpu macro for other stuff, plea=
se feel free to use it from my patch.
> I believe it will be handy.
>
> If there is motivation to accept this patch on the list or provide sugges=
tions on this patch, I can resend it.

Sorry for the last html formatted email.
Somehow settings in my gmail got reset and plaintext mode was set to html a=
gain.

>
> -Deepak
>
>
>
>>
>>
>> Sami
