Return-Path: <linux-kernel+bounces-22896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B960082A516
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC551C22EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AEC4F8AE;
	Wed, 10 Jan 2024 23:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bmo+oYOS"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BF84F883
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-db3a09e96daso3895055276.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704930648; x=1705535448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IY2WHo656dlJft78J6VUeykbQH3OBUSeMuyIpTpTn1Y=;
        b=Bmo+oYOSaJ0xZ16vSCdSpMyXzm5gawk84S0rDaHGmBG6nUqLh2QUliuy/Ciwl83hfZ
         pOwx76LQFrCxRdc5aenk7sW2+2w7NI7H5y92f371xaoNUrjWkIseY+Pi6gC1PgcSRbhO
         AwQKiQAAYspqERWNpNBloPKn76f/xeX96UWsgUGaE+Y3pUErP9noqI13bJIBY6wcPWnP
         Ezik3MyFwNqgXxgar+teYEw0oHMHciPou675m9qY73vo9pr+j52mBWbzD5kdQkLlsTku
         N1ByQ32B9VZO/g3npNTkWo7gljN9J3Yttty/1ngd0qcwhZ8PohWX3W03uTG7X1D3TNZ5
         vepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704930648; x=1705535448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IY2WHo656dlJft78J6VUeykbQH3OBUSeMuyIpTpTn1Y=;
        b=AgyWcb2CAMy6O53LnmeoOZ2zDl7RrF+Dww5UhXxHgKx38EHelgHxK0u/puNNCfigcq
         /pEi+aS33ER2gfbkBlb4wLG5J4KP62IoptHp9Rk+kromRmHpHupqETkMgwP8wJwwjjJH
         CC8he5zwt9FCCuxAHAimoUlGq5yZolrxqaS2dpQ+zxm+4/Qwh7+bgomKog+WmxMuZt5Y
         NGocL5cLR88StVC/NbWqwNHG/o/m9fN+/1udXToW5VRfysOhCOoAwkeE3dFMe/aQfOP1
         y69rwQeKiJ0mtNbXOt/lzP3g2Jq6CHk+tNXpsjeQUdifjethsXDJM9KLV1/XEspJY2IG
         8gOA==
X-Gm-Message-State: AOJu0YxHq7Ukt7p7e87fcm46+bLKLzgtCKdDHcY53XjcIlq1lBSqjmMO
	7qCg8TKDbD/fo+198qq1u0hYX4h0dPFTtCQy2k0e0sFBSLjuIA==
X-Google-Smtp-Source: AGHT+IE0M9W/0P2Ae6mYe8PCrJ9dMKg+/Sc+SJ/3RpX4hnY2c5YNeNuY5R4SrTJIFAZOV6C8lq2rU9YH1tu7XsHEaA4=
X-Received: by 2002:a5b:651:0:b0:dbd:b17c:802 with SMTP id o17-20020a5b0651000000b00dbdb17c0802mr409911ybq.52.1704930648185;
 Wed, 10 Jan 2024 15:50:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1704917931-30133-1-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1704917931-30133-1-git-send-email-quic_khsieh@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Jan 2024 01:50:37 +0200
Message-ID: <CAA8EJppcsQtS7h4g+hK+sss7pDuvKjkJX1o7_DUO-rTg1BtWLQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/msms/dp: fixed link clock divider bits be over
 written in BPC unknown case
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, robdclark@gmail.com, sean@poorly.run, 
	swboyd@chromium.org, dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch, 
	airlied@gmail.com, agross@kernel.org, andersson@kernel.org, 
	quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com, 
	quic_sbillaka@quicinc.com, marijn.suijten@somainline.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 22:19, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> Since the value of DP_TEST_BIT_DEPTH_8 is already left shifted, in the
> BPC unknown case, the additional shift causes spill over to the other
> bits of the [DP_CONFIGURATION_CTRL] register.
> Fix this by changing the return value of dp_link_get_test_bits_depth()
> in the BPC unknown case to (DP_TEST_BIT_DEPTH_8 >> DP_TEST_BIT_DEPTH_SHIFT).
>
> Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

For the patch itself:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Additional note. Since this made me look at how DP_TEST_BIT_DEPTH is
handled in the driver, I stumbled upon dp_link_bit_depth_to_bpc() vs
dp_link_bit_depth_to_bpp(). These two functions look pretty redundant.
Since the former one is used only for the debugfs, please consider
sending a patch that removes it for the sake of using the latter one
and /3 in dp_test_data_show().


-- 
With best wishes
Dmitry

