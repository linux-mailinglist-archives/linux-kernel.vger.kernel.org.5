Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E578DD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbjH3SuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbjH3Mhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:37:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9517ECCF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:37:28 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500bbe3ef0eso995141e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693399047; x=1694003847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I58sq5xTxwCx/GyljuH0Q6KBHvrDLZQ7PUXbI0PsH2Y=;
        b=m0AqtxQcGi5qN6h8Sj3jcNUWNMiue+wxcwP2SvncfVRcsuPCfGF1DA/LRJ8IIL2BYD
         H0qY4bPC4EH39m+uNbcItKxHjDEG2zBUZnI0eO9J1J4KlwC6zXXAtnhp2RFrn1FsrldP
         yZaA4XWIY4W1QOiW1kyBF0+6EY/dlHBNBGrwGVrf/0kTrBIAY+vfrAkMQ+Rgc3yyvcwH
         Zz+tydSkQuNy6jJH8l/KbdvW6i4wPHcxgJoEo8jk9AxjmjNPYRrGziPRUJw2UCuTPRwL
         GvsJav18ThdEJxON7teKubSDW7f0NO3CjS720EYA+iPFcQnKp1DvDy4qLe0KfEUCrMrv
         e2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693399047; x=1694003847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I58sq5xTxwCx/GyljuH0Q6KBHvrDLZQ7PUXbI0PsH2Y=;
        b=KV9hYUg85T1ibxZsJAJbJxC8/Euc3tTE5emOR5UB/X9+ZrFQqwZ3oKuJ/7bL+vD2QR
         bsyUQrKO45HqrusoV9Igte8Ta47SXYf8n7WNbAOL29mdgRuHlDbRkvlxYtY1H1s/iR2i
         60V2TcgcaPxsp83ruZ04CMvpMRfHPd7GjmL8GtOsXji94WaswMSRSxW1t4Mm8lNOC8Ww
         OHk3kwXarJr7p7Qou6yIUDdn64E1iCUHCiVtpMMaYf6+1z1eRF3WEdUYmnKPYFN4Kkxy
         fuQB45VIyiuv48YAq0Avwk5279ezNXFiglOgCB+gbJjHN9k6zAYSVUQoU3EMlJW5O+sr
         oDvw==
X-Gm-Message-State: AOJu0Yz+a2yNmVGpkKU0cx77xw/RoBzfliob1YzRunzq58mvMvD9sLzV
        qa9Dpl/syyY2E8be6HZvmBoiXA==
X-Google-Smtp-Source: AGHT+IEp+gLK73xWw+QqO6fWJI74gXK+me05R7lOQ0QCXV4Bjz00bLArMSjq6XgfqF7mOJb8+dQrzQ==
X-Received: by 2002:a05:6512:402a:b0:4fb:7624:85a5 with SMTP id br42-20020a056512402a00b004fb762485a5mr872461lfb.0.1693399046844;
        Wed, 30 Aug 2023 05:37:26 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id cf5-20020a056512280500b00500b3157ec8sm1772351lfb.163.2023.08.30.05.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 05:37:26 -0700 (PDT)
Message-ID: <49310ff8-80ea-447d-a63e-a181afade189@linaro.org>
Date:   Wed, 30 Aug 2023 14:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] phy: qcom-m31: Add compatible, phy init sequence
 for IPQ5018
Content-Language: en-US
To:     Nitheesh Sekar <quic_nsekar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_wcheng@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20230830111722.19380-1-quic_nsekar@quicinc.com>
 <20230830111722.19380-3-quic_nsekar@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230830111722.19380-3-quic_nsekar@quicinc.com>
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

On 30.08.2023 13:17, Nitheesh Sekar wrote:
> Add phy init sequence and compatible string for IPQ5018
> chipset.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> ---
> V2:
> 	Updated the commit message.
> ---
>  drivers/phy/qualcomm/phy-qcom-m31.c | 60 +++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
> index ed08072ca032..81b72ebde305 100644
> --- a/drivers/phy/qualcomm/phy-qcom-m31.c
> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
> @@ -82,6 +82,59 @@ struct m31_priv_data {
>  	unsigned int			nregs;
>  };
>  
> +struct m31_phy_regs m31_ipq5018_regs[] = {
static const?

Konrad
