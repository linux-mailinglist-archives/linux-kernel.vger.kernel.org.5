Return-Path: <linux-kernel+bounces-70524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797C98598D8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7E51C21049
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78307318D;
	Sun, 18 Feb 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6tPhT2/"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1571B25;
	Sun, 18 Feb 2024 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708282850; cv=none; b=Qge6XWbzobzatsXRB5xgOPFdtE3CvtRAnHMlal+Qw9hontgpq0Ry3elRuWfWjq+nZ6EpdXcdZIQqe0xLaHmIncqAOUccw1HtyjEW1JTc4bBQEK30VW4jcN5+Oj2hvg75JS53LyaSWOlFQfxfZjN2WOHqc0tNaZlMxnNN5JjKxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708282850; c=relaxed/simple;
	bh=2LCv+lgmH0ansXxRDGS7Qz4W8gc7nGFuPp9Acdwiv1k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b363HgrHhZpujbiCacxtSWlI5rLUkuA8h4i16L8ChjVdWCgZcE4gZ4rRgMBhmbrcHJYgVeuPNJo2ul7L2LYG7Fl3/NjWI+uYKX/GLrQHOf6x2TnnLlryqGjNEwjpABYRTVq9P+uXV9V8RSvFUh99w3Yu7Tn4a4MkgA8wOAiSveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6tPhT2/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-337cc8e72f5so1893782f8f.1;
        Sun, 18 Feb 2024 11:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708282847; x=1708887647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDLjeqjcDDwD7/npT7DJCTwwYCyrxg7kY3LYI6eWDbI=;
        b=U6tPhT2/93tQ8fCXHSIeV585Y/nToaRCIDbhBi3cy/eHTZaPCxIMWG9StvIy9qwz85
         ysPsqDVbap9zjNFn2tc03dpKTs8swNI10WXUxGGl12UqNUEmSwrG8dU3Z0CmROvMqK3O
         xbyGKwauuqCEMh3rqmBRBHOvxKgHx2M6zK/ghbVQArFlN+nGE9rslwO7KEpL8ryFSVlA
         jIUTBQCCyHxvqtj1ZPWjDtxcaCJPI10LlQPopUiENB7wsvKAvmg4OoN4H7JPHj9fDHDm
         VGjM4W4nWqnlvZ/X9Hs+cXfXkFtQVB3WUjgTd15Warduqi6WuiVcaW4exVILWHDH3sfx
         suCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708282847; x=1708887647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gDLjeqjcDDwD7/npT7DJCTwwYCyrxg7kY3LYI6eWDbI=;
        b=NlpLjiLlLd2/TUoxtfV9cMNYjMDqF3xfwTwiEo/TaN5gElsKZP7nqkzw2zoQZviJSA
         Eh19AIet/pbYTiNolotXy77TNxVxvm0iqDBHAxvV/NDcEUXJt975CfbpDaEqsXeM3EXc
         KHtAbIt+ybUFeIZtHTMz4exei+0b0YHUC+kK9MsFD30sX6VLEIOykLOq/USPgyUFRQ15
         bOoFMuoqZwlcInupgXRHrvIgs0X2dx4f6fF8EyVJiaZ/nGfu9+kFoc2Sf20bE4qeXJLM
         IbkvNgyUoImkbsGBVdfQxxGLfnIee083mqXUAEeqoP8H3iRxAN9OAYwc5LTw8tbU3cOD
         EI8w==
X-Forwarded-Encrypted: i=1; AJvYcCVq8SbjChIOZnCaDyl9BbymZCKCHwM+xyExn5GRYbldBaug9fyTOFnJkTc+ymhudm0xdFkrF2UC7nxkhyVYaarUJ2vk5ycuc4WbHim6jIZY7lUF9VmFgPQ7WcOdfafwbquFCBZ3
X-Gm-Message-State: AOJu0Ywg1ufF9M5AHHxua2n9RHaRMVCVxvEAdnONFysitWqC0GfXmSNf
	sp0CH/+PeA9JLkPDdTKTcRfRnNANDtvmDJ9OtipK9stRv8xRo/V0
X-Google-Smtp-Source: AGHT+IFxwitGAS6HBiUwRWZSB+cXjxVP0CxCeF7k1rthCH1ddPC6fq9NlS/l2vp7W3J5qozbKlPouw==
X-Received: by 2002:a05:6000:809:b0:33d:1656:21ff with SMTP id bt9-20020a056000080900b0033d165621ffmr7979799wrb.4.1708282846942;
        Sun, 18 Feb 2024 11:00:46 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id m15-20020a056000008f00b0033b728190c1sm8115762wrx.79.2024.02.18.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:00:46 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH 3/6] mod_devicetable: permit to define a name for an mdio_device_id
Date: Sun, 18 Feb 2024 20:00:29 +0100
Message-ID: <20240218190034.15447-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218190034.15447-1-ansuelsmth@gmail.com>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permit to optionally define a name for an mdio_device_id. This can be
used for PHY driver that might define multiple PHY IDs for the same group
of PHY driver OPs to define different names for each PHY ID and better
identify the different models at runtime.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/linux/mod_devicetable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
index f458469c5ce5..9dc6f0cc26b4 100644
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -630,10 +630,12 @@ struct platform_device_id {
  *     for this PHY type
  * @phy_id_mask: Defines the significant bits of @phy_id.  A value of 0
  *     is used to terminate an array of struct mdio_device_id.
+ * @name: Optional Friendly name that identify the PHY device/family.
  */
 struct mdio_device_id {
 	__u32 phy_id;
 	__u32 phy_id_mask;
+	const char *name;
 };
 
 struct zorro_device_id {
-- 
2.43.0


