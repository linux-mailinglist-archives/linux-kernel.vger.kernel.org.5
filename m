Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BA7B2AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 06:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjI2ED4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 00:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjI2EDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 00:03:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431ED194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 21:03:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-406589e5765so5900155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 21:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695960232; x=1696565032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KReiWERwDDfiOU1SSbt/KZ2zRQc3dweGFkFBIgCq5Io=;
        b=S8CZu/7PNx3Z/WQ1jNJwQXNKgaMz57fJOUjAbUKTvU8JJdqhlZHyXi2xUHzdu4fR8f
         NOuEIb1JjJMzyWfknxSFAlW2HJ5ovZhs0cvoEW+aTH1MskQJQQV5S/tbmWC0yeckbb7g
         RjKPEi37JMj+cxDK/Kf1HrCSh90Q+Z/faRuKeoXNRNbV7Ijl7CiUD5xFCPLU94z9kMFN
         2SllgMkViNPRFhiUHi8K6rRGuMCv37Cxqv4IwbDfmATTwtZJ6jDtzOOJWfICxX390vpE
         OmIbJ8AXmczNbwrk/ZgArmtBKtGTja5xattAgRkvk+TO+QJp6go2DZyeGB/6IQa+mW0t
         Q1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695960232; x=1696565032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KReiWERwDDfiOU1SSbt/KZ2zRQc3dweGFkFBIgCq5Io=;
        b=MUo4jWMlpTg/d4zzg8tqPGBvrmbdysdWxH0lSbibT69tBpVX0UOr2Y3NDxJzWAWplJ
         5DwDaGUW3iattQGjdJfrS+ZUIY3N2L8Ta3cWAAYywEtFKNGKM9IyNteH9x4SVhvmTaPs
         kHAiU8kzjvkpC/ODlKxqsk+oLYeDQT7SNHklFlYQpTz+74ZxBcZidKwjo4pPUh4w6D7+
         cTMLv057i4PaxUFHCaDDclU6ly4cDXmRH/uY4mzUnUUTy9KN3sl1b4v2JQyze/YBhjQN
         4p1y4u7C0yFSejs4rjHXCk4EEJCsIqQ0Qc5wvrk2rna60bM/Gf7Ei065Y/PDz2kArbtr
         eMJg==
X-Gm-Message-State: AOJu0Ywo9JdnH+fu3Lh4ZpUTyY98hggNQpdN5hjQroqv0kPP9cq3GvvE
        M8j6s6U2ZTuaHO/YrQQKAjlewg==
X-Google-Smtp-Source: AGHT+IFha5fQ5Dsn15Q0JlswasGvdh0fDuykfF/SAMMAFDWRI8o1Qqykm+j6nnjKX1aQ0UqbTubwog==
X-Received: by 2002:a05:600c:2318:b0:401:be77:9a50 with SMTP id 24-20020a05600c231800b00401be779a50mr2644151wmo.8.1695960231668;
        Thu, 28 Sep 2023 21:03:51 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d50c1000000b003142e438e8csm20651397wrt.26.2023.09.28.21.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 21:03:51 -0700 (PDT)
Message-ID: <480a3b0b-f6fd-8300-804b-36f390f2f36b@linaro.org>
Date:   Fri, 29 Sep 2023 06:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] drm/panel: Add driver for BOE RM692E5 AMOLED panel
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20230927-topic-fp5_disp-v1-0-a6aabd68199f@linaro.org>
 <20230927-topic-fp5_disp-v1-2-a6aabd68199f@linaro.org>
 <000416ca-3bbe-4913-9fe5-0993b90b2829@quicinc.com>
 <9febcacd-675f-4d91-9338-f8b3fad4cf62@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <9febcacd-675f-4d91-9338-f8b3fad4cf62@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/09/2023 à 02:02, Konrad Dybcio a écrit :
> On 29.09.2023 00:00, Jessica Zhang wrote:
>> Hi Konrad,
>>
>> On 9/27/2023 6:19 AM, Konrad Dybcio wrote:
>>> Add support for the 2700x1224 AMOLED BOE panel bundled with a RM692E5
>>> driver IC, as found on the Fairphone 5 smartphone.
>>>
>>> Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
> [...]
> 
>>> +static int rm692e5_on(struct rm692e5_panel *ctx)
>>> +{
>>> +    struct mipi_dsi_device *dsi = ctx->dsi;
>>> +    struct device *dev = &dsi->dev;
>>> +    int ret;
>>> +
>>> +    dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>>> +
>>> +    mipi_dsi_generic_write_seq(dsi, 0xfe, 0x41);
>>> +    usleep_range(1000, 2000);
>>
>> I'm not familiar with this panel, but is calling usleep() after almost every single DCS command necessary or specified by the spec?
> Removing them doesn't seem to cause adverse effects, so I'm willing to
> do that :)
> 
> [...]
> 
>> Are these generic DCS commands? If so, can you use the MIPI_DCS_* command macros/helpers when applicable?
> Unfortunately, it doesn't seem so.
> 
> [...]
> 
>> Just to check my understanding of the comment here.. so the above DCS command will set the panel to 90Hz, and if we change the parameter to 0x00, it will be set to 60Hz instead?
> Yes. Since the commands differ, I was reluctant to introduce
> a second, identical-except-60hz mode for now. Though I can
> define a driver-specific struct like this:
> 
> struct rm69e25_panel_desc {
> 	drm_display_mode drm_mode;
> 	u8 framerate_magic;
> };
> 
> and then define both a 60 and a 90 mode.
> 
> 
> I also moved DCS calls from .unprepare to .disable so that they
> are not sent to a DSI host that's powered off and will include
> that in v2. LMK if you have more comments.

Those changes would be great,

Thanks,
Neil

> 
> Konrad

