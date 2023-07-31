Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86866768FA5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGaIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGaIHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:07:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308A3580
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:04:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-991da766865so669064766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690790643; x=1691395443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StAWhWSGGkB4cU1h2MbOyD2Qpbf/SYmtGySN280LVYA=;
        b=iTrcIKmJOYtLzAvQFugn97bU8V/fUX6WZKB9gfMoa89wACShxg0x3KHCAuwBeRw9md
         eHUw0LHMuU4pLXFa6mQ9gCeBktPLQ0AxdXFSoieF0fB485wJhQ1INJhbFc8G4kFXMOas
         SuoGWJyCHJlHUgpMhO9+Yc5BY95cpUPZrph43J3koUsniIy1ljuL92ZdK17iObWBwYdW
         f3hY6WZfnOAznCmhHlHpG1nksE79w3E4F05+QW9EGLaU4JovcRVSLag66xEQiqGcsfJP
         rw6vbZre1odp6Nkn3ihAjF8NknFfyyC2pyRetFuqm5CFzLlohFFaBrv02j83YWnA9w95
         F1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790643; x=1691395443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StAWhWSGGkB4cU1h2MbOyD2Qpbf/SYmtGySN280LVYA=;
        b=l09V7WnoESAAxW9lxxj04U8/OJIzTcdHbzT1YHIYSfRzZGWscbSighzwO4yWMIVy36
         GY3RdOfXz4N9x0tpwmvEPNWPoHGqBauYMTB9BAtAV9kVqzjOKWx9Um1AoDHFahrXN8l/
         xnn/44lF+7YY4rDUH3OYeDZhDdMueIk1oT1fY13e3VNgts4JbLAfdxOfFtJHHsxZyuVy
         XrZ8BtWkV5Ydsh+OMgTi1jDyShUbDU5HKoRguf5S1eRMQDgHp4Qr9t2EG06p1c0AA56t
         DaSc8DARNdRwQ0sjMWx1HWG5GcKKr5bj6DV40KKRXHxvK+52oj5oelcj0de1vYa2sgsx
         gTGg==
X-Gm-Message-State: ABy/qLbkP6n9I4xGv01XGtsxZ0sw0q6hIWczFdh1hqE6j0fcrKYIMmI1
        Rr35uNJ49jN45bcvHCKaYEpBuA==
X-Google-Smtp-Source: APBJJlG369KJbJLaY9QaN5WlHImxT5PZRSkvlb5BGiaiQ4/YyqYYxcGttpJoeHZJKM6GIJyJCs6vhA==
X-Received: by 2002:a17:906:1d05:b0:992:c8d7:b66f with SMTP id n5-20020a1709061d0500b00992c8d7b66fmr6759738ejh.75.1690790643571;
        Mon, 31 Jul 2023 01:04:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id t25-20020a1709066bd900b00977c7566ccbsm5706453ejs.164.2023.07.31.01.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 01:04:03 -0700 (PDT)
Message-ID: <e9ad374f-82db-251b-2d5c-836e0132563a@linaro.org>
Date:   Mon, 31 Jul 2023 10:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v4 5/6] dt-bindings: arm: qcom,ids: add SoC ID for SM4450
Content-Language: en-US
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731080043.38552-1-quic_tengfan@quicinc.com>
 <20230731080043.38552-6-quic_tengfan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731080043.38552-6-quic_tengfan@quicinc.com>
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

On 31/07/2023 10:00, Tengfei Fan wrote:
> Add the ID for the Qualcomm SM4450 SoC.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

