Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2FC7A9B17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjIUSxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjIUSxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:53:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638EF90A60
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50306b2920dso1501753e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695318420; x=1695923220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9L+Ayd4AVCY39J9Hxvd6MFEArOTVMascukL1YJniY/w=;
        b=of1sp3YRm1q3WvbsgMNMeyNdRKRhbJzk0fdYK27meP8H+/AXA5X9fIQmvVoEt9KlZq
         bHwxuqyOhAKFy/9s9dZKSdfNlqstpH3Dow8315rJ/Gdbuq8JZWCyxjqyPDBppSj4Qt24
         3M7aEvTdx09LiC/z4VvvjWkSPgkOpeqD3s54oJO5XpQ47dw1zJOWqY1LRLVt9MWNbXu/
         +fyMOhHqy/4od/0ysRIbAT3IBTZds92FZjnW8c0OqhLapzoXGGLIziPgqZoF8Xs3tJle
         qrgr+1/UbudwToG7oVi/vfPa+Pq/W2Ckh2uMH7oCdnLz9dojFiXp7hdSZAQI924T7vJY
         1S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695318420; x=1695923220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9L+Ayd4AVCY39J9Hxvd6MFEArOTVMascukL1YJniY/w=;
        b=tb5Xkcny5PcaBL157CAH7P5Ecz8WGRUWy9RV+52mCaWngUAfGr2Z2GiNpKvV6mI0Ri
         1RByf6831p83aoC3hotvKtPrhTmgYakK2qRp6FspbBhfEISnZRB3rUllPwg50TvOGyk7
         jwLxUE8YQBsvW4Y8gr2xHRu8OZ82yDVLl8d+QVbE2EbkfoSGAfyoHPOQzFt1tjT5Oxdg
         SWJXtxrwl+SWmb6x9pEgkDHjrMjiSkJd557hnvTv7XPsqSc2BK93DxDXvzc0VO1mF4U5
         JsoR0IM865K+JSW+Zv3DGJ0FT9fzzNf5YquAUG8+B5rUsIDYbN/pDPpaOe9QvlDOQY8T
         1Eag==
X-Gm-Message-State: AOJu0Yz5uvRvbH7WxbSaOEYBv2CfSc2rMHwkhfFHAFT2HxHHEU1PlNw8
        q8v3LTC2QsKBbpCo1qfIHOJ0/1XuryWeqoYG3AgXjQ==
X-Google-Smtp-Source: AGHT+IH1+DWkTnhgn92dCu/7v9TiDYaPSRko+SKIGaQTddVCw3CZc5wy/uOcCNoqIUvWqVc+G4l53g==
X-Received: by 2002:a17:907:3e15:b0:9ad:e3fd:d46c with SMTP id hp21-20020a1709073e1500b009ade3fdd46cmr11318009ejc.10.1695280184740;
        Thu, 21 Sep 2023 00:09:44 -0700 (PDT)
Received: from [172.20.15.189] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id i13-20020a1709061ccd00b00991faf3810esm594634ejh.146.2023.09.21.00.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 00:09:44 -0700 (PDT)
Message-ID: <01af3370-1d70-aea4-c808-5a96ecb5ee18@linaro.org>
Date:   Thu, 21 Sep 2023 09:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 3/3] soc: qcom: rtmfs: Handle reserved-memory
 allocation issues
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230920-rmtfs-mem-guard-pages-v3-0-305b37219b78@quicinc.com>
 <20230920-rmtfs-mem-guard-pages-v3-3-305b37219b78@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230920-rmtfs-mem-guard-pages-v3-3-305b37219b78@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/23 04:37, Bjorn Andersson wrote:
> In the even that Linux failed to allocate the reserved memory range
> specified in the DeviceTree, the size of the reserved_mem will be 0,
> which results in a oops when memory remapping is attempted.
> 
> Detect this and report that the memory region was not found instead.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
typo in subject: rtmfs

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
