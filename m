Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376297D664B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJYJK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYJK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:10:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03CEB9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:10:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5210a1515so84002161fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698225023; x=1698829823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9WKxzWYTIPEx72gLwqiuI8euT7QCbNEIlRKEwqUgI6Q=;
        b=gNpGjZ5MxUke0lxvfYdaA/16YsOOn75zYudfkdJL7T5HPcSH9KTRCjtxzJnjJxYeXB
         4zFGc8vvmzsy1fEjdtFaQk5nz2+fs/rveTGyJokBzeP6aqrWBnE9U9z4rSojKd4m5LI1
         aAc7tkExOQaZDoZVQYPtRUEJCwBGsYCz3X9lJHvxIOLkrRux/6urblgh7ordq+0oMcMb
         yDiBo/0wyGerqbqvh6GP2qrVUKM+nc1EN8N7wuVVyZV+p9QsaqY3cRHflFt1kZ9xZQNZ
         j6GIrwUMJ7vLf7LxM+8N9UZowu4oXWa5aOsc0dyNp89lxT0zQqG2E7lsmR9nQpxSE3vc
         m6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225023; x=1698829823;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WKxzWYTIPEx72gLwqiuI8euT7QCbNEIlRKEwqUgI6Q=;
        b=afzRrnDiDZOalat9ZBn+ieT+2FU10hnVtf+3qntUeU8vxCldYlVRAxdQG/AfNnDoV2
         Y3F02pBrwQHk/USoz1RdVlsEQfMm9gMJOezqDbOBM7V1NSxprBdrtL0MNRc0adyOmKAZ
         xlTthA1/zERmUM36KV8LUauSlAEdpSpX2mS4LGJ9V7aDFcgtnBRn5VtFUdXMD1UVlUFW
         ltxgwXIQRVw8Yh3DdD7tloFUdKCDTRMPLHN4vbvhVvQNPDqCUfX+uSEx9xmNylIFOQkV
         jAOOTd4glLHY60wPRvaDSuapJvFioPdm7idP7X0d0e4oKqd3RI672p+OQHEoZ0KpftUn
         gCKQ==
X-Gm-Message-State: AOJu0Yx+IsO6dQ5Z+Zmnfzc8eQ3m/k8l8YB5MQfFs2HOK4uWGES+pyN9
        smdwxCAyeTQEdQugXsca7HqsDA==
X-Google-Smtp-Source: AGHT+IE9+723ygXj7zuVPqEp3ynEibr5Ni7XXz2Au0L291BnhJCM/pjwh0RCN+qumAYXwzEy8ZMRjg==
X-Received: by 2002:a2e:7815:0:b0:2c0:300a:82f1 with SMTP id t21-20020a2e7815000000b002c0300a82f1mr10658057ljc.14.1698225022885;
        Wed, 25 Oct 2023 02:10:22 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d24-20020a2e3318000000b002bce87faca9sm2354356ljc.57.2023.10.25.02.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 02:10:22 -0700 (PDT)
Message-ID: <247f2ec2-c400-4d85-ac6b-2fd058989857@linaro.org>
Date:   Wed, 25 Oct 2023 11:10:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/8] arm64: dts: qcom: sm8650: add interconnect
 dependent device nodes
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-dt-v1-0-a821712af62f@linaro.org>
 <20231025-topic-sm8650-upstream-dt-v1-6-a821712af62f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-dt-v1-6-a821712af62f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:47, Neil Armstrong wrote:
> Add Hardware nodes that depends on an interconnect property to
> be valid.
> 
> The includes:
> - all QUP i2s/spi nodes
> - PCIe
> - UFS
> - SDHCI
> - Display
> - HWMON
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
QCOM_ICC_TAG_ALWAYS would be nice.. (see sa8775p)

[...]

> +			/* Forbid SDR104/SDR50 - broken hw! */
> +			sdhci-caps-mask = <0x3 0>;
Have they *still* not fixed that?

[...]

There's a whole lot to digest here, but I don't see anything
obviously wrong..

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
