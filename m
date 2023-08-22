Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846E0784A83
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjHVTew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHVTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:34:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C15CDB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:34:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99c0cb7285fso617005066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692732889; x=1693337689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCcpTzBWSQ+IC9LwkeK4zV70VWPirwKEsLz20+SIVmI=;
        b=O8p0qOjeOgdnidaekqarL8jgxvSEdVprXfjJAmpTMB++3auX4nxd5++LFA/NI+NzpR
         z5qaVw39ymBlfaAJS0W6u7Ky3zpqr4znAD9dJW4DFfHRbTUemeXute5+wzBGm3ea6Nbr
         TZFRlem/nwuBzPJXOkRCL5/fZ/DNjovlh1bixDZb6vM6gPWx7VUWlXW5b9OmrjLGufse
         hxIEY2fkMV/oeu9M1YDVQawwF/iP7y9siRF5C/PVhI43XTMK+SklCheeW5eMhLsLFNK8
         ii8NsC1kDpT738PPvfeHeemw1CTG9+8YEBX0WnjajEH/7D6/d3P0JYCQKM4iHaCVl9X6
         CtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692732889; x=1693337689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCcpTzBWSQ+IC9LwkeK4zV70VWPirwKEsLz20+SIVmI=;
        b=ayqWUcxMLeC2UUMPEIqFn+ujQsos6QNWMDtAAum+KAOw0xC64EC13S9ZuWaGiKHPQx
         XJc66SIr7l6S5k2VcOBClGC/0JGZkM9AeAdqK+1IDN+xvrQzHdfrSbO/kK1wV5CY+Q1k
         Ln3+f8ZhisNoRSQVEWoFEBl38MFgrxt7jS6Ai8gRY94my0K+LHApE3b2iuBx1zLzij8k
         iwLg6tqvZuI8D7V3jD3XEDO7U/KiKUgIbwgG0Put+CU/PiU63MW5DwED7a6cGGcaKpBF
         GaD0vaq0AsG7smsS/D3hs3jb+A1TRp4vWMWBPplKdLeG4Ug1SDissl0J92RPoE8P43pA
         QHOg==
X-Gm-Message-State: AOJu0YwCwggpi9JWFF03IexQCWiOWVeivgnwIbJ5D/87lf8WJCOv4vFT
        1EySo58D4e/5dZfqymE23JyLbw==
X-Google-Smtp-Source: AGHT+IFOfpyf9WYKtBPs4WToe/nFPbsX758TLW9u3YBXfFA+NpzYCUytpJ8TL7xHGho5/FmGM2623A==
X-Received: by 2002:a17:907:7714:b0:99d:fd27:b38d with SMTP id kw20-20020a170907771400b0099dfd27b38dmr7517648ejc.70.1692732888906;
        Tue, 22 Aug 2023 12:34:48 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090606c800b0099d959f9536sm8827134ejb.12.2023.08.22.12.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 12:34:48 -0700 (PDT)
Message-ID: <f14b9ce4-0cb5-5b76-ce9a-a3db9af9a9bc@linaro.org>
Date:   Tue, 22 Aug 2023 21:34:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/5] ASoC: dt-bindings: snps,designware-i2s: Add
 StarFive JH7110 SoC support
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-riscv@lists.infradead.org
References: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
 <20230821144151.207339-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230821144151.207339-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 16:41, Xingyu Wu wrote:
> Add the StarFive JH7110 (TX0/TX1/RX channel) SoC support in the bindings
> of Designware I2S controller. The I2S controller needs two reset items
> to work properly on the JH7110 SoC. And TX0 channel as master mode needs
> 5 clock items and TX1/RX channels as slave mode need 9 clock items on
> the JH7110 SoC. The RX channel needs System Register Controller property
> to enable it and other platforms do not need it.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

