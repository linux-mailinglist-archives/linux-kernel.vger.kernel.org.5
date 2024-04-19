Return-Path: <linux-kernel+bounces-151363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8150F8AAD95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3ACC1C20FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C7081748;
	Fri, 19 Apr 2024 11:19:14 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B183CCB;
	Fri, 19 Apr 2024 11:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525554; cv=none; b=HDnkVSCxd+NZusS/eCWAPCT8GHRSyqVsYZ0GbgWuq7Q0Ka1sF0qEiBfBsBWR7tL5lKX8XZqUWtijzrrckIpT5Pxj2BSpaPHcxSPkohbz+t2TKFh21+804NT+8yEeIcdWANpyyR5xAl7dmIb36/P+N2loYJb7CDQPvX9Ka0RAqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525554; c=relaxed/simple;
	bh=8PCateXJ7QSgCXxmFAjJirF7McdYH8JFUi9yff4bVqk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axt2ElNeP4BtuHoOTrbTECw1CVpzfY4b/64bJVWnXjCQsqzrwqVS97g4w7y+80guny2HDp+78CBjCiHcq+WY/zjoOhDa50zMEy/SWYxHWwOhENwxMBQoLi4Ldo7TuS9gMbDGPN+CKBL977LVwaMH/gjHXxp+dzQ7Knx6tEbqFmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.intern)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxmGl-0000RL-Hh; Fri, 19 Apr 2024 13:19:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	airlied@gmail.com,
	maarten.lankhorst@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	markyao0591@gmail.com,
	conor+dt@kernel.org,
	tzimmermann@suse.de,
	mripard@kernel.org,
	daniel@ffwll.ch,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: display: add #sound-dai-cells property to rockchip dw hdmi
Date: Fri, 19 Apr 2024 13:18:57 +0200
Message-Id: <171352551023.2525344.13101791805180451568.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
References: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 17:38:05 +0200, Johan Jonker wrote:
> The Rockchip DWC HDMI TX Encoder can take one I2S input and transmit it
> over the HDMI output. Add #sound-dai-cells (= 0) to the binding for it.
> 
> 

Applied, thanks!

[1/3] dt-bindings: display: add #sound-dai-cells property to rockchip dw hdmi
      commit: e58414e44b5315230de829ed88a63611646907ac
[2/3] dt-bindings: display: add #sound-dai-cells property to rockchip rk3066 hdmi
      commit: 9be3eb5d6ee57662a22b56153c7ee39265685455
[3/3] dt-bindings: display: add #sound-dai-cells property to rockchip inno hdmi
      commit: b1ee6bd3ea954d081bfb1d5559ce3e78ef40443a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

