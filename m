Return-Path: <linux-kernel+bounces-88438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A62C86E19B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812D8B23FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570926DD0A;
	Fri,  1 Mar 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vAPAXPKt"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D434269E15;
	Fri,  1 Mar 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298682; cv=none; b=otGfYSO/ar6UQOnLQDMZbZnAx9Lj7pmPVT4x+wR40oGCEQYcOjZahH5I9Nx7qqbQPi7JKGBONCp4ankjxIduu4rO+Jaw7xygUBs8IHf+InvYJ+jO4yguxPDZzQHYKREHcbTfzRegoC9EiKfPZQF3ucAnLk9o6aHjgSZvq7AVSLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298682; c=relaxed/simple;
	bh=OHktGIjUm7CQdUtl/zLN2vwuppLnKIcC+CZk6F9ja24=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PSNIJ23X4srIUfYKWTJHXxnkwLsMZvb4ZrqXOVjTBoY5DbsgKhOlPHc8wsbTuqJEJZd98r+TezCa/4S4OvyHqgNlQ9VO9w4R8gqBPH2Rvs+fa2mdxMLVDG1ZtbSAFogPBlLrrsTjss13wAZahbyWpAmn722ZiIZq/5AZq1zJ2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vAPAXPKt; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709298645; x=1709903445; i=markus.elfring@web.de;
	bh=OHktGIjUm7CQdUtl/zLN2vwuppLnKIcC+CZk6F9ja24=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=vAPAXPKtfdbuQ2UfClqFlUrK7EJGbKKpZIfa+BIfGuG+lc6YU9GKusC7/BwN8hLR
	 rr5vsLZo2Di++J6P1jNKuD+pmtjbV7vssOdvC0s4joo16QDo3CGjvJQ0SpSQIc592
	 ZsirhGC/Q9d0/9a/H+XOh0QTnn9B2RCjyyu8LvHHsr49kJABlpXohV5+RUTtu89Gr
	 ESB2TDOaLwByG7l5vBWXc+QEC/UHDwrIQMg+J84dcJofvqfrCQsaR4i1OEhKnyeel
	 dvkjkiLiRX8qBDQ88+takMPKmZisLQrnCO7ueVLU3mtPv92o5WzG/8Dp8RjIcZ5b0
	 gq5Wxxm3XlixeqVw/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M59n6-1rh97Z01bA-0016Y7; Fri, 01
 Mar 2024 14:10:45 +0100
Message-ID: <c26c73d8-9b20-431e-a299-c9508ac3f6ed@web.de>
Date: Fri, 1 Mar 2024 14:10:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] media: rzg2l-csi2: Use common error handling code in
 rzg2l_csi2_parse_dt()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:araX4k2QEvajPbpM9grsaW6s3R17fGhqPxgHzilzewFkzka73/9
 7ur2SvI/96mHuYRr+fTAoXmRubf5VMXj12yiz89UepxZ7+o8XjsCpUE5cQT3KJgVfk9JpxL
 +EvPm+4nDME4cdXGphJVTbbjWXZmgAimVRskD21h1Gag11210+jzhCb/AOIiq8qjAce9XXv
 4bXGrPE44gc8+S/IzjPoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pxo9Bvkn7pI=;hrb1XBYTw5d2PZ1qJg7WXAXoFOS
 k4cqOY/kr2TeE7vtqKX23lx4h8xW1a4KqFAMTS8OSJ78+5H1YGGHAC2oWkwNxZXI6f6LzdXcR
 mJP8Hh0czfLryeyl19anj9laQ1lp+CgVVd7RUoX0AHF14TkOxSe4BuYcYMZq4m7hny/qmy40I
 /Zygrdc9PXmchcdUMWKlVvT4etJnwU8EMUuA4CoEYbOFkIvXpfzXGC7+wYeoXuQImlunaJ/Jq
 k/C24ms36Qs9BtjhS01Aka/brG7sneePI/yC9C0h8G5z07oq1zV0N0VCPSqLuOOX91UojMpRm
 azExq6WTx54HPcggzf4SE9rzXUoLzrnkTL9JbdbarHIqYqInYLqeYl2enMLfbVVb7mfyqXm10
 Y9x4X50aGEPd/RqkxDAxsYTQVE9GSpDWPj28gnjSCN/OYgJfdeuvvystU9QGttMqeYvhBPvRF
 tOeCpqN9BdH/vVZkbqbeMi0a+8FzbH9u0wHWcFyRBe0+B+n4M768+4RoiEjXW++/qaJtP2JZ3
 jQa8pCIwqX6+AkaHXI3pRgr/Yvl/FizrapmuAlaCEIOcZvQwUH5CFBckQZRTIihjXoQbt0lZz
 R+4HKIMtnO6juof1Wy4WbwQ/nkot0T/KnugpIMq2vTlQdIFUCBFEl54J9p010EBC4EcOK1KgI
 E0rAXh0r4vEu1Bd3mg85XiDxbKrdLspnc9HqdzABYR3aePL1XANhgcNaejXAPiPEcAIeQUaE+
 l4SkZFK1ZjSoYxY49NaxhNse2B3dAsNC2hAjr0PdJXyZ50lXkzFWuwxeRZbO54B4at82yoMO3
 ju6mQeOkGfIMBa6DBg067AP1xfcYiG9ulTS1X9S8HY01A=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 14:02:22 +0100

Add a label so that a bit of exception handling can be better reused
in an if branch of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index e68fcdaea207..ef6922dad35f 100644
=2D-- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -671,12 +671,13 @@ static int rzg2l_csi2_parse_dt(struct rzg2l_csi2 *cs=
i2)
 	ret =3D v4l2_fwnode_endpoint_parse(ep, &v4l2_ep);
 	if (ret) {
 		dev_err(csi2->dev, "Could not parse v4l2 endpoint\n");
-		fwnode_handle_put(ep);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto put_fwnode_ep;
 	}

 	ret =3D rzg2l_csi2_parse_v4l2(csi2, &v4l2_ep);
 	if (ret) {
+put_fwnode_ep:
 		fwnode_handle_put(ep);
 		return ret;
 	}
=2D-
2.44.0


