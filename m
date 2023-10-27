Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C747D8CD8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 03:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjJ0Bk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 21:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0BkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 21:40:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24C1B6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 18:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBEA9C433C8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698370823;
        bh=Tg1BcN8MTB11mXGkDAIPwyalWPjJFr1KuXuRuiuHTMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TbBCFdcvYbCRp/t5JHRVTV5fnyhS47C6nm8TprZpBlZPpD8hnOsITBNm29pS/lD1F
         BzbZjnmgcGFzut+1L0AgBmL3iug/YAZ4N/Jpdb79vupM14wa4ZKR/2HVV6doJDq8Ow
         qwBtoTD+g5MuPsDbgQqa4lkLL5z0zpKhEx2tgunnWtGurMLooyCgv3sSC0Subyvf7H
         WPsPvitEja4WIGwRctX/80oXAyX5xCRoQ7W50OoEAdI1zWXrek2fPOTypDaD/pK2lG
         2yDKvuibysGF2uRrfWQslR9lDHnYqH4pA+PDGgkZR7hkM6IqKPyKlfSv73YiZpMyX0
         2rMHr9UOWFzqg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so2571579a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 18:40:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz33hk0Psbfopec5Q1ECjCaRzphMtEBlCjzgFToj9mWz0w7LNET
        w1rTssvbzquRBph8AU0ZYzRhIv2STQoKrgs2iC8=
X-Google-Smtp-Source: AGHT+IFNg9bwsxZP5Gx7uA1HjiH/lO4Sf/zpLdAOH5WCN/PdxqI9L/SIz5GzGkVjk8eB0UflReyPeb/Nm1A31vLqo38=
X-Received: by 2002:a05:6402:3447:b0:53d:b1ca:293c with SMTP id
 l7-20020a056402344700b0053db1ca293cmr1154834edc.22.1698370822207; Thu, 26 Oct
 2023 18:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231026114446.5932-1-huangpei@loongson.cn> <20231026114446.5932-2-huangpei@loongson.cn>
 <0e0cbc68-2b4c-462d-aff4-abd795b3b63d@efficios.com>
In-Reply-To: <0e0cbc68-2b4c-462d-aff4-abd795b3b63d@efficios.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 27 Oct 2023 09:40:09 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5bCmF6Tcjg_fMBwQTRne3h2Zr+PpBZMt_KCZNzot-i4g@mail.gmail.com>
Message-ID: <CAAhV-H5bCmF6Tcjg_fMBwQTRne3h2Zr+PpBZMt_KCZNzot-i4g@mail.gmail.com>
Subject: Re: [PATCH 2/3] LoongArch: Add RSEQ_SIG break code definition
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Huang Pei <huangpei@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mathieu,

On Fri, Oct 27, 2023 at 2:16=E2=80=AFAM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2023-10-26 07:44, Huang Pei wrote:
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > ---
> >   arch/loongarch/include/uapi/asm/break.h | 2 ++
>
> Why is this part of the uapi ? None of the other architecture has this
> as part of uapi. It's only defined in the rseq selftest arch-specific
> header file.
From my point of view, it makes sense to list the dedicated break code
in UAPI. It is harmless and can avoid potential conflict in future.

Huacai

>
> Thanks,
>
> Mathieu
>
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/loongarch/include/uapi/asm/break.h b/arch/loongarch/i=
nclude/uapi/asm/break.h
> > index bb9b82ba59f2..e0fcfc304834 100644
> > --- a/arch/loongarch/include/uapi/asm/break.h
> > +++ b/arch/loongarch/include/uapi/asm/break.h
> > @@ -20,4 +20,6 @@
> >   #define BRK_UPROBE_BP               12      /* See <asm/uprobes.h> */
> >   #define BRK_UPROBE_XOLBP    13      /* See <asm/uprobes.h> */
> >
> > +#define BRK_RSEQ_SIG         16      /* See rseq */
> > +
> >   #endif /* __UAPI_ASM_BREAK_H */
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
>
