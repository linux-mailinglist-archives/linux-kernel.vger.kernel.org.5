Return-Path: <linux-kernel+bounces-158789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF6F8B24EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB3D288E26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351414AD0D;
	Thu, 25 Apr 2024 15:20:10 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECF14A4F7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714058410; cv=none; b=CCLap3bXkPu3DoVzhWshH4ReRwACIbeNs3jUU0XhVjrXd7gSaZpUB36yBZnRpvQDU+r2e6e2r7wn8ClVXoXXLOSMOp4w7vi1Idh8tTTzdavlBsdISDEoSMH/2bGrrnRR0/y7UKqSowni/OJ+b0k6OxJN9whZdbY8yn6DIROMxV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714058410; c=relaxed/simple;
	bh=Vxdc1D4kXPYZe/ioP1lhokZaGxjtMFy/mB3o1wkxxIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwMs1GXL7VnvL8THQkX1/34UoInn9JbvYsS6JtI5KJ+8AeT3uLH8FUQB41UIdeMsj5XkPec+n1GDt9nNsmojDn/z7QvAYlUDHs6WAOZvzwPwVrQaHb1YcCXn/x783JP396xTce7jOK6j2k/BFgLa12UQtR9wX2qufC4piCGurWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e861d82.versanet.de ([94.134.29.130] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s00tE-0003kV-3Z; Thu, 25 Apr 2024 17:20:00 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	hjc@rock-chips.com,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	s.hauer@pengutronix.de,
	Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 0/1] Fix the port mux of VP2
Date: Thu, 25 Apr 2024 17:19:58 +0200
Message-Id: <171405838036.2897712.4067984796758491640.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422101905.32703-1-andyshrk@163.com>
References: <20240422101905.32703-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 18:19:04 +0800, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> 
> The port mux bits of VP2 should be defined by RK3568_OVL_PORT_SET__PORT2_MUX,
> this maybe a copy and paste error when this driver first introduced.
> Hi Heiko:
>    Maybe thi is the problem you met when you porting the dsi2 driver.
> I previously sent you this patch when you ask me about this issue on
> email,but I'm not sure if you received it.
> 
> [...]

Applied, thanks!

[1/1] drm/rockchip: vop2: Fix the port mux of VP2
      commit: 2bdb481bf7a93c22b9fea8daefa2834aab23a70f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

