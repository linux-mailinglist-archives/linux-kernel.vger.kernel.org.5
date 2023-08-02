Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB98576C62C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHBHNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjHBHNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:13:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22D72116;
        Wed,  2 Aug 2023 00:13:15 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9aa1d3029so97075721fa.2;
        Wed, 02 Aug 2023 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690960394; x=1691565194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2buEm2gDrf1fNgEA1fBvBUhdIcoSkeNWypy9BrDWZro=;
        b=o/Z0yMvRj/sHbGhhlNrlERgGL/vkblmm6ZJLHQMACyDwmmKmNZYvTU/06maEeEpfRp
         Qykwe/MywZjAj7CgMOPhkGkeYcF/+NkNb9nzn50MZU8ub6CiuIOy5wlQaHDZiG5zxPFm
         hOwzsQe8rXq+FQKiuPeG7nEpdZeTr5wWh3uyQZddDw1dVz7T+jkLOZ44dHXGhKyahFF8
         RSn7gC04V66HalFvzQXJfxycd+4lyPUNPP2wu9sArTQK6awUl2bONG+SgQvFn0/Nru7D
         YNyTWzdXp1bb3ibxDzOjTS6ZOvdtOkGS6gwUlv+9CUSZEiKg1xeVsqCq30sD7eJNrEvF
         I9bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690960394; x=1691565194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2buEm2gDrf1fNgEA1fBvBUhdIcoSkeNWypy9BrDWZro=;
        b=XUFzgcNj1+T+ja5Sme+MS7rFnPURiwiWAPyenGLL87LNjA6GW0opjGW+JzKm4M5A4t
         /eF7odK+e4tWp4wRapv/vBd6omuW1fvEwP0ScDOzK3fyCl3xKCP+iDn4HEW7ofmNrf+D
         xi91SNc6Q5Tki+R87S9sJ0nH8Pjj+6Ik1kZBr64iEdQXtTlR14qTMfgaBCgWMZ11GK/4
         A5CnyqsSPdslVCNT0pDlIMpjWjerkHBP3DBlbxfZzMi4PIltHBYc7VDGBBIryHRdDWLg
         EMu5Gek5SIEesNZ4orUfLxy23ffT6Qe37kPwdJWFKIK124NNxJ6HtqQvn20bCyHZreXn
         h90g==
X-Gm-Message-State: ABy/qLag+rMIB8Mh3pkcecgn+d3kM1MQau1zI/WW3M0E4B6vIu6b+QSv
        xjjMtWQhcFOU5jGHdSwoU0jnrY+wwcpieVXhqKk=
X-Google-Smtp-Source: APBJJlFxZVa5Xg7zcWRSLmy5da3OrRqJyEbYh7IorsIlR3vmcIxbFVhHJnD/w70xPRJB36NtVtlb3OCXjqI+33+VmtI=
X-Received: by 2002:a05:651c:106:b0:2b5:80e0:f18e with SMTP id
 a6-20020a05651c010600b002b580e0f18emr4150209ljb.3.1690960393778; Wed, 02 Aug
 2023 00:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230801173544.1929519-1-hch@lst.de> <20230801173544.1929519-3-hch@lst.de>
In-Reply-To: <20230801173544.1929519-3-hch@lst.de>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Wed, 2 Aug 2023 09:12:37 +0200
Message-ID: <CAOLZvyGAahsfqS0yMZDaHNVxLBC9QxKGEdW1TRfM_EgieCeORQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mmc: au1xmmc: force non-modular build and remove
 symbol_get usage
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
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

On Tue, Aug 1, 2023 at 7:36=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> au1xmmc is split somewhat awkwardly into the main mmc subsystem driver,
> and callbacks in platform_data that sit under arch/mips/ and are
> always built in.  The latter than call mmc_detect_change through
> symbol_get.  Remove the use of symbol_get by requiring the driver
> to be built in.  In the future the interrupt handlers for card
> insert/eject detection should probably be moved into the main driver,
> and which point it can be built modular again.

The carddetection stuff is entirely system-specific, I don't want the drive=
r
littered with board-custom stuff; I'm fine with it being built-in only.


> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/mips/alchemy/devboards/db1000.c |  8 +-------
>  arch/mips/alchemy/devboards/db1200.c | 19 ++-----------------
>  arch/mips/alchemy/devboards/db1300.c | 10 +---------
>  drivers/mmc/host/Kconfig             |  4 ++--
>  4 files changed, 6 insertions(+), 35 deletions(-)

Ok For me.  If it matters:

Acked-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks!
     Manuel
