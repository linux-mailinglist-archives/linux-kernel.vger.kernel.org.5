Return-Path: <linux-kernel+bounces-64209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0BE853BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ABA8B237E3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A360B94;
	Tue, 13 Feb 2024 20:07:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D860B80;
	Tue, 13 Feb 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707854830; cv=none; b=ZUva/cUTeds9xWAoViGZmzd/9F0OEnL2YOMHlEfKEClDw0tzeoDeFlYN41ZoTAxo6KwaNGKRsuH8omu5jrHaXGV0QzPMeU3fr95prOp6Zfo6C7ILPYsIVNPvPHUZDgrepLrGHltAsoitBSYSN/GyIORDAxzg3jklqMYhLZHJvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707854830; c=relaxed/simple;
	bh=dG56+XWeHB3NZcQwYNJYcVHq+38sAlAwxo/MkuLARR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/EZqjAB4LcxI214Ef1EbljuGnKzU29s50Z0t0QiGSU7X/TDWWPJvaNrIsxCHJdJfoTZuXOtnB5i1Pl+lNSuKmgqpW0FS5j4OU0Dz5qjVg8N+CsmOxvLSBXrVXB8+fmdAHxp0lHHSPeUeGD9Ol3a+PFg3FGzlSlqkvKx7zgytfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rZz3M-0000G3-0B; Tue, 13 Feb 2024 21:06:52 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Sascha Hauer <s.hauer@pengutronix.de>,
	Sandy Huang <hjc@rock-chips.com>,
	linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] drm/rockchip: vop2: add a missing unlock in vop2_crtc_atomic_enable()
Date: Tue, 13 Feb 2024 21:06:49 +0100
Message-Id: <170785480543.3398384.2668111589921036012.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240119190841.1619443-1-harshit.m.mogalapalli@oracle.com>
References: <20240119190841.1619443-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 Jan 2024 11:08:40 -0800, Harshit Mogalapalli wrote:
> Unlock before returning on the error path.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: vop2: add a missing unlock in vop2_crtc_atomic_enable()
      commit: b6ddaa63f728d26c12048aed76be99c24f435c41

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

