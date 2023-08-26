Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490B37894E3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjHZIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 04:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjHZIjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 04:39:13 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABC1213A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:39:10 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so2448010a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 01:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693039149; x=1693643949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EYzLu3AMnSBzud06vqVq1DYv850gj02s8/sr8kWECTA=;
        b=qlN9lkSoz+R+Wwuy0nxuQaqLw47sDENR1RxNYCmTu5wa7/xjxFLkqqKHaFNRAuvAmG
         ku0VPwPrYf3tt4irem6XMKNlBx/nAX/uQ+KZP2Ri8rMUAb0iycjZoDyggPJB7sEVLG5A
         aYzZjdqgVCpG6XCInzKTInplBzt8zuMzRZWOX5Zcl8rq4UHV+LWVPC8dSQ6pwdgiAGKY
         B7ioVh0vb4PpAACHdRi8Ycg8RaWSFGRTL4V8phfaoUzfvBiXLfScbiXxzh2smeO96BS/
         tsGs1Wv/+bLdEEiAgvfZo5rieE7HBdDQoVe6sknfCWhq2rokourV3e7S4Bm3b2e0zluJ
         zQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693039149; x=1693643949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYzLu3AMnSBzud06vqVq1DYv850gj02s8/sr8kWECTA=;
        b=OiUCk6nrglTmo3P08/ZhNCKIq7yGislGTFiyeq4mipabMJUUm7TFY92VGMRFpS2dQv
         qpjU39jXsRp0j7FH94ghqSxb8NCFjv5RwOpF5DbBpu2L36EJH3BWmFAaBxJM/bvOaewT
         h6jp2SNcyFQ+cE9inzNvSrneawnyuFWmvAX0lY/wu0iYDWQT06AxtoWGc8UVbqKwEqYr
         DBsZaIva9t9HQzBdqY4+W2e8vsOkI5eNs8p813HYJGGeic49dEckLf/9BzJ8ZWftXtGQ
         qu7m4H0mAw5nE/7ClB5822mRNDzXon2dmnAF9TjlM6WkgDWIV55aLbwzeNMJ9Ry84jKT
         klyg==
X-Gm-Message-State: AOJu0Yz4EK84aeeBKnibaKhkzkQLL8PwSz3I+w3UN8W/KyirgR+Et7Dq
        YNGJzdHssndyKG/YvUWJBJJG1g==
X-Google-Smtp-Source: AGHT+IH0NSUHl+zlxwX59+CEhOV2G5X+o9fhfo/09fJz4+7mLKi1QQsroRh2/Q+KC0BC7koudme1MQ==
X-Received: by 2002:a17:906:58:b0:9a2:1b05:24c5 with SMTP id 24-20020a170906005800b009a21b0524c5mr4521790ejg.43.1693039149327;
        Sat, 26 Aug 2023 01:39:09 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m19-20020a170906849300b0099cf91fe297sm1915891ejx.13.2023.08.26.01.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 01:39:08 -0700 (PDT)
Message-ID: <afd4843b-427a-8535-78e2-f81879378371@linaro.org>
Date:   Sat, 26 Aug 2023 10:39:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/3] dt-bindings: usb: snps,dwc3: Add
 runtime-suspend-on-usb-suspend property
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Roger Quadros <rogerq@kernel.org>,
        Elson Serrao <quic_eserrao@quicinc.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230814185043.9252-1-quic_eserrao@quicinc.com>
 <20230814185043.9252-3-quic_eserrao@quicinc.com>
 <a77403f5-8b99-3012-3843-1999ee8d12ce@linaro.org>
 <6b27cd55-4e44-7a26-30ff-9692344cae4c@quicinc.com>
 <31fa930a-51fb-6a7f-300d-e71f6b399eb1@linaro.org>
 <a0a6c561-6319-00ba-c6db-f1dec9f0f0aa@quicinc.com>
 <5dfae814-7233-eb1f-cae7-f335e54ce1b6@linaro.org>
 <cf0227c8-cd02-81b6-9e13-2e7fe6f505f2@kernel.org>
 <20230826015257.mbogiefsbz5474ft@synopsys.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230826015257.mbogiefsbz5474ft@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/2023 03:53, Thinh Nguyen wrote:
>>>> For example on Qualcomm platforms there is a phy sideband signalling 
>>>> which detects the wakeup signal when resume is initiated by the host.
>>>
>>> So compatible-specific.
>>>
>>>> Thus qcom platforms can benefit from this feature by defining this dt 
>>>> property. (in a parallel discussion with Thinh N to come up with a 
>>>> better name for this dt entry).
>>>
>>> Thanks, with quite a long message you at the end admitted this is
>>> compatible-specific. Exactly what I wrote it one sentence previously.
>>>
> 
> Various dwc3 platforms often share a common capability that can be
> shared with a common dt property. If we dedicate a property such as in
> this case, it helps designers enable a certain feature without updating
> the driver every time a new platform is introduced. It also helps keep
> the driver a bit simpler on the compatible checks.

That's not the purpose of bindings. Sorry.

> 
> Regardless, what Krzysztof said is valid. Perhaps we can look into
> enhancing dwc3 to maintain shared behavior based on compatible instead?


Best regards,
Krzysztof

