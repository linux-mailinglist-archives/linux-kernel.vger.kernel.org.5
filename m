Return-Path: <linux-kernel+bounces-144907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD98A4C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7138D283435
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921EC5822D;
	Mon, 15 Apr 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9am22Xo"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8758200;
	Mon, 15 Apr 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176811; cv=none; b=bhro7OO0n+9zkn9u6EqPFDllLKEt3iSkhjnsL2Fikjo+Fltvgl3WjSiDnPXOCsLRXNO6Nvdwfiz7YU3RfLillxRsFJxxmNd8S6cjRa7ciomMmGm5R13epKCNb0GZica1tUpMmG2sWSTs50Xsc4JSInv/3+JcGobLNy17UC8edgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176811; c=relaxed/simple;
	bh=KBwUxaJXLkJmwZy66zxwcAFRHzuP/1lN/GXZFCVYFok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Bs4+4scbQakkeLasMzkavEBv2o+lWacWaBQkuuZ67h4IQlQ7Xpklo4l7Cz+g3/z2Yar4Ki2o+1Jw6EGVlJOKs3tIiXWNlGs43G9LvxRMK4z20iRGXnZNuDciYx82DMe5KkAZ5icWQp36XeKswgLMRSDKG2QdRp1v/UYkhhVXbqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9am22Xo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2da0b3f7ad3so33149121fa.1;
        Mon, 15 Apr 2024 03:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713176809; x=1713781609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RpWGqEEM4uqV8fQ9PN2exXNk8aXKdE5yEA9kmzOz8To=;
        b=T9am22XoaO/EuI4f2nbqHEemISW9NCH64eKQ7bM9cvkaNiIE1guH5yshuXJ/4skiQz
         vmYQDdWTM/MXmmWuWkZS7eD57COOazSGx9hMOY5UuZeFl5a7GBXtFIbd1gFrctqV4BrR
         T2c8MvUPzsnLCwDCR07ydNTvuOLRqtnGv1IYjPKToMrurE61S7C+TveuqUTzpCrwdO6D
         GQuWTg8v6VMBTNSCZqTixq89YIZ5QezkJZufL+vbBCuGGmsGZSerg6qrBhXt5byZTh3o
         EL1GNTm3izZieBJloT49QG1wmtEi9MYB4Z5SDAhhmwroOSP5jOV0Sf1OCHRVrAWBAj3J
         Niig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713176809; x=1713781609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpWGqEEM4uqV8fQ9PN2exXNk8aXKdE5yEA9kmzOz8To=;
        b=IpZ8gSoGrkneqYSmIRupe/zk/dP0Z0koM4SH3qUGPNw48hn4iiMmkFlMOxb4qFIpaY
         ERV+J7MtAuOWy+OJamB/VVDiwYBgAEqENCI0uhpJZxE4CmRkPRHAeKwqu6rNUeXJIUeq
         /UYlpUtuvo4ReSBtDrPnbHxx2tGHGOBXWZM77xMOzghyuhAtwK2sSsydlXFmTynM3VwS
         BO3Vl1BvjTutA0CixMi5a0ai1y4XaSN8TJgZGHAsLQ6cw+Mt4Rd+jsKeWKH4KXrnUBlL
         QQlzTDPJCv+gv60mj6y3u1JdPx9F7RehLCSEDwC4c+gaQFqMJFv1msUy9ImLA9FQfLMq
         I/Ng==
X-Forwarded-Encrypted: i=1; AJvYcCW6xdPKZeqTnweleMdnS6xHhJpqVtZskH35I30G3AclEGsU64X3SVWI0X0vNeQz8/CCHDqzXgPL3a6n10aeKPhtEqeinqXRhYRUFgFn
X-Gm-Message-State: AOJu0YzQ1CD9HcJbUxxnIx1eId4kyNSMvN3G7WgmGBou1GDok6vonRd4
	Q0XTODY6+Wj4iFk1Dwp83wEj3YJJXoa9tJ9CrMwR8YYlAmRJIk+D7HxiIm45
X-Google-Smtp-Source: AGHT+IHnLHZYuqmR4gx+ZMSPlRsNFwpxH12fglKrUu8NHuUrEAOGbdQhmU7KA8S2PVxjQRJCUCLPXQ==
X-Received: by 2002:a2e:be04:0:b0:2d8:da4c:5909 with SMTP id z4-20020a2ebe04000000b002d8da4c5909mr6026750ljq.51.1713176808672;
        Mon, 15 Apr 2024 03:26:48 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b004187d900766sm361859wms.43.2024.04.15.03.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:26:48 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] mfd: timberdale: remove redundant assignment to variable err
Date: Mon, 15 Apr 2024 11:26:32 +0100
Message-Id: <20240415102632.484411-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable err is being assigned -ENODEV and then err is being
re-assigned the same error value via the error exit label err_mfd.
The assignment is redundant and can be removed.

Cleans up clang scan build warning:
drivers/mfd/timberdale.c:768:3: warning: Value stored to 'err' is
never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mfd/timberdale.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/timberdale.c b/drivers/mfd/timberdale.c
index 07e5aa10a146..a41e9a3e2064 100644
--- a/drivers/mfd/timberdale.c
+++ b/drivers/mfd/timberdale.c
@@ -765,7 +765,6 @@ static int timb_probe(struct pci_dev *dev,
 	default:
 		dev_err(&dev->dev, "Unknown IP setup: %d.%d.%d\n",
 			priv->fw.major, priv->fw.minor, ip_setup);
-		err = -ENODEV;
 		goto err_mfd;
 	}
 
-- 
2.39.2


