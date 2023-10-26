Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B277D81BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 13:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344789AbjJZLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 07:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344748AbjJZLV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 07:21:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14ED1AC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:21:56 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507a29c7eefso1075786e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698319315; x=1698924115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fcxp1fuyddcU0jwy8+vZyqysrnGnDmUXtGIc2oOqr9M=;
        b=yWKqhpWX+WKh1X4glVG4c2friFCj8xnu298GjlOFo0Bg0WdCCzP85SQYK5KStm5vj+
         hFoP+eCTSOqZ5It+whhIUtooqbNJXG9jho/DBkGJkCf8QFBnPCLCUp7vIzdIPin+zd4d
         hC69Vog+mOezJ9TBKDagu2hUH+xDy+VeoZhnQ8V8hTHIwVAtzareutK0bz6NZg07upAf
         kZ3jxsYPYwkF1mWqIqnucwgYHR1WDlhMCKnCk5XBwoRipVfE8GOg6m8iHumuaKsQeAkv
         bwp8jVKnkXnELdg17vYdmE31EKZLywv5YNT+qOyLLC+QCc5umveQKF/LEgg++vgNBgKe
         aJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698319315; x=1698924115;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fcxp1fuyddcU0jwy8+vZyqysrnGnDmUXtGIc2oOqr9M=;
        b=h8Y+9OnbDaD5XaU0gBfYJEZ77MkZTbhqhC0HWtyOTfhl/7QeZeOE4JJY75wF4UrRKZ
         ql+UgRqWu9kf2uGUcNzdyKAyIg2WqtxA7fzV1mpWJlY5WU/8nKb2k73AthpSgx91W4ps
         pBtd3YatHFu4420a13wgdOYBj15xUwLYDDb+81aDV0+KG8uh49VLAIKg/pPjgbbp82es
         nwjKgTccVMlb1IRvKIJpLer51h0/kJwVJOcWaFt7RutZ4jCo+ZbaU0BnUTX4RaWnaJ1Y
         YKts1bpY08VXKdUf1h3vusa1DiiAevXrbaNgV7OLXvTOc+FVXFEuJ1um6wqOW/teRmd8
         ENWw==
X-Gm-Message-State: AOJu0YyTTEhblaxVfjK4RSUga9WvwI4hZ84yvzuQqDEkO7i1+ZYL2pj5
        K5DjqxTQ1QrQ9cpSC5tN8qOY+g==
X-Google-Smtp-Source: AGHT+IEQQc1TyKVlCDJtMSwT9AGEoFnojlydVneMuAjPLtcei3bXDo4wQ/oGtl3IHJ7gxq29CBF0JA==
X-Received: by 2002:ac2:4acf:0:b0:4fd:faa5:64ed with SMTP id m15-20020ac24acf000000b004fdfaa564edmr11338887lfp.11.1698319315139;
        Thu, 26 Oct 2023 04:21:55 -0700 (PDT)
Received: from [172.30.204.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q5-20020a056512210500b00507a14e18d4sm2974495lfr.222.2023.10.26.04.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:21:54 -0700 (PDT)
Message-ID: <70ae0765-8ade-40db-98a0-59271c96f751@linaro.org>
Date:   Thu, 26 Oct 2023 13:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 4/4] arm64: dts: qcom: sc8280xp: Add in CAMCC
 for sc8280xp
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231026105345.3376-1-bryan.odonoghue@linaro.org>
 <20231026105345.3376-5-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231026105345.3376-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/23 12:53, Bryan O'Donoghue wrote:
> Add in CAMCC for sc8280xp. The sc8280xp Camera Clock Controller looks
> similar to most of the sdmX, smX and now scX controllers.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
