Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFF76473A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjG0GwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjG0GwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:52:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0ECE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:52:05 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so732041a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 23:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690440723; x=1691045523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vtiZPrqP8uUORByaZrYP3A2w8ZlRXeVxL/6m3MH0cfI=;
        b=oESyJ15UExJZrUoP4T1iVbqgurrRaWmrE+ncPplapT0QowF6VWpCQWlBVKphnadN2M
         G1NVEjC9vzTxY6YmRz+lRSAq6yZj9XBcJnc8Oz5wnQyxg1mTl/3AsozrDkspZFXJeBj1
         fBRpjlKF4OUXd/oE1/6TRw6Iob3AF2mrb3XypdggORdWuiR3Ptw7LV30dGSnVPT+wWxc
         ClYdyul6VtmoFRVkSUtQFex/M6jL+3yD21OAE70aDJrFRexj6trVxJyMNhwlfpp9qrlA
         lRcpjJIjyAYLuL+L3YS0L5ZXWdwBd18xAQnJuBXqNPTnAxyGhpGP/PN3XR7hP9Rq4+6N
         98WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690440723; x=1691045523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtiZPrqP8uUORByaZrYP3A2w8ZlRXeVxL/6m3MH0cfI=;
        b=T7bXqzd/kjG4BePZOOq3a+MbIMDAm6V2v0dvA+MS4QWEIpeC+HL+JarupLnbYtuqHq
         9M015b3iagtNKZYE/SfV+XCc/DVoZq2S94jGJ/pF8erCLttqhwbxgBX+KgDVwcscv1pp
         EnRpjnxcVvN0NOxbQOM0HciIQy/Osx94EaR5AecKP/q6AU0D2cuIWZ9bZS8B4ISgJITl
         aKnyyG+WEJvOjuM7f2XcTsnjK3q2Bbqht+rT4Vwmda8xRpxTsBTOZbXAeZtD5dZq9t2T
         ZPSjdhWRubbQyPXPoXwgxKk10lWssJUEmqGtkQ87QAk/ZvIrw/A/95XWL86LKbMi22uV
         fjBw==
X-Gm-Message-State: ABy/qLY8rP+QdqnCzb6Gqbq+vyXFlfMDxHYr+thxX+WMSKMvJsybSjXf
        oLYETvEawEmpRezgY5r0+XV1Iw==
X-Google-Smtp-Source: APBJJlEerrh6bJhTNbyTGssJWe4Bku/FT2W764iCDIy6h8rLd5X2YZloSZ1d+yX0+2Lz3BAbSiesWw==
X-Received: by 2002:a05:6402:5156:b0:522:1b93:4cf4 with SMTP id n22-20020a056402515600b005221b934cf4mr952053edd.25.1690440723541;
        Wed, 26 Jul 2023 23:52:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7ca49000000b0051873c201a0sm283702edt.26.2023.07.26.23.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 23:52:03 -0700 (PDT)
Message-ID: <ca47f2f1-8928-c7bf-c314-a20045231c4c@linaro.org>
Date:   Thu, 27 Jul 2023 08:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] dt-bindings: qcom,pdc: add qcom,sm4450-pdc
 compatible
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727023508.18002-1-quic_tengfan@quicinc.com>
 <20230727023508.18002-2-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727023508.18002-2-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 04:35, Tengfei Fan wrote:
> Document qcom,sm4450-pdc compatible for support SM4450 DT upstream.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

