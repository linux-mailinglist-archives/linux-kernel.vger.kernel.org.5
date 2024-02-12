Return-Path: <linux-kernel+bounces-61530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8449A851350
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13DC0B27872
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDA43B196;
	Mon, 12 Feb 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r+reU0DV"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD13A8EB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740021; cv=none; b=g8X9MbKAr2hDVFTR1Ecso0izmglcsFairNOIVBMhruWGblFksSXIMiEg+GaPJ0W23dlWKloe2G2Viu4TPFlu/9QZLH2BDr39AtI21CWxGXH5O7AlQXG+i+O5vYV8qxdqK2hw/Y0vFXCPA9i2P2hgGmA0brXXVKpcS41mtSlncas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740021; c=relaxed/simple;
	bh=xKohLmgszB47qEXbhAej0mnn6ushwhKQLMYAMblD060=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VojJOe8c/o5tIN9fLdhQ9L0ofaajVN1y4vGXl2S+SzKcV43AkuC/8MqWdM7qPqArpft0HPgn1e6+mHClLTnqh8S/Vtre2i22vKiJpjjrRQbK7espEFsqS8IyAKeEn34Hycb6XxAQHjTFbx40uWLEOrHOzLXbotcIYDUZR0GcAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=r+reU0DV; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707740010; bh=xTQJRPDMPKxwfMQecLLy0zy3Z6oeJK5jbhqCH22xWW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=r+reU0DVh10JDI2PRzL0hO2b54uB0eMa5du08NBmr+5yK96l2mbEH8zsMxFz/G3hi
	 WOm3146KjxugmJ7ZxM53r9Qtd3QvVHJMhi/DdQn8/UNi7JBGUuahGdDjPEjGm0Tk4B
	 5z9tmPrv89v1LeJzryjHs6pSqFHXQ19rV6obS7qQ=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 1D42E6B0; Mon, 12 Feb 2024 20:07:20 +0800
X-QQ-mid: xmsmtpt1707739640t7f1xmzly
Message-ID: <tencent_9E786E6C4C2DF96F4097BCEA5AED66CEBC0A@qq.com>
X-QQ-XMAILINFO: N5sfBKY/oC4k2pZio3FMLYvCCX1tGL5fDqcEh+KzrsHvTELLJEQRN05gdsY9Uy
	 kqxqJkdOkKGeWbLLopMaf2/Ak6JDGcMRQ1bvbS1fqJKOZqsSCJsXVGxIH7L4XOYS64mpfSjqUw9Q
	 DZ7mk/OnWi/qR+C/poOxLrn9l1iAXYijPbByxFP2cdPBrpistSzxFf2QTZwqvJ9Urhjty8qz7x0w
	 ViWogcZdzY3Go30mu2Hn85VqF5JLbHhVDItEZEbR117GUUWz4nLuYTAueuvVfsRjDrXj4EGgC7mG
	 9gVsC29TB93CufcLAAnMajowE9RE+2cgyugbFesStEZ6dxWC2r4Um7ZfBgBz8pifbJ7UE08FutYt
	 85pApXai4DUywAWUN15Th/UyYPLpYAy/Ag5Gu7ezauZKotSTAY60s+zU87hv1DmBUfRTiZmAux79
	 CDfPIx7tMHJGBkZ4htxt9hBCRqSQm8XcCa/B/IeO8PcI3uN3WsCmJSQQ4ybenRaTAubb1YiptJJ0
	 sWOrX+Blw1tKSHo73+oy4Ue7rfw/esygIA9LRhah1mzTnfWpkSi7Jc0nZFfs7QbvQSoyul3Lswkm
	 MxpA+PLg049cJ3MIxXZpO2s1H4+b+PgeB7rnReAd0DUnXwjoq+GpxDUCpj2MI+Rpoa0ap7mNgu24
	 AxGvv5iAocChYBmMSm32fFWTIkhVGJAAHyyQErJLsrZfkj99pIHIzun7WrozV8ZMCAGDMqyX4HFq
	 h2wE1WVprEDahR3bvXGhqdCfsXSgUXn/vRTtfn+wjNM4Ne5jUfOE1y9t2ltxbc1qwiZ3WV03Ir71
	 7X6Ai1DiJG1K0vDuqwn1ABGlUZyovgJHOpOsaX2c2wQRleouc2KW7DhBDUyO8hsW8ReQCGvedi0g
	 FuuQd9K425XaIceePkHZK179+YTyNdTyKSJu4PrDsUI/iCp+caL9U=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0d7a3627fb6a42cf0863@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Test divide err in drm
Date: Mon, 12 Feb 2024 20:07:20 +0800
X-OQ-MSGID: <20240212120720.120067-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000587e0f06112cd973@google.com>
References: <000000000000587e0f06112cd973@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test divide err in drm

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index ac9a406250c5..60739d861da2 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -36,6 +36,7 @@
 #include <linux/list.h>
 #include <linux/list_sort.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 
 #include <video/of_display_timing.h>
 #include <video/of_videomode.h>
@@ -1297,8 +1298,10 @@ int drm_mode_vrefresh(const struct drm_display_mode *mode)
 		num *= 2;
 	if (mode->flags & DRM_MODE_FLAG_DBLSCAN)
 		den *= 2;
-	if (mode->vscan > 1)
-		den *= mode->vscan;
+	if (mode->vscan > 1) {
+		if (unlikely(check_mul_overflow(den, mode->vscan, &den)))
+			return 0;
+	}
 
 	return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(num, 1000), den);
 }


