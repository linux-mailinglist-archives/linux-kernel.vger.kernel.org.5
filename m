Return-Path: <linux-kernel+bounces-83607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575E869C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC701C221A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAAD3F9C6;
	Tue, 27 Feb 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/mR4v/Z"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F0224CE;
	Tue, 27 Feb 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051454; cv=none; b=ZkZA2/HoufxYo16mYOfK8eI+c6XNDPWWfXOEBm+70gUe11HUxpyFvh5oBhV+kYh1CshkhVx5VoI80yFUqECB0GzWQK6GgNevY1dk6hDKKxAaj9zGLv7D03SIo/S/ycQ6L7rj59A97R7I0HFHQY7M0F2EuHtlCbVnceZ/JdbV0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051454; c=relaxed/simple;
	bh=a9ax9Th0J/yWwYA9Ji5yycvcTXucxvXbQDowoYu1TZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjRYZjn1aVDjZWLlN/Rqvmp+sxBfJYhJbqRR0F04vLeW/lXN/4gbBIOGK+75Xz9eaWZGOAsyflpLWFVfznMzfeDM2nj9P7j9IB7YcPd4mKJT9oCALbdEQA7GYkaVJEuZnY+GCJg5hdD4QEFuAlkj3gAT7dok9H2MtIQ7BuvH1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/mR4v/Z; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d28e3c0fe0so27764091fa.2;
        Tue, 27 Feb 2024 08:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051450; x=1709656250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GROxoFfHU3ZTM1nyWGwBFIoVLn4kosYhHeZ7KnHqvU=;
        b=e/mR4v/Za1ifiO8j/QD0V8zeiqrJhwtBPzQ5BS35L+ZrOXJWMlMLaRaFIHL7Drf6H1
         qmVpbNyu4IqoDgwhw/9nknm/RchiyqmRX/zYABUvo5nU/nUtJNk878IKDCuXamn03Rnc
         ThkHUu3UWMKW/zjl3mjU1nu1f0+gd/zUzY6pLEfbYHmc9CudgvjU7HYucquZztFm8ayC
         Y3Ikk2weX5hjw6ANtDxI4RDuQ7VNWESEhGyUSGV6IwrFijQk3uCQKsN84Q3HKD8y+o67
         cWyyKJYLnbTKnl8YhtqaaSoXUmv5FgI6Ak9uP90P/86IhBu2+Za6QVMsnFNYeKwc6lNr
         RYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051450; x=1709656250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GROxoFfHU3ZTM1nyWGwBFIoVLn4kosYhHeZ7KnHqvU=;
        b=BxLcfxrcsAOSz1hedTejjzGFAHBVHBwXk4010Kjb4GhZmKE6VqEIcqbFR+/j/UcSyM
         7GpwephNA/ZMjgJhgEF3866SUTgCPVi7k4/zv4q+HoBZLIuR8vRa423F/XoudPu77Wd/
         ur8ASndngNS8kd+V1KWSoE5EEt0/yoF06HJtyW6dHNqspbAsMcpFPcjgILlY2WFQwban
         5Gt4H0Zc9nBFw98CiIx2+OmMBZhCZhU3KOSsEEfGVAB4Zm4J0bvh3eavKCi36vgvK9Iz
         x1rqWW3K/9u/1tuBrezbSNRkDmDEVcmXLry7Vp3gZRwGn422klHW01+vyUEea45/1cl4
         D//A==
X-Forwarded-Encrypted: i=1; AJvYcCUaGaO6J5x61SjAxEhN4Z0/hpu5usmVitPfEm3rtviHLnoUkTglBcUGcxc5Y8vs+0kAOosR+ZJHXyXpzXXLCJZnuShQK228ATx0J6bqEIesWfhCQUxNwWNo7nDEzfVySTyHgxSUVEAAr30=
X-Gm-Message-State: AOJu0YyYJhhZNSOB5Aj/LiEviepXMYh0ADad5btlsSpuKm6rfjxMhnWk
	vi5LFIDYpkqj/OFeKHQkaOrXw/srwKFWnrpSIao21lk9laM4mEhb
X-Google-Smtp-Source: AGHT+IF/iQ4vrIr9a49uaXp3S6OT5TonBhk0abKcxb7huLkuue7kJ0ujt5PSBvm8ZItLjlqKa2dlPA==
X-Received: by 2002:a05:651c:b0a:b0:2d2:846b:8c50 with SMTP id b10-20020a05651c0b0a00b002d2846b8c50mr6367194ljr.6.1709051450465;
        Tue, 27 Feb 2024 08:30:50 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id n11-20020a2e904b000000b002d0b6eafa8csm1300712ljg.39.2024.02.27.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:30:50 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 3/3] staging: media: atomisp: Replace msleep call for less than 20ms with usleep_range
Date: Tue, 27 Feb 2024 17:30:43 +0100
Message-Id: <20240227163043.112162-3-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240227163043.112162-1-bergh.jonathan@gmail.com>
References: <20240227163043.112162-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch makes the following change:
 * Replaces the call the msleep() to usleep_range() where msleep was used
   for a delay less than 20ms.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index cd00282b87b7..607453740dc9 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -594,7 +594,7 @@ static int atomisp_mrfld_power(struct atomisp_device *isp, bool enable)
 	} while (1);
 
 	if (enable)
-		msleep(10);
+		usleep_range(10000, 15000);
 
 	dev_err(isp->dev, "IUNIT power-%s timeout.\n", enable ? "on" : "off");
 	return -EBUSY;
-- 
2.40.1


