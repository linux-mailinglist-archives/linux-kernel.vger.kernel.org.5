Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982DB7B6CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbjJCPNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjJCPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:13:39 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA44A1;
        Tue,  3 Oct 2023 08:13:36 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6c4fa1c804bso672651a34.2;
        Tue, 03 Oct 2023 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696346015; x=1696950815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8aCsMQXsiJpdwq9EITe7uDvfQZFGnH9kasY1jCayPo=;
        b=b221zDYzWWQ8q9mvm+98fgXuTaTh67o8+VNjWAPQXfBC9AU9LOL45eEid39KdDiwV6
         TJUDpOQIyjfesr+Cjc+nQqA8eOp0A/rA7IIreZUgvwyYz+zNdP1pKpmthju+CJY9Gz62
         bKFWw7j5iBDi5NuFzyy/4mHMeSDCDi4HhHZolQw2Tw1+CTKgxuqCeaj6mlEZ1ULd55IN
         /u72YDsfj5EPdiyiR2cGprvmOR/qEWJWGaZXmEPr+klOPDyxHJrF3zh9diCKP/6jG/+C
         jwIjTGkIDDnttCEO8UIkgPthv+mMSKQRxoyj/JKM1C7wFDXPOcBYVNDfrnukVDD5inUS
         wOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696346015; x=1696950815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8aCsMQXsiJpdwq9EITe7uDvfQZFGnH9kasY1jCayPo=;
        b=WZztub3wb4ZKDQo8aV1Tzu2TDCfepEzIc/v24E/ahImn7ggKwsiusMoskoeb4vPPWG
         JUMhp/ew2QsH3lgMesUSQFqqJEcd6xgABZvAvPzF67beR0STjs5q6DrpahBiNFr1rl5I
         1W/uasYGIM3FnGKZ+eQj8NXwtIva25a6REG+UPKcvmwwm8MNe6HYsWZZceIGxbsHImCU
         pJea4e9mHbzdMlalzYF0epu2xy76Ls2QClqeP+jcwGWyd0xapRfA0t6I4hgpP9+nuwwD
         WCguu3TKR7e5N6vBJEzDOoxSTHLkpR0gReNnsFKuWdxetYXk6kRoCRklPBy1MVDQR7Az
         2Dxw==
X-Gm-Message-State: AOJu0Yy4cZvrd6vN2aWKBbY/+vVEA3rPsl17KrPBWhDFGZmU28iiw1CY
        Hg20rEOFDiBQHbOoSfSaXS6lDfIIija7FxyBnas=
X-Google-Smtp-Source: AGHT+IF5LmhQYBEALuv4tymjC02rLV2yDcWbglnO+4YZIvWLWHyFpO5WP/XfH/HhDAgamRgxSlZkRaK4Gz7U/5H9s1I=
X-Received: by 2002:a05:6808:2391:b0:3ad:af12:2fbc with SMTP id
 bp17-20020a056808239100b003adaf122fbcmr18291731oib.38.1696346015433; Tue, 03
 Oct 2023 08:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231003145114.21637-1-brgl@bgdev.pl> <20231003145114.21637-29-brgl@bgdev.pl>
In-Reply-To: <20231003145114.21637-29-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 3 Oct 2023 18:12:59 +0300
Message-ID: <CAHp75VddLwh5jbzAO3GTpsYSLpLFRsuY_MoSZk64iKd_7fKRqw@mail.gmail.com>
Subject: Re: [PATCH 28/36] pinctrl: intel: use new pinctrl GPIO helpers
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 5:51=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Replace the pinctrl helpers taking the global GPIO number as argument
> with the improved variants that instead take a pointer to the GPIO chip
> and the controller-relative offset.

With whatever name of the APIs at the end,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

But I want to see this to be in an immutable tag / branch so I can
pull it into my tree.

--=20
With Best Regards,
Andy Shevchenko
