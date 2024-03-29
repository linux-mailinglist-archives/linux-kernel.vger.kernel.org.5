Return-Path: <linux-kernel+bounces-125283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B289236A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD621F22E59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1739FFD;
	Fri, 29 Mar 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baXQHGmu"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36012770B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737360; cv=none; b=r5EqoJPzI7nAhDu/+6ndas1qdr2/8HsLoaoFHRFKDIBvab4HKKgaKlyIv4lNtQRjXITqLBfZkM+akExhu95zhLT/ci8Uk8Lnbv4Kd8fWNN6zM2ihsJak+l63aWMWvX2ID0tf211VkAByelkYNa1q0iMlkuvTsaYv2GXxpB0QXp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737360; c=relaxed/simple;
	bh=PUnyjfXXPF54h7ZF04sgHvTy7l4JjKQESDtGtP1iwdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjmgqW9E3PEDHoqPY2aVHTLAz7frBhW7/4480pvYtN6Zzkh9vi1OfDp4WXzXckNhdNOEl4CmLsh1YDyMsDNhKea5o2L8oxP6zmuhI2S7KSSaup6jBX+GAwMzZsaCveJk9VPOetrdmCGhR3sh77vLrZB9Kpo4PE0VyQykIt5isMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=baXQHGmu; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6144369599bso6207947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711737357; x=1712342157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aHkx7Y32QoW56rz0JNMHjO97URPHnDH9wV5JpFER38E=;
        b=baXQHGmu8Rwgvp69XdbWZuF0wiL8DgcojkAy+cP+pRq5wbvypzYmzg4HG1nsrhWlDv
         2kY4HriwHn3fm1OjuHVX/RWVWot/irXjHFX1hnHpOO74KcUUBoI59m6zpqAy0xOR4HRh
         t0FdYvTIFVa1/jznovcF4TGJmXljHFhUoK5mhZkINu/DADF8Saelxpw/wZ92Jf7YQ7KK
         bsiusV/EteqhRYHPI2w6y0DHr5Ys1sDieoU5unM2jZR5MkzgaA7DfIzAnXU/oWRKnuN7
         cqgFHVsMhldhtKvlHPNhyMi3jaMXKyJO4nw4ugAVsNCcLUZHomxqZNYOTeEAtJ5XMG+L
         10ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711737357; x=1712342157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHkx7Y32QoW56rz0JNMHjO97URPHnDH9wV5JpFER38E=;
        b=hezC83wNrLD832SOirrx5bETsHg3JZ5gj2GTmVsHOIgujIUA96s4TD+YWsJcBiluYB
         lMlysstP91U45rWyGh75eYd/zQj7uYax1ehAtS1govok9cAOHx1mVAz2LLVDrsHWYIIX
         1ht1qZWaKsMhBG+d/XrN0K0+0msJDom+zlNR5lqIfVvPBV5AYcqNXNBDvtwA3UGeZlNg
         +ILVIpUuaF7ROoOdfSwA9QH1EEUfSTcBNWwgLF1yfhfsZSO38E/7Lv3HdGj9x8PZSly3
         bDj66l/eBpQJ41BK9f69+airUhYtj/rUOqnB1bwwS4Nn30TSPRzAOVz1c6lejVeQWJ4K
         434g==
X-Forwarded-Encrypted: i=1; AJvYcCWgmmhIgIzTMiHfyPNUEZ/VBt0zkhqjLpdfCl7ePf3JPgL3RW/69A57ONRli0q0YJmbfFhJiIvTSjYuBGzC0RN+HVIBJNsOyGV/ZjNN
X-Gm-Message-State: AOJu0YwaZ6JAROj08F7Zwi5STpx6tru7IZ2XfpJITRBdprKOHEUfoEj9
	snWdNX7uNzvKD+oeBgB1p8FKSKa2RCvCNqI5fmufjMZSGJBJ3FqnHNEvVTgJC51kD+xuT7eNFK3
	sqXT6aK6XwG6UXxuYDH02Bj24IHgJCHEXquD3SA==
X-Google-Smtp-Source: AGHT+IERevB97IF6pH84hlBH+caFIrkRJzR3o4Bk7fPLKGsiOONa8kVzkW96kXFtazpyF80yhz0+Wdm8wZl5aBtqr10=
X-Received: by 2002:a25:4903:0:b0:dc7:1d:5db4 with SMTP id w3-20020a254903000000b00dc7001d5db4mr2911776yba.34.1711737356997;
 Fri, 29 Mar 2024 11:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711730896-16637-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1711730896-16637-1-git-send-email-quic_khsieh@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 20:35:45 +0200
Message-ID: <CAA8EJpppQSTm7fH5fUXef0gdc-+zeKfFGw6uF1j8FJqBMySFjQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: assign correct DP controller ID to
 x1e80100 interface table
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, abel.vesa@linaro.org, 
	andersson@kernel.org, quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 18:48, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> At current x1e80100 interface table, interface #3 is wrongly
> connected to DP controller #0 and interface #4 wrongly connected
> to DP controller #2. Fix this problem by connect Interface #3 to
> DP controller #0 and interface #4 connect to DP controller #1.
> Also add interface #6, #7 and #8 connections to DP controller to
> complete x1e80100 interface table.
>
> Fixes: e3b1f369db5a ("drm/msm/dpu: Add X1E80100 support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

Changelog?

> ---
>  .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   | 34 ++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
>


-- 
With best wishes
Dmitry

