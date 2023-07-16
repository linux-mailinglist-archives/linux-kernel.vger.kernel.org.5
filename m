Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA93755764
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGPV0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGPV0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:26:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A721B5;
        Sun, 16 Jul 2023 14:26:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-993d1f899d7so569658466b.2;
        Sun, 16 Jul 2023 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689542806; x=1692134806;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9fUriBNhyXlFqH896tCKceodeOZncM96JEwNdZlGmY=;
        b=nnIYBAC8QvA7YAUa4Vzzqe5yckDs8Z498G+x/Kq3QIoULdgv0aoANmELok8XkG84Bf
         WSuw46lDKWrE2RdDOuuZAAJbgNLSkKtFIMVxifvZOzVPtxyxZckD+qnNtf/Lqjlh1Rjv
         F2eBNx8tqsL/juliwMDHuOrTtPA+Z23xBMGBIHANbHzzjplW6itXOin70Qotxg9YZRoj
         peNLcGuhkEvsNYudvkFcDYHYMkn39canCPVSFkLZ7vBqGyE7FAtYkPuBhosJCk+TiDvl
         BXCtwA9MnaMLcnTeSYVmz+BcCtyqUePF7cZCKiuhUu1wtXBOvdLs0be6usDS5+RQtxG+
         mC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689542806; x=1692134806;
        h=content-transfer-encoding:cc:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r9fUriBNhyXlFqH896tCKceodeOZncM96JEwNdZlGmY=;
        b=fFdMo9dZv0//DzQLFpkZ0UQPxHyjPGlONeyOKCNWkWc1IctUYeEx71TCnIL3e5g/ER
         qG3Zs/2CVJ0b88RPxxwrAO+hvJD/+EFQEK9lqgu33gALNqInbk3xOPxBDrCza3hF+R04
         SRUmdFFemlv/dz6tzWZJwd1jFS5oJHes9SydAOwbBHuy2fVzdashh+LKvcJRqpPNX8ZP
         ZQMmpBY9ZEcHDChzjV9djgcaBmQHshSL9A+4Rt74QS52Yc3jii2F+BeimmabYFKp9PWd
         73Tm1EEZ32UqziVKW7nHLpsvsg5ndwOD2LiSBTk4t/q9IlsRQ4zSWadKNm14EJ0QgiQe
         qHXw==
X-Gm-Message-State: ABy/qLbZFPQEU1uvYqzKWhu9F35eN89jMoeYUG4LlWqRc99oJrnp7rWF
        iAFbQj+TAKwMCjVZ8LL65ys=
X-Google-Smtp-Source: APBJJlFB+YxCHXbGHtsl4KGzq9AcRZqCuCujF7+0ct5y7H2DgRNPXht5p00ijnzk8gso+SpqYa/jAw==
X-Received: by 2002:a17:906:7397:b0:994:18c4:3303 with SMTP id f23-20020a170906739700b0099418c43303mr10188827ejl.18.1689542805589;
        Sun, 16 Jul 2023 14:26:45 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id la16-20020a170906ad9000b0098d2261d189sm8498147ejb.19.2023.07.16.14.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 14:26:45 -0700 (PDT)
Message-ID: <0414e2e4-a17d-3435-e9e7-35b110233a6d@gmail.com>
Date:   Sun, 16 Jul 2023 23:26:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrea Collamati <andrea.collamati@gmail.com>
Subject: =?UTF-8?Q?=5bPATCH_v2_0/2=5d_add_mcp4728_I2C_DAC_driver=e2=80=8b?=
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andrea.collamati@gmail.com" <andrea.collamati@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof

I release a V2 version. I hope I have understood all your requests.
See below.

> 2. Please use scripts/get_maintainers.pl to get a list of necessary
> people and lists to CC (and consider --no-git-fallback argument). It
> might happen, that command when run on an older kernel, gives you
> outdated entries. Therefore please be sure you base your patches on
> recent Linux kernel.
>
I was using branch master git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git but

I saw it was too old. I switched to branch testing.
> 6. mcp or MCP? What is this? Proper title is missing... also no
> description.
>
I don't know whether using small o capital letters. Usually manufacturers use capital letter to identify the component
but kernel drivers use lowercase in code.
>
> Shouldn't this binding be just merged with existing mcp4725? Are you
> sure it's not similar device, IOW, are you sure you do not have vref supply?
>
Unfortunately they are not that similar. MCP4728 has two vref choices:

- Use Vdd (power supply) as Vref

- User Internal 2.048 V Vref source.


Andrea Collamati (2):
  dt-bindings: iio: dac: add mcp4728.yaml
  iio: add mcp4728 I2C DAC driver

 .../bindings/iio/dac/microchip,mcp4728.yaml   | 42 +++++++++
 drivers/iio/dac/mcp4728.c                     | 93 +++++++++----------
 2 files changed, 86 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4728.yaml

-- 
2.34.1

