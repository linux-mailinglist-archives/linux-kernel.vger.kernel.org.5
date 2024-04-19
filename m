Return-Path: <linux-kernel+bounces-151364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1F8AAD96
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD851C20F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E9984FDA;
	Fri, 19 Apr 2024 11:19:17 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548EF81737
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525556; cv=none; b=FDuET3fwcG2jOKfql+Ecm7QU95Wq3d7BVWTtx+Onp044rA09+6Q0BvnOI+WK8J9ImkAxl/gQDiD1RoJbZ1KQPAL5sW2Q5GoDjflvKga+vD/5uTd5aYSMgj7KOeRKbbsb3ftMiUi709IjihpQWyGa7yl5gdtJDLB7I0BZspfMOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525556; c=relaxed/simple;
	bh=tX1ThYWRIcMHOAOUe3y7wQFqXcAH15RfZ2BfB4VDiYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+wPOe1+Z01wIb779ZgnqttdbKuQWCucJcNQPuEhB7KCclYytPtzaEOuQMBWHkBsjvDfLfDwRd/wERrVuJhErFHJtYMyoFQ/N7hDoXkfBSxmYIVo7jml52nikqukWGNP6mCnwAD5FtpvL5PLN7LrBBF83mxrLGIo7Mcm8RMWpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.intern)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxmGm-0000RL-A6; Fri, 19 Apr 2024 13:19:04 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] drm/rockchip: cdn-dp: drop driver owner assignment
Date: Fri, 19 Apr 2024 13:18:58 +0200
Message-Id: <171352551023.2525344.17146432068876073812.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240330202754.83907-1-krzysztof.kozlowski@linaro.org>
References: <20240330202754.83907-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 30 Mar 2024 21:27:54 +0100, Krzysztof Kozlowski wrote:
> Core in platform_driver_register() already sets the .owner, so driver
> does not need to.  Whatever is set here will be anyway overwritten by
> main driver calling platform_driver_register().
> 
> 

Applied, thanks!

[1/1] drm/rockchip: cdn-dp: drop driver owner assignment
      commit: 0e353133816b3e3e4bf8a682de01506ebc2b1dee

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

