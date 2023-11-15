Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782B7EBE30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbjKOHik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:38:38 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFF0CD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:38:35 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5bf58914bacso71990327b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700033915; x=1700638715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q1N5b4p/p13lbsRtP6IYe/M9cBHIoG53IIFCSkJ3nug=;
        b=iT90UQW40ncjhcZDsUHcFIbBixO8eDKDNFN2aRCNMmbCfYsRKCx4ucPTFNygcxuDsl
         /gDCBAtfB1vfYs3OlWxvfCbwDRXo+pNMtxoFOZ6mGhduo46N+O4R9uTdkUHwLIgTuV7q
         zWPlfjTq++IBNJYnb7SLwQ5JyhF9rHGMJBPiq56MckxCq+bd6nFmeNqUpZ5sR+goibvP
         WD55CcrsH+BLxEPIX5yjR1s2o/eJnXihcE6SZkJ/9y1ud9JStCwj5iYZWMoMyBfFuXvL
         BLPdopbGzS795Hr2X9Iu9KEVlQ8zKby5Cuhu2znReDIjBd/xvfAFsFkgd1ZzSMNEaUyU
         8osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700033915; x=1700638715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1N5b4p/p13lbsRtP6IYe/M9cBHIoG53IIFCSkJ3nug=;
        b=mLiWLFBFrF9aOlCkLomRedI65FoAMQFn4fLnHmPR1NuRgf37AiHeR3sUboYxeKlzr4
         VYSyFWLnX/iHLWgGhtQZId332IfvxqU1q/wJLENDdY8t5rhsiagCQP1gvxvfWPpN4Fxm
         yDjeBsrwRj9/VqDnYw/iTSsSf3RpXpAH7MgcJ+3XYoWyU+kozuZTlG/p1pTpxRdTYOgn
         ue3xrZKZCTfohpfFPPnhi9e2sxxm3xjAD1ryADBtrN0eYdP70nZEVhNFVoVI5HEHliFt
         mgVpVb9cNe2s8jKB2HifvLeM7hMme4d4xBOhLHao39zu9rjmt81/iHT/A4CkYWor/FjW
         NFmg==
X-Gm-Message-State: AOJu0YzvExYi4MOgjxkDlp/LgUmlm5+ILLDIxvxdGsN/a1PjNTCDXDfN
        2yw3zrBdt3AaWuGuLPE9K/J6/2sKSOC9/OXZFq21Sw==
X-Google-Smtp-Source: AGHT+IHjbgTefhGkY80NO9CwFz5yFYBdsK6NjwMZVNPorX5RtHxDYe0wL9z9xFjGN0NQqPY9WuDeHuInEdv8SASvykk=
X-Received: by 2002:a0d:cfc4:0:b0:5a7:c8fa:c620 with SMTP id
 r187-20020a0dcfc4000000b005a7c8fac620mr11860582ywd.0.1700033914825; Tue, 14
 Nov 2023 23:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-5-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-5-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 09:38:23 +0200
Message-ID: <CAA8EJppg=pYh73ncHBCO6Ddv9gG7+WNnpwLYGEv6xEu_3MRNWw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] drm/msm/dsi: add a comment to explain pkt_per_line encoding
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 01:00, Jonathan Marek <jonathan@marek.ca> wrote:
>
> Make it clear why the pkt_per_line value is being "divided by 2".
>
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 66f198e21a7e..842765063b1b 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -877,6 +877,8 @@ static void dsi_update_dsc_timing(struct msm_dsi_host *msm_host, bool is_cmd_mod
>         /* DSI_VIDEO_COMPRESSION_MODE & DSI_COMMAND_COMPRESSION_MODE
>          * registers have similar offsets, so for below common code use
>          * DSI_VIDEO_COMPRESSION_MODE_XXXX for setting bits
> +        *
> +        * pkt_per_line is log2 encoded, >>1 works for supported values (1,2,4)
>          */
>         reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_PKT_PER_LINE(pkt_per_line >> 1);

Should we switch to ffs() or fls() instead?

>         reg |= DSI_VIDEO_COMPRESSION_MODE_CTRL_EOL_BYTE_NUM(eol_byte_num);
> --
> 2.26.1
>


-- 
With best wishes
Dmitry
