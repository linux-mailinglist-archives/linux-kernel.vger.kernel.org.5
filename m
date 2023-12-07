Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87D1808E65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443023AbjLGRDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjLGRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:03:00 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F8C1708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:03:07 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5d77a1163faso7879137b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701968586; x=1702573386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGavWJn3BFskMXePj8G/Gc7zkKDdmqreyDRTVCoA6Wg=;
        b=tzhsdZt53Pilc43ombspsat/1H/XDEHaxgmBs0PvPDtLvUOjabuRf8zD121xPX2o6K
         u1Dqb+z+8knUXY8FjpB7awzCOT1UvOsPEKflAxYa++5tIh+rf9g7DwauL1dLdEVJHpq9
         RbtFyScBYxKdo7HF4r0+5KHl7d8YJto4mNPHpd8riTiJzKFQnNU3G6N9r8+amOpqUsl1
         OR/zu3QWtM0RHnKxMLvavkkyoLRv9tA/INkAW8tGylF/Fcelic6Q3Wqss0tJ0mPFlcHZ
         yKhRJalXKfJeYptKR5SIiS/q0CM9M/4kwyTl5Qr1zBLPiOayRC5yjzUBEWJ0wmeEgC6+
         Lf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701968586; x=1702573386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGavWJn3BFskMXePj8G/Gc7zkKDdmqreyDRTVCoA6Wg=;
        b=nltw97JQgvcUSqtnBdWzlvpRRBK9nh+AnXbuRPh+XShE3yblAWsqLn9Y+YENFzperR
         TALbZVcHLzcId7XABxPtyRES6auUjpa9omNNxcMRAUcr3DwuqpeC0mYWlzx8gkk0Qsl/
         ly5JJYEx7pfmPywC6ERQLWvRCPUS1DkvJ3ihgvyANBZg0+Ikb2vqAfJjSU1PECuPVQmO
         TgWpvwSKQgVzI8tL/+FrU6/FNVKXjSOoWjrDCvkMNbhRJngF4AbUN9R6hl6Mhr3v4i/H
         v5c0uYiunyZEhN6ePXgPKv8x6mrylQ3ziG/WKWe3zz8wEzGhgEzB85tzqojbHNb+hd/r
         Usog==
X-Gm-Message-State: AOJu0Yy8sbSKOt7AJzHoos0uHXeOLFjPhIlUNSCXoIUAsd4/nRvdfV1C
        oI9rPVNayGNdlccv4uXkRY3WMOXvAi9GWUifunr6/w==
X-Google-Smtp-Source: AGHT+IFi1Lw+dYQG5rp3RmkzlgCLipb19CQiXyiuFQHGeZdsmEG6DXb3riJxACss4LeAc2sE3dJFU23/biQpd2Etzf8=
X-Received: by 2002:a05:690c:2b06:b0:5d3:b71b:4d30 with SMTP id
 em6-20020a05690c2b0600b005d3b71b4d30mr3163725ywb.17.1701968586143; Thu, 07
 Dec 2023 09:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20231207-topic-sm8650-upstream-dp-v1-0-b762c06965bb@linaro.org> <20231207-topic-sm8650-upstream-dp-v1-2-b762c06965bb@linaro.org>
In-Reply-To: <20231207-topic-sm8650-upstream-dp-v1-2-b762c06965bb@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 19:02:55 +0200
Message-ID: <CAA8EJprskAYWm6M_yOOmUEHdWV9Ot3_VBxo4MtPYDKBizPHyuQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/dp: Add DisplayPort controller for SM8650
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 18:37, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The Qualcomm SM8650 platform comes with a DisplayPort controller
> with a different base offset than the previous SM8550 SoC,
> add support for this in the DisplayPort driver.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
>  1 file changed, 6 insertions(+)

-- 
With best wishes
Dmitry
