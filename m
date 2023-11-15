Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A737EBE0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjKOH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:27:07 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E829C8E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:27:03 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-da819902678so6623015276.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700033223; x=1700638023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LI+hHZDGsrVLiENiIy3H+HbnGc5/Pj6x1urZCnZBE0A=;
        b=spmse6T7H4y/R88xcfBAML8JUIp4Q1ZF4yUW97y88txZduH/1j/Q+QDFgTsLA/Ofdh
         kzxCG6GRgEsDT+NGL/iDWikV4LPbp2fzcw7ezgKtTLWC5SsYqkbGAdroF9nDsXEuMH+u
         WswlXBmWQYY8kSKZaZMMQWNtY1nMMOObiX/jRrpVlVisguvLkgBIEQJ+2iSQM2Ef7MKC
         1amTeCZsYsIkIWsj2PyIUrXcaUP+u2OAWuuDC1Q4fS1FX6lcu2gqghibeQxmGSP8A0ro
         hr6gXq1N9LlaX43KZ7FJRL7GUn4vLfF1gqd/glQynmB2sgxNHmgByIx2KeCTHU7yQa2P
         97tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700033223; x=1700638023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LI+hHZDGsrVLiENiIy3H+HbnGc5/Pj6x1urZCnZBE0A=;
        b=sXlSRsHwDHZ2pDMIu+pemAp/Tb0Ss2tPiPSDslpYweBJIjs968lc5BqtTB64jclRjr
         U2H/JAl7jO98UXvZP/2Y30fwTFcZwMxEO8b5IFk0g7jvlKXN5EYgkfcLiurdLyPdbBBD
         pWMx4Hk68i/Io2VVHGyw9RnFr95RT7OHSgCnKyAWRXLEtEv9QUCR4pA2Wjv9ap/M3Di+
         lUyiBX4rg+UBUUhrTY/Db9yqRAtkMwIqF0AWNtjYRLLlqfoJrzfIsuDPWSvgo5zVkT3W
         87GxwVSiFDeEwkl0wCmxop67Y7lBzIzrAcQwTpEcpPW7dqpbCQUvxMmsaau2Fo4bk6Mi
         +Hkg==
X-Gm-Message-State: AOJu0Ywu4EeXdbJLjCm23XbJRwt/lymR+M9lvygKsiYxaLuCkK82d68l
        KNNVQinR3+ApSPZoj6stYfqORTZUxqL4G0Xmp7dybQ==
X-Google-Smtp-Source: AGHT+IFg14cjgoXzSIT4pD+JIPGzFocy5oWeTNMHBVe/p8YI7kp1xT3oW6AV6W2ZE8rVTAhJZNFOUYyiR/qUPm+7sR0=
X-Received: by 2002:a25:25d6:0:b0:da0:6876:a8eb with SMTP id
 l205-20020a2525d6000000b00da06876a8ebmr11431431ybl.46.1700033223136; Tue, 14
 Nov 2023 23:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-3-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-3-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 09:26:52 +0200
Message-ID: <CAA8EJpq-bdb_ue1LAXjM+TH97os4eeHyUeNy+51wh44M_J2TKQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/msm/dsi: set video mode widebus enable bit
 when widebus is enabled
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>
> The value returned by msm_dsi_wide_bus_enabled() doesn't match what the
> driver is doing in video mode. Fix that by actually enabling widebus for
> video mode.
>
> Fixes: efcbd6f9cdeb ("drm/msm/dsi: Enable widebus for DSI")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi.xml.h  | 1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.xml.h b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> index 2a7d980e12c3..f0b3cdc020a1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.xml.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.xml.h
> @@ -231,6 +231,7 @@ static inline uint32_t DSI_VID_CFG0_TRAFFIC_MODE(enum dsi_traffic_mode val)
>  #define DSI_VID_CFG0_HSA_POWER_STOP                            0x00010000
>  #define DSI_VID_CFG0_HBP_POWER_STOP                            0x00100000
>  #define DSI_VID_CFG0_HFP_POWER_STOP                            0x01000000
> +#define DSI_VID_CFG0_DATABUS_WIDEN                             0x02000000

BTW, could you please push this register to mesa?

>  #define DSI_VID_CFG0_PULSE_MODE_HSA_HE                         0x10000000
>
>  #define REG_DSI_VID_CFG1                                       0x0000001c

-- 
With best wishes
Dmitry
