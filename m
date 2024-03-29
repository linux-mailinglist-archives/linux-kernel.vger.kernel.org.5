Return-Path: <linux-kernel+bounces-125279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCB1892358
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40821B22058
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0B9137932;
	Fri, 29 Mar 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lfvwEG0K"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891F2566
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736955; cv=none; b=G1a7KApMe7P9X5Lrij5D1VFY7GTv/72MZ4aky3NnXjjGn0/aeqJRNuvxaHzAA3rzClGetz4JMUCg1Q7EI14nr6JvwHdHnMyiktnhnWadC72i3WfIl2SnFwGGVS4YJRPOrfKwf9zAKuyGgfnG/Fjx5V6jzz0RmScZEg/c/h2DybE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736955; c=relaxed/simple;
	bh=EVV3QmuuKNiguLSsuKsSiVzu5NC4P5bKVI5myK0rG0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m7ItiElTJJTE86EIA+19+x5pqkyOe0CVAHvyMphz2PSZ/bqOxb34B0syaNS6/1LnqKYZPg7GYOgJIJRmkfnphJYuetK1Bzh0E+2igEvyF8txaR/dj+vqM79WLrEhWCEf6ZBHvRJbsEcgji6ZinrB9KH+RoQb6lui1qtcgSYR+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lfvwEG0K; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=u6ZgpvkaaGDYHEOzQJsHwpOK9QGPOGeHiXkxrVeGdKA=; b=lfvwEG0KzcGtCxf/xMPkfizHMU
	IEO8Jvj4pryuyTbBN3MjGVPsnhwf7psjuXFoQl/DD1fq7VmnQZud2Am2tU3jyMuZo1dHJDl0hi1b+
	TrejreAGAvGi/D42fVWZF75jMC7PYYCt82PFVN64R+YDXuLT/MD+QyDK2iRjvwko3/lwOAOdZP8Io
	zUn17F3ZDzu8MYfdVo2gJPlDC0Sjfyf7aRsKnpGv641E4TiABILWIczQY9LllHRHSf5wTRTRdLzIH
	ZYO6YBOOB1zKVvEjbSiK6nf7X8FVvxGkZfW8kFDHgTLtDYSYP104MB413JIUfvAQhnrFGpqjHZs89
	kJDm//9Q==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqGyV-00000001bcv-1nOu;
	Fri, 29 Mar 2024 18:29:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	openbmc@lists.ozlabs.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] peci: linux/peci.h: fix Excess kernel-doc description warning
Date: Fri, 29 Mar 2024 11:29:10 -0700
Message-ID: <20240329182910.29495-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the @controller: line to prevent the kernel-doc warning:

include/linux/peci.h:84: warning: Excess struct member 'controller' description in 'peci_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: openbmc@lists.ozlabs.org
Reviewed-by: Iwona Winiarska <iwona.winiarska@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: add Rev-by, add gregkh email

Would it make sense to add Greg as M: in the MAINTAINERS file?
How does someone know to Cc: Greg on PECI patches?

 include/linux/peci.h |    1 -
 1 file changed, 1 deletion(-)

diff -- a/include/linux/peci.h b/include/linux/peci.h
--- a/include/linux/peci.h
+++ b/include/linux/peci.h
@@ -58,7 +58,6 @@ static inline struct peci_controller *to
 /**
  * struct peci_device - PECI device
  * @dev: device object to register PECI device to the device model
- * @controller: manages the bus segment hosting this PECI device
  * @info: PECI device characteristics
  * @info.family: device family
  * @info.model: device model

