Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94A77C0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjHNT2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjHNT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:27:53 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704C7E5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:27:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40ffb4476d8so27465561cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692041271; x=1692646071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LR0ADMW4xi6cMDwqitYs8gzRkQkikF8OaP3FvDd3xKQ=;
        b=lwMiB4dvJQsgNSaBcz/PwGIcv42bJm43DuiSXCUNKLfixGs4govnKIV8CVtp021fHV
         gTNcPCCPoWvZk4PQFruIil1UVk5yH8JNgX5g7kzF+AipGTRVI0bqCUYz+9TwLu9zkRaU
         axVje7y8Cvn3zUEVmYj/thIqTgIY+UqWEX88nEBtbmqkfFDTAqHvmpvNWcDJrP/1Ain0
         1O23CnEW+2bKkfeKJVTozWzlYm4trtEFcms7JT+nBtlRP9j8JGHM4AIHeGxB2CRgDQjK
         Kmfpm9fVFboyJBObWqiOwBPWsEsc/tth2Yxr1pKL94/br18mRGGtBjcAFE7FSO8/vkt4
         kEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041271; x=1692646071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR0ADMW4xi6cMDwqitYs8gzRkQkikF8OaP3FvDd3xKQ=;
        b=HMR9KWpODzkq66vGb6YsWOJ86RJbiqRjVu5GuKXSynBpOqpL7ddYjqLqwJ7HVHAh6C
         4Af4+rpo+CBHcqxz9Cmdo67tu6Unlnc+F8FdNtlKE5y33fGiqjdyhS+JZWREFdNzpaUU
         KD+kUJfS3xLOBN4jl6l0GoOlq0Z4+bkRtCpzpCQjhvmSlTu7EDOJC1OTyCTGdT8MCONi
         PE5xens8T1OO9tbcsDEhbBrOGkbxSlNexxGfrxZ8kloLW3jeEo9FxOxWqG6R5ze+CXIu
         SIumVjR8dRAfFcM+1IcSQ1/PJ2V+LgBnx+ycMvgfRtxnUBsH/eHMw/ik1oGgZ5PFbnZ9
         Ob7w==
X-Gm-Message-State: AOJu0YygeLSUAhRZe6b83QGBWMAQXs7fwnAE+x36DweoT8Rnc5xHWbew
        8AeJx7oF87FrTi4iiBWNm1SgpH4+Ul1yqyFWNs0=
X-Google-Smtp-Source: AGHT+IFx4TCywBJe3m+ha9eU5cfWErt/wtuQs/gaFC7OSD2YXKVNLsk5cM3UOocA0Q7isoEbI8walA==
X-Received: by 2002:a05:622a:5444:b0:40d:760a:bffd with SMTP id eo4-20020a05622a544400b0040d760abffdmr9104142qtb.22.1692041271605;
        Mon, 14 Aug 2023 12:27:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id x13-20020ac87ecd000000b004100c132990sm3304754qtj.44.2023.08.14.12.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:27:51 -0700 (PDT)
Message-ID: <bd9dfeba-db1d-e426-3d36-221e1a4ef197@linaro.org>
Date:   Mon, 14 Aug 2023 21:27:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: qcom,pdc: Add
 SDM670
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
 <20230811-topic-tlmm_wakeup-v1-1-5616a7da1fff@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-1-5616a7da1fff@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2023 22:48, Konrad Dybcio wrote:
> Like all other RPMh-enabled SoCs, SDM670 includes a PDC. Document it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

