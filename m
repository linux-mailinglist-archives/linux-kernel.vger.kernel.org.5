Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8174178D2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbjH3Emc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbjH3EmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:42:23 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CE9CC5;
        Tue, 29 Aug 2023 21:42:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991c786369cso664547066b.1;
        Tue, 29 Aug 2023 21:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693370540; x=1693975340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA0a9dpApYSsfV7l4pjTSJUMNx25R+jfRtyr2czmNLE=;
        b=XGAuaXmdRTU8ZdspPhn7WjgmJFo/B2NhPIvHNKDkve4IyyDxGu9nHtiEe7Xy0EDbw9
         QexE7c8EhHQPiEaw+FuWmZR3BRFivOyXw4R/KO/oCF8aC+y0hITpdI/D6GGx9slUXObU
         fQxbz1kctcGT/Kaec8x2WJDA1yzNCpfjFCXvHH2asQ5Nn2f/4LMf4t6dGPPIA82lasfW
         5kOSg19EZAl7C7cyJpKaJjL4xnk+6oVx23Hoep2BVAIhZZ0GORmoP2DR6vxqEXcrNZ0+
         xL1EmPVFtRZ9NvgdCbAvHO2tfwNMOHCJsZ0R7JFHp0RDihBenqaUDu7f/sE6uTK1rKa+
         fzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693370540; x=1693975340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA0a9dpApYSsfV7l4pjTSJUMNx25R+jfRtyr2czmNLE=;
        b=kaShyZIWErD5pPBFGRHBF8WH5Xp4v8Zcp8E2c4u6+fnEPWwfAaCyw8doAPr8sV+OB0
         SXf3kPd4ObDmCQvrN8WbZUBdJSaFm3ojJX1raXOPrey6D8NnXdmuaqE/cvGYaWADo9PG
         Gto3CEsLLw1bEpjPUJSC6SHyMV98m2ZofTLLM6lCew0TcvFsgGgsUVO+LcJDXECwOxXO
         F2JcHILGpU+1oEok6eT1uvBPuSyXl4/MiObb+AHcV1bNDtQ1qROtUujd1DEJzGews2Wy
         i7C9M1dcHNP+YxdZzBiHH2gjHodrz+3NIER50gWnSfKvJl10zl2ZY7EgVO3xuZDj1R+d
         kNUA==
X-Gm-Message-State: AOJu0Yz9e8EjqJRXea/EvF+v6XAxWEIt2ozdAxWj7fDdUABa+HDm8lz4
        Pdv0ZNjzYcH53/u8/enEOUslY4B+djvOA72RYUE=
X-Google-Smtp-Source: AGHT+IEtSaQQaV5/NtNPlE2Y5LJnluj2AkdjlDbwmA1JV4Lm3xXhYXQPJf+aJcbdthULHbCD7YCMARYQLqJQIsO4MkI=
X-Received: by 2002:a17:907:2717:b0:9a1:f10d:9746 with SMTP id
 w23-20020a170907271700b009a1f10d9746mr653011ejk.20.1693370539610; Tue, 29 Aug
 2023 21:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230828134725.103442-1-keguang.zhang@gmail.com> <ZO4NCXnhauFQgvfJ@alpha.franken.de>
In-Reply-To: <ZO4NCXnhauFQgvfJ@alpha.franken.de>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 30 Aug 2023 12:41:43 +0800
Message-ID: <CAJhJPsVTm5hLa2tDW_c=nmYi4BA-8eTpedO1Xr0uZ2go5NQA7A@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: loongson32: Remove dma.h and nand.h
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 29, 2023 at 11:21=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Mon, Aug 28, 2023 at 09:47:25PM +0800, Keguang Zhang wrote:
> > Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
> > unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
> > are unused. Then, dma.h and nand.h are useless.
> > Therefore, remove these useless header files.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Remove include of dma.h and nand.h
> >           Update the commit message
>
> this still doesn't compile, when applied to mips-next. Can you
> please check, that it compiles before sending ? Thank you.
>
Sorry! I will make sure that there will be no more build errors in the
next version.

> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]



--=20
Best regards,

Keguang Zhang
