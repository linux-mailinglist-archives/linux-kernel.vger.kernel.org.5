Return-Path: <linux-kernel+bounces-71310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B86485A355
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015321F243A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2DE2E856;
	Mon, 19 Feb 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o30itB6h"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0122E84E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345848; cv=none; b=VPgymCCezRmqHICY4xGu72DuGux3dK9ya/mvboNReq8MVCBkbTR8Q0o4cwj+WPbJuArY/c98J3kyw7zARx3RniHJdKmwqlkrcWG/0o5FIWGaz2n76EILv6C/vexuxFgUkttang1CuM8Pc1Y0zLKE9x2uapd6dYW+hxvjqSo/DG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345848; c=relaxed/simple;
	bh=GJgOGooayRDTyLr6i4tPW1k7jU99Mh6mP6UBWIsy4FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=So3k4Dn+q7Nmtoq/GHipvFkvNI2P1mn4+I06OKFnZWyfyFGkidj4SWFAGtZPE+0yXWPqeMMmBnZdrA/maAnEKDRvOXIvVH2CbqBOsPpeGQynmXFz8F/QfodNZEw9LuBG5fGpK2q+chzV/FUddUnC261hAoqiu1ZkjC5yQbicCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o30itB6h; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eac018059so6059337e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345845; x=1708950645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU3RgHxGlzb++qXf2E7iGo81GOpfMcen8bTfd0uPCOw=;
        b=o30itB6hROinxdtx0Je3Hup037sap3JLVjyBRA4x9HrbbKox7jwfFzuM5cBiY/OxPL
         yKb298cm4ib+RQ580LHp9DT7e2jpzQuPKo8xBkj8V6MRuTFTya4y1ftb+s6NtUqjmXyJ
         Uv/N8UTq9fyONETjXpkMS8F1G+7BWQydrEYT4k1/DhC6Q0q43KejDPlhNcY52UWQKK0N
         KJp3uosJXih5LSsGSbgzBlwOsnn0COSesOBLtyEZVDeW2wq+EOELXRhjNT9qwgtYFjkS
         Ut2+Sm8C+nmc+rDuep8cMx+SSg8ezPR105iEqWizD6j333/2mKPAPX6ruh+OO4Wmo+A1
         eJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345845; x=1708950645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TU3RgHxGlzb++qXf2E7iGo81GOpfMcen8bTfd0uPCOw=;
        b=kdkGNGBH4cVr9lzD4uE+PrP/5f2JTG+tqtGOiWAKhzVYbr9WkOECrtdjK346iXEE0B
         L5ALshTDNi6MHUTe8cN2EQNFNVMIaSLkAnugUtAUmpPFRKURcDW8xFJvjwodRCEdwGQY
         o4Duyv2k3oJmvQDWbFgqPBn7ualt3oa+yu5oehrxCuKB297zQo8FSlxm7AzD5i6iaVtP
         Ht+IMJDVyo9U+0g3SSy5K7m+oOJF5JcDehNXLVySkPYdlLnDb8wU8+dSs8LO3Xe6XwaN
         +PcaLA4WcgUE6ETIPyjIjWHXCcajRPmsBXvTwGgIuCr+VVjS8hs7ab9AotopnM1DoeSG
         Yf7A==
X-Forwarded-Encrypted: i=1; AJvYcCXFMCG14rGSk+GoGLJfBgvUbz84mwKfsyzTfF+SZH5ItZkOd3DLi7ZKrJSW0Yv/2fHRkwhnee/tuAnPim6ctP9i2pFzESojWnH5E68D
X-Gm-Message-State: AOJu0Yy8ZNZoWxafgpcWm6xhcwd1DJQjDt5zP3AkAvSQ8u6zNNKAqdQM
	rsOD+tEvJmDhR930Tj5ADge398kJw5685XeozhGarUnP1cmoo8qzDpFHMJZasg8=
X-Google-Smtp-Source: AGHT+IHLK/rYF6Py4Eo3rBlxE89glGNXj0zjcGYdPTtAeNi/U0O/DpqKeN1TdI78YmnZYby2duc5vA==
X-Received: by 2002:a19:5513:0:b0:511:b3fd:76b0 with SMTP id n19-20020a195513000000b00511b3fd76b0mr7566336lfe.23.1708345845307;
        Mon, 19 Feb 2024 04:30:45 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:44 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] drm/msm/dp: Fix spelling mistake "enale" -> "enable"
Date: Mon, 19 Feb 2024 14:30:31 +0200
Message-Id: <170834569502.2610898.13062983632738279958.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212091639.2397424-1-colin.i.king@gmail.com>
References: <20240212091639.2397424-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 Feb 2024 09:16:39 +0000, Colin Ian King wrote:
> There is a spelling mistake in a drm_dbg_dp message. Fix it.
> 
> 

Applied, thanks!

[1/1] drm/msm/dp: Fix spelling mistake "enale" -> "enable"
      https://gitlab.freedesktop.org/lumag/msm/-/commit/fb750eefc492

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

