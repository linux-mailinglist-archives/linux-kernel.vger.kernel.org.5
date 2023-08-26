Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFB78960E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjHZKsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 06:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjHZKrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 06:47:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ADB210D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:47:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so25505771fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 03:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693046868; x=1693651668;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ao51rXoAw7f6MlsWOU5RlSxZNvDWrLBrWp1Bm3dXlsA=;
        b=nFq+19lCVKOd956xW9LWQ6nEgzlGxA6fAJih1ff7g3g6bEJn2NzzcBFcUm9nD0VwNl
         ts1Cx4BOrwUe8JJdHyzOYOevIJu/8kPmslIaCUGgKV9DEMfL/EO27T+Aoq64B4tsaJdN
         gAXyUmbNKdVtro0k612MVDJ81LnQf/C3BuUOzxbZz7WER3rHkvvT79FTGHJSxbPO/OZp
         6R1qI4Z8p4372JAIif76pFaJ7turZ/r+BInqVVnA2irNcC2lXlnZPJ/X7qE7DnhZc3BP
         jMnu0fuuwkGZdzbvm1xNxnEEXI9rpgoLylB5i/8ADGBKfI1Q82C7bl/pAy6IIHI2fWa4
         SgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693046868; x=1693651668;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ao51rXoAw7f6MlsWOU5RlSxZNvDWrLBrWp1Bm3dXlsA=;
        b=k4NtEsMnUpAhmCcjv/6OSGfW7eZkcV40EBTw7QfERXJMW2lW7uMoyL+EV/7FmwyQP1
         ad2DD3bnXLaLjW2KCWWE5mFyv27LjTGtsaomqyOzF9ZFma8GjmOBT93JpO9CR/X0Nie4
         5a5Q6zxi4ty0hOmuwGeJ1Negc41TxqPMwILrGD8i2BC/py+09vYc539ogyBkrM2ebxIx
         vqDW7b02Aj8O67u6P02Exnw9QFSQKJr3rP/s0kIalKygiq+dLEKD0rGbbPrtXcGq5qxC
         peLihFbulMODTOIqpC7gTvAkKa0/vntrVvhP1U76qmIp6vo1ZhBnX8JASgjGF8JsgoV7
         CjbA==
X-Gm-Message-State: AOJu0YymLYxWysnjdSIEn7aS0qt71WNkX10SlLuLeTCilM32tu3GHMLC
        H/4KEs4WMYyTKPNGBByUdHnbug==
X-Google-Smtp-Source: AGHT+IHipns1KFDf7M4NRbycA6fCS/ucHdXbtazhU24AIPBNwZwSdxenxhivn/fcsMmbuw9bNYRtVQ==
X-Received: by 2002:a2e:3c13:0:b0:2bc:d582:e724 with SMTP id j19-20020a2e3c13000000b002bcd582e724mr9978080lja.31.1693046868345;
        Sat, 26 Aug 2023 03:47:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id v3-20020a2e9f43000000b002b6e15ccf88sm733615ljk.135.2023.08.26.03.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 03:47:48 -0700 (PDT)
Message-ID: <07e93a9d-69ac-41b7-aa21-b855b97bf801@linaro.org>
Date:   Sat, 26 Aug 2023 12:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] clk: qcom: Use HW_CTRL_TRIGGER flag to switch
 video GDSC to HW mode
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230816145741.1472721-1-abel.vesa@linaro.org>
 <20230816145741.1472721-5-abel.vesa@linaro.org>
 <2fc0d771-cee2-4826-a62a-56ed4bfad3a2@linaro.org>
 <ZOXiUzxfs1cj3SWT@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZOXiUzxfs1cj3SWT@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2023 12:41, Abel Vesa wrote:
> On 23-08-16 19:56:46, Konrad Dybcio wrote:
>> On 16.08.2023 16:57, Abel Vesa wrote:
>>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>
>>> The current HW_CTRL flag switches the video GDSC to HW control mode as
>>> part of GDSC enable itself, instead of that use HW_CTRL_TRIGGER flag to
>>> give consumer drivers more control and switch the GDSC mode as and when
>>> required.
>>>
>>> HW_CTRL_TRIGGER flag allows consumer drivers to switch the video GDSC to
>>> HW/SW control modes at runtime using dev_pm_genpd_set_hwmode API.
>>>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>> Do we have any use for the HW_CTRL flag?
>>
>> Perhaps it should be renamed to HW_CTRL_ALWAYS?
>>
>> Or even better, *if and only if* that is necessary, add a common
>> property like "always_hw_managed" to the genpd code?
> 
> The HW_CTRL flag is still needed for the consumers that expect the GDSC
> to be have the HW control bit set right after it gets enabled.
Guess the correct question here would be.. Are there any?

Konrad
