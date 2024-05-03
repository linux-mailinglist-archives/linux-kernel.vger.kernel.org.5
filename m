Return-Path: <linux-kernel+bounces-167832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51308BAFFF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ED11F2351E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE59815539B;
	Fri,  3 May 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EKNc9O5l"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60F8154BF3
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750524; cv=none; b=pyQhPjCgYizeoBcOH/iaMdTG7y4dvZaTLEOJbBpX27dVZjqFOneDMg5cvc1fpmwCGkThMZPDXSlwLQS6AjWXrGv8VfchBFOudZ8tTXvgZ2pg/i/pv71hfAHO4XKLD6V04AC6gi79er3NFgTWFsAASsHIoWh8qxBFKUjWZqCLUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750524; c=relaxed/simple;
	bh=VYUWeYsJkSHYakTbzLM5OeloNJRthNdDP2NTbXPBmNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s88++yrBFHYGT7KAmI4Z/om9Ylm3+NumuKOpXmfqUjnzrNF5p4kiziEQKNJYExCIW0uPMbnMLL7aUE2JKImYS2r8m+HOIu6RjZ2tqK4JW+eSN1b6sWshLoboNv/rCVF3C41u+0gq/6AgQ/DbX3ffHVxXI1fBUudLDgdtXsIoHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EKNc9O5l; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e1a02af4a5so30526881fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714750520; x=1715355320; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDT6eBh45WPUqYiEUEshrnFAS6ax7db3lregcCkxLmE=;
        b=EKNc9O5lvlQZH/74zXIcVOdoia2tdT6EuoJlEqTNo7hgYlNIb3JbREBVGU8twfbQoH
         kSpIEwUvYGlVV7DoYKJLx8zmxiZA3eww7EtowYXdf5Lnk4jBWoej5JpNjqykal462B+T
         OwuR0Rs+G3jAOIuD0WILgGvEJH8znllwVj5+D5EYWho+rKb1sbe1wgvf3u48KJVvAdTg
         qENJYJaURbrDrUsTGJSnafSXyG1g4xTMz/MpJI/1Td80do1sVcnuW3Fyo/jpZ3DTBbv5
         QrR1dfEHNeGk+jIeSLDzhFztZn62QLZSLMuxnqJ0M/6gJId06jFxN00aiVglnMr6ac18
         O86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714750520; x=1715355320;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDT6eBh45WPUqYiEUEshrnFAS6ax7db3lregcCkxLmE=;
        b=pFrIq6u1CM4TkbchXcCSGE6iUo3r1t/VQSqxMvGHrk1PCP7Lgh/cxN9wgHjG1fOCMv
         kDr7B4EmKxi7negNTePtD40LpUgS4v2FpFYxkilrLET55XGHLKBmbwRaxsSVxxyv40ur
         O6haMbO95n0DjyQiTGQe4o4rMiLBD0QVKQVYGE0ZDIsjn2f7Ty2K6kJpneWiiJZ7WyTm
         rMrVOpqxg2AI9fJeAJafyyTuLnBX73xieSILqaOjkTC3+35+cek+NToeMUA4FRDXORik
         b35x0RYpUh8qTrTJHGZXD/CCp8lsVn6kJIdRDQmWDKRqATrLkPZRQX9va4MmKa86CYt5
         XExw==
X-Forwarded-Encrypted: i=1; AJvYcCXsQb3HKLQO5Af8YnugIKXzOEvFLMJsmVLuA1Q6gKs2qmZUSOc/IHPkkaB4QLTWnmKvGKVY3bYqGTtHdqKxzcPDAFJfjR3mL1FNCMnG
X-Gm-Message-State: AOJu0YyQxCOWP4eEW3ki+ssymzH1UW7EfjIRxr8QP1dTUHGanvU02AvM
	P5ZieCM+6jlY4Qk0ZvZlXXXMizZ9ms6oitcQTPWLrkY8WhWuB7s2+NJiMeL/f4Y=
X-Google-Smtp-Source: AGHT+IHTeRsDotTIHoakGXC3ItV2s1TSV2nlECEKwfrUNFgWZTNmBCibPYhn4BYzpljcRfbpd1k/TA==
X-Received: by 2002:a2e:9857:0:b0:2e1:a3dc:ed8 with SMTP id e23-20020a2e9857000000b002e1a3dc0ed8mr1986168ljj.4.1714750519836;
        Fri, 03 May 2024 08:35:19 -0700 (PDT)
Received: from [127.0.1.1] ([79.87.205.120])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b00418e4cc9de7sm9702373wms.7.2024.05.03.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:35:19 -0700 (PDT)
From: Julien Panis <jpanis@baylibre.com>
Subject: [PATCH 0/2] Mediatek lvts_thermal driver: Fix wrong lvts_ctrl
 index
Date: Fri, 03 May 2024 17:35:12 +0200
Message-Id: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADAENWYC/zWNwQrCMBBEf6Xs2YXYVgL+injYxq1ZTKNsQgmU/
 rtbweNjZt5sUFiFC1y7DZRXKfLOBudTByFSfjLKwxh614/u4gZc6gtrZF0oYVprwVA1WanhLA0
 DefZMoyc3gzkmKoyTUg7xsGRuFf+qI/8o2+z3f7vv+xe6yl5PjwAAAA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Panis <jpanis@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714750518; l=760;
 i=jpanis@baylibre.com; s=20230526; h=from:subject:message-id;
 bh=VYUWeYsJkSHYakTbzLM5OeloNJRthNdDP2NTbXPBmNc=;
 b=tRkEk+4utiPJcOGZfx3on+2L5z0ljh5s9tXOgL1W2n0C2CWzwEo9YSOcRrpNVoV9afJUE2wjd
 eXNSa/Qq4MCDz8WtXuEMqHA+HEQ/aIDxXpw/evDWphfC0HOVR7HCR5S
X-Developer-Key: i=jpanis@baylibre.com; a=ed25519;
 pk=8eSM4/xkiHWz2M1Cw1U3m2/YfPbsUdEJPCWY3Mh9ekQ=

PATCH 1/2 is a minor change: it just removes 2 unused members from
'struct lvts_ctrl_data'.

PATCH 2/2 is a major bug fix: it fixes a situation where a wrong
array index is used as 'struct lvts_ctrl_data' type item.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
Julien Panis (2):
      thermal/drivers/mediatek/lvts_thermal: Remove unused members from struct lvts_ctrl_data
      thermal/drivers/mediatek/lvts_thermal: Fix wrong lvts_ctrl index

 drivers/thermal/mediatek/lvts_thermal.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240503-mtk-thermal-lvts-ctrl-idx-fix-ca7e7ea47a0f

Best regards,
-- 
Julien Panis <jpanis@baylibre.com>


