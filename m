Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711AF7CF091
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjJSHAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbjJSHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:00:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4303311B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:00:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4079ed65582so21067875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697698807; x=1698303607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=phdopUGhFu1uVNeMVEBY+BMFdVXiqLRcCSRDiN1kr/w=;
        b=tJtOa+Bz/Xr1FHC2DmzY7G3PUS+bKCq6l3/eQ1Qw32nQLrQDIKFc8uKwNAobL4+GH4
         JLfcuUFlifoQr4075xISSNy4iTe0OShnNY/3+3Cw3U7d4mRpqlHctZgu8vIMjILk7tYY
         m9X/8atTE2yHc2xtCb1LhzbI5rKGOO8tCC7WOw+lYAGrXWKJ98mkOv2cRKmrM+7uTs+T
         5ArxX4B0A/RNAn1grpiYATl/6yfqAsFbuHjxHGelZgdsgTOsrNJ1xiNLAYyMGjZ5skPp
         uUTk8J9PnhcdVM6kxf9tE72Es+PJ4JEHBpvyFe7h7iefxNYwFvGNu6thM3H7ldmm6v3p
         dpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697698807; x=1698303607;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phdopUGhFu1uVNeMVEBY+BMFdVXiqLRcCSRDiN1kr/w=;
        b=xQPD3pqHGGYbBcPLJU9mVJgNiImpTYIDeVhXNtO9LNJQZ21Uze5ZAgPFLzZLgj0RYF
         w67cnVANLApGf7bqwneOI11vkM6wbKdl7aeSJJmPOYMNX4/0GKrmYuw6HDEXr2p6YecC
         58NlfyEicMdk+Ezfv0tOi1DzaFCqlLJXjqbxdzfb5v7+3/cqug72999TS+DXNU+ZP5Ox
         38zVvqETBNvtvKCladqo5WnbfQGE7tMdQ4RtN5Kh+43A8TxtmOBTaPBePDMDoDb5ZNkp
         o9jY71YZOx6/Ofo4K9DZKBK1wzt9ZACy/8Wt+CeCA45fg9SN+Z/5ZQ7j6fV4MYgvm8r2
         AD4g==
X-Gm-Message-State: AOJu0YyfI9Kk4GqDARuaSElDZaUwTBC+43IStOJzyECkA+zGfPOZC0Va
        sngD1whJ5nwl2LuCbJ4lwHhg0A==
X-Google-Smtp-Source: AGHT+IGrb+9TA3G20GqE0KVDUSKCpdd4MuCybi2jrStkzxattFRPwFRE2nZ4Fwjil2NOlUTSbOgIpA==
X-Received: by 2002:a05:600c:350f:b0:405:75f0:fd31 with SMTP id h15-20020a05600c350f00b0040575f0fd31mr1051854wmq.31.1697698807613;
        Thu, 19 Oct 2023 00:00:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.49])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600c3d0900b003feae747ff2sm3612213wmb.35.2023.10.19.00.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:00:07 -0700 (PDT)
Message-ID: <dd06c2d3-e273-4356-835b-42619543dfab@linaro.org>
Date:   Thu, 19 Oct 2023 09:00:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] i3c: add slave mode support
To:     Frank Li <Frank.Li@nxp.com>, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net, joe@perches.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
 <20231018215809.3477437-2-Frank.Li@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231018215809.3477437-2-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2023 23:58, Frank Li wrote:
> Introduce a new slave core layer in order to support slave functions in
> linux kernel. This comprises the controller library and function library.
> Controller library implements functions specific to an slave controller
> and function library implements functions specific to an slave function.
> 
> Introduce a new configfs entry to configure the slave function configuring
> and bind the slave function with slave controller.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/i3c/Kconfig       |  26 ++
>  drivers/i3c/Makefile      |   2 +
>  drivers/i3c/i3c-cfs.c     | 389 +++++++++++++++++++++++++++++
>  drivers/i3c/slave.c       | 453 ++++++++++++++++++++++++++++++++++
>  include/linux/i3c/slave.h | 503 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 1373 insertions(+)
>  create mode 100644 drivers/i3c/i3c-cfs.c
>  create mode 100644 drivers/i3c/slave.c
>  create mode 100644 include/linux/i3c/slave.h
> 
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index 30a441506f61c..d5f5ca7cd6a56 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -22,3 +22,29 @@ menuconfig I3C
>  if I3C
>  source "drivers/i3c/master/Kconfig"
>  endif # I3C
> +
> +config I3C_SLAVE

It doesn't look like you follow Kernel naming convention (see coding style).

> +	bool "I3C Slave Support"
> +	help
> +	  Support I3C Slave Mode.
> +



Best regards,
Krzysztof

