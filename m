Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58A792B43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343948AbjIEQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353753AbjIEHw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:52:58 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DE3CC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:52:54 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-34e202a9cc9so6238865ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693900374; x=1694505174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/s66p9pwSSI1fSoYztzIq0uZUi+KONsknkXUZ5g+do=;
        b=kk/3AsBtX3ePS69xgCApgu8GJE3cTZGgo7aacIVPeM4NFKfnKSnB5H/Oapmrj/hgjk
         exnuluKA5/K8JF2FYHphkm/L41CkRx/pl125HJha4w4sBI3lGaa8yVCaC+dA2O2RdMvR
         nw0ETcjHEPES2S3lrnbWog7LMoov8t3x212fxoY/IPKQl8fwZebdHX8/u/0VwgE5/V6H
         v/zSgiSFiq45zCoCBoozJZYkrhSLt7QMBxLWYZeYcys9VBV2gmUw2+Gj3z6cpHkP44X6
         AVypYX5G7XCeKu1LmPxCOdzJYKpbXEg3Hw7jUWShCsvcKGXWeEFDGlhjCcNByEnEkm4p
         Vmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693900374; x=1694505174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/s66p9pwSSI1fSoYztzIq0uZUi+KONsknkXUZ5g+do=;
        b=NbghLKFMlWb1jHsvpraSu9yLh8+iWBY2KpdgxBDtPGF+Si8cfx5H3ifpJFUuXj1MsS
         MNBVjpJ8twSSJ2n89RyQ4RlxtmLlEFd5OB1SmEdKPGNY0WAXp3b7GkEDaxdRcvEodHxJ
         UCU3t8WE/EFK2Ryr3cipQJolNQD9gfODiCr71Nj4PTxBBLSHUakSGnFBJ6lWpTcW0Eqn
         jAEn+sNl9JNTf6/5PqxLOwlMEZ+r7hAV8qsaELBhGXpO22tsj7oYSqrMOYiKUhdgHTJf
         sXLtP/bDjdx4JOjQZN2CFJWvf+7OfeV7emoofbAUPJUu57/xgVsOaMLT9MAgTZDUlhK7
         Dymg==
X-Gm-Message-State: AOJu0YxPhL6m6FzsARm6v8MW1b9AmCAW+5QaE9jznsjj9v9A9IbF1zdh
        FgQV9Fy4q0rAt5NKJt8Pllp+s3y32cvsKaMNCvw=
X-Google-Smtp-Source: AGHT+IEySP94eVLl7AiEPYh5FDmpxXtZ41VikaFi3omLii57sxmTMraaEjMpLk1CCaU/fWHLAoG/v/+5gKsnnWCUapQ=
X-Received: by 2002:a05:6e02:128f:b0:349:9665:38b with SMTP id
 y15-20020a056e02128f00b003499665038bmr11582256ilq.30.1693900373973; Tue, 05
 Sep 2023 00:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230901110320.312674-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230902-plexiglas-cannot-e4ca8494ef95@spud>
In-Reply-To: <20230902-plexiglas-cannot-e4ca8494ef95@spud>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 5 Sep 2023 08:52:27 +0100
Message-ID: <CA+V-a8umzZ7eGDQ-CAL0+uV7mQcr6HC5BR3b=UWJoV2VjNm-4Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: Kconfig.errata: Add dependency for RISCV_SBI in
 ERRATA_ANDES config
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        kernel test robot <lkp@intel.com>
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

Hi Conor,

On Sat, Sep 2, 2023 at 12:02=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Sep 01, 2023 at 12:03:20PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Andes errata uses sbi_ecalll() which is only available if RISCV_SBI is
> > enabled. So add an dependency for RISCV_SBI in ERRATA_ANDES config to
> > avoid any build failures.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202308311610.ec6bm2G8-lkp=
@intel.com/
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Replied here earlier, but pressed the wrong key & it only went to the
> list.
> I think this patch probably also needs to grow a Fixes tag, for
> commit f2863f30d1b0 ("riscv: errata: Add Andes alternative ports").
>
> The 4 Kconfig patches ideally would've been in a series, since 3 of the
> 4 seem to be fixes & the 4th depends on one of the fixes being applied.
>
My bad I should i've posted them as a series.

Cheers,
Prabhakar
