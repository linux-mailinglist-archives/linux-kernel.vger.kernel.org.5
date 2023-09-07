Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E679737C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbjIGPYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjIGPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162831BF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:23:33 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso482297766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100211; x=1694705011; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ragyha6lBrnhd2E4z05r5Sz67SJVNmBsRmnvqyiefU0=;
        b=yeFc3EYnOrz/JFx7nFhlQ9BUxPnYYeDFN9tN5eZLqDU1ZjzQBSwqpmHQV7O3Num/QZ
         0QSFukvDNScT5ZjKQJ6zm+RAl+yZkbdP53kw6C1xKRzUK/C9/9D44wHJG4lXbK45XvjA
         HwSUyQfWN2yNTFfPiIqvEKsFBU3sIygNXzVK2BG3rbLtqJnq/Wk3VocX+mul0JZnpoob
         IrLEagH3jgHK+tXGPm/mEKxS/2a1NMcXWBZQnllcylRgHLOxnni9JcljFTef32f0rbTG
         M5HwtZzc4XQ4D9ZbN0BVHIqeLCfO1TOUnX/4oD+jVVZ+t8R6jtoQQaGFbqzlcy26LRsL
         YQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100211; x=1694705011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ragyha6lBrnhd2E4z05r5Sz67SJVNmBsRmnvqyiefU0=;
        b=Iej2YQ5AzHvTClTbfBs96/Bfd5s5jE7pmPRmowVptwOOTzBjlE7CFqaa8kkPYfp4t6
         c+uzOylZ84p/098LDvA7ENwBvr5XILm2cElSWpI1X0vFobdLSIMTxxlcPGj/2evCNKeu
         xuEte1fJDe7EDPF4LrYPZOktmeK3lnnnv8JZpUJMgUEXRbJIwH68fuCc1QNgE52CbQlH
         vaPL4fo91Cec3q3HGptPF5UUeSrwOqe1GxeRtBdoVDahnV0GpB2RoiFDERrFboPVg7LV
         1q+EnhwajNx9gIFoZ/kIcNnxBEwgyoYZdYTDX0OVg0YWvjwQTTPDGNGzECgFVuF1tL4C
         o0HQ==
X-Gm-Message-State: AOJu0YzZZfBe8kkp3PwruC9VQC4+dOZpczTupntSjBBo/X9N2ZLDAYnA
        TtKD3yLjrmjldC+eMLsjo4l2riwEQYnmoGF6pEc=
X-Google-Smtp-Source: AGHT+IEP5lHuo6K1dRgooEVKve4Q+c2iLkWlLM+qsv5lJAaTMcXKxc9v7sPbPiK8aU4DbGM8Si9Acg==
X-Received: by 2002:a05:6402:26ca:b0:523:72fe:a3c4 with SMTP id x10-20020a05640226ca00b0052372fea3c4mr2255438edd.0.1694066304465;
        Wed, 06 Sep 2023 22:58:24 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id bm26-20020a0564020b1a00b005288f0e547esm9343359edb.55.2023.09.06.22.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 22:58:24 -0700 (PDT)
Message-ID: <07acf4c5-6a03-0196-335c-88f7c367a526@linaro.org>
Date:   Thu, 7 Sep 2023 07:58:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: add mt8395-evk
 board
To:     Macpaul Lin <macpaul.lin@mediatek.com>, frank-w@public-files.de,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230904092043.5157-1-macpaul.lin@mediatek.com>
 <20230906092527.18281-1-macpaul.lin@mediatek.com>
 <fbad941f-232b-9f56-5de3-98a16a8c4d89@linaro.org>
 <c3ddf00c-235a-2d23-db60-c998a67a3fcd@mediatek.com>
 <f343b6e2-6106-47eb-71cb-f391aff6cb7f@collabora.com>
 <50f7fbdd-8592-7a47-b2d8-a1af8ed93b92@linaro.org>
 <c951f693-b219-4745-be20-a8e1fee0099d@mediatek.com>
 <E3DEDA34-C203-4560-B07D-8BCB44204FF3@public-files.de>
 <8db8823d-8313-5515-78ca-effc8d6bc47f@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8db8823d-8313-5515-78ca-effc8d6bc47f@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 06:07, Macpaul Lin wrote:
> 
> 
> On 9/6/23 20:19, Frank Wunderlich wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> Can you please only target Reviewers/Maintainers and mailinglists reported by get_maintainers script?
>>
>> I have only sent patches for mediatek and did some tests. So i'm not interested in patches for hardware i do not have here :). I guess i'm not alone...
>> regards Frank
> 
> I'm sorry for bothering you and other contributors.
> I've indeed run get_maintainers.sh script for these 2 patches.
> Here's the result.
> 
> Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED 
> DEVICE TREE BINDINGS)
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN 
> FIRMWARE AND FLATTENED DEVICE TREE BINDINGS,commit_signer:3/4=75%)
> Conor Dooley <conor+dt@kernel.org> (maintainer:OPEN FIRMWARE AND 
> FLATTENED DEVICE TREE BINDINGS)
> Matthias Brugger <matthias.bgg@gmail.com> (maintainer:ARM/Mediatek SoC 
> support,commit_signer:3/4=75%,in file)
> ...
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
> (reviewer:ARM/Mediatek SoC 
> support,commit_signer:2/4=50%,authored:1/4=25%,added_lines:1/12=8%)
> Frank Wunderlich <frank-w@public-files.de> 
> (commit_signer:1/4=25%,authored:1/4=25%,added_lines:1/12=8%)
> ...
> [striped...]
> 
> You've contributed the similar percentage as Angelo for these files.
> So I think both of you could be important reviewers.
> I'll try to skip contributors who add lines less then 10% next time and see
> if this will help.

No, commit_signer is 1. Don't cc people unrelated people. Unrelated is
everyone which is not maintainer, reviewer, discussion list.

Best regards,
Krzysztof

