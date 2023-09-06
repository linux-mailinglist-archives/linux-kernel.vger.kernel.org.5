Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250657938B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237603AbjIFJpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234398AbjIFJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:44:54 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E02A19AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:44:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc187e0b5so54731151fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693993461; x=1694598261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkFF3q8l/RIWV+E307WjrsB3HqXsRQ9TXHq/kDdIu70=;
        b=cRHI9nLxS5xU35oagF5xNWBXuPsKgRXTTkAYJwmX6Bkoi3FGeKVFUMnDitQ11aJq53
         wcs+vptVuEc0MRuEtVSvsPFsNn9MBN4LKg7sSFWJrIo88oJZQxhH0UaKdm3hwZw1HJGW
         vrIkwSg+IcXEjkBhQyWWchzLjkj7wJhNFf8uCuhs4Tx5H117FQjTUdWTnyUTppxI+Yve
         0Qa2ABeA3UAD97JnmUqgjJtpnxmsaNWSdF4ji0PJdvmN0jBj9B80neNcYoGXfg0YiKBu
         YzgtXYpGe/wGXXi4+gEJprQR2KScPx2Agj/QqURDflXJi4Q41tt5z1cB2UEP4zuon9Le
         nqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993461; x=1694598261;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkFF3q8l/RIWV+E307WjrsB3HqXsRQ9TXHq/kDdIu70=;
        b=AD9KRZ6Ws1e7yvVWfLZPytIqGGSpYvdxFKEGaNTfQiUk2jYl6x0n/7kZ2b0sPmSjxM
         u+RWYk0TUR7PtdhoI3uPYAFQAqIpZLDFKdmYe7toQBlAE4L7YcsOjvC/O6UGaftGE5Er
         HjniF//JwdlSMGlRzTZUDQeNnvEngdDNOuiZg2zY5koaYg/CSCZYmQQzqoPepMmXJLOo
         EPqx7EMPSJFD+SHvIUx5EfnxRdi5tsroAWReQWek5wTP25WZaXZW4v+tpOy0rFm4a4fn
         Jmne5XVY5fXHkMmTTojACGCdbkZ30ZqmXdo7LC1CrQ7BndiEN0jZFz97CYXJnQACiaF0
         i3OQ==
X-Gm-Message-State: AOJu0Ywu4PX/4jPfQ7O+UkR6odpJwPnXsrk1iHyyAVi4ghYORFb04jRl
        bU/+9ZP+zsoNS0H1AZqXT5VdQA==
X-Google-Smtp-Source: AGHT+IH+hF1HSuzJAKUB6mpU10BkClgVY9cY4uMQYvqLn415joS9r1gMsn9P8rQSS+UXG6tUotZtIw==
X-Received: by 2002:a2e:7c03:0:b0:2bc:d38e:65ab with SMTP id x3-20020a2e7c03000000b002bcd38e65abmr1723534ljc.37.1693993461142;
        Wed, 06 Sep 2023 02:44:21 -0700 (PDT)
Received: from [192.168.37.154] (178235177204.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.204])
        by smtp.gmail.com with ESMTPSA id xo9-20020a170907bb8900b0099cbe71f3b5sm8674419ejc.0.2023.09.06.02.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 02:44:20 -0700 (PDT)
Message-ID: <d083bee8-589e-4295-bf05-86862e8e322e@linaro.org>
Date:   Wed, 6 Sep 2023 11:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] arm64: dts: qcom: msm8998-sagit: correct UFS pad
 supply
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230905161920.252013-1-krzysztof.kozlowski@linaro.org>
 <20230905161920.252013-12-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230905161920.252013-12-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.09.2023 18:19, Krzysztof Kozlowski wrote:
> The Qualcomm UFS phy switched from dedicated driver to QMP phy driver.
> Eventually the old driver was removed in commit 02dca8c981b5 ("phy:
> qcom: remove ufs qmp phy driver").  The original driver and its binding
> used vddp-ref-clk regulator supply, but the new one did not and left the
> supply unused.
> 
> The Qualcomm UFS phy bindings were also migrated to newer ones and
> dropped support for vddp-ref-clk regulator in commit dc5cb63592bd
> ("dt-bindings: phy: migrate QMP UFS PHY bindings to
> qcom,sc8280xp-qmp-ufs-phy.yaml").
> 
> It turns out that this regulator, although with inaccurate name
> vddp-ref-clk, is actually needed to provide supply for VDD_PX10 (or
> similar, depending on the SoC) used by UFS controller.
> 
> Bring back handling of this supply by using more appropriate regulator -
> UFS controller host supply.  This also fixes dtbs_check warning:
> 
>   msm8998-xiaomi-sagit.dtb: phy@1da7000: 'vddp-ref-clk-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

