Return-Path: <linux-kernel+bounces-28514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0010C82FF91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 05:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95247B24A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 04:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9248363D5;
	Wed, 17 Jan 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YleZIGfB"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B106119;
	Wed, 17 Jan 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705465866; cv=none; b=mU/hxBAL2p2aZMWqbISJg0q05xW2E419+h4KIUQ7DYpHdAyoriBFr63szLjEJACmFwC3nA+tjYwo1m8qilEIH29PluPDjpH1u0aSMbmE8wvpINFeKSPVocg87Y7TnRPHFoijXzZQDfP1KS0G+/4GSwEjhEfhNhWbtSq2NA/bnTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705465866; c=relaxed/simple;
	bh=12RXVmYofYf/bXk1QHYPI5OizjpwerGZmoWFqY26TmM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=FMu9mPLkxIC/OMFZiacmfvMIXmomnMDriUVPQUC7A9xBeQH5q1Mzx/+VYa3iPB9TAwVp2hVLodZQcsuhRbvrF6zp3miZYa4QaoPO9a09PtDJeZZ/zLMZoSjrYMhBjI4KPgaZ/taISPD4tkzwWejYheoONoEW5QlHx/AzNkMEXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YleZIGfB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5cf6d5117f9so1799134a12.2;
        Tue, 16 Jan 2024 20:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705465864; x=1706070664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBjyRu39NyJs+jVOZ9aRQZBCHdu2QXilU5RRwzN9vHo=;
        b=YleZIGfB88JxNcnYZqMZUq3aZp5X957ZN9qC2v4PBQbwg1CGs3leLO3O/OO2YY+pC2
         eCmoFk9pX6Z3zQkczPpD6zDXD+sYvO+10RkbD/yso2CuPTN3zO/ZOpT/6pOTlb2g/Ik0
         Zd5ah3jlXcNFGh346v0ACC2/YaknD91tUzWWNTv9JJOqF4H7JStPxsRhJYPzk0CwHpYX
         eGP9uREcjx4N21Q82gKJ0KqJamY4E71qND5Keam04CKgxRmjpaPKZcgeL0VeUDjuYETd
         DiQA1nrYL4TMGB/RJlwr+CE8Np6zduaKtQnU6aZzq1X2v//jCm/5ZSEaQ24IrPVifyMu
         t97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705465864; x=1706070664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBjyRu39NyJs+jVOZ9aRQZBCHdu2QXilU5RRwzN9vHo=;
        b=BJUXyPRbPbGl+Z41irH/fHl/lmVotV6xkBYi1VWDQj88FM9xgMmGY0cTpCigOVrX2F
         +BbuPyqExypR365tS5z9h5Hlmcc1vao4rr77svUTmYYjc0yde0+0grDpkMgQP37b0x08
         3i6B083o4ga7c7+6fZGo8Ch2dcyMFGyhYzCqVfCkzkfz/TPz/3MdxvESXB0KuH0Yi3KN
         IPLHz5/3/w10b7cL3BcymezHa3aJhCAlEEIhpkNO+auwiDsu83Ry8phGjVX/O7YoVdr0
         XXCf4444TMl9x07oDLSuTvgNT77CwGBDgHLXrTWPHy0C/PMIDIM8XJ3WERvpuTONRFq3
         o2Rw==
X-Gm-Message-State: AOJu0YxKeaxzr7DV34Yv8jRbK9OoZP83hw0RcCsXiTf9jUrwb+b572+O
	8mIZiGsmkAokp8kC2cO9Q2Py5zpGAsQ=
X-Google-Smtp-Source: AGHT+IHnYNmTwXU2oZr/AGurukrgfDR8ezc3peEwT+QL8W08fegh3RJdOnqCiqXqYjLSt2GM/ifn9g==
X-Received: by 2002:a05:6a20:d491:b0:19b:3390:e22d with SMTP id im17-20020a056a20d49100b0019b3390e22dmr1985379pzb.125.1705465864459;
        Tue, 16 Jan 2024 20:31:04 -0800 (PST)
Received: from eldorado.. (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id sd12-20020a17090b514c00b0028cef021d45sm12668523pjb.17.2024.01.16.20.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 20:31:03 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-mips@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] MIPS: Cobalt: Fix missing prototypes
Date: Tue, 16 Jan 2024 20:30:59 -0800
Message-Id: <20240117043101.371421-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing prototypes warnings for cobalt_machine_halt() and
cobalt_machine_restart() by moving their prototypes to cobalt.h which is
included by setup.c.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/cobalt/setup.c                   | 3 ---
 arch/mips/include/asm/mach-cobalt/cobalt.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
index 2e099d55a564..9a266bf78339 100644
--- a/arch/mips/cobalt/setup.c
+++ b/arch/mips/cobalt/setup.c
@@ -23,9 +23,6 @@
 
 #include <cobalt.h>
 
-extern void cobalt_machine_restart(char *command);
-extern void cobalt_machine_halt(void);
-
 const char *get_system_type(void)
 {
 	switch (cobalt_board_id) {
diff --git a/arch/mips/include/asm/mach-cobalt/cobalt.h b/arch/mips/include/asm/mach-cobalt/cobalt.h
index 5b9fce73f11d..97f9d5e9446d 100644
--- a/arch/mips/include/asm/mach-cobalt/cobalt.h
+++ b/arch/mips/include/asm/mach-cobalt/cobalt.h
@@ -19,4 +19,7 @@ extern int cobalt_board_id;
 #define COBALT_BRD_ID_QUBE2    0x5
 #define COBALT_BRD_ID_RAQ2     0x6
 
+void cobalt_machine_halt(void);
+void cobalt_machine_restart(char *command);
+
 #endif /* __ASM_COBALT_H */
-- 
2.34.1


