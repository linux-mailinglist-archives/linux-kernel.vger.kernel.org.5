Return-Path: <linux-kernel+bounces-94347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF80873DB7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1D31C22651
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB7513BAFE;
	Wed,  6 Mar 2024 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjdImPow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A730D13BADD;
	Wed,  6 Mar 2024 17:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747239; cv=none; b=UE+2i5nc47soEdLKa3p3DO+Fr8nkOmvSCP2IBSN/fS7/i8Z4Uk5ARfSma+AChqkUeK4imG6M/fEQEU9apOk8qiSC/J84Qcxt9tGPrN6YVZoxQA3l9lsNMy09i5WqSR+5gd29eQzh/K3CwZooBJwc2uMRTTucYHbcbvtfTXrq7yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747239; c=relaxed/simple;
	bh=M3Qnc0kB0MnG72TbxAy6mHm1CxTe6WFO/XsmSNzWFVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dt+CzhIBJOdmvomL4kneLl2qNG4vDSuqc5vSrdoX2VF1EeOCfSmn/sxeprYvDm0CWInXNB3Y1rUnVXpsykEIMLZvWYtuvnBz5UCdczjFRz3nW/M574K+ahVsadtHR3g5+B25SloE1BtaIJCyZCgHNa1pN991SnqLoB4+SGvThSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjdImPow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58894C433C7;
	Wed,  6 Mar 2024 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709747239;
	bh=M3Qnc0kB0MnG72TbxAy6mHm1CxTe6WFO/XsmSNzWFVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GjdImPowRYEm7/pn8xhSYm8k0V/sHqvsew0j9xUc57MReIzjVdqeWmCsWzYmlMySF
	 CfBySFrHga5H2Qf6vt/zyUDw8zd8d0Ohh5YXjI8GhdHCMIQ3nvLP4W937LbOdHqNPG
	 Z14JCvmc7QSTew/N6rNuK+331Zh62FjZoJBbqaFj6yExTn2Umgykb57TjpErB2h/x7
	 0kUTvb0Yk4tZ1IN2ZWJNOLBO1oIlUfGBLwbJutYSPZDKX5cpp7bD54VlSzDZard27D
	 EbABchSyftcWpB2WAWozeCp7rVKXdTktq08MkNwYfrRuvWMGYRK93YDuBboviG3f2c
	 zWvA0oEYqASXw==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Johan Hovold <johan+linaro@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
In-Reply-To: <20240217150228.5788-1-johan+linaro@kernel.org>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
Subject: Re: (subset) [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm
 bridge use-after-free
Message-Id: <170974723198.898356.8197875205136329255.b4-ty@kernel.org>
Date: Wed, 06 Mar 2024 23:17:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 17 Feb 2024 16:02:22 +0100, Johan Hovold wrote:
> Starting with 6.8-rc1 the internal display sometimes fails to come up on
> machines like the Lenovo ThinkPad X13s and the logs indicate that this
> is due to a regression in the DRM subsystem [1].
> 
> This series fixes a race in the pmic_glink_altmode driver which was
> exposed / triggered by the transparent DRM bridges rework that went into
> 6.8-rc1 and that manifested itself as a bridge failing to attach and
> sometimes triggering a NULL-pointer dereference.
> 
> [...]

Applied, thanks!

[5/6] phy: qcom-qmp-combo: fix drm bridge registration
      commit: d2d7b8e88023b75320662c2305d61779ff060950
[6/6] phy: qcom-qmp-combo: fix type-c switch registration
      commit: 47b412c1ea77112f1148b4edd71700a388c7c80f

Best regards,
-- 
~Vinod



