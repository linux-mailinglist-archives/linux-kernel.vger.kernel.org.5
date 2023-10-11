Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89047C486C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344969AbjJKDYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345074AbjJKDX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:23:58 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CA91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:23:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-405524e6768so61425655e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696994613; x=1697599413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJ7dw6mq3fAmsxi1/7yqbTp/Tliv2AY25KGUzP1YQfM=;
        b=Wc+d/EeblpBgU2c+KR0wnTxKbzPANUC46jNxUspiSELBvxKXHXwNNjPFgrxkIEYMMs
         rcUrBqifLrhPBvQKck3ilf7SBA4tSQOGvlLHmmsUM7thssAE7EXZV4L4+2dLdAcHFFtE
         9u58mO2/czuSrMygbbB1Z0dIavAm3OlK34CnuFg5C21qXklZaWElNSTBMYY/J2oCMyW+
         /0BxzuceIJjSt4dAtk/vHU4ARovMp79aA3WtpMypTSeeNUnggkln/m1MaF7wKKdlZ2zL
         yA1w9AkK4DFLANdyy2sr/Hrt/TJXIZz2xe2RAufjR9e6GByQ70nxcO7RucmhPEVGWr/m
         uCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696994613; x=1697599413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJ7dw6mq3fAmsxi1/7yqbTp/Tliv2AY25KGUzP1YQfM=;
        b=Px+t8rjgEn2zPmygYOAwIEYPLJyTDtameX0o7IhuUAZh463D0ocPlxX7mJJmKErver
         cb25C+Lz51lihojS8YlpmHYxgEo25YugXiPWPpGzD+6+K4CheLiSNcaPNNsUwsM5VfEC
         LiDYPoqblkR4oYbeuVfBPGdzd/znUaI2S1jrYUcJlX1ubE4u/ApdQ3PiGGBWsWdSZZ5k
         wSzv1yivqlxNybAUt76SGKuRO3DROjDCNnlwVmBFQnoG36JirMyjNgEtccwttR+nQE/0
         0bm5Hroj9gD/p3eSXvsxO33sqLkSN/LaFHLjLQcphkKc4iRZF01FuEKswRGlqNBxu/Ft
         i7DQ==
X-Gm-Message-State: AOJu0YxpU+2xROCpHdKTQaGtEGhXUJUmh8R4EqRYI2ps3yTJsjikQLWk
        2E+O/tPKcvxBRCA8MvqqSpNiwNTqeXcTTe2I269qLA==
X-Google-Smtp-Source: AGHT+IFzXn41foFVeSb6zSWD3ItZskIbYaHjbVugoGL99KDVOKgkl7V8kEVpbVb+GvRZDDLiXvmlBx5bboSlUCb66Ts=
X-Received: by 2002:a05:600c:2202:b0:3f6:58ad:ed85 with SMTP id
 z2-20020a05600c220200b003f658aded85mr18338305wml.10.1696994613341; Tue, 10
 Oct 2023 20:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230912021349.28302-1-cuiyunhui@bytedance.com> <87jzsvd1xn.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87jzsvd1xn.fsf@all.your.base.are.belong.to.us>
From:   yunhui cui <cuiyunhui@bytedance.com>
Date:   Wed, 11 Oct 2023 11:23:22 +0800
Message-ID: <CAEEQ3wkBACC2SdHQZYyVoXzGhd+=wHD9Hf5gL_Yhu1dWuXAVZQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] riscv: add userland instruction dump to
 RISC-V splats
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, dave.hansen@linux.intel.com,
        elver@google.com, glider@google.com, cyphar@cyphar.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bj=C3=B6rn,

On Tue, Sep 12, 2023 at 8:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Yunhui Cui <cuiyunhui@bytedance.com> writes:
>
> > Add userland instruction dump and rename dump_kernel_instr()
> > to dump_instr().
> >
> > An example:
> > [    0.822439] Freeing unused kernel image (initmem) memory: 6916K
> > [    0.823817] Run /init as init process
> > [    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be=
18 in bb[10000+5fb000]
> > [    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gb=
d644290aa72-dirty #187
> > [    0.841373] Hardware name:  , BIOS
> > [    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 000000=
3fffcafda0
> > [    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 000000=
0000000000
> > [    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 000000=
0000000000
> > [    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 000000=
3fffcafe18
> > [    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 000000=
0000000000
> > [    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 000000=
0000000000
> > [    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 000000=
0000000000
> > [    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 000000=
0000000000
> > [    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 000000=
0000000000
> > [    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 000000=
0000000000
> > [    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
> > [    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause=
: 0000000000000002
> > [    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 =
(8053) f002
> > [    0.851016] Kernel panic - not syncing: Attempted to kill init! exit=
code=3D0x00000004
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Could u help to merge this patch into linux-next? Or can anyone help
to merge it?

Thanks=EF=BC=8C
Yunhui
