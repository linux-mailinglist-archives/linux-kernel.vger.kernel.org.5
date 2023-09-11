Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0503A79A356
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjIKGM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbjIKGM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:12:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D004A100
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:12:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31f7638be6eso3252707f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694412741; x=1695017541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XezrCl8ZqDRyxio73LdcaLmnL38z1MHmy6zWkUdZX0c=;
        b=X+cwB4ZzNrWI6CycQ59R5S2CxtUzQ0h0/RoKFVNpDZVMvU8b9r50SaBij12YRK/dCE
         6HgNS74geWGDZjLHJWq0Mj4ign6g595JrNm6oszpjfa7WcFf5siz49pLv0MVggX2ZTHx
         MztL/tt5dX3wuByRUNgCm6mnTs3TJkMp5AnbmuxeoGjm5qHUxNa5Zlcy5hypGw8bD6BO
         wVHMaym8Hr3fL+HcX2wAZKiH5lAD7VtYJdZaL9FnQk27xSp8Ej17zzdns6i6T9SQ8pdC
         QuslvrmLywoWPtyEJvpUscWJNYc2TyloqAdwwHU6bjaYj7VIB4OdmOT0sxfmFjc1IaQW
         XLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694412741; x=1695017541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XezrCl8ZqDRyxio73LdcaLmnL38z1MHmy6zWkUdZX0c=;
        b=X689itTRlWe/dcVngeNYeYE91Wvt4gtpw9jdG3mEYcKA+qnXkBwVLklLSnIKc9IHg0
         b55x7SUooJVXbHQ3yJCZxUhO64rDAD+buJtuodd9T7CY+496M7fxLAa6nP7sIEnOsvXF
         oAFBrcT5hPE4iZDaw6kyZkHk9nxvBIQG8apZYlkPxkv5/9cDG/UMa3m9f45Ksxh3ZdCU
         1KvtNUGrHAhZXxT1ZEWZXKXYzZK8OeVBUSfNBcg+LfsY/01Fz+LCRvlFuO9k4r166OSV
         X5HKyrRo0eTMgkQ/euOsBJRLuqEKcq1YWlkySpwt9hYtr1JaPbnJXxBwz3ToaE6iWSWo
         F/Kg==
X-Gm-Message-State: AOJu0Yzj0oqiQZ64MEAOtVbu0kxwnOp5fPhbG26LH0HXh3GkDsiYnPeq
        CgDG/LEdz0+WGJzULsYMP3+amg==
X-Google-Smtp-Source: AGHT+IE5Ebjr5i6VAf1KdNZGjQGiz4Iee/J02faavRwi1z0yfclTmtfOj/Jn0i8zTJzMyqK6vWlhfw==
X-Received: by 2002:adf:e68a:0:b0:317:5ed6:887 with SMTP id r10-20020adfe68a000000b003175ed60887mr6707475wrm.66.1694412741175;
        Sun, 10 Sep 2023 23:12:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id x5-20020a1c7c05000000b003fef5402d2dsm12227048wmc.8.2023.09.10.23.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 23:12:20 -0700 (PDT)
Message-ID: <bf43b771-35e3-1b37-24f5-e21b2c34a415@linaro.org>
Date:   Mon, 11 Sep 2023 08:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Content-Language: en-US
To:     Myunguk Kim <mwkim@gaonchips.com>, alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?UTF-8?Q?Uw_e_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org
References: <20230911024023.43833-1-mwkim@gaonchips.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230911024023.43833-1-mwkim@gaonchips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 04:40, Myunguk Kim wrote:
> There is a SoC between dwc and DMA block (ie. PL330)
> that does not have a burst signal and supports only single.
> 
> So write not-support-burst property on dts, it support single DMA mode.
> 
> Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
> ---
>  .../bindings/sound/snps,designware-i2s.yaml          |  3 +++

Bindings are always separate patch.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.


>  include/sound/designware_i2s.h                       |  1 +
>  sound/soc/dwc/dwc-i2s.c                              | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> index a48d040b0a4f..43a46ba2a70c 100644
> --- a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
> @@ -86,6 +86,9 @@ properties:
>        The phandle to System Register Controller syscon node and the I2S-rx(ADC)
>        enabled control offset and mask of SYS_SYSCONSAIF__SYSCFG register.
>  
> +  no-burst:
> +    description: Use single transaction only between DesignWare I2S and DMA IP.

This was not tested. Missing vendor prefix, type.

Anyway please provide some explanation why this cannot be deduced from
the compatible.


Best regards,
Krzysztof

