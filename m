Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E601A77011A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHDNQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDNQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:13 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE534EF5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-584034c706dso22571677b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691154874; x=1691759674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D4FGrRKKqr6fNENlJ4HUuscXPUM5XRYzhDK7WNtt/9c=;
        b=Mrg4Xr5v0lFTFocRyHHEc/zy5oeKvOxVeaf08lVJ7qOu9G25xP8Yl2opzmsjEGYjsW
         0Om3zPnCCY0EABOYWclpfzyb+ZiGjyUErocqO/LbH1SMmdC1cHvm0nefne0a4NwzTe3o
         ue082SJuCjExtQm7w3FilO5271WrroN8Tr/rEi0ohb4LtN6m69c3a2n96V8XNIyxBUx4
         tlauYnDu6Qi2QCQrDTUpc4Zi2ML5ZWE3rse4yDzvKi8Bn7tARoEZpjPHp9q1TR1d3WoE
         nkAXfDqMUV7FVUs6eeffv5TVKg9VO3vYmspm+FS25ZPGsZV5vLgpC6mPw4o9Th0llI1s
         HipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691154874; x=1691759674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D4FGrRKKqr6fNENlJ4HUuscXPUM5XRYzhDK7WNtt/9c=;
        b=YsOzxrh1IOe6BcICWZ4+vk3gfC7x35xriCzp8ELgEo+T3fSTSHJwdPySsR2aG4NVvf
         nuNnUSGhvgvdyMYB+YoqzhDDGK1wKaYwbu+4Mp4kfCwYYlrdaAeHnfaPk1zb24BsvmuA
         FyhO39QIJaXTijF0eGIBo/EoX9akiQabH4xw3yMNjFmGmRBLbtUfNflD1FisJeka4N79
         yzcOZUxIIiTXALPe8Nf4L/xemiSFZgWe6UhaSuZBggOSZtMS3IRVE87kV4gmS1nV7o3R
         5k7ROutz+pvS7CE04Z1sHQ0xsIA+W+bjdHwF0lf1/TxZhxACiGPXDBElaw69TG24KJJv
         NGTw==
X-Gm-Message-State: AOJu0YyY2Fz72yjc2qwx/o/yzPCoCPPVEWHFwIGwFBPGn0fbhZpv/Lx6
        KYfG6eqNjsVmj0GRekQHvxGp6hOv8LNqWDRr6OdLZg==
X-Google-Smtp-Source: AGHT+IG/YtX9++/di3aekXINcH9r4zmIZn1VPvqr+jVi9AWhqoV2uRrOWWP2zNSUOl6v7/OqmARiYdzthQYNo4Bm61c=
X-Received: by 2002:a25:29c2:0:b0:c62:2320:2598 with SMTP id
 p185-20020a2529c2000000b00c6223202598mr1173682ybp.62.1691154874341; Fri, 04
 Aug 2023 06:14:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230802-encoder-cleanup-v2-1-5bfdec0ce765@quicinc.com>
In-Reply-To: <20230802-encoder-cleanup-v2-1-5bfdec0ce765@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 4 Aug 2023 16:14:23 +0300
Message-ID: <CAA8EJpp6mijmo2A5xn2aG2PwsAh9mr0v3+ruDgoqLKTawme-xA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dpu: Drop encoder vsync_event
To:     Jessica Zhang <quic_jesszhan@quicinc.com>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, quic_abhinavk@quicinc.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 at 20:01, Jessica Zhang <quic_jesszhan@quicinc.com> wrote:
>
> Drop vsync_event and vsync_event_work handlers as they are unnecessary.
> In addition drop the dpu_enc_ktime_template event class as it will be
> unused after the vsync_event handlers are dropped.
>
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> Changes in v2:
> - Dropped dpu_enc_early_kickoff event and dpu_enc_ktime_template event class
> - Link to v1: https://lore.kernel.org/r/20230801-encoder-cleanup-v1-1-f9e37fe27997@quicinc.com
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 65 +----------------------------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_trace.h   | 23 ----------
>  2 files changed, 1 insertion(+), 87 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>



-- 
With best wishes
Dmitry
