Return-Path: <linux-kernel+bounces-87319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E386D2AD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3967A285FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0659C1361DF;
	Thu, 29 Feb 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RW+iLcSi"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2678132C1E;
	Thu, 29 Feb 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709232987; cv=none; b=iluQHQFksYie2NJ2il0+JrHCl5Hs1morQ1fcIFLL0JJ1MYk0vDaDHWSescQa8govA3FXDyBtdv1KJslHzy/Eyzs/SfjcYiFnZjdUCAJG3FYi2339KJGP8PHcdALdWNKuP9b0op6vk9zSy9vTrcrcLiPRMYV4sSrhNPwppe4BT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709232987; c=relaxed/simple;
	bh=EKoWtZULRre8yAsyfn1dkM46JTGZw1nHFJhhwMcc01w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RGdFuD7d8EAFZdI1cr1tlRIO600ELot2PqwyUBywr4mkm/T9Yj3dN7wd7GXIjznr4uji2D3atbFlaliTGqEOpfas3wqdUA+eZRXZ04X1tVMYr1NnBR5g79x0iHUiOj49t4zWuzW6lFhJ1Ifqlu3P0iGoTUeEv7F+sPiVvT76ABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RW+iLcSi; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709232962; x=1709837762; i=markus.elfring@web.de;
	bh=EKoWtZULRre8yAsyfn1dkM46JTGZw1nHFJhhwMcc01w=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=RW+iLcSiUD808cZ3zD3bg/NTr9RTIrGu16aY5OuhN0LTR/PMuABUuoeAaIES7eGB
	 VxhIJz4QQPQb8XRdIgLtLMAauYMR4DuC61QHS3UVxqlv7gJZlij7HctCREGO3LjDW
	 INrA0S6XUN6Yg4grq0XGARDR86SCYXX2KyhjEWxIVdcdMRer/Gbk9J4p07d33Aj1x
	 Rruu1caBmS5WlsvSEpvUybEab6ZRBV+BTD5CyQSoDn42KvO/B/2yZiaH8x9E+v6iA
	 VMUteae4DWXjt5gw/q8moZeMZ+NB4M14X1KIAXmZO+kDVC9AObzHYy2eA9sIsg57Q
	 w+Mkae/6PpbXZ2jhnA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MoecP-1r4X1f18yP-00oyA6; Thu, 29
 Feb 2024 19:56:02 +0100
Message-ID: <dbebaea7-289c-47d9-ba06-cd58a10ea662@web.de>
Date: Thu, 29 Feb 2024 19:55:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] staging: media: tegra-video: Use common error handling code
 in tegra_vi_graph_parse_one()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5nHI55wJDHdGpQyhkuvBJi5YqQfCTQ34RVAV54eYhVrFpht0hYJ
 dpu9AIS51aPwIEo4rVbUDLJtfkgUxasRSgpRVDR7zFZEPiHWrjypWHDp27FpQ4tG8KPiKr8
 ZsgNifA8T+kv2cMCCRS/BVc/UcwogkKQY67JZgp15hfwnnwhZztIRGMvQZseWL2AwnNj8Np
 g8bk4/kPqrA8tmfqa8XRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8wIh9N3RJr4=;roRuaNv5zMgHjQW6x4d3+75EZOG
 74AgeDDDFxXuCBhSq5CvNPRp2bsPirhPPZxPGxHPE8jOtuFJx67/052c/Y+uNG3h8tpobITmA
 7QI3VdnQzMwDtEQxsokDbc70rYfgGD2OkdzntHfBmCdMMSj96b9Qo20FfEbmFm4HjtBOBfHpf
 17BSHM39B5uH5TV0rb78dPztfbQLcXZoPtltQrrSEg2iTQ4azX0Gbps3NjjrPpurq1a/hPTuN
 gC5HIB7OulJJQsYww1RiPCg/yIDodvmwzqoRozB4n/cvTi64Qq6uZax7Xh5CV6Z/anNRSH0aG
 nC8/9VT87Tlyp99PtLmAhGS8ix51Cn1szrvf5SkIqErcwwo08aU8mRqbqei61IlDYHHB4Grq0
 S2qIwPqWbG/5uN/b6pJJFDwSHZ1d5b/HsR8Kya3uFTebWKPSUPU40Z730sKUAL4Y5/7dYfa7L
 oMFuTLCbeCQiWK6DNa9R4q74ZyPjodVmwp3CmjOAG+VN9iL4vuE3t/Z2Iptt3pmntsNkJEAbS
 TwP0zjN54m6wwoTIDBNr4LVJBW8Ssr4kdsPFJ4QUGzTRt8A0+qojnuN+Nf4pbar2xC4j2mf4f
 vL/XR3La9h+WMrLcVY6340jvYV6WI82HJdElt2+J0dbMoaCReDnCrqNadeOe11i2ZY/D62ja7
 hBzYJA8wY9/ef/bqS27fvR6Y3lUYzDbuQjbDseBRHkL8klj0ZZeUlLWIGTHOcfch3PvgV/izz
 oD9dMvZPjdWFm/yAozYjbN3Qh4MzFSwsAb2JtgMEAf9+KmBDEMTp3km4TYAsQY/imurcWDlDe
 GFp6eugJIc5b07rgr1RbRxBSYC5jMVduAYGl6xI+bsvlc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 29 Feb 2024 19:44:36 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/staging/media/tegra-video/vi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/medi=
a/tegra-video/vi.c
index af6e3a0d8df4..5a08d9551f8b 100644
=2D-- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -1730,21 +1730,20 @@ static int tegra_vi_graph_parse_one(struct tegra_v=
i_channel *chan,
 			ret =3D PTR_ERR(tvge);
 			dev_err(vi->dev,
 				"failed to add subdev to notifier: %d\n", ret);
-			fwnode_handle_put(remote);
-			goto cleanup;
+			goto put_fwnode;
 		}

 		ret =3D tegra_vi_graph_parse_one(chan, remote);
-		if (ret < 0) {
-			fwnode_handle_put(remote);
-			goto cleanup;
-		}
+		if (ret < 0)
+			goto put_fwnode;

 		fwnode_handle_put(remote);
 	}

 	return 0;

+put_fwnode:
+	fwnode_handle_put(remote);
 cleanup:
 	dev_err(vi->dev, "failed parsing the graph: %d\n", ret);
 	v4l2_async_nf_cleanup(&chan->notifier);
=2D-
2.44.0


