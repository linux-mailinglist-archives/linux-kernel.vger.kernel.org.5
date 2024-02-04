Return-Path: <linux-kernel+bounces-51708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7FE848E7A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEC931C21221
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0AB1DFEC;
	Sun,  4 Feb 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="RtNHom6J"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB21DDDB;
	Sun,  4 Feb 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057123; cv=none; b=qvxPIpIaKZCSMPyQdGWTYWWwpdC6M/j1itv61qiYk1UjyTuEFtPuC7ODXhpFLV3pLE7eYGG+t3RdinV+wbVnlGyafdvEWcm0erIjOYpPfNcMOWN8urI5feu8uThwrHQZS564w7XS9gVU0BdTEuZm48GbjDhPt1SOAxVjZH0+mkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057123; c=relaxed/simple;
	bh=bUoLgCW4qDj2Uqe1nE0GJYpMsDm2UIDql8AeznRxBV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XEgQbKAlUhZdaFW1sU45ILvJ7Yha0HknXKxpCug4sQ3T4Y2g1xgZIb76Preba8iMlYmjrWRdQxbKuTv6Ud0XIfx1sqtO+vZz9K073/rU/9HaJZJFMo5g6ek9AcGRPA9WlADR7QaqlnG5Gl8QO2duqdbzB8o+dcRiRkLRLiKcPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=RtNHom6J reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d932f6ccfaso26929115ad.1;
        Sun, 04 Feb 2024 06:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057121; x=1707661921;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJ87ib5NalQBsE0FEcn0KlRmTdklRyj6MKZDkNe11vQ=;
        b=XSE/6J6/VbPfhvJzsZ/FlHAUO8v6EYlp33KHkVF8rCqeBjZZ/RDIHuBxx0MQdh7VFG
         VV+lEe7f8gY2AP90BDfOJ2O9W0u//K/d4wJbb+/apFCCRyKASUFue3/6Jw1AoqlxyR9d
         mAC7oGSUnOmrULE100qsvWxmJqWvdRuolizrjr1miReAcdjOyFh/MozcSzuVgzqpBLc0
         W3hyh+askWJOGbjoPzJ6JcBt822+O2KK3TQBRQYrnzPqZIIeytF2etmhK0M+6RXEikVW
         cOSGnH0r14OILXJ8a/fiLQXoHXAeSQc7+cL/RtIjRe7Xo1zkio6jHdwLOuoexOkU99tR
         c8xA==
X-Gm-Message-State: AOJu0YzairoAGFODOFE7zx0LPSfHByhDmQ2CuImImTJJ7DoLPv5cr8s3
	GFxdBrm3aTYxcQfRaOgfeIHKrAygDkiflnWm/Inu4W9p8WyqGjRS
X-Google-Smtp-Source: AGHT+IEyhQNXn4QBpck2IX1vWw2TrgLz30aIdddRlMaNnQcT7tliXVjDwlUQJ1m38UZfJDkdLaCnEQ==
X-Received: by 2002:a17:902:f7c3:b0:1d9:a148:48a with SMTP id h3-20020a170902f7c300b001d9a148048amr1409279plw.24.1707057121219;
        Sun, 04 Feb 2024 06:32:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXF7dcjfPQrpaAYRMjtME3iwBSs1Q4fbZFJhirIe6pbIWgx+SSTroE6plAVKKYBOrab4SdZ/IUWjpO+a9VT6+IOctPKkc5d57urZ3yhCd59ucy18m4SNMtR/XcLGhT9qKkJqj5ToOjQLElgY+V/2f0T+E1u7w1cPfHPnfMGJ22PrOQDXUYVO06kT8uhldJn11DWhFqE/ucEaHOshe/9Xfi9wtQzUwuyya8ePgoJ9bL9RpM6MOa8e2bFW67rSbkZu5GK0K+c9/EI4DK10MfFY8nnBAzM2izd8Yc=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d9620dd3fdsm4569296pls.206.2024.02.04.06.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:32:00 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707057119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qJ87ib5NalQBsE0FEcn0KlRmTdklRyj6MKZDkNe11vQ=;
	b=RtNHom6JI6RkmMeXzH6a+49AZmKXwaKkirC5Iwil6gWqfFfrxerCPDs3x9HhVd4pC8p/uu
	YGtZWqvRyBNq45ZHdycRXIp9reQ3A4xzKO6xBYL4LjUTXDJ3Nf2s/+eGeR7FDu3I3aLY7+
	1XznKspbCoavxbiyVGuaSLVt3KGQ3hfiSxPV6/sSFgiRTa1V+Ku91PG3d4SziN85n3nPkt
	fsH0dUcNFwz1KVmrNiannn//7gzJZzvGbKqQqjrIcBK7D2cfjolMZQ7ZB5pX6J+4wdY7S9
	3TemVograxUKJwp6FFiXWRzFk8K3uVa+oahbTjNLJsPiN6nE1iTRF9cLpr1gVQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:32:29 -0300
Subject: [PATCH] x86: mce: make mce_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-x86-v1-1-4e7171be88e8@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPyfv2UC/x3MQQqAIBBA0avErBNsMLGuEhFlYw2EhWIE0t2Tl
 m/xf4ZIgSlCX2UIdHPk0xc0dQV2n/1GgtdiQIlKolRiSXGyB80+XeIxWjhsTYdWN8oZKNUVyPH
 zH4fxfT/CoSCZYQAAAA==
To: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=bUoLgCW4qDj2Uqe1nE0GJYpMsDm2UIDql8AeznRxBV0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5/8537zX6l2Is1D9nWshJ9YkX2/EORuLAleN
 /gjLqYY0ACJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+f/AAKCRDJC4p8Y4ZY
 pirXEACtl2pH/pB4h7ybWOUKkAeEnII2gqhOlBGWBX+nAtEJCuXysXgk+9j1AhZBwL9bMw/bR2T
 zylkTxyMBku1o8x8h2JJ6RV6I0RqBJDFUmKYUqeU/2OQJi4aHd/WwTq0tY2hmn9DM3GVgWSXO56
 YJCMv5wipe8A6r9gcwnj96Jxmsm0/i7zOvX/4OagXRyVl6Z6nnuSUAPHHq6vEQ8TIzLE9nhfFZl
 lMwIxrrJgqZfiUQK5wP5v3v5wZgJvZL2FBPOAaMlJJcnYbWsrbQmb5caBVoRZBByRUlrrWjQzZf
 XnI7pnBf0J7TXHGp66qP17Zfm9xyBRnyFVqKQgx0Er0AybdGz5n1WGgjW48o5W7uzrIVocxCyxE
 Djn3oNXWopLiUcfBgq0sLZ9zk3AoJBsG/lcentrz1cAo4ZitxQZswB4zk1TiBExAehNgYphGow0
 1WUO8togPILVyCwCMMjG9iHAgb11M59X0WKKEZYpnDnQC/64Jm0TKLrxNUY5coyg766TFXix3s7
 +F2AmydwNtr7BFUQkE+S+5s5Wj8lJ0lyNPRCQtg++T/xBKbVMA0E3XPBFnudevmcOF/yPYIzLUx
 iHcqmlOKxavPh+NBYdQQlGobY/+HCignK7vOcF6MxiWdsDskrFDUetnAz2wqpVP+ZP07bMA45HY
 Rynio7/gPSqW/EQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mce_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b397370b4d6..9bb208ba7ff4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2399,7 +2399,7 @@ static void mce_enable_ce(void *all)
 		__mcheck_cpu_init_timer();
 }
 
-static struct bus_type mce_subsys = {
+static const struct bus_type mce_subsys = {
 	.name		= "machinecheck",
 	.dev_name	= "machinecheck",
 };

---
base-commit: edc8fc01f608108b0b7580cb2c29dfb5135e5f0e
change-id: 20240204-bus_cleanup-x86-f25892c614f8

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


