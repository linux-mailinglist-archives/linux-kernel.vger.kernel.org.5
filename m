Return-Path: <linux-kernel+bounces-22522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C654C829EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB128444D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54004D108;
	Wed, 10 Jan 2024 17:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="aryp8uRM"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA44D102;
	Wed, 10 Jan 2024 17:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 8910828B531;
	Wed, 10 Jan 2024 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704907392;
	bh=mjyfSltd/Lmj2z8wj65JHdOrQhfwlOTcV4rHxl3TvV0=;
	h=From:To:Cc:Subject:Date;
	b=aryp8uRMU3DrIpaEz2cseygXAUhmwFj4EwZEwI4andbp4zCrp6TRJCiRKSGTqm33Z
	 rXPxfhdhgJEMAPtkwhLSo8X2paY1cttgsQZYN6lQy2+4wWTtLNE7NtIWSU29sG3ddp
	 aaAuIb661C0o2ywJvTCNqLYSJRXiS8eI8LvfdIdY=
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/6] iio: pressure: hsc030pa new features
Date: Wed, 10 Jan 2024 19:22:35 +0200
Message-ID: <20240110172306.31273-1-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches covers the following:

 - small cleanup
 - mandatory 2ms delay between readings
 - support for triggered buffer readings
 - support for devices that have "sleep mode" factory option active

Petre Rodan (6):
  dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add spi props
  dt-bindings: iio: pressure: honeywell,hsc030pa.yaml add sleep-mode
  iio: pressure: hsc030pa cleanup
  iio: pressure: hsc030pa add mandatory delay
  iio: pressure: hsc030pa add triggered buffer
  iio: pressure: hsc030pa add sleep mode

 .../iio/pressure/honeywell,hsc030pa.yaml      | 13 +++++
 drivers/iio/pressure/hsc030pa.c               | 48 ++++++++++++++++++-
 drivers/iio/pressure/hsc030pa.h               |  9 +++-
 drivers/iio/pressure/hsc030pa_i2c.c           | 28 ++++++++++-
 drivers/iio/pressure/hsc030pa_spi.c           | 40 ++++++++++++++--
 5 files changed, 131 insertions(+), 7 deletions(-)

--
2.41.0


