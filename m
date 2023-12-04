Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34C8802FC3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 11:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjLDKMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 05:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjLDKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 05:11:58 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8223CC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 02:12:04 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d3687a6574so40819207b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 02:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701684724; x=1702289524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkXCJmkJqeWYd/zTDegc9H+KdUDHav8RTJQmS9NsaoM=;
        b=pdijNWDg+EvF4M+E/eR+fO8vHSzs56sKPbroIQ82r2KrpnRIpbr585JuRmMdGOlYic
         dSQVHPVOqlMG/8GGhZACEqT+rTeXhGH/Sc4oVQaNAtON9D04Fj2QiAMnCUubvqnrDeC8
         m1XaMPqk94xIdU1FxH2e1Pj5Ly9+LCAxdW5TqxMSQEJY1P66QgdjYruTwb/hZHXGGw7i
         xkP9iljc2R0D/8sSIE2tKRXzvj0OI/oTyQignNjo936QEHVqc97OquC86TSv6fZ1yHyW
         /r0fKd2UcciqWqjQihe/WYuAgHg7492tirpLgEOOr5HJdUdy4Q7PEx4agp2tTnIzpe6F
         PmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684724; x=1702289524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkXCJmkJqeWYd/zTDegc9H+KdUDHav8RTJQmS9NsaoM=;
        b=tzNYrSTu7mn7bG2giWPTmXSkwHAjL7/6t7KjBrJ4OEBPVXTFrALm8HDi1ML98CEQxP
         Zj/Wxps23cgTsjitvPlmXstLCkns5zgKqMIC0eStaj436sBe6BVuHUkzprnk6q0yjVPY
         yZxjO5JT4oI2/7R527u0j9hdezvOicPxLV3Lsg+jZ0MDTxLbb23HThxp0bBxqMbgZtW9
         a0v17+FydKljch6WJhRc5iyoL5S7VGo3tHB2rx+IfoOhriUR+0I/hG5PpYfKU2ogDqXX
         J/p5KTab6dWYJaEDSBzTL2Pgx8Yr4KoIUCI+DT351XLK9mxqagycxHWL5nLchx1J8Qcv
         dUUQ==
X-Gm-Message-State: AOJu0YwiizB3BSgMEHWHYnka6nCF4vfm1bgMe6iqCnaZbXWo8hxKHvm0
        6mdJVX6ZalGoH9Luct9//mNRpfm0Imux0M64Yfd44w==
X-Google-Smtp-Source: AGHT+IGRANTbZfpazl9zXKPI4jec0JQ5yJYaczShvgjPYYPvjqQ4flRZIPO2W6QsypTCTLuCTwb1KxCPPFCYFMYJSOE=
X-Received: by 2002:a05:690c:e0d:b0:5d8:10a1:f504 with SMTP id
 cp13-20020a05690c0e0d00b005d810a1f504mr1121233ywb.82.1701684724084; Mon, 04
 Dec 2023 02:12:04 -0800 (PST)
MIME-Version: 1.0
References: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
In-Reply-To: <fd8bf044799ae50a6291ae150ef87b4f1923cacb.1701422582.git.namcao@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Dec 2023 11:11:53 +0100
Message-ID: <CACRpkdaSeE84VNhYmgnhEOJAqiDfVjFbhZSXCMeUVeGiNFz+BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: starfive: jh7110: ignore disabled device
 tree nodes
To:     Nam Cao <namcao@linutronix.de>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
> Fixes: 447976ab62c5 ("pinctrl: starfive: Add StarFive JH7110 sys controll=
er driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nam Cao <namcao@linutronix.de>

This patch (1/2) applied for fixes.

Yours,
Linus Walleij
