Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184B27B3BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 23:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjI2VGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 17:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2VF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 17:05:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085641A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:05:57 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53406799540so13374708a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021555; x=1696626355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hewtow4Amnq4Fl0NeolxjCW9hsmk+74FWkwP1bIkkB4=;
        b=hFgtaETM/JS704f7t9YBvoEmq2xdEal/zKfPER83/5KiJnz6hcRhplaE1oVzy/sT1c
         gxqIU1opw9UWWMTiZSJtaxT6Y/Krm7LovSIgmqjZYpU1i9z6Xvv+vW+XMedtTjKwMNUD
         3xW/jTBxD7rQnNfP8mBYP/US6UHPszSDqbwnCx5039hnJPbFuDF8NXzeBi3P7ONlMaMc
         pZ6FhAbteqcm23iYXL66DHG6LPzafZXGvY/h31YsljXS6EysqCS1E4UNhrEg4C0nJ0sG
         m9ElHeN8++M2KJj5zxuA45sKxliEgliWDd1P9KF9qVO6rUUEwO/q5Bof1svIYkMYPWYE
         t3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021555; x=1696626355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hewtow4Amnq4Fl0NeolxjCW9hsmk+74FWkwP1bIkkB4=;
        b=MkSWsR1iuMLupTHFE8oyi/NOkzSpH2MSomcx42Zkfzwl/2H5GavjcTeimuuv5XNAPn
         +Oq8PN0xisbMevKt5ttv25G/JXr2D36mdNbwgVZY24IUWguldITgMJ8iHLZW5jmlC8nt
         xAEa67lCBaUnSDkKW2H1/WgSr7e3RJM1ifKYwPb00IqjzJmPK5nCe2x2x6OPwa6wuksj
         ns1F6Nrma8a+/CeBWtRG5MWCfQRMOaOikvvyZuPLkGXnX3xTscYJIf7qPzLL8b7zmnM1
         VSFf0Ev3vsGLy0L9uA4QO7Ov4tox2HeRrDWxXtfYawus3ZHaeqrcMNM2SIBZp6MZ4a5H
         srFA==
X-Gm-Message-State: AOJu0YwH3+vrf+1H+3lUDsWOvNWyP1l42dhad3YNygl9AjuuZVZow2Ps
        LC3k47NcZr18iE4Og9T6uqA=
X-Google-Smtp-Source: AGHT+IHwkhLrWPwEEYb8b7MUFAwc4MjTn1XbxKN3jzKLUDYYoqbsZ+3lME60A0WRmdFh5liJllrwkQ==
X-Received: by 2002:aa7:c488:0:b0:533:20ab:5d84 with SMTP id m8-20020aa7c488000000b0053320ab5d84mr4397979edq.30.1696021555166;
        Fri, 29 Sep 2023 14:05:55 -0700 (PDT)
Received: from gmail.com (84-236-113-123.pool.digikabel.hu. [84.236.113.123])
        by smtp.gmail.com with ESMTPSA id d15-20020aa7d68f000000b005333922efb0sm11689119edr.78.2023.09.29.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 14:05:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 29 Sep 2023 23:05:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] irqchip fixes for 6.6, take #1
Message-ID: <ZRc8L+fJAqHuWEg+@gmail.com>
References: <20230924094105.2361754-1-maz@kernel.org>
 <ZRXtYzIA5dK1iPVb@gmail.com>
 <CAMuHMdU7WuV6moiRWuChFzBr1n5pGxuEMeuoA1YWYw4v8QAN1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdU7WuV6moiRWuChFzBr1n5pGxuEMeuoA1YWYw4v8QAN1w@mail.gmail.com>
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Ingo,
> 
> On Thu, Sep 28, 2023 at 11:17 PM Ingo Molnar <mingo@kernel.org> wrote:
> > So the tags should be something like:
> >
> >   Fixes: 397ad94668c1 ("arm64: dts: qcom: sm8150: Add pdc interrupt controller node")
> >   Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >   Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >   Signed-off-by: Marc Zyngier <maz@kernel.org>
> >   Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >   Link: https://lore.kernel.org/r/20230905-topic-sm8x50-upstream-pdc-ver-v4-2-fc633c7df84b@linaro.org
> >
> > Ie. we generally sort the tags not chronologically (or whatever the original idea
> > was), but group them topically, sort the groups by importance, and only within
> > the group is there chronological order.
> 
> The tags should represent the order of the hand-off chain:
> 
> https://elixir.bootlin.com/linux/v6.6-rc1/source/Documentation/process/submitting-patches.rst#L449
> 
> and chronological history:
> 
> https://elixir.bootlin.com/linux/v6.6-rc1/source/Documentation/process/submitting-patches.rst#L493

That chronological requirement is only for the SOB chain itself.

To quote Documentation/process/submitting-patches.rst:

     Standard sign-off procedure applies, i.e. the ordering of Signed-off-by: tags should 
     reflect the chronological history of the patch insofar as possible,

which is exactly what I wrote above:

> > > only within the group is there chronological order.
      ^^^^^^^^^^^^^^^^^^^^^

In fact it would be crazy to require that all the tags are chronological,
in the random  order they arrived, which the commits I pointed out appeared to be.

Thanks,

	Ingo
