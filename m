Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01597E115C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 23:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjKDW0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjKDW0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 18:26:51 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE9D6B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 15:26:49 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so3303988276.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 15:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699136808; x=1699741608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQchSbVVqTg0oG6VvjAb1juPI1kiDE4WO4qR/mLO6NM=;
        b=zQBqmF/j6WwXpFmp974ZaFYzJxij866vFZjHeDo/8Qc1J4fVuldFrIQLcMyJ/1hNRT
         PSmsozfgXjN8t6iDBm+/gYQ4EIpyLSxthiOblqSlSF/sefJ8gOUSmggqUWiNWaFB6081
         GGkuJ0Bk7Y+CQ6Zx3S4kRJ/PsLPIF/eodY9+8D61ndKSJWPvzRNo6Eof9+Ozt9f+wqLX
         I7e5tC1CdUvEHoKrLY+kKdfCkVGoJqYHLxXQz23FGvYL3c59Hdv/bEayvagI0exyOQjv
         FFA97jn0x9+fr2exmfuaq6GkcaEC1ls2dKZkoB5OnkfaJ1ebwmzNwbNPy6NRRZ80gcVh
         e/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699136808; x=1699741608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQchSbVVqTg0oG6VvjAb1juPI1kiDE4WO4qR/mLO6NM=;
        b=YcGrW9HODl8IitHQ3vrAb0XxECXzBTssV4BHsRIAS5Lc+MMNpo/fJou8hKMSrXrHPX
         f29+ZTIWDRRq/lXNUxM4+8bHsTyruKvrFXMR922ZrRMC/TngIwxOxHWBc1Dr5d2lwz/I
         sDBmPxNaF1FmbMrc9eq7Le9d3u/sNpxUyPV4o/pGli+Li6QxAjVHkbCuJ/X43dAg99JN
         VM5UQbApHrrfx2ooKpo9CDbEH7mwgnvhByAkOwNq69KLfG3kpjsT6kYK5C9V4YsU4zq8
         bH9h8s7kn+VU5IslYYDirFdLPgovlZV+bbBXAsEuvCiRLJz/kqr8dbC2TuZ6qJMQ/y8I
         movw==
X-Gm-Message-State: AOJu0YyLQIYydCUFaOU+nIB1VpJaDMngz9sLDml+Fxhi2zti1378u7p5
        cFmCHEOPGwqtHx82xDt5PtphzPDAJWMi+gbTNZTLlA==
X-Google-Smtp-Source: AGHT+IGUOlPgLekN4MCvK2txlBvcBAz5IKBDHubC53nrrr2yst8IsPZJOMQn8uhuwKQavHKfqW+6J0mndR6sW08WGSU=
X-Received: by 2002:a05:6902:541:b0:d9a:b67f:94e3 with SMTP id
 z1-20020a056902054100b00d9ab67f94e3mr23245243ybs.52.1699136808547; Sat, 04
 Nov 2023 15:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com> <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 4 Nov 2023 23:26:37 +0100
Message-ID: <CACRpkdaAkS=fehsdQtuC4_45Rd=hQ9LiThTOKxVOwabqHO=EoA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] leds: trigger: gpio: Convert to use kstrtox()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:03=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> sscanf() is a heavy one and moreover requires additional boundary checks.
> Convert driver to use kstrtou8() in gpio_trig_inverted_store().
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
