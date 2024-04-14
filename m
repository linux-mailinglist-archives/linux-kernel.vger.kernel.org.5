Return-Path: <linux-kernel+bounces-144288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7428A4432
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B53F0B2214C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB571353FF;
	Sun, 14 Apr 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6Cwpm+f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305B36121
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713113372; cv=none; b=IqkLxRAkiMY/g/T665ZY5Rahy0e8LkzSaqZCmKb8DL3c5vzjvb23km95LaiA901WCVpuerEHdAy9lP97FER/o9ScbNwhpOagrvlcwgVXJ/0DBdmEQKpwKfhxrwyz7B7anvYIe20O3bNQ/++rJXxG7sVFfSExcCujWFJyh1MICiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713113372; c=relaxed/simple;
	bh=Wss0WbtUOhjUWhYJ8vc04bb0suWYo6mOU9+OkAYhBcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1zuF5STBlh2GkZEdJhy0yupGbj2Gyay2lufkQ0Yf6vHqGPnzrP9YtKGukjdYeulV9iDVqC5gHwOM3jTaLOlblT1SrWms4OJ1blW29hhPY+m4F1lMMHNKVqBqrssKR0+xe+2W9FnkSmdCYd6tlLP8az5NwOQ3toMd106M4RWsuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6Cwpm+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04281C072AA;
	Sun, 14 Apr 2024 16:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713113372;
	bh=Wss0WbtUOhjUWhYJ8vc04bb0suWYo6mOU9+OkAYhBcw=;
	h=From:To:Cc:Subject:Date:From;
	b=d6Cwpm+fEoTII9Fi29J6au/DDKa2VJhKm96C02wk9z6fFDLf9pa+7rx//sI7lS9um
	 z32FGHATSjYDmQ4lLT6b31eXyCMnsz2Bc2eVA1JHTHQg8Ao/QcKdMVWhZ81WKv9+j9
	 uoVGS3cQcBXQqUwjz69L2KyX5egnTuyVUUJ4RZtejdeNxGbhtbF/m1c7A+80Q7xqBn
	 wgljKMzVv5HOZ2qkKFd5ZJQmZzze8yxY+HVtdQALEzbDfiWy9URP6557EMHYMkPz/j
	 gBSgfv8MuAa29XloP5ow/uBmZTemnlLEFyGRlHJJeLGpaOP63ATMfPv4Qqcz5JXohA
	 50VXUb/IvUmwQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: boot: remove duplicated targets line
Date: Mon, 15 Apr 2024 00:36:06 +0800
Message-ID: <20240414163606.2598-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "targets:" is duplicated in another line, remove the one with less
targets.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 8e7fc0edf21d..e051c677f6c4 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -20,7 +20,6 @@ OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 OBJCOPYFLAGS_loader.bin :=-O binary
 OBJCOPYFLAGS_xipImage :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.* loader loader.o loader.lds loader.bin
 targets := Image Image.* loader loader.o loader.lds loader.bin xipImage
 
 ifeq ($(CONFIG_XIP_KERNEL),y)
-- 
2.43.0


