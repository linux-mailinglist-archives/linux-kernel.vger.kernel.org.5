Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4F7F303E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjKUOFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbjKUOFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:05:43 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD64D7E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:05:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b6cb515917so3735141b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1700575539; x=1701180339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/TcEF+FhqZ2nz6qvi/9iJUZggk71Tmqu0as2U0xGu4=;
        b=3JFzdoVXCUHDirJnVsMkGwwuXQY4e9DuM4YaIHoZFNPMSxUHoqRySYBWBdNqSMjEOu
         0kUmgIbpNvUMjVL7sWaN6vP6VOy374WcAWPNBTCq2sk8O+Hd83vgoMzJ62pLwDdVKRcV
         a0VrrFm/BROgonetQIH6hKq45kL4OqsJVRI6JYKjft4fxrMGxFdjY189G2cw8VQ+IfNW
         n7s/Ox1Y0BWueg/YmNGtZA+CmEb5iuvunqdYCCXla8pFo/YExJdVwSz/jTjYBpK5HQOg
         ZZwfNmcBe5+arf9u5/MVNaKxAuh24I560SfJH0zTPcKBcfnG6LI0AmFjrHVMmej//uBP
         ZnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575539; x=1701180339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/TcEF+FhqZ2nz6qvi/9iJUZggk71Tmqu0as2U0xGu4=;
        b=lSBUHFuTa/3fmbVRazMy/FNYZBSeShYvZmCQEaekiPiTM86L7TSwWEIdEduyhbD8Zj
         E002fBeOzOdjLiOFoWEnLWkx+kKeuKPJMEcywCS6Y1k6CDZLdHh+ectAsVaPgfJIgU7K
         Ds0hS6y8yI5Q06KjWT7bCaecqZAYCZq141rezANRB689DEUoPoWLqr7XPIoeqrQKSkDL
         9dmWTK/fMYYwAAUoucOOFXcpU9+jQElDGRyf1jwt6rZFxS16oJMDRLzVGgp4oqoke9rC
         ZAtokx3CNB+OOzXwIaxzCUV9g6uMxnMe0oJX0ZO90nxYNmqt+PyJf7dSj4qa/NzVNNvD
         aXng==
X-Gm-Message-State: AOJu0YyZH+N4t8arlAfmoSRbJzgRpfAETtNgYRvpPTKI89jRTDcYPnjO
        UvZI/Gx9gSdnevaqwZWVqhtF1ZAC9kd1CHvVw2US0Q==
X-Google-Smtp-Source: AGHT+IFdtzRXzXfVy2Uyhi9mLRyDdjmHGp1/Reyrw5PR3wZ9oCq2hd80cAXzSj382UrLHy3w0bEY47RRQFKxOu/bww4=
X-Received: by 2002:a05:6358:199b:b0:169:7dad:fee1 with SMTP id
 v27-20020a056358199b00b001697dadfee1mr4692933rwn.4.1700575538944; Tue, 21 Nov
 2023 06:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20231121085024.15955-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20231121085024.15955-1-lukas.bulwahn@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 21 Nov 2023 15:05:28 +0100
Message-ID: <CAMRc=Mf-F5vRPwtV37tuj1-Nwm6ncWM9xfgY-DvYaXXfK1rA7w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add TI da8xx bus driver to TI DAVINCI
 MACHINE SUPPORT
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Nov 21, 2023 at 9:50=E2=80=AFAM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> While doing some code cleanup in drivers/bus/, I noticed that the file
> drivers/bus/da8xx-mstpri.c has no maintainer.
>
> Although the file has not been touched a lot lately, the git history tell=
s
> us that Bartosz Golaszewski is the main author. Further, the driver's
> config depends on config ARCH_DAVINCI_DA8XX, and that is defined in
> arch/arm/mach-davinci/, which is part of TI DAVINCI MACHINE SUPPORT with
> Bartosz already being its maintainer.
>
> Add drivers/bus/da8xx-mstpri.c to TI DAVINCI MACHINE SUPPORT.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e829dbac1e99..e9cbf6e353bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21707,6 +21707,7 @@ T:      git git://git.kernel.org/pub/scm/linux/ke=
rnel/git/brgl/linux.git
>  F:     Documentation/devicetree/bindings/i2c/i2c-davinci.txt
>  F:     arch/arm/boot/dts/ti/davinci/
>  F:     arch/arm/mach-davinci/
> +F:     drivers/bus/da8xx-mstpri.c
>  F:     drivers/i2c/busses/i2c-davinci.c
>
>  TI DAVINCI SERIES CLOCK DRIVER
> --
> 2.17.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
