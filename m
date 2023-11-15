Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134B7EC58F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbjKOOkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbjKOOkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:40:20 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4629CAB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:40:17 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7be55675503so1798725241.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700059213; x=1700664013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x+AROzqaSUGbYJGBNTViIpRJb4Xy2XNSOVc+/9rb+0=;
        b=hTE11iOj6ao2XPi4e9DcWvG1W8ZZ0jSmv7m9GH0m/pYz68ZcgowEo1dObT9bRfjMbq
         YZw+bWAHTIP/wk2aKg2SXPfF9/4T5JvhrptviHtcTlILBEO3aryZHl2g7g+iuzQ/KqJ0
         O9wR1UvI5oD5WOb1fLQmrb1nXpiYBcsCA8ThEREVAgyJD1+ngREb7Qafp2lpmF4XOBUg
         s4lwqOp7gvvl9SQWkl8Mv9CNBSkTHJ1mR1kRlAm7Rji62sMKrTeR4FHw2YBN2PAVcxcV
         cnb/P4QcNCDPvt+f0U5h7fzpzW+GdjI4A2vTd43fPFw7xOVTQGHlAnt1k5AEXQxquNLr
         eYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059213; x=1700664013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x+AROzqaSUGbYJGBNTViIpRJb4Xy2XNSOVc+/9rb+0=;
        b=nYuBWE4TcMONQOU6CGQ4XQDTvBorTA6q+EeG9rxal2DMD5F27YvsShH98M08fXIe+z
         2qD5vlR8FseUbfUpPwD21dtfs1UZyS00uwUPx1X+aJAErBy2qctS177Ys88SaNpWaNuO
         Mqt595AvMt7I0L1cfW9jgy/lTkxmccdtWqClbW6Yzoo/eOGdS87V4IFHmpVvqAiPog2u
         fkXF2duZBtmpBOeszNFcMmhZlsqub2gGF/LheVQCI2OO6Xmm3KHrc3urk1y+h+oP3P1F
         wU3mcBL1dWbWsP5APrbc/NhjOR7yLYqL/jOc9d3tg5qArJxHnpVhKZ8r3VO9xYIdBG17
         X1LA==
X-Gm-Message-State: AOJu0Yx5bWTIJwaeB+5fmPu6zv6eg+hdWp6t4Tc+bRY9GiS9rDNXDu2B
        xLzJC2ZbacTPgeeeagZ9DQ3zIC4IZR3QRb9JOmYx2A==
X-Google-Smtp-Source: AGHT+IFSBUM4YtIzlDwxJKuvSy5YJ1owFz4UfEiN+Yb8y94S/oC+n4+FP0cbt9m2DQBQkPYOvzbRxgVd5sfQol8jHiU=
X-Received: by 2002:ac5:ccc7:0:b0:495:febd:9187 with SMTP id
 j7-20020ac5ccc7000000b00495febd9187mr13178237vkn.0.1700059213161; Wed, 15 Nov
 2023 06:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20231113023434.1186043-1-samuel.holland@sifive.com>
In-Reply-To: <20231113023434.1186043-1-samuel.holland@sifive.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Nov 2023 15:40:02 +0100
Message-ID: <CAMRc=Mc=nzkTxVyYkg0y8r5cW9MDKD7LZggfmj2jtaq68yamFw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: sifive: remove unneeded call to platform_set_drvdata()
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 3:34=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> From: Andrei Coardos <aboutphysycs@gmail.com>
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>
> Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Applied, thanks!

Bart
