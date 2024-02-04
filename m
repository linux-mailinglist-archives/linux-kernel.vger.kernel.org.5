Return-Path: <linux-kernel+bounces-51555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF70848C73
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4153A1C21B7D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F2318E0F;
	Sun,  4 Feb 2024 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Z945rQk3"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1DB18AF9;
	Sun,  4 Feb 2024 09:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038718; cv=none; b=KOU+QCl7IXAO2jbAI4U4zY3XmI+vG2CPVxsrJ5m7bNymZa+mBgjlXcNi7fsEbmjWrDnikERvlzswcTxo9X78DhP53jVZRfm0N0pMWT8D3psIa5Ob3AuYyK+GDVaJ+aU2mDdvdh5UsmJyLF2SiX2hQajpjIS2VFGOtW2NEbrvlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038718; c=relaxed/simple;
	bh=L+SBHnTFrcVv7PLbgFrQDDLQa46+TpX7A+SQYuU87gY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Jd7VP3h3+5Uh3C/rJptJ5OLBt/uvgjRtuyCZBg2EGXoDHrGpHk+xXMtoTJxjLlS5/CzsZBB51SMv84wnsuiCQ7paq8JxTCrKNLrxgpMD2T3R07ya/ZgEpTSbspnveqUe+D+kJlNQGsmR5LpXkgcT44v11XLoCfMu2Xcw5PaUINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Z945rQk3; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707038683; x=1707643483; i=markus.elfring@web.de;
	bh=L+SBHnTFrcVv7PLbgFrQDDLQa46+TpX7A+SQYuU87gY=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=Z945rQk3E/e1VWEpucyOMf2TzdFgA4wu3v7CYyCKXhrv86by8qs41LXqKMqdHfLJ
	 a5Y14MwXjcz5oiZcUFmnHglTgqRvLeMMmnDxzK18B0ejEqlQ0OZzOfTEWSx10Xetq
	 NpDhRjyf5cVk87M1UiC5A30L1dYg2TKQXrJTb0RYsJgc3Mea4fE265qnFhBnnKC3E
	 BzGwyVbFVi30Pa0EstTvAxi+jUaTBSAaMggcdHUKLFso9xknHIorHCaBDoHvNLL4d
	 c1+MAX9fVLY8hEWIhCqkxlbdKapbcft4sNFUFVz0rbAl5W1ev0k+Jp1wopwFaWb9B
	 r5WnjPRWgNvd9ci6Pg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnX1L-1qnLyA2ijV-00jObn; Sun, 04
 Feb 2024 10:24:43 +0100
Message-ID: <82a0768e-95b0-4091-bdd1-14c3e893726b@web.de>
Date: Sun, 4 Feb 2024 10:24:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bjorn Andersson <andersson@kernel.org>,
 David Collins <quic_collinsd@quicinc.com>, Fei Shao <fshao@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Peng Wu <wupeng58@huawei.com>, Stephen Boyd <sboyd@kernel.org>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] spmi: pmic-arb: Replace three IS_ERR() calls by null pointer
 checks in spmi_pmic_arb_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JIR18CQbfq2KoktASMY5o/PlBmGtDdq5i5IxWoIpfPzIu8DQsYo
 tLYokQ6tRJRN2HwsgJW2s/gFW/asrmfiQNz3LJDZaX2ld2/Tudu0MQyNAuTA3yxK/Lr9ZmV
 +dIeIvN9XDcGkC4ZEjQ8CtENhtCXUDIkMYv2NQX8XQzWVpIsrF0Kw7P5PmHve6VAyfk6VL+
 DeKac0TekDEoB026/kkoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vQncsZ5BOhQ=;t9WJT7hmIaKNMsh19fZe9gab+qf
 1bj5KEtNlM5jYr/VYMBeXzGe3Clz+1gBewcBuh9mIb1PdQ1RXJWcGgrg0J7fUVEkEQrQ16DID
 CWTjIxY6Z41Z6k42ccXpDGpq81LC6mJesscSkXEU6UUgSVgGcHg0HieV4Ydotl0Gq37qzCKw8
 6i8FGA5mAhkG7zk6O2IRnpjyV0omdioRfWbNxJRWPwvPumJpCwHM5KpRl9mA+jZJwFvg6Xrsn
 LCOJg4q5xMXbCgz3tQh+LV68BicXgog3kSeuJnaGQRcneIjaZNx+zACK2tay6tza0+NzsPb2l
 MVj5uRHmAo24oj4s4MCdraU7a1+VDTYYZe99rGxYZfbsJ65xwLz9jdJ5a5JPJwPYRCoHTPBRy
 sZhj3INglw9F8svsHFQI5pkyYkZjsA8ubIFIaPj+GQP0AD1a0JBtXMSMNqkobViGh++hHlhvc
 FwhJnUZgHMbtRuS4SLR0iX5Zhjn+n4IZFzeEuXzZRvvwP3j5UEzlrwbIBGKcjRcAoWlGEiwHm
 v/1zbykGKkp+ZjhOeN4AK0TDcmqkmdePk554eCT5MDA5rRSevoChrX5ITxsNZcMgmYAH25H9p
 OiLY9crNgPOaQAuSfeYVrl5gFh9hb5ZAoXapHNKmzappsCKGAkW9aWvU29UJqMpPLoSsdYp8v
 b+a+wbwWuwX00r4+DL5PJyloIkY9gOC+u1WWeq6RwEW9R+AsT1bBVj6pJ3UYTYPlNPLLSnM7g
 BOLcRbP3q1e/arVTusNNSJCe7aFgrnwjpS1J9H3fWffa+gWPegBQxsk90piiy40p3oXi5yS6i
 nAyoq2++deWVzBsJKr06XcbTTCMK0twU+WeXkaxD5NM5U=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Feb 2024 09:39:48 +0100

The devm_ioremap() function does not return error pointers.
It returns NULL on error.
This issue was detected once more also by using the Coccinelle software.

Update three checks (and corresponding error codes) for failed
function calls accordingly.

Fixes: ffdfbafdc4f4 ("spmi: Use devm_spmi_controller_alloc()")
Fixes: 231601cd22bd ("spmi: pmic-arb: Add support for PMIC v7")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

See also:
Suggestion by Peng Wu
[PATCH -next] spmi: pmic-arb: fix a NULL vs IS_ERR() check in spmi_pmic_ar=
b_probe()
https://lore.kernel.org/lkml/20221115090927.47143-1-wupeng58@huawei.com/
https://lkml.org/lkml/2022/11/15/197


 drivers/spmi/spmi-pmic-arb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ed1180fe31f..937c15324513 100644
=2D-- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1462,8 +1462,8 @@ static int spmi_pmic_arb_probe(struct platform_devic=
e *pdev)
 	 */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core =3D devm_ioremap(&ctrl->dev, res->start, resource_size(res));
-	if (IS_ERR(core))
-		return PTR_ERR(core);
+	if (!core)
+		return -ENOMEM;

 	pmic_arb->core_size =3D resource_size(res);

@@ -1495,15 +1495,15 @@ static int spmi_pmic_arb_probe(struct platform_dev=
ice *pdev)
 						   "obsrvr");
 		pmic_arb->rd_base =3D devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->rd_base))
-			return PTR_ERR(pmic_arb->rd_base);
+		if (!pmic_arb->rd_base)
+			return -ENOMEM;

 		res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "chnls");
 		pmic_arb->wr_base =3D devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->wr_base))
-			return PTR_ERR(pmic_arb->wr_base);
+		if (!pmic_arb->wr_base)
+			return -ENOMEM;
 	}

 	pmic_arb->max_periphs =3D PMIC_ARB_MAX_PERIPHS;
=2D-
2.43.0


