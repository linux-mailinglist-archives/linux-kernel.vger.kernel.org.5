Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79811778729
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 07:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjHKFzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 01:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHKFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:55:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02560130
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:55:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so2575302e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 22:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691733323; x=1692338123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmt/gubznLN0uQ86/mDY3ypBbPnVCxi4XxXVIT45T4w=;
        b=OfFJ1UNpIBwTVK2dQ6oI7ZhD0gUA/qGNMI75hMhgLjsyhB1Ur6y9g6nyNj4NHpa67v
         laQ1KVOlJ0KG431h0d0eRdnEIgMVNw7VwoDNbfE06B4o3dmDxZRbJgzJhFaotA9C5xx2
         UQwQD6mIVuZaCBQ14Bug/omZiLEPxdAEUIuqlhrjbxnxFz9MS2pBQPLsKkuc8LZlGElh
         yD7/WZWaPudEeiAx+O2klrWsjCReiYgYjiLwSK3M+Z4PkzYd9/FxQR2QOkA5dWT3FO9k
         pf8pfUD0yIlSWwqpkd16AOoGLr5WrHniCG/YK5VUhvPH67jzXLoMUC/XlrU2cBHmNhW3
         Xsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691733323; x=1692338123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmt/gubznLN0uQ86/mDY3ypBbPnVCxi4XxXVIT45T4w=;
        b=SR1EbSDMOlXDN8Pl1ZTyyQDrR8FpRJJ7EZOm0dKo64jCNR0Eia/QztdBYvr3BZqk1J
         95xuI4StwP9IjKm0ZrNEmu/BM2mY+26aS5rUYJ1jYXSLM5lnJvPVJWhGCb+MA4lYRl9Y
         /u/mh9Ze0RJnH00dXmT/UIgM/0dGqHgOvp5p6QJW6dxin3UpBNEpQLMRCA0Rqic9U4fb
         JSe2M1CrvS+aiWwH8od63qqwA++yYIMSDtmHTPySQ3l33FqrUvXfEZRvMhZivLBn9B12
         hBErxUr9fglzZK86avvAgeM9W/MmiitjZ+ZM8ALoMmpRZAQMRT/PcXyenxQjdiIJ5Em8
         Oxrw==
X-Gm-Message-State: AOJu0YwDIlTFZsKW0f8VBdZ5wdjQOWsCNQGUylUc3tEf8ijukaSkgSWx
        C6ZdnO91AhNrRyHrqpVTZnu4QhMBsuCVKGfSsHrD2w==
X-Google-Smtp-Source: AGHT+IF554dgo6vpDP/cny3ywpXx2Y4i7DYvhGwYm/FsQFD9IB7TGiXNd7lRSzDOuFYIoN24pfQoZjAfpRhs2nHY4hI=
X-Received: by 2002:a05:6512:250f:b0:4fa:d147:9df with SMTP id
 be15-20020a056512250f00b004fad14709dfmr555576lfb.19.1691733323014; Thu, 10
 Aug 2023 22:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230810111330.3248-1-aboutphysycs@gmail.com>
In-Reply-To: <20230810111330.3248-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Fri, 11 Aug 2023 08:55:11 +0300
Message-ID: <CAH3L5QoXrhFd92krdmeJz2fradMZcBc80nx4rJ+pjtjoa0OwBw@mail.gmail.com>
Subject: Re: [PATCH] thermal: broadcom: sr-thermal: removed call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        hayashi.kunihiko@socionext.com, bchihi@baylibre.com,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 2:13=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.
>

I had to take a look over how "thermal_zone_device_priv()" works, and
it looks like it has nothing to do with the platform_set_drvdata() /
dev_set_drvdata() / dev->driver_data stuff.
It defines it's own `devdata` pointer.
Though, it looks like "thermal_zone_device_priv()" could potentially
be converted to use "dev->driver_data"
But that requires a bit of going through all drivers to convert them.

Anyway, for this:

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/thermal/broadcom/sr-thermal.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broa=
dcom/sr-thermal.c
> index 747915890022..9a29dfd4c7fe 100644
> --- a/drivers/thermal/broadcom/sr-thermal.c
> +++ b/drivers/thermal/broadcom/sr-thermal.c
> @@ -91,7 +91,6 @@ static int sr_thermal_probe(struct platform_device *pde=
v)
>
>                 dev_dbg(dev, "thermal sensor %d registered\n", i);
>         }
> -       platform_set_drvdata(pdev, sr_thermal);
>
>         return 0;
>  }
> --
> 2.34.1
>
