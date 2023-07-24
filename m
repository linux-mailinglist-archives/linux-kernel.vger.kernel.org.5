Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3A75F186
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjGXJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGXJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:57:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD1D5FF0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:52:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-522382c4840so609384a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690192279; x=1690797079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qH1xPhg/Am+ZrA/6voevZTtm38nK8XnjsWRckc1S8Y0=;
        b=fxsgaMznyP34uFtm9q8dp/qpx6mJfNaqnKkUjO+3VyQIqxKm9Reo4Q5mHXlTYUL17o
         QX5dwmR9wsUckH6mHlK8U10jRKhNSD9dcRyZP23ZCcRr7zc4lo1OW2B9jteri0NljHRZ
         FJW8kEJxQ2n7FuflC3mkhc8bzFnBMRCl9QNubAq1900yEoDlLyuSPLTDK8pbNKAVzXnz
         QmN76iP3U/PILiqE1lrDQ7LKn0jev5m4vo2oUaUs4Jr38FF/hc0frMCmUIohSMmewlbv
         tgIBeXlZXWd/yQYdy/VloU9o8WliDVcckNeVYtGbaqr6pRFQOS5X0ihF63V120YQ4hq6
         P6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192279; x=1690797079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qH1xPhg/Am+ZrA/6voevZTtm38nK8XnjsWRckc1S8Y0=;
        b=PMV+AtzCNfut0jxDB42f2jBamA+yuszWtM7VbtWBmMgBtJmuv0lIy5LH3ndXkROlfa
         wg5ogSBu/DC2z09p/blcw0jwFBFgeV6RDo3tRWvF395JCpZ22Ik9oezV3U8qrv71fVPq
         MHa7qs6CE9pT1t58t8Ip4yGnqsIcwap4KnoM1WqdcaqyN+uy+bI0MFA0t9uD14alAZYQ
         vaJ4KI+nYHTWb0aRMFoAkszCyf2bDagFadCgs//Yzwq6tv+AlsYoKxT093IRwnszDsQb
         pzKhBiYeADq6AHaGgQcnhwdmL3ybaL+pG6bVi5fNncA7Tu0bFHeGeJl4TcidZ5eP5QM6
         GBFg==
X-Gm-Message-State: ABy/qLbBtdT8XrItLgOqud46PMUg8kyN1yhU4E4mQ4FyTc6afJuqt9Cu
        +wOGs/jeUkr+r7petJBG92ObaQ==
X-Google-Smtp-Source: APBJJlGV4XG1oZ6mf5FuCv97rwX7+atN757Oexd4FcjKk5uHoW5XYBMwCJwhh9zXKY+U05Om/FOqtw==
X-Received: by 2002:a17:906:5a4c:b0:992:345e:831b with SMTP id my12-20020a1709065a4c00b00992345e831bmr10299061ejc.50.1690192279269;
        Mon, 24 Jul 2023 02:51:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b0098e2eaec394sm6486372ejq.101.2023.07.24.02.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:51:18 -0700 (PDT)
Message-ID: <488769bd-8373-5f53-204a-3739f104cd99@linaro.org>
Date:   Mon, 24 Jul 2023 11:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/6] dt-bindings: cache: qcom,llcc: Add LLCC compatible
 for QDU1000/QRU1000
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230724084155.8682-1-quic_kbajaj@quicinc.com>
 <20230724084155.8682-2-quic_kbajaj@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724084155.8682-2-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 10:41, Komal Bajaj wrote:
> Add LLCC compatible for QDU1000/QRU1000 SoCs and add optional
> nvmem-cells and nvmem-cell-names properties to support multiple
> configurations for multi channel DDR.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

