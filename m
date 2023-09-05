Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0609C792C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353527AbjIERGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353659AbjIEHGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:06:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28238CCB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:06:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a6190af24aso323648066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693897558; x=1694502358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r0egsSQOhp01lsRajXoaqFkfpOpTdrOcW/3FTogkqJE=;
        b=vAxjiCSBsCkAdoMf8nMnm5zEnL0IhBEhafTZ12PRZ2XGm94Fjb+nwvX6VUrKPW1M2j
         Tq36nrBWyWN9ECjikrTO7MNaJ6KONY+u7vBpH+AlkBWZR8B5gzk//2jPrtW3QqwXXK50
         /ltT5Ndd+eIOsAJjSoBvj7LeztqYe7vzXOMZoJJ9iiTadIjawdGgeQ6BBvbx0shzpLeg
         YRMYfLek5POgprMVoEJGgwrVlZfd3+4Zv17OrgdqNGrRsPdEVhrh/QtKIwP+rgVdp32g
         Ys6axRnnIn/TCB0TXAUSoZMdnfZuHGra8uqbfVVs91yQ0sWck/qcno+Q3vHOXHkxsoMM
         PbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897558; x=1694502358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0egsSQOhp01lsRajXoaqFkfpOpTdrOcW/3FTogkqJE=;
        b=PdcwsJ/2+x/y1SLXAuVl4j0lBUOM85ktCwLVnk+vkymOqF3dzCKS7So3nnCVrYBAyK
         pWjvmMmVMFO5GjTighKYOUEhunF1Gq1rQZaG/Nu4bVypoazf5KfbbfCVtgXH/nT/UYAQ
         PyNZWZAlZmH34RPOorZPLlFpKou5THv365O7uoZgYPqtH35oeJSlRfvLTYkCMOTANz5s
         zpzniWUr/PrikyiEhC+9I9SK+ZqTK+olQiysBs89zzmYkKaBWeUInzA4UsRJi7rWyj5z
         tQmvwF4dIGkn08BuO02Cpz5Z5Su9YuCkMDKvjubZZ1sGV1FVKFuh+CHs1sI9WrYSizE2
         SToQ==
X-Gm-Message-State: AOJu0YxTeWQptpT9mnrBq8KYh1IxHyEeXUB5aNuyvtzlV4WyX86qhSgB
        vMjl1tl2/gQd/mIBOPXGseXnkQ==
X-Google-Smtp-Source: AGHT+IENPgj4JYcgJE/803SIBZBut8q0p3fyKx4XDHoHog4ocY9H4oabYgo7JoL54BlNATQFijL8sw==
X-Received: by 2002:a17:906:cc10:b0:9a1:f928:dddc with SMTP id ml16-20020a170906cc1000b009a1f928dddcmr9203400ejb.41.1693897558303;
        Tue, 05 Sep 2023 00:05:58 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id jj27-20020a170907985b00b009a16975ee5asm7081259ejc.169.2023.09.05.00.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 00:05:57 -0700 (PDT)
Message-ID: <044bcc91-1145-fee6-ff7c-dca16f83a44d@linaro.org>
Date:   Tue, 5 Sep 2023 09:05:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7180: Add ADSP
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
 <20230905-sc7180-adsp-rproc-v1-4-dfea7699da7b@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905-sc7180-adsp-rproc-v1-4-dfea7699da7b@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 07:47, Nikita Travkin wrote:

> +					q6afe: apr-service@4 {
> +						compatible = "qcom,q6afe";
> +						reg = <APR_SVC_AFE>;
> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +
> +						q6afedai: dais {
> +							compatible = "qcom,q6afe-dais";
> +							#address-cells = <1>;
> +							#size-cells = <0>;
> +							#sound-dai-cells = <1>;
> +						};
> +
> +						q6afecc: cc {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

> +							compatible = "qcom,q6afe-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +


Best regards,
Krzysztof

