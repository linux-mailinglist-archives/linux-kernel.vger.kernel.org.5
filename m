Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3140D7573F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjGRGS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGRGSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:18:37 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C41E198D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:18:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b74209fb60so78461541fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1689661089; x=1692253089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA1k3LWdJrycD7+8OcHcVZB99NNNbrk61vgndGZGEcM=;
        b=DpzU++FE4Ax0xt45yhig+1UQjsLFHwRkgQyIWi0NXZpKJ7C5flgwQUT+795d9afTSS
         jY1zc36HC/j7RH2b/pmgWfGnUlFbdfM7ZYNBHri+DRXdVlxXeRLr8/EIdC+LH0jFhMdR
         XDMcj73CHjloM9lT5M4ILWA9aW1Z784lfnuEl7UdvJprzZgA9miRXu/ImrEv4fjyg0Yg
         LapLMBqub/u4MN3nVIAvof29Hcnj4bwSpWTAteFyD58GSMaWFTIaVI6JtfLtX8fRFF2t
         v9pAisptdpzM21tq7jQv7z7oOhX/wwYNdvx2DZ9Lwvd+IR+G8cltwB60DnKHsyKxJ/AB
         V1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661089; x=1692253089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA1k3LWdJrycD7+8OcHcVZB99NNNbrk61vgndGZGEcM=;
        b=b541rz1fWZcbn3gSnp1TSLi2MBecTTuL4Gwd15FCz8PMY0HIa7ayMuSYBCpxxnvYfg
         ewj6ToAj0Hb+fo3UELBiIcmvnXUEDRRMwri4/AkDLMXfWhxXeAavBEZLJmZ15L5JpC0j
         0GSfy61vxF+fDqyoRO1V8dw9STGFSh+Ofgvem3PLxcBV22etn4SCF5ojYl8aX7Vug3tK
         zmWNDRVXAXwGlOkr/bXyA0uoT0omKKopwTQzC9J05oUPOR9QmljmLzmTlmFa2PJiqFMw
         oMPyK3a+Rv/Yi9VtXezsiImyVgDoqzLCwmJHSllKDHCkJp9bXfahPzvkKZMvom17lA/h
         8yvQ==
X-Gm-Message-State: ABy/qLYTXOaKXMQy6XhxLgiLCRgLNye3NMnZ+RJogvrtBR1mSQZG1Ut8
        KN1+4HAWokCryyL657uTg8z6AnBbYg7kbJ1TRp4g5w==
X-Google-Smtp-Source: APBJJlGB0oIGKDOPuaduZrWnO2FxLltxsvsGPi07T5wrz5pWNnb/vYvW5RkHh+acrIJO2WQbbmY7yUIzF0xFnt3F6Vo=
X-Received: by 2002:a2e:9dcc:0:b0:2b9:3461:45ad with SMTP id
 x12-20020a2e9dcc000000b002b9346145admr4853916ljj.20.1689661089433; Mon, 17
 Jul 2023 23:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230516164416.11616-1-alex@shruggie.ro> <CAOMZO5Br-nMxLSekZL5jLHNpyfOH_KgL1WUgAZ25wu86S2eYwA@mail.gmail.com>
 <27105a1712cd7be1d3d36702873f5702999566e7.camel@gmail.com>
In-Reply-To: <27105a1712cd7be1d3d36702873f5702999566e7.camel@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Tue, 18 Jul 2023 09:17:58 +0300
Message-ID: <CAH3L5QqOUOR4t2b2r780Q7YcWUqDo_rvmLYt_VHKx1MszaNGNA@mail.gmail.com>
Subject: Re: [PATCH] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Bogdan Togorean <bogdan.togorean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:48=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
>
> Hey Alex,

Hey Nuno :)

>
> On Thu, 2023-07-13 at 17:19 -0300, Fabio Estevam wrote:
> > On Wed, May 17, 2023 at 4:08=E2=80=AFAM Alexandru Ardelean <alex@shrugg=
ie.ro> wrote:
> > >
> > > From: Bogdan Togorean <bogdan.togorean@analog.com>
> > >
> > > For ADV7533 and ADV7535 low refresh rate is selected using
> > > bits [3:2] of 0x4a main register.
> > > So depending on ADV model write 0xfb or 0x4a register.
> > >
> > > Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> > > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> >
> > Should this contain a Fixes tag so that it could be backported to
> > stable kernels?
>
> Yeah, most likely yes... With that:

I'll add one.
I seem to forget some upstreaming routines, since I started doing less
upstreaming.

Thanks
Alex

>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>
>
