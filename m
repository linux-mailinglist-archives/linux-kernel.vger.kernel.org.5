Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41D07824E2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjHUHv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbjHUHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:51:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6AA92
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:51:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-58d41109351so56905047b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1692604286; x=1693209086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IkOyMzrPXM2VgxHUc80scGsw2r/NO7mjPQDx+GPN74=;
        b=dmDahYpzHs8mZ4mluw4fY4YqFdveuqRbJAHQ/01cpHcArnHwT9aj+1N+zVh0Il7KlK
         v91zbtufrlxETSqxHueRYILxcaRcUW4ymO37hpdd5sSQweayETXouNgBrM8PIFpd7rgg
         W7SgodZHm9Q//rEIvIkge7Ixl6/OuBa9y8NygWyWJJb1dju6fFxW/yRi8ojA0+Xf5o/U
         xeIUQZbL3D1nEQ8YEUTLaFcMjhH6TdW5PVnOtME8EDeKLdsoGvmW6z2aAmGdsRUSNxAl
         KSaOZESe56qpSc1DiE/4YGZFqlLzU/445giiYxBOb5xLVLOzT7SaKVIiLymIxebCBVbz
         B2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604286; x=1693209086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IkOyMzrPXM2VgxHUc80scGsw2r/NO7mjPQDx+GPN74=;
        b=bMRuHHGEbT45Y0NDi9ZHUCCw5MC06XBHOejZ6CxVhJbnYpLHtQqgYkpSnfvUTC4HeT
         PxuHtAnkdNHiD32891oXYZu+eo27GlqFC9tfK8oe+iz/+aW1/MEg9YEZFGW2vhAWDnu3
         5/7lYrDwU9EWh0tvRtx5rt0B8cQ2arMJTmNVYsXs0Ire897cZcdbN7Coin7h1BxF5ZKH
         lTaDsvX1iEIFvN3rXOXS1Og8O2A6DOEQUPdrZlFjYxGnXLrsKhgbmXFivGFLHlFbfhI5
         XN+hw7YMT8BD404R5dGbE70uY0U2sajF5O25lVyPfFKS5FwTm5L/BdJM7fcdKikKyhFn
         Fntg==
X-Gm-Message-State: AOJu0YxtNmTS+5SyTRWrp1uKKFtSsPsP96Ukrc1irbUTcoAeS03f4qar
        XX28w7ZC3wNqJn0d+KoMqsmC929Z4M7f223rIwdT9w==
X-Google-Smtp-Source: AGHT+IGsgfF/yqt3FJ2nXR1RxTsBuGTHFXhYYZYrd0vKqQuzmc6jZpHnNy5kwuoHkMasCmlduCzk9ohT+0c6ovX2VOY=
X-Received: by 2002:a0d:e897:0:b0:589:f9c3:8b2e with SMTP id
 r145-20020a0de897000000b00589f9c38b2emr4566061ywe.20.1692604286040; Mon, 21
 Aug 2023 00:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230615072302.25638-1-nylon.chen@sifive.com> <20230615-unvisited-deceit-9beab8ce987a@wendy>
 <CAHh=Yk_=oZJ6eY3jJzLavub5rGsvY=MKv4tGXeiqkz+rgJHwDQ@mail.gmail.com>
 <20230615-luxurious-rewire-84ff9d639fea@wendy> <20230615084310.GA780@hsinchu15>
 <mvmo7lh2ip6.fsf@suse.de> <20230615094732.GA8710@hsinchu15>
In-Reply-To: <20230615094732.GA8710@hsinchu15>
From:   Nylon Chen <nylon.chen@sifive.com>
Date:   Mon, 21 Aug 2023 15:51:14 +0800
Message-ID: <CAHh=Yk8upMOdhma4EDZj_TsA2rf8=MQVrP2sidhmwBh3G-ix-Q@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel module
To:     Andreas Schwab <schwab@suse.de>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, ajones@ventanamicro.com, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, zong.li@sifive.com, nylon7717@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Currently, due to the lack of support for the unwind table in RISC-V,
we have disabled it.

If RISC-V were to support the unwind table in the future, would we
need to re-enable it? Would this require implementing related
changes(module relocation type handler) at that time?

Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:47=E5=AF=AB=E9=81=93=EF=BC=9A


Nylon Chen <nylon.chen@sifive.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jun 15, 2023 at 11:11:49AM +0200, Andreas Schwab wrote:
> > On Jun 15 2023, Nylon Chen wrote:
> >
> Hi Andreas,
> > > Because LLVM currently has it enabled by default(https://reviews.llvm=
.org/D145164), it will generate this
> > > relocation type.
> > >
> > >>From what I know, GCC will also enable it in the future.
> >
> > That's why the kernel explicitly disables it.
> Ok, thanks for your feedback, after I cross-tested, there is indeed no re=
levant relocation type generated.
>
> If this error no longer occurs.
>
> I am open to the idea of adding this patch to the upstream and would like=
 to hear your thoughts on whether it is still necessary.
> >
> > --
> > Andreas Schwab, SUSE Labs, schwab@suse.de
> > GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B=
9D7
> > "And now for something completely different."
