Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0502A792A7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbjIEQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354289AbjIEKgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:36:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157B0199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:36:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5007abb15e9so3910712e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693910162; x=1694514962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/U9siKDyazHDG6r3zqTARi8NY0BAa80rOt591lmpFyA=;
        b=aJmXjS1jCiGy32CzRTnfQyuYXlBEDVVB5skg8kPQ+KA/i/5aGEHvWGhr9QfcMzHod/
         I8BrAViAFIuRAlWgvrC+Dde32wkYsIG1vuIg3ONE+fqZaNAXsb/wv0ebaqguSZk61qEH
         0EUuOjRz8VkP/LDjhKwzHzrdkyhZMqs8S2Tn1I/8YQjf7Ef41wKF5qPs+/bdT78Rx+Ow
         gCSxei3n0dd8maqFRcdUhq5CRC9/qaOgR7EOgP4ihLX4xRAg9RPgQAdXFi/cdIdhupNf
         7wX5WJcxLLv1UpkddUXO7Nlj8W+llgLBPmyRCUFL4+XvDKrUFXprnbckJQFKQ+/wUXDW
         TkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693910162; x=1694514962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/U9siKDyazHDG6r3zqTARi8NY0BAa80rOt591lmpFyA=;
        b=brJVaroSgzg56Geq+rwfLALOP5rStYxhCAMtu6P4nzn9iw+t8lnEHYgS2vxCBf2X7Q
         v8KbBEEaaydlJETnPfr3myzo236OcWaKsKJzmPQW0zjG1pC9kTJQmLj/THQR4R4K+xtX
         ZXeXeXi/4aSUWWFB9+zztSDONaiJ4/XnvQv40vBD0nZWXw+rwkh7OP8hQWAcYIpCsUkZ
         e3f0+OPaQZ+Od9wMtwdpuB4QeJ57eXXTD4mkytpH7ZZcE+R5HOVNHKHuW7c5uoAMwYRN
         woJ3y7e1fVlrX4eHuXnvyfZ0Yq+qktDW73+bpqPf+O667S2/8j4aaI9WJM5/sXZguI5N
         Qn8g==
X-Gm-Message-State: AOJu0Yx+NJl+LR5AOabkfwrx09fojESb7NnnJVed1OP46wg4MWbDJqtA
        wFTDnFF1PV47iuUAkiCngIpZCw==
X-Google-Smtp-Source: AGHT+IEEwILeUUAxmLD1NfgpOLlzLDQpUZMD+JAAHfLvTOal4CKjljt/zxapSOY7fQ7wrcKXF88iDA==
X-Received: by 2002:a05:6512:3087:b0:500:9a45:62f with SMTP id z7-20020a056512308700b005009a45062fmr10157967lfd.8.1693910162221;
        Tue, 05 Sep 2023 03:36:02 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709067f8800b009a1a5a7ebacsm7282198ejr.201.2023.09.05.03.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 03:36:01 -0700 (PDT)
Message-ID: <ddbc2681-bbda-88a1-643c-54fcabc9b83a@linaro.org>
Date:   Tue, 5 Sep 2023 12:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add mt8395-evk
 board
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
 <97b82a16-8710-9430-35c8-673381aaa417@linaro.org>
 <d5645707-bcb0-4d4b-1d94-d3cd17c042fb@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d5645707-bcb0-4d4b-1d94-d3cd17c042fb@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 11:36, Macpaul Lin wrote:
> 
> 
> On 9/4/23 20:11, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 04/09/2023 11:50, Macpaul Lin wrote:
>>>
>>>
>>> On 9/4/23 17:33, Krzysztof Kozlowski wrote:
>>>>
>>>>
>>>> External email : Please do not click links or open attachments until you 
>>>> have verified the sender or the content.
>>>>
>>>> On 04/09/2023 11:20, Macpaul Lin wrote:
>>>>> Add bindings for the MediaTek mt8395-evk board.
>>>>> The mt8359-evk board is also named as "Genio 1200-EVK".
>>>>> MT8195 and MT8395 are the same family series SoC could share
>>>>
>>>> How can be the same and have different numbers? You sill need dedicated
>>>> compatible.
>>>>
>>>
>>> The SoCs mt8195 and mt8395 are designed for different market application 
>>> and physical characteristics, using different efuse values for 
>>> distinction. The booting flow and configurations are controllered by the 
>>> boot loaders, firmware, and TF-A. Therefore, the part numbers and 
>>> procurement channels are different. The detail information of these 
>>> efuse values is proprietary, so I cant disclose it futher. Hence the 
>>> most of peripheral drivers and base address are almost the same.
>>
>> 1. Drivers? So we talk about compatibility, not the same.
>> 2. "almost the same" is not the same. Follow the guidelines for writing
>> bindings.
>>
> 
> Thanks for the review.
> 
> After internal confirmation and discussion, it can be confirmed that the 
> MT8195 and MT8395 are identical SoCs from to binding's perspective. 

I am sorry, but I really do not care what you internally discussed about
bindings. I do not think your internal review respect existing
guidelines. You talked about drivers, not "bindings perspective", so
your internal discussion is clearly discussing something else.

> MediaTek hope the mt8395 boards could directly use mt8195.dtsi, without 
> the need to create a separate mt8395.dtsi to include mt8195.dtsi. 
> Therefore, we hope to fully adopt the bindings of mt8195. However, I 
> will submit a revised patch for compatible since they are different boards.

You can disagree but then I expect arguments from your side.

Best regards,
Krzysztof

