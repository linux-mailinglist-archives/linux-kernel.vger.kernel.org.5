Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8DF7828B8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjHUMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjHUMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:14:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA762E2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:14:43 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523b066d7ceso3983571a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692620082; x=1693224882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ4A4PjuTlt+XMBWNzJPDmDOYWrTcGhNygKMgDnc2Q8=;
        b=iz47zDBpw3Ibp9kl1kFtzFepKYW/YZlCZwdM5dghFSdUm/fFZS+Uq7svCIQA2PUGT7
         OD7Wlu5kBJskZM//szi2rDV7LYwaKEc4+vlA6pOg9orqWAOxqpJCHzsr1fYbh97ryA9i
         BoDR0Ekcsujpmojlv7w/5/kob8qL3PlThsz97PyDGN6dfGbpBQQYhUwle2UNBz16JP9e
         3ckTQ47Z5VqVV/y2ODFgVSbFpX8CPLFOueagp9/Urr6uWng6o87r/zZqJHK+iXcwH4H8
         qtkprEhub9+1Q+gQwHjfX4pTSP8kmGGPR288EdV2DWoDI2ppe8t6NMukGFbrrB1s5hYE
         be9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692620082; x=1693224882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ4A4PjuTlt+XMBWNzJPDmDOYWrTcGhNygKMgDnc2Q8=;
        b=Y/zrr3dCzBghtoWfQWG3ErdWlTxBahIpFrtKekFbbJCWFlLdOUDXVVTd4I1hLChj/q
         oWzCTLGNeFrpGsqmgTb2lubu54UjIeWTKTSjBvzfiVMMYe3gvexUZrr/DSFpyB/33ZF6
         q5eO7Lj0ugxLf+uN0yQVXpHx7WVcdLO+pBhYdZ64iCvTTsSnw032kfx9DbYbpeVzIAdZ
         bMLwXyPcTa2Ugh6UUWWXOwSsBlmypnQ9xA2vUnXFFE4X8goBuXrVurxu9wsYYqpYeHFj
         I75wLXk1lCa047k96tsS7CbBPZnoXzvco1k3w/ccythxRKQlqA0TcavEDCKkTKi8IJEH
         uMWg==
X-Gm-Message-State: AOJu0Yz2LDIE1th7YgBFtJoAL8BY/nrq7DtuO7vqU3t9ORzK7NituRCK
        Ej00fpjVf6HF3XpXSwfzpxLQ5g==
X-Google-Smtp-Source: AGHT+IHT1a6k5nRWS7uPl1+UfJiLHZIjEonHC2gVte7HgVai3ix/2YZ3UlymJWu5FXdusZH2IMz46A==
X-Received: by 2002:aa7:d502:0:b0:521:7ab6:b95d with SMTP id y2-20020aa7d502000000b005217ab6b95dmr5303186edq.29.1692620082158;
        Mon, 21 Aug 2023 05:14:42 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7cf8c000000b005256d4d58a6sm5920187edx.18.2023.08.21.05.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 05:14:41 -0700 (PDT)
Message-ID: <c2f616a0-c24e-5061-7e1d-5be68ed3d706@linaro.org>
Date:   Mon, 21 Aug 2023 14:14:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V1 1/2] scsi: ufs: qcom: dt-bindings: Add SC7280
 compatible string
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, mani@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        alim.akhtar@samsung.com, bvanassche@acm.org, robh+dt@kernel.org,
        avri.altman@wdc.com, cros-qcom-dts-watchers@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230821094937.13059-1-quic_nitirawa@quicinc.com>
 <20230821094937.13059-2-quic_nitirawa@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230821094937.13059-2-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 11:49, Nitin Rawat wrote:
> Document the compatible string for the UFS found on SC7280.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

