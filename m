Return-Path: <linux-kernel+bounces-144348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280648A44CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D862628124D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106A135A5F;
	Sun, 14 Apr 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZB1elG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A12E3E0;
	Sun, 14 Apr 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120891; cv=none; b=b58rj7/Lz2RtDUJb97PTztD1vm4AeT555m3HW0jKew27RN9CI32gG64BPTXoA/oIuJXk/7ldKHH5eiQnlJZf4CO8vJSiCnhDuqEfb1mvUhmygnA/qtkk/C8DrwK5eUFlWL2RSbL7EVpV7h5PnbZg/teLEpkp0DnSiC4KYZXzCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120891; c=relaxed/simple;
	bh=PJYzGTJWdJ4l39vPejCJ8w6VfNZCoY78ujqO75wJNYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B9obzvQwiUBbajpUpUAkOJHjxIZPKYtVo8oJ7acREJFoW3w5iKVqPzrfw2/Q2Q77Cd8hBRoMmrVsy7wog+oP54CWL/MrN9DNWmMIS5zEo2PnfPhHPzpY7Nl4Opgs143zQalzYkIzmrDs0heiG2OPwMfy303SxcKEXDbemzxsyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZB1elG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02EFC072AA;
	Sun, 14 Apr 2024 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120891;
	bh=PJYzGTJWdJ4l39vPejCJ8w6VfNZCoY78ujqO75wJNYU=;
	h=From:To:Cc:Subject:Date:From;
	b=TZB1elG4wxmqfAuHagIJREBBuzfQk5pWxN+iKXLUVUOAvNxmo2yEIAxuQMx1msk5C
	 Lqrxx0jlz4TR257DGzoYi2AlAqetFrjvCrNS9BfHZGFJItVO1aqCd4qshnczeto2Pr
	 Hjl7zm0TVvDIEEZAo/FFsvO2URkx56v/Y+rCtHvGSzi851gwc9ujEAvWIw4pwHLjxp
	 geZ+GXZSD7WufwEi+OwDOGS1gcnKXjWkV5lAOBhZMpnpSHsHV96eRaIGXIXm5dAHiN
	 fehXKBmqblkioO2YM8Xoeo3q7WX2CUwP5EJ2sq0/vZeivLAK531nEvUMXSmErUMdlw
	 aZfws6hOURzBA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] const_structs.checkpatch: add lcd_ops
Date: Sun, 14 Apr 2024 20:54:40 +0200
Message-Id: <20240414185440.288812-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'struct lcd_ops' is not modified by core code.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Patch making lcd_ops const in progress:
https://lore.kernel.org/r/20240414-video-backlight-lcd-ops-v1-0-9b37fcbf546a@kernel.org

Cc: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index fa96cfd16e99..52e5bfb61fd0 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -39,6 +39,7 @@ kgdb_arch
 kgdb_io
 kobj_type
 kset_uevent_ops
+lcd_ops
 lock_manager_operations
 machine_desc
 microcode_ops
-- 
2.34.1


