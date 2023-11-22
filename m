Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D197F516C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjKVUVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjKVUVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:21:05 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94533199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:21:01 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507e85ebf50so151612e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700684460; x=1701289260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ga6DHD8tx1x1pLsmxg1KBcXT7AH9Qf7vXNZRtF9xmNs=;
        b=k+h9GJUDo8wLC+t4ob8PzV8k5NasaEANs6rdKao8S1staFBWuKbjBlNwx5p+Mxqr2e
         +auwayeVXsIVe6Kwmu3jC4J9GC80L8pBUxN5b/XmrWvmjfUsRRVFerm/Y9J1jTaOawl2
         K/zLS2SUbYPc6xSvPPzYQAygCJKkEdf7q58UB3GNhzU/6ata3m8BtugKTn4tgsqilasI
         8NgeETL5LSIbzvKMoHZt9YaOLTTvG44bGZjS1qXwV8aeQ70Xdi4KaapLtPC+x6E5h47W
         53JJcyGMfWjocDieA0u+BG2CTJvnHAD4/6LEAkdPI/gQKo7Tg3CxTO8T8z8eMaXN3LUH
         xn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684460; x=1701289260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ga6DHD8tx1x1pLsmxg1KBcXT7AH9Qf7vXNZRtF9xmNs=;
        b=IAx7Kbl5pg3fRmdWg5F/bmxfVTzJgfE5liexianjVlcYxdiBRinqWCzpRQOCaXPyV7
         a8D6iFUxAwo6ElI5aPN6EXdm8nGsPdq0sfBk9Zbq18DeOWYvhX1Z0eBgGPi8LBlD0knc
         unC9yE9VsTsthmImMlk58QsMkY3VQWDDd4ef99pPneNjpHkzTZHWjIi+/LHbsT+6Fthp
         aZW7yhH2FJwQabEK//+tGzbYSzRoD1uootrKEcWRv+56vj1mOICEWZ/zbElxGokEwu/c
         UDXQtU/wgqj6puHGled3gIEGS7v+892qM0ivtCA2ye8kZlW92b+9jRjJZaxLpuNA/YCd
         oH/Q==
X-Gm-Message-State: AOJu0Yzs3T1kvOSJh8hUHLN2YtZrcZzp9hSqxCQ8upZEuQRgTThV6JgW
        Iu2El2XwTnylP7G46ueH7L2KEg==
X-Google-Smtp-Source: AGHT+IEc9mJl9mTCVwaSAeiMnvagrqFfsVeSKHne7giqPH5q83K+s9vNjJPuseV4FAYZtneshFP7Mw==
X-Received: by 2002:a05:6512:1256:b0:507:96c7:eb1a with SMTP id fb22-20020a056512125600b0050796c7eb1amr3411303lfb.54.1700684459628;
        Wed, 22 Nov 2023 12:20:59 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d24-20020a056512369800b005091314185asm1952576lfs.285.2023.11.22.12.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:20:59 -0800 (PST)
Message-ID: <1f643ec4-2f55-4fe3-8d66-a47241c25619@linaro.org>
Date:   Wed, 22 Nov 2023 21:20:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] clk: qcom: add NSS clock Controller driver for
 Qualcomm IPQ5332
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-ipq5332-nsscc-v2-7-a7ff61beab72@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
> Add Networking Sub System Clock Controller(NSSCC) driver for Qualcomm
> IPQ5332 based devices.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
LGTM except a single nit

> +MODULE_DESCRIPTION("QTI NSS_CC MIAMI Driver");

Konrad
