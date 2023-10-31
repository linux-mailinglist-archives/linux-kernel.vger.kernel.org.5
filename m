Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93177DC80E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233492AbjJaITy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjJaITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:19:52 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300CDC9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:19:44 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5af6c445e9eso45105387b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698740383; x=1699345183; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=78zyyhOvPbqFiviMdoByxBcrmsePwBi34jIz0gyHXvM=;
        b=haCwmk8sutEtWA7xGtH7IVyIJgEhII59qNgbqeXER2VUeFYTrjloN2RcHEC1PWxS6G
         u3g7xLg/jzarky7LKWqKY+BhRAnrKt76EQ8y/2nK5uUmDt3wAqpytJUgeXcX5zVwdVo8
         T+4c2dKwOORkD/UCakUS/SSxq87lCdZj7seH+HtZctLD/PxAqedNBIe21j9arD/uskEt
         95I8sHK0WZgFzha8tWM24L78QuA5RlIqLgovITtOecYfsbxBWUFonUaLhI/epGLcIy3s
         1jCQEX85bAkE4uf+OM7awRzgZpkkvEQtkkkDMKMbJ9aEs82l5K4fmdYELirOdbuUeK2t
         xn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698740383; x=1699345183;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78zyyhOvPbqFiviMdoByxBcrmsePwBi34jIz0gyHXvM=;
        b=fZTkPMxObMW0n7j/B+MIAqNKLKghlPij9dErnFUmAsbw4pQPk2snLCKB/yeLuFWeua
         0ZdZrNCQNdtAVWoPjBgELWw6ylsy2QemW0uk531zVquXVaMOtSwadTF2gw44j56wle3x
         LE/+krGLS5ZEVxPySKoSGlEq2lxnU0ZG4FZ60/TYbzPgKR4KhDnh5HljNP/hAcJPz/Z+
         S9LlZFLrW3FBh93YMzPju71ORFkTDO3H3HZaO1t4ykrRHESdsrJjcCQTLtOtvS4ECddY
         V/b2BW0oo3qjexY1r1qiqKIop/OBng/SR6GqEqCS6Nqbdv4cMi76/ytjJNAFAMeWrxEu
         dmOA==
X-Gm-Message-State: AOJu0YyYlTXlxHNS0XVQGt/yJ725emQyEO+scFZc6+8u+KeXIAt/w+UI
        55C7I3o/yowd36I5Rt29bzcy
X-Google-Smtp-Source: AGHT+IHfHrgScUqqG+ilU65NVBGwpReFaZrWGtTlMbg3rSDabDCKMvqmWMYSRcTOVsok1aO8JSa1PA==
X-Received: by 2002:a81:e703:0:b0:5a4:db86:4ea8 with SMTP id x3-20020a81e703000000b005a4db864ea8mr10248096ywl.31.1698740383266;
        Tue, 31 Oct 2023 01:19:43 -0700 (PDT)
Received: from thinkpad ([117.193.215.92])
        by smtp.gmail.com with ESMTPSA id cs3-20020ad44c43000000b0066d15724feesm330713qvb.68.2023.10.31.01.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 01:19:42 -0700 (PDT)
Date:   Tue, 31 Oct 2023 13:49:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>
Subject: Re: [PATCH] drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog
Message-ID: <20231031081931.GC11778@thinkpad>
References: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030-sc8280xp-dpu-safe-lut-v1-1-6d485d7b428f@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:23:20PM -0700, Bjorn Andersson wrote:
> During USB transfers on the SC8280XP __arm_smmu_tlb_sync() is seen to
> typically take 1-2ms to complete. As expected this results in poor
> performance, something that has been mitigated by proposing running the
> iommu in non-strict mode (boot with iommu.strict=0).
> 
> This turns out to be related to the SAFE logic, and programming the QOS
> SAFE values in the DPU (per suggestion from Rob and Doug) reduces the
> TLB sync time to below 10us, which means significant less time spent
> with interrupts disabled and a significant boost in throughput.
> 
> Fixes: 4a352c2fc15a ("drm/msm/dpu: Introduce SC8280XP")
> Cc: stable@vger.kernel.org
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Suggested-by: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> index 1ccd1edd693c..4c0528794e7a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> @@ -406,6 +406,7 @@ static const struct dpu_perf_cfg sc8280xp_perf_data = {
>  	.min_llcc_ib = 0,
>  	.min_dram_ib = 800000,
>  	.danger_lut_tbl = {0xf, 0xffff, 0x0},
> +	.safe_lut_tbl = {0xfe00, 0xfe00, 0xffff},

What does these values represent? And how SAFE is to override the default QoS
values?

I'm not too familiar with the MSM DRM driver, so please excuse my ignorance.

- Mani

>  	.qos_lut_tbl = {
>  		{.nentry = ARRAY_SIZE(sc8180x_qos_linear),
>  		.entries = sc8180x_qos_linear
> 
> ---
> base-commit: c503e3eec382ac708ee7adf874add37b77c5d312
> change-id: 20231030-sc8280xp-dpu-safe-lut-9769027b8452
> 
> Best regards,
> -- 
> Bjorn Andersson <quic_bjorande@quicinc.com>
> 

-- 
மணிவண்ணன் சதாசிவம்
