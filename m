Return-Path: <linux-kernel+bounces-75584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2851B85EB88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD551F20F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2D8128383;
	Wed, 21 Feb 2024 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz44TZGm"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765EC3C099;
	Wed, 21 Feb 2024 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552930; cv=none; b=djXMwfbmRugKDMoP13YLuviLizh2jkdaDprdCX+Xo6UjGToYTFtv1xNp7Ojg0ArPDBaBsrCKECX/gqlhf5VjSfG/vjc/MVSzlOCXsCq1U0MTQIumi2MoF5rxO0bZOtzH17J74qPW5aeqm/zEDlcFqlDEHdzmHiy6JK4sQ7AhyRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552930; c=relaxed/simple;
	bh=8MGCt+P4gH2QpzJLHo5gIAZpKB2OaAAWxWUcX9wLNUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F545RLRrsUbj9ahY7rRgK5KwfZPqgj1yVDruc5RaAN82p7LWSGtdyAHzKzwfwRzQ1pBztpatGvR81i4fvdiWwHlL63YZAbD1mYyST39aitkHqYL/TOtolqDjaBLoxT8j8BkRRcf+M9KNfjygtACV8Rm/ih9HxKWd+f9exiGR7wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz44TZGm; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a1a03d067so1450087eaf.1;
        Wed, 21 Feb 2024 14:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708552928; x=1709157728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ahCz42898xX1WCFynstOUHFEqWmdicda2jxA9WNrI+Q=;
        b=Wz44TZGmIkEJevaCIL4DdUYEbeKVwjvojcr6sDbegH1erFg0H7zKM0uBKr/HMN+9RU
         mH00oNZiZDP5KPbVMOVlb2WHNQdndqhoRfWa02Pf2LmLt5bJu90XmKFFMGrD8KQ1bg9g
         5q5QJ/qscZ6VFdWfjQs6oQOYWRCDYysPdTxeGsKgdh6rInvLykWAVApKvrUcRK0YbN6I
         Mh+4oJ5ta4cIW7a1/XHPQqs3PvIegFly50cqDAUwN051w/cYlU+jHXh/JVJB4hltoEqs
         2zm4JiaNhxEkdYdvuPT2DTlFA1y8JFmipNkYJCBh8o7VMjSvefOcLNK5yTqRanT/zTwN
         zTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552928; x=1709157728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahCz42898xX1WCFynstOUHFEqWmdicda2jxA9WNrI+Q=;
        b=UhVzKDzX7mmhq9BJ8F7IYPWcxi/dzxKI8zntApAgRMsZtRBUAcxz23Va/DCFvEKH8t
         yVxKJyudBYiSQF2XTI7pJOGyvFASSErddeS2pR4N4cEq/0MmriWkoVK3sz46P9PJnw8J
         ceReGI4MFOmtGZV3zhSxXQr3iC+opYbgiPEs+qHOJawV7kXqoAmdem8LGJtbDfFsVYBj
         0aE9PG4x/FuZRs4fwaDdNDIsz3drDLO9uzsiHOUDYhFcmUFteJOGlwtbYD14uX2VV6O+
         RckCQP+gnFLMlVOvXCP3qnyHOX2ZvBe060pLu4VzD534kQES4Afo7vN44xxFVDp3AddM
         IGFA==
X-Forwarded-Encrypted: i=1; AJvYcCWbXDK7o8O+gK5eCX455QdQbAUrGbL0zd8U/kJJNfTbfELaFHKRJbYrfXLNbruRFR4xMdeOXUGKLThs+KzuwNK0C2BF21zsSseh58kNZm/D0Ql5IWlFeV+oBnD8VFhVm0Ggh8ed1j3QjXY=
X-Gm-Message-State: AOJu0YyGopsyc8RMtjfZ/hKg24+qDnNaej/JtLQg9GxPfRnx4m9FsrU+
	eyLht9KzBar2uLzjvq1GKYEeiX74nLfbfOyWSwo9kV3/iCeLZ/rWlTDfN6O5qA==
X-Google-Smtp-Source: AGHT+IELvTZ+XcitZ0rXJc4Qh4F8SDtv4VZO8EdsZgt3m1h7Hx+uhDcRaXrInSVx7/UkjE45Fy8/sw==
X-Received: by 2002:a4a:dfac:0:b0:59f:e26f:fb1a with SMTP id k12-20020a4adfac000000b0059fe26ffb1amr9379137ook.3.1708552928506;
        Wed, 21 Feb 2024 14:02:08 -0800 (PST)
Received: from FreeCalypso.domain_not_set.invalid ([2806:106e:19:4bb8:77c:948e:6b1f:1907])
        by smtp.gmail.com with ESMTPSA id l15-20020a4a350f000000b0059d7a60e4a6sm139ooa.44.2024.02.21.14.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:02:08 -0800 (PST)
From: Alfredo Cruz <alfredo.carlon@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alfredo Cruz <alfredo.carlon@gmail.com>
Subject: [PATCH] block: add put_device() call when device_add() fails in device_add_disk()
Date: Wed, 21 Feb 2024 23:01:41 +0100
Message-ID: <20240221220141.32316-1-alfredo.carlon@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When device_add() fails, put_device() should called for cleanup.
Added this call before the jump to out_free_ext_minor to not
interfere with device_del() on error paths where deivce_add() succeeded

Signed-off-by: Alfredo Cruz <alfredo.carlon@gmail.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index d74fb5b4ae68..5a231fb075bd 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -456,8 +456,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
 	ret = device_add(ddev);
-	if (ret)
+	if (ret) {
+		put_device(ddev);
 		goto out_free_ext_minor;
+	}
 
 	ret = disk_alloc_events(disk);
 	if (ret)
-- 
2.43.2


