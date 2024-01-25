Return-Path: <linux-kernel+bounces-39225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9983CD0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC51F23472
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564B137C48;
	Thu, 25 Jan 2024 20:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="x78Fr8UN"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B704A137C42
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212881; cv=none; b=nGo24CfB4iPeaRF2wVa/f+Izv3k+Jnt6zwA4MYtgb+6LrP9oEZU0X0L9vTDxcgZzr62kTg8lGf0/oI63C3Zho3GmBJaAe2kOIS/4R9Dn65JqT4pYgX5ERTV72cFrRCuvy2aHna8qIh/k1rDDyJdhCwbfGI1yLB0IRdCKS+28b60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212881; c=relaxed/simple;
	bh=DZzmmmrYIltVI6Z6RLi2zuyLdW4r682bNWAaWhZPbN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmQuHu2hRxfYFDQ/dfxIRBAlqFpjlPkXG0Rr7OzvmeVoc+go70KZuOGvixW5DVXuwDYJCQabCBR/IuY/y/eHzK4CfThMIUy63dCCxrhnZF6CKg5gMLjT7ogjBs0lpMvnS2k/12ZmujXxPgMrw9CfNFv5oGGV04yYal6TehV0Hvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=x78Fr8UN; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2e633c5365so193721766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 12:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1706212875; x=1706817675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LjZQMJu8JXGJ4/hFdnB0KIWnvhPMFZL0jbAwRB4Bxd8=;
        b=x78Fr8UNpqTMP5iRhz+BxjlMMv4ZP7MU+TwyRSuT7+B0OjNpeb8OCeVAWoJtZMaDsh
         xNB6GvgHFnGwqLqUnAxGxkvs7KEa4JKUuX2IClPG6JevZA4N5qFLgYUaQgomVn7smGUO
         7PHykjL2xQBwniNnaKZsr2rGcqzm554dLcGxIo/XzUQxn2kVpSDB1i08kACu8ZzxVh9/
         H0Juob9AiTwuia/o+EE+Cu0c1/jMPll/CcGSD69mMgkui/xPib6Pmwmug3iGG0JkYoEA
         IcZRt7XC83BhHbWPnhCWfxgLQXwv88GMs9/r9ym4V6rcV5wu489HWiDvEBgSRDiYQrLp
         hzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212875; x=1706817675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LjZQMJu8JXGJ4/hFdnB0KIWnvhPMFZL0jbAwRB4Bxd8=;
        b=nDU6fT2n+m/9j9gKJCvHXJL3o5BOSxY7isr7jLXyjbGYcKgaBsxFmvEAtqaVc1uJ55
         x56V1Pe/NAGh6eCs1axa0iHcGp/Ew7qa+OFwga6+3pL8I2wqNhK6suXvSaQ2A1CwSau+
         rU/mPVTFEIs+YOs59lgJW/xB5gfftuPFPvuYOOaK0y8BSC4Y35QJC9oxMnJ5NB4oy4fR
         VG2Stuib6sGZ2F0CcRDiSYcb3h15frnJhCuz1/pCmJIiUHPHBdfpwVVxhKLQLNOehR+D
         IPaHobnoS+guqlGYL3eDffd+ibopKcuRzWUhLee5QW5kOZBnpJqBQk7bJQmLaJ7Td1Pg
         HIKA==
X-Gm-Message-State: AOJu0Yytar+1NsS6uAAbXuJH+dq9RyTwlq7yXi/eV4PrFONH/WXUl/FY
	1nxpqsrNS9ACPFKjQ8lzUMV7Pi5zV1kfwfO77wEbsw1CuPABh4wd7lGGPSU08ko=
X-Google-Smtp-Source: AGHT+IHGkHmj96AZrG1C9Gzn4qdCJRKaw3LE7lV5CI3SQbvj9lV/LuLm0m5wCgvzJsK98B1SDt8pJg==
X-Received: by 2002:a17:906:ca58:b0:a34:8908:de0c with SMTP id jx24-20020a170906ca5800b00a348908de0cmr137234ejb.2.1706212875558;
        Thu, 25 Jan 2024 12:01:15 -0800 (PST)
Received: from pikachu.. ([105.225.45.176])
        by smtp.gmail.com with ESMTPSA id ss17-20020a170907c01100b00a3496fa1f7fsm195577ejc.91.2024.01.25.12.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:01:15 -0800 (PST)
From: Ezra Buehler <ezra@easyb.ch>
To: linux-mtd@lists.infradead.org
Cc: Chuanhong Guo <gch981213@gmail.com>,
	Dmitry Rokosov <ddrokosov@sberdevices.ru>,
	Martin Kurbanov <mmkurbanov@sberdevices.ru>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Sridharan S N <quic_sridsn@quicinc.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mtd: spinand: Resolve GigaDevice/ESMT ID clash
Date: Thu, 25 Jan 2024 22:01:06 +0200
Message-ID: <20240125200108.24374-1-ezra@easyb.ch>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>

Since commit aa08bf187f32 ("mtd: spinand: esmt: add support for
F50D2G41KA") the MT7688-based GARDENA smart Gateway no longer boots.
This is due to an ID clash resulting in the ESMT driver being used
together with our GigaDevice GD5F1GQ5UEYIG.

The following patches resolve the issue for our board. However, I do not
have any ESMT NAND flash chips to further test my changes with.

Ezra Buehler (2):
  mtd: spinand: Add support for 5-byte IDs
  mtd: spinand: esmt: Extend IDs to 5 bytes

 drivers/mtd/nand/spi/esmt.c | 9 ++++++---
 include/linux/mtd/spinand.h | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.43.0


