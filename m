Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB677FDA6C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjK2OxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjK2OxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:53:12 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53244DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:53:18 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a03a9009572so929174566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269597; x=1701874397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GBDl6cG4lr87kxdVo6gq3b5ip4+sMxJ6dZ4zGUODCRE=;
        b=TMYP3se2fU5YViluPNX/fzENNinTvBcOVpfackBQzfM+5vNJehxXOB711gBD5AcdHK
         Gf8L+tEQK0wHrwGfIdknpcCBwUq18b0YSZ/j/KPYcFyZhPH74qeK5+8OPWldHtddxrAO
         Ny/A9nghF/1op6bBK8T8A95LGvoJicqJtBR+LskC6YQKVVL6BMBTJ86zvrX0++D9ZT7H
         oz6+/KeMWHHE3sei30LcQfwyjs2X9RTGiFTxk8wiyuZ+9dICJm3pnngTL4fLK8UPLACU
         OA/of4wbR+Zm/pSD6jXOQmOy4znnQQb/mBCuNgxuLR/DEBuo6t1iMs9gptUVEdaMChSy
         3cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269597; x=1701874397;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GBDl6cG4lr87kxdVo6gq3b5ip4+sMxJ6dZ4zGUODCRE=;
        b=ffkShntiEiY+vGx8pQ8tt5jEZi7krm1lOUWtwQis9IxTTAE0Te+Pz29rdkIbElEbG3
         19dYvrikXysAqx0bisTPraFzh1k5sSqBT7oqx8G8vsUYGQ+imSkHXclOH/8vPK++uTus
         wEV4X0jpblzGbdBLYzMYTbfMkXeuiX9T9+XdqRH5tyo+iIqIGYOjJOPP2peVQzsOjL/a
         DlIu16tDx0oy1iDcznhSO3tUmpccoN0A0NeeQdiipaCkJzH0HZxyBNfzzJgRzr4hGEfe
         m1himw/yl4snDj4VbHMd/93FWwEt8gMe5eRKy54zwPsmH0FI0ut7pNP+SmrvO13lGhb1
         Onew==
X-Gm-Message-State: AOJu0YwmVK8fpU8hSVpTEqmYY+nxgorV/KLFQH+GaQuMRt8alpfSd3pT
        6cLH/1kWmHpnJQWGeJH0BtUfIg==
X-Google-Smtp-Source: AGHT+IEYbWmdEk+CF8l9ul8Hlt5WI3nwUcrOO4Xq4y9FjJD7dEzmATjepnSP1f3VGfizPy3ONExCFg==
X-Received: by 2002:a17:906:18c:b0:9fe:354c:b754 with SMTP id 12-20020a170906018c00b009fe354cb754mr14042382ejb.53.1701269596826;
        Wed, 29 Nov 2023 06:53:16 -0800 (PST)
Received: from [192.168.209.173] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id u25-20020a17090657d900b0098ec690e6d7sm7949048ejr.73.2023.11.29.06.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 06:53:16 -0800 (PST)
Message-ID: <61407fc0-4273-4d85-a9ff-4795a718d80c@linaro.org>
Date:   Wed, 29 Nov 2023 15:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] DSIPHY RPM
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230620-topic-dsiphy_rpm-v2-0-a11a751f34f0@linaro.org>
 <168908465045.1869384.1893558597710112842.b4-ty@linaro.org>
 <3b4865d7-2730-1ea9-d75b-a015d27aa84d@linaro.org>
 <ff7fac16-deaf-4e71-91aa-b2ea66098c9d@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ff7fac16-deaf-4e71-91aa-b2ea66098c9d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.2023 17:25, Konrad Dybcio wrote:
> On 11.07.2023 18:31, Dmitry Baryshkov wrote:
>> On 11/07/2023 17:21, Dmitry Baryshkov wrote:
>>>
>>> On Tue, 20 Jun 2023 13:43:19 +0200, Konrad Dybcio wrote:
>>>> Some recent SoCs use power rails that we model as GENPDs to power the
>>>> DSIPHY. This series attempts to make such configurations suspendable.
>>>>
>>>> Tested on SM6375.
>>>>
>>>>
>>>
>>> Applied, thanks!
>>>
>>> [1/2] drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks
>>>        https://gitlab.freedesktop.org/lumag/msm/-/commit/a402e0e61b75
>>> [2/2] drm/msm/dsi: Enable runtime PM
>>>        https://gitlab.freedesktop.org/lumag/msm/-/commit/4e905c2acc9d
>>
>> Unfortunately this series breaks our CI, see [1], [2]. I had to remove these patches for now.
>>
>> I suppose this is either because of a probe deferral or because of having subset of drivers built as module. Konrad, could you please take a look?
> I see no reason why it would break things :/
> 
> You can see that rpmhpd sync_state has not completed, which means all
> PDs should still be pinned at max vote..
> 
> Can we somehow retest it?
> 
> If it still fails, can you try enabling runtime pm on dispcc and hooking
> up vddcx?
IIRC this was a fluke with the CI, can we retry?

Konrad
