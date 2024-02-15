Return-Path: <linux-kernel+bounces-67387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB12856AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22670B2B797
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7F137C45;
	Thu, 15 Feb 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvSPP72q"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711B2136983;
	Thu, 15 Feb 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017478; cv=none; b=HH4dtq/UOJRKhCOzkwlHHVbgcrNY/zlxvOP66ZawKEExackHxeH/jR2YVSUm41AG990TbkFWs1HCGtFvplYviPBTHvbQ4rcifvuSz02+mI+QVwsdRoUMgJxxF1dM4XAmGsxqhRdPSEMK5gp98eT5BpsAikOoalOlgJwlNQ/paio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017478; c=relaxed/simple;
	bh=gv5DE7RXsTmH4yqXPX4t1wYgvuqILt6r3eF0XEGiPNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHkPBghjmXYdCP8cRpZZ5z9BdFEbk9qyOJp6uR8HCPK+93P9eyRi469lDdYXxsB1/DhsIQrSkXwnTov73LpnnQfBNI70veE4RBMpb17w61bJUJXOB7Lccn+XB03k/bUWoQZ+nU3WmEJSMX+MpgG4zhr6jLwbayJcDSVXmUhR4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvSPP72q; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51181d8f52fso1400942e87.3;
        Thu, 15 Feb 2024 09:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017474; x=1708622274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWD6NBu3YiSI1wWq6kinvIvYBM4vO3pv/UsA9bvpgzQ=;
        b=GvSPP72qNDUfoP1jX15Gj5FDl9IADUxKWYljrXFzxrEyw4wfrAhbB8vlUtQ9nKXZVp
         PrF1m/x1bx5iaVEDb5u60zhqksBLS/jAgtBT32v4SVA88wdIJf/8HZo3suPjGZf4zju+
         B/qRbvueSQmyh9rKarhQTg0dn1gzhaLlNxgyQgDXa81MA6aXMM2WV7O1C9/PklE0tnbK
         ve0Qglbd/1QqY6wj+yNoym4GjMqoYhrgQYed4CUkkEYOLmNj/RuJvWdJ0+1hw9CzyF3Q
         O5QvMO9I/IuS6Pgp5E0K4/d1F1HOGBZOM+cHkXkPc7fIBg8+imhbGHOqyqVs59QRIK4y
         aWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017474; x=1708622274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWD6NBu3YiSI1wWq6kinvIvYBM4vO3pv/UsA9bvpgzQ=;
        b=gtIQxG//Ep3mPNERhoFigrgZxuWFWoba3Ayz8r2eH8dWfexi75KJpfkVmDMnl14ZoE
         L+Bkv1vxgugHuYKwhhKWZzrxO5N08jwvzcs2Cfs9kvWEt/euv+Ck61r3PAFbsX/LK096
         k5jHLsNBdruZlwl+UcNrSv0nvwBLVTrFFt0e0MKcskItOo1u5v93rVikZbghT1Yl5eeI
         XlOf2gM8BaaxgvRH1TVx4ZfeHSIJOi/lW8wunguyr+CqpSi8mWHhsoTGoEIpDmmq87de
         4fARE+E/Zcp4h/UbR3tPzjfKVfcSpNq/6oNWwat3pODqfOiOdez+/5J0Ewssq7rvX+CY
         eqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfbxnYFRfpwa9yygmiHIATmw8XrKZ/YtwZRiknsY1HQmjDW9tZVbzmlscesBAc9i0n7Z95ZrvYtrHH0uCtzS8CH0hwcrwyTuBcC5c9WRa82TDy6YN6SEQTQJMnHkd920GGb5EaO3JUSvo+CJtbHmXJfRMikVGKnaCpTuVCDSE3+0Oi/BqRYQ==
X-Gm-Message-State: AOJu0YwIvXCsdQ+LLY48Rwsif5VXEfDRu3CZX3KnxfGSJ5AEBiDumE4J
	3zxSNkbL7X1wTQ49OK2Q+rfTiC6phpdwWcaZylkVjW3wchPS3D2E
X-Google-Smtp-Source: AGHT+IEyWvDdPOgStxl17oLA2WRBpXuBBoZ3Kibr5+lnRIW0ufhJUYeohaM+Cvp7KBqVACSH+JDVTQ==
X-Received: by 2002:ac2:5bc4:0:b0:511:4844:77f2 with SMTP id u4-20020ac25bc4000000b00511484477f2mr1787996lfn.40.1708017474151;
        Thu, 15 Feb 2024 09:17:54 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id x21-20020ac24895000000b00511570772f1sm309401lfc.303.2024.02.15.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:17:53 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mips: cm: Add CM GCR and L2-sync base address getters declarations
Date: Thu, 15 Feb 2024 20:17:27 +0300
Message-ID: <20240215171740.14550-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215171740.14550-1-fancer.lancer@gmail.com>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the design pattern utilized in the CM GCR and L2-sync base
address getters implementation the platform-specific code is capable to
re-define the getters and re-use the weakly defined initial versions. But
since the re-definition is supposed to be done in another source file the
interface methods have been globally defined which in its turn causes the
"no previous prototype" warning printed should the re-definition is
finally introduced. Since without the global declarations the pattern can
be considered as incomplete and causing the warning printed, fix it by
providing the respective methods prototype declarations in
"arch/mips/include/asm/mips-cm.h".

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note as I mentioned in the previous patch, since the weak implementation
of the getters isn't utilized other than as a default implementation of
the original methods, we can convert the denoted pattern to a simple
__weak attributed methods. Let me know if that would be more preferable.
---
 arch/mips/include/asm/mips-cm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 1f143dfad7a2..6dbe74dc323d 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -32,6 +32,7 @@ extern void __iomem *mips_cm_l2sync_base;
  * name mips_cm_phys_base (without underscores).
  */
 extern phys_addr_t __mips_cm_phys_base(void);
+extern phys_addr_t mips_cm_phys_base(void);
 
 /**
  * __mips_cm_l2sync_phys_base - retrieve the physical base address of the CM
@@ -46,6 +47,7 @@ extern phys_addr_t __mips_cm_phys_base(void);
  * underscores).
  */
 extern phys_addr_t __mips_cm_l2sync_phys_base(void);
+extern phys_addr_t mips_cm_l2sync_phys_base(void);
 
 /*
  * mips_cm_is64 - determine CM register width
-- 
2.43.0


