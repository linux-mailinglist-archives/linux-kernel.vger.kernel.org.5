Return-Path: <linux-kernel+bounces-139752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFBF8A074C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEDE288773
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6313C810;
	Thu, 11 Apr 2024 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3eWVdh4"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED513C3F1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712811003; cv=none; b=WZSDAd2iJre9JQ/dZqPJPoLeOOV73pMzH4Cw6yDnvAMW/I1mwKKPB3+E7dqeD8GQeESx8xza8icM101Sy7qqOJ3UbTZBpwbu1fLpHLtWYmY0taO6LfgHhrNeb7jwX1b+baPloWcJ3qfl08eo8jPGgdofdQbIkKU/QKXoKGqpeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712811003; c=relaxed/simple;
	bh=o0n7CdTQicezVYHkhHA+eu0PFvXKHx9vQdAaZcpUKvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=urqbON83NVZAi1HnlHinJG3UnrxQf/pcjg9VMJA2Br8cHGgWpIN89bxISRMeMt9h2/jLq806mKZdnngXccvQtLgYEKTN6t8nSoSg7FaK4HNgxmP0SEBUwvnQtf/dlADx9jMJkba2DyRgHdk7jZNBxCPAFmH2f6vW/G3ZzJMCZq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3eWVdh4; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso5153476a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712811000; x=1713415800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XYpc5SxTXH/MsQrVYYEDUZMigDy27y83NbauXg0EFI=;
        b=z3eWVdh4kSiaZ1HVJtOPqqXjDaEdR0yB/qv/c18kMCuptbYfXi5x3zi1DPLOeC+HNN
         Fsy3HeJY0xlm6ILDrm3YWBtu0ATqCfHy3HumeYIFyxXS9ybxMy8fF8p4v7bIwhXq+m5E
         jfeoNFNS/8/O1OBSkLBd9Vv2GlMIzzN6MSpofCRE3EO3o8jhQyyEepDCjo+JRmZC+QMY
         C8aN74IhxXOrpNWBD0jU5y1qNLnWQ9wM3cYQLbFC3HkNUoNP/Uen922gfIvAf6fYh4Oe
         KeihFqcxV/WjV2TBQjWBTmgk//+AqrNCiJT34XHwA1hsq8sE9r65X8k6NZnmoOXpTAuZ
         LuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712811000; x=1713415800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XYpc5SxTXH/MsQrVYYEDUZMigDy27y83NbauXg0EFI=;
        b=GXD+AFSJRYVRPniVXAR00Ae+nfwAjreTi9GUh+nIa7eLOqnxM1h2K2r4hCJUnkuF+W
         Q9t7REt7Yga6dYyWYk9c/qqp4ajtOseKPdAMaVnLGCJ+RopuArYp+L07lVabRzyTV/U6
         1ubbQHO4bqW6J6kq582eQAdfmG6opgRR7IaHtRya32z0e0Q1uZOUUIOnbZL0LBIyD/yl
         bYpRcffzgJEFN/WalHr+ZEEu1+Wj8E/6g95yhep/NBrX2dAwVtzhr6SgMyqnx+w7NCoF
         y5KcAsAQcWCs1fprUtfAyMjRjxQticf+cGcS86fiR3S4kMydra743xbZ7nMDDJlP7Adx
         8krg==
X-Forwarded-Encrypted: i=1; AJvYcCUCA5J3ulI5GJnCaDFWxYysc4w/gwP0OViq9UxGeve3RMSjaDeROrPxQUxGl7byUUZqZzQ51fveDS229tZ21PmCWketzbxxDoU2b+ut
X-Gm-Message-State: AOJu0YwAdoSFbRaDOq5KxHg82aUjxuQvRmSQhpSDiMC/7GDFU5nhP8VK
	4+awLIzeSxxiEOyVniiTiZselk0PSUgbPe9jy8ngqIhlWKxnQl4SXavbDPBHypZDkKOAJDR8RNa
	X
X-Google-Smtp-Source: AGHT+IHfOS7TMMEPhMNqCrs2YJCCHD4EXfinhHN+glELQjcm2ZidXGZ5C649R9o5G1KRNLgmNjjXuA==
X-Received: by 2002:a17:906:a389:b0:a52:192a:4ea with SMTP id k9-20020a170906a38900b00a52192a04eamr1144097ejz.29.1712811000000;
        Wed, 10 Apr 2024 21:50:00 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b00a51eed4f0d7sm364899ejc.130.2024.04.10.21.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 21:49:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Apr 2024 07:49:53 +0300
Subject: [PATCH v2 1/5] usb: typec: ucsi: add callback for connector status
 updates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-ucsi-orient-aware-v2-1-d4b1cb22a33f@linaro.org>
References: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
In-Reply-To: <20240411-ucsi-orient-aware-v2-0-d4b1cb22a33f@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2605;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=o0n7CdTQicezVYHkhHA+eu0PFvXKHx9vQdAaZcpUKvM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmF2v1zcM0rrrGE4aOLnDVKdErruEX+D/hxk6do
 U+KlmclAnqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhdr9QAKCRCLPIo+Aiko
 1U01B/kB78Y8wS5Ox4gzzekFlLF4pp7KtBmCVkxAZLP5I67A7gRC4ibEGNAyP8QuarHRj4gsyRZ
 Dn+h7zL+XlBGHsOcwn78reF6iJCjwNoO6TCaZixM2CcCzkVt9Rky+xVhqBm8r6ax4vleyaUbfDM
 vX9/FU0jdbfHutYJ/oqG6iAs/F7nKf2619h0tARI13FqWlzaIbd8Qgl0YwM7kkHeUcoB7DdvpoW
 tD2G2fLOl+qImHV7v/fAQSVXH4CJMr/9C3RBgfs0Uq4bAaXtWadaqrxpUPak+hbgvUxNvJPWeVK
 uRwqdlL+hRhTPiPRBhtFnIDm21YQGPNn2v5khXPWg5GkuGf2
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Allow UCSI glue driver to perform addtional work to update connector
status. For example, it might check the cable orientation.  This call is
performed after reading new connector statatus, so the platform driver
can peek at new connection status bits.

The callback is called both when registering the port and when the
connector change event is being handled.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++++
 drivers/usb/typec/ucsi/ucsi.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 3106e69050cd..7ad544c968e4 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1199,6 +1199,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	trace_ucsi_connector_change(con->num, &con->status);
 
+	if (ucsi->ops->connector_status)
+		ucsi->ops->connector_status(con);
+
 	role = !!(con->status.flags & UCSI_CONSTAT_PWR_DIR);
 
 	if (con->status.change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
@@ -1588,6 +1591,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 	}
 	ret = 0; /* ucsi_send_command() returns length on success */
 
+	if (ucsi->ops->connector_status)
+		ucsi->ops->connector_status(con);
+
 	switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
 	case UCSI_CONSTAT_PARTNER_TYPE_UFP:
 	case UCSI_CONSTAT_PARTNER_TYPE_CABLE_AND_UFP:
diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 2caf2969668c..3e1241e38f3c 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -16,6 +16,7 @@
 
 struct ucsi;
 struct ucsi_altmode;
+struct ucsi_connector;
 struct dentry;
 
 /* UCSI offsets (Bytes) */
@@ -59,6 +60,7 @@ struct dentry;
  * @sync_write: Blocking write operation
  * @async_write: Non-blocking write operation
  * @update_altmodes: Squashes duplicate DP altmodes
+ * @connector_status: Updates connector status, called holding connector lock
  *
  * Read and write routines for UCSI interface. @sync_write must wait for the
  * Command Completion Event from the PPM before returning, and @async_write must
@@ -73,6 +75,7 @@ struct ucsi_operations {
 			   const void *val, size_t val_len);
 	bool (*update_altmodes)(struct ucsi *ucsi, struct ucsi_altmode *orig,
 				struct ucsi_altmode *updated);
+	void (*connector_status)(struct ucsi_connector *con);
 };
 
 struct ucsi *ucsi_create(struct device *dev, const struct ucsi_operations *ops);

-- 
2.39.2


