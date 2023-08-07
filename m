Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA11772332
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjHGL6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjHGL56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:57:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C8116
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:57:55 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso6813014e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 04:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20221208.gappssmtp.com; s=20221208; t=1691409473; x=1692014273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOBcOiQRHcQIvraR7huR9LdNLrK1QBRsdFqV3ZT875M=;
        b=W3ntSd57mxc1WVrgskaNHMBsT5266+EJGXl2mDvTGTG4Pv/SJRzk9cbK5xrb18kOr1
         +09Qd5tfg/Wx/UWlKkJdbvKzrdc+A4Lf/suI2pUk8fXI+ClJCGHe2j+8mdhGmeTWEavI
         /Nm8LCAiWYn0mzagA+r2FYj6ICXxw792QeRL9cQTqZtg8pk2BBVJ0sPdtpvWPBo12RpN
         jxbJudBE0fqIp5KKe00DRcBXNbV2Zm3pNx0uT2kIlyqi8TenZgYQh1nFHlrBvUaL+Yfz
         wtgP5KHokMb+xLC/YjtHB4wyQ/SWpepVkbZCFb/48UH1G+D910lRgXJls3C8+HbbNIdY
         2QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691409473; x=1692014273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOBcOiQRHcQIvraR7huR9LdNLrK1QBRsdFqV3ZT875M=;
        b=EnrTosQvksbTHXSk3pOVKtRCHEQXBT+8iR6z0AQlL8n0UyBDrA9OQKSG4XZzrkAd0V
         edsb9Wu321dbTll/0nCFZGCDqPa+65fO5wgxQ2EpSQlvPKhKRF7kaolCepaEzEuIuLNf
         FNzxHH542VjPJPrrOcBWUKBvYeSBWdyCH7+SUT1u7aZgA6y387gdwwENxpvttKotUDt3
         JRkdUD4iLB/kTL0oMa/T2GDAHnxN9GKjvbP54M4orpQ80dxpbyUOis8zmkkorc4z7R14
         xPwfi/zJfBP+bgQFJ5sAdwhuZZiBs/KTeqfDyV+fQUTkU1WHfvPNwr+T1d0m3DodbX0d
         ouuQ==
X-Gm-Message-State: AOJu0Yzg3ZfXGc70k5dnJ1jV0c/uoHJZsl+58yCe7ngNvUzjx0zr1Zpr
        Q37QWgBytA1DTpFsuFU5oqQnV5rcGJjFHRm9QDcvszN+fjPBOmqerkg=
X-Google-Smtp-Source: AGHT+IFRs1dXDfY9ptILt2pHCUSGxN+nUonBXH6gtQCIYrNvBhVfuUx/j8sgbbRIzb6uN+YkGaaihMdnsYG2GSCXsvM=
X-Received: by 2002:a05:6512:311c:b0:4fe:a2e:890c with SMTP id
 n28-20020a056512311c00b004fe0a2e890cmr5080925lfb.49.1691409473211; Mon, 07
 Aug 2023 04:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230807111534.12392-1-aboutphysycs@gmail.com>
In-Reply-To: <20230807111534.12392-1-aboutphysycs@gmail.com>
From:   Alexandru Ardelean <alex@shruggie.ro>
Date:   Mon, 7 Aug 2023 14:57:42 +0300
Message-ID: <CAH3L5QrdF3fZDKV4FvsO+czgWyWNxKZE3yaxP7C94o0oyLZ6HQ@mail.gmail.com>
Subject: Re: [PATCH] reset: ti: syscon: remove unneeded call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, afd@ti.com,
        s-anna@ti.com
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

On Mon, Aug 7, 2023 at 2:15=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.c=
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

// also adding the people listed as MODULE_AUTHOR
// the list seems a bit short otherwise; no idea if these emails work

> Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
> ---
>  drivers/reset/reset-ti-syscon.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/reset/reset-ti-syscon.c b/drivers/reset/reset-ti-sys=
con.c
> index f0dd7ffc3b72..23f86ddb8668 100644
> --- a/drivers/reset/reset-ti-syscon.c
> +++ b/drivers/reset/reset-ti-syscon.c
> @@ -204,8 +204,6 @@ static int ti_syscon_reset_probe(struct platform_devi=
ce *pdev)
>         data->controls =3D controls;
>         data->nr_controls =3D nr_controls;
>
> -       platform_set_drvdata(pdev, data);
> -
>         return devm_reset_controller_register(dev, &data->rcdev);
>  }
>
> --
> 2.34.1
>
