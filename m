Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B667EE3DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjKPPF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345239AbjKPPFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:05:24 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67459D4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:05:20 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-5079f9ec8d9so995239e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700147118; x=1700751918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8ztruwTEzNqGhDwNxN4hXW3N9Yo9g8CNvr+Y4z6O+k=;
        b=wcRQS4J4mXukG+NgrAqu3gF/dCLAXWRVykRjT3a0vq1Sue6ye9VEl0prJmlZJJpdTy
         mHuHhgNXGJ2mtGRgLehALAP/oD4o+IkjSXlGz0GRPK+EiZdfkcRlLEcRU+4d1Exg6zU9
         y+1zvxEaJi6GaLeLCgXmOIV71yldeG37P/6Sc+mWxBycBwYKUrKGB/SiSxDNQ/ukVLVI
         1/yj0I3/FTFLzV4MuWFmSCIZJM0u9lS8QW89LKGhn5mrC416nsqNEUfxdPipgjTnMpB+
         qqESvOV/Y5jdfUyrFCxBYwg7MlfZ5H9NO7lAZ42avXUoGjj+AwWGDwfprM2pphOA9fYP
         jvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700147118; x=1700751918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8ztruwTEzNqGhDwNxN4hXW3N9Yo9g8CNvr+Y4z6O+k=;
        b=LgRPXIc2ntv1xxOCIRw4Ui3RNvz4oHajUoUXr5A97CrHeJbNPC97/9sKVwLa6gwVD7
         zQi364dCYLT50qHRBct5XskQ+IVHsldBOxCP3il9L37fGF8CnKiqSSwOldxbXfZD1P1v
         Y6Yeqhl6c/8TaBXTFrV+W+w37lnqT40oxM5Ee/ZbAvYxLD2RauPxqI73i7FQNcxW4rgz
         Z9tm61wr+++eV7+YrIZghKPSywjb/0pEp5MZi6niQqGuPKfHT+nJ+Y6XWNMluAEd9gwz
         m+0NO3CONmZtmsdm5ampi1OuB8R7ADsyo8HUG8AkQcPuLXKpQ85VDI1mhkMUGPffhWrk
         Nsfw==
X-Gm-Message-State: AOJu0Yx1HiAWebYLtfyp5/22x0kt/1NLR2S/Ap69T7Di2SAI1tvv9pIw
        VihPVU9XzfE2yaArmscvwk5gUw==
X-Google-Smtp-Source: AGHT+IGgtkvKHvRCkcC8IvrfG4Jr4Gtm0TsvyhM0PmD5yiJB/6F8c0YaysiX6wR5ayIUsM/MoVqACg==
X-Received: by 2002:ac2:4117:0:b0:501:b929:48af with SMTP id b23-20020ac24117000000b00501b92948afmr780178lfi.34.1700147118541;
        Thu, 16 Nov 2023 07:05:18 -0800 (PST)
Received: from [172.30.204.128] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b13-20020ac247ed000000b0050a3e7e718dsm19556lfp.189.2023.11.16.07.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 07:05:18 -0800 (PST)
Message-ID: <0f618da5-e742-4c0c-908c-1d37ff90a3ba@linaro.org>
Date:   Thu, 16 Nov 2023 16:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/4] clk: qcom: Add ECPRICC driver support for QDU1000
 and QRU1000
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231106103027.3988871-1-quic_imrashai@quicinc.com>
 <20231106103027.3988871-4-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231106103027.3988871-4-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 11:30, Imran Shaik wrote:
> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
[...]

> +/* 700 MHz configuration */
> +static struct alpha_pll_config ecpri_cc_pll0_config = {
const

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
