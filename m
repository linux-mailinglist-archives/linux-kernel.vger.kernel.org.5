Return-Path: <linux-kernel+bounces-122822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AD788FDE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAE5293F99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0B7E0F6;
	Thu, 28 Mar 2024 11:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/5PmY+8"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF351C46;
	Thu, 28 Mar 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624561; cv=none; b=SZ3RMlzQOOCrzjJbqPVQVeWttrJJL+E+rWhrnu+6wOk8dy5L68Puna1lSFl5FBUpzgT5PMXTAQ9VKvD3T6GH8xuJRIQDNVH3WfgMPP2axGi2wyqFifBdkFpxH0iO2Di/MBved33WLgr3VHxsHzrsbF0G+WIcg/TEtTDjoaFTf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624561; c=relaxed/simple;
	bh=OjaCjAYXmOVIMPCD1vmVDcJeK/db0iibhkrPeTlXNGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XjtBfnyx0bQLMnNyGVzGfnlTeVwVYNqe0CIn8vh9u9/D5B3YNSQpW0l3vaPjgvlBO1Zc677hfYM56aV2aIE4MhlTnr01VvTInZ7bvZsLnySklKoxkz90u4yBtUgqfCoZ2/GlNGa+LS54ITSGMWLLh7KGGJxrUcOff6dgapprLFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/5PmY+8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41494c040a1so5634275e9.2;
        Thu, 28 Mar 2024 04:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711624559; x=1712229359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WybsyYGdRxLPs11yfwNBD1z9sFtjKlfAeK6fQFQ+BB4=;
        b=d/5PmY+8xpEwyxJLQXzTQURgNJCutR+GDcYIj4tmpwnMWszU637HiOGvBZQIo+CbeS
         gfX73hOWWEn/Epc7YQZgxbv1W3xPGVnubndX1PY3lEcux+IJiL8nuSRJ2Rv8ufwCYv/c
         GzisueLRpZBOyZU8Ws20YzuYQpBJgiNr6m1NM2Ne8j4WyLUOqYw9jlGyGPLmev6BJW5Q
         DvbvsZIAn1jHvsGRAEhzfh3/Q222eVbGN7nNfz4JP4eyIyARoUkz3k7C6+lJoNRTI2rX
         96ExiNdCL/Tkkz9ugP/6nUu/do3JxbrATcQirFLAeM78lv3uwoBF54Xo6z3IGCJFaYcN
         99ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711624559; x=1712229359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WybsyYGdRxLPs11yfwNBD1z9sFtjKlfAeK6fQFQ+BB4=;
        b=cgygRnwqJ+OeG/Nyv03T+iiXPf27HBNHCfBkyyqeV9ClybNZG6F3KpIKnZbI2ytNpS
         J7keyG3zfj+61qZG7WojdPGsfv57Y/BdwaISIDRF4SiWjGlQfBpBdkbDJA0Pl9OME5FL
         aQD9anYdrIqGMHESEgfZu+9Xl6LTbC17BndpIjq3ku2mWoKK5i6PcB202bPrsgE9sSOx
         y4KkFk+6P/CnZatRxq6vhbtpXpiXcv2Aq/6o0Th9to5JlN0VOku+1HcAZ/yTRlRrZoT+
         4APx+TNBD4GYPdUkxw/CS7Y4GQtf43DYBvtDTFL9S2mH03R4U1fbPhdLiM1dQO0ySHjW
         QR/w==
X-Forwarded-Encrypted: i=1; AJvYcCXL/dI7JDdirVv8tDMXr4AsyOO+5ArZ3awSd/IIn4wCN6Lk50qPLNFOcoHoLB5nVVWxaHPw7Pc8mcyXrxPDb1dNIHNp3YjlqYYcTPBS
X-Gm-Message-State: AOJu0YyvpAXyJnOS6fWzSRtk8pkju8XcJx70MxYD4iNKUgVFP7m4JYF8
	I6hqm0cPCXancNxYl59A7a0JhOtUA9D+LbFlQgLD6rSWWGSGqClW
X-Google-Smtp-Source: AGHT+IFp36refJW3aN0bcav4cApShn6gxfrOOufpHbhFyuPF8YMdAFwPTBTVMMjenFWczuNtSRfa9g==
X-Received: by 2002:a05:600c:19d3:b0:414:868d:1cbe with SMTP id u19-20020a05600c19d300b00414868d1cbemr2546968wmq.9.1711624558453;
        Thu, 28 Mar 2024 04:15:58 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00414807ef8dfsm2007874wms.5.2024.03.28.04.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:15:57 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Forest Bond <forest@alittletooquiet.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] staging: vt6655: remove redundant assignment to variable byData
Date: Thu, 28 Mar 2024 11:15:57 +0000
Message-Id: <20240328111557.761380-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Variable byData is being assigned a value that is never read, it is
being re-assigned later on. The assignment is redundant and can be
removed.

Cleans up clang scan build warning:
drivers/staging/vt6655/srom.c:67:2: warning: Value stored to 'byData'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/vt6655/srom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 1b89d401a7eb..e80556509c58 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -64,7 +64,6 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	unsigned char byData;
 	unsigned char byOrg;
 
-	byData = 0xFF;
 	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
 	/* turn off hardware retry for getting NACK */
 	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
-- 
2.39.2


