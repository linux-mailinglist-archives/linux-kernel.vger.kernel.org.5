Return-Path: <linux-kernel+bounces-29180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0105E830A2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13DD1C219CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67222306;
	Wed, 17 Jan 2024 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="Z/MDljio"
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3321A15;
	Wed, 17 Jan 2024 15:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.128.248.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507081; cv=none; b=dts0hmdtdMeQIaK9yLR3kaX1lNqoNm6Jf8fY0jiysYSs46ZfoWGOoL/RYazZhQhRajeEudvw5qzGsDQRwzz5C3bpP1E+4+Lhcq/4KvF7qwpMGikNcGyOQe3Bi9d5P2gGhEVPWkrCgKT5zHt5ZUBNZMIoExJ+/bFmDRrfwaTiT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507081; c=relaxed/simple;
	bh=5eIV2ECbqThsSC3N7XQpfP+YzIOdiuURgqyHz3CBRLk=;
	h=DKIM-Signature:Received:Resent-Date:Resent-Message-ID:Resent-From:
	 Resent-To:Resent-Cc:Message-ID:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:To:Cc; b=eAYkla1Pjc7CuUM1I8lP7lMoI8K6mAOLUt3ios1/w3kwCGWHcvM5eO5nsGJs8iFlB4fawIW5MzQeVrGjY7WB4ljcLCj1ka9Dh21jLUPtJRCFD3rQqWW3QVXdn83DM2OEkyA+7CZyQsMqvYT6lDVHQiBT3XsJ8aj+LG8XQWMaGto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz; spf=pass smtp.mailfrom=cesnet.cz; dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b=Z/MDljio; arc=none smtp.client-ip=78.128.248.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cesnet.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1705506735;
	bh=UVRbAJjGBCaUJ9jH+NLdOpNygaBZ83+KFG+cEO56Tk8=;
	h=Resent-Date:Resent-From:Resent-To:Resent-Cc:From:Date:Subject:To:
	 Cc;
	b=Z/MDljioECiWXNTycDSwwYxnldNQGLyOPJzRLskim2kiKPn8DYB8tPP4FuBxvaIHB
	 G3HMjCvSmhifwh5xCvC7GIsy4rj46t8ytCRwcUXpUFcwJSMGIPXXMbMKGUPPBErPBG
	 XGtRYoqoz0YuCIM/USkmwbE8/9l9gDEGSESa6AWLxVHSFN72dE1VulrDKlrbLuTdjK
	 +g+Mf/b/vEc8CpoRQqndVPfI9UuVbi64miMF+wvLIP+gna+QKcOxWweAc99wlEq0Ao
	 34lr7ApgHvm+1BB4JI1jiDM8x/ez6ctjnjCqnGV+NNBVoPXiEpLdEfWugynj0hxtcn
	 ZbBnPip+/+KGg==
Received: from localhost (unknown [IPv6:2a07:b241:1002:700:41fe:11a9:b352:1c39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id 628111180072;
	Wed, 17 Jan 2024 16:52:12 +0100 (CET)
Resent-Date: Wed, 17 Jan 2024 16:52:10 +0100
Resent-Message-ID: <262d0a5c-1813-4e64-899c-549aa5cf80a0@cesnet.cz>
Resent-From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
Resent-To: <linux-perf-users@vger.kernel.org>
Resent-Cc: "Yann E. MORIN" <yann.morin.1998@free.fr>,
 <linux-kernel@vger.kernel.org>
Message-ID: <e0fc158239e73f22405c78d5b3219c266e3763be.1705506665.git.jan.kundrat@cesnet.cz>
From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Date: Wed, 17 Jan 2024 16:50:47 +0100
Subject: [PATCH] perf build: don't hardcode pkg-config path
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: linux-perf-users@vger.kernel.org
Cc: Yann E. MORIN <yann.morin.1998@free.fr>,
    linux-kernel@vger.kernel.org

On Buildroot and when building for Arm using the Bootlin toolchain, the
actual `pkg-config` is named just `pkg-config`, not
`arm-linux-pkg-config`. This patch allows the external build system
(such as Buildroot) to pass a working path.

This is already done correctly in tools/build/feature/Makefile and
tools/thermal/tmon/Makefile and also fixed in other places many years
ago (9961aa665b70e47d6c80141c4a2482266010f246), but for some reason it
was never fixed in this file.

Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
To: linux-perf-users@vger.kernel.org
Cc: Yann E. MORIN <yann.morin.1998@free.fr>
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 86569f230e60..b69ab2ae77c6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -188,7 +188,7 @@ HOSTLD  ?= ld
 HOSTAR  ?= ar
 CLANG   ?= clang
 
-PKG_CONFIG = $(CROSS_COMPILE)pkg-config
+PKG_CONFIG ?= $(CROSS_COMPILE)pkg-config
 
 RM      = rm -f
 LN      = ln -f
-- 
2.43.0



