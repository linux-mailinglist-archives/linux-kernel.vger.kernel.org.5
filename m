Return-Path: <linux-kernel+bounces-31976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7098354AE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537311C22119
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F136134;
	Sun, 21 Jan 2024 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RV6vfr1+"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E611368;
	Sun, 21 Jan 2024 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705816208; cv=none; b=WY2gr8kcS2yu3DkSSeEEIU2yTFEvM/NIxuAoDabGRiQ13OnkFCWxynH0gmNPD/17pCtww+H5XuxDYuiN0F6kagCQqvqGCssIaoyUjkleBQ2RrV9fjtusNdSXPdU47aCCV99WtpigE1VE1aWrap/0dGF8PeS+cpeqHx2tkpZXzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705816208; c=relaxed/simple;
	bh=h33UzZ0tWWCKz1+yrzv3DvA7kCTCgnjlmKSm4AQR1xU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcC7F6LdVOpu+ECrgBAZecSakUXZHbb3CyWqKkJ3ugb3cR4EPJuyz6mbEz0dOaV+tH+UIards2YRseai7P6ZVKOM5fyflqZL7+5FGlCdXLkih9Vbyrmu8XmNZOXQbyB6W8GpQ6zROfUDPktKupBqE+SEzc6nhnTWERhx04pvgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RV6vfr1+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UH6nDGWw2lXKyKcl5BO0YkgOounrr6R93lfm/znubaY=; b=RV6vfr1+hs6DGTuaCq1LAUNHPW
	a3PxdjPcMq1T1kOyLUzR+pQrLIG6SCNoCRWHuNNCZjG+1MVNHfjhzB1C32fbkTazLYxXhQfpTHJUO
	O5TfX57P/ZUHIK+qIWNDlNg3TM+QwWt8UA7TWV/OvDzRIndij+W3aWPP5UgcFyVYFrxmCa9Y0zbAl
	zhta8VLuv985jQccN6Ck0WX0RmMPxa19Vh2YfEBoP+n7DXErxhpK1aVTX3s49kCWdHAkGRZYBChd4
	kfwyc5l6hpEGotgVL5EAQ2ihq6knCFDdGWIFp6OR4EnJiO47bj901w5L7ECcoJ3CSLYhnTzr0o0JQ
	DyxFdVsg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rRQic-008vyJ-0C;
	Sun, 21 Jan 2024 05:50:06 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: dummy_evgen: remove Excess kernel-doc comments
Date: Sat, 20 Jan 2024 21:50:05 -0800
Message-ID: <20240121055005.20042-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop kernel-doc comments for struct fields that were removed to
prevent kernel-doc warnings:

iio_dummy_evgen.c:43: warning: Excess struct member 'irq_sim' description in 'iio_dummy_eventgen'
iio_dummy_evgen.c:43: warning: Excess struct member 'base' description in 'iio_dummy_eventgen'

Fixes: 337cbeb2c13e ("genirq/irq_sim: Simplify the API")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/dummy/iio_dummy_evgen.c |    2 --
 1 file changed, 2 deletions(-)

diff -- a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -31,8 +31,6 @@
  * @regs: irq regs we are faking
  * @lock: protect the evgen state
  * @inuse: mask of which irqs are connected
- * @irq_sim: interrupt simulator
- * @base: base of irq range
  * @irq_sim_domain: irq simulator domain
  */
 struct iio_dummy_eventgen {

