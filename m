Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC77D6619
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJYJCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJYJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:02:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9371FB9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:02:06 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507adc3381cso7945189e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698224525; x=1698829325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UEyMueufZwMl5WUtKOF3x8IWGEweeFOo/V9l1nZBv7Y=;
        b=I2fnd5WdmgYSeQnZgk9z0tn44dyQcJPnQ8tGlYVoyerehj8vpIynEMdXj4LGOGg7Ll
         nPRu6y3bUlnKSlE+4/afG2SI2EcUT7IsWVpJ1eSgPZBqxkOJ4jJkTBaYFEVrJh6x0X6I
         AhfOhfHsexOxQ/Z+NmF0lC27vhhKyx5C8lGz8lJOby/aIkDByHqTG3RMf3BgQ4ckbgzE
         j4ecdw4Ag+FTItsh+eEkgEKtLCFe7snIV2bn99t4IhwRqlghCZp93yFWUZVuFs8NgXVf
         bgeIH1ZH/DEVrNasjg4YMWCpkrgBtGxV+O7RZMkrhzzTih5XPC57iKeZBsh2xbh4qTPH
         nbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224525; x=1698829325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEyMueufZwMl5WUtKOF3x8IWGEweeFOo/V9l1nZBv7Y=;
        b=wz59gBJ7BzhZIG4PtHaZHB1SP5uVZzs/BcGx7dj+EXCpBZiLKN7eIThgR1eRcdRA3G
         XR4wO70PWCRD1eG9j/5Cz1dUoxvrp9okENfA0EH2/3kzA8MNhDLKC3ElqbPI5e4gcBPW
         puVViBtEOikkVKtDBZamcNbRYXh6WVR0OHgnb1hAlFF1iNBKLc5IB52P59PLqFCYVdy5
         hnbdH2MujmQvjFJftZv/OorQTUysyOzbPlCsSVHt4f41AzZnyO2IJ2jBZEaPUfFsfsCK
         og+OAJ0RTlTXGTtJS/PQB47DKDT97WcU2xQYg8MJVNBNeLQ56nBaeEH79LsrO0JhensJ
         qcdw==
X-Gm-Message-State: AOJu0YwoV6zZ1G7/H55+s27kuEHYq8X3GXJi+N8hvlaWtACW441PN8Lq
        nLzXGF1SZkTUy9sD2iXIrKTHaA==
X-Google-Smtp-Source: AGHT+IFwLuCJViMWpxRb/Yk5R0yRSQLNcUdTYLytsZrUrOCyYdDwK9RyldAH5WauocLedqtCc/8dnw==
X-Received: by 2002:ac2:5229:0:b0:507:a40e:d8bf with SMTP id i9-20020ac25229000000b00507a40ed8bfmr9522620lfl.7.1698224524731;
        Wed, 25 Oct 2023 02:02:04 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b005079ab8ab19sm2458305lfo.150.2023.10.25.02.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:02:03 -0700 (PDT)
Message-ID: <d1c66914-3b41-4ea6-860a-dbc91308983d@linaro.org>
Date:   Wed, 25 Oct 2023 11:02:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/8] arm64: dts: qcom: pm8550ve: make PMK8550VE SID
 configurable
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
 <20231025-topic-sm8650-upstream-dt-v1-3-a821712af62f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-3-a821712af62f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:47, Neil Armstrong wrote:
> The pm8550ve can be found with a different SID on SM8650 platforms,
> make it configurable.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
