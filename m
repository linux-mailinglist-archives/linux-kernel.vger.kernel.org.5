Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9832979C173
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjILBLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjILBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:11:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C173DE9C61;
        Mon, 11 Sep 2023 17:05:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500b66f8b27so8676359e87.3;
        Mon, 11 Sep 2023 17:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694477079; x=1695081879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJwIMS70R7O4xotSYAbycvkE7LIixxz2BRpxlkaoOuQ=;
        b=C8BV1JRqYxqHAChV3nFK1KomnNYklmGkbaEoMZYJTAsAImfDBPVRq4k6SQAQyJCZkX
         T+rgQjinDmWeI8atE7x3y0Aq50ZPUS+MLXAx63ZaLrgS4eyGJv+s7ovfLFNMNIGrmF+h
         3lpnewbNJ/kZsc4bOvOJNxXr1t95CoFur8UIlgaFd0pZT2ipLkksxGuVz9uS72M5D2KG
         hwRwBJMaITd2yevT/K5jbZa2iHsvB3FUdbga+QvrPPCSoly95fnfP8vYO2e0S5MgiO5n
         PDqPi8xqSFAMnSUlp6FcjQLcx8rtFUupVKy05Mw+9YwTQRbW4IL1bLxdTniafv7gqtGI
         QR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477079; x=1695081879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJwIMS70R7O4xotSYAbycvkE7LIixxz2BRpxlkaoOuQ=;
        b=v5pKfZn2HuLx3t/wI2mspUQSAJiW+MjZRLaNBD/SusYSUrIbDggO8OMMErvms3S3/V
         juXUuj/CkQ6pusZ65oMiU+NDRhEjhDOAYTajOHhZ1bfZusXwbZkHOD6WcP0zVYkyutpe
         reS82Cz1XesjZ4HAoh9AzrsWCKH/id+DGAvWDIzvxYBZ9rh86Cylm6yXE5YEF/hXJ5CL
         GQ1OzZcekQE0SA/q3ubp9QH04urXyLzivsT722+dEk+H08VDuIh0ks0vvuC9dtAg4sDE
         iFsmh6p8ICfI8HTCtB+CcWs9eMtV5bY9yTJPdP2k9/KsJSXUHbZ5pSoEOtrTzQwPaocy
         MYVw==
X-Gm-Message-State: AOJu0YySNZifylj1F2xFeKAsQM+IoRnDk/JVGT6QFz8od9pzNFdPDDn0
        +5ZErLDLqitm/ShUczpAafa0S3TR+apbGv2SUEbpyjiI87Faig==
X-Google-Smtp-Source: AGHT+IFf2hqEyBFntRVpYOdqr6T6TV+V1ehJ8cSgQpPXcwsMJ4j+xNm6xYRtTw0/JaZaMQZr0SNrgfCVx6jkQoSCZXk=
X-Received: by 2002:a17:906:1d9:b0:9a5:a44a:86f3 with SMTP id
 25-20020a17090601d900b009a5a44a86f3mr9128275ejj.25.1694474448340; Mon, 11 Sep
 2023 16:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc> <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
In-Reply-To: <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Mon, 11 Sep 2023 19:20:12 -0400
Message-ID: <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jan Hendrik Farr <kernel@jfarr.cc>, linux-kernel@vger.kernel.org,
        systemd-devel@lists.freedesktop.org, x86@kernel.org,
        kexec@lists.infradead.org, dhowells@redhat.com,
        keyrings@vger.kernel.org, bluca@debian.org, bhelgaas@google.com,
        tglx@linutronix.de, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 7:15=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Sat Sep 9, 2023 at 7:18 PM EEST, Jan Hendrik Farr wrote:
> > Hello,
> >
> > this patch implements UKI support for kexec_file_load. It will require =
support
> > in the kexec-tools userspace utility. For testing purposes the followin=
g can be used:
> > https://github.com/Cydox/kexec-test/
> >
> > There has been discussion on this topic in an issue on GitHub that is l=
inked below
> > for reference.
> >
> >
> > Some links:
> > - Related discussion: https://github.com/systemd/systemd/issues/28538
> > - Documentation of UKIs: https://uapi-group.org/specifications/specs/un=
ified_kernel_image/
> >
> > Jan Hendrik Farr (1):
> >   x86/kexec: UKI support
> >
> >  arch/x86/include/asm/kexec-uki.h       |   7 ++
> >  arch/x86/include/asm/parse_pefile.h    |  32 +++++++
> >  arch/x86/kernel/Makefile               |   2 +
> >  arch/x86/kernel/kexec-uki.c            | 113 +++++++++++++++++++++++++
> >  arch/x86/kernel/machine_kexec_64.c     |   2 +
> >  arch/x86/kernel/parse_pefile.c         | 110 ++++++++++++++++++++++++
> >  crypto/asymmetric_keys/mscode_parser.c |   2 +-
> >  crypto/asymmetric_keys/verify_pefile.c | 110 +++---------------------
> >  crypto/asymmetric_keys/verify_pefile.h |  16 ----
> >  9 files changed, 278 insertions(+), 116 deletions(-)
> >  create mode 100644 arch/x86/include/asm/kexec-uki.h
> >  create mode 100644 arch/x86/include/asm/parse_pefile.h
> >  create mode 100644 arch/x86/kernel/kexec-uki.c
> >  create mode 100644 arch/x86/kernel/parse_pefile.c
> >
> > --
> > 2.40.1
>
> What the heck is UKI?

Unified Kernel Images. More details available here:
https://uapi-group.org/specifications/specs/unified_kernel_image/

It's a way of creating initramfs-style images as fully generic,
reproducible images that can be built server-side.

It is a requirement for creating locked down Linux devices for
appliances that can be tamper-resistant too.




--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
