Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB57802FE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343758AbjLDKOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjLDKOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:14:17 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0769D5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:14:23 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-db539f21712so2150251276.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684863; x=1702289663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6T1DQnSXHpRdTd/LbBCSLbNlM8eSq6nAzUcVYf1VEk=;
        b=Pb0AFZ2LmsJ7dhpXT5xnsH5/wNR4NZL7It5bY7zdIhPvjzwTxUctt23r2ApzHk3XG+
         qXUKWHtpUBj6d8lhh2axjGxozUAJqwDtcVNuJYd9/eSGLrnWX/bKRQOjzT/aTOjceabB
         pTIKfb33Sq98Mok/ZTO3/ELKjS/0xHs6ET5q4sApNqOi9mXNkxV0pkhZhVIptZ5SOO/i
         um/wAtfPqYXuQW+/i2HwFPLkrwC0TL/OMjoR2guMhdVIXs8sEzPt9tnTAyZy51eNGVEZ
         OC6ceHSLyqF8FdtWtkkK4zuJtakngf3Q7Ii+fdMa99GL4fNFjM/I3yG3rxbCCPUJcCyS
         Y/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684863; x=1702289663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6T1DQnSXHpRdTd/LbBCSLbNlM8eSq6nAzUcVYf1VEk=;
        b=SvdV2AWS5XFtB9sO+rQiTq8vndNT6wqiQ02PT3GPCy0aZ1DecuGF1ofwDru8TP5KwP
         CpVcoy7FPM0n2vqhcDf1FHJF5+MXNdULncLrIWpAp0RlVcM6a8/MEo2Fa0gHwMB9d1IC
         y+zTj/D1U1hEqBzPSWKqQql2ddFbxi87d3DEFJUbzbG4xxUWYjrnLgeBiTESHyc1Dy9+
         tN/z0OZrq3ivcpPODaCtn0kJDbzahutk3aPmkiXBgRdoJPgekOT6HIVe+W6VmmS2NH1G
         IGJkAx0flqf8pO/+B1/5SEI+1Tl/U/QXc3RRIv8doJ2LrOWA66i6bKei63NYGmiwj7Rr
         rSkw==
X-Gm-Message-State: AOJu0YxYiKWjlN6M6KcWHxhJ8qwMTUysl2e0D9SSWIjjVJUHDOLet4mM
        J7Spd396kquLu3CPvpSTV4ApjBT8GgwGDfP+TGAoGw==
X-Google-Smtp-Source: AGHT+IHhuDurJ8RdbjXooRiGJLv52npQVT6/Px+lFRxxtrp8WQLTQQplQz795ifTJ1edDRCXEJYqWVyVZzD1Wpcw/tw=
X-Received: by 2002:a25:6f8b:0:b0:daf:6330:cc1d with SMTP id
 k133-20020a256f8b000000b00daf6330cc1dmr2323965ybc.24.1701684863177; Mon, 04
 Dec 2023 02:14:23 -0800 (PST)
MIME-Version: 1.0
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
 <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
In-Reply-To: <fe4c15dcc3074412326b8dc296b0cbccf79c49bf.1701422582.git.namcao@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:14:12 +0100
Message-ID: <CACRpkda0wdVgwTjX4bF411TEeZ96H+sqZVXaVgh4d5S2Ek_eZA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: starfive: jh7100: ignore disabled device
 tree nodes
To:     Nam Cao <namcao@linutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Huan Feng <huan.feng@starfivetech.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 10:23=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:

> The driver always registers pin configurations in device tree. This can
> cause some inconvenience to users, as pin configurations in the base
> device tree cannot be disabled in the device tree overlay, even when the
> relevant devices are not used.
>
> Ignore disabled pin configuration nodes in device tree.
>
> Fixes: ec648f6b7686 ("pinctrl: starfive: Add pinctrl driver for StarFive =
SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Patch applied for fixes.

If there is some doubts about the saneness of this patch, seek input
from the devicetree maintainers.

Yours,
Linus Walleij
