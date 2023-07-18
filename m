Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD37583EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjGRRzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGRRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:55:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE461DC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:55:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso8554873a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689702928; x=1692294928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pE1qUAyXgxKm4FKDn6d98dPZAsbuyVV+oDCpGCKIXhU=;
        b=yKU7ey9m0xAO3Q8ywQtNs2uzVpbTKYk2Oz/Ja55cbIzHogaqystU603eY2x5/YqfGX
         H9naCLbpROzYaCTVDOp6twWnsl5mpSp/Dgsp4I3itzTPTXDBboyf2yc6kLV/zPioOXOF
         jvU3DR0kjkVNfcMjGtCq1OoqtT0R9oRe1EbyGkohqS5nP8DQK4hg+a6WfdjX/7NPp1VJ
         PmhTujoe7StxAl788QGqCF0DEMGd5CplUQSa93Rbnq5eh6ufJ05uoRGnsRWB0clgWrqh
         sX0OSCjjhSmETSwQB1Zg42ZXspK36gFDQnHY7rm8MBKSea8NYogWPy18kIhsH9+IknFs
         LGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689702928; x=1692294928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pE1qUAyXgxKm4FKDn6d98dPZAsbuyVV+oDCpGCKIXhU=;
        b=PVuozPF22ZRXQLICYc5dAgpnbKebpTlsXWz8NZomVyDE11gmIWO2ZEhAolLAmSgh17
         oW6DA+3X/o98LsO4m4EbAg2/O01M0FoC1x1kCxvVXmvtnfC7j37NWzlAnlfEvLhVbud0
         xElG0sJHcbEUwPTNAr0CjxB2AGkcHzwHFrCG4a2AQ90nEjCRuctaDiCv2J4lqP42hpfw
         Rzgz6fBlKGqy5CPx+ajIqNICNzq7wjJIfsnXJHDiIJfbcF2XB/qWantffT03QauxTrnG
         QEbhC5Ip7pn8c0Lfbx9lKLyQzZxVNOo1G/1vfeAl/hQ3XjL7x+YZ7odYUe2W1p3ZrTIg
         IXCA==
X-Gm-Message-State: ABy/qLbnexOUTEflLirVP90Yo1vcvcL4WoJqMfvbbrJDCzGA0qCSY392
        OqHx9NlpmV/sSGcSSV7U9tBDLg==
X-Google-Smtp-Source: APBJJlHYuGKkFhUbj4/g+lnn7IHgZET+cWPwb/gciRk73Ap9ki4NtfiSuNyeWYGARK+7KsmckTS24Q==
X-Received: by 2002:aa7:d412:0:b0:51d:e4b6:ff6b with SMTP id z18-20020aa7d412000000b0051de4b6ff6bmr377730edq.33.1689702928194;
        Tue, 18 Jul 2023 10:55:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id a19-20020aa7cf13000000b00521936fadabsm1530499edy.89.2023.07.18.10.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 10:55:27 -0700 (PDT)
Message-ID: <715caa18-e772-0b5d-4dcd-49a05eedf2ec@linaro.org>
Date:   Tue, 18 Jul 2023 19:55:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] arm64: dts: allwinner: h616: Add Mango Pi MQ-Quad DTS
To:     Matthew Croughan <matthew.croughan@nix.how>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230718152206.1430313-1-matthew.croughan@nix.how>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718152206.1430313-1-matthew.croughan@nix.how>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 17:22, Matthew Croughan wrote:
> Mango Pi MQ Quad is a H616 based SBC, add basic support for the board
> and its peripherals
> 
> Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
> ---
> V1 -> V2: Alphabetical ordering, added "widora,mangopi-mq-quad" compatible
> V2 -> V3: Added Signed-off-by, add to device-tree compatible/bindings documentation

Thank you for your patch. There is something to discuss/improve.


> 
>  .../devicetree/bindings/arm/sunxi.yaml        |   5 +

As checkpatch tells you - this must be a separate patch.

>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../allwinner/sun50i-h616-mangopi-mq-quad.dts | 183 ++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-mangopi-mq-quad.dts
> 


Best regards,
Krzysztof

