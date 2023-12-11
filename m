Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD0080DBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 21:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbjLKUrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 15:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbjLKUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 15:47:50 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9731DB5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:47:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3332e351670so4524339f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702327675; x=1702932475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNFFKTdQ4QRGU3jiDsgZw6qRsjpUS+kZ+xjPJ/qMrTI=;
        b=EnBLlceTcSSyp37RP4ztHPHpitRX0yRJR5QhD3ot4GsLp+g+f/8eNOOeswU1ZSKGDZ
         piCx9vSg4FtLvebqSTp/N9SczyhTK69RfXM+8ksmJaGy/cvm7rEEN8YG/37/3B3Y+XSU
         TUl/QBtllRecfzYUi1AVR5KfmMedrdn1TEha/0pSa6ucKPvl42jxqF/nOWRa9RwawmTf
         gfPSxJJQ8l1X6VbuzYuN2C9FbEC7NX1f7+I5QdzDsnQQrfC6vBv4le3SbnKovWfupGqh
         jt6/UqNifdK/wgP/OG4efIotAD88WxVJbLvmA8ysXUbVe7ZCw0rCZTg4/3uhl0gYOA6+
         7AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327675; x=1702932475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNFFKTdQ4QRGU3jiDsgZw6qRsjpUS+kZ+xjPJ/qMrTI=;
        b=dedNdDwwycEedILgCAwMkOQETvGDGqyLQQ6y95V1IrQ0TesAKwuy/AQD3pQQoSxGww
         ohtTbkKSr/FY+wGpEEE8Tq+z4QoNOnALjV45FdQ3gtGABU5wV8fMKhPaovOQucVqpOeA
         wDbo5VmoCjqK+kCE4mp6H+Js7Ef+sNZlMc8JCKAaCGaGlrDV6RSfteyH+kl2ZZb2pz97
         2xnIMSZYi3kkYwPPlDDGOBFb/QTqXafqafwM62hBMAqkkVsfK2PXqdWhovDVvGb5Fh5R
         0pObBYAZzwxSxvawIDHGsGLs9SGCyPorPx6UMaDNSmjcUfOh5EpX3tENMPBbDYwyf2ec
         iskQ==
X-Gm-Message-State: AOJu0YwCx9M4bF0GZYHMGyhBMUWyI7jBW/7Bz/Qaw6Wt2mEHw3J0cciY
        kxounPfZiEqqe1I4D07UpCOSs23TBKxm5BTjbmyu1w==
X-Google-Smtp-Source: AGHT+IHwCiI9a280gfixWHYnlXadu2DnALRqwi1TkFx8Su2VU6cZ+QOy+Dz/bbRdlhSki6Dni8BtYfJKHIclqEDVHoc=
X-Received: by 2002:a5d:604d:0:b0:333:2fd2:7692 with SMTP id
 j13-20020a5d604d000000b003332fd27692mr435092wrt.131.1702327674923; Mon, 11
 Dec 2023 12:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com> <20231205214359.GF1674809@ZenIV>
In-Reply-To: <20231205214359.GF1674809@ZenIV>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Dec 2023 12:47:39 -0800
Message-ID: <CAKwvOdkC0oHWKGJ1Z6k_U9cwkjdcf=iweG-G78jXSJgWFk86Jg@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 1:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Dec 05, 2023 at 01:39:47PM -0800, Nick Desaulniers wrote:
>
> > The tooling Tanzir is working on does wrap IWYU, and does support such
> > mapping (of 'low level' to 'high level' headers; more so, if it
> > recommends X you can override to suggest Y instead).
> >
> > arch/nios/ also doesn't provide a bug.h, which this patch is
> > suggesting we include directly.  I guess the same goes for
> > asm/rwonce.h.
>
> See include/asm-generic/Kbuild:
> mandatory-y +=3D bug.h
> ...
> mandatory-y +=3D rwonce.h
>
> IOW, sh will have asm/bug.h and as/rwonce.h copied from asm-generic.
>
> Still, includes of asm/*.h had been a massive headache historically
> and breeding more of those shouldn't be overdone.
>
> More painful problem is arch- and config-dependent stuff, though...

Ah, it looks like include/uapi/asm-generic/Kbuild also makes use of
this pattern using mandatory-y.

So I think we can handle this as a two step translation. We can tell
the tooling to 'nevermind recommending X, always replace
recommendations for X with Y <for raisins>', so:
1. any recommendation to use asm-generic/foo.h should be replaced with
asm/foo.h (always, based on those 2 Kbuild files, could autogenerate)
2. some recommendations to use asm/foo.h should be replaced with
linux/foo.h (not necessarily codified anywhere; depends on if there is
a linux/foo.h, will manually curate this list for now)

Orthogonal but some places in tree can be cleaned up to include
linux/foo.h rather than asm/foo.h.

Does this sound like an improvement to my mental model of the
conventions used for kernel header inclusion within the linux kernel?

Tanzir nearly has the above done (for 1, 2 we will probably need to
iterate on more).  We've also beefed up our local testing to test more
architectures.  I expect Tanzir to send a v2 of this patch (as a
series, with the fix for ARCH=3Dsh) later this week, if the above seems
correct.
--=20
Thanks,
~Nick Desaulniers
