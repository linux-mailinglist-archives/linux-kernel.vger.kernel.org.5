Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F1A7C73A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379562AbjJLRDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379566AbjJLRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:03:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8E1DA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:03:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ae75ece209so197165966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697130224; x=1697735024; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpj60L1giOhZDrev97o25zjJHzefVjPnm5rNDXRL1v4=;
        b=w+Dim5RPaej0Tkizr6QijIiVS19PbHFaqUExEpuN1hh/F/B20uAoVnCcr0K0oZ7m/2
         ABLeQ6TMp+6a2cmG7YOaUIveKHyMpPBM5oxCl//v1cEGd88l68pssauqNzIRLSe4g6LY
         fuW7AGtz/JFF2c/V5hZua+Y5voLL+AKqjsfuLrIdcmQbkAS2IbMyUHs40Ffr1Jr2JzfI
         ybe9SLssOXj01zJNsMlcsOkRtKFcOyoaPOC8uvQWG+SOeix+kdJdIR9ZXcwd1fB8SuaF
         09QPFEBIdDC5zYXdUPGb6gD7GhS/Hhm+tKInl0uRgV9emxbbQ/fkngnyeqzYNnDp5pmO
         5yOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697130224; x=1697735024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bpj60L1giOhZDrev97o25zjJHzefVjPnm5rNDXRL1v4=;
        b=VP/KKNoesEvhwFnw7IIbNCcBZndP5O6UhfFWfaFt5/TriFjPmBGceBEs5bj9DK4I8J
         9WJxHJPrTBpvg9ow5FfdOcs5reAvSduzDMRj0YX4HVMg6mtz6XWTx4w6VPRYC0Y+k3zr
         Q+DpURKO8tR1B+aytyD3As1Fr1m749+g7zotQ0ysYRyhv07fjxSS1tUg4ffGdWyO4amw
         ZYf0PDcZ+0cx/nZh8/ewAh8KAOJit7TjzBdSgLReRKYQrrn1r684Y1tITAvx1mmRG6cZ
         zhWqqUfy3cRe2QiBJ/wyKwyKwWJJpQ9VBXTQj85ynMqxgsJYApWMLFolHiYvFkCWhQ8G
         Di8w==
X-Gm-Message-State: AOJu0YyAUUbRZnN7ULsG9vZD3zqaep+kxuwpN99B2KW96BER9/87rtR6
        KzY2HuD0bNGR0fCKtyiLKJoQqj20Jcre8xMI2BTLRg==
X-Google-Smtp-Source: AGHT+IHnItZqj3WoRz3s0Uyjg3a1IGBWvjSwLhRqCZLGtotHoQvNSkjH2MugZe17HhUqAfVikbHBbvc6y+hxZvjZCKk=
X-Received: by 2002:a17:906:845c:b0:9b8:f17a:fbc3 with SMTP id
 e28-20020a170906845c00b009b8f17afbc3mr19609420ejy.64.1697130223912; Thu, 12
 Oct 2023 10:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231012043501.9610-1-m.muzzammilashraf@gmail.com>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 12 Oct 2023 19:03:07 +0200
Message-ID: <CAMZdPi_RY7H8owUB=6-G3fnhXBVrKHjv6O5iLmLwu8bZUbJa3A@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     horms@kernel.org, ryazanov.s.a@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muhammad,

On Thu, 12 Oct 2023 at 06:35, Muhammad Muzammil
<m.muzzammilashraf@gmail.com> wrote:
>
> resolved typing mistake from devce to device
>
> changes since v1:

Change log should not be part of the commit message, simply drop the above line.

>         - resolved another typing mistake from concurent to
>           concurrent
>
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> ---

You can put your change log here, e.g:
   v1: Fix 'concurrent' typo...

>  drivers/net/wwan/wwan_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> index 87df60916960..72e01e550a16 100644
> --- a/drivers/net/wwan/wwan_core.c
> +++ b/drivers/net/wwan/wwan_core.c
> @@ -302,7 +302,7 @@ static void wwan_remove_dev(struct wwan_device *wwandev)
>
>  static const struct {
>         const char * const name;        /* Port type name */
> -       const char * const devsuf;      /* Port devce name suffix */
> +       const char * const devsuf;      /* Port device name suffix */
>  } wwan_port_types[WWAN_PORT_MAX + 1] = {
>         [WWAN_PORT_AT] = {
>                 .name = "AT",
> @@ -1184,7 +1184,7 @@ void wwan_unregister_ops(struct device *parent)
>          */
>         put_device(&wwandev->dev);
>
> -       rtnl_lock();    /* Prevent concurent netdev(s) creation/destroying */
> +       rtnl_lock();    /* Prevent concurrent netdev(s) creation/destroying */
>
>         /* Remove all child netdev(s), using batch removing */
>         device_for_each_child(&wwandev->dev, &kill_list,
> --
> 2.27.0
>
