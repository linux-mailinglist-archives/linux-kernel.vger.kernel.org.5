Return-Path: <linux-kernel+bounces-69453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9A3858932
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81809286A68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86214830A;
	Fri, 16 Feb 2024 22:51:30 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948B17BC4;
	Fri, 16 Feb 2024 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123889; cv=none; b=q5J6x/EpZImPuI7l+N2vjzSoAYolq1cSl8K9GOGp+4u16y7V0WnXdYEwXjf+J2gBLMTcrrn1gtwFKmF2Vyx2kBpKELKBcFTa89rGS2+2u+5jD2boM27u7znm7O9lo3o6vllnZtgmViQJ05etnSPIqcF3h84jaWv/w8fEqwoKJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123889; c=relaxed/simple;
	bh=bLvW3PsIXf159ttPYUgIF90/T3Ck+C3TDpTdkYS9ppc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUWA4WpElAejNyQQ8S3zNoR1RL7LmNkYmodzB04HBfQSBmmsnsNJqV4noZuTjexycqI0FxtdUiwZSFG8YC81tjcp/+vaIrMhDQAR9CvnJpBX2+cI7NjvfSwWBJze8+7rnFZilm1/cqaVfNR3OpOyuLiCAc3b1YYMEseRpMVRNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6c.versanet.de ([83.135.91.108] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rb73A-0005aX-53; Fri, 16 Feb 2024 23:51:20 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>,
	neil.armstrong@linaro.org
Cc: conor+dt@kernel.org,
	quic_jesszhan@quicinc.com,
	robh+dt@kernel.org,
	quentin.schulz@theobroma-systems.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	krzysztof.kozlowski+dt@linaro.org,
	tzimmermann@suse.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Subject: Re: [PATCH 0/3] drm/panel: add one more Leadtek panel, the ltk101b4029w
Date: Fri, 16 Feb 2024 23:51:18 +0100
Message-Id: <170812382120.3827147.1835380121153532051.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215090515.3513817-1-heiko@sntech.de>
References: <20240215090515.3513817-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 15 Feb 2024 10:05:12 +0100, Heiko Stuebner wrote:
> Similar in setup to the ltk500hd1829, group it with this driver.
> 
> Heiko Stuebner (3):
>   drm/panel: ltk500hd1829: make room for more similar panels
>   dt-bindings: display: ltk500hd1829: add variant compatible for
>     ltk101b4029w
>   drm/panel: ltk500hd1829: add panel type for ltk101b4029w
> 
> [...]

Applied, thanks!

Adapted the commit message in the binding patch to show
where the panels are similar but also different (init-sequence)

[1/3] drm/panel: ltk500hd1829: make room for more similar panels
      commit: f9488c160d6e8e5e548452a0d36057a1f8c04045
[2/3] dt-bindings: display: ltk500hd1829: add variant compatible for ltk101b4029w
      commit: c71efc6337135670164334404ef11506b31b7a81
[3/3] drm/panel: ltk500hd1829: add panel type for ltk101b4029w
      commit: 239cce651ea617002ff26f068f2568b2baf6421a

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

