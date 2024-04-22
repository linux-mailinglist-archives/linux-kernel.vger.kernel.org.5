Return-Path: <linux-kernel+bounces-153455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C86F8ACE4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAF39B24E94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56121514E6;
	Mon, 22 Apr 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0wLqw2q"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719171514D9;
	Mon, 22 Apr 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792750; cv=none; b=lAK63BHGXlnwGRfKOS5ulR63eRETTa7wLk39f7vvndQ+WgmiRewdhQUCMz3rRcpLzuV67z2isHqSdFTGO3Y/7nKz5KEb3iEkNUA7QM20q2VABqcVXLkX4046pz3ceLFVfMip9Tjp2icu9RuVN4Q91/wgEetJL8YEKe1uKt4G1h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792750; c=relaxed/simple;
	bh=RG8CUzJj7liBj8gdr8T/dMNMaikBu1bs+iravaPxFvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkvN8j7HdAwg719sMOx7iihBrAEOaBzwdhX5Ml4KDLtG2Rb/k0BQyf78aV9a0lRHMMQIw/Tx/OrSxJNlFl9KNFsY853QpAmUTuptTOb9qeeQ54XEdP4PtyQ/tGHmOadJ6LB9o+RpdNBbhJXSom6QBuo+H5OaTedlfgkG1hU5Ph8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0wLqw2q; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a56cdc03so5358530e87.1;
        Mon, 22 Apr 2024 06:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713792746; x=1714397546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57zSDZ92EP3wAYQC2i48fKKKXLFnXyG79WLHf7GYKew=;
        b=l0wLqw2q06FsS2VfOar46LXJGSG+x1RJDjRZHGaKVASK2CkfkGOgvjvZmARGpI5/HH
         waXpaZXvmz9C0UXZvIb5PsCQP5TzNDNb37qSCAg8bASrC9yQsNxeSIlmd95wP0OhdtBg
         uQc8kgKp/IQZbStB6tpiT7SWtN+GS4bERQrL1HLtRtnFSYfE38sW2uQWGKJGAW6Gsqr0
         Okt9IOKCvnS6YTft/rraAdFEcHgQ4FK/W+Ac7OU4dgwFxK3+yTf6+l91xGbzvVwu6J+Z
         whrSGkaoanwW/sQZ/n3S6xDx+p2gipw8nUPZRMfCXihi91vJkUCbJxp25zlTT++E1yRe
         6XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713792746; x=1714397546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57zSDZ92EP3wAYQC2i48fKKKXLFnXyG79WLHf7GYKew=;
        b=w679h+D/bBACwptlAhGKqkqiIf9MB3O18vWvCc/bZ9UpEfsssJRbR8yLC9fWliMl6P
         3apONofvIF7EVqLOoORkwT1eyyuA5FUllF/edIIPg4XsxArYXa7cC0goYnERw3qFA8ht
         hblTV20A/x4FTtwAG9n4Zu3NMcAdfG2DKJYD+z/i57/0p67yLyif8DkJ2Fw28MtWBC+U
         Qof9EBlZS+Z4lR8X1Im1rzoJ1kSPynFWlanzWarxthvrY4YAUy2KUQ3Gr7HZlICcI47H
         l4qFZPI4ejCcApKLs5rQ3Rrrra3fPyBT69f4adZ3YSk9Q51elmfurflhiBAb8a8OHa6K
         +IWg==
X-Forwarded-Encrypted: i=1; AJvYcCVKMKzagQR+uD/jrojbYWDj0XlOnMKKJ87qcTlY62UUK7aO3sIagf1H00GWLviB4Ye0848RODfZ2icRkdvJQ3BYP9OGwJDRecBNW1wRExMXEmTFFsBCqPQdVZJrlbgD+EjG1MuVHW/dtHPA
X-Gm-Message-State: AOJu0YzTAdscOPkhC1SrWAQpaQuqKw+JH3l9UBkSYmuG+P69AytHsEZT
	OT5rMc4U6NWKOcNCYUsVTXnkF5hfsifSwkh+KKIBMDzTOnvKOrUA
X-Google-Smtp-Source: AGHT+IHTRKR2CYlW0AvsaKcGWG7HOD/2o242EPCvX7K06P4iX5kJreV3GKPeX3YcZWnRLJohz9CSwA==
X-Received: by 2002:a19:8c02:0:b0:519:2828:ccbc with SMTP id o2-20020a198c02000000b005192828ccbcmr6150106lfd.36.1713792746351;
        Mon, 22 Apr 2024 06:32:26 -0700 (PDT)
Received: from CVSIT-Server.. ([193.232.173.109])
        by smtp.gmail.com with ESMTPSA id d22-20020ac241d6000000b0051327d2f5e5sm1729568lfi.119.2024.04.22.06.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:32:25 -0700 (PDT)
From: Konstantin Pugin <ria.freelander@gmail.com>
To: 
Cc: krzk@kernel.org,
	conor@kernel.org,
	lkp@intel.com,
	vz@mleia.com,
	robh@kernel.org,
	jcmvbkbc@gmail.com,
	nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com,
	corbet@lwn.net,
	ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de,
	Maarten.Brock@sttls.nl,
	Konstantin Pugin <ria.freelander@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v7 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
Date: Mon, 22 Apr 2024 16:32:13 +0300
Message-Id: <20240422133219.2710061-2-ria.freelander@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422133219.2710061-1-ria.freelander@gmail.com>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
after the commit 4afeced55baa ("serial: core: fix sanitizing check for
RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
breaks some hardware using these chips.

Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
---
 drivers/tty/serial/sc16is7xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 03cf30e20b75..dfcc804f558f 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1449,7 +1449,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc16is7xx_port *s,
 }
 
 static const struct serial_rs485 sc16is7xx_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
 };
-- 
2.34.1


