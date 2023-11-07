Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661927E4A92
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjKGV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjKGV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:26:28 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB6710C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:26:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7853023e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699392384; x=1699997184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8ZbabYnEZ0TbrYO0L9GGQTYabN7EWJlrXz4ovvinYE=;
        b=lZ/lXuYleOyNqWTK8ZA4sjS2tO+gvQdpLhmWJmF1TCX0whdZjac6mdl2CnDi7xaNrR
         5rBpTb0qXh+a97HZzN3KrFdyi3lT6qZiGwnYarCdb7bBd3OVNnqjOQyAX7EFqx2j23OW
         k+Ysxq9nzyqToJAuM4GrGo3R3BW3dIUOlV+CbXO3Yv6KxRLuSCT5q6HF25QnnL2vioYp
         5yPwSfi8EbVsRUUJecpX97JZa5pjickrk1n5RPxlxuo4Mo5qniwNKJlN9cw5xlERc7hk
         ObNNNxVP3wPECg2GRfOdgKo3XC8xzoC1qgM+TcTbKfIRKYSQZdN5WqF9y4DPMzRWeYSF
         2pzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699392384; x=1699997184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8ZbabYnEZ0TbrYO0L9GGQTYabN7EWJlrXz4ovvinYE=;
        b=Y1MWAWKwKLxZhu2IwKsAWHc/0I+mxbcrqVR0QVZp7lNA3CNdaVSuzTU49GtpbvR129
         tTwn4zVvnRKASuJdBu6Vbg/ZvXYJmLC9++OxiMd22hbpBJsGV3dp3J5xat4h40nzV40i
         /xaaP+GKeMvp//r5QVIsMjVJpwqn+udObxFKQSf7+Bw4ki8G/rirbRe4BJFb+VPx85Q+
         zWd1MAu39nTTksTGaP7rxpJ2m2XWvxIlhr2k44LJqdozrLeVk/+bD0KHvMjRAX68Rv4w
         7R+GyR3vG7ugp5lnSH0mjlKGScYrZnQpVbdi61R4eB+kYF27X9ckvOOlBZA7vuSvBvrM
         Zqog==
X-Gm-Message-State: AOJu0Yw6X7yPu83Ddy14hqTLha+BBpZSUgR4hjDD2DUexZUo/vpgtS2Y
        PQfHTLAED4tzG0CKcP1KIvxz+A==
X-Google-Smtp-Source: AGHT+IHgLJN+d/IqcqroFzMDSTAI3G6hIBS/d7pJb3zhOOeHlWT4o81L0maEKBm4+T2uZ7Y4KtUPDg==
X-Received: by 2002:a05:6512:31d0:b0:508:1332:558a with SMTP id j16-20020a05651231d000b005081332558amr31609895lfe.2.1699392383665;
        Tue, 07 Nov 2023 13:26:23 -0800 (PST)
Received: from [172.30.205.109] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t14-20020ac243ae000000b005094bb01fc4sm457208lfl.275.2023.11.07.13.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 13:26:23 -0800 (PST)
Message-ID: <c0201df3-b1de-4761-a4a1-c2bd2e3c14f3@linaro.org>
Date:   Tue, 7 Nov 2023 22:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm850-lenovo-yoga: Add wakeup-sources
Content-Language: en-US
To:     steev@kali.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231106-wakeup-source-v1-1-36b1f39e67fd@kali.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231106-wakeup-source-v1-1-36b1f39e67fd@kali.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/23 01:12, Steev Klimaszewski via B4 Relay wrote:
> From: Steev Klimaszewski <steev@kali.org>
> 
> The keyboard, touchpad and touchscreen can all be used to wake the
> computer up from sleep, so mark them as such in the dts file.
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
> It would be nice to wake up the Lenovo Yoga C630 from suspend by hitting
> the keyboard or touchpad or even touchscreen, so this patch enables that
> ability.
> 
> I'm not married to enabling it for the touchscreen, so if anyone wants
> me to drop that hunk, I'd be fine with it.
Does the touchscreen power off? Would touching it when the laptop is
asleep wake the device up? If so, I'd say that leaving it out makes
more sense by default

Konrad
