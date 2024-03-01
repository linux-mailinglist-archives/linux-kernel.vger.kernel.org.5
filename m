Return-Path: <linux-kernel+bounces-88247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AC86DF22
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E9E288841
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC26BB2D;
	Fri,  1 Mar 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gQL08X9N"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44CE6A8B2;
	Fri,  1 Mar 2024 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709288450; cv=none; b=E+ZF9hn+escPVv4flC2D1ey/OlxB5U4WxN8c4/jsOSjLCyG2CisOswIUfw/YtyLBPxrWjTCZ8So5dG2GHzxhhO0pbanddAZBwML8vFoWQbrrSvCKAf0J+kzDDtOeLFdpN63JR4W7MoUtOddDK+1wn1SMRO44YqqxSl8gmFIodls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709288450; c=relaxed/simple;
	bh=XnJJ/DuVyMNtN8i32SvT66PU+gRXPYlBC+UZSbXhbd8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=g8QMmfTmeZGwv6/kBj7UZa5EBXvvvAkyaSz7vLMgzUUBBkkNmNdPxg70Kny/wl7lHy0gqCH4IuU/LhXa4geSb9aTHF/8b+RLHvUOn4eOgLB9e8xma9YwwGDXhl/EaduGhq5GgWXso5gqd1sMhQWo6CC7kvNyEGRKPTv3XSGHEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gQL08X9N; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1709288428; x=1709893228; i=markus.elfring@web.de;
	bh=XnJJ/DuVyMNtN8i32SvT66PU+gRXPYlBC+UZSbXhbd8=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=gQL08X9NVZrlig7gp98I8sAQQ+ORwftbgdpTa1m8Uptvcy8tht4oBE7lY/vsfF3l
	 AyPwgJwKIQchKpfjLjokAaobUq6c5651QfcvPPLS+6IEDxW9F+Jnn1T6fVAGerb3o
	 IMniBYazjqp5lBQynA/Upo+/jMgY8ahE8EwirFFoIzbKBNr0fPho6TPqfati8Zo2V
	 BuRfmX/FVPCqzR3qwMyofANOPRZFb039RGSB4RrR28R4t8/EUC4kwERp+wS2yB1ya
	 Wcxt88zWTJ13moiQrP9vnzCpXxkgTd8WC5cajxncjK1eyOOhIwrmsSuRRbWtNU7Pt
	 y6ut0OkOGzBZrA0VmA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWzD3-1rLy0T11Qn-00XR2t; Fri, 01
 Mar 2024 11:20:28 +0100
Message-ID: <0f98e7de-4351-481f-86be-e573805c82f6@web.de>
Date: Fri, 1 Mar 2024 11:20:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] media: microchip-csi2dc: Move a fwnode_handle_put() call into
 an if branch in csi2dc_of_parse()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3zOeZeLgrJuL3S2I4zME9Gi1I6z1I7OFnDgqu8b0tQcvJuw/wfq
 KywAjCJ/m3Z2Uk3RmerBE6XUwv8gt+hgHvajIa4YPSTe7eaLDrk4D7VsWyTgPXKe/8BD4xs
 lIReWa03QBnUHUwmNxkmO8nBscbmkm/Ok2v17CdcqwyLBdXJKzg4lXGwGq/Xu0xP63ofgLx
 eJVYeOTDAg6Occ8M0iCBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JrS5DAV2alI=;swQcZg+CJenRsuPdDlrFOqKYLWe
 IQwCC05aq9G3hpsqYg1nFlYiiWJdc327P0ltpu7CVeNMyBYP6wMEuqlyjot/z48qKJ7MRzw1W
 BjWo+4GGfwv59c7HlehR09jT0L5vmqv9dmIQVYIO5CjJa4zSOehu4c0FimLE9jAUFfPsbmJ1d
 SmfyTR8Ugpz57jm8hz9RXnN2/u8Xw3B4VCQIjREyP2RF8Xoi9NVLH8Mtp67jiUZNdt4NRV6jS
 sKLhsbXT+2e/oRsfsgf6R6d/47CjOY0oRmzKBXr+57t+XLYTlkTOq6Bdc3BFuhivPXN+sdHTA
 CmYnZn2vePUlSjAkWlnoJZhEEGb/RoV1JUPUfc5dPrYFYpNY1Y0KzCyHaSmYLC+uavyciMIDk
 vib/7NLq16AtuhPEGXgRZmNdpRbKl5xLaIuIFeSx/v7Wzm3jBnU1tXt/J4hrkhvo0WJYDl179
 LVvPh5jSSlxqfkNO383iVI9+7ivNvoewsf8/muQnrVxx99jMr7+oKiPoHmPSIWUY8RM0oR1WJ
 MUVNlxxnQVFcu/KWEv63IXdhZsuqmeANAdmvJd20R7ORTcQNVpryYA0a+MHOncLaNemdJBEAH
 VzpK8ZoIjVaWrWvuMfJjZDv6gYzmmfUxM7nfb0+PV1t1XXd9yHslBfVHQs+DJuTz3iLzV+D8c
 2QNpPR/HDxfH9Aeb7h3n4t/s4UKejBSohBENS23CeP37ONMYmUCwi6fofhFZxY6ovkBJzUojq
 13wgf6mxRHlYX7YdY1n8zdFSOj7Mgi42eM3BLNJxJEvYipT7EWqQrxCoINlBTkAE8Q+s5zicj
 VflXJolFyYv2rjf7xVTMs+TvO6KOTUTpzSDc655JLUHf8=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 1 Mar 2024 11:11:44 +0100

Move a fwnode_handle_put() call into an if branch of this function
so that the control flow looks a bit safer directly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/platform/microchip/microchip-csi2dc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-csi2dc.c b/drivers=
/media/platform/microchip/microchip-csi2dc.c
index fee73260bb1e..ed800a3bb268 100644
=2D-- a/drivers/media/platform/microchip/microchip-csi2dc.c
+++ b/drivers/media/platform/microchip/microchip-csi2dc.c
@@ -595,12 +595,11 @@ static int csi2dc_of_parse(struct csi2dc_device *csi=
2dc,

 	output_fwnode =3D fwnode_graph_get_next_endpoint
 				(of_fwnode_handle(of_node), input_fwnode);
-
-	if (output_fwnode)
+	if (output_fwnode) {
 		ret =3D v4l2_fwnode_endpoint_parse(output_fwnode,
 						 &output_endpoint);
-
-	fwnode_handle_put(output_fwnode);
+		fwnode_handle_put(output_fwnode);
+	}

 	if (!output_fwnode || ret) {
 		dev_info(csi2dc->dev,
=2D-
2.44.0


