Return-Path: <linux-kernel+bounces-138005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B6989EB05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFFF91F22226
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325A22085;
	Wed, 10 Apr 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="LqEAIoVe"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A5120300;
	Wed, 10 Apr 2024 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731236; cv=none; b=bziBbrO1bvc3kLwl7ekHaRzf16PG3jZwKIysFlyrfD09HpcrUvNeayeYMajkHoD5vMeYcVjEBm7uht+2bzN5ARRZPo8okS9OymMgEzffzwL5UOla2PJUBwG1lXMnJ8czbcfucW6I8mp3eK06XB0Za1ipI929/I3feWIfQ9ijE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731236; c=relaxed/simple;
	bh=gWIpPMfOlhuTKajVxuLbatZ5OdKeeKVUQ4nZ6QVslug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CanQ6zVo+ep2FSegHD/IsEs8/kkukA6FkB899PYo3x98V2ZmeHD7xvGIbVLS1V2OYyBAEJnDlk7XsHfQD3Ir84nMW9imDxH02ZE3ydRXbiFKGhigAvqPrKla5i+DfTbZec4xGe67+SOgQ590qM0vEnGqj2VBx6UCaFzkfpvhxM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=LqEAIoVe; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id A844D6034B;
	Wed, 10 Apr 2024 06:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712731234;
	bh=gWIpPMfOlhuTKajVxuLbatZ5OdKeeKVUQ4nZ6QVslug=;
	h=From:To:Cc:Subject:Date:From;
	b=LqEAIoVeFmQBuYjTysYN3mAk97SLjRtSGy0xDgYwUa9oHeszsAFt3M2v9xqfAGKKL
	 XSyJDLkfSdVWkRg95zsKdMnwFLIL8a77ebPuNwfMurA29eBOxjBrxRVKn00CQP4ngv
	 4xeNC8ALFum/oxsOr+v9LxF97RGxi+PznQImW62fW6OjdUFDgrqTP2G+Vd+k+z8Jdw
	 N6ppvd1tXeREs2bi6f+BMNIyamsUZDtazfkJRyxy1waZmRiuFFJKvBp6gHKK/qmeHz
	 13k6nJyuwqIVMUToUW05dy4Y4qC+Nsjkjhlon9srKjZ6C7modsXvupUsBRxTHxxLka
	 VEkDiAw7sZijA==
From: Tony Lindgren <tony@atomide.com>
To: linux-omap@vger.kernel.org
Cc: Dhruva Gole <d-gole@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Update ti-sysc description and drop legacy quirk handling
Date: Wed, 10 Apr 2024 09:40:04 +0300
Message-ID: <20240410064010.57142-1-tony@atomide.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Here are v2 changes for the ti-sysc interconnect target driver.

Regards,

Tony

Changes since v1:

- Update copyright years and format as suggested by Dhruva, limit
  the copyright years to last changes done to the legacy arch code

- Add Reviewed-by from Dhruva

Tony Lindgren (5):
  bus: ti-sysc: Move check for no-reset-on-init
  bus: ti-sysc: Add a description and copyrights
  bus: ti-sysc: Drop legacy quirk handling for uarts
  bus: ti-sysc: Drop legacy quirk handling for smartreflex
  bus: ti-sysc: Drop legacy idle quirk handling

 drivers/bus/ti-sysc.c                 | 165 ++++++--------------------
 include/linux/platform_data/ti-sysc.h |   1 -
 2 files changed, 34 insertions(+), 132 deletions(-)

-- 
2.44.0

