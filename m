Return-Path: <linux-kernel+bounces-14377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AB821C44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B2FAB21F74
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA8EF9DA;
	Tue,  2 Jan 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="figEQ5Yr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC0F9CC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40d2e56f3a6so53426445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704201025; x=1704805825; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uowTUjLxrj5pVd1k89+sk1irYGIPwxkoZlQeDZRpdQg=;
        b=figEQ5Yr6raSC6f2I8z1J4R0+eNsuyrmweROQ79Hy0Rmy8aTENSYYXEWccGN4IeVZt
         Qrn/atllJPNTa0dJefjhccCWIcf+Qfg33MLULvjhGZm2DWjrSTWMVY/Z9vP7WUU5f/Nf
         lo4ArhPaD8kHp+y+w6e7gkEZ3WrC74h2cCAaVZgpOZhCx0D1F/iq+HtA2NjnpTbm/4RH
         7FEhfAa2Px0Li3vD97TFuH4Ugaw+Rl8xDoSr7eG02YnGJOUk20nFoL9WKfpXXIyaFXi8
         BgP/ROJNpn5hnzMxVq5hox1VG/dQEzV8Yo8FjbKrJj3s/Ndo/AIpVIwqegDhQxCcP+CA
         Cxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201025; x=1704805825;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uowTUjLxrj5pVd1k89+sk1irYGIPwxkoZlQeDZRpdQg=;
        b=RvmHq6wIIRHHgK0YgJzLdUAGZmWMSpVw2NZNFEZGcfYGIfN7dmwDU2R8l2e9LT18Kw
         emtdzI5PqlJyLba+r8U6or1T7L1W575/m0dETov2rEGpcMYIUtBmRiSoaTaamwxGsj5I
         QREQmaDh/tNBHYN1dpifPfESvvuj08pdXIkruvdclQUrDyyE/0vRICOooQ7yRO18ItFy
         jy3c4i4Y+VdDpQEFz5c7KPpTFaYg4v6gY6Fmho4RNcGk9pQotMxXorGivwmBao6QjpFI
         NQt901YAsqmbxXuf9Qg0/5NgYGmEjOt9odvJxcK2IbAMEas51252et5zqKoaVTgpwA9a
         yKUw==
X-Gm-Message-State: AOJu0YypQqj00z9VfhwEcFFefc4nlsi4s6L2y+x7D4s9HTLh5RIAG6+A
	5Fxd1FJkeDdNNfT9U5bYIzNaZTM1UDWekg==
X-Google-Smtp-Source: AGHT+IEoN+ebHJooT4EFia3vvux4q4QYo8ANuuld+tcBrJj7L3tqLsmg4Zf3Hx240ew4nQq4WWIkzQ==
X-Received: by 2002:a05:600c:998:b0:40c:6c8e:8b7c with SMTP id w24-20020a05600c099800b0040c6c8e8b7cmr8100998wmp.55.1704201025149;
        Tue, 02 Jan 2024 05:10:25 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id ay23-20020a05600c1e1700b0040d8d11bf63sm1884557wmb.41.2024.01.02.05.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:10:24 -0800 (PST)
Date: Tue, 2 Jan 2024 16:10:21 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 1/2] cdx: call of_node_put() on error path
Message-ID: <2e66efc4-a13a-4774-8c9d-763455fe4834@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Add a missing call to of_node_put(np) on error.

There was a second error path where "np" was NULL, but that situation is
impossible.  The for_each_compatible_node() loop iterator is always
non-NULL.  Just deleted that error path.

Fixes: 54b406e10f03 ("cdx: Remove cdx controller list from cdx bus system")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Christophe JAILLET pointed out this bug so I added this patch
    to the patchset.

 drivers/cdx/cdx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index d84d153078d7..40035dd2e299 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -572,12 +572,11 @@ static ssize_t rescan_store(const struct bus_type *bus,
 
 	/* Rescan all the devices */
 	for_each_compatible_node(np, NULL, compat_node_name) {
-		if (!np)
-			return -EINVAL;
-
 		pd = of_find_device_by_node(np);
-		if (!pd)
+		if (!pd) {
+			of_node_put(np);
 			return -EINVAL;
+		}
 
 		cdx = platform_get_drvdata(pd);
 		if (cdx && cdx->controller_registered && cdx->ops->scan)
-- 
2.42.0


