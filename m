Return-Path: <linux-kernel+bounces-52099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DE8849413
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05832816FD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FBC8DE;
	Mon,  5 Feb 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QvWjHthr"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5211706;
	Mon,  5 Feb 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707116279; cv=none; b=hrZoLO8/RmyQ3Xgk8WfkyP4YmpaCrPe4ss1037QtSPDlHCQzupTkjXMiV2ZnTyi44GNzCaa+WXrVUvizP3vNExbNsxf7QzIHxQ+3bwFK9yaRb2E8OO9Ogt1RoEfDQFDwK/2EfTNwYNHKPBznKGPFsIKSKQ2taCxm3p+e/9vbzD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707116279; c=relaxed/simple;
	bh=RXzTL5cG0SNesg3Afpwl70tFQ0R3QhZxi1UpMCumLjQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uVGOKwmurwM4Jr9Li927rIqdMaK0hBDV1DiiJhTA2E+kzxG2bg5CGnPDcg9seNg2kaHAQlxu5uvkq8yYJtmxIqaVFvfmUW0scz5UL/ZNoaStcoSEYP5M4la3JA87ReAMcxsZV9KEDsIwsmryAZen7w2hmhkjOjr0gX5j3mFMZjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QvWjHthr; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1707116274; x=1707721074; i=markus.elfring@web.de;
	bh=RXzTL5cG0SNesg3Afpwl70tFQ0R3QhZxi1UpMCumLjQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=QvWjHthrquehyRpFLwG1F5pcDrPRklhK9LnYcBor2HvnLea6nsAwcI/xkTyVqI/Q
	 VKoHqPT1j2ymOjazXD/P40Po2sVvODNbehgw2j0JynXh+03Aje0eVqCpaV/iJEi2y
	 wxB3Y0B90hFStOCDhPuHccg1W2uMlfkFu6HfM4WtBcbuq5K+eNr8o4R743hwpFWgz
	 ayXHg68jkb6/36U4A3LaBVTr5V2zvmIXLlOoe/YoOXTzgeiBMnN5G3YAmSj6TwkVb
	 1L28JGBzmaeGYkQ1YmG7zM4MKv/NjkL8+D4csjLqtXpCnlJG2BDRs6Wh4kBWPghO4
	 2bNFi1DvP/Cs9P6ihg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1rFd9k3jhx-00HwhV; Mon, 05
 Feb 2024 07:57:53 +0100
Message-ID: <5c56f149-baa7-4907-b7d4-7a7bf6bd74db@web.de>
Date: Mon, 5 Feb 2024 07:57:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Tony Lindgren <tony@atomide.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] bus: omap-ocp2scp: Use
 devm_platform_get_and_ioremap_resource() in omap_ocp2scp_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vICtbcrGkOM6DTuAb7WcSon1CyYkAwggSLyY7AXB6KoyVkY8t9a
 hWTtJV0bOq6D9MPzQ1v0z6jLduG3E7XX/wMa/+iTUC8ivgUw/PQE+aTVUWdX5HqPAEFz/dR
 1L8BbMxX1CehyUBo5GuDrid+lRVWpqwHzb25A2TXsW3nm8iKfpJa9oFbh7F6/TQINYSVc0b
 jbTqQs5VuqzI6YcLVRq4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:INQqPlD6db8=;ZXEMWibM6D75/q4tslfRPi0Y2VH
 pOxo0ErEDqo/i+52RjGTstVV0N8TgpVExPl6dSey/8QOFHhDvY9A7T4kPyb/T9TaPcux5OMGc
 R4HQ5WvqyqT0cqL6dXXXofbkC9M1hmPJWAXQQaFpwpc0JTVoCGP02/9NZL4jynw9QxN2mb3Mc
 8lvoW+bHzFn4kGJ1hfOP9P5DD1TjCLvpPq2ZublW1TuRZi6JFjDDQI7XMQ3I9YQv8q8P6WunZ
 XWvI1b1uD1EnwOvSaDqDh1Ck/5836hkfcxKgnJ6uSdB6T3FxDuw6CyCPq8zyQhN8K7lfsOTnT
 JxbmTZ/lsc/VYmjuPsDXIYdc0hsTb3UM0z1VJqI5obezYPJj8HKkUxXOW3CFJrWoEPYusmFmH
 M4S37zPJIE7v+dBWCt6NbGj88XSGmwxYkelwRZT16OJeJy02YnmGri1i6sB5fca2yLZaN7FiI
 7ync7JFQrL4yDNsiOznk2/ZF953iGDMU5FwsmqamhDpNYhr9Pixd0l+hWHFEmCvXF/dXVznC2
 iq43MgXrCLGQbGVo2p0VuvxFEqtWCOHVrrP3O96l3kOkUmiTO40NNghLUi4GDZNAtTQJH7R2C
 ha0qUTVMaTaMwUbby6mYtQ/IxK1ZOezhtdJNbMDP1MvyRzPNeSUrZxdxwaVyemoe5wfhA8yiG
 t+i3nscLoPzCtWidBjdp5+nkPfpNNFBUBw1RHV6EStkWLJL3buuoFlMZEIPxdklgann1ePToq
 2uAj4CyVhmEphUes3bjXPRdlFIQ1bFi5kdHdGKNoam+ddmTZaE3iafUXy7z5p2ytyKnEe/xEp
 mautjTDv4qe2jD8IcBqY9AYxz96ggG5NXMT4nfR7UFdjo=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 5 Feb 2024 07:51:37 +0100

A wrapper function is available since the commit 890cc39a879906b63912482df=
c41944579df2dc6
("drivers: provide devm_platform_get_and_ioremap_resource()").
Thus reuse existing functionality instead of keeping duplicate source code=
.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/bus/omap-ocp2scp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index 7d7479ba0a75..16d3c1807e1c 100644
=2D-- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -58,8 +58,7 @@ static int omap_ocp2scp_probe(struct platform_device *pd=
ev)
 	 * of SYNC2 parameter in OCP2SCP. Suggested reset value is 0x6 or more.
 	 */
 	if (!of_device_is_compatible(np, "ti,am437x-ocp2scp")) {
-		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		regs =3D devm_ioremap_resource(&pdev->dev, res);
+		regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 		if (IS_ERR(regs)) {
 			ret =3D PTR_ERR(regs);
 			goto err1;
=2D-
2.43.0


