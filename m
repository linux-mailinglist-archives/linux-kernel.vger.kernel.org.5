Return-Path: <linux-kernel+bounces-104196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6031A87CA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922901C212B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AB217C71;
	Fri, 15 Mar 2024 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpgxlXdO"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612DB17BBF;
	Fri, 15 Mar 2024 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494259; cv=none; b=pQTdwrh4gZt6kbZUuJHSuL3QxDavopMsCE/UQAxSUUKb3ltPPM75QujWvPW3vf15+eHjTBq1ol7lHL97hDP/aLZPNqKTD7NpGbgo8vpdZRF9prkioJE3XNZMQV+nQiNh2KgEwwCaYsjIyj1nEIa6LVgMsUInW2b+oTlgr+9/Fi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494259; c=relaxed/simple;
	bh=kXBAnkGbfJNrzeLkswUtQO+dWo2m2AFzCqCA+Q4/7cA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=osUj1R9XedHABJCRMFe04Nn9cjdKjvi2qszDsXGFMzcTOKDphCdXkzZHCX5/o0T4z1DrucVosCsfFXyuvPdkO4bPlDDn2KI3Vi4w4h3ohz5F1idENXuAbuSOwsbW6NGBvRyBj3ScWnrruCH7V57HJ7+cezlZLtAHmyuAkSEi6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpgxlXdO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41401f1d665so1691435e9.2;
        Fri, 15 Mar 2024 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710494256; x=1711099056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c268dTB1nt4ioX1PYxDiUB6jGnxnnZc8CAJCFV2Kn4k=;
        b=jpgxlXdOn3GIjpR1gXmm+vdu2GR0MFHT1uVaeHBNQviqAx6WzYBMtaB5x/xCEuuWvz
         xi6p4TZs4YjdmOFkNyOAnzNsFsk6o8gdXbf//ouBxMzEFCyi2Q3YorASdGDZc5iDzdhy
         jn+3GULx2gqyhRA5C0EYg9NZ9wuMBvtX/W5XJH0RskCpa96ZohYNTvmftQjPZFRsPC3j
         zhjgZqJm5QRShUOPE1O0H7tIm4Zqt8iIemAX5kPFX+oyhbXU1Jo1jh5Z1gVeUyIOJkZw
         HYZ2RIl4SgKnEr7nHmgmgpdIW4dNIZPRo/ftW4FyireGScE4mkdMrVOsZrERHCHJVMLT
         kCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710494256; x=1711099056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c268dTB1nt4ioX1PYxDiUB6jGnxnnZc8CAJCFV2Kn4k=;
        b=LdV7Fe6MGbN+qxkfrK3KYXN+NSmLnGZ7XtcZ1Vwk8HKLPB4ZjOzYvV4R6d/0P9MHdn
         GIxkS4YZF5vW5ked/3H0VTShPWQmoEe7qamsEmn/QeUOd4PnG1cryYP4K26aHd2pa+iC
         PtMN9CCUwL8b/r0xxm5DyeyM7VQB4aR5G7GYtFr9U0hB18cGaEmdNpCpYP4ZmPhO4Xij
         Al7sODmHkoBI2QSPxd9nftbsYUvQC0YLIj0ZVWgoP9h5yqv+hBo7whznfHk5zMzg5Nbi
         k5iIgPJ9aYRPslC6S81158AvdqbWazqCF+dO7uGbNlvZBMLWqm9DZtur0MgQCtgjJXoR
         eNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNWH9fN9FL23pB4uYRNKaPs0PETWs6Q0Z8mzqmyPSaT+BMHNAI3e3C7tgBUrE9FKF49EjWZSdpI9DOT59R00U/ausV8yiGlsYznW4xhnSHUUqeeLIQIJJKv2cZEuSQxBWjJcPyio9/iHzB
X-Gm-Message-State: AOJu0YzidfQ+f8Pa59R4N0OEzZHhmYcM6ahCzGcaNyVoEAQQZ0BAT30N
	nm17cxrro+7BALtAkO0HAqloyfDIyNHDbQRI2BvOFfzWXC87d7RF6Fohw4udmH4=
X-Google-Smtp-Source: AGHT+IENWATxNF4oDreVWvt1hXlDdhhoO+9WNqt74/Tv6ejfOOWqm9MJnvUPCll3CHbAqVXALh2GHw==
X-Received: by 2002:a05:600c:3f90:b0:413:fff2:a7d1 with SMTP id fs16-20020a05600c3f9000b00413fff2a7d1mr1050979wmb.29.1710494255707;
        Fri, 15 Mar 2024 02:17:35 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b00413f3ca39easm4262167wmb.5.2024.03.15.02.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 02:17:35 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tty: hvc: Remove second semicolon
Date: Fri, 15 Mar 2024 09:17:34 +0000
Message-Id: <20240315091734.2430416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a statement with two semicolons. Remove the second one, it
is redundant.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/hvc/hvc_xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
index 0e497501f8e3..388a71afd6ef 100644
--- a/drivers/tty/hvc/hvc_xen.c
+++ b/drivers/tty/hvc/hvc_xen.c
@@ -558,7 +558,7 @@ static void xencons_backend_changed(struct xenbus_device *dev,
 			break;
 		fallthrough;	/* Missed the backend's CLOSING state */
 	case XenbusStateClosing: {
-		struct xencons_info *info = dev_get_drvdata(&dev->dev);;
+		struct xencons_info *info = dev_get_drvdata(&dev->dev);
 
 		/*
 		 * Don't tear down the evtchn and grant ref before the other
-- 
2.39.2


