Return-Path: <linux-kernel+bounces-35789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2742839690
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E3A1F27D69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ECC8004C;
	Tue, 23 Jan 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Nw2HZd/L"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774467F7EF;
	Tue, 23 Jan 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031557; cv=none; b=GcPzWcdGmbMdUO5IrX2JFg54AWcGXLwEaTyu1aJ/9fPygVP3onTG8GnvhZWUKFHdf/GzxIaTB1qVQC5+Xw+5ciGTKLWfefNaqOaOK3wmR9HTCk+UbTqBd35SATLBxBUArUHxbVMjRRtKKJul464m5CyWdsr9gd1ihPL1xENy2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031557; c=relaxed/simple;
	bh=j1oHpg4MxoWTUcQaZ1olHovNZwz63l8U9f6+pGJ2lyw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NdK73ik1GvOADi5RSSKAMoYJ8ehF/vkoo9IiMvY/KIBquoc6sylWbWreqBSohaPhp5QdoyhIw7xMp51a2+1E4Jvq6YSdKyyU0jFXvnT3lkZ+gJ9ifT/sLz/ImbeGYc+dXTd0etHczQAyyDgOAL7PBhfKO0PxN2ntAARe+5L/AVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Nw2HZd/L; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706031525; x=1706636325; i=markus.elfring@web.de;
	bh=j1oHpg4MxoWTUcQaZ1olHovNZwz63l8U9f6+pGJ2lyw=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Nw2HZd/LI3K4FI7m1djjISxf6D2R8AsLKI2IdRYiLQjaQOz+0+3ICR2TYjGwhbpk
	 ZPhTPvKYLyAC/nqzMkkSjEd3bevz2F14muq0IeWoO8OFuPJ3yg+QJBbbjxCwLCAok
	 +aJKbbhiPJqcvS9QTe8Vi6NZRxgiooUInYhg8X5hgZ/ckHuXCNCLVTBQSOmH3dfEY
	 SRAh3GMLyLOXEs2scYvc+2rJTWPtizR88Csme1ig260izjVHz4swSiGfyOySMgTrv
	 LHxMTt6kcr21wcIg/O2QZ3VSToEPm9jSuv67uOr0fCRUfLTkSCi46CqbNNEG+4Bvh
	 LbItnEetlFd21npPdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01Za-1rDGct0iwQ-00xLW8; Tue, 23
 Jan 2024 18:38:45 +0100
Message-ID: <0b2bccfb-d1a3-4c2e-b1d3-159630edf21a@web.de>
Date: Tue, 23 Jan 2024 18:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devicetree@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>,
 Rob Herring <robh+dt@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Kunwu Chan <chentao@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] of: unittest: Return directly after a failed kasprintf() call
 in of_unittest_pci_node_verify()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WJwV0X4SrkIl1x7eYAfuuKIkzEKEjVLiVLm0xDpc25U8/8a10oS
 HHTdw0wX5QhiPucq31noLHuJuWuBDRwZiFpTIJkm5aD8Sj6bCIZ/D8L78e0oZL3kIh9SN/W
 ay7tDhJjCR6DysJFGjWY30id87NXbT/1v7BLn/VZHDEIKC8syGy28HKNKxoPIiDWvuoh4BC
 rMul1Funyal/SvX/IXfeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EEXap3aLt3M=;C/95zT7YksgzcT6MP9G9p9xmZei
 DASbxD436h1QydtkXQyROSGVV5xEXam1Yd9yzAqJW9ROwU/q2aBew0s4Hwqy8mtH6mgMHw2Tl
 KqiMoBwK6r3XiaOrijeRkXE1nLR0VrgXO3jjRfkKXyhsRSXNHr263qGi00xQXu+5BNYZMWxvv
 JVF4c/R+GVBIHyGSM5xL92x7kOsyha+zH1u7CFM1RsfA+L9Eir90TyRFdpz3cXBO6xqIgJ1o/
 aeV9OLSFvjPwb4kub+nLLePpOezeRBZYjNqqYQg8u+fKMPypczMOeRCs0MgHaWnKUMzFpPR/Y
 n65GEiAtWtEw+loJqfOboFqxpcz532UGGP7XxT6tm/RjTf7tCpffpVjhxRhEm9YYX4PAJ176Q
 EUb1EGMGKdwT24gff7zlbLMgT7cmc8p4iWcel22FjN2uq0VWoCE3gHyIEkAvHOQakSK6Vwigd
 i6YoJe0Rq6m4t5Da7W2zjB2p9OPDWAx3DFQvEUh07WtyoP6Ld7rGYuwB6FgoJtEdWDqLKebdt
 eT4/9QylULvP3uiIxklSszotDGNW/Njyjn4o7ITkn2QpavdAZ14YHcO1uHBVQ97jxoJTey7uq
 axoo62QKRBoo3UPX5fVvRz99n2Gl9PSKBSmyAhrXnBZfPwDfYnCVbnoc3dqlBSmrijyQh6Cke
 Fm3e4l3N8yGK03jN0kOZaWvjHOyjuOsW4/RM2firIHTx/sp0eEOVhacOZMoeA3YqnUZ0zylkv
 YOc5nLL0SeyMZoSl3QqKRymSu2PnUI8NM1y5Fa7fPNm2KMdBtubmTl1bF0Y0ugGehfxFTIi7X
 HoxfK6ZmcUrLIukBKhFvdKVJu6KDKWR1UuHjNORT0GeoF+BEtGa7En5KNJs0rv9+mQQAJT+Gk
 XqFzjn8Tx4FtDORsSn+CLBmEUGas1RZlOCyLcGJh0Pp+KxXahOp4pOzMEfP2xZKpAZChlg1ir
 cflSnA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 Jan 2024 18:24:53 +0100

The result from a call of the function =E2=80=9Ckasprintf=E2=80=9D was pas=
sed to
a subsequent function call without checking for a null pointer before
(according to a memory allocation failure).
This issue was detected by using the Coccinelle software.

Thus return directly after a failed kasprintf() call.

Fixes: 26409dd045892 ("of: unittest: Add pci_dt_testdrv pci driver")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/of/unittest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index e9e90e96600e..a46268fe8d2a 100644
=2D-- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3990,6 +3990,9 @@ static int of_unittest_pci_node_verify(struct pci_de=
v *pdev, bool add)

 	if (add) {
 		path =3D kasprintf(GFP_KERNEL, "%pOF/pci-ep-bus@0/unittest-pci@100", pn=
p);
+		if (!path)
+			return -ENOMEM;
+
 		np =3D of_find_node_by_path(path);
 		unittest(np, "Failed to get unittest-pci node under PCI node\n");
 		if (!np) {
@@ -4003,6 +4006,9 @@ static int of_unittest_pci_node_verify(struct pci_de=
v *pdev, bool add)
 			rc =3D -ENODEV;
 	} else {
 		path =3D kasprintf(GFP_KERNEL, "%pOF/pci-ep-bus@0", pnp);
+		if (!path)
+			return -ENOMEM;
+
 		np =3D of_find_node_by_path(path);
 		unittest(!np, "Child device tree node is not removed\n");
 		child_dev =3D device_find_any_child(&pdev->dev);
=2D-
2.43.0


