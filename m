Return-Path: <linux-kernel+bounces-73797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B785CB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93C1DB23141
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F19B154450;
	Tue, 20 Feb 2024 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfMqzgW1"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D71154425
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708470068; cv=none; b=tVKxXhjszx/LNhFgcPOpZXmWq8R+R7QFN35jIb2nisBxnSDmDczvwVkLZScPxMBYaxgvzvNcLMm1FRDAeNrIabanDafh2f2BEPxsRrizAA2+dsiTNH3SjkvXLeEYjzM4KDLQyB9vLf26niowVsgguoSeg/ZqE7UNUonc88aesKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708470068; c=relaxed/simple;
	bh=ZH1Shcw7u15ZCG1t+CtfsAPJrxf9hlxF4UYzNdDcnpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqJBsjA/3sUZB+ShmTQg85ivIVg1549Km64aNtW7+2p/0is9k7LPIUCSj6bB5eqkAaMH7sUOOaRzl33CDyTkhWHRYvj5VIIoMyUtMhi/eTSYioBwfwj/DJ97wlBJEeol4nqXmIjlbH/G57MGY1uEx/0F4UGqLCBA3/0vzwfIzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfMqzgW1; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc73148611so6909944276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708470066; x=1709074866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U2fn3Q8ysQNGsP4/bFdrwVKI00s9RBc5Vo0obuiYfWE=;
        b=QfMqzgW18qcN/x/LbG3APkh8Vk+cs0hverVKQw72SfRnKZqXe93r88Ju5vqPGEX1NS
         QiFgYzy5wuu7Z1/udjIJYU2EJxbUAkCNH00dfeU9tJx/zumvz2duiGTMBd3hxo1qbapZ
         sEwVdCp5PqAqO6coaJglrMEQ71GkeDjMmUv9P93iZvpYD/SrC2difZJkkNUSJE25z+tw
         e9ExfuPKFMtGU4HKKv2Cv7VPJeKa7mWjZj0XjdygqnZzCCoS/i//5m/VzvOC+NcEiFdA
         tYJm+8UfK44aBj0duCAC0g6f7yUlOk798V+SrJ8zSeEnH6Gl8JD64xwoQeyZE1UH1P/0
         RLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708470066; x=1709074866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2fn3Q8ysQNGsP4/bFdrwVKI00s9RBc5Vo0obuiYfWE=;
        b=q1DnNKYNpFPrbr0cAiEgUoakdS7hCju6wf3QunP+i/VNXdCLo+Pv1GrswfIp2usEk8
         5O15VPwqc/kvP4YPJ8ApxhBXxLvGH++OGp3UBlp0fKDZalm8esIw2SdcrUAbBdmD7rmb
         IvHOiSkkxWDcN1svjwQgvcvf46c9aCo98OsK/yrVJ4zdyasf2hX5yOfKPdRXUvkSfj7P
         Os9NFztQ2ZXF3q7RHVg//F/VO8nr4xP0M3c5iSX9RXjGDAgtqa+FiCrPZwip/riV4hcs
         70DoOUwTtVNfuObcVFhXDpfbRn/ipqOCRmlQ2RVmUu2RjgX8+2xqjxRwc1N52HZrCJXi
         xvUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFTjHIqbiLSHaWFy9h43Md9HP7t/wClI4YtkVZEbTVF0pw6rGFZ9AiSN0VGytJVqhTG5SDQPna8uVu3WzmYOmEY9wbzaY7uErvDkVF
X-Gm-Message-State: AOJu0YydchDXzQrYiHsxx7BNTT4Sb6guj/ZeR9ozBLQGR+ZbwcndyeXm
	Z3zP6UGdBvOAPczx3E5rt0EUKSMIaGNhvF8soQtzvNTuRATPzX1aMBwa6Nv6YxCnlzyacVtvRvQ
	D0nBpEYfsWid9dyxWu19UP4tmxQb/OxC2TQSBdg==
X-Google-Smtp-Source: AGHT+IHF4X8wKExd1/pvj1ol/XkM7oZ8gVoH8+BQhl5KQKK4+h/fjqShZZcUu2zwUnRK8rhG/TFZmoyPRSTuQf9Je84=
X-Received: by 2002:a25:8a12:0:b0:dcc:e388:6db6 with SMTP id
 g18-20020a258a12000000b00dcce3886db6mr16240782ybl.55.1708470065975; Tue, 20
 Feb 2024 15:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-x1e80100-display-refactor-connector-v1-0-86c0e1ebd5ec@linaro.org>
 <20240221-x1e80100-display-refactor-connector-v1-2-86c0e1ebd5ec@linaro.org>
In-Reply-To: <20240221-x1e80100-display-refactor-connector-v1-2-86c0e1ebd5ec@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 21 Feb 2024 01:00:54 +0200
Message-ID: <CAA8EJppgusQObCgmtG7Sz2tLiQziyPy71Eq7ru1=VmOaTZE9og@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] drm/msm/dp: Add support for setting the eDP mode
 from devicetree
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Johan Hovold <johan@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 00:50, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Instead of relying on different compatibles for eDP and DP, use
> the is-edp property from DT to figure out the connector type and
> then pass on that information to the PHY.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 11 +++++++++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 19 ++++++++++++++++---
>  3 files changed, 28 insertions(+), 3 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

