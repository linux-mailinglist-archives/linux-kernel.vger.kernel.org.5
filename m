Return-Path: <linux-kernel+bounces-16673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E500E82422C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F3A1F216BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC22233A;
	Thu,  4 Jan 2024 13:02:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9422327
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T5R7F66TfzMpnVZ;
	Thu,  4 Jan 2024 12:42:17 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T5R7C6rXxzMpnPs;
	Thu,  4 Jan 2024 13:42:15 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 0/2] drm/panel: ltk050h3146w: error-path debug message improvements
Date: Thu,  4 Jan 2024 13:41:56 +0100
Message-ID: <20240104-ltk-dev_err_probe-v1-0-8ef3c0b585d8@theobroma-systems.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

This hides an error message if EPROBE_DEFER was returned when trying to
get the reset GPIO.

This also makes use of dev_err_probe in lieu of hand-crafted logic
inside the driver.

Thanks,
Quentin

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Quentin Schulz (2):
      drm/panel: ltk050h3146w: only print message when GPIO getting is not EPROBE_DEFER
      drm/panel: ltk050h3146w: use dev_err_probe wherever possible

 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 23 +++++++---------------
 1 file changed, 7 insertions(+), 16 deletions(-)
---
base-commit: ac865f00af293d081356bec56eea90815094a60e
change-id: 20240104-ltk-dev_err_probe-3c93c1b09242

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>


