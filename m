Return-Path: <linux-kernel+bounces-167111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9118BA4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 908E3B23220
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9A101F2;
	Fri,  3 May 2024 00:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yA3B7DrP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33215E9B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696789; cv=none; b=ZXHWVNxnorKHBSiWxvrxY8oEKbs0XKCdGeBHGnGxlTF8bxF8Ln4B+TNO/MaRMyKyWlQqioiajgOaBRh1fSStvQZv65MJ/apWKY8qSI3E8vJ9BGIv7C5Q+yaMb8KUBkJ7kcxtEUmUdvrTqwWfMMShx8bDs2P0/VonVgYbk2dN5Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696789; c=relaxed/simple;
	bh=1W6WfWN99WG/pjCYyMD+X7XuHDDI4azbE7UAfj/7jS8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIidFfxTzLmqOhuabPSMukvyUp6tFdwdIAX3qmZmsbqId7nWJuYsa+vLFK3UsoPkY8asQ9bWWz7mmysJC9/nd2HtcpfGDvCsf9hjsy1QiGfyy/0VXO1BoWrZPwMIs92JYxrsaTEw1lS32GiaQI403N/xDYiFoul16dw1L8Uqmvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yA3B7DrP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bef0accddso68843347b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714696786; x=1715301586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev3cYq8jpdJihaDvVJt0iSYbqkUt898jtR/GbVOU2w0=;
        b=yA3B7DrPU/ieKZ2wOxG9sEQWe0ugOTXMleihyGLewgSyLPBbJXDnUMm4VHzN/6FLvW
         cC6Pz2vn4oBiK9EsngRZS8q+NeupvXf0ckcOV7ILLCVD4bXVNzO+QwiRqPpw2+WfXmyc
         px5bNxjpw892MuAFC0Rsrqo2DSEBEhHUHrvDshhMqFutGREbG6CRQVv+wrzotDS0Zevv
         a2BJMfFTXtsXORwkq1WUYGPKK88QJfvVZHwSLH+B2g8SazPbUMeuDZG3Cl2Se8rrjiSL
         hk9oQ5mtZ8rcwx5nUz+/NN9kbQ/Fhe+L569wbMp2dnRDCJwMQkZiiowBQpEaDmc7gRoN
         A48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714696786; x=1715301586;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev3cYq8jpdJihaDvVJt0iSYbqkUt898jtR/GbVOU2w0=;
        b=byoID6nPuJ+jAWpG/pg7wtFtTEjrMq7dW4MvCZ4MDN11AYe7MhrFrh/X9g9zzhc/WZ
         qLv3l0rUVhqO4MhyZQXk0JsxB8YWIMiF9Kbc/ZZrjPs/vpmsnR9QgKpc4/xCzuTdarNW
         dyXDLHNUjjMj8jnJOMqrw/oNGK/57PgZ3865Uy6Cxn3lEfHcl5VlVze38oL263DJ3nIj
         W7SrcYFs8gIJ7ESPRJMEYYLEgtRaLFlt+ZsROlgRR1hsjfSMJ4VZADGhLV+sPZUwelC7
         Dh7dO5Tu27W+nehp0ww9s/A9t9il0+NftvVXelEIx3kiNEuE2FPh93/KJiKC4T8kZ1kb
         RVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr65zT4RfCzhmKsBZYygw26nVdFsCJa5AtY0C14x9lpUCUrwB1qLhaojJKrWZB79H1gJyCzBM6CZRgNohvv8u7bxXnE4eKCyQ0HfQB
X-Gm-Message-State: AOJu0YyNYlBDLidEBGWiWYk8E37Qy/Br4JmJkuev538X+IfCER7k49JF
	8+/IQYIED+DN4xLp8DfBu/Dh+l4NrRl1VkpcA1QL2AOHzo6UdjR3J1X1JzX3pyaqHPlozvN/a9Z
	ifg==
X-Google-Smtp-Source: AGHT+IFsDXHVBXexV+q+HUPPZ1A61NbpNAX/YNO61X1Tzqc3GZbiwPa7NnrSWuFsoBHqRKuYYgTm+BG32hw=
X-Received: from jthies.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:23db])
 (user=jthies job=sendgmr) by 2002:a25:26cc:0:b0:de4:e042:eee9 with SMTP id
 m195-20020a2526cc000000b00de4e042eee9mr383303ybm.6.1714696786732; Thu, 02 May
 2024 17:39:46 -0700 (PDT)
Date: Fri,  3 May 2024 00:39:18 +0000
In-Reply-To: <20240503003920.1482447-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503003920.1482447-1-jthies@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503003920.1482447-3-jthies@google.com>
Subject: [PATCH v3 2/4] usb: typec: Update sysfs when setting ops
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc: jthies@google.com, pmalani@chromium.org, bleung@google.com, 
	abhishekpandit@chromium.org, andersson@kernel.org, 
	dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com, 
	gregkh@linuxfoundation.org, hdegoede@redhat.com, neil.armstrong@linaro.org, 
	rajaram.regupathy@intel.com, saranya.gopal@intel.com, 
	linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

When adding altmode ops, update the sysfs group so that visibility is
also recalculated.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Jameson Thies <jthies@google.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Changes in V3:
- None.

Changes in V2:
- None.

 drivers/usb/typec/altmodes/displayport.c |  2 +-
 drivers/usb/typec/class.c                | 18 +++++++++++++++++-
 drivers/usb/typec/ucsi/displayport.c     |  2 +-
 include/linux/usb/typec.h                |  3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 596cd4806018b..92cc1b1361208 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -746,7 +746,7 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	dp->alt = alt;
 
 	alt->desc = "DisplayPort";
-	alt->ops = &dp_altmode_ops;
+	typec_altmode_set_ops(alt, &dp_altmode_ops);
 
 	if (plug) {
 		plug->desc = "Displayport";
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 9610e647a8d48..9262fcd4144f8 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -467,6 +467,22 @@ static const struct attribute_group *typec_altmode_groups[] = {
 	NULL
 };
 
+/**
+ * typec_altmode_set_ops - Set ops for altmode
+ * @adev: Handle to the alternate mode
+ * @ops: Ops for the alternate mode
+ *
+ * After setting ops, attribute visiblity needs to be refreshed if the alternate
+ * mode can be activated.
+ */
+void typec_altmode_set_ops(struct typec_altmode *adev,
+			   const struct typec_altmode_ops *ops)
+{
+	adev->ops = ops;
+	sysfs_update_group(&adev->dev.kobj, &typec_altmode_group);
+}
+EXPORT_SYMBOL_GPL(typec_altmode_set_ops);
+
 static int altmode_id_get(struct device *dev)
 {
 	struct ida *ids;
@@ -2317,7 +2333,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 			continue;
 		}
 
-		alt->ops = ops;
+		typec_altmode_set_ops(alt, ops);
 		typec_altmode_set_drvdata(alt, drvdata);
 		altmodes[index] = alt;
 		index++;
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index d9d3c91125ca8..eb7b8d6e47d00 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -337,7 +337,7 @@ struct typec_altmode *ucsi_register_displayport(struct ucsi_connector *con,
 	dp->con = con;
 	dp->alt = alt;
 
-	alt->ops = &ucsi_displayport_ops;
+	typec_altmode_set_ops(alt, &ucsi_displayport_ops);
 	typec_altmode_set_drvdata(alt, dp);
 
 	return alt;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index b35b427561ab5..549275f8ac1b3 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -167,6 +167,9 @@ struct typec_port *typec_altmode2port(struct typec_altmode *alt);
 
 void typec_altmode_update_active(struct typec_altmode *alt, bool active);
 
+void typec_altmode_set_ops(struct typec_altmode *alt,
+			   const struct typec_altmode_ops *ops);
+
 enum typec_plug_index {
 	TYPEC_PLUG_SOP_P,
 	TYPEC_PLUG_SOP_PP,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


