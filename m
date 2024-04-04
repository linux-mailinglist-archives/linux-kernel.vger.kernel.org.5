Return-Path: <linux-kernel+bounces-131302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3351D8985E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13B0287D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A8F823B0;
	Thu,  4 Apr 2024 11:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="fPe3MZ6m"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65AC80049;
	Thu,  4 Apr 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229604; cv=none; b=IjfCFYydrY0Dy/iKNkW855/7ai9mYYFQjWsJJxu/oZzdaDUTBJnEukhVf145fXSbH2ZLpWocHJzdKM6bDT6zDqIUExc9r4ldeDLK7tbOwlbCCqxkCo2PQuPAUYuLjwV4R47hJcZg/bH2RRFJCGzT1PdhqRpSdjvteWoWD6I8lbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229604; c=relaxed/simple;
	bh=t6d/PyHpVwkmewtMCsKlZKk/Gyvx6dW/FybD6AJAP1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gyiwQAVzbjglB5oLKInV1ujCkx2V+zW8WSSvNXjggoUydxUfwrbVMVJHOthB2ghGV6IV8XFfK8BoEta5RQQefpIyqfz+372FhfRLMGFh4VEORk9elo1cl7zFVP+aD6qFaDjWekmEtxf2vfeLXD00nRMIctCbZKzj2HrqvZEXoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=fPe3MZ6m; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 12B2C1FA96;
	Thu,  4 Apr 2024 13:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712229599;
	bh=y8c3dwgARBoHOS+ppSjIp8Ujo9TVdiGyzxhgn7bkyAs=; h=From:To:Subject;
	b=fPe3MZ6m7Dor2GUvfZGemOoHMPbDAkZU3wNKIxkVNUGbph4gNL67mowN6+ymE3izp
	 CKK5eXasbVXnDBUQj63l01uXUSSIaeK1FKWSdTQ6Ixu3bPoZTs9TUyc5e2X88QI7Ef
	 k6mTvZH8MBGthuDwouv8rCNlknrKS2LE015qbLFuSZKD4rkE1C7P4jPRecriiO3tZf
	 8GZYNIoE2pWIW2Bg99WScp/9zeAAQyRmqTR7DJyqUaIPaw9y0RjNRU+ZuqsYGEu5k8
	 XceuAI6GwzARQh6BWVizbCqhgsNCgo4NKgP+FqQ9u2v5JeASSxdE8IfaET/DhQRodV
	 7tzSbc5Tp+TXQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: nau8822: Remove unused member from struct
Date: Thu,  4 Apr 2024 13:19:53 +0200
Message-Id: <20240404111953.99287-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Remove unused mclk_idx struct member.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 sound/soc/codecs/nau8822.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/nau8822.h b/sound/soc/codecs/nau8822.h
index 646f6bb64bc5..6ecd46e45923 100644
--- a/sound/soc/codecs/nau8822.h
+++ b/sound/soc/codecs/nau8822.h
@@ -215,7 +215,6 @@ struct nau8822_pll {
 struct nau8822 {
 	struct device *dev;
 	struct regmap *regmap;
-	int mclk_idx;
 	struct nau8822_pll pll;
 	int sysclk;
 	int div_id;
-- 
2.39.2


