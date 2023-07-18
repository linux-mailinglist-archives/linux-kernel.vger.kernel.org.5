Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEA275761D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGRICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjGRIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:01:52 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB41BEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:01:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so8078236e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689667216; x=1692259216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TMF8KkLHgIjjvuu9yRbShpISudcqJyFHmRqyTxc6O4=;
        b=jWuqqDtk3x6ktCQ+Glsyd2kL95uhDESKBMrQtRQ58ong17rYZworF6J3gSwDGvrOaQ
         09qHQCiL3V2B2BS/Oz8xm35SNQ8TMdBUSlk87J8GduCn9Wfu02wJGuKxFO+9plxPhHXu
         3TgtvZFt0v/WvpIURdO8NY3dgcerNOX1LIG6KSM0SkW4PRs/aSEswYlWBOn/OrKzTUhU
         Q/HFw+2oRp3N6TcWPL07pBqki4dfTuKCjbKXFdTMfc969Sviha2bpkEEhw/7p5GqTNEP
         CryarmLHTFBJSpXFfvz2q7455VMybZIJl9joGPMX1JBSj2xq1x/fEHXKicz3z7rO4+uH
         HRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667216; x=1692259216;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TMF8KkLHgIjjvuu9yRbShpISudcqJyFHmRqyTxc6O4=;
        b=hwjnvl5vQeG/UoMihde+v7UCEB6iRstbjHGNjVvvJhZ5K95X8PmRpPZErV954xYn4i
         Q3G68EFX2KuHNiUXrDAjbv1XGcM5bFbfKOJOW5wuoJG2vFguSIYFRXcyinTsRWS95UDW
         LFSk/HMEKd8oHLmR0+HaHj/KXctsZQIPsk9+ImgItBvOJeMwi8TMbVC5rq+de178IzbQ
         hu2PDFk74WwSqyuzsbSSklGOOaRpG2STWMRYkOfyPPgiRJCdk/sAwsoLZ1a3amzdR11w
         3IXdlKquLYafQzxLDkZa+Yk8MJ2YEtZx67fOpRSBA4Mm61Z+A/8TFKUKIgY4/jYdw7E2
         wvDA==
X-Gm-Message-State: ABy/qLZ0Tncg0P6mpvaj63SDjBLLvVOEn8LT6kxy6+E6s41NvQB9ziBh
        Xk0HX3iIvTZYg2uBSArci9kIiw==
X-Google-Smtp-Source: APBJJlHk3u4MdO8axVsUFrnEBFxv5a8PaAepGuSbyIx6Wu0c1NWLR2Yv9yDhcPOpldRKz2pvU9g3mA==
X-Received: by 2002:a05:6512:3d03:b0:4fb:8f79:631 with SMTP id d3-20020a0565123d0300b004fb8f790631mr18681248lfv.46.1689667216606;
        Tue, 18 Jul 2023 01:00:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k23-20020aa7c397000000b0051d9dbf5edfsm825879edq.55.2023.07.18.01.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 01:00:16 -0700 (PDT)
Message-ID: <9ac33c64-337d-d9b6-275c-94942797e5a4@linaro.org>
Date:   Tue, 18 Jul 2023 10:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: add phy-supply
 support
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717164307.2868264-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 18:43, Marco Felsch wrote:
> Document the common phy-supply property to be able to specify a phy
> regulator.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

