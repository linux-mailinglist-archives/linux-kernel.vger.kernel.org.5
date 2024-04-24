Return-Path: <linux-kernel+bounces-156383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E9B8B0235
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409CB283AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF981598F6;
	Wed, 24 Apr 2024 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXIwA+L5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F7157E62;
	Wed, 24 Apr 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940588; cv=none; b=LxH/B+1J3h9xFYjQjUCQ1amLMBGfCiU+Lrucl3IQALa5WuvMtoAQxlov283YdUnfZeOQG4zw4iZvbGOnmyjSgNJtCtxNI5GxMFLTPGg94eATNY5J2/+5I8DEXAL3EW9tutNlgH/k28v3mMtrnh7uKuNNftQBcnxomMQSdplOFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940588; c=relaxed/simple;
	bh=q+qnEpK+l59jPIQe5UqWWsiYjfA7aXbDpteN/UQE4iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCTotrZkHKCfDUG5w+n3J4e+eXW8LCipj4oBDH2vAOfs20f85XXj5IOlSdI0lZRpetw26cF4rxgIenxziJOQymauiGHxqYHnje5ZNCaguxsHVgf4HsSnMZF/DWyYzb3xk1sNpChzjjKLcs4OgxKv+bVxUMV0/FbrLMMLesSDgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXIwA+L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366E3C113CE;
	Wed, 24 Apr 2024 06:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713940587;
	bh=q+qnEpK+l59jPIQe5UqWWsiYjfA7aXbDpteN/UQE4iA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YXIwA+L5lnMLivG8Ty4VlkldYLZBJZPHVVZMR7CTjhW+GrLhvcLYVr97KR3EvltKy
	 mxtpqmvPaHIZXvzV8eT0jlixtWZ3xh2QXaTMPa6IGG4p1VHEaxnlHdkZ+MOSUVEESj
	 jmUAq+E9AcnjSHKsrj78MpyR7YYPeN4oPNUzJBG1rJRihgFkOJu4XbplXbCpzhDIUy
	 fcBi/Cl8klNVmB4h4wO0XDMTkG4I7Ivgslvta3HSqjYYs/az22Y4ZG6p/b/qHEGtih
	 9WsxJToWE/vq25/SJ1SqPJ9cWerEhS3jYmspvsRwsUqIFGq5P7adOML7RcGx4zgFSl
	 KP5ImGssJdGIg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 24 Apr 2024 08:33:45 +0200
Subject: [PATCH v2 19/19] const_structs.checkpatch: add lcd_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240424-video-backlight-lcd-ops-v2-19-1aaa82b07bc6@kernel.org>
References: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
In-Reply-To: <20240424-video-backlight-lcd-ops-v2-0-1aaa82b07bc6@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=924; i=krzk@kernel.org;
 h=from:subject:message-id; bh=q+qnEpK+l59jPIQe5UqWWsiYjfA7aXbDpteN/UQE4iA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmKKfuTlvNIAwrbpIVvZdLwVKRUFDW99McbcRZO
 QcDFmCzNHWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZiin7gAKCRDBN2bmhouD
 1yEQD/wNRPPVi0sZ02CXQxc7WhjX2fS8W+11eReyDlq0TrPblfN1uN5EMVeLOipf070lASAUEgU
 Gtb/gaAZ5okrFRW0X2hOeeIODr5KW1USIedvITCosTww6e0o9/cTpygkeVTOALUJOnVMgpLJY55
 XRMvMJ4qGnfcWgPBAbjF93sxBkG6/HFDtOpxQDDQY7SHg59WVwHZi5oBviEKsJAYPrV9HcUMQ+f
 3NoMhI72z6PrcVfGF5cqmzjrohnUZ62BHJHta13v+PzzYI7MSKNL7cJ7yZ/IpxZoD98gBNLGad9
 981Jw4EwZJDQ+SZkds/AN2cOvHrrCiR7H1ufn9aL7sMA+SMYsVdyZWNvxiYu4+x0SxlKB7nU3jt
 2iLwQLhDJRdPEarPDky8Zb4NwSmci44wy+6CkYp5wt7CN+jJLGTMchJNos8QG22urVDwI/ioxVf
 gwkTBb55aKgzI7G/igaFKh/KyHdHZfxdKwtWKi9qNCi8rIWmr8obybUjejGetKkDveClRmLwX1G
 +upKHPFu6Tu5tH87v78kZ52gfA6f9kojKKKevH0+Lrsr+H41Al/5f7RJm3/5eoLmoLnWdSKxiYN
 4zuMqxjysxD7OdAaSsdgxFdiZhtldi3P0icA+Ykb2lvqkxFh/X4AIunJukrYCK5w1CEf/fOHFTq
 UcMo7yh1XzNrCMQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

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
2.43.0


