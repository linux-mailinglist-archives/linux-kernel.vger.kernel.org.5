Return-Path: <linux-kernel+bounces-78278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6515861128
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4761C21CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D37A73A;
	Fri, 23 Feb 2024 12:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h72n9H/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71E7AE47;
	Fri, 23 Feb 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690214; cv=none; b=nejg8Wu+I7iF0rE5oNDVzfzxG7qxI8+dWY+XkZ7mTdAgQr/tpQZUw3SO7kvfObyfVxzL7nUeA7OHEQe9/kZIRT+QV90WBmfgNAJfgh8tUXaTHm3kC2Ou7cWHxyJdJmHl6/0OPTh1MyvMD+wXtwUlL18LkWxAzqLWAzh7NmDOChs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690214; c=relaxed/simple;
	bh=4mfjeqsrT5LLWTfnZOi1uQqHARRbPNHPlL7bWNXA1qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8+9BcaAI2kfdSOZukm1FIdbK8xvtQnlJXuIr0cYDxIxqBY/r1xja3Qj2DBoUklnLWb28tFRzdE91AZ2Wgoxu2cFUVzTF9GQk5S1p71Db87J2z1Oa28wFBK/qSAto8SX1kB1UK5zsDZdVqG7ZuDZgh08H+BiBhj+AMdETaVVpwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h72n9H/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B80DC433C7;
	Fri, 23 Feb 2024 12:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690214;
	bh=4mfjeqsrT5LLWTfnZOi1uQqHARRbPNHPlL7bWNXA1qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h72n9H/Ey6btg2YG3+/Lndvz6UL99KJBWHTd2DmoRO2yWH1/pu+jFKJsTzELXXwr9
	 vIacBhyEGk57aSoaG5rkePrkzJ8HlT6EbaoKn6IKXgGhBTEgUAgBUGhr9loLlZHJEp
	 ZxTqExOuYNu/bJOFEen2Or5AE7hQ+yCu4H+zmNUAz3uefWv18K3hrjLl1ZuN00s8p5
	 K19x+3oTMDVW0ePSzIr3+a0r8iefy3Qh+FtcnlzmVqSWWznSrVA1Rw9nTICEOD/aBV
	 JUuZlze6Xt3nUJzJdpMhuuzG1116zfi+uW9Z1vpbBqUi83BdreXLKp7K//DhXTLL1e
	 UnGBCgRv5PJDQ==
Date: Fri, 23 Feb 2024 17:40:10 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jonas Karlman <jonas@kwiboo.se>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, stable@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH 6/6] phy: qcom-qmp-combo: fix type-c switch registration
Message-ID: <ZdiLIjGIn8e5tnJc@matsya>
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <20240217150228.5788-7-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217150228.5788-7-johan+linaro@kernel.org>

On 17-02-24, 16:02, Johan Hovold wrote:
> Due to a long-standing issue in driver core, drivers may not probe defer
> after having registered child devices to avoid triggering a probe
> deferral loop (see fbc35b45f9f6 ("Add documentation on meaning of
> -EPROBE_DEFER")).
> 
> Move registration of the typec switch to after looking up clocks and
> other resources.
> 
> Note that PHY creation can in theory also trigger a probe deferral when
> a 'phy' supply is used. This does not seem to affect the QMP PHY driver
> but the PHY subsystem should be reworked to address this (i.e. by
> separating initialisation and registration of the PHY).

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod

