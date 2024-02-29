Return-Path: <linux-kernel+bounces-86221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA286C1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EB91C21FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE11644C8F;
	Thu, 29 Feb 2024 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4fwe7aNv"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ABA44C60;
	Thu, 29 Feb 2024 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191178; cv=none; b=Xp48SZ9oNNDY3oniG25qBdeOiBX2xvRNLtHSGFdKZoRidusUoovraKE8d0gdf2BKVoq09L01jztvm+cy0WcEeUi2tSehMgBwObdLT3P+lKpceZkKB0+37eCvtgCvsUbje+1ZiB/n3e8N4Xxyc7pLqsOtuMKZlpnTO58S4HRi0RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191178; c=relaxed/simple;
	bh=tPCMm9iGolFXvWv5fvj5V1ItxLfXV2fIW6FWJFQwSzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KU81AO6sRHhqAmdf+rdVn+BUV2uP9H4mCULT2sa8cQlamWRUlFqXX9PLUkGDYRJ06MhJzGHtB9Mvu3hqmPaQI8MoLxRcxULzcWyVdLtkTOBGB75opttEgbH43OuziFVIcBiqyuB8ymMtybUGa3eNt+IEAxjcqAzISBZAaz6do0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4fwe7aNv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fdZMYkp4/hjcAN0ZLKNckyXABggtZ+R0eKZlDjrAclo=; b=4fwe7aNvamUnAok4A9TAPzHJS7
	WpMGXRFz28xXgi2J/nqSt07LadmdHrzwnKGbgEhajWvl5ZB3sEyvfiEk2uyzq5VeZlgNZ5gFMU+Vr
	mjgg56byh3NAtknArx6Sc4QaBEtLhp0MeTuVTk0Ndfh5UWjoJC5EP/QUF7BLIkNrTIsI9YF8iHCNK
	Hgso4+EDeCXliVZZBvhum5qWznvKLqdI78/EfSiRmQuierOU4ZoFxfoX1KpVgTqISOpzZSrPauB+y
	E4eUXD0N2CKJB7K98QlOI1KPLHZu8w3Cd0KT2c+hKyRuEnMOqHPgwzsm7IwDHP6IdFO1jO8MDzwrW
	OJv9hX5w==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfahY-0000000CRbT-0NOY;
	Thu, 29 Feb 2024 07:19:34 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	Vadim Pasternak <vadimp@nvidia.com>
Subject: [PATCH] leds: fix 3 drivers' kernel-doc warnings
Date: Wed, 28 Feb 2024 23:19:28 -0800
Message-ID: <20240229071931.7870-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix kernel-doc warnings in 3 leds drivers:

 [PATCH v2 1/3] leds: lm3601x: fix struct lm3601_led kernel-doc warnings
 [PATCH v2 2/3] leds: leds-mlxcpld: fix struct mlxcpld_led_priv member name
 [PATCH v2 3/3] leds: mlxreg: drop an excess struct mlxreg_led_data member

 drivers/leds/flash/leds-lm3601x.c |    3 +--
 drivers/leds/leds-mlxcpld.c       |    2 +-
 drivers/leds/leds-mlxreg.c        |    1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
Cc: Vadim Pasternak <vadimp@nvidia.com>

