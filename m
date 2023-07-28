Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C7C766D9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjG1Mve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjG1Mvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:51:31 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEF2187
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:51:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5221e2e69bdso2664904a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 05:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690548689; x=1691153489;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gedJLHyl9jYC/USPCijx0sE3um9fSLBbzPsw2ixUmqY=;
        b=wZkbNGqQ3uw7mcIwc1dl7W5fqIdyvKuQUlDtB8gOcchltE1RNPokOIfX3a/CvA/g5t
         mw2xEn50S9OLn2pNFVCuTMP86YFrvZKsDIBDutAbKKuSiTQPY8/b4MCrKdJQYFfOKVv/
         Ty3Lw8A0HAfx+lgEd/6uJxOqks62xu8+dJP4KoIOWfeIZFIK1rb2giVKIpibsczYWqqU
         7k0zJTnEguhscCH+pXhGphDy2A0CNjWyoqyxlXMi54Vl+hVfx6m9a3Zt8jdwrObAQcnt
         S/tQrXjg6JBJYzZih7sFc1ERLc5iEP5Uq26CzNJrJcWUunD0PCgjfVnRAEgG4GAUcgk3
         KGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690548689; x=1691153489;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gedJLHyl9jYC/USPCijx0sE3um9fSLBbzPsw2ixUmqY=;
        b=OqjpCX4Wf0fkcC4tycx8w/xrhSpDV+ffAOinJcgv0hnZoSTsKYfgl36RHN3rZ2BoIv
         hctQCtDZ8kSf4IhDhx7z5YZOsNRTTEQeY3Lh/VAE8UlH5hH53hHGC70hkrGGL5lfxAx6
         YCnz8YAlQRM0P+7aXNdAO81JP/e4ViXVB4v/k8jyrZj0v7lXfSH00PEzpQPO//pdypFT
         +DVZnMEnOCX3irITYjGljsNze4NTfW1i6cp2NwjjPYM6UeHb3teAHhSbBiF/H23TrDRX
         k8HxAgCkMH+vO7aXb/T6Heek6wLDkLoUTxLIeR0LpwNrc2fy5PY90G593+rXwiQVC7Fo
         Nrgg==
X-Gm-Message-State: ABy/qLbxnes1nzLRXjKJlYSMAJVM4OrGpHyAoPgXwSlL64XeMpjkZJtJ
        YK8KEiS2FriUohCrXgkmFHUc+A==
X-Google-Smtp-Source: APBJJlHax6AsxJudUM5VqzR8XMQAFX9jqhmnuuAP0jJ/YQ0xu9Ni7Sg1fWIzJHA9rNtfwWtbo3ixhQ==
X-Received: by 2002:a17:906:319a:b0:994:34a2:8727 with SMTP id 26-20020a170906319a00b0099434a28727mr2157378ejy.41.1690548688933;
        Fri, 28 Jul 2023 05:51:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b0099bc08862b6sm2054522ejb.171.2023.07.28.05.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 05:51:28 -0700 (PDT)
Message-ID: <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
Date:   Fri, 28 Jul 2023 14:51:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Content-Language: en-US
To:     Maso Huang <maso.huang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mars Chen <chenxiangrui@huaqin.corp-partner.google.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-7-maso.huang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728090819.18038-7-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 11:08, Maso Huang wrote:
> Add mt7986 audio afe document.
> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents

You should constrain your clocks per variants. I doubt that they are
really so flexible/optional on each SoC... or maybe missing clocks are
result of unimplemented parts in the driver? But then this should not
really affect bindings. Bindings still should require such clocks. Your
DTS can always provide a <0>, if needed.


> +
> +additionalProperties: false


Best regards,
Krzysztof

