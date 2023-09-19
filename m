Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACF07A5CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjISIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjISIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:48:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ABCE6;
        Tue, 19 Sep 2023 01:47:56 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6930508a12.0;
        Tue, 19 Sep 2023 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695113274; x=1695718074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7pafI/HHXnkF6ezjWGXbvSL9S6lgRffcEOuOK8LK9g=;
        b=QInQeLjxXCJl4Tqq60C+nIzRDfc5/X1wLC5azajFCr1GKlllxs+cUkaIgAdW9qLwRv
         q2k+d0j+0acNi4H3pKoLTwhCD0vwvWLwgyScBVFdw9VdXp2RWOgHaNXLhdCS5ToSmUYN
         ES5KMOx1+FFlqprKlh1HxUWty/eYJPzsbq6rCpWjjq8lXGs9YoYkRLqbTTY/JoFY4SNu
         NlpG9qiRFV+bsZbNfKWr/tHpvfCt0Fqu4uWB1yLQX56NOD3LQ7NRyUJne+4ma/ZVP66e
         dOZuRcsblKou8k2SABkDPww5LFFoDuzR2zkvuy+TwD0HUys7L+VfDIBQG4FmJbnPVofw
         oQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695113274; x=1695718074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7pafI/HHXnkF6ezjWGXbvSL9S6lgRffcEOuOK8LK9g=;
        b=Yb3jisMzxKNnJpJJy8Hb7lcRmWIiIATVyRaBDvVO039VNsPVo8fHsecQM95cDPPKoX
         shLcFFO6DDhHB5+LDXjnZf75a/hfmWhI/arVVl4RunvZmKoIvpvSO6ES9IiFcfzsk842
         gxhsyIBbDfpelV2gDjIkVsbjcqJMSA/XAKo7y27vVyDqOz03vnSRyjVny7JMl1lnMxC6
         H9rq7BOiUB+mTG9+bQoIb803diDhDWYjBkLz4gJCtDXDrfDh/tVWOOJVgkbL7aWghrvR
         rzi3wLsbDXCPq7plx23CfrXcpk3RG0BqHMdoscfsICEiHjIpLC1wuhOMA2c86Zb/rbVp
         lw9A==
X-Gm-Message-State: AOJu0YzkFFmm4XLzywHZQmIZFaACytAb+gbZq6nSlWCE5ipxNhp+KeLS
        +97YZpQ2xuPn8RcT1qsazFL6j/GE98PdEDrnd3Q=
X-Google-Smtp-Source: AGHT+IEqHIB6lIOtFpj01Vh8OHCgkaU+d5Sh4uEvFtzPqGlbQAEGwZVnicpXzsWMuJuNjhXfZyOztn6chZi5j0pz2E8=
X-Received: by 2002:a50:ee0d:0:b0:52a:6497:d02b with SMTP id
 g13-20020a50ee0d000000b0052a6497d02bmr10208761eds.16.1695113274304; Tue, 19
 Sep 2023 01:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135002.6d9610da@canb.auug.org.au> <d2b5b60a-7540-5a00-5fca-9690c1db85c4@amd.com>
In-Reply-To: <d2b5b60a-7540-5a00-5fca-9690c1db85c4@amd.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 19 Sep 2023 10:47:15 +0200
Message-ID: <CAP01T74oyzNvNqMq62UvfbkER906skY=wdg9PVMbRQhMOw+1UQ@mail.gmail.com>
Subject: Re: linux-next: next-20230918: x86 build fails
To:     "Aithal, Srikanth" <sraithal@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 05:55, Aithal, Srikanth <sraithal@amd.com> wrote:
>
> Hi all,
>
> linux-next: next-20230918: x86 build fails with below error:
>
> arch/x86/net/bpf_jit_comp.c: In function =E2=80=98arch_bpf_stack_walk=E2=
=80=99:
> arch/x86/net/bpf_jit_comp.c:3022:72: error: =E2=80=98struct unwind_state=
=E2=80=99 has no
> member named =E2=80=98sp=E2=80=99; did you mean =E2=80=98bp=E2=80=99?
> 3022 |                 if (!addr || !consume_fn(cookie, (u64)addr,
> (u64)state.sp, (u64)state.bp))
> |                                                                        =
^~
> |                                                                        =
bp
> make[4]: *** [scripts/Makefile.build:243: arch/x86/net/bpf_jit_comp.o]
> Error 1
> make[3]: *** [scripts/Makefile.build:480: arch/x86/net] Error 2
>

Hi,
Thanks for the report. This has been fixed in bpf-next and the fix
should find its way into linux-next soon.
You can locally apply the fix for now to be unstuck.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=
=3D43c6e890472edf3f667579b0a671f4b3d9b2fa3d

>
>
> Thanks,
> Srikanth Aithal
