Return-Path: <linux-kernel+bounces-128376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F135895A12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8681F27307
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9904415B54E;
	Tue,  2 Apr 2024 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPfuw+Fv"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD515B141;
	Tue,  2 Apr 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076390; cv=none; b=CnOGdn6SooyYOKYLDNbyWnW4l3qA8NgRuuiq7kBSPlIh10SsOesn3SPcY3bwp79NaBFE4TXpPsD2i1QQFfyLQUHSzozslR9mB+VHqfqyEtc6hmfCYjuJja3MvJKKV5nZQ4g6VtX75+osUkr8zApqJhYtnJnRmcNYolX0Ihv4pYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076390; c=relaxed/simple;
	bh=E0o55GGyKHH/o4gvauWZb45RlrgSPIPaZnbulkAj3bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzoOhylxNxpLI3bNxowUUka3b6qrEIZozsJws+UP3uC6Re73EZ5ARGZeIHxcU0Soqex7WWN/QezYrrgpYIjLLIxIzdOJ0RVIjO8k20TCX9IFi91bmQ+yoHPgnFrNgUswkwQIfDuQEhsjgIlFE0AI8u1LSgyNaM53pmqhXNiX4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPfuw+Fv; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d4360ab3daso70605991fa.3;
        Tue, 02 Apr 2024 09:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712076387; x=1712681187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alTXpK3BrQdugb3n83k43FXhqCCqRob/UUjuSE7ucIE=;
        b=PPfuw+FvQC0iUsSDOCttKyEYHy3p82cWcMI0bId58jQ5CfO4Y3e3NB5hV8q3VkWAZY
         cCd97/Vx6XF48p8A0z9heJLhHCzlRFSSUFoGBSPTDRyg7EVK8KMJ/qvqZMYOtDch5lnM
         vxQ1fF67A8zl4RzHVZDNK0MHHDAXWvemR3h8zs3As3Zt80D1AGUnj0LKE3HNPOsGgkzn
         Fchh//BW7eZqZUEAaPHjs8wN7AexP+R903HOvywwM/dHtlikSmfdiiowRTaC1AlsFC1c
         7/q2PoBYPrGPUPALxyHF4V798TK60Z9QRy+dcoE+BN5qKWYhgqYFUw/oorQK0qS3kUCU
         3/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712076387; x=1712681187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alTXpK3BrQdugb3n83k43FXhqCCqRob/UUjuSE7ucIE=;
        b=pI3dwawSVeo5b5+omthDWdbfk2akuquyrAqbLr9z+d0qGxX68oLH0mWpyLBBDLx9Nw
         7wfabO/4pktrVt/bQOWNeKvgExMYImxIRozY4RnaOd/u5uOwr4ngCxMoD+sRZS3ddkHX
         AO9RzN3ikyaD6QDct4IvwQkAQXwidJm/JsgwnzsuFLlKLoPG5wb0BdgH1lmjl19DuinS
         XCQFjW16EdlgFFPfkqe77ODFk2pdnwmLg8ujWS7AAStZlTGRB6VaKMfCoKeCIb4LcA77
         59VPR1V6wY+U5AlZlfro9KWNveD7JwAWkXekxOpJFE3cBDq7a6xbqCb/kF2agwGTJZZq
         mLsg==
X-Forwarded-Encrypted: i=1; AJvYcCV22Q+0wHu8G7ROgbKmlOyN9PRAYWPr45B3X7BjeMsWh/ksaAeGu9pEihZUNviITiDd5zM1+R1N9wq2gZi44XZm2inZmjZzrLtJJGdz
X-Gm-Message-State: AOJu0YybjZF8pyxzR6iEXIJcqd7ofgr9OhDBViWRrL56rgWtiozsiIv0
	C5ZAQFthDW2k6oOlias6dkk5NDAp1aE4JrhoI7du/f7Jr4mt+AGCL0TY42FHZjeR2g==
X-Google-Smtp-Source: AGHT+IGscVT48+bcbVmPHHAokWPVWlvOCpKbJcej6mOWzJLXhzcuwZ+e6oCbBIr/Q2RwMx8PB5TlMg==
X-Received: by 2002:a2e:888d:0:b0:2d6:c1a3:8ead with SMTP id k13-20020a2e888d000000b002d6c1a38eadmr8656825lji.23.1712076386602;
        Tue, 02 Apr 2024 09:46:26 -0700 (PDT)
Received: from localhost ([77.91.78.25])
        by smtp.gmail.com with ESMTPSA id t16-20020a2e9d10000000b002d7095bf808sm1630776lji.128.2024.04.02.09.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:46:26 -0700 (PDT)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v4 10/20] media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
Date: Tue,  2 Apr 2024 19:45:41 +0300
Message-ID: <20240402164552.19171-11-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402164552.19171-1-mike.rudenko@gmail.com>
References: <20240402164552.19171-1-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_fps field of struct ov4689_mode is unused in this driver, so
remove it.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/media/i2c/ov4689.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index 2354397ab34c..45f055c57436 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -60,7 +60,6 @@ struct ov4689_mode {
 	enum ov4689_mode_id id;
 	u32 width;
 	u32 height;
-	u32 max_fps;
 	u32 hts_def;
 	u32 vts_def;
 	u32 exp_def;
@@ -237,7 +236,6 @@ static const struct ov4689_mode supported_modes[] = {
 		.sensor_height = 1536,
 		.crop_top = 8,
 		.crop_left = 16,
-		.max_fps = 30,
 		.exp_def = 1536,
 		.hts_def = 4 * 2574,
 		.vts_def = 1554,
-- 
2.44.0


