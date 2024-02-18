Return-Path: <linux-kernel+bounces-70251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1461859544
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657DD1C212A3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B199D294;
	Sun, 18 Feb 2024 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpsSnz2y"
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com [209.85.161.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A17746B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708241716; cv=none; b=iu4ufSUOQCh6ldQfO+4Uxjfur3uoPN6x5vhIRe8uyQsOTz4fihSTdy0mtD0pJ9/4QXV6YKG/8QrR9fOujvyjqZOZTeE3zF67pv+fhG2LnZndfdtfMkZmqmK43SktWeDwOVdp4MVkHwDr06CrldG5/wZ2ndU7tGKBIXcYRtarLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708241716; c=relaxed/simple;
	bh=+a4H/ahmoRNiU1zYapSk7p0IZYFE8bsHkSV8lIN96Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=taPYWh0jP/G16EjpxvLD8JUsuYHB6NT2vv0/nSQ+d+Zii9R2ygFeNHdAOgflLHyHlfMNgS9ixMRjCZFbDYnFj1dS0nopDq9UKQiZsZZafKxwaSXlhpfXo9BaypauNh91sxEBl3zkp6rHr7LxnC9aQ5iQOxYjng9K6/vFLQdaRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpsSnz2y; arc=none smtp.client-ip=209.85.161.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f66.google.com with SMTP id 006d021491bc7-59f786b2b59so1621984eaf.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 23:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708241714; x=1708846514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGrS/QrK390LGI0LLUrbrIxCWDxFRathI2WV75UnB8M=;
        b=MpsSnz2yZWEUv2d3O68AijHRWi1N9GQijOP/QUJglV0p3CgRXLa81z626dw/by3hB5
         B7QxqKT/xP00dgCFvOVK46toLwv1ofpUksgiUMUNF8lyWsxLBCwhJZ3g7k0OjHXn7usD
         4Hm2ymgGI2FlQRHu5/9fEh4htpibAVYqhZvYBH4C8jMiFrG4OyVIRiqUDBwMaNVMzEvx
         rseFC7YUN0UZk7d1yTcsE8/xA2sphzXoCCQLuaVrey0c043/98s65OC4Ov2j5ifgkcxC
         br8ytZSUCJzfKAYHc8kXTAV8IbuK9BWYLKHeaHDwh3pS7o5hQ6LvlZIJoS3x3omX7YU8
         knaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708241714; x=1708846514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGrS/QrK390LGI0LLUrbrIxCWDxFRathI2WV75UnB8M=;
        b=I99SUfzxsz2h4ays3oa1swHDGb6M4GfUCYDZcxfPVMg08gHQB871fMOwz6QBIytF3l
         pQrmz44UwuO7atggHO02+zWICMs3wb9lBTG/DeuoIvm+prj61hoJgt+KsbsJJLZhnvfA
         AYYJ1PTWCkjC+wMN3J0UhousWjX1sZ2Obu7Y9dH1EtcYcKbU72aREFRKSHu28Md0IyFN
         Q3Npau6teSVdqRRPHhFky4IhtXzRFDo/ZQMZLupUvSIpSWi2JDXir14SrHRuAAQ7xRdH
         S797h6PTpmMIiM0XRjVOzY5czRdHU9aCI8/T5ZLPjoyj96L+WMQ3mw3sSmN+VyxhmVKf
         Zezg==
X-Gm-Message-State: AOJu0YwYqIER8LvdCWHUBR4C/PrJ8GnDIf0iELo1AUW2AZ459zSzNqUp
	qRfsKTmUP+oUyjQNRqfwsR/dnqUw92t5iXE9BHHTlqV/R3mF47+4
X-Google-Smtp-Source: AGHT+IFAHmVa6lCwwy26W3zoYicuYsavdriNiHTPPOtGGk0lCsFkAWCMwzwT3RPyDQyQIdySr6xXWg==
X-Received: by 2002:a05:6358:8427:b0:178:72b5:cf49 with SMTP id b39-20020a056358842700b0017872b5cf49mr10369100rwk.8.1708241714429;
        Sat, 17 Feb 2024 23:35:14 -0800 (PST)
Received: from C02FG0GJMD6V.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id sk17-20020a17090b2dd100b002997e87b390sm706675pjb.29.2024.02.17.23.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:35:14 -0800 (PST)
From: Guixiong Wei <guixiongwei@gmail.com>
To: gregkh@linuxfoundation.org,
	jgross@suse.com,
	boris.ostrovsky@oracle.com
Cc: linux-kernel@vger.kernel.org,
	Guixiong Wei <weiguixiong@bytedance.com>
Subject: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root access
Date: Sun, 18 Feb 2024 15:35:01 +0800
Message-Id: <20240218073501.54555-1-guixiongwei@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guixiong Wei <weiguixiong@bytedance.com>

Restrict non-privileged user access to /sys/kernel/notes to
avoid security attack.

The non-privileged users have read access to notes. The notes
expose the load address of startup_xen. This address could be
used to bypass KASLR.

For example, the startup_xen is built at 0xffffffff82465180 and
commit_creds is built at 0xffffffff810ad570 which could read from
the /boot/System.map. And the loaded address of startup_xen is
0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
 - 0xffffffff810ad570) = 0xffffffffbaead570.

Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 kernel/ksysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index b1292a57c2a5..09bc0730239b 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct kobject *kobj,
 static struct bin_attribute notes_attr __ro_after_init  = {
 	.attr = {
 		.name = "notes",
-		.mode = S_IRUGO,
+		.mode = S_IRUSR,
 	},
 	.read = &notes_read,
 };
-- 
2.24.3 (Apple Git-128)


