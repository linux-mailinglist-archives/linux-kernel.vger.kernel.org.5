Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F42A76E678
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjHCLM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjHCLMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:12:09 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF698122
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 04:12:04 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-522bc9556f5so1077340a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 04:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691061123; x=1691665923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0XelJdYR6bFWh5mhR2ZVrgJG5GvsMHFZq9tsYSBv50=;
        b=RAYVrN3/oSONSI5EIj17kn4cvUfL7T2zcsxJtlY48R+Y5o+63RLn4THxDli5FKyCll
         ygeNzzIvrImm661r80k9QLnj4MjILAgI0HE587WmYQu7XmuxqYhb5L2e9A0U8Bv2xwpP
         h8mXXQJqRiD/24TI3k33m/gOM56UALt5l3U1DKpiJhGV9d5V3w44KrqKndfO40ijBhnY
         1Oc3/VcYW0D76OhTnGguVjFxbHI/ettYfKzLAYDkLxBufjob/s2/7pDH+bYhGKQ1cmhX
         4QcfI2S+cBEU951S5NNGRl5odvicaIp1JaTdY2vafTSXi5uTvTvRz04otE5inq6lVHBN
         7XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691061123; x=1691665923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0XelJdYR6bFWh5mhR2ZVrgJG5GvsMHFZq9tsYSBv50=;
        b=YLnXNBWRpDOqnkTTbFm/pmenaprLW4W5h5ij+1X1/ghlR5psfruWuif1dBU7OHwSY/
         SGHD5API2L/LOZ1d/2HegXbx+VMB1775hkkA2M0pS+sHTbYsGWBe+mKiU5D/mlT78sNN
         DMc+t1Mpz6c1uvUx6reyT6p/hqf2s2EXQ59eh43hsfX/yTeL6Wisn0hEfcifB9YmEKdX
         quwhbLFKCKJMtwOCtQ0VZPmcCQn4E+h3LFScjuTtljI4WDvneag4Zgkib5yu7PL6Oc8/
         zXQxCdVhP+HcY54I5na7cKXoG0NTtPc6tgLpHWx2fmtvD6JVzja7NGtQvXCtkQfDtXpL
         Ug5w==
X-Gm-Message-State: ABy/qLby2z+4uNV+hmQfIUIxDLvYXYqvn16uh7G2jah9w4YssLdS9arm
        D8Nsf8GVa0F0WKfuSkK9ygqRvw==
X-Google-Smtp-Source: APBJJlGXauZv2QFpBai3rRvQFxkagKCLuV0/Neg15wZhqipdLYpxshqBMsN9vcvFDCmNYPeO+iJEvw==
X-Received: by 2002:aa7:c0d5:0:b0:522:bff2:dd20 with SMTP id j21-20020aa7c0d5000000b00522bff2dd20mr7473778edp.13.1691061123200;
        Thu, 03 Aug 2023 04:12:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7d3cc000000b00522d88e8c55sm4584793edr.91.2023.08.03.04.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 04:12:02 -0700 (PDT)
Message-ID: <8b47da4b-ec68-40f1-c3eb-939dcfa7550e@linaro.org>
Date:   Thu, 3 Aug 2023 13:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v6 1/2] dt-bindings: input: i2c-hid: Introduce Ilitek
 ili9882t
To:     Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com,
        dianders@google.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, hsinyi@google.com
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230802071947.1683318-1-yangcong5@huaqin.corp-partner.google.com>
 <20230802071947.1683318-2-yangcong5@huaqin.corp-partner.google.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230802071947.1683318-2-yangcong5@huaqin.corp-partner.google.com>
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

On 02/08/2023 09:19, Cong Yang wrote:
> The ili9882t touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that ili9882t needs to use
> vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> and touchscreens to power on/off together, let's add a phandle for this.
> 
> [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromium.org
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../bindings/input/ilitek,ili9882t.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml

It's v6 but this still misses the changelog.

Best regards,
Krzysztof

