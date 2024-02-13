Return-Path: <linux-kernel+bounces-63638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9C8532A2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74077281BAD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7457310;
	Tue, 13 Feb 2024 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YvFTgYPY"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A84C73
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833227; cv=none; b=Z1HywvavX6438GCR8uIArAJz9UlF1MKIkW9wGkKfAswroxkhVieHC9tKpAqhQjzqF5MJjcMWZvzU1Iykb3n3AsqiTJwyeJ8ViLov1bbQSXkL325vj2pg1cZT5dHhrATE+1Xba0tQUp8rvmJfqVE4boYsi3Yho/ILhqIjPV5Fe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833227; c=relaxed/simple;
	bh=+s/OfGNMXB58P7TxwiDwAEhQ+GBlUKjDVwC55toeJVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDIe8ugngclywUlsgicRKGJAUX4oQ8/pidOFYhGN52F2hvPX5u/jONJH6PzyzjAxJ9hobRInRxoySAihzFs1hEVmgA7W3nbtLz9to40xVRGTGmIsdLWs+NHshdKSpISPSkmDoaNBQ3nCd9ZGCyHuLKYMTgOcu8QE01QMDfNt9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=YvFTgYPY; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-410db155e57so14596595e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1707833224; x=1708438024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OznreBbGn8I8qErYNCh7MV7tKWfbq+5twYL5yapVuHA=;
        b=YvFTgYPYeSpNbdCxOjklcltk58yg2oZROYr/l5C+nIz2X8Hgu4B9aRRlvh6JTvQVqN
         hiYGFHSWtsqFITWZ0B0oUy43NTU6PZgoY6aO/DQdkjch48NbKDtUHqb0R90CI6N4uD8O
         Du/Ji6c0IoELV/VN/aRI4zWwvoiEvzoIfIixGgLDeo1+pqK+bLCN5KtOv7qGvdxuSQB8
         Hg54V1Fzi/TFWW+9Uwa53OIAu1TGmsui8Fe8xRMykXCrZUTtUWglBoDInWYmcDFL5vhi
         90eUObiU3HFzUciPhj3y2wuGTEJY50zVOypf0Eg0d6vJy9thB90VTDXJ+Hx3j7Ia6ZkS
         afOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833224; x=1708438024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OznreBbGn8I8qErYNCh7MV7tKWfbq+5twYL5yapVuHA=;
        b=aQDq7WmkM4v0/bkg/yewSu+xzWuJ7Vqs8Er84330uCG0cIzYrlssF0PE92mlB23h4N
         N735RC4LxTdgW+N4aoVRSDMIQUqbv5bdaU2v7JIHYXljSEgEdLaWZ3ycXCJ5E9TsnTuK
         G9xvPSjHKtv6poO5pycpxgQqLelYUMGPBkwaWhci3FpORtfp7rBhfe6joZn5YrBpyugv
         tlZ6vaGV2RguWjlJMB027AHcb8G3/MYIJSSrrs9i+JTAO7iaU+o/4AOmM1FNtURs0lPW
         XaEtLVekA73jfGMVRoIF//3S4OYR5cQ8J3fEFztIw650DMud7fu0xZAMu9lbrEtroD3M
         ccOg==
X-Forwarded-Encrypted: i=1; AJvYcCUATQqNmr3vYbc8VNtiHndOJWTzEbYhvDtGsFJcG8nT95qbXd8p/iMHzjDAYaJCuPu8X2M4k/dBmdlXYJQGToMlEgjIrdliAXQQC2KZ
X-Gm-Message-State: AOJu0YzCgz4lMZaJJQyy1a60M6LXK2ax4b7onwfv5v7wc+wYQQu85Epe
	MeStyCQSfo2GrUHD8WosO60ARTu2F7+qpMWkV3GNA/GgVFf7jYGHnLjxjWu7DiKb6p6TyyB/2gh
	Mgg/T+w==
X-Google-Smtp-Source: AGHT+IHgaCsw+bI3YnMtmRZRxOhZhIBpjtyhecfn4YghOjw9O5dxyxlKSEdfcJ9dLFmj9HUOdbCPFA==
X-Received: by 2002:a05:600c:1c98:b0:410:1587:7c0 with SMTP id k24-20020a05600c1c9800b00410158707c0mr8585573wms.31.1707833224356;
        Tue, 13 Feb 2024 06:07:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPlTlgcRhS132bjJpvP127vmj2lPugovqokaqg0rSgIYimGTm7LoF/kfRoriLQM2mmmzfw93YScwoshSD8YO0n/srrSuAnufpdYFdq55rAiqi2z8k4zctqQ++Z/VQxn8wANY36BXIaAxJlBh9Hzw3jtYQdFCD4k7D4KfmNY0M8czaEcVuZO8MT0H9F0AXQgR1sJTpc74Sxq5ZJhwOVvlm+
Received: from fedora.fritz.box (aftr-82-135-80-242.dynamic.mnet-online.de. [82.135.80.242])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b0040fb783ad93sm11744683wmg.48.2024.02.13.06.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:07:02 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drivers: wave5: Remove unnecessary semicolons
Date: Tue, 13 Feb 2024 15:04:41 +0100
Message-ID: <20240213140441.8640-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/media/platform/chips-media/wave5/wave5-hw.c      | 2 +-
 drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index f1e022fb148e..2d82791f575e 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -2315,7 +2315,7 @@ static bool wave5_vpu_enc_check_common_param_valid(struct vpu_instance *inst,
 				param->intra_refresh_mode);
 			return false;
 		}
-	};
+	}
 	return true;
 
 invalid_refresh_argument:
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..8bbf9d10b467 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -92,7 +92,7 @@ static int switch_state(struct vpu_instance *inst, enum vpu_instance_state state
 		break;
 	case VPU_INST_STATE_STOP:
 		break;
-	};
+	}
 
 	dev_dbg(inst->dev->dev, "Switch state from %s to %s.\n",
 		state_to_str(inst->state), state_to_str(state));
-- 
2.43.0


