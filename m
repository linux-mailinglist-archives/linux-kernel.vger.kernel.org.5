Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD076846F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjG3I0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjG3I0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:26:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5DD1709
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:26:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdcade7fbso439274566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690705566; x=1691310366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbca5dXAA/CsAVzj5b0FSbHE1+BN0Gm2+1XNguRAkFY=;
        b=axmbOWocWR1Hs5AWePpS2pz35Ro2v3chDLV3qo7j6McOKGhGC7dMlbAeyRHhUGS/0E
         0ca9lOwQPJCAfLvCpYpxuVH1nxCA2vxAGWZt5f8r2LsF8NEA+jBiulnaX6a+QGBJJoxr
         TMKELJ9iPdsJPJuYl4WCjIjtdeNOzHrHHx2BbONnQlOmwFnHEpoK+VKljN9mCuJb0OFJ
         aa/kbz2PE+tUtFhWTnvB0P48b76Oy8Vfik3QBUcfDLx+kZWfMr4zuxk9OBo/rTRK+E9A
         0DLMa8LYr9GZ9l9bXLtVWu+yQASAdCH1qkYpiUzPfhnnf6/hYYvUfMP0s7vyaVLD4QD3
         sQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705566; x=1691310366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cbca5dXAA/CsAVzj5b0FSbHE1+BN0Gm2+1XNguRAkFY=;
        b=DciIp2LcpRrbATXVD6WTibm8hmtZn7SMJA3eZfo2x7gwQVCYEwqSSjDvV9FWyhGPfs
         ebQf0QgXiFt7gT2QB3AgGOj3LAS4WxH0Tk7VW0CdGfrTiIOAMS31ap8mk14BATDT/tYd
         EB9oDLz80Oes3+wQUv46go+zQGyR3ln9DhL4TmU7hW/RqiuetPQ4N4/HlWAVrBkbYueg
         zSM5NlgGH+bQueFSz/TEiaR/HWElzDTWzGAxdB+owyGdQBTinOun5KFP37DHKS0MoxCJ
         PlBH2mr8kv+Giv3Al+5OhKeV18A1sdOZbyls5nIeu/tqkz/oQuzvlQh+lazJSf9WiEKh
         23cg==
X-Gm-Message-State: ABy/qLanzvgSsItJ6jDydtJVPyjWR8PV6CnfsT3KgHWNJVpYoeSPLMjI
        TqodBd8Cr4qSBxsplV8ijthxsQ==
X-Google-Smtp-Source: APBJJlF+hgS+GuCqh01N/8YF2wf89TRNJBobKe9fSDk653BjvVHt9a51l9CtA0cRjaq51px+7TsaCg==
X-Received: by 2002:a17:907:7638:b0:997:deb1:ff6a with SMTP id jy24-20020a170907763800b00997deb1ff6amr3215763ejc.22.1690705565846;
        Sun, 30 Jul 2023 01:26:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id f25-20020a1709067f9900b009934855d8f1sm4305188ejr.34.2023.07.30.01.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 01:26:05 -0700 (PDT)
Message-ID: <2ee2336c-d54f-6fb7-0142-8d0e08cce25b@linaro.org>
Date:   Sun, 30 Jul 2023 10:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/17] MIPS: loongson32: Convert UART platform device to
 DT
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-8-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729134318.1694467-8-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2023 15:43, Keguang Zhang wrote:
> Add UART device nodes for Loongson-1 boards,
> and drop the legacy platform devices and data accordingly.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  arch/mips/boot/dts/loongson/loongson1.dtsi    | 54 +++++++++++++++++++

Same problem - DTS is always separate. It seems you made this mistake
everywhere, so entire patchset needs to be fixed. Keep all DTS - your
base board and extending it - at the end of the patchset and squash it.
There is little point to add new DTS in steps (e.g. first add incomplete
broken DTS and then immediately fix it... no, instead just add correct
and complete DTS).


Best regards,
Krzysztof

