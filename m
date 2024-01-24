Return-Path: <linux-kernel+bounces-37243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DD383AD32
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3B311F22AB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C087A721;
	Wed, 24 Jan 2024 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jLfK4Ir+";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="RqAwVMX2"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA62BAE5;
	Wed, 24 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109934; cv=none; b=LntcJpn59oG1Uh6JzMBcXyCx5AUimmXf9c4gOIBdiB0E7gQidyr6TLVqKWJpryFxdCVyWkYg48yd8ZeF9Iqq7vgA3WUs0UCnvv9CwGAm4iTkwkWtGJ5qy8re6RlDWcvf9cczMa8IH+csY2ljGVlXatU+PmUCJ8p72jE84TUQYgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109934; c=relaxed/simple;
	bh=h6gKgCOyMbUEFd07PJSrDnDe9rMzxnKmjXzcvpqKJlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXlrp0txbOmKRcvQEbpPzJRmdrGPNnSG8fp2+MmFpWyOYoGfNbUw7wIdR3j+FtBJgSfOtB6nLpMUwdTaO13mKXfmre4+wl1saBcYMI3hctIX02qYN7g3zpN3QwjS8kTsIZdS2SNlUYa7XGP2/85fgfpY2Ne9yJwfgVifeX09ZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=jLfK4Ir+; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=RqAwVMX2; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706109334; bh=h6gKgCOyMbUEFd07PJSrDnDe9rMzxnKmjXzcvpqKJlw=;
	h=From:To:Cc:Subject:Date:From;
	b=jLfK4Ir+PWEN6fIkcwK5gNMUQhN1Dgk1VL7yKyzUD6YuZVgMfFgEoCEImOJUD8LbY
	 LNjkWRyIcuBzTRViycy3KJF7g+jTG8tTOsnt7OWMAr0vSgFIl+10QtZ4/HGLiEzHOV
	 NkPOIxxJzBR0fpSaY5f5KkA+7HdzSZmTslBj2rOM6xfvxoqLLUFutYP9iuVeQKoW0D
	 2lPz/oSwj+IeDdmVvaSCYnxo25E/HeDxAG/WiG0cWo7XOT/SLa/NGNO5iy61pbkYyN
	 G1FhCtinZOAPvJctgoSNUb+bk4OKLgkkhJyMLRjhWJs038HjIvwCrKImQCuhxF9t7L
	 x2TOSwJZ/KZfA==
Received: by gofer.mess.org (Postfix, from userid 501)
	id C3E35100741; Wed, 24 Jan 2024 15:15:34 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706109333; bh=h6gKgCOyMbUEFd07PJSrDnDe9rMzxnKmjXzcvpqKJlw=;
	h=From:To:Cc:Subject:Date:From;
	b=RqAwVMX2dDzUvfbJsEf/2lu1BSNBVcNjxvPnCbrBPJb3OM6v3dMW4ObwXtnFSf2a6
	 F0eivZNyHX+gW6uYsgzuS1q8wFxJXahffSeOf/RgtY9r1300p9U7+iqC/WtZZbjr8g
	 Ccwp/9GX0AGIUgA1aEezGlgPHo2J2tZu18ymWcs981OQxbSxjcieHi5peFzlV4mVWf
	 t8KjgpMgws4uSGAT2ifzWrTzJIM+J5ZZRoiYV7AKfxCrXQER1EA/Xf1xTwPz1kw7Nk
	 NSuURE6ZHYifrtBY3HoIyDlfVXqmqUtlkBNNv2ciGo/hiIE7Jk2+kynnBGp7HTSzlZ
	 RYKZL/PiYZToA==
Received: from bigcore.mess.org (bigcore.local [IPv6:2a02:8011:d000:212:bc3c:1b4a:a6fa:362f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 2B9671000B2;
	Wed, 24 Jan 2024 15:15:33 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Sean Young <sean@mess.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: add quirk for RODE NT-USB+
Date: Wed, 24 Jan 2024 15:15:24 +0000
Message-ID: <20240124151524.23314-1-sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The RODE NT-USB+ is marketed as a professional usb microphone, however the
usb audio interface is a mess:

[    1.130977] usb 1-5: new full-speed USB device number 2 using xhci_hcd
[    1.503906] usb 1-5: config 1 has an invalid interface number: 5 but max is 4
[    1.503912] usb 1-5: config 1 has no interface number 4
[    1.519689] usb 1-5: New USB device found, idVendor=19f7, idProduct=0035, bcdDevice= 1.09
[    1.519695] usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.519697] usb 1-5: Product: RØDE NT-USB+
[    1.519699] usb 1-5: Manufacturer: RØDE
[    1.519700] usb 1-5: SerialNumber: 1D773A1A
[    8.327495] usb 1-5: 1:1: cannot get freq at ep 0x82
[    8.344500] usb 1-5: 1:2: cannot get freq at ep 0x82
[    8.365499] usb 1-5: 2:1: cannot get freq at ep 0x2

Add QUIRK_FLAG_GET_SAMPLE_RATE to work around the broken sample rate get.
I have asked Rode support to fix it, but they show no interest.

Signed-off-by: Sean Young <sean@mess.org>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 07cc6a201579a..6f1f0712e7dc5 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2179,6 +2179,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 
 	/* Vendor matches */
 	VENDOR_FLG(0x045e, /* MS Lifecam */
-- 
2.43.0


