Return-Path: <linux-kernel+bounces-126618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E774F893A67
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BC1B21086
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393C20309;
	Mon,  1 Apr 2024 10:50:48 +0000 (UTC)
Received: from blizzard.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6137144;
	Mon,  1 Apr 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711968648; cv=none; b=RkDP/n6RE9+nY8Suj4UByHvQ0d4azm6VD5zLkaSVWguSH2jFI/EQWZKFg7dniZYi0ldydxYAm7LnYPtfMZVugQQhJeLrTqqyrYWY8lai3MTkUMY6FCP/HgBTLCDhgJguZFMMjQu6tVowqh1OPKCAiPK0zn5BZCb/uu8oNbuqrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711968648; c=relaxed/simple;
	bh=A3YJ20u5Z9Tj4aFGrDSHD0JkGW4BIAHoUUkzF4gW2c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lshT9NV40/cUSYM/Vhmf41C5Tjq8KZwiMJvLKA+gRzs8iDeGL/7YZ2ZGPbR+ytK7teRkAe1viMSBI/Zfa5urUGHCLwTOSvSeFAg3hcXrI7hlY1MDi93/seoGvQfOX6glTD9N4tjsefAMp9XpmXcT7PY3Ccvh5ZR3NKoq4Z7K6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjellic.com
Received: from blizzard.enjellic.com (localhost [127.0.0.1])
	by blizzard.enjellic.com (8.15.2/8.15.2) with ESMTP id 431AoI3U027653;
	Mon, 1 Apr 2024 05:50:18 -0500
Received: (from greg@localhost)
	by blizzard.enjellic.com (8.15.2/8.15.2/Submit) id 431AoIUV027651;
	Mon, 1 Apr 2024 05:50:18 -0500
X-Authentication-Warning: blizzard.enjellic.com: greg set sender to greg@enjellic.com using -f
From: Greg Wettstein <greg@enjellic.com>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jmorris@namei.org
Subject: [PATCH v3 01/12] Update MAINTAINERS file.
Date: Mon,  1 Apr 2024 05:50:04 -0500
Message-Id: <20240401105015.27614-2-greg@enjellic.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240401105015.27614-1-greg@enjellic.com>
References: <20240401105015.27614-1-greg@enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. Greg" <greg@enjellic.com>

Add an entry to the MAINTAINERS file to document the maintainer's
address and files relevant to the Trusted Security Event Modeling
system (TSEM).
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa3b947fb080..03b1cd71701e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22469,6 +22469,14 @@ F:	Documentation/ABI/testing/configfs-tsm
 F:	drivers/virt/coco/tsm.c
 F:	include/linux/tsm.h
 
+TSEM SECURITY MODULE
+M:	Greg Wettstein <greg@enjellic.com>
+S:	Maintained
+L:	linux-security-module@vger.kernel.org
+F:	Documentation/admin-guide/LSM/tsem.rst
+F:	Documentation/ABI/testing/tsem
+F:	security/tsem/
+
 TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
-- 
2.39.1


