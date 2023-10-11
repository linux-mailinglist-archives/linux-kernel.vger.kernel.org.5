Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBB7C4775
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjJKBt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 21:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbjJKBt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 21:49:58 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805B92;
        Tue, 10 Oct 2023 18:49:57 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdcade7fbso1073714266b.1;
        Tue, 10 Oct 2023 18:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1696988996; x=1697593796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LO/vJrNP2TpMz42rqukb2IJJCeqp32FfF1/7XGzp3yw=;
        b=XHHbpmN1On7QqF9RL3YyQMyzJByDxtS8bzuN6pvLdZbw7CPnbIcaFe+6CUQKOsvLcd
         COE55YVPbHovhvWlrgXWT3rsP97pI93aNlsR+kAx/CjIN5fhYNJlss4qzcnec0YI4/m+
         2ThnK3QWzZVzo8fChCnNyWsFhhtzeby9+8Elk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696988996; x=1697593796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LO/vJrNP2TpMz42rqukb2IJJCeqp32FfF1/7XGzp3yw=;
        b=fo2bU+jI0dh/2vy5/Umz/8fwAXyteV6Julxis9lplbtR1p+P9nvRv45oBpfcOpydn2
         XpeiyVOdRtkMd7XbIAQuoPsklDyxQeSUCa/LsBsvLk6tRCP0NHKFI1v5fa4FnCQHSvU+
         tCNxpLnk6u8C10W2/kbvtdvT/DlHOZYiOmBjagxjxoKDhy0uLgVI64sEzKhr/8dRb765
         Tis+D/uYsb3bf9fEuznoR3LDWzTEw6155vo7BBm7sMRkd+3wqYSv2PmCYF/eUZ+G2aOw
         Vo1VXBXMczkHDlFpAwqalApxgsyKANL24x+feoiQDz8NIPxzbMb6VtRQix4ZWntzko1B
         zcWQ==
X-Gm-Message-State: AOJu0Yyu62KX9cIroh0tNQRmPdOgx5ARzxYyk+LHKdSDHBsSzyERiOFz
        rYFj1IlJWhxGS8OY5e0n/ZNLCmmGbB24pszWlZo=
X-Google-Smtp-Source: AGHT+IENtIO4uRrRVxLj+GzOepLQkLMK0qxFFO24siVqSmqpcrcJ7ieHXx0nNMhyFPDGj+jIXrGioxzcX3zlg33/eMo=
X-Received: by 2002:a17:906:3f04:b0:9ae:5568:b6a8 with SMTP id
 c4-20020a1709063f0400b009ae5568b6a8mr19965720ejj.10.1696988995731; Tue, 10
 Oct 2023 18:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231005035525.19036-1-chanh@os.amperecomputing.com> <20231005035525.19036-4-chanh@os.amperecomputing.com>
In-Reply-To: <20231005035525.19036-4-chanh@os.amperecomputing.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 11 Oct 2023 12:19:44 +1030
Message-ID: <CACPK8Xcby1Oy0ksP9GQjUi8TNg77bw+HJMqgVujM6dABvT_ViA@mail.gmail.com>
Subject: Re: [PATCH 3/7] ARM: dts: aspeed: mtjade: Add the gpio-hog
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2023 at 14:26, Chanh Nguyen <chanh@os.amperecomputing.com> wrote:
>
> Add the GPIOR5 as a gpio-hog with output high so that can
> power the OCP card once the BMC booting.
>
> Add the GPIOAC5 as a gpio-hog with output high to notice
> the BMC state.
>
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Could be two patches as it does two different things, but not worth
re-spinning just for that.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> index c87be433bdd0..8ab5f301f926 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> @@ -805,4 +805,18 @@
>                 output-high;
>                 line-name = "i2c4-o-en";
>         };
> +
> +       ocp-aux-pwren-hog {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(R, 3) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "ocp-aux-pwren";
> +       };
> +
> +       bmc-ready {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(AC, 5) GPIO_ACTIVE_HIGH>;
> +               output-high;
> +               line-name = "bmc-ready";
> +       };
>  };
> --
> 2.17.1
>
