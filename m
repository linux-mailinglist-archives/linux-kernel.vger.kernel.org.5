Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B47CC7A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344053AbjJQPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbjJQPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:41:58 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E9B6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:41:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so57342895e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697557315; x=1698162115; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhb/VbAKqWW2bljNb3g4iYW+C+1SCZk6etl2bAcOYLg=;
        b=ndGJ0F+DYASH3lA6ZKOvJYiP4KYDBFMW8JyLPkmpwxPPg9lrGLWpJH5WQ/VE82eoiC
         XyjJ9lyyS6QWOvORIcyWlczwFugb2H9nKNcN0jTxdDfnJJEEyVSHcUZSy+absxhtToH4
         NyMJjTmGCoJZ9WtIupircSl1mOxEgFn2xVDfoPy7tunE3/p8UBM3nD9D08wB07a//bWk
         Gy3VzjYEg1ekfQ+agevrBHc1uEG4EanU2nOoGLL454oi2C/WjxpN3T0JGYGyQuH/plef
         FZMVdpdC5FAzCDrwKvffNvkqphKm3Hw0L+BFM/1x/3h0wWJPK0OWh84nuautTVIpyrLY
         +jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697557315; x=1698162115;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhb/VbAKqWW2bljNb3g4iYW+C+1SCZk6etl2bAcOYLg=;
        b=kLZPc+gshIyX07ubXnyg4b38YFwERzKKRp8Xh+ikOA5b8Ut6r0pQacbycSDP7EsLUi
         4ky/DObOdFwvtuTUewhtVMxZX4iYEVMgHVEiWlnxWSEHmEm26wOBbRrPz1OfsR6F0fAl
         2AqwGjgJ0VB4ruFPxqKE2WEHsrjUeFDNwhRSpfB05rt4+jJpKSECmdY35HnO6v89OKuI
         3yMvCJPYXkb4IF0h8HWUyB/b+L6vFLmk1TGW9iGzIA3fp0xAHVgvnRSSc/RZlWloAqjP
         wuhJc4cfMKt1xi8RvncY9W5VLR7GiKU6n+wMHKwN9qDBiaQlVll5j9vtlwAAwPFwYAeh
         j1sA==
X-Gm-Message-State: AOJu0Yy7vOjC+ucjzesVLwPwrCjYFIoNjvLNYDhPKLpGo90wHPR0nwYQ
        gp0dYMN/0VOpXUjh3hm+o0o8cQ==
X-Google-Smtp-Source: AGHT+IEBdPfJkKsMwqOR6v2jaw8Ctfjv771N7HSdvQQL35i0TEr+3Xf1Wr87PCO+t6DIWat/o2wyKA==
X-Received: by 2002:adf:fac9:0:b0:32d:8401:404a with SMTP id a9-20020adffac9000000b0032d8401404amr2001007wrs.10.1697557314693;
        Tue, 17 Oct 2023 08:41:54 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b0032dbf26e7aesm38382wrr.65.2023.10.17.08.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 08:41:54 -0700 (PDT)
Message-ID: <eb05e877-ad8f-4724-bcf9-6054ae14a5e8@linaro.org>
Date:   Tue, 17 Oct 2023 17:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/msm/adreno: Add ZAP firmware name to A635
To:     Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org>
 <20230926-topic-a643-v1-2-7af6937ac0a3@linaro.org>
 <43q6mui3lofa4rqh667o54b2qcbqn5fg34ss5o7y7k7uxbxsro@dxgovofsrvqx>
 <CAJs_Fx7WkdhY31aP_buZP+b7ihOOmE8zBZFOLZ8z9uqcNmEhVw@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAJs_Fx7WkdhY31aP_buZP+b7ihOOmE8zBZFOLZ8z9uqcNmEhVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/23 09:33, Rob Clark wrote:
> On Mon, Oct 16, 2023 at 1:12 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>
>> On Tue, Sep 26, 2023 at 08:24:37PM +0200, Konrad Dybcio wrote:
>>>
>>> Some (many?) devices with A635 expect a ZAP shader to be loaded.
>>>
>>> Set the file name to allow for that.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/gpu/drm/msm/adreno/adreno_device.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>> index fa527935ffd4..16527fe8584d 100644
>>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>>> @@ -454,6 +454,7 @@ static const struct adreno_info gpulist[] = {
>>>                .quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
>>>                        ADRENO_QUIRK_HAS_HW_APRIV,
>>>                .init = a6xx_gpu_init,
>>> +             .zapfw = "a660_zap.mbn",
>>
>> sc7280 doesn't have a TZ and so no zap shader support. Can we handle
>> this using "firmware-name" property in your top level platform dt? Zap
>> firmwares are signed with different keys for each OEMs. So there is
>> cross-compatibility anyway.
> 
> I think this ends up working out because the version of sc7280 that
> doesn't have TZ also doesn't have the associated mem-region/etc..
Yes

> but
> maybe we should deprecate the zapfw field as in practice it isn't
> useful (ie. always overriden by firmware-name).
Also yes, we've discussed that on IRC once

> 
> Fwiw there are windows laptops with sc7180/sc7280 which do use zap fw.
Correct, e.g. the SC7180 Acer Aspire 1 that is supported upstream.

Konrad

Konrad
