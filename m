Return-Path: <linux-kernel+bounces-141338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D478A1CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F67B1C21B9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D249446D6;
	Thu, 11 Apr 2024 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hT3mg+kc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF3405E6;
	Thu, 11 Apr 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853770; cv=none; b=YPDe+jCx0zPNkyB/AzYrq24mbvyv6DhPby2NO4JaP+BbaPUvD468IkRT8Lwplq3VhMXMLYsY6HmREZZnSlnQyg1+gy0GVsF5Q69YCANE+4j1pdoRQtGKEyexrq8uezG0v+6HeqUrMV0WRnKG2Ml7UIUh7L1SsiPIRdU8QfDtVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853770; c=relaxed/simple;
	bh=BI5OdDgHvBNY3QFVjbWJ82A5vKMB2cwZZJBVWP8kcH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=loS2M81Nh7v+xC4AGp22YDz3GEzCCCSmg87Vea591is/ZU8xr+3Gnuy63AeCHYd2D8JSedyaoK/L4nFeeaZ4cwGDEntGPJHkDp5qLDQylNxO2kP0piwj0tyk6kkIDiTyW5vZ7ig6OyxBYto6qkM3dFXa5g+bUi3FCziF6zkE+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hT3mg+kc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-417d092f39aso175675e9.1;
        Thu, 11 Apr 2024 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712853767; x=1713458567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uU29TjRIzlqUd1qRILPxi5ETTNjawZxtpfK0rLH2fmQ=;
        b=hT3mg+kcubZAgi2jHJpRCMw+OeWnt/Qns7zjvhmWiWAnOQiuk3G3KUgzWCmncQZcT6
         JlZHqR3Pr/2qAnNo2cMvYvIZ1km6bgATATx+qifhETV+QhDJJ9/I9LYJAUxY1DMZDq3o
         MOhLWOs1wCN6Qaubyi4F3EdzXAhMKtUDUElZYXZhEcgctCgo9E6cBWMu6boPfiqhg9ra
         XhNEN5l6qjxG/W/JXUc2cDMXfRyZpmQP1meO7adQYz1rsfbQmWZaEqPiwg/hdiXQ2eFy
         MlpX7TFvoj+hIcFkQk/7DAsoZWVqg4dM9pbtb6lw2aTPsdlfBkAedYIiCmA6HSSmzPwB
         0glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853767; x=1713458567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU29TjRIzlqUd1qRILPxi5ETTNjawZxtpfK0rLH2fmQ=;
        b=vqsRb89Hki2OUjf7kSPCk7TiTNyEY5xMXM9NeFSq7T8udy/YasRf512pk4P0JD7P4K
         drCYdE2jyHAtYr5STQwoE/tPie7+DeKq1dX4587bVLO5DHXNipSohAgvXgwIu9UGhFcr
         J03dUI/W3IgWU2rcA24raUvcKXr4HBGn8JoA8Yf3Uk4/gbXE4/h9XcXuBZEqS1WciFJZ
         D683oKLLcmAiCIiI2woGQvxSb06fgxG4wZSOaDjtp4hvvwgMeDuD2yLXAWbTdRei00p7
         7X4unog5DOwduyK6/iDp4+N+VrEaD0T1kON2zn8t08LGZ9L0A0sdqSuNukruY2idVtx/
         jYMw==
X-Gm-Message-State: AOJu0YwVgeociwZ+4yoZcU6UhI54iphWE0sN93tb/HjQRvRlH/6ko8YN
	nc/KdWQ98ZT4D0s/ZSvHFQnSjtbssBgo9FBxiNi/AfSgasBBofZUXNgwwQ==
X-Google-Smtp-Source: AGHT+IGWgfDlTe9R7P4iyjvZwuNmmcFVKqnk+p/g8h8BlwK6VSoBhVwjO/xT9n+pwDNknAGeK3S83w==
X-Received: by 2002:a05:600c:4446:b0:415:ff48:59fc with SMTP id v6-20020a05600c444600b00415ff4859fcmr3281651wmn.8.1712853766714;
        Thu, 11 Apr 2024 09:42:46 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b0041668162b45sm6060324wms.26.2024.04.11.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:42:45 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/2] OpenRISC module fixups
Date: Thu, 11 Apr 2024 17:42:30 +0100
Message-ID: <20240411164234.1997000-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series implements some missing OpenRISC relocations to allow
module loading to work.  I tested a few modules and these relocations
were enough to allow for several modules I tested with.

In the series we:
  1. Update the relocations to add all of the relocation types currently
     defined in gnu binutils.
  2. Implement two of the missing relocations needed for module loading.

Since v1:
 - Added patch suggested by Geert to rename all relocation types to the
   R_OR1K_* form.

Stafford Horne (2):
  openrisc: Define openrisc relocation types
  openrisc: Add support for more module relocations

 arch/openrisc/include/uapi/asm/elf.h | 75 ++++++++++++++++++++++++----
 arch/openrisc/kernel/module.c        | 18 +++++--
 2 files changed, 80 insertions(+), 13 deletions(-)

-- 
2.44.0


