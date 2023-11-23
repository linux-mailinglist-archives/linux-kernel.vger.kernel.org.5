Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC817F5E27
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345113AbjKWLrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345070AbjKWLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:47:52 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BEA110
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:47:57 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso9206131fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700740076; x=1701344876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5z/6kzj0xpjEwyEn6jAgsUGnC17kgWeKFKQoCRWLJSg=;
        b=zSztR4DAbD6suhJ8VKTu/ajau66KyMuNQxprHZ/GBO5mKFJWe/gOafIGYVJinqD88v
         o155l4/en3BTQH1zVJykcyfmEZhyrsn+okD9hm7HQI4DOy+ciQtJ25mrtJAgtOUSgkG/
         7ZemhYW2/qHBsaY4yfgwbr7wgYorBtpUXk9UExWrEhEDhdwL7OxusJZ8A/qifGNnlICy
         EqtsxcGKyIcQMr8RihbKEBcbvi9i5gOyDbjc0e6T3uRyPuQcjtKpMW3jpSza54GtxdZ5
         +bkibdwIx0Bfgfei5/1Yc24zlSZ8aBBntPZYBHa4eZxk/igZdix3ru9Qlb7P5Jk/GZA4
         83+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700740076; x=1701344876;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z/6kzj0xpjEwyEn6jAgsUGnC17kgWeKFKQoCRWLJSg=;
        b=IBI/fYcBoiOGFq6xPNU/EYm6LHTfnWtArgNyfwpNqUsjoQdAdTdhNgslW5j0261NE1
         GLZZq9SyG/xDDg3iihZ1UFMrhpUbtbko3txsIjNQUt70HeZ+fmYNyVe8m4CpVdfnLs0W
         iYXvkUMQFym9LmmcPeG1wSQbb8sCCtFLUQslqs1mnYCH65NqKKwguCiI3vW/eC2gEquD
         izf3sKWMk+NT5MgZOjQpNh/Eex99dRCIre/O7L+/viyP4ouzPjVV1+zu/vGpXTeH/f0g
         HyCeUZe8xSz4wSYlw/zYCajor5wvLKFyCWqQ3D1Dz6ysNr+y7AymUHSDRu+KgOqJ8RIP
         jYNw==
X-Gm-Message-State: AOJu0YzG7UjRHOUOOgQcvUHWmIKLZ+qYbavs3KbmUALRIuoss6l72/Kk
        UoBMUrw+X13c7i9ej/piFVTZRw==
X-Google-Smtp-Source: AGHT+IFm0EJlV2LouBQ+mZHobXuZe5nby4UbO3zTHDKq7i7Jq7eN0/XJb4O6uXm73wxuqU8z1o/SMA==
X-Received: by 2002:a05:651c:1426:b0:2c5:2133:a9fc with SMTP id u38-20020a05651c142600b002c52133a9fcmr3186298lje.40.1700740075960;
        Thu, 23 Nov 2023 03:47:55 -0800 (PST)
Received: from [172.30.204.221] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c12-20020a2e9d8c000000b002c505793a23sm164296ljj.109.2023.11.23.03.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 03:47:55 -0800 (PST)
Message-ID: <31e8a8ba-6357-4332-95a5-bce8c2991203@linaro.org>
Date:   Thu, 23 Nov 2023 12:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 2/4] clk: qcom: branch: Add mem ops support for branch2
 clocks
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231123064735.2979802-1-quic_imrashai@quicinc.com>
 <20231123064735.2979802-3-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231123064735.2979802-3-quic_imrashai@quicinc.com>
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



On 11/23/23 07:47, Imran Shaik wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add the support for mem ops implementation to handle the sequence of
> enable/disable of the memories in ethernet PHY, prior to enable/disable
> of the respective clocks, which helps retain the respecive block's
> register contents.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
