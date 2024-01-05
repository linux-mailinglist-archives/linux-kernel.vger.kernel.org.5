Return-Path: <linux-kernel+bounces-18106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 711788258FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D47F1F23FF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5F6321AA;
	Fri,  5 Jan 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="METOTHhM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D9D32186
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704475394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dtJeN7TACSQgao0vuoZrL+Z3Hkf2IquMRY0Uvyl8X9k=;
	b=METOTHhMp5DQ9ZqZ64vEVSFKLHjgKU4MtFlQAJzjlU/gdMHT0sCXMX1zL8Kp8DBfHpHNpD
	6e1RpCm2Zity7dIOGpVksTpWgmxWpXQcta0V4s9v0ttHDOdjKRCi6UEc0bpkpKU8XZjqMU
	n7GKHSC6UGXXKL8Ijz1RAasYyT1SNoQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-jv9TT6pvOmahQRQp5MgqaA-1; Fri, 05 Jan 2024 12:23:12 -0500
X-MC-Unique: jv9TT6pvOmahQRQp5MgqaA-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6dba4b70deeso484762a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 09:23:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475391; x=1705080191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dtJeN7TACSQgao0vuoZrL+Z3Hkf2IquMRY0Uvyl8X9k=;
        b=WPAqLAsWz3pn/oln+SXc6FXDaJ4OQeKV43JowL3qg8TTCs6xpPcgRJYYzjxBctGXM8
         iWeuAG99Qi5+gqZj6k4VitbVNyxwRu+6wY2uVTDsnjIsYotl4NnZaGw3hghbfQzDsO0E
         QLX5bvIehgnnqNy/37Bivve/UXPIarc9cNRthnFqBScxUJMNlEeYHlV3U46NnNtdpMJ0
         CydxI0B07yuXMNP/rxe6dONsXBzj9ebg0/sDjOKOXhS78m9t51/VmrQM810w9bpgGSmL
         KyDFnOJ1kQiUu83mkQkRWagXVHRi/vou2Uv9QJ8pnyH4/HY23zmUFlRN1k/PP5kvJFwu
         uqWw==
X-Gm-Message-State: AOJu0Yzc3yKDRU5x+WtGZqwsnje0lkR3kRm/4waPYigDQBfvBxD0S9qh
	B20C+MYVYWR67svsI/D5tKG26oqQ7oNYQRNW7AqZ3mRQyL8QRzphI/QrYyZh25kpFsSc1C/9v5l
	e4u3KfMmY5dXWbPFAt/3Qh0iOqF2dqNl6
X-Received: by 2002:a05:6358:998a:b0:175:31db:191f with SMTP id j10-20020a056358998a00b0017531db191fmr5533023rwb.3.1704475391329;
        Fri, 05 Jan 2024 09:23:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4W7UoEYVL25ZiTJPqQ+3iKgSUjpmhQaKfboSvX00EKet2J7PxO9VXhFiFvETA35RWG0dxOw==
X-Received: by 2002:a05:6358:998a:b0:175:31db:191f with SMTP id j10-20020a056358998a00b0017531db191fmr5533001rwb.3.1704475390938;
        Fri, 05 Jan 2024 09:23:10 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32d1:a900:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id t22-20020ac865d6000000b004282c862fccsm884750qto.57.2024.01.05.09.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:23:10 -0800 (PST)
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
Subject: [PATCH 0/2] platform_device: add new devres function
Date: Fri,  5 Jan 2024 18:22:17 +0100
Message-ID: <20240105172218.42457-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/base/platform.c             | 37 +++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-dev.c |  8 +++----
 include/linux/platform_device.h     |  2 ++
 3 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.43.0


