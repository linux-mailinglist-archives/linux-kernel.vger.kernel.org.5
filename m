Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B643C7C67FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbjJLIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjJLIXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:23:21 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3691
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:23:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-503065c4b25so1034155e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697098999; x=1697703799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3fd/15RUmS8/J2LyPk4OkGg7Q+I1Eks/iQVPxR/ZFE=;
        b=xt8LSPhqNjJkYCXNegIU3Lp4CJV7TAcbjsV/IruzOnP1rlvqwAbFZzEfjSFRbGgbhB
         LqQt0TTIFWo7kfTYdItstET6vNYiDQm/TODYvCwFPzCHTcGueHSkNmnN0zkq+AZAuR4v
         Ac493RO5PZMKHNlb/wZ59BXZLB3ji55LqfBlSBw6dFiUzuxOyoXL/gJ4R9AeliASShuy
         APXsKVkG1uxdFUBuEvdBnASgb4J97t0nwOm3sle/sQZ6g229LqHEFNUW0VbeHt/R9dyC
         pW+9UTa5xWk0sYwKWwOjIjjQokshgJNuDEnceVKREIuZlVclxWDtbiZkPWRLgX6tJQfT
         tV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697098999; x=1697703799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3fd/15RUmS8/J2LyPk4OkGg7Q+I1Eks/iQVPxR/ZFE=;
        b=Ebf2cez/nmmCGSLsyQ1EgD5gO4ktD2/P21sRZCBHbatFFJqr5+PSdKzPSV5QLKhyQm
         gj/rWKCfv1KwH8DnYkbY4NBGn3R+T5I0BcVjN/shtLJ02ecjfQTLqf3g/wTFCpgaYpHc
         Hxoo/pTdteP9ZcJQ6nEl7psIimm4Sw3CFx0hgL38hIkNZs1KcOuDzc/H/hpQg1ndqxvH
         Abvlt/+1UtQ3JCuHfJnqPSYgVyWGD9NAAvsXhz5MRiOm7wUSRdr5RPdZb1JPumuhaXgA
         4nEkQ8GfQoNd8Ofhgu43/Ks2gMurAppKsD/BB/cfl7CBrT3GZsucGbQ+mUVWsq9OT6xp
         Dkzw==
X-Gm-Message-State: AOJu0YyXlBwYOuxEfvVU8Rrl9H/6skQFjEv+btjRh/ixkLDzTR0BgbIf
        4cnTTcyd13Q1X+3SOyHnjo7cx+8WMSWJ5e4ta/A=
X-Google-Smtp-Source: AGHT+IFGSheWNiPKf3Czyq7E/vwLEq/r9RnUAh1lzVUDvNzl0lK9+TXbBUfqaNXflXQUYF/3TWITvg==
X-Received: by 2002:a19:f015:0:b0:500:92f1:c341 with SMTP id p21-20020a19f015000000b0050092f1c341mr18090318lfc.54.1697098998633;
        Thu, 12 Oct 2023 01:23:18 -0700 (PDT)
Received: from [87.246.221.191] (netpanel-87-246-221-191.pol.akademiki.lublin.pl. [87.246.221.191])
        by smtp.gmail.com with ESMTPSA id j8-20020ac253a8000000b005030b40aa56sm2686512lfh.173.2023.10.12.01.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 01:23:18 -0700 (PDT)
Message-ID: <6c691b17-d44b-4967-b957-c963fb136e24@linaro.org>
Date:   Thu, 12 Oct 2023 10:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avinash Philip <quic_avinashp@quicinc.com>,
        Umnathi Chalicheemala <quic_uchalich@quicinc.com>
References: <20231012061127.95637-1-abel.vesa@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231012061127.95637-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/23 08:11, Abel Vesa wrote:
> According to documentation, it has increments of 4, not 8.
> 
> Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> Reported-by: Umnathi Chalicheemala <quic_uchalich@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
