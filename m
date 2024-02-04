Return-Path: <linux-kernel+bounces-51678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B41848E2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC85D283A22
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6E224E7;
	Sun,  4 Feb 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="Lh+azBGx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE62D224D5
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707054400; cv=none; b=AthwpjHmfleGwlmUI3IhwJTMWG/Hja5dMrp9G01JjUdsiAjVXzlsUlo1/0jNJ5p2Ta4Z7xmv/vgRKcEcr6egeNS2+vHvsoOl2aG3ir/4el4cimAE4YLl9k1vDZr1VSEcA9AwDXm1P34EJOI8etu8kSRvJeeF+32e1UqNEJdVaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707054400; c=relaxed/simple;
	bh=qKCo/jNBhfOfLZkSlabIjpgNUdA/N8SMgurTg12fd6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jd9INaldDxNKQ4+NEug0sySaTSp1J+pU/EVXnUoKV7D0giChzz8zkjHUMqp6bhPA+CoFlms6lXmPqdUTMXX1INMANtwxnTBLR15wQ5KrFlID3paLQ5dGNl80sjsvsM+x/55zJ7j8Xiy6KzsAreJ2w6i5DjCE/3YJ9bqcTfVpWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=Lh+azBGx reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29631796acdso1493480a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707054398; x=1707659198;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4528a23sx2pHGEBKObsW4f0VY+b9fY/qXjwoxuqJKQ=;
        b=MwwcZgqoq3s4mjndgDo3bHieCeC2FL31p1NeqUv7N+zsP10vHSxe+4GmmSvBCw/OeV
         asar1sCO04kG2v2k9wnf7d8Ys6zzFAzPnporWN0PtS8eHf9m5rNwcI6RpjGEh/EeaRS5
         twC+Bd1o8PhgS4qxyJAXVI7cvKJQUXYWvPsNuTLLguw0KTlXNiJ3IbTAte9iy0g5HSJn
         RKeY0JK+zMtq6w3UvtH9Nwja7EpCJWhOAqZuzSiHTyEd7UxUXi5v9SMmENok1qYiWsPL
         vh0b8vkUmogMLWbFyx6D5RP/i/hDt7YstiOmyvrqrp7lIwcJrgtdu1dOuZ4AlH/raYaJ
         EEzQ==
X-Gm-Message-State: AOJu0Ywp7Jlq+Z/4Qr8D/ckw2AD+EBNwB8TVW8f7GMLlObprmx5HMUcn
	CsPX35QqoKF0rcZSwCPd7ypSUHuUhNwsmcK8wcl4Do0dd5u+ssdz
X-Google-Smtp-Source: AGHT+IGtSHbU7hGtOH6rkyi6EKaSaI5H/E/4zYP05GFCS9UWzZHB/XeToRpdbSRuqNGp09wSsqMibQ==
X-Received: by 2002:a17:90b:3c8:b0:296:3a69:8152 with SMTP id go8-20020a17090b03c800b002963a698152mr6261485pjb.2.1707054398092;
        Sun, 04 Feb 2024 05:46:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4AfufQPQYE9JyKfKgQ1eLJr3mIm2YMenuXJk11MEz1ZEA5v2Tr7terO+0j6UZ6pRaWp36p3gIhvICiksBQjCaIxG2DjEC215u1oQUj1zUbpoGxRqLnzePjRGlQkxQcQ0xww==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id oe5-20020a17090b394500b0029685c1ab0asm1114312pjb.31.2024.02.04.05.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:46:37 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707054395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z4528a23sx2pHGEBKObsW4f0VY+b9fY/qXjwoxuqJKQ=;
	b=Lh+azBGxCFaVdW5aJMQOeJ/mjqGqkFgGPdj64s8j8CZIBSNepJe91DBIYWnDQ1f1yknnon
	qzFfb/aJ3PNxG6ra52UXBoZCTpzgBDI1UFAI15TDsq6UZZ2ERvzAWzxpLvNQYy7bnO2dNx
	satQFo2gryr/ulJuwPFWh4w7WEW1nwJbarfI8+i/bqGnnlZ92NnwmsXKSSgDleotcDRnrp
	FRzMZ5z289m9MXGZwAoWCzesZlCNgto6aKyrBOnfEFL+kkscamfaYj2q+9HUudMhzNdIfE
	RlvvFXVOU/rFzZJd/ON+Y5Cm/Cx6FjCGcjzRfy7yHhDPjFIq9faqH0K0Cmgt/g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 10:47:05 -0300
Subject: [PATCH] workqueue: make wq_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-workqueue-v1-1-311748f9101a@marliere.net>
X-B4-Tracking: v=1; b=H4sIAFiVv2UC/x3M0QpAMBSA4VfRubaadRReRZLNwYmGraGWd7dcf
 hf/H8GTY/LQZBEcXex5twlFnoFZBjuT4DEZlFQolUShg+/NRoMNh7h3t56BAgldloi1Ql3pGlJ
 7OJr4+b9t974fQamm4mcAAAA=
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1059; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=qKCo/jNBhfOfLZkSlabIjpgNUdA/N8SMgurTg12fd6Q=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5VZTbfiuIZArQRVP10vibbJG6+HdbQtU87PR
 ib5B0bocRKJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+VWQAKCRDJC4p8Y4ZY
 poaPEACzhO8kAG47WTmOmLQyhhmIib1KF6zFVof5YPqHiW0e2FcRHWaIBpoLcNAyeBQVQCXsFhu
 /Zw147W9wFTjaqAqMvsei4mVgNYavzYgGY/c21khCKP7t50pHNT/KzVpNBM5y4y7hFfurq/3n9v
 yVSO4azgMr06cZkRX/FaWY2LIGKJHjMlihn6rVY3edcmotkwCZtkvviiuFyFT5EHcYS6ywZDyaE
 50fN0+1as0pDlvNO9lcQLDJSy0EUoq78xwKM/tMyKzXDusgFns9OChsrYbnzpa6kPM4nGVlAkt6
 nioytc9vhJTWEWxm1YEzSNeh+XAWSZ2d5fA9ixi/kb/N099bNH223ooGYrQTLBqY6VbWvx3+1lf
 huBgL1thdOE5U/IbLih/kvX9efCw+FszO4J+PO+cNlDzXoUMzf+65HXst2T0tS5PqOwEEAncqye
 NcdFIEZSmk/DXxwokw2nUAkmqjc6gcwC1I8lgo6w6vKZ5GpReCtYSbFQCnqwrbSMhc1+mFDQJNi
 srn6B0wI6YVIdQrhHbDMooswx53mim2L6chGRUFNcKojbgsMgo0LrF1pEI/NnM5uSGVA+Nqaf99
 O3upFsQR5HEKuuqxanJtjBfSBL4cBct5Y1hUytDZiZPnwqDA13YCZ9V/99MjAEm8B3HH61KjNlt
 xLcWM4HDruNmYTw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the wq_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ffb625db9771..09caa1a34630 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6686,7 +6686,7 @@ static struct device_attribute wq_sysfs_unbound_attrs[] = {
 	__ATTR_NULL,
 };
 
-static struct bus_type wq_subsys = {
+static const struct bus_type wq_subsys = {
 	.name				= "workqueue",
 	.dev_groups			= wq_sysfs_groups,
 };

---
base-commit: d49e20ca05ef22580bd4ae3219a31e4630f8df97
change-id: 20240204-bus_cleanup-workqueue-b5544924b8b9

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


