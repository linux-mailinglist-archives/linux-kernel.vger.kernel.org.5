Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35484762FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjGZIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjGZIbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:31:03 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5042135
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:21:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99342a599e9so1096716766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690359660; x=1690964460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiHG1lqfKtIgSn5nDbZ/v9AonJn+0BEDVLcqcbo9VMw=;
        b=eM07wKpFCUyvyGxNYzYTzgCpEijzkJf7hJHDQc+i/xA/jNEnvHA977kYSn0v/43e+H
         175ADqTKdLFh5yltdkjKiAQquGfKNC7khbSd6pR+Xsx4eMx2/MN2VZeQmwXbsE+avszl
         GhG4wA39gGhGrK9uymQluTkRgUAZDzHXgwPVmxCwfmXs210k8gYsiols3HHWcv9aT4Ds
         B5Z2BDhHLmBoPo9mYXDsSY6eOvwzWjtb7mPc02HjZIqeRrsVSMGcDpKgRM69mg01yyna
         m4onL4BptrTSDHkWGcFMJzCDBAurZ4qUl1eo6zPwT4oPh7wG6VIDUrbWXF86GIUFk+gH
         ct3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359660; x=1690964460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiHG1lqfKtIgSn5nDbZ/v9AonJn+0BEDVLcqcbo9VMw=;
        b=aWnVeBtod78weoKrPtudrcsOetxlpehsJuEhA6xK2iPsCO+JYeQBZDqP6tZUeefNWe
         Gue3FvQaSSx4objRhxYGQy9oGJQugXnnAVzv/fE9nckt+61MSv/v8EGN0oPvmIONj0Ml
         CP9DiPx78ZT8fOqJys0sBdEMBEA3EUOlx4ZFzr9uH52YlcFpVWVh3fujf2KrJH25btSB
         KnJWFtyXpZ3TSTEnaXTpk87T6va63p+32BjPTWS/auI0QgXP2O0rQaUH1j2qNktooPnX
         Rv5006Oz+vkqZqhdLYwVFaPbNby4M4/QajL4tf4+LmYamg74YlB+4flTmICM8f0sJSvA
         luEA==
X-Gm-Message-State: ABy/qLYFpho02Vyd5v2wnbucikO2mw5eRSChTOCMzh4S0YDIW5NQKFp2
        piPe56ICRObmtHURtJLN57x4cg==
X-Google-Smtp-Source: APBJJlFSv4sPrPVpORIAoXVWqnWYXffFs8Rj+rBO6g/J3M8WgKWJdW/mDG62LCvhpl6DqK28klacEQ==
X-Received: by 2002:a17:907:7851:b0:982:21a1:c4e0 with SMTP id lb17-20020a170907785100b0098221a1c4e0mr1067754ejc.56.1690359660018;
        Wed, 26 Jul 2023 01:21:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x10-20020a170906804a00b009893b06e9e3sm9301463ejw.225.2023.07.26.01.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 01:20:59 -0700 (PDT)
Message-ID: <f24f29e9-ff06-5d96-df44-7632a933e4c5@linaro.org>
Date:   Wed, 26 Jul 2023 10:20:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/28] media: cec: ch7322: drop of_match_ptr for ID table
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Joe Tessler <jrt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Yong Deng <yong.deng@magewell.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <98a77653-ec58-56c4-9893-3b424f67c87e@linaro.org>
 <5afcec8b-b8f6-35b0-278a-5de185e4a7a2@xs4all.nl>
 <ZG9XJCD98VWjGjTN@valkosipuli.retiisi.eu>
 <ZG9ger4WE2VWoVEF@valkosipuli.retiisi.eu>
 <158425ec-86e8-ca3e-eed8-e14b37c42730@linaro.org>
 <ce217ae6-6dd5-26ea-2ce7-95d97ef791c4@linaro.org>
 <ZL+pNUYymeXv5EoU@valkosipuli.retiisi.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZL+pNUYymeXv5EoU@valkosipuli.retiisi.eu>
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

On 25/07/2023 12:51, Sakari Ailus wrote:
>>
>> I don't think this was merged in v6.5-rc1. It's not in linux-next,
>> either. Another month passed...
> 
> These are now in the media-stage tree
> <URL:https://git.linuxtv.org/media_stage.git/log/>. Assuming nothing goes
> wrong, these should end up in Linus's tree for 6.6.

Great, thank you!

Best regards,
Krzysztof

