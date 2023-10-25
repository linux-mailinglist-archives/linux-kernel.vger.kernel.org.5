Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AC97D74C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjJYTuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjJYTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:50:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77E21A1;
        Wed, 25 Oct 2023 12:50:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c50906f941so1538451fa.2;
        Wed, 25 Oct 2023 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698263403; x=1698868203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHfvnUbqg9GtaO1sB11RiBDoSfdRrypjGI2a/Q+8XQQ=;
        b=bOVtHpJsxD4cx3oyJTS/0IVxuILyUHezuL4579KB9y6LP0qhXEdMNHA0NvgqY8G/vC
         bAk5CiYkyFk7N4Bt81H/k4jrD3/LhlaU0EaC7rLY/QP0pcYu3bMPJhG12d4ODQhlL3mp
         NIcsm9SBw4fKJLCn/j4LRTDQnYMrLs/HcoLCjSThV6wW3UU3M/eUVEAVqc/yMzbs7o+x
         6id1ktYVbLZo5JuPpcFLIyA3C3rQK13NGgSm66rzziXefsHJu+BDhnEmJYrdYw0xpU3X
         f79BVtzgyDXpfP4RXJEg1/ikNCfFP7xhSoNs/IJSJRnA2673J+xYetAlXeYGMNuSIl7V
         4UJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263403; x=1698868203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHfvnUbqg9GtaO1sB11RiBDoSfdRrypjGI2a/Q+8XQQ=;
        b=sT7NsU5Jyz2YSxDkPDNkkAwIQLLLgfEWAsL7IA4V32wxIEiITbcjbpJSpVQE0c9l5M
         lRSceVINQdNJogUo2X/pJOYu5eg2cmG+ZSJhDPt83bTj1Y/E/gNhSyPTCntNmXg7K/zW
         9Xb0FhHYOSom4KcQAhVw6IuYB9C9rMJtAOaIUQulcWqlU0nMNWl8GK4xmzrURefstc94
         DQa9jjjAJmrf0brHGsRE5lgIL2BCDJHzpwMYwYFPoVO8poDiRQ31r2/VieHaqUnED9IS
         o6V1uHQwmigNLoboDd/A4+amuKojYav9ccqVun5gD3Anhjv2dE7fsfTkTI/AgfC9p+4R
         1CtQ==
X-Gm-Message-State: AOJu0YyB0Jyc2bkFNYnSIKd/7tkeXRnUKW5N0J/fmQ+bWGUGwvwCI143
        pXgHUPCI65Ba4zy+OdH7984UIIJY7DNvPmHgeQIgDUARhsu6SQ==
X-Google-Smtp-Source: AGHT+IFTSIFhk7YK+RtSUQtz1foEIyZxmQA2dcXEGjb8hG3jcEut0JFjg8m+QhAobRlv9Wn6NZ/NFyUUAUASKYBl2LM=
X-Received: by 2002:a19:2d5d:0:b0:4f8:77db:1d9e with SMTP id
 t29-20020a192d5d000000b004f877db1d9emr11554827lft.12.1698263402639; Wed, 25
 Oct 2023 12:50:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231025091550.21052-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20231025091550.21052-1-lukas.bulwahn@gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Thu, 26 Oct 2023 01:19:51 +0530
Message-ID: <CAM+2Eu+yjguvkZLzAw6u+Y3PxT5JDuOEWtJSfv-U-C5mdmvL+Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: correct file entry in BOSCH SENSORTEC BMI323
 IMU IIO DRIVER
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:45=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> Commit b512c767e7bc ("iio: imu: Add driver for BMI323 IMU") adds the
> MAINTAINERS section BOSCH SENSORTEC BMI323 IMU IIO DRIVER and refers to a
> non-existing device-tree file.
>
> Probably, this mistake was introduced by copying from the BOSCH SENSORTEC
> BMA400 ACCELEROMETER IIO DRIVER section and missing to adjust the file
> entry properly. This is however easily caught, as the script
> ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about a brok=
en
> reference.
>
> The related commit 77583938740e ("dt-bindings: iio: imu: Add Bosch BMI323=
")
> adds bosch,bmi323.yaml, so refer to that intended file instead.

My apologies for the silly mistake, and thank you for fixing it.
Reviewed-by: Jagath Jog J <jagathjog1996@gmail.com>


>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a493d96ffd85..82ba3695f614 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3642,7 +3642,7 @@ BOSCH SENSORTEC BMI323 IMU IIO DRIVER
>  M:     Jagath Jog J <jagathjog1996@gmail.com>
>  L:     linux-iio@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
> +F:     Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
>  F:     drivers/iio/imu/bmi323/
>
>  BPF JIT for ARM
> --
> 2.17.1
>
