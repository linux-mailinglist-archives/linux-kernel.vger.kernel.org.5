Return-Path: <linux-kernel+bounces-10295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0081D24E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 06:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDAC1C22570
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C76ABF;
	Sat, 23 Dec 2023 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vcy6fL6Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8238D6125
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ubmihT4wj5QRLZEmpW/gNvdw69PG6Q27Y0TAoUTCeR0=; b=vcy6fL6Yj1dglnkm37wedJvHqN
	0zQA1eEbkeNogDMqXtsOl2YlKSK3r3Dh3uHwQ2s5pck8Z5NqhydgBVfAfqq7Jm3yjFEVqrCFSAedn
	rc5r+Et0BayUfEo2rwfVt1OaOMjsXR6W/0WjCZ2B+HJ4Ff6cmeSnkA+u8+XOmkipDrVwRSiI6oGwg
	idTpAsk93cIAgHuBXaU8ISvUdsFeZcma4FHYSeYiO2RPF0Iokno9IuVD2ppGx/kY/w2rIQM4XKRAI
	Fu0PUf2mhpzPjwujAWAL3KF6MQyX4uFKoVniOqaM5WRPDtU8Sf/uEyEbk5o/DTlFJBqITdP1P23Cd
	4bZqcVLA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGuCQ-007OXP-2v;
	Sat, 23 Dec 2023 05:05:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH] driver core: class: fix Excess kernel-doc description warning
Date: Fri, 22 Dec 2023 21:05:22 -0800
Message-ID: <20231223050522.13867-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @p: lines to prevent the kernel-doc warning:

include/linux/device/class.h:72: warning: Excess struct member 'p' description in 'class'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 include/linux/device/class.h |    2 --
 1 file changed, 2 deletions(-)

diff -- a/include/linux/device/class.h b/include/linux/device/class.h
--- a/include/linux/device/class.h
+++ b/include/linux/device/class.h
@@ -40,8 +40,6 @@ struct fwnode_handle;
  *		for the devices belonging to the class. Usually tied to
  *		device's namespace.
  * @pm:		The default device power management operations of this class.
- * @p:		The private data of the driver core, no one other than the
- *		driver core can touch this.
  *
  * A class is a higher-level view of a device that abstracts out low-level
  * implementation details. Drivers may see a SCSI disk or an ATA disk, but,

