Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80167F86B2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjKXX16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKXX14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:27:56 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2404410CB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:28:03 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5cc69df1b9aso22357897b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700868482; x=1701473282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2T6xhJOCHBr72o8TDhfTjNe/mgHT5Nn+BnsbczQFrE=;
        b=atCpN4rzQC5g2+UIz/SivB0roFhN/AxR73FfuDxTNDxZGHUaRQYLYk7lrRkO4nsA2I
         OTgGpsuv/pwbgcLQEwupMy+ZPFKRf2Y8vex021aOTHXDE08sPfvsPfiCEgbukqDZI85a
         I5Ruu6w2FalLHzbm4BaBlpJXv6Ruo11FjPz4UuGKOfy8qcjX7LthIzJEAfmB6BrH092s
         SHfDNVFNUFiLcUbCGtJ90pYLVsMh8FX0pJG/DQCW+hYfn8dKngxgPQwdmHR/P45kcD7I
         5HauS9e6ohkNmx25AMLpNYCrF3c3Tek/2UC5N0ul11ejME14u+7N/vXmkc2wymfD8fO3
         RKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700868482; x=1701473282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2T6xhJOCHBr72o8TDhfTjNe/mgHT5Nn+BnsbczQFrE=;
        b=flPDCQAmSEfnJk/d4R1nS+nLzAiISYtIAAoIMNaoLmjkM8/MiQP6SnjLFNWBjjkEE0
         UUOms/cy6HX91XvS1lRRSNttFnnPxK2J9sLdvBFWZv5xpoN8DEg3qJXn/Qyyht9UQbzC
         CYXzDTkKmGne+12q4FZK6ylhomZBiDC8pmSiBmfO1Cl1NMx1w5zdiRM9VG1mt6ZjWzwp
         cxTxIvA04s4J+3jWw8ZIoNFTWTv+hKR6URHX2JWx9sEL5jPuwrkwgrqeD2xZcgSWyxAY
         +yjzIBTZm+tSEZh6M1GrqDNWekt6VYWX1JzzeP9a1gkzvWNhk1KzDKLEb0XqPOKNtkki
         dNaw==
X-Gm-Message-State: AOJu0Ywf3FFxEhm0e+vcX5JrcOmheZUTEdeCe3rzr/EdbJWf4SWHhAX+
        kqHN3LONEqpxzcJfnCnUZ0cbR/saAOXboxNymEYCKQ==
X-Google-Smtp-Source: AGHT+IEaF5uolA+HMAwWuxAWZeShooHQqlRPuQDzXT3Q0kiEp69ZHcnKhaqRDxjLYLhGa+UtUv1SkhJpjGvdrp4VFWg=
X-Received: by 2002:a81:8843:0:b0:5cc:e5a5:d951 with SMTP id
 y64-20020a818843000000b005cce5a5d951mr4563960ywf.45.1700868482367; Fri, 24
 Nov 2023 15:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20231124193816.30412-1-brgl@bgdev.pl>
In-Reply-To: <20231124193816.30412-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 25 Nov 2023 00:27:51 +0100
Message-ID: <CACRpkdZ44D2_dxdwa13z9c0Upu_VUaZJHHkXZMQCnms0UKvLbw@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: immutable branch between GPIO and pinctrl trees
 for v6.8-rc1
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 8:38=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> Here's the immutable branch for you to pull into the pinctrl tree that
> provides the new gpio_device_get_label() getter.

Pulled, thanks!

Yours,
Linus Walleij
