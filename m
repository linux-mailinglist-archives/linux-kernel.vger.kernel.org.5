Return-Path: <linux-kernel+bounces-56343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BCB84C8F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E5F1C25B7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9511772D;
	Wed,  7 Feb 2024 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLDG4Fqa"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423EC182A7;
	Wed,  7 Feb 2024 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707302982; cv=none; b=JCStCxA0S5azDfOs5wABiYFRJHHsgpOwlxm/TJn6SGSQalxd6VJectuFpjtiR8oA0Xdjv71MmKaKstvo9erIsWRvDHrZ/ZZb2aQbp+Ekmyf0NFoXS8wbHwx+XO0qhC07zBpg6TpS5ntDY/oCQiTPaJ0H5H+DWiKtM1+SYkZ7Y34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707302982; c=relaxed/simple;
	bh=kt0zOLTcL1HWHJnw6yZryV/wCuD7xd1Hb506uXxvfuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cyPsMinuwDQnNBT/rkBxPPRNHybdDO/lZ9rShCKn+DR6PUHhhzQdPtsr/RlVNaUc+5XgAMfing+xOAurs7bGdWTVzuJdZvRDc2PFuvGoM9jMpsyGAguQwUc4/OBcMlkXn0V447GA2dL2mwcXIQfJp8Pp8DALfxcDo3E1Ut9DOK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLDG4Fqa; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3394bec856fso922575f8f.0;
        Wed, 07 Feb 2024 02:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707302977; x=1707907777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DI3W1hyqaNPdQCStHZpWr3XfLdJcYQ1oBBj7o4zZK5c=;
        b=SLDG4Fqam5VFt6KXe+6E42+cWV/LZmj3bhH7Yqkb+i4/fcF1FOdqlweO5eOAA7fSIL
         KGfSkSE0gl5Jn4fMz6uklqz6zvCHtaeGp1mNNLaX9B76cMtes4zLrElEPUHj2dDJGPcz
         PSZIudf/11phJPnazlzzOWginpC1m3E5397Zjh/5J/xUZEh/GMMUw43PR8KjPVPDFxuK
         1LfAN52rinZRNeHo9f8DHCZR5rvih/DU2ZrXWcrz8B2C2Sz6IYOEAcal5VpHIUTR99iM
         dIe0WYFMid0EbDpgjKCQSz+PJTK0OzCSKsv8//v2LJUlswoAIqA29hisQDq3/EqRdOUB
         KyZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707302977; x=1707907777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DI3W1hyqaNPdQCStHZpWr3XfLdJcYQ1oBBj7o4zZK5c=;
        b=oY1yqSop/VP2D0Wgyr0fM0L0nf/itEzS9F+l3bVyzmLs89sA7B0chpVZgW/BSZ9FHQ
         t//4UPdRj76x8JJDoSIMhDE4M1uwEUV5O4aDeCossv2DfAXjqS4ob/YaVoDI8soAceUs
         Husj8SD/D6Ec2QVvYzkhAwYNzNEQoYZ/4ZQxtpZug8AQpBp+J/Ea1AOrc/6gkfbUYq0l
         +p57qIEI0EeA5c29NMofsF/HT76RZAs1Kk3+o5faz/U7/yacV1cDVkVqPoC2isaoau2C
         CLnvx0CxdQyow63oAz0Qi8Nj1kDhBfXMpTMmd+77s2RXF2TQBAq/0EABEX+CE2gQt+jw
         steg==
X-Gm-Message-State: AOJu0Yx6pYQMmLthhVIQD8q77XxlqApTXiRBFFsze7ycizUGBJNjETMZ
	UhKPdZ4L5tCeX8DTdGBC7puruGauUpQBLvm875WJ10NhwDd78OEe9bVzrP4emeY=
X-Google-Smtp-Source: AGHT+IFBxJGUQtRyWwApXmHdgtgFEploDEBoyVbUXb2bfaM1oo+4vxt3Cr8vTBEkawOWZBKcIYEIBg==
X-Received: by 2002:adf:ea01:0:b0:33b:26c3:4fe0 with SMTP id q1-20020adfea01000000b0033b26c34fe0mr3412621wrm.6.1707302977122;
        Wed, 07 Feb 2024 02:49:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWChfYQ26ruVxK/0C+NL6FTtor+PbyhCshRbuHxK8X0y5jjJGNtBwOsezz1J/QSknBbupMQafAMH5HR1fwBQTR9ZKXjzkn2Stmdw2BwqlXJrqXbvMF0snzT9/NxqOPZuWESxjPQ68s/aVGtbXEJN7iSJrxQ7e5O+qSjtmK/8cSk+NxHhdJmEQVj16sBBtPgnePJ8z3di+uhYiBEPQ==
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b0040ff2933959sm1689595wmo.7.2024.02.07.02.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:49:36 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] USB: serial: ftdi_sio: Remove redundant assignment to variable cflag
Date: Wed,  7 Feb 2024 10:49:36 +0000
Message-Id: <20240207104936.2441424-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable cflag is being assigned a value that is not being read
afterwards, it is being re-assigned later on. The assignment is
redundant and can be removed.

Cleans up clang scan warning:
drivers/usb/serial/ftdi_sio.c:2613:15: warning: Value stored to 'cflag'
during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 13a56783830d..c634d345a652 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2610,7 +2610,7 @@ static void ftdi_set_termios(struct tty_struct *tty,
 	struct device *ddev = &port->dev;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	struct ktermios *termios = &tty->termios;
-	unsigned int cflag = termios->c_cflag;
+	unsigned int cflag;
 	u16 value, index;
 	int ret;
 
-- 
2.39.2


