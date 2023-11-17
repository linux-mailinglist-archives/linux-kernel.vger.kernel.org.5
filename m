Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC4C7EF353
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjKQNEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjKQNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:04:45 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3349D6A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:04:39 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5be30d543c4so1457830a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1700226279; x=1700831079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/F1OxU0rX7/2Awza+ieBvlQ9jwzfprHoNUntAoYQeA=;
        b=kq4p4qNsyI5PD1CWUJKQNHfxMljXlGi3/T9UBSLCkuM4zPv8MVAw/NlBJ86UtAbPBo
         jLyYmHJbetcKRIedfu1eoG28XPQwPt7G0qRGKp4JtlDfsW5zFFU5dfPmWPlzqzAATUcK
         bbhw3j+IFpZzcuoGv8tp9B/qGu4UFwLiOEht/UxsYfPqPWPDZXRoMN21XLsDmwFaxfNv
         Dddk78IkA44IqMLir3JJQLNEUjpGh4Za80ylBnwTF7LdEM4Oympco+oDWQvqrDSHGBDf
         xs07FhYP+9hrZE9d++y7sJ2gpmjdtp5UQvOrNspWF5kzMIehciWTqYX2vPs7gQZBw5SA
         Rjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226279; x=1700831079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/F1OxU0rX7/2Awza+ieBvlQ9jwzfprHoNUntAoYQeA=;
        b=eJPzD+2xmHiVZB4rK5TK44ippg48fytrRzPYIg4nzr95XQPyFYzkl9Thz7A7qAGkqw
         P7IWOiFNp0+LupIOEhpTQII6QgKhuuekfLPYC6CAP422PjhEkna3dacF8c5IRnssFKFf
         0oIy19pB184ep4Uv/SeIXKG5ErnR0hJ6KyM2CEblzWKh4QlC8MnrHi9kTeYaNTt1yD4j
         8WkYo3ZXnMFZTarV2dnIPOaYikQyM/4pDBsA03QVbdMIxOI79//eY4LCNZJR3cZPpLs5
         82QnH0MSjHjVuQK20wCSBdWAGMf2j8kAfy6ivcC6cReMKDgr99j+KY99K7tsquuAnm5L
         qohA==
X-Gm-Message-State: AOJu0Yzj1vVWM3QuTCQFLCqLt3l1wLsWwH8ZRf5pxP4bzieiBty0J7en
        /smWsP6Qx/yge5APwkINIFGiYO3WagXHhscdnm9r8Q==
X-Google-Smtp-Source: AGHT+IEtPzE7lEOx2d7Ysp4LwrL/GBmShcmNUU9lJo3FtmpAf6sriMDVi9emlG1mMx8Yan2mKYsw1q3eMsjqCt3Pm70=
X-Received: by 2002:a17:90b:3904:b0:274:8949:d834 with SMTP id
 ob4-20020a17090b390400b002748949d834mr13014202pjb.49.1700226278671; Fri, 17
 Nov 2023 05:04:38 -0800 (PST)
MIME-Version: 1.0
References: <20231020072140.900967-1-apatel@ventanamicro.com>
 <20231020072140.900967-7-apatel@ventanamicro.com> <2023102113-harsh-trout-be8f@gregkh>
In-Reply-To: <2023102113-harsh-trout-be8f@gregkh>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 17 Nov 2023 18:34:27 +0530
Message-ID: <CAAhSdy1Beq-Qnio3E+Am0jVQ7ECaWa1HH2A1JkWRPN5y8tsgAQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] RISC-V: Add stubs for sbi_console_putchar/getchar()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 10:05=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 20, 2023 at 12:51:37PM +0530, Anup Patel wrote:
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
> > index 12dfda6bb924..cbcefa344417 100644
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
> > +static inline int sbi_console_getchar(void) { return -1; }
>
> Why not return a real error, "-1" isn't that :)

As-per SBI spec, the legacy sbi_console_getchar() returns
-1 upon failure hence the code.

Refer, section 5.3 of the latest SBI spec
https://github.com/riscv-non-isa/riscv-sbi-doc/releases/download/commit-fe4=
562532a9cc57e5743b6466946c5e5c98c73ca/riscv-sbi.pdf

Although, the users of this function only expect a negative
value upon failure so better to return proper error code here.

I will update.

>
> thanks,
>
> greg k-h
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

Regards,
Anup
