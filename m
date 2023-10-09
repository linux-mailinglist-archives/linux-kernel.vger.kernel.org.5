Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BD37BD9B6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346304AbjJIL1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346349AbjJIL12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:27:28 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654001BE7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:26:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-694f3444f94so3591069b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1696850768; x=1697455568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsfe35r8ooSP3DhlzGaGZax530VOuZcCVqPc76Jz+G8=;
        b=A1HdxuZGG7c6E2S8QwiA33bowHUeVkyNn0oTQBgLERaGNnOvsVDqpW+zFNbBT4VZEW
         ucyTcITjHka5LNh7kD7cbPCN+3r5xp2/pwIFjmealkWCObt+wvJ3COdPYy22g+MNdwPv
         tUaR8oD3B04mxywlr3p0Hoq/na+WCmEPbons9a27Q9e/uPKoTdevHtnwiu3DjFH9o3ci
         vZQFDHTk8iIJyd45NNPtG0fUOMk5FzD3lZRwPOZIFmTZZ+H4tlV0b8FektnNdvCdGzGH
         nTptmwmosvfHazWKWWu+iStyq6R8dVw4ZT74L3nnG9FMNxVszBKxKcPAnJ/0XGp/qQlR
         sXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696850768; x=1697455568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsfe35r8ooSP3DhlzGaGZax530VOuZcCVqPc76Jz+G8=;
        b=kdCsjHB+dNZluqk/Sn3DxO0PQ1BddABIlcZ/fkk+FXNZ+hkM2LYOSXGwRi/uNuMz9n
         w8dcBNBb7OwIXcPfrZQT0H0D8l7LlcQuQwNSPADkb/NcGYkoGIGmvl8ftVIZlHidNjeU
         Z87kxwukbxeiHuAIz2nqSHvop3vWaP4gMCwipjLsWx6SKK+KCuoMVCkm3dcX7+RPS/Lc
         3h4wYt/l8pmFILsee13U99sfcBvtD7BiV7m3MLYwcLwZ47s/LbvYO0Swv+XYT5d9dOXy
         0vHcm7o07ZNBoUemQyHfaIIv9pOfZOZCpiYeK3Ufw8eDYniv0u9U/RIB0MOgfZyGe/pJ
         sKug==
X-Gm-Message-State: AOJu0YxX42wmoleKERVs8eICsFU8ZowTT80kbBWl1v6Rb5yY8FUWDP3L
        RJSViBFqqJGnLdvR04OHArukGQ==
X-Google-Smtp-Source: AGHT+IERamTChL8jto5HfuCQzBKteg7fz6+WRHZF4cZ3oSUN3CsKBzo0JRWZ1NvfP+iNGmC7XNKjSw==
X-Received: by 2002:a05:6a20:4422:b0:16b:d137:dfb3 with SMTP id ce34-20020a056a20442200b0016bd137dfb3mr11519517pzb.59.1696850767700;
        Mon, 09 Oct 2023 04:26:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:bfd1:310:d6e3:7630? (2403-580d-82f4-0-bfd1-310-d6e3-7630.ip6.aussiebb.net. [2403:580d:82f4:0:bfd1:310:d6e3:7630])
        by smtp.gmail.com with ESMTPSA id be8-20020a170902aa0800b001b9e9edbf43sm9327575plb.171.2023.10.09.04.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 04:26:07 -0700 (PDT)
Message-ID: <6151507f-e0a5-f862-d6bc-f54c7f88f50c@tweaklogic.com>
Date:   Mon, 9 Oct 2023 21:55:59 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Avago APDS9306
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
References: <20231008154857.24162-1-subhajit.ghosh@tweaklogic.com>
 <20231008154857.24162-2-subhajit.ghosh@tweaklogic.com>
 <4e785d2e-d310-4592-a75a-13549938dcef@linaro.org>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <4e785d2e-d310-4592-a75a-13549938dcef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +description:
>> +  Datasheet at https://docs.broadcom.com/doc/AV02-4755EN
> 
> This is exactly the same as two other Avago devices. It should be
> squashed - first two device schemas squashed, then add new device support.
> 
> Also, the supply is not vin, but vdd.
>

Yes, they look similar. I will combine them all in a single yaml file in
the next revision. Thank you Krzysztof.

Regards,
Subhajit Ghosh
