Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC63F7976FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbjIGQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjIGQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:17:31 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE53584
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:56:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so19433321fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102124; x=1694706924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpHIUYmzApKmGGiHZZpnMSxi31KSn/xZKBPfgME94EA=;
        b=DqymKHAEv9IZOuCrbcaO5LZ4elHJIgrHqbzN9Q1y1ibxxJMnZOuW1ymNVtQO49pCYM
         i/Sam3SpXeyqfzF9QKboGp1Ct4eWhbtHP4efhlrKN3DoIJ7f2ZWLpXS+aGzRRCNxD3tq
         10xexlEgbiYIm344ck/iSGvW94DL2m4JBc3nUDTrKI+FMD45ybf+rdpVXHIxcrjNqTsf
         PuVNeX+TX8jNJLWeClgtKjsashGx4isCmTY6zyXAOKMKpDhNLkO3cHGuL+sMWa2HTu4p
         B4rKC53IMqwrIqmFfAh7/a9SvVM9nz81GIXAa5/+YPJbesakju2FV3MpZwtf+CfWqVDE
         y9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102124; x=1694706924;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpHIUYmzApKmGGiHZZpnMSxi31KSn/xZKBPfgME94EA=;
        b=eUzck87C0Z20RkGrHJuBgfGfK6rPoyTFzCpyjb3nb0SVMtiHawSvaR7iMCHA0si/iP
         MQEQmNhxxmKzXFSleOKYsUA2nt8eJjvfh2QiCUbIs1Kmixjbwh4rYuJ58z6tu6OeW8Bl
         /p3K+9VdpOm8R7muYFVsW0qT+j8XuS/4I0ZrBuerd1tFRveQ/Cj05KkvU+gM6oEIOFLW
         1BEnWMCP8s+VB/5vHPwo3tkFBUvTUTO5X37fyio0Ac2g0T9cwveFHVKRX6XVoVCLGByy
         XZ30iTCC1ksul9I/IHpROK0Mtp3gX3dODfWpmTRntMLUmuNLYC++CwwH/1nQhHAqaEMp
         qQzg==
X-Gm-Message-State: AOJu0YyePTsZeHhzW7fGHroAaJqpny7/qFgooHv8DcpzuO5jHJOANA2c
        td1I5HpB9QJ1Ioda3PfZb4Uk5yXaCFpNinn+hfcLQQ==
X-Google-Smtp-Source: AGHT+IE6rP7AS4FnGxp/huXUuWImGW5DpdIfQDtTj/sIRkZFOXfhElTxhQiu10RgpaNZRjIoSI51Qg==
X-Received: by 2002:a17:906:5c:b0:9a5:db06:4264 with SMTP id 28-20020a170906005c00b009a5db064264mr3607933ejg.72.1694066638936;
        Wed, 06 Sep 2023 23:03:58 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b009a5f7fb51d5sm9928020ejw.21.2023.09.06.23.03.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:03:58 -0700 (PDT)
Message-ID: <4f882fa1-8174-2816-71c4-a2941372aa19@linaro.org>
Date:   Thu, 7 Sep 2023 08:03:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 10/10] arm64: dts: qcom: ipq9574: populate the opp
 table based on the eFuse
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <1512a94f8fe1f8fe22cef2bf8498a6ac27989633.1693996662.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1512a94f8fe1f8fe22cef2bf8498a6ac27989633.1693996662.git.quic_varada@quicinc.com>
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

On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> IPQ95xx SoCs have different OPPs available for the CPU based on
> SoC variant. This can be determined from an eFuse register
> present in the silicon.
> 
> Add support to read the eFuse and populate the OPPs based on it.
> 

...

>  	};
> @@ -223,6 +254,11 @@
>  			reg = <0x000a4000 0x5a1>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> +
> +			cpu_speed_bin: cpu_speed_bin@15 {

No underscores in node names

Best regards,
Krzysztof

