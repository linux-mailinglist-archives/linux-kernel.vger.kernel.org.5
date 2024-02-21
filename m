Return-Path: <linux-kernel+bounces-74931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8370585E02C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129611F223F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B937FBBA;
	Wed, 21 Feb 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="soKUNHFR"
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6667F47B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.182.159.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526779; cv=none; b=mCTrvv426jZ9wcingev+s2p8bR0bWMng1Z32US4oOD05tJOu1kf7VV1i6UGBRC15ByXzhadilvRqGZP+6KzMXc3o6P0Xtb9FvIPpcMC5prK/xtkcfDjcRK5FfiS2ssDsSv92DMxW6z4zOi+gHZnFN4vrDXxlx53vd89a7RDS6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526779; c=relaxed/simple;
	bh=lBKWNCjz5XeMeeVLKV0cVIhl8GuROrhj8AxVnzf8uiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3mkkUf4dExNzmCRJ9QXoxtpsCdga+3KNkViHvrwOPdCCI3YExxsH+lFbPViWxB0nWSK9ynM/XF+RXpMPu+I31XjH5SpYC2V73PCNPVb5ULDepXrASMDhy6/+zu/XA+UoXZ5hQb1sKFB4KXZius4F8n3HeZ5pUmQu7jvSGjqanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=soKUNHFR; arc=none smtp.client-ip=62.182.159.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2CE5910D835;
	Wed, 21 Feb 2024 14:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1708526229; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hLJvt3Qp8v0w1uJwmrYsCccfbrCeUtcFvurCzwm/ryk=;
	b=soKUNHFRozKgZhbs78Di9BwEv+DFo1m8s8wCoI0dKpxPLKZQbu0nA3Epg7DWutgUrOn/3T
	tYiKGxTa9ipWbCurbuOvTVnQtiK3Qe8A880bTN4ITxI7xZqz6DQIV5e0F6cQLk5+LvVLzm
	UeOSIfkba1zKKzyntwch2iiqNzVM3DoA4NHhEU/W6jCMfthwrlvfriJiBlwRTmh2XM+KNs
	X/I63zYloAio/4TGsDXBzO6mU5Z7Fmnef4URwMy9BwHaPS8Efm9ZzPkQsk2C8abv6JcTH6
	ztiT43pVmEAF95TVn5XzHes3DFqCLJmHXjxJnGjE6Blrl96ahitwrJVyyJghVw==
From: Viacheslav Bocharov <adeep@lexina.in>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH v2 3/3] soc: amlogic: meson-gx-socinfo: add new definition for Amlogic A113X package
Date: Wed, 21 Feb 2024 17:36:16 +0300
Message-ID: <20240221143654.544444-4-adeep@lexina.in>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221143654.544444-1-adeep@lexina.in>
References: <20240221143654.544444-1-adeep@lexina.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add new definition for Amlogix A113X soc found in JetHub D1/D1+ devices.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/soc/amlogic/meson-gx-socinfo-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo-internal.h b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
index 3ebb80972fc7..2028101bb9b2 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo-internal.h
+++ b/drivers/soc/amlogic/meson-gx-socinfo-internal.h
@@ -78,6 +78,7 @@ static const struct meson_gx_package_id {
 	{ "962X", 0x24, 0x10, 0xf0 },
 	{ "962E", 0x24, 0x20, 0xf0 },
 	{ "A113X", 0x25, 0x37, 0xff },
+	{ "A113X", 0x25, 0x43, 0xff },
 	{ "A113D", 0x25, 0x22, 0xff },
 	{ "S905D2", 0x28, 0x10, 0xf0 },
 	{ "S905Y2", 0x28, 0x30, 0xf0 },
-- 
2.43.2


