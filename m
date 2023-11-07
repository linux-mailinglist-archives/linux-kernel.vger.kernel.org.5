Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E97E32C5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 03:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjKGB4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGB4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:56:10 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E11111F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 17:56:04 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5b35579f475so60337817b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 17:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699322163; x=1699926963; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qRdFl5udOcDDgpUUHFmtzTJy5y7ihwibQnaHgGQmu7k=;
        b=BZFblLgjjM8OPrYN1LQG8qQwUVwf1K6prfsGbAy4Bhzm8h+623wqk2iEmra2LeDRLe
         0hIOjLbH+rlPSWP6psoPUqmwG/ubWml1CUtslEYTcFiiv8b5PYZSlBfIbdtVfRa0hsxm
         v2oymDSdKZXJuZH2AAB1/Ov2Uepwti+X7H++7YNazEaqbxY6vK2m2vTi4qvsMnunH+/j
         9dbEMsxQpbgXCiIm2fPH6dBoCHU75yR9WJOLPHgwwFfPGkCrnhXPSr3idkcnD5hMqVxr
         pq5K4Qeq1R3AW2jMycFL1w58bExHzcxhpaD40E5JCMFY/TAOmKGNTUndfSYyPZse4Jzy
         yzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699322163; x=1699926963;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRdFl5udOcDDgpUUHFmtzTJy5y7ihwibQnaHgGQmu7k=;
        b=I2TBZ3vtizJnAV/Q2r7cow4lHuGVeIrETQ0sn7fqN/Q0zGVx91aYoBa77Zgngma5h5
         8spnCVh09hepLANRTcmpki6Kak0ba3/VUWCPN7rqNMtw5LOc9ect9ONWWWVv0q3FRlSL
         wLTGn6ftbypEDfN8Luev6q6I2zjtuy6YKKEoyShFTHDk0lVYVR34Tgb5t39e4VWcbk5Y
         s2T3NbpCc0WB2KUcDUga2K6hPYzWlQ08v0fm4sRB+vfRVJnOobPHqFhrGyypVGPx/vqZ
         dZwGfQ1tybx3pb18HxtdE0X2vuefpoDS/H63wsGvXMoQ5raNYqbkDn9mKomg4b7ayKC9
         ajfA==
X-Gm-Message-State: AOJu0Yy6XGdnGARj2nU45CCeHHZTzZbDQnd/KN1SBYYWtjLo3/t3hbH/
        z0YTz4VZxABWP8RaBkHSL3Aw2Huhz5i+XfSnXInn/w==
X-Google-Smtp-Source: AGHT+IFtN3nj1SFB8choYmUK6+L0wPLOEXRz8UqI3Ocfv/fDkJmkQoE2qADkYCuPiioo32CihjU/UeJ2DjK7I3fYw4E=
X-Received: by 2002:a81:9a54:0:b0:5a7:fa8b:3fa6 with SMTP id
 r81-20020a819a54000000b005a7fa8b3fa6mr12601421ywg.9.1699322163303; Mon, 06
 Nov 2023 17:56:03 -0800 (PST)
MIME-Version: 1.0
References: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1696632910-21942-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 7 Nov 2023 03:55:51 +0200
Message-ID: <CAA8EJpoFRp+7GyO=F3Ar21tfG5Yt0cL6zkAquqg7D1XXQjp50Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] incorporate pm runtime framework and eDP clean up
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023 at 01:55, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> The purpose of this patch series is to incorporate pm runtime framework
> into MSM eDP/DP driver so that eDP panel can be detected by DRM eDP panel
> driver during system probe time. During incorporating procedure, original
> customized pm realted fucntions, such as dp_pm_prepare(), dp_pm_suspend(),
> dp_pm_resume() and dp_pm_prepare(), are removed and replaced with functions
> provided by pm runtiem framework such as pm_runtime_force_suspend() and
> pm_runtime_force_resume(). In addition, both eDP aux-bus and irq handler
> are bound at system probe time too.


With this patchset in place I can crash the board using the following
sequence (SM8350-HDK):

- plug the USBC DP dongle
- run modetest at any mode, don't press Enter yet
- unplug the dongle
- press Enter to stop modetest

=> the board resets to Sahara.

Please ping me if you need any additional information from my side.

-- 
With best wishes
Dmitry
