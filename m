Return-Path: <linux-kernel+bounces-3589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C79816E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66EEB1F2256A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F87F55C;
	Mon, 18 Dec 2023 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="UI24YBub"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B657E579;
	Mon, 18 Dec 2023 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C33D39C3645;
	Mon, 18 Dec 2023 07:42:38 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id Kh6SC-Fsoi_x; Mon, 18 Dec 2023 07:42:38 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 5E1DE9C3F1C;
	Mon, 18 Dec 2023 07:42:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 5E1DE9C3F1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1702903358; bh=u9QYi3UK49RvCOM0jwOPRvXLix0O7m+OZA9DnyWKw9g=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=UI24YBubofICoggQzbeSMr0uvYktWGel5+4Si71HbI0s+U5MBrINJ2tp2Hi7vqSkl
	 I1BFb5hTeBLJ88Fo8styxXAPVU9AhKmd/f4TkYi9YhKhZTWTl7EduBAIzz3S8P9g9h
	 mjircdeZiQHZfh9snTFR1UYorBV+m1BjQiImgBAvYkJhfV7Sp20s7cI0+zWtAzDiHF
	 tERB0EBuABQFKX0H14ik9js1nqPMtxg1T3DnB39BQA2GCnxFu3pfkihpiu9K1OcjQE
	 pCkF77NBkuyWX9chk7MEokrAD0wq8UdgFN7TKdPo0+hhVQ+f8sz2WOxfCVdvU9OLax
	 BXiMzq2pjziUQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id wzya-KG1c6eG; Mon, 18 Dec 2023 07:42:38 -0500 (EST)
Received: from gerard.rennes.sfl (unknown [192.168.216.3])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5B84E9C3645;
	Mon, 18 Dec 2023 07:42:36 -0500 (EST)
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
Subject: [PATCHv3 RESEND 01/10] ASoC: fsl-asoc-card: add support for dai links with multiple codecs
Date: Mon, 18 Dec 2023 13:40:49 +0100
Message-Id: <20231218124058.2047167-2-elinor.montmasson@savoirfairelinux.com>
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

Add support for dai links using multiple codecs for multi-codec
use cases.

Signed-off-by: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Co-authored-by: Philip-Dylan Gleonec <philip-dylan.gleonec@savoirfairelin=
ux.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.=
c
index 7518ab9d768e..cde31fd38262 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -809,10 +809,10 @@ static int fsl_asoc_card_probe(struct platform_devi=
ce *pdev)
=20
 	/* Normal DAI Link */
 	priv->dai_link[0].cpus->of_node =3D cpu_np;
-	priv->dai_link[0].codecs->dai_name =3D codec_dai_name;
+	priv->dai_link[0].codecs[0].dai_name =3D codec_dai_name;
=20
 	if (!fsl_asoc_card_is_ac97(priv))
-		priv->dai_link[0].codecs->of_node =3D codec_np;
+		priv->dai_link[0].codecs[0].of_node =3D codec_np;
 	else {
 		u32 idx;
=20
@@ -823,11 +823,11 @@ static int fsl_asoc_card_probe(struct platform_devi=
ce *pdev)
 			goto asrc_fail;
 		}
=20
-		priv->dai_link[0].codecs->name =3D
+		priv->dai_link[0].codecs[0].name =3D
 				devm_kasprintf(&pdev->dev, GFP_KERNEL,
 					       "ac97-codec.%u",
 					       (unsigned int)idx);
-		if (!priv->dai_link[0].codecs->name) {
+		if (!priv->dai_link[0].codecs[0].name) {
 			ret =3D -ENOMEM;
 			goto asrc_fail;
 		}
@@ -838,13 +838,19 @@ static int fsl_asoc_card_probe(struct platform_devi=
ce *pdev)
 	priv->card.num_links =3D 1;
=20
 	if (asrc_pdev) {
+		int i;
+		struct snd_soc_dai_link_component *codec;
+		struct snd_soc_dai_link *link;
+
 		/* DPCM DAI Links only if ASRC exists */
 		priv->dai_link[1].cpus->of_node =3D asrc_np;
 		priv->dai_link[1].platforms->of_node =3D asrc_np;
-		priv->dai_link[2].codecs->dai_name =3D codec_dai_name;
-		priv->dai_link[2].codecs->of_node =3D codec_np;
-		priv->dai_link[2].codecs->name =3D
-				priv->dai_link[0].codecs->name;
+		link =3D &(priv->dai_link[2]);
+		for_each_link_codecs(link, i, codec) {
+			codec->dai_name =3D priv->dai_link[0].codecs[i].dai_name;
+			codec->of_node =3D priv->dai_link[0].codecs[i].of_node;
+			codec->name =3D priv->dai_link[0].codecs[i].name;
+		}
 		priv->dai_link[2].cpus->of_node =3D cpu_np;
 		priv->dai_link[2].dai_fmt =3D priv->dai_fmt;
 		priv->card.num_links =3D 3;
--=20
2.25.1


