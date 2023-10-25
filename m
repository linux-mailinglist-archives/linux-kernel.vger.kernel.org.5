Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5827D65A6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjJYIrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjJYIqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:46:36 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D6E134
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:46:31 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so82031191fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698223589; x=1698828389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/qDJt2TktcCTAjVqQQhY9/t4tuTrwTtLlHAGkujnds=;
        b=L0rH+BHDTRJltVtYgGHibtc2kAhZRpfQzX17xTaf3FYZUoehotgfexGZAO95Qkwgfq
         if397bM3mt7YLJHPb9Th3IP1sbeuZsdX3XZf+kkLx4vtkpl6VfEV9fsQh2XbAMNvelsw
         V/pCYBedExVegIoHtCxuAUWLdj/sF3a1pWr97uMFh5w8PsADJLZKUYcIAzmJ0eVmlb9W
         i4B4iX5dUBtNbOQX+E1BpVoKcK9CXXCOoMkzDqhcjpWqnXateDLDRMTqGOyf+vRMVhJ6
         +BSZdyfHti2XZIRpvKvSAvDVxt9sTyQr60Ys9XjWypganqFvsTgOnaIFJeNic1AmF3Po
         2VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698223589; x=1698828389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/qDJt2TktcCTAjVqQQhY9/t4tuTrwTtLlHAGkujnds=;
        b=W5ZRxRcX+T/0gk2TIdSgfsBvgmCR9mZ/jjO2wIeJSbdOJ9AYPWqom6PPYeiZIhiNkl
         RPW8yTkovpQXnGi9OX96PH8j00f2gLEq82VlOVES+biJXsA0wiYaNO+3LVFd/oPzOj7H
         nyZhYwCejJEK/yT2cSU6tvNHPvT+XZOKf8L+Ic37IrJ74PHuJ7hMScIxsYvbW57ctpza
         8OD14enO/scmkYkOtrjQFFZhRM5z6P6ttxspW+KPHT2YcxQlGUliXu2qq/nu7qdQ4iVZ
         xvbZajtNnzlH0fCub/s/vvZUZNFeWyFQ03Ct+MstTbz9pnHO3ui8WfR1YUMeAAOedKzD
         9UcA==
X-Gm-Message-State: AOJu0Yw0RoIS4mGsTMC98MxQXqpyQGNY33lSuKveN9p+2IkMaRcWTsW+
        0ggt+zyX5uIZkEozIgXKwiRkb/yRLRo1GctxKzo=
X-Google-Smtp-Source: AGHT+IHrkSVsX7DyHcQJ6Dgs3IFMRhs0xM2WvS141qWk0u9YzRxXAMgcw/0DND/s9rBxWOKyOBFj7A==
X-Received: by 2002:a2e:81cc:0:b0:2c0:2ef8:9716 with SMTP id s12-20020a2e81cc000000b002c02ef89716mr10491238ljg.1.1698223589554;
        Wed, 25 Oct 2023 01:46:29 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p13-20020a2e9a8d000000b002c5122f13b8sm2320875lji.30.2023.10.25.01.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:46:28 -0700 (PDT)
Message-ID: <73409bba-b27a-4c8d-af4b-9efb4c0a5efb@linaro.org>
Date:   Wed, 25 Oct 2023 10:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] clk: qcom: add the SM8650 GPU Clock Controller
 driver
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org>
 <20231025-topic-sm8650-upstream-clocks-v1-9-c89b59594caf@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-clocks-v1-9-c89b59594caf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:32, Neil Armstrong wrote:
> Add Graphics Clock Controller (GPUCC) support for SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
