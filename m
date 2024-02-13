Return-Path: <linux-kernel+bounces-63056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F40852A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F52E283F89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A411B5B1;
	Tue, 13 Feb 2024 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQYgW4H0"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF761A708
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810415; cv=none; b=mdduOfMwf2+x7E9vC8XeXxzenH5T5pb0sWKrqya5qO6+JfOVwcLl71DN3YzngU6yL92ZCNLl042uCw0expsw+QD+r4vLPbAnQQcLn5NPJfv+2ST1UCpPTyUUItLNlWILtc1/ZQ20MJwAkSV2pJ4IVFvVja3QCJwvui6LZcu3Mto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810415; c=relaxed/simple;
	bh=CI7+IRxGYwRZ60wyiLw47yAVg1pJTOWlIhftN4mcqWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nt8/oJF+iqlzvKl7PUXPf7pG1LVkCyHxyvGKWxwqQYB95qxE/1X/j7I+D6Y4WyyK5IowBh0pYvRfElIdz6tqvPOHVX1YaAIuznv91pzYRuWLWL3OCiGaI0Tmb7yxljWZt/f0Us75UdK06cQFwKtg+dLsHKuYqIO99bYwyJ02Cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQYgW4H0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-410e820a4feso7900045e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707810412; x=1708415212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lgAC8oAHr33uPCiZyuqvH6IjPqpu++NDN80X3PJhzBM=;
        b=aQYgW4H0PxOO/+QZdYnbF6v0OlCdIHQXA2eI2TPbqMBNe9OAxKeQ5GznO29R4u3csE
         CpkRJDKJqYXxOM7VYvfxupJ4fVfTHO3MvTsonxxjgBirmzDI7EAuavdBrvjLJKTKVgXA
         FMbt9owPJ7Iq0OxR8FW+qUy9ava0cAXdO/HQWO+2is7p/lxprTbeBhxr+qqJevN73ScV
         CfS8IXY9f4ReXNv6bt2IONA5uB7i8T3LryAfypWNKpZpe0jc/cm5/NHf4s82JYOD+3aj
         YYoPNZXywWOUKD1AIvLx7KMrG1M1NBk9DyPi+HGFfV1X62ExcvfXghAFsZT0pPs7Aq7d
         +DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707810412; x=1708415212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgAC8oAHr33uPCiZyuqvH6IjPqpu++NDN80X3PJhzBM=;
        b=haP2/HBEVqTKCQNH4hYKLiL2+m/A4uD7maFw292zuilQkMh3YQDXwtMy+5zMPl8jPJ
         0A4MR/En82AZNe06ISokV0oTsjHm2+JRbqiD0oTqgbAeUAHXRXcs20hZJUKdmpiVHOW2
         0tSPhKLdnK7WWkvPQKxaXkQx2ONNNt4k+7E0z4B1IrhXSI3IprO1Ew3xBUzmSXUadCSU
         UpAn9l1xHKmtUGMuGsa02+1jN5AwigwK7WF2iyjn6aYYAe1Rd4kMjD5667epOnxgw6zY
         QxcQNny+UAFhzBXtmAwRBTZ8c2mS/f++5+Nq6txUjFRcOrhqvkwl1fg7H+HOOndDjNT4
         Qqyw==
X-Gm-Message-State: AOJu0Yxsx+8NE1mW705c6NjOjI4KPN2mRGJXM+64pht9NwClzz04pBo8
	O0D6xx3+5wn5WXwu8BoG/5ag9C/inFaJ2dUrds8DSoXKn8VszA8EBTeBrzctplEsvQ==
X-Google-Smtp-Source: AGHT+IEftBHvPo3F+NL6i6w0+3IKs7hng2i277qIsEAtBShKVbdPi0r1QMTUYQFDVrKGQUL07fxJkQ==
X-Received: by 2002:adf:f802:0:b0:33c:d8b2:5be2 with SMTP id s2-20020adff802000000b0033cd8b25be2mr608721wrp.25.1707810412094;
        Mon, 12 Feb 2024 23:46:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvZ5E+sueX5qBcCQb2ib9jxp0mJyfkLE39pgoEVgK9pJIhfE4ayJwaRsRBqmjC3K6/Y+G+4aQDQi1Psk1h5pB/en79KAU+nfsVgoR8kVDyKogpmngkjkPIoI96b1uNU0LedNQO5aGgqw==
Received: from aaron-macbookpro.. (host-92-14-37-217.as13285.net. [92.14.37.217])
        by smtp.gmail.com with ESMTPSA id bp9-20020a5d5a89000000b0033b4796641asm8894702wrb.22.2024.02.12.23.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 23:46:51 -0800 (PST)
From: Aaron Parfitt <aaronparfitt123@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Aaron Parfitt <aaronparfitt123@gmail.com>
Subject: [PATCH] Staging: rtl8192e: rtl819x_HTProc: Removed braces from single statement block
Date: Tue, 13 Feb 2024 07:46:49 +0000
Message-ID: <20240213074649.18158-1-aaronparfitt123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed code style issue

Signed-off-by: Aaron Parfitt <aaronparfitt123@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 6d0912f90198..49b882c363bf 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -480,9 +480,9 @@ void ht_on_assoc_rsp(struct rtllib_device *ieee)
 	}
 
 	ht_info->current_mpdu_density = pPeerHTCap->MPDUDensity;
-	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K) {
+	if (ht_info->iot_action & HT_IOT_ACT_TX_USE_AMSDU_8K)
 		ht_info->current_ampdu_enable = false;
-	}
+
 	ht_info->cur_rx_reorder_enable = 1;
 
 	if (pPeerHTCap->MCS[0] == 0)
-- 
2.43.0


