Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0004477487D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjHHTdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjHHTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:33:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D98C3C20
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:37:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so9396317e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691516238; x=1692121038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iq0fuWZwZqbSchZWggB1/iaIkWHEYwpCz6Ex4V1jQs4=;
        b=SPe+Yke/rR47Tg84RtKmVhZP+pYTDaBGRvW+Nm8DQwMtZAOfZs+fXjao6BU4u0k88Y
         AMK4PCKwboLtNwuK2eja3JAq5H5AVjpU1Lw6WtBw3Eu3aEv82M5QuF8jnb9aLyzuIp3w
         +m6iOAuqik4CmbcDDOLTQHBhw4NmYpf7+YLkhXmHgwX8RPWyqETcswg2rnldpiuJ5bO8
         wZcz+KClKDnU8yKA9Yj5/HX8prsdykKmwEq5jvYaPOmkdG9C3B1Ex3QI1kTIXIi63F/s
         VF+bP56b2YovWR7LWv7wPDH7TJtAsZ/MrLJROHo69J/JbJFsN3Q5Svps85SeQgPzC0nK
         Gq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516238; x=1692121038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq0fuWZwZqbSchZWggB1/iaIkWHEYwpCz6Ex4V1jQs4=;
        b=PaInogDCShb1cx2OJWDDnajD/HPbuX9wlOn11tfcbSOLdHEbCggWzwxS3YiG7wpFkk
         5U3r5VBC1ur5zByOqHp5qTcGEHElMlZsBXfwp1ZFjNBhF0h7iU6iiIBNerh6WVkdxrm5
         Ci1ZtYVZOTiqgx6qZwpgvkJs7AyvEbXt8KREnumketGsinVLrtCGw524ZIQYOsAJ/TI8
         4EIj6LoFS6uF+a/mmJ8GWsU5eLdPRoeowE9wlxAvxlaXTh/mhoJ6DXhVKU9CuB28zg+W
         a0OvdJTUpQqj9EttDeNHQdZ19x75+dxaXxhlpSe72XpRBENRMh23C2IMZCfjtOUhhApa
         8mcg==
X-Gm-Message-State: AOJu0YzsPn5SuuNFIB/drl10GHZwqQBYdYUigdcWk1s/AZXhBaMsLuWT
        EDbVPLeshKttB7AHi8XPKLMSKsRe3sWYMs+zNNg=
X-Google-Smtp-Source: AGHT+IFqJWNgx4SDpHJVEfxD9C+abszRRx1REVJ80Xsoki5bg1/ZLXXf6uPqaSk3im75Pf+vcP0AAA==
X-Received: by 2002:a17:906:74cd:b0:993:f90b:e549 with SMTP id z13-20020a17090674cd00b00993f90be549mr11013614ejl.37.1691484825944;
        Tue, 08 Aug 2023 01:53:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id s5-20020a170906168500b00999bb1e01dfsm6303027ejd.52.2023.08.08.01.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 01:53:45 -0700 (PDT)
Message-ID: <56593261-6e7d-9694-91d0-dfbac24aefa3@linaro.org>
Date:   Tue, 8 Aug 2023 10:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: yosemitev4: add Facebook
 Yosemite 4 BMC
Content-Language: en-US
To:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230808084248.1415678-1-Delphine_CC_Chiu@wiwynn.com>
 <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230808084248.1415678-3-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 10:42, Delphine CC Chiu wrote:
> Add linux device tree entry related to
> Yosemite 4 specific devices connected to BMC SoC.
> 
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

