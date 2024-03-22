Return-Path: <linux-kernel+bounces-111580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DF8886E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72361F22236
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B744C601;
	Fri, 22 Mar 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMzFM8U1"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237D481DD;
	Fri, 22 Mar 2024 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116529; cv=none; b=k0zMR5uCH84k+IuouqcY/SwMFf9GjqPwJe/i5DZ0133FrzypQ1Fdm5nOna+qpSfX2sdFgO6foYTFdm+bSdQjYnwVXTIRMozSAR3OukjLn5kf6jjCRNVAT54tqgM1YxNU/OTXYXigrKGEG47tVS5OiNPzmahUWSppsBJypws5ATg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116529; c=relaxed/simple;
	bh=turmBzRmql7+31PREK5QaeIbLQ1mPenOQjp2Kh63vRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsMyxMvmiEdr+8OPwsL0lskyk1eQKkGyfSteR5iDaBqqLFdBXNWaQUirzT5ZDWXcZxQSasN45+S24TybBeTx9iy74NFMKCEnrqYFjTYJTquERMtau0MXfiWfFxT2i8zYkU62B4gR6xWqUGOOrRWd0ZmgoNnX5cBPBBuiUg6Vl/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMzFM8U1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69629b4ae2bso18566306d6.3;
        Fri, 22 Mar 2024 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711116527; x=1711721327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FossVTVmjL68nyfPQZCKYx8qjMlzIsUJgOQrUcYnW2w=;
        b=hMzFM8U1kCyaTQ7g/z7ZI6NoAaySvmkBHudEV628nJxorupMhF+s3g4V7XLFxX7lCd
         FVB3S1dXXfTZtb8j4QoES03aH3jVA5DRsh1N9W+UJ9Teii/+q4JBX16m7NfKf2D3f61p
         WN38Sezr2nqB/cWDlAfEcBVbslqLPtToeMSnZdThlKYZTkQheB9zZFEI4tUOIprNhEyJ
         XSBXnPpF720a370lhC6TU4fJhZKv2JTf/MbFMbNinvidwCeOn283ibulhNXRaGpuax91
         a87/ibJ0jRINLy3OPYLi0d/wUVvTDZY6ZnXcpgAc16Z+vTPnZ6UywrskSqgqeF7XPxkB
         Q2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711116527; x=1711721327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FossVTVmjL68nyfPQZCKYx8qjMlzIsUJgOQrUcYnW2w=;
        b=cBmmoYS/cNewDZLS57HXUQU7QXIviZkGbcrbdcW0kIdrEfiSGPGuDTE/N2D34+oYd/
         wzqPfkNTK3vqr/nsillL/d9kibzhgHlBFAkPIchy1Xgk2jqGNTPU/2/Zod5pwVRrQtn6
         xaT8CUpaYRM/Z8rp0Fi9evjf2qyEcMLSohG2bKW8KKw1DU6msNgTETlvJRPdSxnfFoN3
         nKW5J8ErMPPecOT34qd9C6UHYSqlYOTG5Ra/efPggMgpf3YCmIc4eu4PXEtrK7JouIHJ
         nsA0eOry6BQTAaTVRtR2l4ai+pYv6/Qgm8v7HS/Krh/lHJd/7mBdsqK5ROfTBo7sbdrg
         axgg==
X-Forwarded-Encrypted: i=1; AJvYcCXS4WItrFALmty8qciGjWFSVaGe7bTXOdjsJ9fo65KhhX7KzH5ZKFsEEXUoU4Y4pUhCaMnZD6mPFsRN/5Q0KRbFVwlQxmkymOEjxbXZrVVWS1uk4WUjgj5I9BQVv2Wp0yeVZmd1tFkLD5zReVWghPnSFOMd4HGzSNn1bwgb8g==
X-Gm-Message-State: AOJu0YzfvxMrjMqDBE5wE8vBVjpLi8iUFTmmNKGN+5bSREg8zrHK5nrN
	4owPrudjLdZFGSGbuVdMGVDFFvcbd0fvw9kQYPv/22ax1G/dYpM9
X-Google-Smtp-Source: AGHT+IF2PYsxGINwGFey4BHK+Lz1mbILhIHEQY+3mK6bFTwve5jKVSRS6g1orEAM5Pr0SPDD6o/IYQ==
X-Received: by 2002:a05:6214:234e:b0:691:43bd:f3ed with SMTP id hu14-20020a056214234e00b0069143bdf3edmr2703921qvb.57.1711116526826;
        Fri, 22 Mar 2024 07:08:46 -0700 (PDT)
Received: from l1441l.thefacebook.com ([2620:10d:c091:600::1:b4ee])
        by smtp.gmail.com with ESMTPSA id kc22-20020a056214411600b0069124fff14esm1099508qvb.138.2024.03.22.07.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:08:46 -0700 (PDT)
From: Daniel Hodges <hodges.daniel.scott@gmail.com>
To: ast@kernel.org,
	pavel@ucw.cz,
	lee@kernel.org,
	linux-leds@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Hodges <hodges.daniel.scott@gmail.com>
Subject: [PATCH 3/3] leds: trigger: Add documentation for ledtrig-bpf
Date: Fri, 22 Mar 2024 10:08:16 -0400
Message-ID: <3ce269887c51319b2428a75e7fd008abc6fd6638.1711113657.git.hodges.daniel.scott@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
References: <cover.1711113657.git.hodges.daniel.scott@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation for led triggers to include the BPF LED
trigger.

Signed-off-by: Daniel Hodges <hodges.daniel.scott@gmail.com>
---
 Documentation/leds/index.rst       |  1 +
 Documentation/leds/ledtrig-bpf.rst | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 Documentation/leds/ledtrig-bpf.rst

diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
index 3ade16c18328..2af52a19d6bb 100644
--- a/Documentation/leds/index.rst
+++ b/Documentation/leds/index.rst
@@ -10,6 +10,7 @@ LEDs
    leds-class
    leds-class-flash
    leds-class-multicolor
+   ledtrig-bpf
    ledtrig-oneshot
    ledtrig-transient
    ledtrig-usbport
diff --git a/Documentation/leds/ledtrig-bpf.rst b/Documentation/leds/ledtrig-bpf.rst
new file mode 100644
index 000000000000..391a305f69d1
--- /dev/null
+++ b/Documentation/leds/ledtrig-bpf.rst
@@ -0,0 +1,13 @@
+====================
+BPF LED Trigger
+====================
+
+This LED trigger is useful for triggering LEDs from the BPF subsystem.  This
+trigger is designed to be used in combination with a BPF program that interacts
+with the trigger via a kfunc.  The exported kfuncs will have BTF names that
+start with "bpf_ledtrig_".
+
+The trigger can be activated from user space on led class devices as shown
+below::
+
+  echo bpf > trigger
-- 
2.43.0


