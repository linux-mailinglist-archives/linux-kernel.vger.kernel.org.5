Return-Path: <linux-kernel+bounces-161512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939058B4D05
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 19:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E087281863
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5540273539;
	Sun, 28 Apr 2024 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ALa1Y9AP"
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860673505;
	Sun, 28 Apr 2024 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714323781; cv=none; b=VoaM9t3j/TmT/NLJP++yIzmPxbF3hXbPAdqVe61loOcMR1X4KAMiKbBPy0NyKg2DLXoDHRCPY3hUUSjowin/1zpBrnZ+G+Et2Nk2gmIWafbkB5IQ2x78Erbe4scffmZqfCtDv6UKtHOD7nmbsGtpv2++Yw0lhi8evDWyqe/pSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714323781; c=relaxed/simple;
	bh=NOChUkLc53HGxp6iS60sYnNJrUDWg1eYKPCqAN7ZKOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClY4MPqikpQvMnAa5Gi/H/5kYxPupKEWyCnXtuDJLpzNsNzkxDKTJJNwdJvLZ9prVyNBR/nhZz5XAoHz8/9w0RSyqvwUUDpY3uKGoWJb5ojRiNe/yrgAJinQGUkXEezkujdahBQvU4G/HiKoX7JFSMnnUW3++dmTWqTpwdC43oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ALa1Y9AP; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 17vNsHfVWPWAk17vNsQrRM; Sun, 28 Apr 2024 19:02:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714323771;
	bh=1J7yKW1JH/MbhhOzTjiWOl04XoUf+ADaaRxdB9nsQNA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ALa1Y9APV4vo+Uo0/upk2/484RNc5NgIW/9a+/MJXW6W4mPT170Xhoyji7r3UEVRj
	 WN9SURFJF8u46cy8KEwpK3AdK2GL1lDEjyYbe1dxHdGx77WN94W05YhBrTGuunm/Iq
	 qZfdgVBu2ijj4QAmz02dFHpFoFIOyv8/JfpATgMWh5LeQ3Ggw6rA/pBGj4/tNDg1i8
	 TXiU8qEuJvktzUjDP+jNQ/sm4nqVQpD/cc/jX6sIQz/U/j07028iEdc2VmJq3V+Ogc
	 BSL2opShvxjXWLfHbcoHL8FFpsoxuLJIYSdXK949kC9BGH4xNaSfZgu88II6H8/L0n
	 oLFvD4buikVEw==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Apr 2024 19:02:51 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-acpi@vger.kernel.org
Subject: [PATCH] device property: Fix a typo in the description of device_get_child_node_count()
Date: Sun, 28 Apr 2024 19:02:37 +0200
Message-ID: <369e7f6898c4a442d45aa15d7d969131d61e9cee.1714323747.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/cound/count/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 6a3a434d0d6f..837d77e3af2b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -891,7 +891,7 @@ EXPORT_SYMBOL_GPL(fwnode_device_is_available);
 
 /**
  * device_get_child_node_count - return the number of child nodes for device
- * @dev: Device to cound the child nodes for
+ * @dev: Device to count the child nodes for
  *
  * Return: the number of child nodes for a given device.
  */
-- 
2.44.0


