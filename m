Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667127907CA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352121AbjIBMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352085AbjIBMRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:17:20 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD5E72
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 05:17:17 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500c6ff99acso989450e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693657036; x=1694261836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8YjCL4MC8RHhoT9yS4acFO7xCziXIBoNIPh3JbO9pMI=;
        b=DDhAW4IaARQiav1aw9XB9oQzMMUgOmqwznL1aKlToloxCdL3kBg9W3ybpx8elM5QAy
         F6BkyeXWvWUN6etRs22EIBti4e8pPOXdyH+vEADurBzYC0mocFhiS8BTMS1Z9t/pQzJx
         erK7WHqgGxIzEkE5WEf97z4/VrQ749ekID3IFyPr5UFnMWDCHffGhFsPErvT7Q8Wn0Hl
         TtclAckfU1pV5RaRC9i4XZtwnw2dEizwSWYCPXYRKlZnax8Skptb2DpyN9Psw/aWikG4
         eC3vDM2SyksrG9dwmpBftpw39hKlwLod4aiGomlS/ghiV4LLu641G6n1RF35f9ykyzJH
         JT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693657036; x=1694261836;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YjCL4MC8RHhoT9yS4acFO7xCziXIBoNIPh3JbO9pMI=;
        b=cydTThAKXKIEHd0GTbpVUPMDPyhu6I/frPQyecpIrb4sz5XKkr4Xy9dc5jhS+IXsOZ
         jnennZ2TwUWza9bivCHvsX8CVAPAmbCcGmG7kF2iLwyLE5iyd/XGRKRt13voRpMScKdr
         QFvJL0Kjf/wm30b45Z9UV+/b2B8pvYTJqIJ/Tjtul2bxaNXuI0xlUMuCWDvK4yPISI6V
         e5cGjFiDFtFRq+y34/szsC5IFipiLLKGS3s5WOjIlxEcBCR76NA0Lpv7eHFB9Ti8wSnB
         m2UnWYjUigBKNUJRAgDlXLNlG93B5rX0yNx205WpYwa2i3Ile1mWEQXCTQ1ndoKYg70s
         q8Nw==
X-Gm-Message-State: AOJu0YwBDWrfhjPwDNJyASmxj66C5sxeqRM7PbOjijdahPw4jM4JHibm
        QGYxLCD3vRc86/FldjgFC6v2NA==
X-Google-Smtp-Source: AGHT+IGx6FZYlE0NJqd3FNjJKJHBhb975Mne1npLdrzyohd6egRy8/Yo6eOFAKVhppxUYwJt2keaxg==
X-Received: by 2002:a05:6512:220f:b0:500:7756:644f with SMTP id h15-20020a056512220f00b005007756644fmr2613051lfu.8.1693657035599;
        Sat, 02 Sep 2023 05:17:15 -0700 (PDT)
Received: from [192.168.1.101] (abxi170.neoplus.adsl.tpnet.pl. [83.9.2.170])
        by smtp.gmail.com with ESMTPSA id r13-20020ac25a4d000000b004ff1b5c8df3sm978910lfn.211.2023.09.02.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Sep 2023 05:17:15 -0700 (PDT)
Message-ID: <4b38699c-8276-4474-8d0c-b54a69ea8be3@linaro.org>
Date:   Sat, 2 Sep 2023 14:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to
 switch GDSC mode
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
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
 <ef031105-3b77-484d-8f47-a6c0233dd9c2@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ef031105-3b77-484d-8f47-a6c0233dd9c2@linaro.org>
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

On 16.08.2023 19:58, Konrad Dybcio wrote:
> On 16.08.2023 16:57, Abel Vesa wrote:
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> This change demonstrates the use of dev_pm_genpd_set_hwmode API from
>> video driver to switch the video mvs0 gdsc to SW/HW modes at runtime
>> based on requirement.
>>
>> This change adds a new boolean array member vcodec_pmdomains_hwctrl in
>> venus_resources structure to indicate if GDSC's have HW control support
>> or not. This data is used in vcodec_control_v4() to check if GDSC has
>> support to switch to HW control mode and then call dev_pm_genpd_set_hwmode
>> to switch the GDSC mode.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
> [...]
> 
>>  static int vcodec_control_v4(struct venus_core *core, u32 coreid, bool enable)
>>  {
>> -	void __iomem *ctrl, *stat;
>> -	u32 val;
>> -	int ret;
>> -
>> -	if (IS_V6(core)) {
>> -		ctrl = core->wrapper_base + WRAPPER_CORE_POWER_CONTROL_V6;
>> -		stat = core->wrapper_base + WRAPPER_CORE_POWER_STATUS_V6;
>> -	} else if (coreid == VIDC_CORE_ID_1) {
>> -		ctrl = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_CONTROL;
>> -		stat = core->wrapper_base + WRAPPER_VCODEC0_MMCC_POWER_STATUS;
>> -	} else {
>> -		ctrl = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_CONTROL;
>> -		stat = core->wrapper_base + WRAPPER_VCODEC1_MMCC_POWER_STATUS;
>> -	}
>> -
>> -	if (enable) {
>> -		writel(0, ctrl);
>> -
>> -		ret = readl_poll_timeout(stat, val, val & BIT(1), 1, 100);
>> -		if (ret)
>> -			return ret;
>> -	} else {
>> -		writel(1, ctrl);
> This removal cries for better explanation.
> 
> Has the venus hw been setting some registers that alter the GDSC's state?
> Or the hardware's expectations of the GDSC state?
Clearly can't read the commit message

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
