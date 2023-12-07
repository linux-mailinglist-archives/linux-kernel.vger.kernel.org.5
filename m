Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E35808637
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378809AbjLGJyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378695AbjLGJym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:54:42 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C019A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:54:48 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5d8a772157fso4457617b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701942887; x=1702547687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE7xYQUlzv02mponHAUbU9YxaUMHPxUWeHaAlOpaiO0=;
        b=muUcdWEdZBQSHf5DcrG9edy4cYcAeoXc6q+aqt85J0QKd7YubFEQBeH8NDEuJ+o9cM
         PmyB58KDxa3L5atwABY4KZFsSTC8g6xrh/+jkqIpEmfhyjZKdxQS3md8TiQLi7CoI+mo
         LcLTepAFJP1Al5ljPBF0gmPGOzM2IVv2v0SdOTXzTrpl0t5IEXsIJXiGQw1WNTrdiW0+
         W9OgiHfj6yvO5v+80eAX7RqMGSbP8//Ku+aPiP2N1nr7Cp/IQufFnydKOy0+4BZLY40r
         iQDrXVSOeIIgUewAoMzhbQmA48Dpzs+HbYUAxK5Sy9CTrLSFszKyd0C9Uq1kfXNbLo4m
         e3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701942887; x=1702547687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE7xYQUlzv02mponHAUbU9YxaUMHPxUWeHaAlOpaiO0=;
        b=rF4KmRrMMj26t2iVKYuJboMcM83R+KRqR4wvJw2QRoRzrqaKYiJj3pFksMFDetfg9e
         a9yi0sBJ/JQ4en68jQn3X0XDQTenZWni5/AE6HpNttuoK+JbdL02AxXk4JoizeASmZNa
         jBnIKItNfZP41bc+gkwwcg4G31jqSZcr/G5J9Jm+olTCOmX6qvXZuPMyEluSbQIAzK5I
         jcODG9mYGYCv3oYhDFX6jv6oCAyI1ITTTlN6ZE8JDMJ61myR9tlbHpb7/FnjoQRXSAV0
         DamW58rLBgHRz2kGyeAV22D/rNGAKJRQ51BWCUOPvknLm//eqLofMqSQ19OA7nrcMeOL
         iSRQ==
X-Gm-Message-State: AOJu0YzkpHPUivXYX7KfcAJNFzA0LmFEQ6ie3NqxuzYCTdnxIjUNxI15
        JUEcJImh9l5lzWRmb4F9nn7AUKX6nH0FEwRRQQBZ1A==
X-Google-Smtp-Source: AGHT+IEOjV+e4fO7tLGjEoQWjOkdeRdGdcIMPsTYSMvX6xAX0W3EEwj2XzT9z0JeD0O7EwAjfnACJWMxZ/0hDFeMo1s=
X-Received: by 2002:a81:4515:0:b0:5d4:3596:5ace with SMTP id
 s21-20020a814515000000b005d435965acemr2061763ywa.12.1701942887739; Thu, 07
 Dec 2023 01:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231204160033.1872569-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Dec 2023 10:54:58 +0100
Message-ID: <CACRpkdYVTgNCdDE6qK8wnbPAL2=S6RyDQYwPUVdtfQSSTratnQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] pinctrl: Use struct pingroup and PINCTRL_PINGROUP()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 5:00=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> This is an excerpt from v4 of the "pinctrl: Convert struct group_desc
> to use struct pingroup" [1]. The series has been compiled with GCC 8
> for ARM64 besides x86_64 GCC 13 and LLVM 16.
>
> Changelog to the mother series [1]:
> - added a new patch against Renesas code, so no warnings will be seen

Patches applied!

Yours,
Linus Walleij
