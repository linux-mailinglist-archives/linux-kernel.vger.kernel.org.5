Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56598779400
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbjHKQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbjHKQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:11:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFE8271E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:11:38 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so33960861fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691770296; x=1692375096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9ZAMNQoymALcBO/YXbYxLOGCttwEzlATxN39tlKZ04=;
        b=fNa+PgzzPdYbITjpJAUXp2GrOx+clAFsasfMkdYezWUZCvAEQuWtSZBojr8jxVnvPk
         Ws9f8X/xizsi5nN1+T4MRBgX1rSG/elFH+a31SoIY1szS76XtAv2ELyWLKIzn10eF9TF
         niVOzRSzfP5oCnoavgevMwdMfF/Id7UhdURjMyS2rWidUDiA+R7sO8+BWC+dsHjEWos/
         KmqzadzN7CszS8nG2uemtr0heBYLt2vMmZdNjGJ2S4T9z7RqzgLI3nTT7lyC6czv+hgG
         00g1A7CaMMnfhZUMaSMel1nvO2ATsIyf8G3Bvf2Jz43UutxPQam8QUo6bf+2vlZKbPPV
         Cl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691770296; x=1692375096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9ZAMNQoymALcBO/YXbYxLOGCttwEzlATxN39tlKZ04=;
        b=Nw641J0TOCNc7exD9SsdkgSuc9eiTuDFCVFRiDpg+R4+es3ve51f4xcSRU0fcgs+dn
         G2X1UQhWvzEF66Mb7tNyYehSlJDMH3LUOKm+qQSqZypSi4KCUvbF0esPZj0GNDCe4I8g
         TfcgZyme4IYueyZRi6UWgmu71aEQKxk1Jfg2o0pdO8GEd2iPhnWGUMhCufZLEbTc0uBg
         BDUV1O83Vjmjd0nXFA1a3dV2zcbBN0t4CrDYSyCBbFd+CsLR92cdjoUS9TBKnilsbc9d
         +EZCx9xYcXgDvnLdh3YhjNFTRsf26VBt3yffl3BCM74ttpS4JDS/a/hyuxfTAyjQ2HIm
         oNFg==
X-Gm-Message-State: AOJu0YwzY7JMbxNKMaBMFtN7kUanLgwNr/CXVf/3xlVq79DynJZng2u7
        Q2np5qhle968FKhyzHTxOCviaQ==
X-Google-Smtp-Source: AGHT+IGD4iru4OlZyO5VyYD4jF4S5cGBNWpAly//GJxDIREQZP5T3IlLN48pB9ByIbg+DjpW8Ef/8A==
X-Received: by 2002:a2e:7c03:0:b0:2b9:e93e:65e6 with SMTP id x3-20020a2e7c03000000b002b9e93e65e6mr2003908ljc.35.1691770296329;
        Fri, 11 Aug 2023 09:11:36 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id l13-20020a2e908d000000b002b70a8478ddsm932084ljg.44.2023.08.11.09.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:11:35 -0700 (PDT)
Message-ID: <d400c787-3c81-4e37-b541-371d6096cf7e@linaro.org>
Date:   Fri, 11 Aug 2023 18:11:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a690: Switch to a660_gmu.bin
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230811160505.174574-1-robdclark@gmail.com>
 <CAF6AEGtNgCxsOLyF31=WCdag4Gb7+2FvFEvOWDcqd_TxiTeE3w@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAF6AEGtNgCxsOLyF31=WCdag4Gb7+2FvFEvOWDcqd_TxiTeE3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 18:09, Rob Clark wrote:
> On Fri, Aug 11, 2023 at 9:05 AM Rob Clark <robdclark@gmail.com> wrote:
>>
>> From: Rob Clark <robdclark@chromium.org>
>>
>> There isn't actually a a690_gmu.bin.  But it appears that the normal
>> a660_gmu.bin works fine.  Normally all the devices within a sub-
>> generation (or "family") will use the same fw, and a690 is in the a660
>> family.
>>
> 
> possibly this could be considered as:
> 
> Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
For a lack of a better response, "meh"

Other than that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Perhaps we could take this further and do something like

if (failed to load gmu fw)
	try loading "gmu.bin"


Konrad
> 
>> Signed-off-by: Rob Clark <robdclark@chromium.org>
>> ---
>>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> index 1ed270dae148..756a9cfe1cbf 100644
>> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
>> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
>> @@ -478,7 +478,7 @@ static const struct adreno_info gpulist[] = {
>>                 .family = ADRENO_6XX_GEN4,
>>                 .fw = {
>>                         [ADRENO_FW_SQE] = "a660_sqe.fw",
>> -                       [ADRENO_FW_GMU] = "a690_gmu.bin",
>> +                       [ADRENO_FW_GMU] = "a660_gmu.bin",
>>                 },
>>                 .gmem = SZ_4M,
>>                 .inactive_period = DRM_MSM_INACTIVE_PERIOD,
>> --
>> 2.41.0
>>
