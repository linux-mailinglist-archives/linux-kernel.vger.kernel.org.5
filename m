Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6379B179
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359412AbjIKWQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbjIKLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:48:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CEDCEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:48:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4013454fa93so49478715e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694432892; x=1695037692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwBXtpnl2seZq0ac+rqFxMXSK7kQ64QRu+m5l1ngFCY=;
        b=EFf0STkEsDoJwPKCqc/cQ/SQg8V6LMgWV3Ki0LiEJ8Ln0wUvrDGxN7YreWBoSyW/Uq
         GDFW6VlHZ5sGG3j1sFfPxfn3prpzSKGKeJnncnQmjYdqKPONR9VNlU6ILQBSW9DS4FtE
         E1Di5hp41KCbTN09mv0QYXITxcfcjFa6E2VLocCoJNW5TWWqtxNKEpDLP92TYxzRTYm2
         1M6xBijSnyYMamFDG+qIJ/qRvhrU1y0Tt6o40arviRiGN+hMdBpmqP8oZBicxgYqMB7y
         HPemNoCwoqlrpr8v0W/X5VHnJDUkQJvD9cK6GU9lctBpXAUyAiS30kriVDEpE+4VW90I
         YL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694432892; x=1695037692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwBXtpnl2seZq0ac+rqFxMXSK7kQ64QRu+m5l1ngFCY=;
        b=mMUtKFTmgBQvVpEoav5pagxJqEFeFTc4MAlblKgDfABsahKKjM9VUduSQOstTmT077
         BE7J8yx4DuqibLtqCGvqxG6oQIXbshDy0D7bXQu4avyk5Yr+4x03+yMgg0niErqeHVWF
         u1wGpwpPMZcblwTdHYM05HvbvmLU2Xtp/ImEMshQFJtttZgxrQIJo4ng+HZPJVzu56tT
         WFyPpwYDnuabqAZ3ds6DAb8JrZ5l5EX09KX8KMyyBVImp0eAhMdcnsnPLk5Wiw/1dIK3
         +IS5j+gQlbg1mVNC4K1OyA2Dh0YSDo7RemAYFT9EZF4QSgMavyUEY8RzJoSDlPUDPeXn
         PFwA==
X-Gm-Message-State: AOJu0Ywu1TfTd5OoQv/lmtuwcPrTrhqPAJXr/ON+LMaCMNRv8qE/nb9T
        Wm1UalST7McFuFGzAh/svrRH9A==
X-Google-Smtp-Source: AGHT+IHAvDDw/3BcjPvocX1g7Jb/JITzMNDYISyuqfgRWtXN/Nv9cKpEy9yu4vLAQ1MX2vjcc8eFCQ==
X-Received: by 2002:a7b:ce06:0:b0:3fc:114:c015 with SMTP id m6-20020a7bce06000000b003fc0114c015mr7852858wmc.39.1694432892513;
        Mon, 11 Sep 2023 04:48:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id q15-20020adfcd8f000000b0031753073abcsm9816108wrj.36.2023.09.11.04.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:48:11 -0700 (PDT)
Message-ID: <0940204f-b7b8-01f7-30c4-0589fae5ce24@linaro.org>
Date:   Mon, 11 Sep 2023 13:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm SM4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org
Cc:     arnd@arndb.de, geert+renesas@glider.be, nfraprado@collabora.com,
        rafal@milecki.pl, peng.fan@nxp.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com
References: <20230908064427.26999-1-quic_tengfan@quicinc.com>
 <20230908064427.26999-2-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230908064427.26999-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2023 08:44, Tengfei Fan wrote:
> The Qualcomm SM4450 SoC has several bus fabrics that could be controlled
> and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof

