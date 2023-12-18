Return-Path: <linux-kernel+bounces-3597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0727816E36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C75E1C24076
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920857FBA3;
	Mon, 18 Dec 2023 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="nDiBaC0a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737383F6B;
	Mon, 18 Dec 2023 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DEC219C416F;
	Mon, 18 Dec 2023 07:43:17 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id QejM-XcZBxTU; Mon, 18 Dec 2023 07:43:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 88F549C4174;
	Mon, 18 Dec 2023 07:43:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 88F549C4174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702903397; bh=KtxwE8Nf9NfqMzcAEjPfPhN3k9SXvXZrYJX8fn3taU4=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=nDiBaC0av/NAEKfOkNRFR88a7b2Hf8YqFUopYYAmGIh5KWvi8YxshrGtQc20z4EOH
	 18F0LZ6+Q7RpHLslDoLrzFKrIadHQmoMxvpaJBWTHGM+M5AASCzcLWXh2XTPDoT42p
	 sfiElvvSyc/gfiNxl+Kny7n6oatpIg8seUYYjO0/c5UVOgeAU+c3RXkbWOty2S0rQI
	 dgo/TA+d5fbsvI0EWTqDmOQIhJ93VA3kiLDwFkMRAoyM1bDvZr5TJyMTpgy5V1xPcR
	 LKXarcVOAqSSjvmxDzmGCsC1UlbmaMrY7LsWaC3hY020ZkN8lOpFVjHlxPtWf/zaj3
	 6M9O0/oMONPQQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id uct7dIBeWdpD; Mon, 18 Dec 2023 07:43:17 -0500 (EST)
Received: from gerard.rennes.sfl (unknown [192.168.216.3])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 86C709C416F;
	Mon, 18 Dec 2023 07:43:15 -0500 (EST)
From: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>,
	Philip-Dylan <philip-dylan.gleonec@savoirfairelinux.com>
Subject: [PATCHv3 RESEND 09/10] ASoC: fsl-asoc-card: add dts properties "cpu-sysclk-dir-out"
Date: Mon, 18 Dec 2023 13:40:57 +0100
Message-Id: <20231218124058.2047167-10-elinor.montmasson@savoirfairelinux.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
References: <20231218124058.2047167-1-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add new optional dts properties "cpu-sysclk-dir-out" to set
sysclk directions as "out" for the CPU DAI when using the generic codec.
This can be set for Tx and Rx.
If not set, the direction is "in".
The way values are used is up to the CPU DAI driver implementation.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Co-authored-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelin=
ux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.=
c
index 7b0d7df7ae27..5f8fb724e29d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -751,6 +751,12 @@ static int fsl_asoc_card_probe(struct platform_devic=
e *pdev)
 					(u32 *)&priv->cpu_priv.sysclk_freq[RX]);
 		of_property_read_u32(np, "cpu-sysclk-freq-tx",
 					(u32 *)&priv->cpu_priv.sysclk_freq[TX]);
+		priv->cpu_priv.sysclk_dir[RX] =3D
+			of_property_read_bool(np, "cpu-sysclk-dir-rx-out") ?
+			SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN;
+		priv->cpu_priv.sysclk_dir[TX] =3D
+			of_property_read_bool(np, "cpu-sysclk-dir-tx-out") ?
+			SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret =3D -EINVAL;
--=20
2.25.1


