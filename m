Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A080177E86D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345422AbjHPSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbjHPSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:13:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028642698
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:12:58 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe11652b64so10784184e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692209576; x=1692814376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rIOIAIAB2nZMmeJ2q/w7McIGNDOK18Jyp8rCuWMNUEA=;
        b=DybbaXBOFIVURSPRYAPB/bM0Qx59UpXwMJn20HZ0mIZWx1KK3GnwJX/fXNxT/ZvdCb
         js8LxqIeCBPYBFymVHarmLML734sZyulZpK359EKmt95FzZqoIhWEbHY5oRZJVkLMzlL
         SPoFGx+0By/xCGEiR3uYEcllrEDrIydTsgwnHX3KwoHSEyiLFA6u+sknJXBMIUCIscSO
         XPUP/USF0kDs55A64DD7QIDQVdIoeAx1N/TySJLLllr9gRmJ4o/XKFTaHyOSCvW4uNlA
         UTubXfZYkHet/4Vi+8C6G+lVSslI904h2Ex8XQ3EuTHxfC4cJjTm4+Rm+2YlPmn+7HSy
         96MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692209576; x=1692814376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rIOIAIAB2nZMmeJ2q/w7McIGNDOK18Jyp8rCuWMNUEA=;
        b=Lb9B1ggaARJYAIzZchjZVOOTybiyPLnh6Eti7XH7Mfpw/nuHE5r0cphoEJCHVLIkaQ
         mc3/UdCt34YGq7TB7IzssBCr51RzIWiYIYJF7Dj/EH/ZSqU7UC4+B8TRMNpScX9/MOR7
         JgeG6vue9LPqJpSnoWdxxY3B1sy51bOa1GfhPvGY7JtRrFQzS+YRwj5vmxUHLhjVw53U
         bOeps+WODLaHHKzGWQGjI6v+4fBGdr+FL3/tCbhOd/ruK2xIh5pFbSjWJiuTVBh0m5aP
         WyIPQqLooYSX5MrovHoSMOr4JIjuDWGSDmguUnnjrBTJjfXS1EhJp1AoqBDYjtLZ7rxn
         c4uA==
X-Gm-Message-State: AOJu0Yw62iVe/c9dKMPdsSJePvAiqW56ZWIiS00umdQ48r37KDQotyF7
        BBQjBckfJugO389QI/0e1apsmg==
X-Google-Smtp-Source: AGHT+IGVXtf9gH1OBvrJrM9BtUDz5r4jCbc8hwdm5q56kVF64Fc5atHpw0a7kqmBvumG/eEcLCTgkQ==
X-Received: by 2002:a05:6512:31c6:b0:4f8:4245:ed57 with SMTP id j6-20020a05651231c600b004f84245ed57mr2631921lfe.35.1692209576231;
        Wed, 16 Aug 2023 11:12:56 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id i21-20020a056512007500b004fbc6a8ad08sm3008542lfo.306.2023.08.16.11.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 11:12:55 -0700 (PDT)
Message-ID: <cb1df40a-e879-4095-b5e5-f71a46e92120@linaro.org>
Date:   Wed, 16 Aug 2023 20:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 2/2] phy: qcom-qmp-ufs: Add Phy Configuration support
 for SC7280
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, andersson@kernel.org,
        vkoul@kernel.org, agross@kernel.org, kishon@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Manish Pandey <quic_mapa@quicinc.com>
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
 <20230816154841.2183-3-quic_nitirawa@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230816154841.2183-3-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.08.2023 17:48, Nitin Rawat wrote:
> Add SC7280 specific register layout and table configs.
> 
> Co-developed-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
Looks very reasonable compared to what I can see downstream.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
