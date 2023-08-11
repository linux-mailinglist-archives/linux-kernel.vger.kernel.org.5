Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A707977872F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjHKF5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHKF5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:57:38 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156C2706
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:57:36 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe426521adso2477550e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691733455; x=1692338255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZtbOQJNFRCditQfcWrZUf7jKmGEPwgw/zJuB3OdcCc=;
        b=yWnINyuTz2hXpLYg5kqupnOmbuzhoS8HHM+6QaK+90gjkQUv2lednFgmgb62Z8kNCd
         B0ksMfdsPF51vMmaqdybn1MPMmn2l7Ypahar1WKIZ+VKFrOOuz1VvcWgyHYZHZCpMSvV
         Q2vVEZG8wTKY1btG7hS8zWnWVCr/kor+jwkQf9L9w2ijMxqeq50XxNqG0rZwbeyyD9/1
         zO8EjjKYIFQPmJsBZMQw9d0xo6vt5D6+GEsHolCLo4iiO+nFvrbi6WQVRsNAJl5Ks3oc
         3pggMFcj06uwEI4pUAWr4zF+kCeDyF66ELOIsrVin6eAXlnfVsuZtgS3IvdHkQ+XW+aS
         HsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733455; x=1692338255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZtbOQJNFRCditQfcWrZUf7jKmGEPwgw/zJuB3OdcCc=;
        b=Eiui6ClbqkOONzSMtfhEYQUgq/iUcqwiW3GRrKw69f3kXfc/0QwK1PqH3E+geu7ZeJ
         AvAQdEcrjl5M8GYUzHDi1a1whGr85f+wfu1Z7Si9dC79jtHq2T/FzNeawvL4XGyjxnkI
         G9qmU1u878ZFoaCj1D7fIz2lHUjYy9rUXvjr8dgcHCKnIOHihUoV1QbiY1YuyxmC+fTD
         oPU7tGJu9DhjM40jRkdBlOii3zULR4MJXw6QzLAYWYMqySlxYtj5xf+1w5FLx+HfU29p
         8zdBZRBiZnd30q67oJ58EmdQgeIFfsRM2HhhrNYC06OKBCeGCGXNMgQp1gYAS7RrtEbI
         VLXQ==
X-Gm-Message-State: AOJu0YxQAnLGB32X8hYjKhu9M5lrig1kK7WkkfThFhIhgz3PZ0/2Bu/m
        6EVcYo+UfOESSwwBGNWfijYac4rw7dr7syuaUzTByw==
X-Google-Smtp-Source: AGHT+IEdB1SJT7ln5tJra23AUBCkolLijO18zxcZh88jEeEUOFjZMUhwRslemIrE9JQvM5MmCGKEXOVFQaxRS+1yIcQ=
X-Received: by 2002:a05:6512:33ca:b0:4fe:8e0:87f3 with SMTP id
 d10-20020a05651233ca00b004fe08e087f3mr546740lfg.41.1691733454961; Thu, 10 Aug
 2023 22:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230810112015.3578-1-aboutphysycs@gmail.com>
In-Reply-To: <20230810112015.3578-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 11 Aug 2023 08:57:24 +0300
Message-ID: <CAH3L5QqXMAmiiDF5cNM9fY68hiqXeH6GKHdrQYG5Mh9H9Nrc3w@mail.gmail.com>
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: removed unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:20=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/k3_j72xx_bandgap.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/thermal/k3_j72xx_bandgap.c b/drivers/thermal/k3_j72x=
x_bandgap.c
> index 5be1f09eeb2c..b91743dbd95a 100644
> --- a/drivers/thermal/k3_j72xx_bandgap.c
> +++ b/drivers/thermal/k3_j72xx_bandgap.c
> @@ -502,8 +502,6 @@ static int k3_j72xx_bandgap_probe(struct platform_dev=
ice *pdev)
>         writel(K3_VTM_ANYMAXT_OUTRG_ALERT_EN, data[0].bgp->cfg2_base +
>                K3_VTM_MISC_CTRL_OFFSET);
>
> -       platform_set_drvdata(pdev, bgp);
> -
>         print_look_up_table(dev, ref_table);
>         /*
>          * Now that the derived_table has the appropriate look up values
> --
> 2.34.1
>
