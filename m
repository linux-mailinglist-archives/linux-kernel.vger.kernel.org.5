Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303677706FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjHDRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjHDRXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:23:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FAF469A;
        Fri,  4 Aug 2023 10:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FB4B620D1;
        Fri,  4 Aug 2023 17:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A48C433CB;
        Fri,  4 Aug 2023 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691169823;
        bh=pX4JO8cUMPFX/7eqCt97XOCu1Qwjs6jTjWKwADOJ3hM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eXx/hocet7GcuQXmEnd8oc8WA31nITE5YL0fB8/IVAofYd3M8Qorx70SE7ytCAghe
         nTtiDW3K+i7SFDqsiRkjLbI4etNMh61X11ya/Qzussiod+4K2wfBWeteoZM/Kwn9xf
         EwA07/pBieD75nXplqq9YIgBUuZGfboSDT+E7oVd0Of5qNmPNuYG+AgX3DEb+XZVn6
         38GBb0TTQMm81sYAiz3Xh8kqu7GUCNomOdqFemGINap9QwHSSBqjLnR6uwmkdg+zsX
         DEOP8l5DB/5bA4O5L2dPx/9ixFSY8jbFPnq0OwtfsI7fSg+Ot2rSOJV7DCsMh2lSGj
         cfCDKaf6Lgw/g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so36709371fa.1;
        Fri, 04 Aug 2023 10:23:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwiYgHT6YTcfo5ae0wX1qRkgSlxk+Ytec3WnC1GT8Hd64Q+mm3l
        aRKFUiit6Qh++1GRcOBkG465vu1L74z7YsgydA==
X-Google-Smtp-Source: AGHT+IF0j6TlCYvGUVtXd1S/Q0iv1iISN2MYMAf+QAGxO0EdffC7eK6t++9XFQxUNAzy2RqY402LhHUiQr0RNIifL8o=
X-Received: by 2002:a2e:88d6:0:b0:2b9:cb50:7043 with SMTP id
 a22-20020a2e88d6000000b002b9cb507043mr1896653ljk.2.1691169821442; Fri, 04 Aug
 2023 10:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230728195022.1198555-1-robh@kernel.org> <20230729-twerp-avert-70577ff7d952@spud>
In-Reply-To: <20230729-twerp-avert-70577ff7d952@spud>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Aug 2023 11:23:29 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJip=r-xObhCOnL0sue67Pems8wO1FP3x=rCGXARCA1sw@mail.gmail.com>
Message-ID: <CAL_JsqJip=r-xObhCOnL0sue67Pems8wO1FP3x=rCGXARCA1sw@mail.gmail.com>
Subject: Re: [PATCH] watchdog: Enable COMPILE_TEST for more drivers
To:     Conor Dooley <conor@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 4:22=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Fri, Jul 28, 2023 at 01:50:21PM -0600, Rob Herring wrote:
> > There's quite a few watchdog drivers which are easily enabled for
> > COMPILE_TEST, so let's enable them.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Passed allyesconfig builds on arm, arm64, x86, riscv, powerpc, sparc
>
> Doing its job I suppose, the riscv patchwork automation stuff has
> spotted one new complaint for allmodconfig:
> stm32_iwdg.c:77:19: warning: unused function 'reg_read' [-Wunused-functio=
n]

Looks like that's a clang W=3D1 warning only. Presumably it was already
there before this patch with the right config.

Rob
