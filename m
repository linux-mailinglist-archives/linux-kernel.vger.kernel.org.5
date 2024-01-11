Return-Path: <linux-kernel+bounces-23930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1382B40C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1984528611E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6979524A3;
	Thu, 11 Jan 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmjr8Exr"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0A50264
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5f15a1052b3so51217907b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704994056; x=1705598856; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwX+Q8u87YRBeqp+9doFk/KRGXo5yTvV0ztJoK1gxhA=;
        b=cmjr8Exr9t4/hwhLD9gbLaTRyekJkiLl8LgvVj/EmAlJdrFul+YObDIecW6o+tWdBG
         zGCJqYIKY+FUZufT6YMWZVm4m/26pGDIbGwVD/ltT0SiZxUiv56YOLr25KKD1cCVr6qB
         6iqyEXAzHl4+mcjLO1xitkxfs779nIvk/aqatH5URs3k1sW9CTUxhw8OpxcLdsdsbZkk
         yYqegNzpaIWBMT04b0vK7/HsQlMafJKRW3UeBNy7AOz/UZAS+csXnDM8UOv8+aOdI6kx
         vG2tUTZ/KEHXxCaFAnWfBCLyDIs27fbK45CwYaoqT6C72OSgRsJSE6CFNmKCK3Lk5Oxh
         E9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994056; x=1705598856;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwX+Q8u87YRBeqp+9doFk/KRGXo5yTvV0ztJoK1gxhA=;
        b=J1Gouaihz5ULaCJBt2YtWg+HKgGr1Qlx0FgaVtoHn82qj84NyUduYCGuZOAIqG/VoT
         a3KQlkSzKLMptNwhsCGnRUIjJgu1P+ycS+7pQ3qWf9tZehl2hCd/439Jqq9IQp80TJtC
         CNtTWTKU8r1UjXT//wAI3n6z5nCIteCXJZUYAuLEYVkpD8ei3rIjuTbF3pNnkZqMxYgX
         1DLPsFBJ+/APmyveGvot8koTstQp0Y/rbQGajlRCA0LaeL6mNlHidZrmKRJQDZKDmmIz
         pDI1Q1qFbrHYj/JdqgLfVzb1xcXcKqKZnYINZsVSGu9e/rPlutkMWIVJ0M9molluBNc1
         EgUA==
X-Gm-Message-State: AOJu0YyOom8P4Ok8bheUt0qtO0q6KXizXGtUV2kj+bqqqfVI7VNKH7mt
	ISta5Bn8XmdhnhPI++VLHSa6ACJEhDVBTTEhEImqqqxuxtJPTr8Hqo0vYTieygJ6H64a
X-Google-Smtp-Source: AGHT+IFXacy54wlB2/avVyvlqWPg2me5MG2fUSxjyMqNRuv2t5PPokTTThra3Y7tS7jvxnp1hqWagKKX50vYF3/UjZg=
X-Received: by 2002:a81:bc12:0:b0:5e7:5cd8:92b2 with SMTP id
 a18-20020a81bc12000000b005e75cd892b2mr114924ywi.69.1704994056560; Thu, 11 Jan
 2024 09:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704993255-12753-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1704993255-12753-1-git-send-email-quic_khsieh@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jan 2024 19:27:25 +0200
Message-ID: <CAA8EJprHVbPv8ULK3mRPXGOFbuCQ6sw+r68uhdfCe8=E5=YkAw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msm/dp: remove mdss_dp_test_bit_depth_to_bpc()
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, andersson@kernel.org, 
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 19:14, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> mdss_dp_test_bit_depth_to_bpc() can be replace by
> mdss_dp_test_bit_depth_to_bpp() / 3. Hence remove it.
>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c |  2 +-
>  drivers/gpu/drm/msm/dp/dp_link.h  | 23 -----------------------
>  2 files changed, 1 insertion(+), 24 deletions(-)

Thank you!

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

