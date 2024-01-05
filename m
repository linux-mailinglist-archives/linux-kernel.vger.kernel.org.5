Return-Path: <linux-kernel+bounces-17989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E582567D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACB4283AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355292E832;
	Fri,  5 Jan 2024 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="OTdPdfL4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F12E825
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BF6F3F2C4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704468112;
	bh=va+R088LK5HPp976U93J7EMukikDVxpd8L8bbCz8s64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=OTdPdfL4vD88WxjnXOS8DD5iLwX3e7wWdtD9P7YoHSs1fdFhDNnavWmqVxPpN1WFY
	 1e/HX1qtjoL5zaazt2OVcRyNuv4zf326Jxt9x6h5h4laoPbsBsQsOjo6+tItU9efXr
	 EZ30cCCUq2/QRcfzxnxQeuQCeBchjnGRv4e21dXc+e12Chv74bpRS6gJwUOkCptgkk
	 doMjxd8YPN8X6ZPiAVKNqouxH7qOBvY/nS2hYODZJv5Kuny7x97FN0P58jNCkeO/7n
	 Vgt1+r7cR3wPD1cpNSxNgp+JAkYMew5tPVUXJ8X42piKf2cq9CAmKZyyFqvK3zzHdk
	 mteQyU0dq+yvg==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50e7b5c3582so1407195e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468111; x=1705072911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=va+R088LK5HPp976U93J7EMukikDVxpd8L8bbCz8s64=;
        b=cRfvuUZul0qefSokn2an+sdJVPz3qlZ6Ni/sktbzoPNvFB1U0hy/6WFrRmvWxVwtKN
         zm8OAmdUu2ZOWdY6rcnYkPgHgRPD9G1hxyEmjD8CX6M/GhjP5CMETkmWJK5AhnIPcad7
         2iPqZTWHjWkIT3bp+wuAB1ulqs0qyvCNrMhFDha7txXFF8GuP2Kn7NPzO2mpN86nEx8q
         vxsudgx6ppgwpmcKb/rtEfTef11zIe3rhLYBy9eekc5rCJEjUx/tnIxtNwrhPWJLP17n
         bMDWJOsmqPx5nQTOS0yRgja8firke7yC/xSYO3prwiYCEDf6xglpEmTcJj98OrAJd7hW
         c47Q==
X-Gm-Message-State: AOJu0Yw/TDXMT8+NSQMjUsGhKA/PWMeGfLU9RiOaDOUGgU7nFn/vy9Jy
	apLzPyasRZdWDrC56qjTn0caHHo7yWak42tEgfQwKKpGqLiaycz9WXrJd4Ug5aLwc08Tgj0T2fH
	/CoSbQDJfbCrhuLvrragqMR4SZDIeyj03YPg2sdHiTMnQWgEPhZ18CQ7n
X-Received: by 2002:a05:6512:6c7:b0:50e:4375:712 with SMTP id u7-20020a05651206c700b0050e43750712mr1334021lff.16.1704468111588;
        Fri, 05 Jan 2024 07:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2/T4cw9Nt8HWcefUxCTnHCLrQ/5/WQYn6R+9zUBE3oW/gttm32aQ4NbV3GZMIq02etobbVg==
X-Received: by 2002:a05:6512:6c7:b0:50e:4375:712 with SMTP id u7-20020a05651206c700b0050e43750712mr1334017lff.16.1704468111287;
        Fri, 05 Jan 2024 07:21:51 -0800 (PST)
Received: from amikhalitsyn.lan ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906115700b00a298adde5a1sm345630eja.189.2024.01.05.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:21:50 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] fuse: fix typo for fuse_permission comment
Date: Fri,  5 Jan 2024 16:21:27 +0100
Message-Id: <20240105152129.196824-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found by chance while working on support for idmapped mounts in fuse.

Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d19cbf34c634..6f5f9ff95380 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1485,7 +1485,7 @@ static int fuse_perm_getattr(struct inode *inode, int mask)
  *
  * 1) Local access checking ('default_permissions' mount option) based
  * on file mode.  This is the plain old disk filesystem permission
- * modell.
+ * model.
  *
  * 2) "Remote" access checking, where server is responsible for
  * checking permission in each inode operation.  An exception to this
-- 
2.34.1


