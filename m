Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDD7D9B94
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjJ0Oik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJ0Oij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:38:39 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D241D191
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:38:36 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5859a7d6556so1839305a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698417516; x=1699022316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55I45Qtlplt+aIkb3uw3RfeEyoBtnIxw2UGzAOCPdDY=;
        b=Wc9yZqFyEFXH4zn/PSLKQ/HOqrf0AoU2UFslouG08QDJqMelIZEnrsHC02ddkxZ8uP
         8nHshG8bhaR42c6RDsFT7/zNmYgI3eEFA8jy3S1RUQ/2phKYFGN/LUBsOGXR1MTK3puc
         QNX3fQrW/PeDDcaRqbxA8/WedSrL34SjPJ+W/Y1yEz6tVcJeO9PxxUWStQxZFjf95WOs
         m0mDZPAlJ29u17K9cvcpRUBdVEtq9m3nde73g4z1NzBR2mts44iJhBCdgz8xEbAqJEcJ
         MJxC+OuHN1PITAU/SmNfNy+jV33G8ZCQJOC4e5HpsZXNcu+MC1mb0d+X3hRfd+GGgzXq
         Tj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698417516; x=1699022316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55I45Qtlplt+aIkb3uw3RfeEyoBtnIxw2UGzAOCPdDY=;
        b=ei+dz9dfsHxFtXdgUF51Qr6iCzV84IJyrKqNUKlHZ7UhAZu9fd1bt1K4pdvL3HwrTW
         Hp58yXUFeht7JckeIbuB/MTCQofzYfxqe99Ho5SBusw5HMrrGMSEevS5WXpHsVw9a8xS
         PmW+xSfPrsEaeZcDKrUzkOpc9SP/y801N02+ZhJpz9uvf28aOK6gTiRcInP9Xj2FveE5
         pFOI+uKGPTA38LPapzbrdB8WdXDNzAzKCVQR/k1Eh0Wx7Ye8WE8/t+NwEaERJLvLqBZj
         Jw+dYqJ+yvwdsd0z/B475/p3IuOJUl8x9gx6JyQf3TTzLs17m1IDgCVx4NhGOx7hE7hJ
         EYsw==
X-Gm-Message-State: AOJu0Yy/pOEnPtMihWYfL2Rv/3jNbgROHyg1VqiQ9k+wa5nf8BcFBvrd
        RBrjG72UGh6x3OGfbSpMzhVEGhH5DcrBkza7D++6ZQ==
X-Google-Smtp-Source: AGHT+IEJ07q1D5+4KgTEUidlRWDjPLhaZTGEoCul8Ylb8bU0eDcjf2kvbdOo0yKFuk4wmgeVVBFcvoZPzXSIbNI0bKk=
X-Received: by 2002:a17:90a:6e48:b0:27d:3c75:db02 with SMTP id
 s8-20020a17090a6e4800b0027d3c75db02mr2979762pjm.32.1698417516000; Fri, 27 Oct
 2023 07:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231025142820.390238-1-apatel@ventanamicro.com>
 <20231025142820.390238-2-apatel@ventanamicro.com> <87y1fo3383.ffs@tglx>
In-Reply-To: <87y1fo3383.ffs@tglx>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 27 Oct 2023 20:08:24 +0530
Message-ID: <CAK9=C2WC7N-9LgrtpfeWCT08iToqMevgvR0rkjEvdJFPzNDkMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: Don't fail in riscv_of_parent_hartid() for
 disabled HARTs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 1:29=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Oct 25 2023 at 19:58, Anup Patel wrote:
> > The riscv_of_processor_hartid() used by riscv_of_parent_hartid() fails
> > for HARTs disabled in the DT. This results in the following warning
> > thrown by the RISC-V INTC driver for the E-core on SiFive boards:
> >
> > [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/inter=
rupt-controller
> >
> > The riscv_of_parent_hartid() is only expected to read the hartid from
> > the DT so we should directly call of_get_cpu_hwid() instead of calling
>
> We should? Or maybe not?
>
> Please write precise changelogs and use imperative wording as documented
> in Documentation/process.

Sure, I will update the wording in the commit description.

Thanks,
Anup
