Return-Path: <linux-kernel+bounces-74121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E785D034
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B817B248E4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F439FE7;
	Wed, 21 Feb 2024 06:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3x/QEPK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204338F9B;
	Wed, 21 Feb 2024 06:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495309; cv=none; b=R2MmIQF0tn9C09X3pkksR1xpducl4B7QWHb9KQCdOS9N+fmn6ZlNsWfH0ZeaYtOxzT4GmzqzkpmPmpQgEz91nffgz4/a2hEJ9Ad3fUYKAi9Q5bh5P+FbrYG3ldZIJy05ZWQmlxfe08ZcHcqCpr/N5z+DDmtVpr+qIHKCGQ0Peus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495309; c=relaxed/simple;
	bh=44XkvpDcBDxX5rZg4/ZUSxigVTajxgUFJqfJboreeOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=US5h22IZ5eJ9d7G956s0FDqVoHfE9lBQkP7bOjoEHPvbCbVRQYDIEYRiOyGQe2B6TOF/KbOC0PeS9bLYKQOIMwpIYhptUtJJ5fUTT7S4GfHqaqTqYfexpqMqRc0n4ShdzJlDl5aUEkwetaQo1UttvJG8zVfie1jIrOcOHxQZm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d3x/QEPK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EswRYSMjvhqRzU4zRKnoIRXs9psC+v2E1sO0MEvmNfs=; b=d3x/QEPK8TuB2dSaC9jfGhQQJa
	YQH0tW1ibpm5h2XUAUkDsUFPrP2b/XUMIj1YBrOpMLHiCUCcGnG2YrNvr8yedsW4gvUsPQ8c9/YJq
	hVzgy8cf0USltCX9HP1izjmAwItEY6u2svDlFFjk8mOi3dhJ97C1HFVT1SrydjQ4wPLY0siUq7G6x
	h4moUDMypYdVxQim4PR/eBaFPwwGK4pwSUx8erNwr1WzFZlXt0zsL3rboEo9SwgSPqA/Dv1Fz2rjQ
	z3k1s+KzCKWs0dMpEkqqAh5N9XkB7Bf8s+24Zjd7Kx/93hSrDpCQevWbb2ErFaORPI8B8urUDOaf7
	TuumgN4w==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcffv-0000000HHf5-0LCc;
	Wed, 21 Feb 2024 06:01:47 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH] leds: leds-mlxcpld: fix kernel-doc warnings
Date: Tue, 20 Feb 2024 22:01:46 -0800
Message-ID: <20240221060146.30850-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "cled" to "cdev" to quieten kernel-doc warnings:

leds-mlxcpld.c:86: warning: Function parameter or struct member 'cdev' not described in 'mlxcpld_led_priv'
leds-mlxcpld.c:86: warning: Excess struct member 'cled' description in 'mlxcpld_led_priv'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vadim Pasternak <vadimp@nvidia.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
---
 drivers/leds/leds-mlxcpld.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/leds/leds-mlxcpld.c b/drivers/leds/leds-mlxcpld.c
--- a/drivers/leds/leds-mlxcpld.c
+++ b/drivers/leds/leds-mlxcpld.c
@@ -77,7 +77,7 @@ struct mlxcpld_param {
 
 /**
  * struct mlxcpld_led_priv - LED private data:
- * @cled: LED class device instance
+ * @cdev: LED class device instance
  * @param: LED CPLD access parameters
 **/
 struct mlxcpld_led_priv {

