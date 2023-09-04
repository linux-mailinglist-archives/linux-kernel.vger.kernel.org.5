Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622FF791E2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbjIDUVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbjIDUVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:21:48 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8F184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:21:44 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58fb8963617so17542997b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 13:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693858904; x=1694463704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIdGcDEg2RFpVY8/WSXPv+0h5xxmY9R8V3wRWCGVCYQ=;
        b=wH6Wkp3CC4Oy4BUiHAGfjurSB1/6/DCgJ7Zq/mRpkla3AT2yuyHZ2wmqX5fJGrfmNH
         kH6Fzf0/3imUKw9NEeauKXHmZBJ5ygY3xNBOMwbdlwcDtoHxWIAYgutJGIoS/Fj1zjl5
         GHCJ3vmzTE3u7PxNBo55WoNnY5KEATegaU6S4c+9kcFGn4x7fdH3nLmKqd1Fd23SnJcm
         arfXrOxUup5B+yZy+6vkNhAMJe57AhHl/9M/hvtYxCW/TXKd48K58ryEtfVyNHLYIHYT
         dMSRIxN54Gpth9seQlJnXMhDS75m79stnBidMxSTRklTnbyWqQASsACiDSce1ONu1X1f
         ujcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693858904; x=1694463704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIdGcDEg2RFpVY8/WSXPv+0h5xxmY9R8V3wRWCGVCYQ=;
        b=iXEsD+1EDl5ldIBjwZ8niDc4FjC23AmtupSR4nn0H/FpB1HWiQD+JYJ8LrMizIVCD8
         GGy/WejOJxvjaymYPpZ8ruLgPrtPq+Kv+8b5L+7WpKmdSliTxEQzAg093LVb1J4D6HwM
         pWNbQhNbeIyacVYQ2mKwuM8dGGdoopao6BxQt7vI7M2ouNKeur3c9aF+oQxjMQ50DcBP
         DIPOUyuBtp0zSX4gLksJBamVswIeHlf3HRIZrM/H5JGB9SD8EiglUnKLlTYmGfRUA9VJ
         nIL7eVRbBxh9YN98Rsr7d0mVW9s2S/q8ODsK/+F11HaaCikLDw5UvoENWTQs92gCmmZG
         86wg==
X-Gm-Message-State: AOJu0YwV3Fpmi8q5F1RKFHPP6wyFOJ7kCL0Ukf+ZyUMtL2Z/Vdp81MC5
        89RNQIKtIBDynkVIdPjyFBh+CYh7QKEK5XCSxQ2f2Q==
X-Google-Smtp-Source: AGHT+IEzdDqxXs9QZDSllPejOTay+Awx9NDl2MJSCZD3I3yUhS5JtosXX53OvrRtmVX5RO7qxnOT9Utgiiu/XFH+ve0=
X-Received: by 2002:a25:e6c4:0:b0:d4e:3ffe:79d4 with SMTP id
 d187-20020a25e6c4000000b00d4e3ffe79d4mr10203380ybh.61.1693858903883; Mon, 04
 Sep 2023 13:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230904114621.4457-1-wangweidong.a@awinic.com> <20230904114621.4457-4-wangweidong.a@awinic.com>
In-Reply-To: <20230904114621.4457-4-wangweidong.a@awinic.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Sep 2023 22:21:31 +0200
Message-ID: <CACRpkdZ8Q0hWx5GLsJR+kmnkF6cMwY-ZJjePX5WO3qmXv8uJzQ@mail.gmail.com>
Subject: Re: [PATCH V1 3/3] ASoC: codecs: Add aw87390 amplifier driver
To:     wangweidong.a@awinic.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, rf@opensource.cirrus.com,
        herve.codina@bootlin.com, shumingf@realtek.com,
        rdunlap@infradead.org, 13916275206@139.com, ryans.lee@analog.com,
        ckeepax@opensource.cirrus.com, yijiangtao@awinic.com,
        liweilei@awinic.com, colin.i.king@gmail.com, trix@redhat.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangjianming@awinic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weidong,

thanks for your patch!

On Mon, Sep 4, 2023 at 1:47=E2=80=AFPM <wangweidong.a@awinic.com> wrote:

> From: Weidong Wang <wangweidong.a@awinic.com>
>
> Add i2c and amplifier registration for aw87390 and
> their associated operation functions.
>
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
(...)
> +#include <linux/of_gpio.h>

Please do not include this deprecated header.

Also: it seems you do not even use it so it's unnecessary.

Yours,
Linus Walleij
