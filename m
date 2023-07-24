Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8C75FCDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGXRDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGXRDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:03:52 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904A7A9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:03:51 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63cfd68086dso7214866d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690218230; x=1690823030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xTLp2+UW4g8FQgI9ZvYWnrpGeRvJJke/XOVP6Sg9EM=;
        b=gpGa803vBPmy3xYMimjz1WlnY7Ku62fvsR+af6BsD1aCsvvEdyNUhyEFAzJrRyMsJY
         xMOhN+GJss1b06bmFi8lbDVFE/+xx+KeC+coqXZ/v+nDkzoagfdirlZLzUbn0sZsb482
         Wtb0medJMSp8LsR7EyZUfCFH+eKjec+v2Iht6GL6RsBfppemdvxF2Ecu/GPespcXdVdt
         pKYCwJkArxhyu4vW3phBL4djFwcWk9zlaOKNfV0mHhXWN+x/FkqM2kjj3f2ZnBLCiUIZ
         u2jk4X9JG2YI2aBp9N0vZLTYmKvMSq2UaZv6gaFYG2raxMYBAiy1x8jno8l+/Jje17Z8
         kBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690218230; x=1690823030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xTLp2+UW4g8FQgI9ZvYWnrpGeRvJJke/XOVP6Sg9EM=;
        b=fny+7XIV0pjs5KHffKo1UulG8iDLAoW6fFZvLIIcIuoZBBIMgk9makF4Sb3ENaRCBW
         ecNxJkTXbPdYqq4VcEU7/dwnkKgIrkjFX9WL7JWjjTv1CfAs6FdzCTiC7QCc3rEoo1cQ
         SLcblnf9oLd2r3YKvuetwQYf5YuO2TsFfN7beHd8fYuyr+ENCOOGGQ/ZJJU5euC0qpjJ
         ls3rQEY1IQITz5jzFvcxRM4Z9Px54mF4KbpXBMk3FhPFZJMIhMX/seQ2pcVQCW7Gov6K
         MxSvSx04hWoubjzr4ipkiLQEL7U6NqxvoykaBtvXtjSj03tUFJfWS89xRKmbpwrc958F
         bRaA==
X-Gm-Message-State: ABy/qLZmbwK2g1ciHZZbG2NIcpgnENpKUD8eIsa+MpvRwIo1lIdX4wsI
        iU5PN4CNXoT0GNySv+NCdD8o8eeVF6gOSU1TLcse5FCmV4j/vTJuyE7eJA==
X-Google-Smtp-Source: APBJJlEnO5lejCzbyCaztVTOmKeDnXswtgvMcSvSSH9+fMOwbn/xmDGfc9PRT8MCPp3isU5yXTN/OJi7P19hPG7CgVs=
X-Received: by 2002:a0c:df0a:0:b0:635:e680:99b with SMTP id
 g10-20020a0cdf0a000000b00635e680099bmr364128qvl.36.1690218230579; Mon, 24 Jul
 2023 10:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221124094845.1907443-1-debug@rivosinc.com> <CAJF2gTT_-_Q2hQWWbt=CiUV4a3xq4Cw3s9A308KfTx0i55WSuw@mail.gmail.com>
In-Reply-To: <CAJF2gTT_-_Q2hQWWbt=CiUV4a3xq4Cw3s9A308KfTx0i55WSuw@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 24 Jul 2023 10:03:14 -0700
Message-ID: <CABCJKufYj6E8WagP5GyB3M_=WfA4H0d=MMxX6+DQg0F8qjNTcQ@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: VMAP_STACK overflow detection thread-safe
To:     Guo Ren <guoren@kernel.org>
Cc:     Deepak Gupta <debug@rivosinc.com>, palmer@dabbelt.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 8:10=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Nov 24, 2022 at 5:48=E2=80=AFPM Deepak Gupta <debug@rivosinc.com>=
 wrote:
> > +.macro asm_per_cpu dst sym tmp
> > +       REG_L \tmp, TASK_TI_CPU_NUM(tp)
> > +       slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
> > +       la    \dst, __per_cpu_offset
> > +       add   \dst, \dst, \tmp
> > +       REG_L \tmp, 0(\dst)
> > +       la    \dst, \sym
> > +       add   \dst, \dst, \tmp
> > +.endm
> It's a tricky implementation, and we can't maintain it here because it
> depends on percpu design.

I can certainly understand this concern, but AFAICT this part of the
percpu code hasn't changed in ~14 years, so adding an assembly macro
for the computation shouldn't be a huge maintenance burden. arm64 also
performs a similar computation in assembly (starting with commit
3d8c1a013d78) and I don't see their implementation needing constant
maintenance since then.

Sami
