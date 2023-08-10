Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529A17776F2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjHJL1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbjHJL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:27:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA3226A9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:27:32 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so6835905e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691666851; x=1692271651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDbzZey8z8DtjOGfcUbD6PYAKPLiO9y+FZZkbeDm/yY=;
        b=jxmtsAJjcEPs8cRRbIh7ZgDTTpeRxDiC3NZPtDMXJcegH6VfgS6mHiHmS6gEgHhH8f
         6hMy0HXP6QI0b3hEkl+gnD/L5UVI1dp/n7C4kcVnG/Ahwd3MX9U7NYJwHWWwlnvD4/sN
         OJNSKYipquGsdoZORbouk0pTNYTNGFG19mddKFlYS+kkSeI+EPv7mANB8L3+J/eTpm7w
         Eyg2NdiPSPmzin05dvifrn55Wyqr6escz4bJLOR8pO5AfLm75aA6hSAQJo89ZrZd0Q8d
         p2JcW2gDEtaHbF7qYFMHK0sJrYg0ceYduPbRiZoNiRomZEal7je0QBaI33AMH4FYrwSY
         FsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691666851; x=1692271651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDbzZey8z8DtjOGfcUbD6PYAKPLiO9y+FZZkbeDm/yY=;
        b=HOcmhoKBGvozKe5qm3Q8VQvkhv8cv5xKP5jBtU3W2toVOgDYTaTb8vDo8xA5eiuIHz
         XCmceTZedGse/rychqVRYcWWDGOauwufJQ2pZlFLSnoZqAua4JagT17zwRxUX0orjPxu
         LDYmCF+NmZJCqTsLxZ/qJkVpdPzlRhCv2qGbp0eml+6tjsylmgTOMiMWMZR0Nbz4o6dK
         nxPthjnUx6zCKY5SwCOwGzboduXSh9aEmYVlVrdX0mtuwzPdaX5OhkvuZeLceQ12+rZh
         gG2SrBHVaYswVDqdtkMkFffImZ9/LU8Gp5QtGhyriCu1rfkO+yT9anBAy39YH5ZYvglG
         lbJg==
X-Gm-Message-State: AOJu0YxjFDbHXGpEBZrP8klR39C3ch7VkobfenSNhfM1321zujVicmag
        quKrGLM4LX1yXzhaCJRsiEu/ZEUC5rGloi5DTyW/OQ==
X-Google-Smtp-Source: AGHT+IHLENZ3IIOqh0ZfoD3+FGlR+9ECXsB/eKGjaTzjh9wztsBxBUxpOQYfG7csZwYPpeMgWwDfNQ==
X-Received: by 2002:a5d:508e:0:b0:314:2732:e81e with SMTP id a14-20020a5d508e000000b003142732e81emr1740898wrt.8.1691666851414;
        Thu, 10 Aug 2023 04:27:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b003179d7ed4f3sm1903355wra.12.2023.08.10.04.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 04:27:30 -0700 (PDT)
Message-ID: <4e05a1fb-f6f2-3219-b41d-67351c70a7ff@linaro.org>
Date:   Thu, 10 Aug 2023 13:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sc7180: Add board id for
 lazor/limozeen
Content-Language: en-US
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        dianders@chromium.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org
References: <20230809064908.193739-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20230809144516.v3.3.Ie77732a87ab53d21bac47db309b75a796fa19337@changeid>
 <cd15df3a-eadc-13d6-7088-3ad785ea733e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cd15df3a-eadc-13d6-7088-3ad785ea733e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 11:30, Sheng-Liang Pan wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
>> Isn't this duplicated with r9? Probably other places as well... or....
>> separate r10 add rt5682s node which different with r9.
> we separate r10 add rt5682s which differentwith r9
> 
> 
>>> -	model = "Google Lazor Limozeen without Touchscreen (rev9+)";
>>> -	compatible = "google,lazor-sku6", "google,lazor-sku18", "qcom,sc7180";
>>> +	model = "Google Lazor Limozeen without Touchscreen (rev9)";
>>> +	compatible = "google,lazor-rev9-sku6", "google,lazor-rev9-sku18", "qcom,sc7180";
> 
>> Your patch 2 does not make any sense. Didn't you touch it in patch 2?
>> Really, what is happening here?
> patch 2 explain why we added new sku for no-eSIM.

So which commit explain why you touch the same line twice? Sorry, this
does not make sense.

Best regards,
Krzysztof

