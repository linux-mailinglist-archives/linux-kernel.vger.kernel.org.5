Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204AF7A3429
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjIQHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjIQHws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 03:52:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A1196
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:52:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ad810be221so452456866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 00:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694937161; x=1695541961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eo0rPZzuvMX1hueccHEBwOS160FHpuSftGVntb1qxg=;
        b=abqMaPOX5yqE89p8X3eNAO2piHJKqwg+2vR6FtQpneBsnBncvW8F+OVifhYlGx0L9+
         e6El4Cwwua4U/Y/atX6qdF7W+EWGXl3oe3jN5UoQhnE1Q6Vw+uJgAMoMX0mLRTOjMpTC
         MWC7AATpwJ3yc6rSowiRegV3VGT9LOTuf+g9zkLhKzsnwF3EKlG+NxBbO13OZ2r8q1tz
         G8GSHXjkwApbjWB34mxyex/+Pim/jaiVLRnslpJeCWlZZyOC7oFUsocqNAz/VqIJflXM
         o8nCWc/IfAUHIugEhs636gwwmM4f9vvdmNxEA5kK6WzuKTGSh9ihbAEOyMKskI7XNpgb
         fnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694937161; x=1695541961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eo0rPZzuvMX1hueccHEBwOS160FHpuSftGVntb1qxg=;
        b=Kt0iqIwH1XeQRi7ctLulzgERTfXWobGX6/S0G0pxHH0UYBtAYvgwUu/niuRMnse+/v
         3yxQylwHCudgkc7BRF3rAcI6pSUba5cUmfhZ/NMn1RzeQaCvbM/cLwk1IJhWBSfOuMK9
         T2HAeZAiLRrsbvWj3O8fdVY6KDYmcQ3V3O4mXF22xz8wUSVe9CCwMXkpjZIJOJ0d1GYe
         fiOjkX1jjT3uFw7WVK8xKsBwXkwAVotPhJ/0c5IHjO5bLwPbbkTIu1PsMOVS8d84eEpY
         R1KbTs8m+1NSEfH9l6Mu5w0wjRJrZgpykbJNeYa6qv61FO4zFoZxe8NezZWPxX/a0pZu
         QjkA==
X-Gm-Message-State: AOJu0YzI6h3uWeNF+7mQjR3sk9IY2cV0Kt66JxkLjfCSVSjTtIgafJph
        81ob6JswJOLjitAxl/mkgFDDTQ==
X-Google-Smtp-Source: AGHT+IEVjWE53AChtQwuTyXoGTpdIYaK3RL4LJS2V6aENqPfqKoxFhW4kzRLVZ20h4kWVResksGkcg==
X-Received: by 2002:a17:906:cd1:b0:9a1:c00e:60c5 with SMTP id l17-20020a1709060cd100b009a1c00e60c5mr5039237ejh.48.1694937161408;
        Sun, 17 Sep 2023 00:52:41 -0700 (PDT)
Received: from [192.168.1.77] (150-140-187-31.ftth.glasoperator.nl. [31.187.140.150])
        by smtp.gmail.com with ESMTPSA id i23-20020a1709061cd700b009ad8796a6aesm4660614ejh.56.2023.09.17.00.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 00:52:40 -0700 (PDT)
Message-ID: <00d40f2f-df8e-1bc3-1619-c25a7d3149d5@linaro.org>
Date:   Sun, 17 Sep 2023 09:52:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/6] dt-bindings: gpio: vf610: add i.MX95 compatible
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
 <20230916-vf610-gpio-v2-3-40823da788d7@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230916-vf610-gpio-v2-3-40823da788d7@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2023 04:03, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX95 compatible string which is compatible with i.MX8ULP
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

