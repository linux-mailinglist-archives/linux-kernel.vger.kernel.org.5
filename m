Return-Path: <linux-kernel+bounces-76543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A4685F8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 063EF28660A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9712E1DB;
	Thu, 22 Feb 2024 12:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lWgIFwc+"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EB12E1C6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606265; cv=none; b=dJ7/cjesxzsRTtonUd7WL7rhJi5BS6eRlivBLmgihm9nQuSLcklXkMqL47g6Aa6EsSEYAzhy5My0kizrRpxlXg2DV5ejH8AZ019Xbl6FhDIGk1yXOetnRS0WmPQR8cmPqzNalCY+b3Tc7KSnAEUrRgj29JVIhVzJKq35ASCpj0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606265; c=relaxed/simple;
	bh=Iaix6aPDV3Ekm1vsTQVRiK0bk18pj7k/AkSkAqYAbuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GEbQytydFdnYkDo4pcV4J1Nbwuqw0zqasMvNADNyUwn9EarO8xdYNuMf+jbpDIPYlCwBUSCmlF57PiwLZvPOLGp2i7LBzQPkvHVZ6T7icGhZ1tR+iBJ3rW8amSvqVLHfsMdbnDMTWsTmlUcU747WKgKY8QIxE3kc8XrvNDXWGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lWgIFwc+; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-58962bf3f89so2325956a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708606263; x=1709211063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dGL6re92CbNNHJMPdFIuyeYfruvRTt7XkXoiR2obBU=;
        b=lWgIFwc+aSwTuAQH0E9wyoQSSDn2Ko33MrV2lUREyx+QLfLFQyY2Y0oZtWw5k6LvDk
         iiHa/TvyOOuURNpeB82GOvVV/6V67rPCQEOIJltpNt0NZlblW2PlgnKTO5lxm8/etG8c
         9udVPtbjXoRghUuf0WrM5dDmJRZ0tuEy8upmmsaXU9BhGIlan2H9fkNIewGnZlGXVwVQ
         JgEV3UsZDnff2ZOR44QW5omAWS9clShbocmDH3oHQOk6jTg++nEbzaSkzZdksFAq+knA
         ySBm80xX/d+PfZfcuxVtYqFHSTOESpUHEqJP3m5ZmUKjlapCTeUewKY3YDoPIE9M6UO8
         sTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708606263; x=1709211063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dGL6re92CbNNHJMPdFIuyeYfruvRTt7XkXoiR2obBU=;
        b=HxlA6TERBtkJhioXydlEyTQgGzdB0rdHFi7xsrKcbgclPNuY84rXD4L7hGAYs60be+
         5QjtiedCPlzT/vOIoLyR+gM+QHyLH66t9McQtcnCm7ZlQw/4QkrxS3SH3L4CnOOx5D4b
         xT0Oo2HQxiIZg1rVz4JkSf2OKlhVDc7dun3KLKsGSsc8l6F/J7+Wg6VKRU4nfj4OeAPA
         8q6zkhZ5g8faAgy4Xo8SmwCoy1k3Pi62R4iodyKlplLeNuTGsrVNDs2vxI9h9ygZ4xQ5
         Lmv5i5hI3yTI5A4SyQDe7/qvxyRcBI2vaxE/C8Z5oWCtLiAOcNkU4GrR1jvYADLyX2rR
         Qmzw==
X-Forwarded-Encrypted: i=1; AJvYcCXa6dyw2CM6tOXxTObVd/JrjXOI4MTGO05sOPja/S2gPhny71vEQ6b9dgQHt++EJjjSYuZAlAzcaqsQceazDGA9MUxySr68uDi5K5eB
X-Gm-Message-State: AOJu0YxoSAz88n200JyyTkBaaihdCoVLemPudNOmvuDl8Bh7lkT7MK5N
	lyfo7++d0mwFW5qxPI6gancmJyOkFJblMy5Hzhc68kizgvVIpa2+btOvE8M8j8s=
X-Google-Smtp-Source: AGHT+IGzq1UgKqcEc6MKfHFEbuy/83jvLzb8ZV8t+axyKqng12tbOej5W7pSGAiRksWjBSdw2xzwUw==
X-Received: by 2002:a17:903:50b:b0:1db:4b1b:d726 with SMTP id jn11-20020a170903050b00b001db4b1bd726mr19709333plb.1.1708606263443;
        Thu, 22 Feb 2024 04:51:03 -0800 (PST)
Received: from aryabhatta.. ([49.37.248.155])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001db7599aba0sm9898438pld.24.2024.02.22.04.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 04:51:03 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [RFC PATCH 0/2] Introduce support for hardware break/watchpoints
Date: Thu, 22 Feb 2024 18:20:57 +0530
Message-Id: <20240222125059.13331-1-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support of hardware breakpoints and watchpoints
in RISC-V architecture. The framework is built on top of perf subsystem and
SBI debug trigger extension.

Currently following features are not supported and are in works:
 - Ptrace support
 - Single stepping
 - Virtualization of debug triggers

The SBI debug trigger extension proposal (Draft v6) can be found at:
https://lists.riscv.org/g/sig-hypervisors/message/361

The Sdtrig ISA is part of RISC-V debug specification which can be
found at:
https://github.com/riscv/riscv-debug-spec

Himanshu Chauhan (2):
  riscv: Add SBI debug trigger extension and function ids
  riscv: Introduce support for hardware break/watchpoints

 arch/riscv/Kconfig                     |   1 +
 arch/riscv/include/asm/hw_breakpoint.h | 327 ++++++++++++
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/include/asm/sbi.h           |  31 ++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/hw_breakpoint.c      | 659 +++++++++++++++++++++++++
 arch/riscv/kernel/traps.c              |   6 +
 7 files changed, 1027 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c

-- 
2.34.1


