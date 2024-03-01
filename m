Return-Path: <linux-kernel+bounces-89138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214C586EB0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FF21C22AE8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA515733D;
	Fri,  1 Mar 2024 21:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="OyDX2ofH"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFB56B98;
	Fri,  1 Mar 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327980; cv=none; b=am4xO1lBSbxIqKKnlAFQ/zzlKYAj4gMkcHzZ/e7C/8b7Sl7MAxOs6xk6SuUT4YRl/rJhRi9GU9JlRgE8U77p4nw25SUR82t62Dghdy6hD86jLslkwwUVFrLCU4WrsVSOOEWfIHeAn5QP/ZG85AWfHl9B+oPlXuZ3ZGGRkCPzSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327980; c=relaxed/simple;
	bh=aQgtIrqPEJ6JLO3fBjYxQofvBaZjEx8JOTDSClljCmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n5SymiAQ7Of9Ktv/E4HMIjHm2RiwhHPJjaQWbs1Lz5FXLv+AIL00Ix6OYCGmCuLfPiJRRaZV76P0E0yDfZ/rFK8/PcbBhSLUHKH4+g+0fPBdnu1VJiz3dB0+ewYvBTjUn8ZY2brFo8ESoXARFTIIubHUxn6rVeAD59NjW0Rb5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=OyDX2ofH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29a378040daso1821033a91.1;
        Fri, 01 Mar 2024 13:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709327978; x=1709932778;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcu8ifKGnRyTxlpkQj5cfTQBEVQ8gXCBuRO6bQX8bcE=;
        b=DnTSInPG3Zntgo/HQN14oGgGtpwfehtiKinR08jny4hHTSVadqt08eYfFH0rgVl1BH
         oC5YuYu+VkZ+BiwYzGzu1wHZgkZtc9k6fVFOuv+4zcYv1PpxRO+r8hXr3hllW9AhdBuA
         GA/BmopV4+yf0y7WsWOQ1v9rSUotgznDPYpIjrf3nJJsge0+WdszRIiuOFG3GfBRjRDM
         1J2Y61/ZfIxMU+Aoaqpb4Sbj1IXRA3FJmboZl2Ii1cRPnGVGcuVbYowlfaR1gUoDQvoK
         b0ubyLyyhgyObJD8hP97dTUJ8JSE8ZWcRwmBvJM5QLqch9fxsD6G8DSrMtBZO/FC6WkQ
         VZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVHX3Zz8SSpqgC/VAbWXosom5KQhZBllnzJgI3toUXJvDtAHGxg9e1IdJNi0IjP/pEXrgyZRJiPlpNPq4P47SZ3nULMOiW0IcQKg3MO
X-Gm-Message-State: AOJu0YxEsyaV3EynYLNwloST2U0uVhrvbk1+8MKC8qwKIVucN8jwjilj
	B+b83Eao/HXgCnz8w3FuJVhmLNapEN+kG9iwuB8lj1s5gvEN3vr3dJ4UY5zcUqvubg==
X-Google-Smtp-Source: AGHT+IHpWqlK6xa7dddlCxL+RPam4ay8EwZ/lTWj7tWxut5hL9zzdL0+M36msIBoy9H+sHL1cx9lew==
X-Received: by 2002:a17:90a:9ef:b0:29a:eb0f:e356 with SMTP id 102-20020a17090a09ef00b0029aeb0fe356mr2687800pjo.37.1709327978133;
        Fri, 01 Mar 2024 13:19:38 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id cz13-20020a17090ad44d00b0029ad44cc063sm5772861pjb.35.2024.03.01.13.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 13:19:37 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709327975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mcu8ifKGnRyTxlpkQj5cfTQBEVQ8gXCBuRO6bQX8bcE=;
	b=OyDX2ofHFYQ+quFTNwXNCM3LjqqJMcL30cZRbwjpxCAnQlyjwDeim5KcIW3vMy8ZmZAqUC
	jcGI7KgBkItj3yiCqg0GBXsM7N9DeYEhcel9mngj365kusPvpear35cT2Ec61qTJymRso3
	vx98RYB7GyDWDohWNpqJILrffTlLWjjzsNlPvngOQzHkGL1rd05eca5AMOBdxHxmwuVzhc
	J4I8jV2crOTsC1GuRjcjQDOuKoOJlqDoF9DTlDi7RJKoheZfWrSbdMgGg686rDsvm07Zlt
	Jv2fbMoUnn4IVtuvxwZPfIj6dC11zMv2SLKx/HNwrC+xF/QqZzCOZDUGzYwCtw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 01 Mar 2024 18:19:28 -0300
Subject: [PATCH] usb: typec: constify struct class usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-class_cleanup-usb-v1-1-50309e325095@marliere.net>
X-B4-Tracking: v=1; b=H4sIAF9G4mUC/x3MMQqAMAxA0atIZgup1cWriEgbowZKlQZFEO9uc
 XzD/w8oZ2GFvnog8yUqeyqwdQW0+bSykbkYGmxadGgNRa86UWSfzsOcGkxLjnjpQkDyULoj8yL
 3/xzG9/0AMVN2p2MAAAA=
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2788; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=aQgtIrqPEJ6JLO3fBjYxQofvBaZjEx8JOTDSClljCmI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl4kZmGuWhyMxTSm1IalkqtZB3NrPparm+vd5eV
 s1pBNuJOMSJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZeJGZgAKCRDJC4p8Y4ZY
 pmF5EACFP6Zw/Dp+1tijBBgIUCWuBflQ5ZpphUyMcibsTiS4yzDgjxzHIRuC05GpPydJHw4doYi
 9vQsLB99/CY6lIXKQTeDM+uoJoYufc1xxvf05vFGbBeNGsFd24eVIef/TBFTy9x+4a66R0J3Ddl
 M+cX33V16UkafZSHHy55JjVW7OBMN5fWhLZhN1A1sYfoPAY/aWXq4GmSFYVpN+JmB7l6R/kFzS2
 Jldbgc7gYrZJU7xAb/1Ik9M6KtrBLAD+Gq0XMxI80Yems1p+YQsU7ZJpBofSDOTMG3bGYBkELKk
 Yc2A3B+EswTYypJR7zX2ndjPqO9s+0R1h33eu3c2LxdXSHZsbThHtL54WHTHUsnFfB6qVqB5mJK
 RLOrlvGmtxnrZnqQjacB/923grIaIUKVGAcf8nxBps3WNwfjl42G6YmeXwx+NaU0k22X/wVwkQ7
 4CckMFCNUrCTyBUY9T1ma90CW/TPE1lvxBNFqj38Df+wEAn0Yi4M7LGAtEcdPJO1idXYNO9Gn+w
 i60apvKo1v++CIyr5X3TBnk5E0vAwdU8AlUI9uLIK6cWJJWa5yTj2V7oP3a7HZP+OA6Ktr0s32y
 snzrByrhksZvAf9Auyz2wms3S+8LzS/3rcf70rrJBlgajR5d+vXW5Rmu99u5RenA5mOyG4Y5Ks8
 +2VrD+e4Kru8+kQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the structures typec_mux_class, retimer_class and
typec_class to be declared at build time placing them into read-only
memory, instead of having to be dynamically allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/usb/typec/class.c   | 2 +-
 drivers/usb/typec/class.h   | 6 +++---
 drivers/usb/typec/mux.c     | 2 +-
 drivers/usb/typec/retimer.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index caea2b829980..389c7f0b8d93 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -21,7 +21,7 @@
 
 static DEFINE_IDA(typec_index_ida);
 
-struct class typec_class = {
+const struct class typec_class = {
 	.name = "typec",
 };
 
diff --git a/drivers/usb/typec/class.h b/drivers/usb/typec/class.h
index 759b98355eeb..7485cdb9dd20 100644
--- a/drivers/usb/typec/class.h
+++ b/drivers/usb/typec/class.h
@@ -93,9 +93,9 @@ extern const struct device_type typec_port_dev_type;
 #define is_typec_plug(dev) ((dev)->type == &typec_plug_dev_type)
 #define is_typec_port(dev) ((dev)->type == &typec_port_dev_type)
 
-extern struct class typec_mux_class;
-extern struct class retimer_class;
-extern struct class typec_class;
+extern const struct class typec_mux_class;
+extern const struct class retimer_class;
+extern const struct class typec_class;
 
 #if defined(CONFIG_ACPI)
 int typec_link_ports(struct typec_port *connector);
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 80dd91938d96..49926d6e72c7 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -469,6 +469,6 @@ void *typec_mux_get_drvdata(struct typec_mux_dev *mux_dev)
 }
 EXPORT_SYMBOL_GPL(typec_mux_get_drvdata);
 
-struct class typec_mux_class = {
+const struct class typec_mux_class = {
 	.name = "typec_mux",
 };
diff --git a/drivers/usb/typec/retimer.c b/drivers/usb/typec/retimer.c
index 4a7d1b5c4d86..b519fcf358ca 100644
--- a/drivers/usb/typec/retimer.c
+++ b/drivers/usb/typec/retimer.c
@@ -155,6 +155,6 @@ void *typec_retimer_get_drvdata(struct typec_retimer *retimer)
 }
 EXPORT_SYMBOL_GPL(typec_retimer_get_drvdata);
 
-struct class retimer_class = {
+const struct class retimer_class = {
 	.name = "retimer",
 };

---
base-commit: a560a5672826fc1e057068bda93b3d4c98d037a2
change-id: 20240301-class_cleanup-usb-4c3cef5bb0ca

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


