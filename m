Return-Path: <linux-kernel+bounces-98397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FA687798E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33531C212AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 01:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81480A47;
	Mon, 11 Mar 2024 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdYB/gPZ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD97EC;
	Mon, 11 Mar 2024 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710120864; cv=none; b=r2kf9isQYemAdlvwi4K6kMDVg1s+bZVZ9nF18UUuJA36A10kuuLAphoCmJraBQLUOH/xlobJqXy4RRpXfRRiJsTrB3aHEQNQLLGegKHG10ZwGau/26dIJ/c9nz99a5j/KABHTcz5QnwOw10UOC4t4/Xmp02x4lDL+BDPDEwFNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710120864; c=relaxed/simple;
	bh=gIWiCJvE0JHJgXOb6hHxrhgE+CyD0jaBCuuhnMb8YXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQjjS6vWnXKEe9oyTEOIjLJDW/FsuWALu0EyKTZvR1iBYN0u00mm2airp7aVNQdGsuOE4Airw45WXzvYyT/UlTNa86+VkwhG1Xe1WB9kZ6r+PkRX1U3qarJzyKMB92IhXau5aApuGTi6Yq1PWWLwqhXT7QJBbh0wl1AsdVHPjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdYB/gPZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd81aee2b4so12474645ad.0;
        Sun, 10 Mar 2024 18:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710120863; x=1710725663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VR+QQ5l8PpU95Y/xTT+3n13mQ9mpbvLS9Y3rI68/ZfQ=;
        b=EdYB/gPZ2G0bOkxH0ouTMOkMI+OMQjTXkpP2fQLJfSPVUq35copjvSk2SNGT37FhyH
         vKLfJQyBkYKHpOgvXa0g/PUgbRIUq9pks+ZfdygQvbtxncM5y7qG+V/QsM/PWqvZg+1b
         4sToPs9zvG2mBdH5xPi/GUveTj2xfQB/mXwoJWpj+anx9YXzkZyN1p5iHQXAzqN7+FXa
         Y7TyjhnLYcRj0HMvkKtbMdBkOXt2lynl/HWF/JbakpnG8pdvigZZw0eCuI8IpSrgss7o
         aTrAiu8WV/wRkHgK3qijDPcxFtfBxB8RvSNt0LeYDZt17i8qO54tkOzbnoq/QqHH4Mkv
         NdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710120863; x=1710725663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VR+QQ5l8PpU95Y/xTT+3n13mQ9mpbvLS9Y3rI68/ZfQ=;
        b=u32fC5D8Ye9xtU1nsNWHCF9gDq50jnM/wwqNoZspMK9rgqcT5NPnJJ63v/zHyIy6MS
         /Y6ZPRePmk9Z5wDMKjRcMRPGZZzcuMzlOey4aL6LItNTRcZ9Bdg29NTd97N8AWYq5XMz
         xwpnUvs9Z38h9+qW1fYQlf5X3O24hedh2wqpylTV/Kbq26gBptlb03SmSlkOX6zTs652
         Zs74kTBXuwokEwDCfaYEhxtbbeNQmSbQzSOUAMNUyTYkg+NAT0gimyoJuaSI6DgmzWLI
         NZO/CPcQod3cNaZDKfsOWiW8vFFmy8PkGHv9PM/PYydlGTO4oXG5A5c8J3BTukBmlIWZ
         iMVg==
X-Forwarded-Encrypted: i=1; AJvYcCUTpvvA1168oGUxeVA9Z+OkYpTHbwFowRIuFbGI1IbR5+K4lWXPqG3x4DAqXb4/XWP5eaSq+sJHXXvTZHPj/dulydsGpomSndFfN/MhOs3W42FLtPFCEbkK8hzUKINLBxJiKudVN7ie
X-Gm-Message-State: AOJu0YxgTEoymKu2xfS4jBgO8+tqeNavM3Bw0dSyKtpYm9B/8Cj21QTq
	yOJu7jCeFFM15WhXOqlJlMmmGXl5QaBxrmRneVop+QlEV8q6/Aa3
X-Google-Smtp-Source: AGHT+IGJdwZSdNxwoxWO8o+tapZOOpCyTd3U4i83c6tdD3UW5sHog1iZN71eTpdlG5F1RIfTI3rIAA==
X-Received: by 2002:a17:903:496:b0:1dc:6d64:dcff with SMTP id jj22-20020a170903049600b001dc6d64dcffmr5204730plb.37.1710120862533;
        Sun, 10 Mar 2024 18:34:22 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902e54c00b001dbae7b85b1sm3255012plf.237.2024.03.10.18.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 18:34:21 -0700 (PDT)
From: Mia Lin <mimi05633@gmail.com>
To: avifishman70@gmail.com,
	tmaimon77@gmail.com,
	tali.perry1@gmail.com,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com,
	alexandre.belloni@bootlin.com,
	mimi05633@gmail.com,
	KWLIU@nuvoton.com,
	mylin1@nuvoton.com
Cc: openbmc@lists.ozlabs.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] rtc: nuvoton: Modify part number value
Date: Mon, 11 Mar 2024 09:34:04 +0800
Message-Id: <20240311013405.3398823-1-mimi05633@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since version 1:
  rtc: nuvoton: Modify part number value to match datasheet definition.

Mia Lin (1):
  rtc: nuvoton: Modify part number value

 drivers/rtc/rtc-nct3018y.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

-- 
2.25.1


