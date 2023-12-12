Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AE680E463
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 07:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjLLGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjLLGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:41:34 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84194C7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 22:41:40 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5e176babd4eso11349337b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 22:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702363299; x=1702968099; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YKE2zuLzeQJDcIXSdKzo06j4Otoprc4M3hYEaOW4B8o=;
        b=w7CTmTsR4bBftceV6dA8o9SkIwdin5kWphWNg24ZoBmAmR3UJT9A4WvMa6uK1HaX4P
         d26/t2VWh4VUPiGw81pclF3ceFc3tLx8rQAxcSeRM7PFlxVtIaFhQvcRcB1bUp0ZTpzj
         btceeHcpuCt8srjtVGnZ0xfBj3VLPBeWZYfo4XAvnCL9wJ25qUD78GV/1XNefqNLTAsj
         ZZRSb5YmTMHTNsxjK0+el1NV6aRrlaRB1idcggDWcjit+hLxuawxybwPM6Qi18iTGsaO
         Y2NzRwy8lpiR2IVkMXrv7ZARqApy7xvLQOBCsx7EW1688WhNmUM2Kp3iyIlFTO9t6Sr3
         hZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702363300; x=1702968100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKE2zuLzeQJDcIXSdKzo06j4Otoprc4M3hYEaOW4B8o=;
        b=hHpkw+PId78zb37uz+MhMHMTxfqOjBzPQZvTQ5U1qUkWWIeQ+HHz8mYQpW8sLoXbx5
         JEkqtPWLse8h+rrhTk6qpPf0Sgaik8G1xZjZKWwS1dj1lFdvOZXgZfK1vU5ehJhDgaN7
         MK1vcsBOzKBvoGdNdYI+CZ7MaLPJV0PxrpovoLnDwszH36KkWwSzbP/WGoLd1Cy1IzT/
         k59wiZ5VkuGRkt/Y5Qb+7a7bTG2mNffa9ZBsCT/NiXWaFo1+LtJgr7SG8IW3iPqHrwsg
         uORlwzDQfPeYfr53RzCynWvbuAn/ADaG/rMQaO6DQeDVnwjmpzjjdjbb66p/Mxd8cXoe
         SR1Q==
X-Gm-Message-State: AOJu0Yx8KkHM9NImJOjpef5b0VCFL7+Nm9nYkU53ZWeI094J+inHyNa/
        EdjS8d0S1m6opUv6ta/KS+bsUm6rBYt37J0/5ThZ0w==
X-Google-Smtp-Source: AGHT+IHm3Elev5sOzSSZwb12FUilvp/T+04Oo2vDTg0/IFFD3ZcM1sD3HEd7qlZ80V9IQ6FD9RbDvwFmQqdbl1lMypM=
X-Received: by 2002:a81:8585:0:b0:5d7:1940:53c7 with SMTP id
 v127-20020a818585000000b005d7194053c7mr4579131ywf.63.1702363299778; Mon, 11
 Dec 2023 22:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20231212002245.23715-1-quic_abhinavk@quicinc.com> <20231212002245.23715-5-quic_abhinavk@quicinc.com>
In-Reply-To: <20231212002245.23715-5-quic_abhinavk@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 12 Dec 2023 08:41:29 +0200
Message-ID: <CAA8EJppjMhqJM8svtFECPJHRYvG7uSY6GB=Qe04q4hCQRNQZjQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] drm/msm/dpu: move csc matrices to dpu_hw_util
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, seanpaul@chromium.org,
        quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 12 Dec 2023 at 02:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> Since the type and usage of CSC matrices is spanning across DPU
> lets introduce a helper to the dpu_hw_util to return the CSC
> corresponding to the request type. This will help to add more
> supported CSC types such as the RGB to YUV one which is used in
> the case of CDM.
>
> changes in v3:
>         - drop the extra wrapper and export the matrices directly
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h | 30 ++++++++++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c   | 31 +--------------------
>  2 files changed, 31 insertions(+), 30 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
