Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B74E759372
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGSKx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGSKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:53:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532A7126
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:53:26 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso9550232a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689764005; x=1692356005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7UsnPJAlx+zJvjW7NPUxGuJZcFft7FkawPhO4cPS6L0=;
        b=D7rQYOCWkih5eVlFXleNpL06gLAZgJqJerQzOvXhKfktsHfjx24qwJx+uG/L2p+OXv
         yzrhseE9fT80PjT662zAq+5L6fWYbLvYO3ImvJWgVotHNQCeGcaGcIN1ZmxGvXRkVS1M
         ZliL2YrU4f6hYAQw5th2V9LMESb2o6RxW0muNWM8QWLT9P7U1eXG796eoRNLQKTe6j5G
         8XERIMFcwcvq4p1kHi5ceclOpsWIjzMguicGOTjijM2l3JNxOiXzSIJ+RwYR3RvQEDyl
         aMeujQdGEMfySMtacz9WzXxMa4ILKoYjnOOx37adgApMky3ASieAB23g25T/i0YNe2UK
         BhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689764005; x=1692356005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UsnPJAlx+zJvjW7NPUxGuJZcFft7FkawPhO4cPS6L0=;
        b=BBSGdwvgwtMeD3Ww/z76+pNgMVgRtT2NWztBpYc4vOK3wc814xdlS8bDXLj4dpq0oe
         SfDle5DfQbErWglaCB2JKuxOSYRY3UCaU9lM+zzgIqBTHP+z4rIRdY21C83VInATosjn
         aocOiQoLZYCWsot8lrF5tOfaXBEksAJxiUVFbeU0Ag+VWD8RJzJZzXpM51tEnBadVh09
         XHaaQ7A5V8fD844Er3ayioSekCP29eRNNSnamz6rcA0LPOa9FSfO64+AXbi5/kRquuKF
         x/nw5o3w1wsT44iHcb6Ri4lXyvBfQCamgLC7vnFKOuh+lbtCjoZBVpYU4yTb/8sk7WEr
         H6tg==
X-Gm-Message-State: ABy/qLbMxga80IYRNwQF3pZ34MRZVfAhHImSLNigR7DJH2NiWrjT9Pgu
        QlpoeTjKhzvaNWC7o5dP3fjBBw==
X-Google-Smtp-Source: APBJJlHeDzULHdm46nMp8fn9qzD8PjM/5gM+DuBigu3bOrq4KBv2hSExaHh8IBlswZWOt5RwDBQiRA==
X-Received: by 2002:a17:907:7fa4:b0:988:bb33:53b7 with SMTP id qk36-20020a1709077fa400b00988bb3353b7mr3000006ejc.60.1689764004961;
        Wed, 19 Jul 2023 03:53:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s17-20020a170906c31100b00992d0de8762sm2157060ejz.216.2023.07.19.03.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:53:24 -0700 (PDT)
Message-ID: <a1f60fc6-f150-0cca-2685-daaba82af20e@linaro.org>
Date:   Wed, 19 Jul 2023 12:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/9] dt-bindings: PCI: microchip: Remove the PLDA
 common properties
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
 <20230719102057.22329-3-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230719102057.22329-3-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 12:20, Minda Chen wrote:
> Add plda,xpressrich-pcie-common.yaml reference and
> remove the PLDA XpressRICH PCIe host common properties.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

This should be squashed with previous patch.

> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 45 +------------------
>  1 file changed, 1 insertion(+), 44 deletions(-)
> 


Best regards,
Krzysztof

