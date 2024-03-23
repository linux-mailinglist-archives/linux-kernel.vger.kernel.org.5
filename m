Return-Path: <linux-kernel+bounces-112241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD62887753
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED756280C56
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 06:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F1E125CD;
	Sat, 23 Mar 2024 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XHrfy2Kv"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F01ECA6F;
	Sat, 23 Mar 2024 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711177057; cv=none; b=OdrAM9SPG6KHkLpqokOxLw3lNSNYzAkT7QYs5BtdfqUFTwS4fQzVv7lz3JzVjx6NQk9q5Kkwt4XXa/DcWFVJMfXKON99PSbqlT4vF30rOomnpTqb+Hq6lH/CD+39/mqa79rwk9EJKcrFgTg3APO1HR2PXWTkeDZLe70KpU0Ldd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711177057; c=relaxed/simple;
	bh=y2BUhWyG2HK6NoiwSsb///Wz9WQ5PTYaMBs7R+bsQKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6aW6dtC8smoTq2g8O7Q9j9H2YhldHLJFtlnXAlKEJ7VRUbmeOgarhQTOPub5lEUN1bk/0MHaY0iLMcWgj4rg/GxNzFLsnwmc58HpAMAKt61E8vR9HDuEpR9KxSvTwodcur3ai9vxXAnf+sr1LqHouTqfYtASjI04D4rrH78CEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XHrfy2Kv; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id nvJZrKeyIixjunvJnrMrik; Sat, 23 Mar 2024 07:57:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1711177047;
	bh=GqVTzgUhSwxWnPsMh7JKr/v6dWRM2rIpiyLhxqJvIk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=XHrfy2KvjpqI2gsrxiQRiC5mc3PqShjlMeYJXhoH60ZzN62+0BZ9tFIHYZVOPYB9A
	 DzRU4dISD/6Hqn4JIf+QAX/5N8gxmfiO31dJepjEYciQI0TYbNFORTbRODUUAalg3z
	 uEVDua/GKX+TsPNfp6Uz+0GqXHh2N1J3K8MsMP/STa6BbhIl4Dswnioj6HNK2m/BJ7
	 NOczLzbj7niily6rh+bLGF6mL4IgdHwVudTXOWxB3mX/ORjPBY9hVaI/jim5D+WaEW
	 aLM2Xt31V8Te8+0RRlISBfGjb4xBFKroEwiVC42n4z92JtQt85i414avwWeZveYdVy
	 9jueAhMZbbJVQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 23 Mar 2024 07:57:27 +0100
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: gregkh@linuxfoundation.org,
	jbrunet@baylibre.com,
	ruslan.bilovol@gmail.com
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] usb: gadget: u_audio: Use snprintf() instead of sprintf()
Date: Sat, 23 Mar 2024 07:57:05 +0100
Message-ID: <5703e697687e4a39059bf90659969ffc86b2cfbd.1711176701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711176700.git.christophe.jaillet@wanadoo.fr>
References: <cover.1711176700.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to be consistent with other s[n]printf() usage in this file,
switch to snprintf() here as well.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/usb/gadget/function/u_audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 5dba7ed9b0a1..1a634646bd24 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1388,7 +1388,8 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 
 	strscpy(card->driver, card_name);
 	strscpy(card->shortname, card_name);
-	sprintf(card->longname, "%s %i", card_name, card->dev->id);
+	snprintf(card->longname, sizeof(card->longname), "%s %i",
+		 card_name, card->dev->id);
 
 	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_CONTINUOUS,
 				       NULL, 0, BUFF_SIZE_MAX);
-- 
2.44.0


