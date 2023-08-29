Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBB78CA22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjH2REH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237621AbjH2RDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:03:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665FEAD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:03:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so6460533a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693328630; x=1693933430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdTmjmuPAurruPWgK9CBCEBZHBscY3L79kIykl4vQps=;
        b=waubyInGZ/ryHrlP/0kxJ7g8oFoIN9dIfMljCEhusZAyOVUhjKQP5HkJNeKm8inBOA
         qTQoLBYJmTJcaZZAAVWAvZ1Y8IXutZXDSnA2n/CZn4cneOeGURsa7/RC2zsujeTSBE6v
         OLRg+ztB+eMktVMqsJC2XJLIN2MWinYuWbe87Hjz47USRHEpkTf4TEwUn6IhWvPjuNt9
         LXs2NlGPr7eRRnB+aZnfpBi9sksNlnxD3gBtz4QFyCwgfx5JMupSxM1hZm8DqqSvyZG3
         vtFf1cVd9cllJv058Lsi4tvSruM2T2SSW0wIJLtztvqWV//B6O3g6vvxvFSbr+/CJiaH
         xitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693328630; x=1693933430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdTmjmuPAurruPWgK9CBCEBZHBscY3L79kIykl4vQps=;
        b=BbrMG3NWYFOkI5rBx66RCNa9ik3tkg27t86I6t/JUHd7arg9rsDOcNv4LmVaPjS/XY
         kaakIo3cXnilAGHSUAhlOIz1w9XjqSoml+VHuMnAcVlp2q6mfOAGLzNZpCtFH05Jahjc
         42fJdbVeZGABUu/VKKULSSX4IwvxKaNo51VHYvraKZYLzaD8mJNtAiAkgjSUX6r3aUr1
         uyvR6lmX+qApKKRT3htI7KJTJ+YhAuqz6nMticJHhrXMMQNq7wSiG/IFjDKTj0glFddn
         WA558AyYYG2y2nZE1CCxSnra7HMpucr5Uun+RgE+YaVJq2idKxgsWF9DMCDA6EZ+IJu/
         bQvQ==
X-Gm-Message-State: AOJu0YxvnirYIzmHrE/qPdcbGXlTa4Vm9cnB87wdU82Cp8aIvAsUQVpU
        ekrLBsrX4vgfqeBfefNoQONSxw==
X-Google-Smtp-Source: AGHT+IGMNbdGZpiJfoKIbglOYT2jBQpjifa66imX4kAlXfQqNLwz78VbLZWuChdAb5e/Wmk2vArrsQ==
X-Received: by 2002:a05:6402:14d1:b0:524:24dc:c455 with SMTP id f17-20020a05640214d100b0052424dcc455mr18273629edx.42.1693328629888;
        Tue, 29 Aug 2023 10:03:49 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id r14-20020aa7d58e000000b0052a1a623267sm5801084edq.62.2023.08.29.10.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 10:03:49 -0700 (PDT)
Message-ID: <4d2df1ae-cf16-ddaa-ce03-eec520f19ae3@linaro.org>
Date:   Tue, 29 Aug 2023 19:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 7/9] arm64: dts: qcom: ipq5332: Enable USB SS UNIPHY
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, robert.marko@sartura.hr,
        luka.perkov@sartura.hr, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com
References: <20230829135818.2219438-1-quic_ipkumar@quicinc.com>
 <20230829135818.2219438-8-quic_ipkumar@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230829135818.2219438-8-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 15:58, Praveenkumar I wrote:
> Enable USB3 SS UNIPHY and update USB node name.
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
> This patch depends on the below series which adds support for USB2 in
> IPQ5332
> https://lore.kernel.org/all/cover.1692699472.git.quic_varada@quicinc.com/
> 
>  arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> index 53696f4b46fc..c450153cfaac 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-rdp468.dts
> @@ -95,10 +95,15 @@ &usbphy0 {
>  	status = "okay";
>  };
>  
> +&ssuniphy0 {
> +	vdd-supply = <&regulator_fixed_5p0>;
> +	status = "okay";
> +};
> +
>  &usb {
>  	status = "okay";
>  };
>  
> -&usb2_0_dwc {
> +&usb3_0_dwc {

This means previous patch was not even built. Sorry, that's bad. Please
test your commits before sending.

Best regards,
Krzysztof

