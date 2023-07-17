Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB527562C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjGQMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjGQMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:31:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21A51B4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:31:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f64817809so453657a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689597110; x=1690201910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhtKDGLkYdLlMzTZE+T1BryE5vukkd/SRUwBcJXGkYE=;
        b=adSle6S4qsLISaMws72/D7IY0mwUp/nesW94VNVtbmdc6XDZ7TC6TFQwBCdStwhr3F
         07xlBBvutoTmqDWX/XDMJluLs4bdCB/ow17FqmqN8vaCWz5n7bVCbbsZXfk8EPuCXVwT
         nd1uhYhy2sZin05dMd8A3na86l/KiYqagH6mb/T15SOtsl/FXwRH1E9HSbj31BkFexdX
         WvoQ6LdhwlRT1N3j9KU+98wympgjOrdQ0P0Atno/H2W2OOVjQMKTWy1PF3g5cpOs1pVw
         HUZjoxHjy7yTb5SJf4JvtptbWgVGyLBWKLu0TARWVQ7GwUkoe0YsPdoDm+f1qudH2c3H
         iquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689597110; x=1690201910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhtKDGLkYdLlMzTZE+T1BryE5vukkd/SRUwBcJXGkYE=;
        b=LPd1gYEGpw5z3gnLWhEGm/c2RpFuiJw1+Fo5aa8bohX11ssNofboOkFinwHROL0wSh
         S+lKo/hdGo7nqdvWbiWjjmSZUKpMM78h9EIS6rnxr8iRgiT7Tu81xYNdSuk+UxGrOi8J
         pavpVzEYPUfPI7Wq9J81rR6IaefCoZtxXNRF9Avk9iPvXjN6UG8R1XinpFUod4eh+V0R
         eIQ0ibGBIGFRojZ2Roblhdxa5Ib7wXs24QCouPodZM26HBsRD8rVhd94PrEJbG9dnyeJ
         6dlbcXOkEWjBln+oEuMaft32xz3tevcyDk696pSGewzCrmOHT82VE24wHo7UorebCwQR
         cLrA==
X-Gm-Message-State: ABy/qLajR8qhJ1Q1wlnJ5I2eTXSvvqxkKn69RHtbj3A1wwFrbDjHLi5N
        6NI4Su3lZwqv6og+9T82AnwC/6Nbc3K2JCDvgIA=
X-Google-Smtp-Source: APBJJlE88ZKilmPeyPMniQza3GQ3pBQrLfygkPj1jJXbn1/AdXpYoB4MvfL+s0Esgs/EA1CzPEUZ7pYqEn2WGR3dgH4=
X-Received: by 2002:a17:90b:3c43:b0:263:484c:f173 with SMTP id
 pm3-20020a17090b3c4300b00263484cf173mr11550745pjb.2.1689597110032; Mon, 17
 Jul 2023 05:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230712124934.32232-1-matuszpd@gmail.com>
In-Reply-To: <20230712124934.32232-1-matuszpd@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 17 Jul 2023 09:31:38 -0300
Message-ID: <CAOMZO5ATTK7UsTRPTF_7r86WbNmAhtpEphO2u896QqARTk2kpA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Disable bit clock with transmitter
To:     Matus Gajdos <matuszpd@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 12, 2023 at 9:53=E2=80=AFAM Matus Gajdos <matuszpd@gmail.com> w=
rote:
>
> Otherwise bit clock remains running writing invalid data to the DAC.
>
> Signed-off-by: Matus Gajdos <matuszpd@gmail.com>

Should this contain a Fixes tag so that it could be backported to
stable kernels?
