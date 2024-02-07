Return-Path: <linux-kernel+bounces-57072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3F84D3BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229A9283FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2627D12EBF4;
	Wed,  7 Feb 2024 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6G92GWT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A74B12EBC1;
	Wed,  7 Feb 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340916; cv=none; b=AZy66/3Mx+5n5xZKS649m2G7Q3TPHjWEQpETJF159eHfD7ZZETi5AWYFbeMFf2h/9XlyuVrOMAWmR6bhVPqDpF45aPLcWrGXIq1nwHjAgH/oGzFtQxfTB4WM2ojKYuNiA1G8mty/dFQPSMdZqibSzOmGFnRnZW5MGMVnUL9irOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340916; c=relaxed/simple;
	bh=I6ACf0rheCfaTgMnCYw/5BfgrO0NFpeYQB8WyEw7xzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKjEYBq9GXuEpppxyB8jnW29MhE4PhItIDtKOi6hyv816hm+uocxOoUNMM/LONEJs9231K3+1WC+MsczWFomYIMfK7zh5Ama32SFECbK6Bpyd+t35FjZ82jZ1w1Ssfo5nde0XT0VlUF6rFe5asooZKn+lpHcvzp5/Up5WYDtWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6G92GWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D479C433C7;
	Wed,  7 Feb 2024 21:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340916;
	bh=I6ACf0rheCfaTgMnCYw/5BfgrO0NFpeYQB8WyEw7xzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6G92GWTlBVh1F8qfOiGV7r824mxZPaXEeaGCqRsua6EsOVaMqZll1HUCLZiZ9kyy
	 gVf16Lz/5L6d4GTAeZ9TTpmxWdCLoLkLSUItJIi1Ya29D2IVN44duSjRPkeC0Nnheg
	 BGCX/+TPoVUWgqk3v/NdfXtiWMw9VS23F5VHoVyEds1GBsjCe8UBzFOAnVrJ9W2c7S
	 ZBcrcE7bVtlX9iOx2FIHF3R63SsG7nMiCdUoea5vKaKlwHwlQnz6qDouCxe5TdmfrG
	 Bx1mgydhy4yaHh0fLx2dPkXOh4Xa5deYihkYbP+frpfGe3X3ZDAymxQfZl+f5j8p+l
	 XyAVtkmnCgX+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 07/44] ASoC: codecs: wcd934x: drop unneeded regulator include
Date: Wed,  7 Feb 2024 16:20:34 -0500
Message-ID: <20240207212142.1399-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 35314e39dabcfb256832654ad0e856a9fba744bd ]

Driver does not use any regulator code, so drop redundant include of
regulator/consumer.h header.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://msgid.link/r/20240117151208.1219755-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1b6e376f3833..6813268e6a19 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -13,7 +13,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/slimbus.h>
 #include <sound/pcm_params.h>
-- 
2.43.0


