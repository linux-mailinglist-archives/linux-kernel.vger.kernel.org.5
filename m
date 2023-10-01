Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A847B45B9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 08:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJAG7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 02:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjJAG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 02:59:11 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637819F;
        Sat, 30 Sep 2023 23:59:08 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-668d9c1f70fso375996d6.3;
        Sat, 30 Sep 2023 23:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696143547; x=1696748347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFogJBniBFn6caNvLOi/GkfLB5jlxKmfjfT3DU/VTrs=;
        b=LmFlY+vb2sPDIOPT/zPMZFEYX5ymLOZB4OMlSPuxNTGwUxcifB7b3XjptFbxUn/6ML
         K7hgODB/KevWyolh2APc/ad7WvMePnbcxYOsJor5UX+/XHnbZEoxs6/IH5yBqA/BVgbb
         owXbTX3F+WZ3YX/uotAW1a0d8vX7hSRZKjPwgWpgWIfvgWTRtloUw3gk0gBMJ5aPgPxk
         jve+FWN0nfgqgYzXqrMZuI658ZrzI8v+TDKgcU/gkpqb6T5YZzQKZErhGOr5L9XghTEU
         5bPCqtSmMf5ad+JKK7XX3X1aFCzdLhDDbD3gQVj96gGBssFNuUXPT9YGi0/wqwuomGVx
         cZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696143547; x=1696748347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFogJBniBFn6caNvLOi/GkfLB5jlxKmfjfT3DU/VTrs=;
        b=VA+d12y63tIYWA8HW30QmM3nShh1w298z35xDvlAzkXYoRnsOE9dt1w4wi0I9XAPKJ
         SsxZFgRUfzdKNdKBBm6w6ylGtT1N7TqVrfa22U/lCxAcWCiOj166g4ot8CnNn96F4nz2
         5EsEwu50J9lFhRNVCOluP07hBkDmBdSa+kabvWs7vzpsL+hki6YlCp0DbyufycJxW7Wx
         mpb8h/tq2isp/04O1BmXxgdj7aPlXrQG5F3+Azx3iLI65EbP9O28NHlKUjbxfrAra+zE
         kR0bbO8QCpjwIL5//zdmTyGSyyOWPu37YVLH2/mtxaQ2HI/3bEyGvgavSS6Zb7yZULCS
         ozGg==
X-Gm-Message-State: AOJu0YxzLL+nU5Hpj9McpiNfA0CHswx8JDV7cb2nBYrdRLKDUJDtLLml
        xRZ4i52xUHHWoV8c7BRtwL76tIMhe/fVfU3iV98=
X-Google-Smtp-Source: AGHT+IEDqx5jMt8NqHx7dN34nsB6P6Z72VHmZfl6fhmpQu5lKy26iZ4Uo7oU/tzxZ45ynGgotZmRMoWORQflbF2C7fw=
X-Received: by 2002:a05:620a:f81:b0:775:66c1:7f94 with SMTP id
 b1-20020a05620a0f8100b0077566c17f94mr7526632qkn.39.1696143547468; Sat, 30 Sep
 2023 23:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230928041600.15982-1-quic_jiangenj@quicinc.com>
 <CAG_fn=V9FXGpqceojn0UGiPi7gFbDbRnObc-N5a55Qk=XQy=kg@mail.gmail.com> <CAK7LNASfdQYy7ON011jQxqd4Bz98CJuvDNCUp2NRrHcK29x3zA@mail.gmail.com>
In-Reply-To: <CAK7LNASfdQYy7ON011jQxqd4Bz98CJuvDNCUp2NRrHcK29x3zA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 1 Oct 2023 08:58:55 +0200
Message-ID: <CA+fCnZe809yDRNQ_sQHenOE8idBDLDk_p=PG1-_O2NK7bMVxwQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: Add CONFIG_KASAN_WHITELIST_ONLY mode
To:     Joey Jiao <quic_jiangenj@quicinc.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kasan-dev@googlegroups.com, quic_likaid@quicinc.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 12:13=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> On Fri, Sep 29, 2023 at 11:06=E2=80=AFPM Alexander Potapenko <glider@goog=
le.com> wrote:
> >
> > (CC Masahiro Yamada)
> >
> > On Thu, Sep 28, 2023 at 6:16=E2=80=AFAM Joey Jiao <quic_jiangenj@quicin=
c.com> wrote:
> > >
> > > Fow low memory device, full enabled kasan just not work.
> > > Set KASAN_SANITIZE to n when CONFIG_KASAN_WHITELIST_ONLY=3Dy.
> > > So we can enable kasan for single file or module.
> >
> > I don't have technical objections here, but it bothers me a bit that
> > we are adding support for KASAN_SANITIZE:=3Dy, although nobody will be
> > adding KASAN_SANITIZE:=3Dy to upstream Makefiles - only development
> > kernels when debugging on low-end devices.
> >
> > Masahiro, is this something worth having in upstream Kconfig code?
>
>
> Even if we apply this patch to the upstream,
> you will end up with adding 'KASAN_SANITIZE :=3Dy'
> to the single file/Makefile.
>
> I am not convinced with this patch
> since this nod is not so useful standalone.

Yeah, I agree here, I don't think this change belongs as is in the
upstream KASAN code.
