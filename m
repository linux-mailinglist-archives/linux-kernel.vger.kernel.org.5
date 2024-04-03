Return-Path: <linux-kernel+bounces-130375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48B897746
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708D71C20DCA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75380154BE3;
	Wed,  3 Apr 2024 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tO+wqjp2"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2B152DEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165206; cv=none; b=pRM2kowJs1b7Z3wLD/Es8oEdIBkRJfHUNj2hZg1XACuc1RM2WcX+LgAlEC4jZRKMIU8pjZkxR2rEBnMIvZCxQlfuSoZVpvQVrqwfoG7SK8vSvz4SzlXhghIgmoQFmk4W0Ex26NozuMWf3WqKbntAWCZyWL2svBsaQfQ7bRnsD5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165206; c=relaxed/simple;
	bh=LnpTv88ibvNdXj6GVzP9xU4lqh7L6amljLmOCPnvIHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9tZKBSkWhgG6ZAdowOg+GgE4TFEHwIPyC9VT/zn1am5neJ59YEEyg0XkJiHzbe+BZ+NtNwkrtGEFRPOqmzAEZCAlvoa5DNRuvIpBZ/iUUFAobXPRO9FgXjrJyutMqpzJIaQRDbDEhPxZlC/g+5RfFBCETWTbZqQrP/JNqhg3Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tO+wqjp2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so156938276.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712165204; x=1712770004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7QRRgKqsXwD5sSRDZZ8VcuFdOzjyZfFtngo+Xri/jk=;
        b=tO+wqjp21AqO4hJzG6vcG0QYNqO+NiIc6NK9s/VeAEwXC2g81lBhNHJ485e1XaP/16
         KkZpcnKuR36at5dVR3ZpkaSWlSxJTsBAee3xWvJAKXYEYCekARTSNacBB/FsbWh5EO5Q
         KL7LLKKdA7fSxy8VUFCRH2KVO2qA923ZXTLunJXNnF/7Ub+X76pXRiRaQphg5Mh9jXjU
         9x8c4Lc7Dt79QHREgvAPE5O9x2ZAEfriUnOznXooWXIGGT3ZeHMsmqN2QVd7SzmA4RR4
         R/G0HvwNFKDJwJ4dTdqONupv9m4+pt8UiQ4RX65FeO3wvMcBKi10GEK+sarbkE0FF1rR
         Ri3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712165204; x=1712770004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7QRRgKqsXwD5sSRDZZ8VcuFdOzjyZfFtngo+Xri/jk=;
        b=oXsAl0lNfpRV3iZLuJ9qipc4umhTyWm9WhOu8bU4VPcb1ZbV1KVLeDTh3DP5HL4s3A
         Mu7YLLOe6j1a+3HEOnR0/wblsW35Zi9XMdA4YSM4TzCJRl0L0pm2fh4OK1Jv4Dav2EvV
         SS4AU2WMILLFidmlDMY61LeEI9yqBvtayrytOarCrFN9JS43pBd4Z/AqvZXauo9i/U39
         vjX6gaHu5lXIJh1bF4Zb1mvMtDPftVj4ap1fB9CfmXTgsPFMqjfMLJ1E1vQ5NijxSRXi
         j124O0cM1S/ADcwXYFrbga4SoSFtroqig5g3Zor9z/dxdgoPR72ew3EjB4GAGZLRq67U
         2QHg==
X-Forwarded-Encrypted: i=1; AJvYcCU1OM8Tzy8VfKpiq35yDu0mZPd4fkVqWyjL3tDmlIbDKT/xav8y3lWWfSJ7+uUJIpxsDVrppxOTneuSrYjN2RgN5aBNakfkZBNGG92O
X-Gm-Message-State: AOJu0YzbXVEIdFhz79jAiqFFecZqdqDxjVxczCkex1FawpYLBJvEEo4u
	kFsa9WQ58Vhe2ndtAqr7gd8IadkYw5wliG2fG+26HIj3cVajlX5DsY9dQkK3SUM9PAizdAwTFH7
	txeItGvennvby770QfozTSQOjWwlUYgrf1uXARw==
X-Google-Smtp-Source: AGHT+IGKs4UZZu1uWec/JwUPIddWSalxBLmZpFq3atHbYhG7vywkXhdOnRse/O/THqsDCZtUL5neZXBtsuKX/2xQd+w=
X-Received: by 2002:a5b:a92:0:b0:dcd:13ba:cdd6 with SMTP id
 h18-20020a5b0a92000000b00dcd13bacdd6mr116607ybq.47.1712165204168; Wed, 03 Apr
 2024 10:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711741586-9037-1-git-send-email-quic_khsieh@quicinc.com> <f0dcfd6a-55cf-84d8-6599-319a700e1960@quicinc.com>
In-Reply-To: <f0dcfd6a-55cf-84d8-6599-319a700e1960@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 3 Apr 2024 20:26:33 +0300
Message-ID: <CAA8EJpqWa0bcV_ucsyM5_sSu3d0_XFjnNdabUcbq0muHtx_YWg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: assign correct DP controller ID to
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

On Wed, 3 Apr 2024 at 20:24, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Dmitry,
>
> any more comments?
>

No, it was picked by Abhinav for msm-fixes.

-- 
With best wishes
Dmitry

