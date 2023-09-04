Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD6A7916E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350566AbjIDMLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjIDMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:11:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7865F1B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 05:11:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so1891022a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693829507; x=1694434307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyfz+f7VyGeUd0ysOTxZ3d34KQmY46MduGm04AnUCII=;
        b=rYM381EFgBFi8E/Iyo6FVn5MYSQPJcqKqJ+ITf7UM8UIWTZHGOffztPVRCup+wrzov
         wKgha5Di6MyJRqhJWB6XdUXcl5w2JUu/5PrZ4/NgflKz0sfwhDJI56kQagDaGLjZ7Y/W
         YDOjCQf17SqyVGK6OjjOpS2W9xnBaGZmYPZ4NdQ6dE3sIT1i+uQmSleJ074I2VNK51AC
         LbYOng7JcQnVLBnx5RKQzsJlx52A6h2imBGaU2slAhlh3hbWXfUk3tuTQbFxgS1HezxT
         d3EgljWn7CM844/+EaXnIHDN0InNLJfYf93wDnTYz1xJ2U3b8nSoeRAHV31Cwd2IwXvp
         6pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693829507; x=1694434307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyfz+f7VyGeUd0ysOTxZ3d34KQmY46MduGm04AnUCII=;
        b=RyJ2Rc4cWKD3t2Lr0TyeQqGcqo4dJlG6LNe/fjRXcj4Axw+nA4muw1Jm45BOpfEoBZ
         eTlNwm8+SOedEg+HAsPBXKKSUX94WF4FW05GSGk6OxkmwpE7aSYhDlAMSH/mGOQC2kXE
         jTL9UMNZcdStxnR8SUVVADWGzE4N6gkQk7eayo8hf/nTKh8bjDC87h2Xg/Xa54pAQ1hX
         E2GayK9xGD6ZjHfPOPT8C4QhwjYmeVLdgDpDTvh6okC1UvIQ+ExYmSQrBMpaF7Z8pwFp
         XsTzcYU0S91XQ+PGdwIbD+eluhFAmMu/IdMoWvdFScS1VTt6okRn3VWH1p++kbkST1vL
         fiRg==
X-Gm-Message-State: AOJu0YwerjeuEopkSwkQ96gxA8inWNHE9QYGIrdamN8TlBA/NATIwq8C
        Dh1Wq0f/Wez3HhDN+BEqUWINSQ==
X-Google-Smtp-Source: AGHT+IFB2Jh7XUiVV5an3Jp+fAAPvez8NEAQzLDG1i59tLqMZgGpLkp9bUYtaUJ+4kgbsc/ATfvo6g==
X-Received: by 2002:a05:6402:120b:b0:51e:2e39:9003 with SMTP id c11-20020a056402120b00b0051e2e399003mr6398291edw.40.1693829506925;
        Mon, 04 Sep 2023 05:11:46 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id i19-20020a056402055300b005233609e39dsm5821877edx.30.2023.09.04.05.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 05:11:46 -0700 (PDT)
Message-ID: <97b82a16-8710-9430-35c8-673381aaa417@linaro.org>
Date:   Mon, 4 Sep 2023 14:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8395-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <e2e35d4d-7853-fccc-28c2-b8ecf309d6ec@linaro.org>
 <00f0a1cf-6246-92e9-13b0-cf31bb292a94@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <00f0a1cf-6246-92e9-13b0-cf31bb292a94@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 11:50, Macpaul Lin wrote:
> 
> 
> On 9/4/23 17:33, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 04/09/2023 11:20, Macpaul Lin wrote:
>>> Add bindings for the MediaTek mt8395-evk board.
>>> The mt8359-evk board is also named as "Genio 1200-EVK".
>>> MT8195 and MT8395 are the same family series SoC could share
>>
>> How can be the same and have different numbers? You sill need dedicated
>> compatible.
>>
> 
> The SoCs mt8195 and mt8395 are designed for different market application 
> and physical characteristics, using different efuse values for 
> distinction. The booting flow and configurations are controllered by the 
> boot loaders, firmware, and TF-A. Therefore, the part numbers and 
> procurement channels are different. The detail information of these 
> efuse values is proprietary, so I cant disclose it futher. Hence the 
> most of peripheral drivers and base address are almost the same.

1. Drivers? So we talk about compatibility, not the same.
2. "almost the same" is not the same. Follow the guidelines for writing
bindings.


Best regards,
Krzysztof

