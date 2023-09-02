Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D279098F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 22:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbjIBU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjIBU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 16:28:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B52E54
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 13:28:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5007abb15e9so428886e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693686493; x=1694291293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AqfoenQWKjB8osDxkwnJtLt7lDhWz7e/+s7umbsPwHw=;
        b=swKso9zaMeE8R5oZjRS8ty0OwExYJa4ha1t8KJkRfTc791O0G2shPvtBU4uifG8jBs
         AZD3uT1E9Q2MkDU1l9svrGjU+VVCzsXgqjwJjgIPzBhOP7/9fK4PF3R2Z6mciOT7hQB+
         B0PkhdQFSxqzBm3oiJ8wSspp2ey/zWuEBSif5eVMj9ahqbf/W+9rKBERtRVtnVHDskdG
         Ed9IWcMPaZEyGRrk0sAmA13nktmI206WuBkks27jZlUkGqycITAa4qsVPGnm9JA2CfVw
         H2kov2FFhEK6M9Q5tb/0z2ifUjk5PXASAxK5nuKa7UJ7mgv+xzZ6jZLxFIW029UhicTV
         8ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693686493; x=1694291293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqfoenQWKjB8osDxkwnJtLt7lDhWz7e/+s7umbsPwHw=;
        b=ZRbZh6yBGrPL5gs3/VUJKa8xyy1uNSNhMPVMrroLuvLRYm8hk7s4slIrwgqh79Qube
         RzDUEjIZvvGEQiZZzKOpVQt8k3NMeobI1ZAmvqEy7N62MPqQaYSukCF8u0eppeIA0Hfa
         RggyuN+S8BkD/D28UrEKPjcrLlP2chcov1nYN9p9aLDXyEGvKvsEDarCDqwBegqEP7Xw
         jB5wUXe/Mnk5p0Fm7DfOCAdn/v9E0PRYTtIj84oJeHig/2rYZpv7D5ypogPRhqzeHMPt
         Lg5BluSSeZkuD74MNmXWcP+U7nxRMHa00OpfsU9CCMXNQvADXC4mC8gjQlsvhK2i6hFn
         GmRg==
X-Gm-Message-State: AOJu0YxLBBhd9LOVsUs4G+PCVIC0UgCgad5kI1EQ4Z5qQZs63ub3br74
        yoBVADJI7CZKpyhNGzLHwTTHtg==
X-Google-Smtp-Source: AGHT+IFKG4hNiSYylXmxPiCLbNRI/9QDxNUYdr8ha450JvMnEp+W79CNqzswJe03zTPMb/vPObWnrQ==
X-Received: by 2002:a05:6512:742:b0:500:7f51:d129 with SMTP id c2-20020a056512074200b005007f51d129mr3115285lfs.34.1693686492622;
        Sat, 02 Sep 2023 13:28:12 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id g22-20020ac25396000000b00500829f7b2bsm1073827lfh.250.2023.09.02.13.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 13:28:12 -0700 (PDT)
Message-ID: <091e4156-cdaa-4233-b7e5-69e3f8ee9a49@linaro.org>
Date:   Sat, 2 Sep 2023 22:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: mmcc-msm8974: remove ocmemcx_ahb_clk
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mike Turquette <mturquette@linaro.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230902-msm8226-ocmemcx_ahb_clk-remove-v1-1-8124dbde83b9@z3ntu.xyz>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230902-msm8226-ocmemcx_ahb_clk-remove-v1-1-8124dbde83b9@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
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

On 2.09.2023 19:34, Luca Weiss wrote:
> According to a commit in the 3.4 vendor kernel sources[0] the
> ocmemcx_ahb_clk clock "is controlled by RPM and should not be touched by
> APPS.".
> 
> [0] https://git.codelinaro.org/clo/la/kernel/msm/-/commit/37df5f2d91b4d5768b37fcaacaeea958dd683ebc
> 
> And indeed, when using MDSS+GPU+OCMEM on MSM8226 and not using
> clk_ignore_unused, when Linux tries to disable the clock the device
> crashes and reboots.
> 
> And since there's also no evidence of this clock in msm8974 vendor
> kernel sources, remove the clock for msm8226 and msm8974.
Going over the downstream clock driver for 26 and 74 and comparing
the registered clocks with mainline may be useful.

Older clock drivers were likely written by hand and people doing
that likely didn't have a great reference of which clocks should
be skipped due to having been moved to firmware somewhere in the
bringup process.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

