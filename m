Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72CB79E7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbjIMMLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240312AbjIMMLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:11:00 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E44E19AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:10:56 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4937fc5d66fso2404671e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694607055; x=1695211855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0h+IDkH/EPhWNrCCaHfFOfxcn7DChky2zhYIMwbRidU=;
        b=TmgSPSFEDxtnP3xoizSypV9xIWMICB6N2VQ0EZ3LfsdwJYdscxQ25PUOhy6m/hllP0
         Ygo1PbgdQeQfC5NC3uDAEWqERZDieLyln8GFsKDZA8xFPCwa/TxrP3JTVssASWEkm+uG
         ifS0TPLapsOzCQvolAofznn9Sgr73JjifbIw5okpt/7o1EVfyfKG9Py9l+clTP7lYZ52
         y23Q8fCkXeoivx/MUOCXxR95IRZtq3iux5cRJVyXfCeV3CSRODtXEkgZuj7JvMoZV1QS
         o9aFTWmztHRdrKcAnRMLkfoS9Sf7QccIXBEmQCIHzQYB0eFi90zIf4do7Qu4Bh/1PRW/
         QF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607055; x=1695211855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h+IDkH/EPhWNrCCaHfFOfxcn7DChky2zhYIMwbRidU=;
        b=oVGpLFXWenXbu5/xC7jQa6wp9UAujMTXGqC+sTCh7TxBfOn3dh/yesUa2xV4MwYqeE
         xkmZsv1AaCCdZQ6E/QHw5uKMakf3j6gqn5uVnsoeupil9TVHgFs6t9/4Xg8rUFdPTLze
         jv79ymW5YPbzVPknfVnJXUfg9lCXV83oNyT1G+r2q7C6VfMmHAmhDvfrMq2hY+cYGDXt
         Wd8Fx7xUsbU2QDOHhSH7ezAOaBf+EvNJ4l7TPVe94IjHLkjpvQjfbiNKZPwWnfY9me/I
         VdZQVaEw01v/JCVGlkAieEOJd20gJhBvz1m3E0quorpymfU0lqpqoJrJOCbizmU3YTPr
         /uNg==
X-Gm-Message-State: AOJu0YwD7u8M9SLFcb/Nlafjs7S+IK81iercpRI5twyhXYJTAYjdpzLq
        yW1Sk+viqyL5Jjj+kc4wQShXaCcIfIIBGdjntIzQmA==
X-Google-Smtp-Source: AGHT+IHMlKX8gvF9W0STKoQpbmwthU6PjMiEISQb3dqycuYLiaW11CdY4bSM54lBt/qXtS4emMd4bS7bJazrfHdiYaI=
X-Received: by 2002:a1f:dd82:0:b0:48f:c07e:433a with SMTP id
 u124-20020a1fdd82000000b0048fc07e433amr2188051vkg.11.1694607055259; Wed, 13
 Sep 2023 05:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230912122850.164150-1-michael@walle.cc> <CAMRc=Mcj77F7SZ6BxDimnD=2iXe-g02yG9KuFCKTj0m58SzOTg@mail.gmail.com>
 <0dc01be91d0958db93937d1628477b61@walle.cc>
In-Reply-To: <0dc01be91d0958db93937d1628477b61@walle.cc>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Sep 2023 14:10:44 +0200
Message-ID: <CAMRc=Me0Gd1XtPisU0s+xZZ_a4Yrs4F5_FDKHwmc4X7HQBhYoA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: gpio-regmap: make myself a maintainer of it
To:     Michael Walle <michael@walle.cc>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 3:26=E2=80=AFPM Michael Walle <michael@walle.cc> wr=
ote:
>
> Hi,
>
> >> When I've upstreamed the gpio-regmap driver, I didn't have that much
> >> experience with kernel maintenance, so I've just added myself as a
> >> reviewer. I've gained quite some experience, so I'd like to step up
> >> as a maintainer for it.
> >>
> >
> > Do you think about maintaining your own tree and sending PRs to me?
> > I'm wondering if - given the little volume of changes to gpio-regmap -
> > this wouldn't be unnecessary churn? I normally wait for you to Ack any
> > changes to gpio-regmap code and drivers based on it anyway. Otherwise
> > if it's just the formal role of the maintainer you're suggesting, then
> > sure, I'm all for it.
>
> No, no own tree, that's overkill ;) As you said, it's just some formal
> change.
>
> -michael

Fair enough, queued.

Bart
