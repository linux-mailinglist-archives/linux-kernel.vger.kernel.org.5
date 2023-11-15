Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC57EBE28
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjKOHdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbjKOHdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:33:40 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAAB13D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:33:32 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5a82c2eb50cso67470227b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700033611; x=1700638411; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FOA8cwIAyYlR65wDteBKmBM81DRgXu6MSA3Hl45V4Y=;
        b=ctFsyR7hPgeP33E5FpKYqxNfMZjPwJJm6Tt+ptjM29/78aJzfgM/iS8nZ62e5Coa6W
         5w73wgko7sL3GST4iIOUAFU1V5iXv1jOV+1+TlvDjFfX68Q4Wtpyx13JqTZWup13SOOG
         PwRjrfyX0EQTKtz5KBsFYbuxmBBA6301w/9x7IGOInvw5QLdXDkMkNVc4xV+MzrpcYgY
         HKsH3Lz3DIy6Yln6sbodDi7hFvNeumN7d0eoYy3VcfXLAd8egvB43wSoxZI6uTFkQEPO
         pMh0RMJHbnfQCY1pME08nJYYVOTPM9qhIIefY9lQhe79DWey6SQAqPRS3iO6sFD/envC
         QPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700033611; x=1700638411;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FOA8cwIAyYlR65wDteBKmBM81DRgXu6MSA3Hl45V4Y=;
        b=bCEOC1GEZM4riNBv809XAf0XZ5cYXB105GxEzDll/qpC7kgeh+OOFg9hsSlbAVGfET
         HZxVVY1y8KdrOjPRykrV1pCt2mClB1PnAFFUrjjDjZ/bDtKjX6aG4TrI1+JC86KS69LY
         iQn1ZUMz5FkFZ6K8RL2FoSBl9UaLrhK23+Z7lxu8xkjpVZe3d9cjI5HavK+EP9A2oYyh
         vaQMrP6mR4fcrxT8sMIgM+//u7xEEgCouqYWw/u6TBsR+kKDkdq1MMCVprFWVdaw4l+E
         Tlq67m/6jQLGmGJpWnkjy8XDzqmubmoaD+5L4AZQCLzc9EwdP38bu5iNLoM49Od5YSQJ
         6lBg==
X-Gm-Message-State: AOJu0Yw2ojHcV+rfhVAX0us38D1hziUCSuqjBwfZkKxFfHLmGQPHYEBi
        aypUjDMl9pV3p44gttjU3uudhHsd/XACENYP79tHDA==
X-Google-Smtp-Source: AGHT+IGaoOYs+bd3ICE+icrHuNJQ+wn0eLONRAaiZI9vHUtjmK/ZBgnbAWkr+eRFLcDJ4ik1mFWd/zZtJNuRPE2VUow=
X-Received: by 2002:a0d:cac3:0:b0:5a8:187d:d5d5 with SMTP id
 m186-20020a0dcac3000000b005a8187dd5d5mr10457931ywd.35.1700033611715; Tue, 14
 Nov 2023 23:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20231114225857.19702-1-jonathan@marek.ca> <20231114225857.19702-4-jonathan@marek.ca>
In-Reply-To: <20231114225857.19702-4-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 15 Nov 2023 09:33:20 +0200
Message-ID: <CAA8EJpoXF+DtVxNwK1Lr6WVzTgoGGKybzeOQ384RYyT71Zdksw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC
 (fix video mode DSC)
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
        Vinod Koul <vkoul@kernel.org>,
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
> Video mode DSC won't work if this field is not set correctly. Set it to fix
> video mode DSC (for slice_per_pkt==1 cases at least).
>
> Fixes: 08802f515c3 ("drm/msm/dsi: Add support for DSC configuration")
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

--
With best wishes
Dmitry
