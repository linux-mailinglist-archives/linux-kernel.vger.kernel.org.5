Return-Path: <linux-kernel+bounces-10297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A080B81D250
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317E91F215E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07421CA6C;
	Sat, 23 Dec 2023 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DrcoGei4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFD3CA48
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=42KYBTqUA5ZtwEGNQfPFt0Cs5TDraR3/gNZadZC2bGY=; b=DrcoGei4DaeKZvr618bE9mJljM
	lZnjoNWvonDsRHpzZUjoHLmw9U15d+h5QsXv824Px/jVKbVnzKB0MwMfQlyCm/2yWoD6k5l+LMJXH
	Vph4WEBixYU9cWuzWEn0PIzAKfhmfk7maJI1vW0vpsgTBSut3reyKipI+WdhDP1AJ/bNIh25zenNo
	bd64rEAvC0YcDH2NHOKAXdSsgpN0bTHEYOquz2NKV+R//nwNT6OXMcUyN+6Xd2ITErMaZwVQSKoRT
	Qt4GtDTJOCeix8pVoQpZNCaNRKC47imE59VR7r7jY7KqZAffE+O0LV8mOCLqoJs+zxvp1Rhk2vC/P
	oKIJsC8w==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuCl-007Obr-0I;
	Sat, 23 Dec 2023 05:05:43 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org
Subject: [PATCH] i3c: master: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:05:42 -0800
Message-ID: <20231223050542.13930-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @boardinfo: line to prevent the kernel-doc warning:

include/linux/i3c/master.h:98: warning: Excess struct member 'boardinfo' description in 'i2c_dev_desc'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
---
 include/linux/i3c/master.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/i3c/master.h b/include/linux/i3c/master.h
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -76,7 +76,6 @@ struct i2c_dev_boardinfo {
 /**
  * struct i2c_dev_desc - I2C device descriptor
  * @common: common part of the I2C device descriptor
- * @boardinfo: pointer to the boardinfo attached to this I2C device
  * @dev: I2C device object registered to the I2C framework
  * @addr: I2C device address
  * @lvr: LVR (Legacy Virtual Register) needed by the I3C core to know about

