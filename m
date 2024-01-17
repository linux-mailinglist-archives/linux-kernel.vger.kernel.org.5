Return-Path: <linux-kernel+bounces-29326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA084830CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89D81C24143
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360623753;
	Wed, 17 Jan 2024 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="AJgXuF5k"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD1D13FFF;
	Wed, 17 Jan 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516787; cv=none; b=rIr4dqKBbfYaPTAF/nAbbLQfah+nQn1qH865cD28JXRjOaT79bRRimKcLl2UE5pfRd0DafKGurA9wF8ee8I4zJxTpvDwt5j5x9MY5TaQcgjtX563mFUrDKPv1d1C6Y5mHwxD3Iarg/9P0YywrnkSB/l8raU+pudwpiBmsLkR/gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516787; c=relaxed/simple;
	bh=OGTSWYYYIj8c+SD8nKzKyjhCGDqhkunykC0KNhW8ywg=;
	h=DKIM-Signature:X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport; b=qckoQh81DTd4PQfa9VTvSNwNrxc2zzuBTXnhddFBjmt/og7EmVOnrojHATAvNB395sxEaRy94rjPTLEiUpPUpSnrnyB/Uf9JBG6RcCr0Rlm+QCJ9jOwCTd51kfnNXu/QQtudOTuvGXFBg7N8uVylcK0v3/37mS6oU84RyP9DV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=AJgXuF5k; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
	s=s31663417; t=1705516763; x=1706121563; i=frank-w@public-files.de;
	bh=OGTSWYYYIj8c+SD8nKzKyjhCGDqhkunykC0KNhW8ywg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=AJgXuF5k8HVQ523E71D9cfqi+mrPAr1Ry4u89Ofc9EUCXkQp8nVePmThzNwSutvJ
	 +kxSD/6pyyjK+FlsFtinRsq85BS9EiBgM7wsgtO8nTIiSw7/qiUKKm8+DSh7A36Qo
	 +DErHSq7W2O3ZIfJ18l3wRWo9RkvL4Xo5MSyrPOvOjTSLPhkLoKtYi+mYazdSomtv
	 rM5GvsORLSpTqgviOJ6PFnrt5rXlhFQrYCbnz4SHLb2ybwz4rS9wR7Ir8/De7p5iu
	 iSXMhAZZqQ0NN0RIDPsBlY79O1glgLFtJEN7JGk4C8bLNzGOTTRvSIDNdhZtzRqbD
	 qIxPZrwk3MTnyZhCsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from frank-G5 ([217.61.151.254]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1wll-1qy5Br44rZ-012HW0; Wed, 17
 Jan 2024 19:39:23 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] Add reset controller to mt7988 infracfg
Date: Wed, 17 Jan 2024 19:39:12 +0100
Message-Id: <20240117183914.62122-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ot4r7tklUz8MgmS9LTbACzre8iQs8Hx+z+di0RWtZbnRPLQYiGe
 tp1PvtXKeDhzaJROf+ij6+lmA+6H+pl3FOxzMBLK7SPSL8D6asAo39bpgigkHGo1ObaFwQU
 QaTvaZQHDsvd6jeZEeDvbY+JQa61Xb73xO7orc323X1a2PNPAmf8vEHbrKReNfduQhbYFuj
 ToYdMGed60GurzKf5UWZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TNCFqyXqnyM=;cQqBF/HRLDu+oXyy8j8R83GDoir
 gbD3D6ICYH1whKRxsZtyuJcpVYLadHrticqut6pDQYYGdnCuxLIVMcr5qcoA+hRl1gFuP2+FT
 7T6lz5zU+PDmCISN4nWKX/EyAq0e55oFWhwUHZCN4pohOio4fsJ3W73UcYLydm0nk4krnExM6
 VYewiT7xZi7rt9mMhhQFU84bZvIvbUNUDSEaqo899/4De58JWGW/x0fyWUXh9rndGZ8Cel61n
 QyULho6zjXygWDA3ZWaJMbWQ6cWqt+pCzJf6CpbZrTE05bMTwL+4lmfO30sv3E3Lg2jrGO733
 fynr6fBGeCVi3Btbgn60F32f/bq4+aWd5qYJSQqRCCg9zFaZJyMDLCqppq2pCWXn+/0Z0wa4L
 yTqDxqc3/IGKNvI3qe2QYBBXs+CtFwkaokfgUVHRCP0yETGKNLirMNGhImc73dB5G1EvPWYFF
 pGr/lJm2i95OrXwhkKZC0dGwYzXJHYtXhrcHtaWF4/Ct+ysma2Nv+CwEk5a2MP2jfHu+NZbfw
 7oKl4LJ/ekMzAJO4LnjmNCfbAIlybEzVSK6dgupRC654wlz0hCIPLOJvD43eHLCkluQuZO/HD
 TdiPWW0qByzycKRQgGuxjIq5EapuINyep9q6xi9NyF2tEMMU4qOK4RySAXqAo9908GmwwZy4B
 zaq0aHOemzwFvgXpqhl1tW/fOpLgBQ2WyToM4jBBjlyWrxo76zVqcpn15FkXllaaQioGmNYdy
 EcKhOTBeANZgqt3X5aWgY4d7izw15+a0ippy09zDLBGVe9f2tW90DRIXwTLlmfZtQxs8Gln2i
 cJYE0nbq6Xe7+Ux+kDrEzNVvJHhU5xMOzifKNVvOtvhp+PP210hHoLLIMBLuHuVCeYzu9lVsL
 lScfk9ijLw/waxF2wzO97wUC6Sf/ToXtD5PkgjDDQMVQ9kAOv0YMKolmYlFohdYeZ53Ckvtj1
 RiiUFQ==

Infracfg on mt7988 supports reset controller function which is
needed to get lvts thermal working.

Patches are based on clk-next due to recently added mt7988 clock driver:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git

changes:
 v3:
   - start resets on RST0 offset (LVTS is RST1)
   - rename offset constants with MT7988 prefix (else collision with reset=
h)
 v2:
   - change value of constant to 0 from 9
   - add missing SoB and commit-message for binding-patch


Frank Wunderlich (2):
  dt-bindings: reset: mediatek: add MT7988 reset IDs
  clk: mediatek: add infracfg reset controller for mt7988

 drivers/clk/mediatek/clk-mt7988-infracfg.c    | 23 +++++++++++++++++++
 .../reset/mediatek,mt7988-resets.h            |  6 +++++
 2 files changed, 29 insertions(+)

=2D-
2.34.1


