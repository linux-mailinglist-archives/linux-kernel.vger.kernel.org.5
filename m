Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903DD768476
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 10:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjG3I2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 04:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjG3I2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 04:28:40 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234231FE4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:28:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcfe28909so491270766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690705666; x=1691310466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D60VbFymTmhk33TulwzZUfrsQML4Fn7VfvjzkkAQ+Fw=;
        b=v9LyuYPhpC6zcLchqJqp+K/pksVlx/CBkDNKjRiTnvqtKr3pmNJXzl3FHUDjuzf18E
         9b2h1St0PpofjI++XeuayZCfHG0TDgEsZIE6DPoQeVeuPyj16CpLCQqWeBS5HByjtv8z
         sZP5LqylaJZTUptNhODkx0aw1jfyJN64TzQCVxQp0a6XYhEq6I4jjbBNI+MDOAv+vaU4
         0bOzSJFO4PhEobSuRRgAwgdWiLCJqxxQ+2juO08hKddXwcIMDwPN5Q3ZqHz+rYjYRqn1
         Vg6mNtBGtlUg0HnvkU9h2bV9l1+ayXOpo6264yJBjV+rrXYosNdd1xtRVSIMdh5MPKRo
         nVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690705666; x=1691310466;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D60VbFymTmhk33TulwzZUfrsQML4Fn7VfvjzkkAQ+Fw=;
        b=a3+ixBt4OWJ6egUM37EqFnxVgyT6jMPZKrEPqX1LJq3yOo367sC7PV21uXOTqjRNdo
         C0R5Oq1xcyMtKrj0ffGbqSjkmom6XrzbIMqMJWo1cqxcT7jL3aXeuGhrLwcM19uSGaxm
         ApBe2A/xBlhWFr73RIIYxegajOMuK/0qtj8g6m5jCfwaObo7loGlpXSP6FPHmD5faO+t
         EHnyiehYoRcuByWDwimhnTIMgWS6TUjumQ5mYLEHufvSdJg0RXiaam6LvzuVFuXX2NlS
         VUHt8nd/BvxLEx2F5TqnHdp9JCgRNPDPbKRNwoZKvgwOcWDwAQJaOrXTX/tdhq3PeKq2
         DIPg==
X-Gm-Message-State: ABy/qLYip7/euflhrJMlh+UZ9zvoKfFfkvgIxqWkBha0e7cLJo4517yY
        uKcNi1C3LlxVX8Wpbwq88hTsXA==
X-Google-Smtp-Source: APBJJlEkx8evuqe35HveMmTK6Z9zxyAvK3EkdcIpk1D+eGhBx5CLd26uF+T5+BYxOm63+kwz6uVdTQ==
X-Received: by 2002:a17:907:784f:b0:99b:d693:cb8e with SMTP id lb15-20020a170907784f00b0099bd693cb8emr3556505ejc.71.1690705666463;
        Sun, 30 Jul 2023 01:27:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00993860a6d37sm4314892ejo.40.2023.07.30.01.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 01:27:45 -0700 (PDT)
Message-ID: <dfd8be75-6ae7-8989-4717-db82c5c0656d@linaro.org>
Date:   Sun, 30 Jul 2023 10:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 14/17] mips: dts: loongson1b: Add PWM timer clocksource
Content-Language: en-US
To:     Keguang Zhang <keguang.zhang@gmail.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
 <20230729134318.1694467-15-keguang.zhang@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230729134318.1694467-15-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2023 15:43, Keguang Zhang wrote:
> Add the device node of PWM timer clocksource
> for Loongson-1B boards.

Don't split adding new DTS into many small commits. There is little
point in adding broken/incomplete DTS and immediately fix it. Just add
complete one. We do the same for each drivers and DTS is not different here.

It would be entirely different if you followed 'release early, release
often' approach, so release pieces as fast as you have them ready. You
decided to ignore that rule, so no, you don't get 20 commits fixing DTS
you added in first commit of the same patchset.



Best regards,
Krzysztof

