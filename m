Return-Path: <linux-kernel+bounces-92942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF894872860
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766ABB24D88
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B45BAE6;
	Tue,  5 Mar 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="DmUTZ69D"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074D4CB28
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669722; cv=none; b=bt22j8zeB3EGnx/YwZrStJQlp7Y21Ra8Dh1vUkr7L6DKHHRA1cPkHUhKnHVdHltJsntrQYvJE4iR361uhwjtc1dda5MWUe6xQKOn5lnVv2jsjTQlcUU2YiaxV/KDruWFQfl1NSFGi8cTOt4YOM2xXEmdld1HRPfwDCVdwY37yb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669722; c=relaxed/simple;
	bh=488t3tz2oPTEzp7l/kraNwu14HhRkKjoEra3ef7epEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PEpiAJWNtEFS8A6kErkiRPd46hcODOITor99slTAZ1wx/AZ6CLXCpkm3HEXGO7xKNPCPjvEYQcWKEC4FkTkjN+wU5HGb6+dwVNj3JM81YTVei5T3GiXg7qAc8Kt+Z/qdJcSTs2/v03/RTSNcimMzQ+l1/5XVje+BGe23SyHT064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=DmUTZ69D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd2dca2007so8209585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 12:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669720; x=1710274520;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gp3w+24t07dXjctifa2SSP7Ome+LDfHvGCQdQ2YaGE=;
        b=TJ61zr8FV8OeAmEC857t/WT5/IgRgGhCeOQqCG0N7JlZ4UHaoObpDe5qbsuf47ybCm
         I6s4tToY/WI86WjWtbThe/gn/xnY0JI7Y/8aFDcuJXNellyWQXa4f8nlVSYDHh/WqpXc
         l0MVQdiVIlOsHeWaMDH68A7BzfGYjMFhFQx78AojPIkIG6ysc700OWl2GEi77TDb/4ay
         gdftx16HlskQmiwSXPARpWqkEt82TcZ6EciqrSdHb4JPXaKyFhXbQ2mC8gymJ3trT5yp
         ftDXs6Y5bcmJxibqp5OBbZKtxlDDFrlRsSPkGMtqSlPOlwfMevyEPP1oUSB3rH0FLgk8
         lkfQ==
X-Gm-Message-State: AOJu0YyKSxXxHIrA9LDJetxipL8OkgO66u69f2FARXIohIj9LKEvysZW
	T5z/XE4l9GsP2yd7lzs8fAz6l7ZhAg0S6d//k8UE8imSTKM1CS7h
X-Google-Smtp-Source: AGHT+IFpopj5ppOA7lOnzO59bjSrhNwOFvwuBYyhoBHlRLeI/pZjP6hklo2s/I+KWf4We4Ywznn/Iw==
X-Received: by 2002:a17:902:9f97:b0:1dc:652d:708f with SMTP id g23-20020a1709029f9700b001dc652d708fmr2458983plq.15.1709669719939;
        Tue, 05 Mar 2024 12:15:19 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001d54b763995sm10930429plh.129.2024.03.05.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 12:15:19 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709669718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+gp3w+24t07dXjctifa2SSP7Ome+LDfHvGCQdQ2YaGE=;
	b=DmUTZ69DPpf63aDXgW/HtxweQMuR0KxJZ6KlNwh2TybA7wFIzHTOXC8MnzW8VDjFlRcWFJ
	tAlJUSRiWogyk/5nPeLKbAKekqyjkkE+cOOewUL3pasLv05jE6BcM4ndi2MBytE+DMtDi5
	G2ACy2F9ulTnWMA1fkKvlvzb8DnvdWe7oCfuGIptSahvS1+wvITZk5ApXl67+tK9OyYye+
	YLyoYt/cs19RpSq5/evfaizfjn3veu/autwxNj/7BJz2X2VbroiNC0XBkN2tIAft+L32KQ
	kNPY8PIO2pXQK2lQf5yymd3BzIfVFG52M5UlqBPuAXyO9p1yY4wQEsOZinubCg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 17:15:04 -0300
Subject: [PATCH] rapidio: make rio_mport_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-rapidio-v1-1-0c036139704f@marliere.net>
X-B4-Tracking: v=1; b=H4sIAEd952UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwNT3aLEgsyUzHzdtGQzwyQjA0OT5LQ0JaDqgqLUtMwKsEnRsbW1ANx
 IdzJZAAAA
To: Matt Porter <mporter@kernel.crashing.org>, 
 Alexandre Bounine <alex.bou9@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1656; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=488t3tz2oPTEzp7l/kraNwu14HhRkKjoEra3ef7epEQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl531SzXCe2VPlUr4QpjJXsUlT0bqYOdyN4xpph
 xNU6Pb5MGiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZed9UgAKCRDJC4p8Y4ZY
 pt/VEACuIP3/Fl9M292MxtPkxjzIJz9gV5EhxkBiZlyoFXYg3oP4IjeAcJBnMagCCT+EFBwm/TH
 kOzJ771GIaKgtw7fuwz+oTljtsJJf3uz/R7LUBTOcmjgP19ADOMLwxggLoPE6TJXtQKAyQPpV++
 BWM9ViM2hHkbuDqYOalH9Ly6fs1N6elWzIgE3qPpBNrBB4Ls8ziDyvK9KdUHYyUiGCLx6QmIY3w
 rdL9xeyvYghOBGh8XJoU0ivgqsHtVb7q/TEXVL1VTTU1N8nw3tXP/8IuRiGibLpwjZ+jUe21SCX
 f19VGaSDNZn/37SUt4GVkG/FmdJpQnj2nnFUA6tKlmRphfLmeR5xfIRFC51egeLqjB9R1w8WecH
 dKsLRi2guMlrYxh7VDdTJBI8Y4sA2ggfbKxApfFFnL1jTnEQ4QM49BMV4VC8epQJC7FVAAcxpkK
 kwfYvsaeedtSAYZSqxd0dQ38taIKf+EAijnY+dnj+yuHLBoNjlrBDVVM/p4/JoXtmMZAGcztzgo
 klTKln+79R6iW89UZH4OqUjwoAZi2vbMuShOuCTIpUQZM3intsUoY7tB97NYsP5sq/2kW/w12j1
 nvMAy10FPJmhiEFJfkBFIXgoZvFDi2UISjCULPeWdGPiNnQScAMph6g1iyztHc+5r563uASqbvA
 CSCrxc+W3gz2QXw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the rio_mport_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/rapidio/rio-driver.c | 2 +-
 include/linux/rio.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/rio-driver.c b/drivers/rapidio/rio-driver.c
index 1b3b4c2e015d..9aacb5edf6b3 100644
--- a/drivers/rapidio/rio-driver.c
+++ b/drivers/rapidio/rio-driver.c
@@ -221,7 +221,7 @@ static int rio_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct class rio_mport_class = {
+const struct class rio_mport_class = {
 	.name		= "rapidio_port",
 	.dev_groups	= rio_mport_groups,
 };
diff --git a/include/linux/rio.h b/include/linux/rio.h
index 2cd637268b4f..55cebdddabfe 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -79,7 +79,7 @@
 #define RIO_CTAG_UDEVID	0x0001ffff /* Unique device identifier */
 
 extern struct bus_type rio_bus_type;
-extern struct class rio_mport_class;
+extern const struct class rio_mport_class;
 
 struct rio_mport;
 struct rio_dev;

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240305-rapidio-fc61b2014cff

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


