Return-Path: <linux-kernel+bounces-3211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A300681693B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CA21C225FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9307D111B5;
	Mon, 18 Dec 2023 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1+K+2Tu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B711185;
	Mon, 18 Dec 2023 09:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2010BC433C8;
	Mon, 18 Dec 2023 09:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702890393;
	bh=+xrIC1/M+x5wcDX06MA4CU4wO1xgEjusI4hUvk9v7rI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=D1+K+2TuggkeOywWXWV/o3XuwlXsB+dqlcUycqw/yS0BII3/ni/ahT/ZEMsCZu8Ka
	 pYvoJP3wAZMavxnBh7QkBu2OqyB1G/1rj1nS+CJ0bSiQPZUmp6ZK5OBcB0IAjBRimz
	 qya9m98rXJlg18arlEpWpBDrDxCIkSSXyEGlZNmRRwhJuxaFjnRd8BUAJEJDrLFcI0
	 nbrJbxW7bR1qyorv9Auz4cSLCahgcRRMExhUC/q9bs//begL7eiRwAjoA6WjkwgYoy
	 Lpy91k8DYnlEnfooukr1U3AjWL6c3wllpLZ3bPgm/2W6uYYNlTXjZNlmDMvrfDXGTF
	 e1TN6vKdBVVEQ==
Message-ID: <2fe240249b744ecdddc31c8e23c7616b@kernel.org>
Date: Mon, 18 Dec 2023 09:06:30 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Alex Bee" <knaerzche@gmail.com>
Subject: Re: [PATCH v2 24/27] drm/rockchip: inno_hdmi: Drop custom
 fill_modes hook
In-Reply-To: <20231216162639.125215-25-knaerzche@gmail.com>
References: <20231216162639.125215-25-knaerzche@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, "Andy
 Yan" <andyshrk@163.com>, "Conor Dooley" <conor+dt@kernel.org>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, "Sandy Huang" <hjc@rock-chips.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

On Sat, 16 Dec 2023 17:26:35 +0100, Alex Bee wrote:
> Now that we have proper pixelclock-based mode validation we can drop the
> custom fill_modes hook.
> CRTC size validation for the display controller has been added with
> Commit 8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to
> hardware capabilities")
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

