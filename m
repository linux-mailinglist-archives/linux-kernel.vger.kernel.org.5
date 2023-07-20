Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777075A411
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjGTBkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjGTBj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:39:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646E1739;
        Wed, 19 Jul 2023 18:39:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24F4F617DC;
        Thu, 20 Jul 2023 01:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80135C433C7;
        Thu, 20 Jul 2023 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689817196;
        bh=s7nvsi/fR/DkOos7XUNnf4czEgsTZCalrOP+7ilrR20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AMWE1PQzoNpizBsp86xzjvtm60TA8h1+7R2wrnSMm8cP+VhrpHCo5Qo/o1wpaYcGG
         7Vss+9GH6KZuJATFLUW8qG94XgfgEYua7IBa4L6KfIUScgOwbADci25ZfOxFTvUq0W
         7kz28MXJExKMnHXSknP22C5F4Zg4p6cQMfQV6NyzC79kd5F0IzRm/e9w5p+0ANXDJ0
         FgUNQBKkkW+7BJlSEvOxrrRoyQ362VHauYtXMNPCQBEOurMmLml9sP12GFlRBR3UNP
         neqJhDQ6BXGjHnOjkrIssvuAyeId5IaLYU1D1bHf38AI+rgPM3W1jthcfUt7o5WWlM
         Fb/KX59KJagCQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso244352a12.2;
        Wed, 19 Jul 2023 18:39:56 -0700 (PDT)
X-Gm-Message-State: ABy/qLYQttqcG08gNhv9Yl21GGlQk0vkkVU9vd04fx2XWPh5Un+x7KdY
        JKuamOu9iiheOcG8UnBkfKymAcc1q3L40rVCgVU=
X-Google-Smtp-Source: APBJJlFIeK7vwGDOYJWQBumT0vZA08j+F+PIgl5t9pRISgHIG62HRsN1cOKE2vxtbVivLmWBrzkee4GQ/LkHpE4liuw=
X-Received: by 2002:a05:6402:60a:b0:51e:357:3782 with SMTP id
 n10-20020a056402060a00b0051e03573782mr3169355edv.9.1689817194776; Wed, 19 Jul
 2023 18:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230718153348.3340811-1-chenhuacai@loongson.cn>
 <261edc6c-e339-faeb-3045-bfe6604d1aef@web.de> <CAAhV-H5nNMmYZQXvoog85cgMUd+gM2QMaG3cUhYk_iGzjB=B4Q@mail.gmail.com>
 <f9e7fb54-a76e-a9b0-1b9c-8c9251f4af20@xen0n.name> <281c5d5e51488ce51497072c1e4304d71af141ec.camel@hotmail.com>
In-Reply-To: <281c5d5e51488ce51497072c1e4304d71af141ec.camel@hotmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 20 Jul 2023 09:39:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6JAsR+1jK6BsEfOqf=uee3kj2=Fj3LSW0oUfhSo-vYiQ@mail.gmail.com>
Message-ID: <CAAhV-H6JAsR+1jK6BsEfOqf=uee3kj2=Fj3LSW0oUfhSo-vYiQ@mail.gmail.com>
Subject: Re: [PATCH v5] LoongArch: Fix CONFIG_CMDLINE_EXTEND and
 CONFIG_CMDLINE_BOOTLOADER handling
To:     donmor <donmor3000@hotmail.com>
Cc:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "chenhuacai@loongson.cn" <chenhuacai@loongson.cn>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "lixuefeng@loongson.cn" <lixuefeng@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 9:35=E2=80=AFAM =E2=80=8E donmor <donmor3000@hotmai=
l.com> wrote:
>
> =E5=9C=A8 2023-07-19=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 18:29 +0800=EF=
=BC=8CWANG Xuerui=E5=86=99=E9=81=93=EF=BC=9A
> > On 2023/7/19 15:22, Huacai Chen wrote:
> > > Hi, Markus,
> > >
> > > On Wed, Jul 19, 2023 at 2:51=E2=80=AFPM Markus Elfring <Markus.Elfrin=
g@web.de> wrote:
> > > > >                                                    =E2=80=A6, so =
this patch add
> > > > > some code to fix it.
> > > >
> > > > Would you like to avoid a typo here?
> > > >
> > > > Will any other imperative change description variant become more he=
lpful?
> > > Thank you for pointing this out, but since Zhihong is the original
> > > author, I don't want to completely rewrite the commit message, so jus=
t
> > > fix the typo...
> >
> > AFAICT the commit message is totally uninformative even if "an
> > imperative change description" were used. It basically:
> >
> > 1. repeated the patch title,
> > 2. spent one sentence only for mentioning a function name without givin=
g
> > any more information,
> > 3. mentioned why some change was not necessary due to some other
> > existing code, but not explicitly calling that part out, then
> > 4. finished with a sentence that boiled down to "we should do the
> > similar thing".
> >
> > My take:
> >
> >  > Subject: Fix CMDLINE_EXTEND and CMDLINE_BOOTLOADER on non-FDT system=
s
> >  >
> >  > On FDT systems these command line processing are already taken care =
of
> >  > by early_init_dt_scan_chosen(). Add similar handling to the non-FDT
> >  > code path to allow these config options to work for non-FDT boxes to=
o.
> >
> > Would this sound better?
> >
> Xuerui's take is fine. Do I need to make a v6 patch?
OK, if you have time please do that.

Huacai
>
> donmor
