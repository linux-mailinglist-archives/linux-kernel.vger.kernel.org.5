Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BAD772337
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjHGL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjHGL7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:59:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9569C1B3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:59:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so6655999e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691409545; x=1692014345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpSVKA3kJqAYdJixQpM5UDQqCCLM318WeLmzzbmIW1c=;
        b=Uhm1StHclSK/N4QL+W4gtKnY6quhuampPfV4E+74eoywhpSaqDTqYjaHT9WlqmlR6E
         h2JBNmwz43NvVQmdqGLKP3PprG6LSGap6PA7napbMfbroZP0YMES/hzhTPTy2M99QMD2
         +Jcx/90+LHkm/ihjKauOTcD127uYnV6oWVFqy8bKxfZqBcDNnCGGTz3l+rjZR5lqlSBq
         1tH54U76I2qDTatc5w+hDAR+0snZQhkO7OIpSg18Kj/5CoGquNi+wcRsDDqhudI66PMB
         TRYqQxuez65aNz5ZviG+Oy2uBPvBNYlMom8rwH5gkEepgg5Q7dzz3T7Ninvr6K9nnFm1
         Hj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409545; x=1692014345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpSVKA3kJqAYdJixQpM5UDQqCCLM318WeLmzzbmIW1c=;
        b=RZz7ovLwEXQ9lkiXjwX0CWdjQVlhX3cxBz7shRNboLcVMKp1vbYF+Q14UsDXoGUD+E
         G/lIJeiIU6dOVMyYa24JH9HmfoWvFec87u5AIIwbn0QQH3sp4fxzVgeRnnQaW75+tczN
         KoFErQ1T+T7ARPHFTrrePYm55dPVPdQoVQ/1B1zkVF9ykYY3G18STsaGvJ9plXTSypcr
         hf/ZywYu/EXFJ6vYbF1yEytF1V4Xan2RSfYr5eEXn3960Skm31NSJ44ANVPAJfGvJugg
         VzOafehLckRPofcjx1XxAxpOXvL/zIvLtEJzIINWmDjImgrkrDu38uoqiMRrHM0M1SEt
         GUcg==
X-Gm-Message-State: AOJu0YwjwDPNMqeBvw7zfyn2054LnuLavFNqGbkUbrcThgfc7jglEUon
        ZYZmWIVhZtKuYRknVrQCN/5ghwwII4PZs5qmlnMbGg==
X-Google-Smtp-Source: AGHT+IEIruUTwKjdVFKfeu0NogVrzm1dhyChGOYmMkQoR9V667e1ySxaznJ9S9CD4ihlon4KK92+/9GoErLW0yE2hqU=
X-Received: by 2002:a05:6512:1287:b0:4fe:feb:fef9 with SMTP id
 u7-20020a056512128700b004fe0febfef9mr2366421lfs.24.1691409545439; Mon, 07 Aug
 2023 04:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230807112705.12862-1-aboutphysycs@gmail.com>
In-Reply-To: <20230807112705.12862-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 7 Aug 2023 14:58:54 +0300
Message-ID: <CAH3L5QrySJPGT9ZYkV1nC2x+gPKMj7JEbZoCLjzkQjEd2oRjcQ@mail.gmail.com>
Subject: Re: [PATCH] reset: uniphier-glue: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mhiramat@kernel.org, hayashi.kunihiko@socionext.com,
        p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 2:27=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
om> wrote:
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
>  drivers/reset/reset-uniphier-glue.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-un=
iphier-glue.c
> index 15abac9fc72c..df41b75786ad 100644
> --- a/drivers/reset/reset-uniphier-glue.c
> +++ b/drivers/reset/reset-uniphier-glue.c
> @@ -99,8 +99,6 @@ static int uniphier_glue_reset_probe(struct platform_de=
vice *pdev)
>         priv->rdata.rcdev.of_node =3D dev->of_node;
>         priv->rdata.active_low =3D true;
>
> -       platform_set_drvdata(pdev, priv);
> -
>         return devm_reset_controller_register(dev, &priv->rdata.rcdev);
>  }
>
> --
> 2.34.1
>
