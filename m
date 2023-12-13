Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826ED811DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjLMS6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbjLMS6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:58:40 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E32B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:58:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50c0478f970so7730525e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493925; x=1703098725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9DowOQy/Sxl1JmlMV31xqpgcOa6MjD1E5V4uWjGVTE=;
        b=wL2/tvglytQn4XXQaXnjOfyh7LNUVZusOBiktTp6SLSeVwa09JwgKbw/xGIobEJSuI
         SYF8wmOV7wOiFHCQTwGQxNxNqBdhmPXbUSmD9pKuZYhjOGRiRUrEBwZo8uRpXy4gpQP0
         SPf1xw+sUOqkdnyrSXS6kyPfjJkGRSv1cKV4KHUPyAplDuY9Ua7fX4v0H0lCOaiTyczx
         GcWNmNIaJNyj5I02IJd8s8rcZb7CV8dmjCDIc/rpT80ffz9LvJhFV9UmciSl0Zuc0N6Y
         zUBmD/BxvmQskVBb5f5HLd70erbUc0Cy1kTJqkhaZ4kebLSXH40qLbRr12haEtdlMwIb
         Sy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493925; x=1703098725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9DowOQy/Sxl1JmlMV31xqpgcOa6MjD1E5V4uWjGVTE=;
        b=NqTVK0MS+MfBz5VXmq/LcrwTL25yn6kdl7oreAj8Hs5QsoEinTU0fspj/Jx2Y4PdeO
         sjMoMvAlE+QK0EE/N64s63a9Uxswio3pWPYnvbGWhZ9TPvtFJ1sR+xZcmuI33dGXN8gq
         aMfCLFPWeogjWuU12x7JucPu5z3+LGUN/yI/pd7Ln27Nq4h5RkkcgvEs4VdTvgkL8bKj
         66HVdtIuU0Pk8zY1k5YX6EafQkuSIFY3/Rij1HBaWPeGfR3/he/fSrSKO080mbKcth3q
         pgRjU1hs6IrhI/cjw/Da+O/uwjeFomdzRyJTqs/IYERhVmvZAf9ZRNwUMZhWon/0/Kw5
         OybA==
X-Gm-Message-State: AOJu0YyLTh6id+3qThnm2x6B71NOk3zemFn311VfsQgFdzAVB8AcOCvu
        9zZxoT9bNjKp4KpFaVh5PEYhNQ==
X-Google-Smtp-Source: AGHT+IG9XuroAkQ9UfAcWZUQQ+IDHc4FOLDEE14HErVjpjowcti0RuDxYZzjAuJXvBGAJCWeEMO03Q==
X-Received: by 2002:a05:6512:39cc:b0:50b:ec63:8cf with SMTP id k12-20020a05651239cc00b0050bec6308cfmr5992226lfu.21.1702493924800;
        Wed, 13 Dec 2023 10:58:44 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651206c400b005009c4ba3f0sm1680336lff.72.2023.12.13.10.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:58:44 -0800 (PST)
Message-ID: <fcdf32a5-4efa-481f-9387-df94f08db7b1@linaro.org>
Date:   Wed, 13 Dec 2023 19:58:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sdm845: fix USB SS wakeup
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231213173403.29544-1-johan+linaro@kernel.org>
 <20231213173403.29544-4-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213173403.29544-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 18:34, Johan Hovold wrote:
> The USB SS PHY interrupts need to be provided by the PDC interrupt
> controller in order to be able to wake the system up from low-power
> states.
> 
> Fixes: ca4db2b538a1 ("arm64: dts: qcom: sdm845: Add USB-related nodes")
> Cc: stable@vger.kernel.org	# 4.20
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Matches ds

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
