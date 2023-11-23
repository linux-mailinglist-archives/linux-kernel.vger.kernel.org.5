Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DB77F5C94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjKWKit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjKWKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:38:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF211BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:38:49 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso453169a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1700735929; x=1701340729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtWJos9eJonIZMcnZ3qHTztIEX4OrKTTJCiVLASavc8=;
        b=aOKUW6W3A21AW5tgv3wI8uMaVtT978Cb3hBUE9XwGdR/FgGQDXCGGbT7xmqkcAMz+G
         ho5YICq+hTXHgZqv6rKyFcGuDgnXx/lx2OhbPDOsK94KqOgnLwSTy21fjeNoCcfymiHv
         IJ5q7QNg5r52oom0EjOUx27RgbKV2FFSYkjRR0Lcxqa9t5yNK28QI17tqCfNk373VhEY
         ZUqVoYG5BttKcNqO2zlegzryfaSeNKjLxyeuE18fsoQkYoeJhqRY/fB/nQvqJOLPfcW8
         I7ZUg+a2MhdH19owXHXPNrXjQfMnpemB13BY65+Ep5gc5S6lyQ3ZzqU/HCGwowrAZpqS
         xQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700735929; x=1701340729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JtWJos9eJonIZMcnZ3qHTztIEX4OrKTTJCiVLASavc8=;
        b=W0fgHE0iJGbTqQyw9q+GYymmftPVOLFK7fL0ke00A1m2B3CW97a3agI7Z/Hk+/rwEQ
         dQ1EKhxNO6VNbt8w0IhyKKnPzPUNbpX9YKxLoqRMwPuVvfmt5wUcAjncEwvVNn081Mn/
         Gz4eaMOaHUTIoVxDwl5APLoy3ZPXVY/ORsDvtksCuOFyaNP1U4LRBYu6Mu3RNwp+fShb
         0zL82RNWD+9vej9kEo64UqJyeg5nwLehm4dATM7+ZNb3SK+bCnU8C7OFKovuZiWtgHkp
         /1INHhlBBWGdCNQFOtOcS/WkwGjKMH6fE/m2Ucb82GpKvH4oX5rWjCy0Li1DeiuqB+VY
         BGMg==
X-Gm-Message-State: AOJu0YwTH/6t2JbYv+4c8+QNAYgM+GCCx87dg+cfgF934jA4RwzDOpvJ
        EZRCFsmXdlewWsyHAY75vMmR8G/fnPwFFSnPJKjpHA==
X-Google-Smtp-Source: AGHT+IHvryOzXWmfb9qEZWfYxLmtqn4CX5rtr/8r6s4TMLtNZgUWu2Uht2WYKwskvoiWScCKfk/YfcsxnyZ6UyDhj40=
X-Received: by 2002:a05:6a20:be9c:b0:187:200a:713f with SMTP id
 gf28-20020a056a20be9c00b00187200a713fmr3721171pzb.23.1700735928664; Thu, 23
 Nov 2023 02:38:48 -0800 (PST)
MIME-Version: 1.0
References: <20231118033859.726692-1-apatel@ventanamicro.com>
 <20231118033859.726692-2-apatel@ventanamicro.com> <70ff59ea-378c-4d53-899a-eafffcad22fd@sifive.com>
In-Reply-To: <70ff59ea-378c-4d53-899a-eafffcad22fd@sifive.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 23 Nov 2023 16:08:36 +0530
Message-ID: <CAK9=C2U9aJDDd0JUhRqyLCF3dfyY5QBUrgyH+PKsT+pUKiB1xQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 4:06=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Anup,
>
> On 2023-11-17 9:38 PM, Anup Patel wrote:
> > The functions sbi_console_putchar() and sbi_console_getchar() are
> > not defined when CONFIG_RISCV_SBI_V01 is disabled so let us add
> > stub of these functions to avoid "#ifdef" on user side.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.=
h
> > index 0892f4421bc4..66f3933c14f6 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -271,8 +271,13 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned=
 long arg0,
> >                       unsigned long arg3, unsigned long arg4,
> >                       unsigned long arg5);
> >
> > +#ifdef CONFIG_RISCV_SBI_V01
> >  void sbi_console_putchar(int ch);
> >  int sbi_console_getchar(void);
> > +#else
> > +static inline void sbi_console_putchar(int ch) { }
> > +static inline int sbi_console_getchar(void) { return -ENOENT; }
>
> "The SBI call returns the byte on success, or -1 for failure."
>
> So -ENOENT is not really an appropriate value to return here.

Actually, I had -1 over here previously but based on GregKH's
suggestion, we are now returning proper Linux error code here.

Also, all users of sbi_console_getchar() onlyl expect a negative
value upon error so better to return proper Linux error code.

>
> Regards,
> Samuel
>
> > +#endif
> >  long sbi_get_mvendorid(void);
> >  long sbi_get_marchid(void);
> >  long sbi_get_mimpid(void);
>

Regards,
Anup
