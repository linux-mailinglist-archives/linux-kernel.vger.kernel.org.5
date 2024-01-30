Return-Path: <linux-kernel+bounces-44412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ECC8421C0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4E9292FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F92867E82;
	Tue, 30 Jan 2024 10:43:59 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0B67E6F;
	Tue, 30 Jan 2024 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611438; cv=none; b=baZraTDbhl6cfhJk9R7Joj4Obx67o7Hj/dXQzLaEuXlNtcxYdE+K5r314MveK8m8O8vEroLb2W5HvvGMdrVxbD99AB1PNcxS4nqijkVend7O/CwvhwZHDrE57r+smGUUYchaauyJtyRQCtQu+mRONqVlxCoCnIcB4D5Xii7WrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611438; c=relaxed/simple;
	bh=VIjszJsbF2GDzmdLEhRHO/hbtloJjxsbJ0cwUfkqGyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRBfKXuzyAJbWDdCNYcu1XdGyE2a9LW6aPExIJsh3I4W9Ud546DQWY8Pi6oT8orE/b/eTpgADzbpNp3x0Zrgr3kheDwVkK9H8Crkda7N1ESJ10Pp1seME09XBcMUp2tdWWUOF6ltbCKL8qn43sUEHePt6ZQgXJEqeOMG7to2bqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so248984a12.1;
        Tue, 30 Jan 2024 02:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611435; x=1707216235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76e9uPIeXCxDiA3pMJxXyMeHe9zGOP/nmo8UuctdYG8=;
        b=cAQISUL+tQA8iR+jf86mREVBxRoj4uf0yIA85ZOE2Ip78n3n/WTd6H1r0/e79qcN53
         u5wAXkPliPp7IWe/sA67Ybs2GzoyOKQkD/fuapPkIkTBPKwwSySY1GTXT/405lKND4AH
         JA/EO0ElAG5ll5EyvQvEcidcbR1V9eVv6SlS3AKjULz521UtImesp4u0+3vb/3oc8bbu
         ZMyedvhNC7qAOh/ETpQSgHcva0lISxmNPNT+8tujYbgDejsuuhN5jO5tLYFOKWDG6EP6
         +Y7GEV0nO1R4JiXy0GOOp0zZ077XYrTFkNB5gNDLDvpj+dUGFhzXiukRUx667MB80HRj
         IY6A==
X-Gm-Message-State: AOJu0YwvKMWOeqhqRZWLvDzTecgYmKR81RjEL1EDBjYfQHmXJOX5dXao
	GLSzwNxmyZ541Hpsm/AhC3Ao+VA91sYc3I0R3dt+E9vYYNIBttRW4El/R9UtjDJslA==
X-Google-Smtp-Source: AGHT+IE5DBnCKLOmnlpPsk6kJYKBKsXojDbNbaLqKAdFzfUBd0dnr+0ErjJTmFBd1dRKqkOqjjJ9jw==
X-Received: by 2002:aa7:d904:0:b0:55f:11cf:ee56 with SMTP id a4-20020aa7d904000000b0055f11cfee56mr3292534edr.28.1706611435126;
        Tue, 30 Jan 2024 02:43:55 -0800 (PST)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id n16-20020aa7d050000000b0055f0f643ebcsm1604211edo.96.2024.01.30.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	Wu Yunchuan <yunchuan@nfschina.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	linux-wireless@vger.kernel.org (open list:USB AR5523 WIRELESS DRIVER)
Subject: [PATCH net 4/9] wifi: fill in MODULE_DESCRIPTION()s for ar5523
Date: Tue, 30 Jan 2024 02:42:38 -0800
Message-Id: <20240130104243.3025393-5-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130104243.3025393-1-leitao@debian.org>
References: <20240130104243.3025393-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Atheros AR5523 wireless driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ath/ar5523/ar5523.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index 43e0db78d42b..a742cec44e3d 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1803,5 +1803,6 @@ static struct usb_driver ar5523_driver = {
 
 module_usb_driver(ar5523_driver);
 
+MODULE_DESCRIPTION("Atheros AR5523 wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_FIRMWARE(AR5523_FIRMWARE_FILE);
-- 
2.39.3


