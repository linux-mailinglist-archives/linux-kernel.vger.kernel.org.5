Return-Path: <linux-kernel+bounces-89460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF586F09F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D8128199C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC73B17BD9;
	Sat,  2 Mar 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BV/1KqYv"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64737E8;
	Sat,  2 Mar 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709388233; cv=none; b=Ur9bV0QUZXxBBgtN8XxOQ3Pr2+xelDvByEMLoh00CFKNrkB2+z3mtWZ4OTtoeQ16O46myehfO6gb0Et+VTUVUFotGQ8EB2GbRDLetSKpYYNjyyjmBkqAI/a+FX5EAFUIqESya1ynCgO2cs3XqYzg/aK3LHXq5ZAe4IoWJWWVvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709388233; c=relaxed/simple;
	bh=ON+p+fRGKbKs2n16LfRR4Sn2YZd0Y92AlSEpgvHleQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MGIRdYNuQZhBjnDVWJJwPMvnIYOhaHH/K0ngoB9ioEzFJ7qeDork5O5fsSLotDgYcs28H5AwYl87QIIjj0BxMPi3Zq6bP4FeksvAe8CDsa+/1oDHPLhhiI29BgTtyp58Xhu2+0LJ4On3v7SimmbW99zjMtGiaBdWcWzp4wwvnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BV/1KqYv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dbd32cff0bso28063575ad.0;
        Sat, 02 Mar 2024 06:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709388231; x=1709993031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGPt7WWJ/meTyXMsy8NiR7qClff89VB73LNZFS09DAM=;
        b=BV/1KqYv6Ycfsh8rfM9B8+Hbwq6sZopjU/qkddDr9JJS7faRitcYrW00mm1E9kpCrK
         BZnfkUsR8J3MojCeDp77DiOqXVOAm8S9DgTy2cue+1CnJ8zw4ldeARM6+7BPqr3j0vxQ
         u1cPWN6oqix+hKdR+AAakQ9ca29aKTGw0fdUyc9l+/xQdyfAyoc6RjtEEFF8QgODffia
         kLxppvx6ycwOSdI1AB5Ej50nBQV4jncEW/7pOpeUes4mkqJLOCQRMq10YdhUbMAX7R3C
         v8dynT8+xXPtJSFJHkgYu8RsILae7Zi0fNyZY6esZaGfm8IMCh5LExMaA7uLRs4IUWus
         v9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709388231; x=1709993031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGPt7WWJ/meTyXMsy8NiR7qClff89VB73LNZFS09DAM=;
        b=Bdcmuy1e7OuwQDiuu/yQX7dD641IhN0geNO13t5TEd4WGAxFcyQWEwP9oMGXlyiUq+
         WHysOU4BCXfLytDIvdPyNI1RjZs9RQF73z/bE9EOF+U2TReHyd0Aqb/qygJ0swyLC3EH
         TGrmUcqfKBL9NHUJ3ANDlS67uotO53obHY1DjkkyR0a17rRsRYoDwPqmnOvbDs+hi+nE
         g4ER6paYdskzQja39V1iUjMKMgR7aPdXQUEpc8cxj7S7PlaYxVK2sqcaOJmTOJ5v2ANQ
         JopfZmvvnCfp4xLkv90ZaRgboBQAuZCxDCxWd3hSFGnzeE7igPnYlhApd4Xn34fgp/7W
         kMUA==
X-Forwarded-Encrypted: i=1; AJvYcCUjXzQhfFGDWXfQ/RUzNfdAMhVsxOtbjxrf0LaxRZWoqRQId7I5OmycHjhH/uH8C0PgqswDinypMtJPMIabACrfU6hBQKa5k97SNoUk
X-Gm-Message-State: AOJu0YzyMPWxiFTn/mPqsIgkV2GpAwI6SL77ajn0rxJeZaBHgE3Hosx2
	DqgKpd9TqotmOggMhPmihyK30V4kMpP5EponCjLOtDfxKbxoope9
X-Google-Smtp-Source: AGHT+IFpCAQBHRxEXaGvHvvm/ww1HmZ8U5rh1PayYfxsFaEDMwbJahZsnwzxcFtYxKvhuN6HXZMKIg==
X-Received: by 2002:a17:902:f60c:b0:1db:3a22:1fd6 with SMTP id n12-20020a170902f60c00b001db3a221fd6mr5381617plg.66.1709388230940;
        Sat, 02 Mar 2024 06:03:50 -0800 (PST)
Received: from localhost.localdomain ([49.142.40.215])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090a899300b0029951d04dc4sm4783322pjn.54.2024.03.02.06.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 06:03:50 -0800 (PST)
From: skseofh@gmail.com
To: robh+dt@kernel.org,
	frowand.list@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daero Lee <skseofh@gmail.com>
Subject: [PATCH] of: fdt: add size 0 check after page align
Date: Sat,  2 Mar 2024 23:03:35 +0900
Message-Id: <20240302140335.117769-1-skseofh@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daero Lee <skseofh@gmail.com>

After page aligning, the size may become zero. So I added exception
handling code for size 0.

example : 4K page size
    [before page align]
        base = 0x1800
        size = 0x1100

    [after page align]
        size = 0x900
        base = 0x2000

        size &= PAGE_MASK(~0x7FFF) = 0

Signed-off-by: Daero Lee <skseofh@gmail.com>
---
 drivers/of/fdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..01156088fbb4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1232,6 +1232,11 @@ void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
 		base = PAGE_ALIGN(base);
 	}
 	size &= PAGE_MASK;
+	if (!size) {
+		pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
+			base, base + size);
+		return;
+	}
 
 	if (base > MAX_MEMBLOCK_ADDR) {
 		pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
-- 
2.25.1


