Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685177EC858
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjKOQUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKOQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:20:21 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D86A19E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:20:18 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c6efcef4eeso93053351fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700065216; x=1700670016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YgZKA0DsdEM8wfBvKevVF7NO4a9xgKqf98z7VA8pCt4=;
        b=LFcv9MQUpSFeuwVXbqhBUtqHoUK4djj/xcRY8TJUDxr8hSdZBR/Aob8PnC6pZiFAWA
         z2aim21gSehuSrhpSytji5nsUvsn72Krh69RpXyv/2+Iv1Wc3CS5xJGAQCOcIct/XLOL
         c1Gwecw6qLV2HufkCsirfq+A6AkTPC+x9nRaWqzG/P6cgAxL7WZjzCiRCfanYV4RGAZU
         1bkZq7IPXa2T3JmlnP1oXD96TXydUGpJIZD97PTkHWn2CFUXhfo43875VTpRHbzHkDE8
         Q5wfNHc0pS0LiW0Faew1svroshISM7sfE2Y2IDXeqb7vgECSCWOqhyJqPdEeRttvZukP
         ihIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700065216; x=1700670016;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YgZKA0DsdEM8wfBvKevVF7NO4a9xgKqf98z7VA8pCt4=;
        b=m8dbQrsdUo9ya5vqFtuL+8VDNC4axORcZuZe+EfIcCBy7sFm5sNPtOiF445jxuKOFO
         X4Pu4lV4Wp4yfgoTln5XvaKm+WRGfD/vJcUpoJtg68SeU+cd4Didp1RpRDOofsMapHH8
         RhD4lsSLXHsYUP93sDpqZO7Aw/cO5zDpIzwZ7HWFEUfwHT1BkbyWnXRNxU/rWLx6EE22
         49zuj9atZKMXqqUUHllm47iOdqFTTQdPB/Xax8Kyn3HxMNaUqt17e7t2ntrJvmkphlZy
         HiOMGSsHj9JjDVFHJrzUhLKvjNQhFrkm9ZWYqUfYwdTuoptjF0F0nS3xAzww3plqGdpa
         A2Ew==
X-Gm-Message-State: AOJu0YwoIP+/7S91US1M3h0OnS5gRsWmiqxv1+VxKCxUBmeAh/7EAjlN
        6zf9ym/ApiBWdpjYvJRynftXxAcOFpB4Qr1Rv1CjZg==
X-Google-Smtp-Source: AGHT+IHk3uMUNlHK4NV9UcrNsdAssZ6J6dzByPvwjC/T3+TqTzTc7Q32W1dsQXYmHXcCyhCreLbElA==
X-Received: by 2002:a05:651c:10a5:b0:2bb:a28b:58e1 with SMTP id k5-20020a05651c10a500b002bba28b58e1mr4164080ljn.41.1700065216616;
        Wed, 15 Nov 2023 08:20:16 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id k8-20020a05651c0a0800b002bce77e4ddfsm1699622ljq.97.2023.11.15.08.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:20:15 -0800 (PST)
Message-ID: <c1e604cf-4388-458a-835d-0674056aec5f@linaro.org>
Date:   Wed, 15 Nov 2023 17:20:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: correct Soundwire node name
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231111095617.16496-1-krzysztof.kozlowski@linaro.org>
 <20231111095617.16496-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231111095617.16496-2-krzysztof.kozlowski@linaro.org>
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



On 11/11/23 10:56, Krzysztof Kozlowski wrote:
> Soundwire Devicetree bindings expect the Soundwire controller device
> node to be named just "soundwire":
> 
>    sdm845-db845c.dtb: swm@c85: $nodename:0: 'swm@c85' does not match '^soundwire(@.*)?$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
