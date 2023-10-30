Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82B7DC162
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjJ3UqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJ3UqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:46:21 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53233AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:46:19 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2f507c03cso2726060b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698698778; x=1699303578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GHWL46G8NXkoKAdE2/pXu93JSdaBuXUlUxnrvTJOdOY=;
        b=gScqSKHr+7n+8L/2SI5WR0Tp8ai3I2OXp9nTrBXP/pojyyM24BfmofAmcuExTt4PFv
         fQ9ndEJfozz0rWT9/cGqT8iAS34ExDVJKNrXvt4BaK5/X1LXHG0EPLAtg9XR0ormjmRK
         yqTeDigqXN2GmvLdb3I0K8/ohOUEHMVsejQ+XFfxwbUZgKDDIiRQ4yBzBDnLn+ZvFYIA
         UdrbuyBjIsdVEpoBm5vpGuudiHSmgGdYUomx1xGsqaw5/Xh8yt8cCRfo8NLjPwFozYG2
         Lb0H0e/YqXVe24VJrZcIoInZLp4GusHD8cxkmuxBBSP7WT4kpb1mLvNNaDTTElZDAioP
         31zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698698778; x=1699303578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHWL46G8NXkoKAdE2/pXu93JSdaBuXUlUxnrvTJOdOY=;
        b=eeVkyeaDcgjgDP3TQnICETlu4COBTSyTPKvUQsQmdVFBTvDgCCg6B9MkiAChEwuIla
         9LEMSuz7UQ3VF9KajEU/LP+HaGyaj3suNwWSt7VX/WN2QCnlXgSwAoi5fh9p3sACnACH
         dB2I3icudAL7wFOGUqjwJVwy0jr9yTv5pyhV1/vcp0IQpIJo3ic/9D+21XIGsrMj1p2q
         QYgMC30x2ttoVVGZS9gkQ7mqeS0p7sQSxAOPfrAJ7m3fBuenRoC/pBha/yRv7yNW35BZ
         xhmJ3EtMAkLrpLIJEideagjSecAxY1639dpOoW+gGsONrpoQM3CZaBDqi7Ji25kCFWTB
         lzFg==
X-Gm-Message-State: AOJu0YwwuBL5oGFzFXvtgB+sjhbBg0jwfK3jTtKF3v3UEUpn85XO1cIV
        3XUE6m1gZ0deUd1D/+iJebVun3cLOYAfTM662e1AAsPHPFrx0zDx
X-Google-Smtp-Source: AGHT+IH7Dib57XvDiKMu/5BfJ4q/bfY6Uc5iK24QoDCMGMXOqPPDiJXdm5FbY1GzK8H6oKpjuiUed0mr05G7KpFVtas=
X-Received: by 2002:a05:6808:8f6:b0:3ae:511e:179e with SMTP id
 d22-20020a05680808f600b003ae511e179emr10833202oic.54.1698698778622; Mon, 30
 Oct 2023 13:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230913053343.119798-1-poseaydone@ya.ru> <c36c2c196670a36f32cc776869e91f710c237400.camel@gmail.com>
 <282881698597547@mail.yandex.ru>
In-Reply-To: <282881698597547@mail.yandex.ru>
From:   Matthew Pisoni <mmpisoni@gmail.com>
Date:   Mon, 30 Oct 2023 15:46:07 -0500
Message-ID: <CAJgVWNfTO_8bcOnbNC4mXdignS5Z8beQUDxjQkQ+R7BfBiVnzQ@mail.gmail.com>
Subject: Re: [PATCH] patch_realtek: Splitting the UX3402 into two separate models.
To:     =?UTF-8?B?0JDRgNGB0LXQvdC40Lkg0JrQvdGP0LfQtdCy?= <poseaydone@ya.ru>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Shenghao Ding <shenghao-ding@ti.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Luka Guzenko <l.guzenko@web.de>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay so how would I go about getting the following line added to the
patch_realtek file?

SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM",
ALC245_FIXUP_CS35L41_SPI_2)

It works on my machine I own that model I would just like it added as
other models have been so I don't need to continue to patch the kernel
module when it's already been effectively fixed for others.
This thread looked like you all were discussing modifications to that
file for this issue so I thought it might be a good place to start.

Thank you!
