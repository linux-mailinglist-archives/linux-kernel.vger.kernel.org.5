Return-Path: <linux-kernel+bounces-19269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B19826A99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7952C1F213BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFE012E44;
	Mon,  8 Jan 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fabzwQ3v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED64212B7C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704705654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=48TtFxmkBLq08biP3z1ck/nyrB9vsB9Au4Xw4KzideY=;
	b=fabzwQ3vSLiU3CaNd0KBVcTS4APNtA6nVKIR8Voa53aBam8W+X0GAUwSXlimjHtusJKozZ
	qnHvHjwMtWuomwdaaoXUwVLEkHg8NwjEq3SE8YlpRE7ClNPeCrzDI0AP1WOlxOANNkwfqZ
	4LWTTiUvVL3Qsye+fp3VHXv0NeNOnUo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-SoY_W1zvNASHI7HnQi34mg-1; Mon, 08 Jan 2024 04:20:52 -0500
X-MC-Unique: SoY_W1zvNASHI7HnQi34mg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-781314b6298so32045885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 01:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705652; x=1705310452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48TtFxmkBLq08biP3z1ck/nyrB9vsB9Au4Xw4KzideY=;
        b=N4n6nMn+Gn3ftq8O6nxP1JVx+fNrKLKxvR0gDcMXErs/wKuVaRTgmhEFVvkqDfP/uT
         XR9P8tLUmcvWdb/C4EZyAfiWbb/HSUwjHOC4wKC2a7FRCxrJLrnXDr2P0V08pkzV+1HS
         9jIDTFiRpFrvCMw8/KrcpXh/GmeQv27ZWGswwzdWCKbWWUVFLPKFDdGjTVe1TUkxXzKG
         ykTOPTPduBBb2vmHuhlmO81SlWEEXVJrYgszl43wf61xlArviHBuNEHj9NiEkIzsrjWb
         Rwy87owY63AsmWNTyrtQfhuq13KuzseAZdddmrCYhfYJwH5U+5vZmfY/gFIAQd2jHUBy
         ARfQ==
X-Gm-Message-State: AOJu0YzFU5epFJy4TezeBuw8uXB4o3ksrDcBRDEy9DrH7wUeyij18FYW
	n23mLvWuUKlX6aXwtN07DGeST9WaJhEcJ6R5QNYp1ydKvwZj2UoIjwsUilt8DEsN+BVXGiF7eRY
	hTJ5l0TSJJUQpLppI0spxc8WllRmqkIs3
X-Received: by 2002:a05:6214:2305:b0:681:7ea:7ac2 with SMTP id gc5-20020a056214230500b0068107ea7ac2mr1913600qvb.1.1704705652211;
        Mon, 08 Jan 2024 01:20:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSYTkeF6XSZKtSHbVgPwqgjaTeSq0UBVxgUw+1xaqYnJhub7w67LhH5GVVx/wDOpiGTWPBmA==
X-Received: by 2002:a05:6214:2305:b0:681:7ea:7ac2 with SMTP id gc5-20020a056214230500b0068107ea7ac2mr1913588qvb.1.1704705651960;
        Mon, 08 Jan 2024 01:20:51 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id dm4-20020ad44e24000000b00680613267d5sm2732554qvb.115.2024.01.08.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 01:20:51 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	David Gow <davidgow@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v2 0/2] platform_device: add new devres function
Date: Mon,  8 Jan 2024 10:20:41 +0100
Message-ID: <20240108092042.16949-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Fix wrong function name in docstring (Uwe)
- Change devres function name so it becomes obvious that it's requesting

Patch #1 adds a new devres function that I found could be useful for the
driver dcss in drm. Patch #2 makes that driver use the new function.

I compiled this successfully but unfortunately don't have the hardware
to test it for dcss.
So you might want to have a closer look.

Greetings,
P.

Philipp Stanner (2):
  platform_device: add devres function region-reqs
  drm/dcss: request memory region

 drivers/base/platform.c             | 38 +++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.c |  9 ++++---
 include/linux/platform_device.h     |  3 +++
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.43.0


