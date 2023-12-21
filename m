Return-Path: <linux-kernel+bounces-8099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FA81B22C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A485B1F2524E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23B14CDEE;
	Thu, 21 Dec 2023 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dL1BaqVQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C34C637;
	Thu, 21 Dec 2023 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dbb20471b0so432996a34.1;
        Thu, 21 Dec 2023 01:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703150067; x=1703754867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK1ZeDVamx7U18/C8YwIFX4kHm0CoIjY003ixghLHh4=;
        b=dL1BaqVQ+zgxxRcpXQ+0pynSwQm7CEtNt71itFV0+3GF1XAxgFoYJMPb2P6p1OKbuO
         4Fut9JZnMC/khPi/JssPXIJ4OvbIFfQr2U4KTbEYWgE3nmTyzyW4MMUwj2JmDD2oQ86R
         QEdrNFduspgCzzfZ+aJ0UUSNPLr4j3v+4TuegFOQuIRfbCaRWuQ/Nqs6O72aRSdbvntO
         xzEMbV2R/sn+IAEbrZlY7A9CDjoF3qjBXxKA0fpE/M8TCNV6qCbe5jLBU5mwKr5xVNR7
         T7wdpbMzrtszwfAk5In0oLwzCB5Byutlxj4UijfkYgYoAovTgtQ6MiENT1yuoncGyHfW
         MuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703150067; x=1703754867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nK1ZeDVamx7U18/C8YwIFX4kHm0CoIjY003ixghLHh4=;
        b=qD2sWMah7N/zDUDmYnqXx1HG/nQpUTTnIER69rVawQTUzkPk0iO3udNHmlF+x/TGIS
         +mP0sXBfom7aX5UgBU0J4aBspThS+HsaqhPoUSDn3aCko/wfwgpav7LCztY5El+RxtVH
         zFUzxGlLbaudv5VU7QpUJS8AcRYrdK8VOA3m06a+cUiGbvWNi1EFAuKQW+gnnmNnYnKl
         ly2eiqb08DNMl+nin/rxhOZA9a8b0dOBY1r2xVcOFk50dcrnod6qTUtMcVb9z43T+H9r
         sPSEdASMHNAjdvlBCiEVAF5bS34bwNW7xpToCo14qSI0RMARIgf9666Rv+bZP7Lt/9gJ
         7bbg==
X-Gm-Message-State: AOJu0YxPdU9+toYOvpjLsnAfoKeqZROLheC8I1WP7szwPAc0qpCccUoQ
	bDZ1W4L/l6+cwv2nqRWFC7E=
X-Google-Smtp-Source: AGHT+IE0RvoYfx/RGlaBffHusP1cAQybOsB7Oke4YsNyig7USkNqpHxYfgZo7IegqJTEVp+L7ODzVQ==
X-Received: by 2002:a05:6359:2d86:b0:16e:12c:16b8 with SMTP id rn6-20020a0563592d8600b0016e012c16b8mr821354rwb.7.1703150066661;
        Thu, 21 Dec 2023 01:14:26 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id r20-20020aa78454000000b006d91c425eb7sm1116015pfn.184.2023.12.21.01.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 01:14:26 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id EEF521024D73D; Thu, 21 Dec 2023 16:14:22 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <keescook@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Kunwu Chan <chentao@kylinos.cn>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Karsten Keil <isdn@linux-pingi.de>,
	Karsten Keil <keil@b1-systems.de>,
	YouHong Li <liyouhong@kylinos.cn>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net 1/2] MAINTAINERS: Remove Karsten Keil
Date: Thu, 21 Dec 2023 16:14:18 +0700
Message-ID: <20231221091419.11764-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221091419.11764-1-bagasdotme@gmail.com>
References: <20231221091419.11764-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

He's no longer active maintaining ISDN/mISDN subsystem: his last message
on kernel mailing lists was three years ago [1] and last commit activity
from him was 1e1589ad8b5cb5 ("mISDN: Support DR6 indication in mISDNipac
driver") in 2016 when he gave Acked-by: from his @b1-systems.de address.

Move him to CREDITS, as netdev people should already handle ISDN/mISDN
patches.

Link: https://lore.kernel.org/r/0ee243a9-9937-ad26-0684-44b18e772662@linux-pingi.de/ [1]
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Karsten Keil <keil@b1-systems.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 6 ++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 81845c39e3cf37..aeb30bb77f06be 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1936,6 +1936,10 @@ S: Botanicka' 68a
 S: 602 00 Brno
 S: Czech Republic
 
+N: Karsten Keil
+E: <isdn@linux-pingi.de>
+D: ISDN/mISDN subsystem maintainer
+
 N: Jakob Kemi
 E: jakob.kemi@telia.com
 D: V4L W9966 Webcam driver
diff --git a/MAINTAINERS b/MAINTAINERS
index d8360788467843..fab95e0258e799 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11238,10 +11238,9 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending.git mast
 F:	drivers/infiniband/ulp/isert
 
 ISDN/CMTP OVER BLUETOOTH
-M:	Karsten Keil <isdn@linux-pingi.de>
 L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
-S:	Odd Fixes
+S:	Orphan
 W:	http://www.isdn4linux.de
 F:	Documentation/isdn/
 F:	drivers/isdn/capi/
@@ -11250,10 +11249,9 @@ F:	include/uapi/linux/isdn/
 F:	net/bluetooth/cmtp/
 
 ISDN/mISDN SUBSYSTEM
-M:	Karsten Keil <isdn@linux-pingi.de>
 L:	isdn4linux@listserv.isdn4linux.de (subscribers-only)
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 W:	http://www.isdn4linux.de
 F:	drivers/isdn/Kconfig
 F:	drivers/isdn/Makefile
-- 
An old man doll... just what I always wanted! - Clara


