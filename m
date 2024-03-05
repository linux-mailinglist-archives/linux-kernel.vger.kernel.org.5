Return-Path: <linux-kernel+bounces-92354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAFC871EFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D0F1C231E4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BE15A783;
	Tue,  5 Mar 2024 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="iJ+9TT5d"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD0D5491A;
	Tue,  5 Mar 2024 12:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641284; cv=none; b=IWPnw5BDBRO1A+0mDilYMkflXkGqAiRrI9TUqX+EiELvsYLXHO9MIu+4MzyJPN4s/EnDAS2tx1h2U6rnb0Kia3el/+hTpDcPMUDgegEI6dd/nbVISELypihoifjbl8ewb+QRAsfype4NkSgNTH2EUibdwiaW91f1kXQlFbCmzLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641284; c=relaxed/simple;
	bh=GN1G4NyMvWBolsspYbu0gF+ZyFJ3Ms4SmSjQgZCesZk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XCMCBIMLb6vyleJ59fXZAExY8CrfuX0Q24Yzqz/utkpbSU6sgpeulLWdXvWiehK2EBXmjqeHKwwpU8XXLT1fdt0w2NNerPndI1GTaNkaH6tUTYzYRPaTwK79sZCERXa0T4ZfxYUmQfAnzBd7bdvL3Dx2qPeaZ3rnH2o+wpHcaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=iJ+9TT5d; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc13fb0133so41329365ad.3;
        Tue, 05 Mar 2024 04:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641282; x=1710246082;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RpDVIywGu+mJvIXOFGxusadZf1l18EI+lUGuf5OSG+4=;
        b=R1pwsboTgLv0Q+aJShFP3sihtAbizo0JYA9MD0MZTLwaPdywArMxhFgHrXUXW5c6Ae
         YWSUwx+9FnFsNg5TOp2V+loWD1uoo3bRGVWyoZJfn616F8pg6iwUIaGerJ85/+E9Qyck
         8I8YINFDqU2LsacMp5yNGVGA0rMxbm9SWlfhwl3peHQDHkj6JsTxsJY5R6t5mWs1k+Xw
         0RAMM5Mx2HVBB6VveRAoIuA9/EDm/HbIFXfWKQidfBBQWjYdbN/ctjx7b2Rsj3EBMRof
         kXIcoTIIBCN2S/++ZLKhG9vKDkJp8kb5bF+WbATsCYcyrAfU47F6DCzwGsITMThugzAJ
         YaYg==
X-Forwarded-Encrypted: i=1; AJvYcCWIe3befuwjHjUPFI8uB6r2ZN440sBQTdEwuTxuf+E2p3wZputuWq6B3MkahITFsd3uHXCvAZMR6qaKFVMjeIdE39qZTfaZNL1sH/WzLhMV50ypLnKKH2ziJmUZoQswIqPRsxsSt0064PM=
X-Gm-Message-State: AOJu0YxCFF7BS+rol8Z1rwrv5UHzQbryYEXeZl35l+D/FN53XyTsQw3m
	De4OgvoR5aJlXQc4Dcewl376NLam0brCsO5QXjIjgeqD7FImBeVx
X-Google-Smtp-Source: AGHT+IHpuMsf1ZJiOZka7p/FiwnMuc/YVUhf1GFTqo6hGAt/L35GMeh9daxAanvulu3wfU0Wk0zdRg==
X-Received: by 2002:a17:902:cec9:b0:1dd:151b:fa9e with SMTP id d9-20020a170902cec900b001dd151bfa9emr1851559plg.63.1709641282330;
        Tue, 05 Mar 2024 04:21:22 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001dca9a6fdf1sm10417663plj.183.2024.03.05.04.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:21:21 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709641280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RpDVIywGu+mJvIXOFGxusadZf1l18EI+lUGuf5OSG+4=;
	b=iJ+9TT5dKkMjIRx6HClkAtVYkv5PJw1hJ2pBMHTSHZAU2Cwwiaz6oDN1HQjLJZkZBkg44k
	oJwJV/wspoHpN/bhReO/C1kYz8Ym4d0pkvSjvWclaVcG6YejmoSD53YkjBY6sYYP9YcNdd
	Uu3q8tw1UaIWEcs/82XxeaN70bAlL075PlmMUgGL4zu7w82GZdmXRErGlrvHZJGkNl0H1o
	uZforwhiX9rLptLwKZ/ctiV/ER1IRtRMaKxzK9i9iLN7xSgDYIx0nThgdvopGvQvcpjafR
	utMLG3Znu6Scdkl+ZqeK2VsUQOmF7kgUZypSFQhilD2yop71ZgW7hje0cI4wRw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] video: backlight: constify struct class usage
Date: Tue, 05 Mar 2024 09:21:16 -0300
Message-Id: <20240305-class_cleanup-backlight-v1-0-c0e15cc25be1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADwO52UC/x3MQQqDMBBA0avIrBsYEy21VykicRx1MKSSURHEu
 zd0+Rb/X6CchBXexQWJD1H5xozyUQDNPk5sZMgGi7ZCh7Wh4FU7Cuzjvpre0xJkmjfztH1Tkns
 h1gy5XhOPcv7Pn/a+fwyupjJpAAAA
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Ricardo B. Marliere" <ricardo@marliere.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=GN1G4NyMvWBolsspYbu0gF+ZyFJ3Ms4SmSjQgZCesZk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5w49ttMZGRTTzHYaea508k7VdAAv+U7ckzf2N
 /sm626lc0mJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecOPQAKCRDJC4p8Y4ZY
 pnYdD/9qO73gM1EqWw5mEM2tjBt0xEpPH7+BhtYqEeXSt9wLxreoBjFgEIIdt6Pjb8+HT0NMVOR
 7QFk/LhkWF0x3mRveAAeV9IpmlmwCynDkZmNq0S+Dzcb3vdONtUGfB10fBG1JQW8Rq2GSEMF4tl
 qVYEsSj/hqZ3I9Kbf8ZxaAqmEn53mF3AbsCq5HIr9RHASNjLyfLyIhKDvQ2M7cVjLZs+GAensbz
 cVIfpLdMVMjL500gO1kHvIu/OiO5A7YboYhzbluh/YKMqqVv7SmKnRUGWi3RE5xjue+hs+R9BvF
 QmGDYygj63SNsJMe/XHjq82KfdJIkK+7r3fGRCIcgW0kapVDj1JVwO1Jtia4r0bY3FnlCAmZZbE
 6BC/1AEtxu9Tqem9SpCQWR3cKppkNKiMKl3dmYwvJsYWIEwQpp7eD3i3BAVhaTAcr7WNKc6y74Y
 nOsYcoVypc5G4JiMc15z77lD5NcliNqbgss7rw+dNvSCvsohCN5Ft3MlyPr2HdBYRJ0YSK44TQz
 FAelFLufkW/fKuLgYG3p5u9BAkHm3w8FGZC5xeVXeiZs2JqRwgKWM8QFk6o5TKaaBU/Mp5+E6tR
 C4xA+ul3A24g6qGPW9HXD0WEFPrhRC6kjPJWciPAp1F1BE4QgheZULODGFmCqG8R0pz6Ash/CmY
 bcg2BTnQ5o9Ocug==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This is a simple and straight forward cleanup series that aims to make the
class structures in backlight constant. This has been possible since 2023
[1].

[1]: https://lore.kernel.org/all/2023040248-customary-release-4aec@gregkh/

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
Ricardo B. Marliere (2):
      video: backlight: make backlight_class constant
      video: backlight: lcd: make lcd_class constant

 drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
 drivers/video/backlight/lcd.c       | 23 +++++++++++++----------
 2 files changed, 29 insertions(+), 23 deletions(-)
---
base-commit: cd1995b6ac7384149ad755b74e3c3eb25195ab81
change-id: 20240305-class_cleanup-backlight-62b91c38005e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


