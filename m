Return-Path: <linux-kernel+bounces-122412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6E88F6D5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0064729A5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A0B3FB89;
	Thu, 28 Mar 2024 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="30zK5pRp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58369A92E;
	Thu, 28 Mar 2024 04:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601717; cv=none; b=kM/xxq8sL6MNe/au40ORgGn9WdtShojRuvAcsx/5Wd1C59s/3TBI2VgUiB+cmqfZ+3uS1HYmxBRa0oj8zV41cusycEaZ01OFg3cn2mWiVCvZP9IZST9y6ByTUqzqmM6ZPXCKbgU+ssaqSIcFQ6Q7BgFBob/8DfSAtMbZeK6aKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601717; c=relaxed/simple;
	bh=3dCOe5qEg8LQcdTQOWQtPpxzFP1h9Y8FsuBoFGQ6Coo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V90QClpnN76GCVY1YxYw4DisQcL05Nx+oD/UDu+IGjVO91cwws9ClyMmIXLArDsqA9Yw9mlUHQI0wdG8ksS1sOmSUPU3NnroAMJH5px+VekMP25q/y6dQFD2KMPz/DYykgw7OI+5ECeON8PWzyW4/xuUroevwZ+KI3ibOCT9s64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=30zK5pRp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OQoilj+soa24Mgg+p59BIgshZBpGmcYgdkwIwgfwOhY=; b=30zK5pRpPo4t2FUFE6RwogSfTy
	8SxGGahLDFwId2tyLuh7TJTRInnHjxkCsyFTiVZxvUU6/qjGxAuXqpx5Q14ss2HM1qMqajJU7lTjf
	qEqI06Xbg5pzwB16alY2R11F/Q27W/Dg6b0crMON3Ps6ilSk4yREFmg+6Luxgwwi81EdRUAw6nxhv
	+9pLuV6jPivgSETJHrl1GwAeUNGLFF9tt3wRHf3rGz4zimkR9BtI1HxzmzeGwGEz61jQ/4AkHozMR
	RtwIMG/YpFvfb3Oun2tBkMyINgvuUiX8QmAKF8+/vRA4qfs2lmgAtUStCnPT9jVFFwlDNYi5EsXXM
	WMRAm1zw==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphnH-0000000CTA4-3RzR;
	Thu, 28 Mar 2024 04:55:15 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: add missing kernel-doc for pwm_chip:cdev
Date: Wed, 27 Mar 2024 21:55:13 -0700
Message-ID: <20240328045515.15874-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a kernel-doc description of @cdev to prevent a build warning:

include/linux/pwm.h:308: warning: Function parameter or struct member 'cdev' not described in 'pwm_chip'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org

 include/linux/pwm.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/include/linux/pwm.h b/include/linux/pwm.h
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -268,6 +268,7 @@ struct pwm_ops {
 /**
  * struct pwm_chip - abstract a PWM controller
  * @dev: device providing the PWMs
+ * @cdev: &struct cdev for this device
  * @ops: callbacks for this PWM controller
  * @owner: module providing this chip
  * @id: unique number of this PWM chip

