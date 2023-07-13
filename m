Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11B0752AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 21:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGMTLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 15:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjGMTLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 15:11:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08FB173B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:11:02 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3143ccb0f75so1296840f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689275461; x=1691867461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZHtFaKwOC0c8sQncRhDK+3GAV+TH5migs5I8qyyzrF0=;
        b=ZAH6U6fkqdpRGVD/CSrog5rN1GyMYtgyWn1ASwnSI4HiP9Kt3Nf05kA3zw1eM9f9rg
         LYEHXx6VQJhERdP8TJ84jXOPj8hxMFlbPtrjMbBI66DeLvyNSVrWQ7uGnes9/nvWMLEN
         R7p7kHTp630wNZeUgtAxLaTLqI8oeYo4fCNTnezzHIxrOPfSFqnVMmBYyvpFo8ricKwx
         fjeIHbti7yPCX8yreef3297F44s//B6d9PgwSWQuHK+yDks+LMoYfbgmZDv9lFP8t3CG
         uUaZeyvqunmTY2CtT02JFbqNiOs3wSAN/4pDDuIAP7sKdDAVr7tKHQCKAS2i6cJOFHI/
         j2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689275461; x=1691867461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHtFaKwOC0c8sQncRhDK+3GAV+TH5migs5I8qyyzrF0=;
        b=JV+wxV3NRLr4iVQfiCWkaUco8ygHWtgmtEZ3BhwuxqPZd5PID4bOUuSaYsZqOJnbsZ
         df+BgqYjc7CzWfXWWW/c2dANkEGgIoB4FnF8/RUY7vCuuFjyxwTXCwxCfzS6BpqcUcZK
         CuPdbGuZLdkOvly13v+hvAQHYaAqBjaz9V34njHwts3Jk1ToZkJvtSUCfnyELcV9KezU
         xkolH9oWq5zglMQNdav7EjpVcpqeIVOjqnQYOK7PcS5ZnzDnhVFHx313HWpVgPCaihwn
         9u8ITYWUFDDwytg7hYK6XneCk8Ba/BaL9ql6GXB9Khi6vDgEFiZpl4EEuMS2+cbkOzrl
         YTrw==
X-Gm-Message-State: ABy/qLaQe7Cbo7cuJGdiQ0RXmrm5o9tldXxNkKAYVI8euLEYPaN+/Nth
        7mW3OQ08JjYUdbN9eC7YhpLvbg==
X-Google-Smtp-Source: APBJJlGyWy8tCKeVGAlBh+DlwifgnbuWtjHsXY4V6N1ieKwsw0wvpVADWeFwjp+Y4bcxaI5Az7NHDw==
X-Received: by 2002:adf:ed49:0:b0:314:3997:530d with SMTP id u9-20020adfed49000000b003143997530dmr2703871wro.31.1689275461227;
        Thu, 13 Jul 2023 12:11:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d65ce000000b0031437ec7ec1sm8822806wrw.2.2023.07.13.12.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:11:00 -0700 (PDT)
Message-ID: <e1c3decd-3424-d7ed-9f2d-93242d163232@linaro.org>
Date:   Thu, 13 Jul 2023 21:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: Use local header for SERDES MUX
 idle-state values
To:     Jayesh Choudhary <j-choudhary@ti.com>, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peda@axentia.se, rogerq@kernel.org
Cc:     s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230713151707.8109-1-j-choudhary@ti.com>
 <20230713151707.8109-2-j-choudhary@ti.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713151707.8109-2-j-choudhary@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 17:17, Jayesh Choudhary wrote:
> The DTS uses constants for SERDES MUX idle state values which were earlier
> provided as bindings header. But they are unsuitable for bindings.
> So move these constants in a header next to DTS.
> 
> Also add J784S4 SERDES4 lane definitons which were missed earlier.

typo: definitions

> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

