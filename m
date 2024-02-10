Return-Path: <linux-kernel+bounces-60564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD6F8506C2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 22:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DA9B25EE8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB58612C4;
	Sat, 10 Feb 2024 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuEo6rKA"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3460EC8;
	Sat, 10 Feb 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707602030; cv=none; b=Inb9CutVj3PoPbaUPTwBH1A8AHZag5BD/rwfuDs5JwyynL8drzPsEdYggXH4emkEqK3L0H2qXEUTOL9qYoJCofxE+lSEiSDFZjKc0tt1mOTfcTfy2DvyyeH7XjS0Dc88irCCnPltk50qLpOjoQg+m6+uihV8q0AS1V9OrMTujds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707602030; c=relaxed/simple;
	bh=6qkcHzfTU/XRV4Bz6RvhCN/NdCXvR92GNjpua2Ojrs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NajN7CdcAju+EX6V9Xbg2ZE4uU0Ez0ml1mCUC5a8I0esW19JXul3+ZlSUUIwp4Q4vyEo5UBKytLgszYCmmq8iGcD/ocFUY2ZKU0SDQZRb1ik/ABboMa8/xeCoaJ0ZIQyp3yTCb6HQX6uGIiFxLLwEcFKprAH6Hspdasg8QK4JAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuEo6rKA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5116ec49365so2295569e87.3;
        Sat, 10 Feb 2024 13:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707602026; x=1708206826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjAuDrVvrKWSGT9QwD0z4gCom14B7n2OsRrtSBnn7j4=;
        b=iuEo6rKAf197gNALM8j1OBi+k0WM7TXnSSEb0U2BR3tqlqYgsMwORHi917DtYCu/L8
         WNLrgFBUqQpGqf0DpIqf4jqejdIJ5DpFj7dFhkyZf7pAB8qB+9LLFxsXMa1M/aCZ/3aZ
         kbIZVWJs4MFwv2QdBcAWkXX/+anZ0EBxDo/OiAIBadFhnbV81BSdC97HhvoU1FaMq7NV
         N/3omvo9Ue8ttT8kqSUFWf1wNIcSSnOLIO7sBqM3ciAqMWnWSMoYZqn0YLcVREHKgRJs
         KhGFR+dIY7OOuE0qbUVUSMW/uUyILYio9sg5UvH2RTe9ZwNFyd9kkaqIk/dI6ahCDX7/
         gv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707602026; x=1708206826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wjAuDrVvrKWSGT9QwD0z4gCom14B7n2OsRrtSBnn7j4=;
        b=EjNm+9qtLOxLi0Gsi6O6SBotDjOWUkmbqHgOER4aWMJHp4b+IhoIm7f2lgKpiqxpFY
         BnRJ2LB5zVC4nxUszpEvAV6LMJ29ohoN6D7gCyf8f5d3joj3SwX6IvObsP98MXG+vTuP
         vFEYDfBM0uZabsa61j8DToiTB2+4/2EV02aEvwslciWAn9NwKCDC7PX8uf/jCq3F6VsS
         yozawHdYwpvZ6bjxgumgjwhNkco9nPOKp1k/fskoWsKiYZPlpvAjw07Hpcy3K5HmEcbu
         CB2fUDfxoTHynYR3cHhDfFuSBM+wBcjCQRLddHTYzU825pboIN4ulG6yLDPVEP/5VfjT
         O5AA==
X-Gm-Message-State: AOJu0YyclmqlWCYNgnsNaHsCjmZTzrG3TKjXt3trFVQDTLgsBYCIBbzv
	78FhGhLdbDDfoKsEyXg3E7Kd5qPKl62hgcXDxP3EpgDd6fctAzgI
X-Google-Smtp-Source: AGHT+IGUtOgUFaxpfrwJlT4SfRpkTvV7z0N3jQf7TiaBV2r+xcYI+qAhYk6KFSSK8Ecwaau4bnRPzw==
X-Received: by 2002:ac2:4da4:0:b0:511:79ee:5f98 with SMTP id h4-20020ac24da4000000b0051179ee5f98mr1803335lfe.18.1707602026526;
        Sat, 10 Feb 2024 13:53:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMxUjFQN8kLLBJFOD+xJkBq6Mqn2oPW7uUNxHYWcH65zJxGBRSqPNnEdeCvRj5eQnP6di1ea9tVhsbGsmZXI3qfQmKw6RZwMFNngFiFPu76Eb4ibI9djkr2pb36bvKiuyMCYu4s0R9tLswyQeuQc6R1KeYQgeO9Kpe8EF+79OKtfQxwUXKVbbtqrm7brhFmSDU4wnO/IDFp2so43xzlOVS2Nr3c81lR2jC7PbH2SQ3jOtmsv14NnJqXRPxO7cCCfsyVgkKiogy1gOWIRipEWEFxycfyMbKi0/eii+zZlafvsdihSb0VE8Y4thAP2lOQuuIUio0zaTzKrxt4hCeNUuefLGCr3+T+NjBZJGhwRg7T6zPHrN/Ow==
Received: from m2.. (89-139-223-180.bb.netvision.net.il. [89.139.223.180])
        by smtp.googlemail.com with ESMTPSA id a7-20020a19ca07000000b0051189b53f93sm24005lfg.302.2024.02.10.13.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 13:53:46 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: chrysh@christina-quast.de,
	daniel.beer@igorinstitute.com,
	jikos@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	johan@kernel.org,
	gregkh@linuxfoundation.org,
	equinox@diac24.net,
	michael.zaidman@gmail.com
Subject: [PATCH v1 17/19] hid-ft260: uart: arm wake-up timer unconditionally on tty session start
Date: Sat, 10 Feb 2024 23:51:45 +0200
Message-Id: <20240210215147.77629-18-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210215147.77629-1-michael.zaidman@gmail.com>
References: <20240210215147.77629-1-michael.zaidman@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous session deactivated the wake-up workaround. The next session calls
ft260_uart_port_activate while the wake-up workaround flag is yet deactivated.
It is enabled later, conditionally, in the ft260_uart_change_speed. Thus, the
timer is never armed again, and the device enters power-saving mode and misses
the incoming data.

Arming the wake-up timer unconditionally on the tty session start resolved the
issue.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index d7eb00aeb669..7f3ef4f20075 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1510,10 +1510,8 @@ static int ft260_uart_port_activate(struct tty_port *tport, struct tty_struct *t
 	/* Wake up the chip as early as possible to not miss incoming data */
 	ft260_uart_wakeup(port);
 
-	if (port->reschedule_work) {
-		mod_timer(&port->wakeup_timer, jiffies +
-			  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
-	}
+	mod_timer(&port->wakeup_timer, jiffies +
+		  msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS));
 
 	return 0;
 }
-- 
2.40.1


