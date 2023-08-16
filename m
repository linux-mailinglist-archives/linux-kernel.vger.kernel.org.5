Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1C77E80D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbjHPR7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345322AbjHPR64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:58:56 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AAC2710
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:58:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so109211641fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692208733; x=1692813533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rL1d5IkkpVuyaHJUviWq3wb0oe5qxAALKeywaszABpo=;
        b=f9t0VBOxRmhAPHWhEew70l7ub3eQ1HxIhoi1qa1w7k0EFrextvcWK3vdTGbL8aPiIp
         Q3doG/2Mey7PKIb6XIlJpGeKG+0iLHUY8UBgSnrQIPFXhhGyHLw+xKpvSrDiA1HNg2t8
         4iB2q0A2hkAjUVXDq7rDwqHxdT3j5VxELLYwucVD6Yz/vYDR5whteKmqLVsJ7Vh9sQQ4
         kRQeYNrEfbQzhLq2/5knVeS4py+fev72cCaHwOr+TaFRX0JYmQ3RsbcPBUMTkCVLKrFI
         c/CBNFc5T/LAcnl5wK4VNjQxiTtSqTfIuLwgUfh1hjoKKld+QQ6whrSD6mk1Smf35gKV
         dWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692208733; x=1692813533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL1d5IkkpVuyaHJUviWq3wb0oe5qxAALKeywaszABpo=;
        b=R6z9AQT7AgUsYkomtp1rtJ7j9JJ4E3LQY0Grb0WtejH4umyXq3/RxxKG6JPulIo1rm
         jR+1P0f2lUcPpEDd0uzKN3Eq6i5uoarbXoG6In/CRiVJcEZdk2zSb09aZEtT+fEv4Kbd
         WDfLQmYvxGN+aKflwzd9rtLijzjxLpEthAN4vJYlydrQViJxMOaTwh6MKhX3Dz1fV1Sv
         InALjw5OE+276RreG+qDOP/38of2dfz8K9bXOKdxGidXz57FiTzsrVg0oeQcbNzSjJEK
         AjJ+1BCN7cR8acZGw9d1/52E2ozmaPrg/qbc+vJ6sAOrGI8Obn1BjLLyN+yyHDKf3Dke
         8+7Q==
X-Gm-Message-State: AOJu0Yy6mfqlQWJnm27j3cTCrYSoaCBAuKVA1pveB3wkmTSNMWyJSSZE
        SkTcm4ilgX3V6aWmHxUy3fgKdA==
X-Google-Smtp-Source: AGHT+IGmlFLezr5yGl7cSouAqe8XS1SwhcY8CrjyqarVswLmc7p7MEkLmDIAAfCbjQRhEMEbcAsTjw==
X-Received: by 2002:a2e:9c99:0:b0:2b6:e618:b593 with SMTP id x25-20020a2e9c99000000b002b6e618b593mr2263846lji.31.1692208733180;
        Wed, 16 Aug 2023 10:58:53 -0700 (PDT)
Received: from [192.168.1.101] (abxi8.neoplus.adsl.tpnet.pl. [83.9.2.8])
        by smtp.gmail.com with ESMTPSA id k22-20020a2e2416000000b002b9e0aeff68sm3581086ljk.95.2023.08.16.10.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 10:58:52 -0700 (PDT)
Message-ID: <ef031105-3b77-484d-8f47-a6c0233dd9c2@linaro.org>
Date:   Wed, 16 Aug 2023 19:58:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to
 switch GDSC mode
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>
Cc:     linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-7-abel.vesa@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230816145741.1472721-7-abel.vesa@linaro.org>
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

On 16.08.2023 16:57, Abel Vesa wrote:
> From: Jagadeesh Kona <quic_jkona@quicinc.com>
> 
> This change demonstrates the use of dev_pm_genpd_set_hwmode API from
> video driver to switch the video mvs0 gdsc to SW/HW modes at runtime
> based on requirement.
> 
> This change adds a new boolean array member vcodec_pmdomains_hwctrl in
> venus_resources structure to indicate if GDSC's have HW control support
> or not. This data is used in vcodec_control_v4() to check if GDSC has
> support to switch to HW control mode and then call dev_pm_genpd_set_hwmode
> to switch the GDSC mode.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
[...]

>  static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
>  {
> -	void __iomem *ctrl, *stat;
> -	u32 val;
> -	int ret;
> -
> -	if (IS_V6(core)) {
> -		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
> -		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
> -	} else if (coreid == VIDC_CORE_ID_1) {
> -		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
> -		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
> -	} else {
> -		ctrl = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
> -		stat = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
> -	}
> -
> -	if (enable) {
> -		writel(0, ctrl);
> -
> -		ret = readl_poll_timeout(stat, val, val & BIT(1), 1, 100);
> -		if (ret)
> -			return ret;
> -	} else {
> -		writel(1, ctrl);
This removal cries for better explanation.

Has the venus hw been setting some registers that alter the GDSC's state?
Or the hardware's expectations of the GDSC state?

Konrad
