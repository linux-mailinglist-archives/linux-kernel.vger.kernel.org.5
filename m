Return-Path: <linux-kernel+bounces-10301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607881D258
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C80FA28516A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AABCA5C;
	Sat, 23 Dec 2023 05:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeco1Yus"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E4C8ED;
	Sat, 23 Dec 2023 05:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=V2ueZ00Y4pSQAAXdW8Qi8wcTt0Tuy56H5bP3lQmJS5Q=; b=aeco1YusuIy0pKsk68tqN5IIPo
	BVaanFizpuoiYw9FtJ5xH0SFbtNq+gnNEE7iaYHVF6RdO611eVfKsAR98s/vo7jy2PxasP6vQynnb
	uktPaR7XrfQEvlifVFMPTkHYXiEMhNxJuLWdXUbRd5zjuWXwvBss/6nLIteWKednggI9GfwWsIIzq
	lhcr/CmcHdqtmbmoNLmFqSvAn1E429biZ6qnsprbEAki8mn3K8eqdy6Obq203oyr/NaFdSK8WKSXL
	IoFUgOyy8Hq0qFcinwOT9coXpf/4vw0MtAKFXRFO0kl46O1z10hpFo8xPkmzXB4+epEIMvFtprsQz
	EPmmHYNg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuDO-007Oiv-0D;
	Sat, 23 Dec 2023 05:06:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: linux/pwm.h: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:06:20 -0800
Message-ID: <20231223050621.13994-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the @pwm: line to prevent the kernel-doc warning:

include/linux/pwm.h:87: warning: Excess struct member 'pwm' description in 'pwm_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org
---
 include/linux/pwm.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/pwm.h b/include/linux/pwm.h
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -69,7 +69,6 @@ struct pwm_state {
  * @label: name of the PWM device
  * @flags: flags associated with the PWM device
  * @hwpwm: per-chip relative index of the PWM device
- * @pwm: global index of the PWM device
  * @chip: PWM chip providing this PWM device
  * @args: PWM arguments
  * @state: last applied state

