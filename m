Return-Path: <linux-kernel+bounces-87957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6827986DB7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EA01C2246D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E367E71;
	Fri,  1 Mar 2024 06:32:16 +0000 (UTC)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2B67C47;
	Fri,  1 Mar 2024 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274736; cv=none; b=LM5FqUhGGl4rKkm14lVWQn4A9CuSfpkpUpAw8527lNkBGky9Xh3ixQz+mGqBiAMYIi/xGzOdFCAhPGRzb2KJ93ShbaP0xdUbnaaGeisJoNJorR47WGGLoe5ZSlCkeMmI/rLJajX4U1ihZsMdFv9hluC2LCm5Hb466T+MgtE0ZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274736; c=relaxed/simple;
	bh=O1qKA1IW83ZBKKr7GX7jI3gS+bXyxbOnSvwFGHrcLbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPr6MOcG7m9VAVCXssfQyizjko8pS0md3gSpoZ5G2gRhVgvWCDdz0u09zCSsXx+8QPo7JKB78rm8xomt9aCsO+b1p+dYInBRbwCSqD3hVDxh7qRkeJ5XoHSJK57Tnr1J93ys/qDsHvlh4jNX6WBUrSxwCdx5VaUgxzW6NDAy20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 01 Mar 2024 15:32:06 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 0B39020584CE;
	Fri,  1 Mar 2024 15:32:06 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Fri, 1 Mar 2024 15:32:06 +0900
Received: from ubuntu-FMVS04001.e01.socionext.com (unknown [10.213.110.223])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id D4D05B62A2;
	Fri,  1 Mar 2024 15:32:05 +0900 (JST)
From: Masahisa Kojima <kojima.masahisa@socionext.com>
To: jaswinder.singh@linaro.org,
	ilias.apalodimas@linaro.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH] MAINTAINERS: net: netsec: add myself as co-maintainer
Date: Fri,  1 Mar 2024 15:32:14 +0900
Message-Id: <20240301063214.2310855-1-kojima.masahisa@socionext.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as co-maintainer for Socionext netsec driver.
This commit also removes Jassi from maintainer since he
no longer has a Developerbox.

Cc: Jassi Brar <jaswinder.singh@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..494e08683b64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20214,8 +20214,8 @@ F:	Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
 F:	drivers/net/ethernet/socionext/sni_ave.c
 
 SOCIONEXT (SNI) NETSEC NETWORK DRIVER
-M:	Jassi Brar <jaswinder.singh@linaro.org>
 M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
+M:	Masahisa Kojima <kojima.masahisa@socionext.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/socionext,synquacer-netsec.yaml
-- 
2.34.1


