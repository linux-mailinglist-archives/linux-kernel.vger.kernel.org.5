Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE27847AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbjHVQdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbjHVQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:33:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A75CDF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:32:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso7177079e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692721976; x=1693326776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rIoS0znE6oN/l/x3K7NnUf3Qklsrk/Ze3DzZn22wcY=;
        b=HVVWAHjkZvxxFdpMClmqn8mJ73t0auaVoyFggAo5M5OGtyOocB8aTG6IK2xdb+4mkH
         U9+yMWZJ2Mlc3nuIK83FDCWxFh2j249BtG6Dk4UdKSPrBi1o9/s/5Tt7GerCxc6+QnyD
         nhozKGGnAfV2Y2NxYn7vWvDxVvC226qYPV++yH3KGXnOeqa5AOOruud2VELfVF9OoHOK
         FAZ2BN/yPwUzeEIHSXbqPYwHS1vRwb+kBOQYg8dgxIwCZ0My7DWrnAjf0yMJdrt9EfJP
         HOc4fXv6nD3HBAyT73nrvQpQI6vKx05qUsaJyrfUE0AyycdzA+qgeY6m+UyCF4fnSkuc
         6OIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692721976; x=1693326776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rIoS0znE6oN/l/x3K7NnUf3Qklsrk/Ze3DzZn22wcY=;
        b=NeJfQ3OAr0C5nVU4UmwyZGT3vtacS9XNC9bm/7hPpQagWchTES+0KoO7QQv2SiNgo1
         X3eA9N1GjbZ0QiFqdpza0vHzVj71q/DQSMsMUxmDBnKW03eEdukxo8rC7V3qrwX7dwzp
         Ms9a8WXO5vUT61M9Ko6Km62VO7iSrRRH7xm6yRzoEV2sjjP7BEuq2fB8tBAoOiR3HeTg
         gybnDeV6GMb+NnsPLruGomrpVRGCVlaiXMS5LcFxaktZQluVPdfn7G7CpUD0xYBSis3U
         YjP9texdwKgac3hU8FmDd9IjixbNf9qRWJLGMoPTFSr9Nh0JA6noZXJs7UWOJYjTX1fS
         A02A==
X-Gm-Message-State: AOJu0Yz3tBUEFO8oiUvWp6T9P7yjSOIcOdSP5MX7XDdKIMclbTQMqWED
        umLniCeEskCeKWP4P9kxwW8iyA==
X-Google-Smtp-Source: AGHT+IGJBRiipWOU1uAjMDjYvT2rmEnNSJaWly8u7+15oUvz1XPHQzEY5hzGm1+H4GbQkRyn42i/Rw==
X-Received: by 2002:a05:6512:4007:b0:4f8:5e49:c613 with SMTP id br7-20020a056512400700b004f85e49c613mr8650861lfb.43.1692721976079;
        Tue, 22 Aug 2023 09:32:56 -0700 (PDT)
Received: from [192.168.1.101] (abyk189.neoplus.adsl.tpnet.pl. [83.9.30.189])
        by smtp.gmail.com with ESMTPSA id f14-20020ac2532e000000b004fe4ba4cdc3sm2259782lfh.89.2023.08.22.09.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 09:32:55 -0700 (PDT)
Message-ID: <5c917927-92ed-4139-a69f-95761ec63c83@linaro.org>
Date:   Tue, 22 Aug 2023 18:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/9] media: qcom: camss: Fix set CSI2_RX_CFG1_VC_MODE
 when VC is greater than 3
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230822161620.1915110-1-bryan.odonoghue@linaro.org>
 <20230822161620.1915110-9-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230822161620.1915110-9-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.08.2023 18:16, Bryan O'Donoghue wrote:
> VC_MODE = 0 implies a two bit VC address.
> VC_MODE = 1 is required for VCs with a larger address than two bits.
> 
> Fixes: eebe6d00e9bf ("media: camss: Add support for CSID hardware version Titan 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/media/platform/qcom/camss/camss-csid-gen2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen2.c b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> index 45c7986d4a8d0..140c584bfb8b1 100644
> --- a/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> +++ b/drivers/media/platform/qcom/camss/camss-csid-gen2.c
> @@ -449,6 +449,8 @@ static void __csid_configure_stream(struct csid_device *csid, u8 enable, u8 vc)
>  	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG0);
>  
>  	val = 1 << CSI2_RX_CFG1_PACKET_ECC_CORRECTION_EN;
> +	if (vc > 3)
I hope you don't pull your hair out, but I think GENMASK(1,0) could be
in order here with a comment about the bitlength requirements

Konrad
> +		val |= 1 << CSI2_RX_CFG1_VC_MODE;
>  	val |= 1 << CSI2_RX_CFG1_MISR_EN;
>  	writel_relaxed(val, csid->base + CSID_CSI2_RX_CFG1);
>  
