Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF557531B7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjGNGEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjGNGE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:04:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EE9271F;
        Thu, 13 Jul 2023 23:04:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b8392076c9so9956771fa.1;
        Thu, 13 Jul 2023 23:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314663; x=1691906663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjmA4vOTkGwFP6byVeuNX5GJuZ4Uxjvbd1dybkUi9gI=;
        b=gPhvisrPuH0rQjgD5Hi9MFnrsv910eO34eUc1RGHcccB844nvWd9hml7pRuR4djqUU
         cG8EI/0uXHzF7oSZ3I0YZ9PNlXVXi9kTLPaSVVr4cqC6EpouWqnYfMLMKdTPiMrbhpws
         zm8W9vljDAm+eVQF41e+vjsPJb8p2YBW9Vy8kM7V0ISRzb4imcwL/S+VTSk8LwTa/105
         SGaCs4aHpTIXbgw00XXKhhdzSVEhfTrY+LAetqiCDF8LhZNnHmIMq9xDcca7fEejLE+g
         M0Hwx+8zPik68+9+YPJMQk3O1ZDOEV+FJ9glwThDS+6IEwiBx048z2+bYRbF7cp74ZNX
         9GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314663; x=1691906663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjmA4vOTkGwFP6byVeuNX5GJuZ4Uxjvbd1dybkUi9gI=;
        b=OzUiesCbLh0aNbMa2S578LzP2NB0IOTQKYbmDYoDYYAij/kCpBpBHKNyUaVhvirSY7
         wuj8Z7DiAyWn/E0EaJf3+qTT7yTOy8HG7ZOElNBpYS3q+Jl0BaU8WsxrU1NmRKsOUdha
         COfv/MDI8mTly8illbiLM3lJmLuqdtfrmxBcvjReK/aD5ct4xZXjdeyPSQbqMvnbSm8b
         r8I5dqSyHGD/D+y7J9NDWmNfbcnpfNNzByp7DbOD9o1blFR83sDtkeobOgG3Lpn7YR3+
         mfmLrDS1SbCZ1HzYdzEbebzCgcpTLHFDm4ACjVTvCPUGIUe6OUPxoB/2bxtZ1L07aBBF
         ig8w==
X-Gm-Message-State: ABy/qLYP8cmzWaQ/Wx5Hy7KSMeWAveWIQjtV7UKiZIT8t7Ji6Eeuez8T
        7hIivsvf6to/midq01TbC/W3h6TaKJtf4EYXYwsnm1DJ
X-Google-Smtp-Source: APBJJlEyzFmZTxDSLZlKXTyqY5UP1cP5IIpdqO6/ly8Nf2PhalxOwEhK/FxafwqY0Azgc1rBday0xBVHfmmMuvLx1L8=
X-Received: by 2002:a2e:9b8b:0:b0:2b7:3b73:2589 with SMTP id
 z11-20020a2e9b8b000000b002b73b732589mr3103159lji.32.1689314663201; Thu, 13
 Jul 2023 23:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230714144330.3c0a4074@canb.auug.org.au> <6f655ef5-b236-4683-92b0-da8b19e79eca@paulmck-laptop>
In-Reply-To: <6f655ef5-b236-4683-92b0-da8b19e79eca@paulmck-laptop>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 13 Jul 2023 23:04:11 -0700
Message-ID: <CAADnVQLF0BP-_Fjxi1S-0Shus38vAVdNbB2JHsBd6_RudYWF0A@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the rcu tree
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 9:50=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jul 14, 2023 at 02:43:30PM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > The following commit is also in net-next tree as a different commit
> > (but the same patch):
> >
> >   a2b38823280d ("rcu: Export rcu_request_urgent_qs_task()")
> >
> > This is commit
> >
> >   43a89baecfe2 ("rcu: Export rcu_request_urgent_qs_task()")
> >
> > in the net-next tree.
>
> The net-next tree needs it for BPF, correct?

yes.

> So if you guys intend to
> push it to mainline, I will be happy to drop if from -rcu.

That's the intent. Please drop it from -rcu.
Thank you!
