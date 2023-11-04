Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B817E0F62
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKDMc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:32:24 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B53194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:32:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d8d3b65a67so427769066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101139; x=1699705939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aD8sQ7ZbeF75IJwsidf9wpTlqXnkpYqRPBDPPKQs8Y8=;
        b=wXjyy1+UKXWRQDWF7aiV9wGI2Caqz/ruh4cI/MXIOoMZUk6fUXtMvisoJa64K0z8PV
         Fl56SxD5jBcWLyZPXDOHJkYoRw89MM7AWHd5wf8nOdr+8uDoQTE5H3ZRBxbJBWEvChhr
         jvHLtOCbdikJ1IXKSOGssgqvTF8f46ERCkXIgo7+y1mUHaTxrHzMvqxwZ9bRNvTL7Zmn
         knMwIVrW7aZxYupBmB2JLmTBlDtYzKa3XG666T391lF+/HDsGQ/QoMcHXLYJdEDCE9sh
         v/5xn8gnhqd+zE7M18VhUftq2zt7yblCd8MrQ4quMb/+i8+nPJJAVIS7RyZrIBi9LKVx
         NSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101139; x=1699705939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aD8sQ7ZbeF75IJwsidf9wpTlqXnkpYqRPBDPPKQs8Y8=;
        b=YhBpzEMXe7GqN/u7PNbUMb6LO8rFoMkCWpvXHw8VHpUE8dbyH4P0N2NQv9FH47hnR2
         sdPPYijhniky3mPw+S9PEGjSIWZf8fL3UzA5CfyLFxsRgzhgJu87SDTZsNJbyF1wQ9PW
         UVUv2IDI4okZoo3YyDRqshH0Ozu6As32y77Ll5Kwgo0llyqwKGz99HpATcsOCR7lwW+V
         /xY/78Q06Xr66SybtoO8tF8XBoCrg93oDuNUBtFVNWVElAHDstu2oOe2Y+mdq6V5q8c/
         1BWsTPJking0zhB55O91iJ8w8dz5RWXkLxGCUadtFLrBr27LjMVCISMQm5f69gae7Lft
         9H5g==
X-Gm-Message-State: AOJu0YxnjvFb/sw3uhs7kGc1rqIp/43o3b8F3FCGjFgrjIGiULJ4Pebz
        RsaySXp8HT+80IcEN0DPpBj/XQ==
X-Google-Smtp-Source: AGHT+IGHDBcap9eLMlD+wItasasKcPKHzhMXSkVNaXPMbhCdN1xZlc3moYKwu+Kens8XEBGhsaTeaQ==
X-Received: by 2002:a17:907:9603:b0:9d3:f436:6807 with SMTP id gb3-20020a170907960300b009d3f4366807mr10003624ejc.42.1699101138774;
        Sat, 04 Nov 2023 05:32:18 -0700 (PDT)
Received: from [192.168.0.153] (178235177017.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.17])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906260300b009887f4e0291sm1903972ejc.27.2023.11.04.05.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 05:32:18 -0700 (PDT)
Message-ID: <62860baa-4a0f-4a69-bbe4-94579c28a1cb@linaro.org>
Date:   Sat, 4 Nov 2023 13:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 idp and
 rb3 board
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_nainmeht@quicinc.com
References: <20231103184655.23555-1-quic_kbajaj@quicinc.com>
 <20231103184655.23555-3-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231103184655.23555-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/23 19:46, Komal Bajaj wrote:
> Add qcm6490 devicetree file for QCM6490 IDP and QCM6490 RB3
> platform. QCM6490 is derived from SC7280 meant for various
> form factor including IoT.
> 
> Supported features are, as of now:
> * Debug UART
> * eMMC (only in IDP)
> * USB
> 
> Co-developed-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Naina Mehta <quic_nainmeht@quicinc.com>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
[...]

> +
> +&sdhc_1 {
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +
> +	vmmc-supply = <&vreg_l7b_2p952>;
> +	vqmmc-supply = <&vreg_l19b_1p8>;
I think you also need to add regulator-allow-set-mode and something
something regulator allowed modes to VQMMC

[...]

> +	model = "Qualcomm Technologies, Inc. QCM6490 RB3";
Is the name just "QCM6490 RB3"? One already exists, based on SDM845.

Otherwise, this looks very good to me now, thanks.

With these nits addressed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
