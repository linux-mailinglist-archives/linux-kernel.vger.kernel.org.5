Return-Path: <linux-kernel+bounces-154754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D408AE091
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1687281879
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43E58ACD;
	Tue, 23 Apr 2024 09:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HFcfiBlA"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD385578A;
	Tue, 23 Apr 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863177; cv=none; b=MJazM/idc1ihmNrTrzavgFkimaF4g0g5GtW5tv2jIHbDFyMnodjoLTh23veA/ytOhCLJ+AEYDP/dPunS5+iLiEyWzS2g0yoCgKPCAuL501jtgk7J73nvHdC9nfxKvFMfFTSD9HhODsccIJFVUusOLyYaAeHRokiUmB0hGtn6FgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863177; c=relaxed/simple;
	bh=qFr01XCCsOjJ3XLciOyq1BEwICTx8UuRQM17Ph15bKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TEsiwFjCytB+PwD8K2rP++CDKu3J3IpxV3MfOYewpFSWDnqUBIEkRvgEPweUQuo2iw3cKvO/QElPa9VGu2WFGF0ba3GIXxkEnl1YLXAV8735c0H6TVVf/u4BYr2EaHFEw5fRXBW81b/SV3TcJzFjjEETAweHd5jglpQVVN1UPhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HFcfiBlA; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 541DFE000E;
	Tue, 23 Apr 2024 09:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713863172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f3Vdm2ApnbgD6sAJCOxwcva/xay9jaobfNPK0b3rdjQ=;
	b=HFcfiBlA76ZdN52JJ0STOoBlPjYNGSdY5cipDUfIp8huo1VoU8xSJDRcB2rYQWf6QzgrbD
	HxCPzTjLeTAsmCx1Puo8DYxUHTt0FirNVVQEEYzBj28f3bkH5c8xioTvIrm4GvPBnmWFic
	rqdAwsa8h+5Ria6W6cYfbyxB3v5BxPvlwbniE6Q6+aEuLSKuUZ8lCuKNhhDYQ1bkn1tnZt
	tj+AbrCwu6Y2NEMPC2+0SdIqPGwpzyCiGxSY3wYfMFMEmWkKQ+gv/NZN8gzuOa+2KUh6kj
	LKSXlRd67ZgYV7CbDzEOf9g52szIH6XsStKi9bB48ShPZGs4ylpzO01i2z+Fiw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 23 Apr 2024 11:05:41 +0200
Subject: [PATCH ethtool-next 1/2] update UAPI header copies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-feature_poe-v1-1-9e12136a8674@bootlin.com>
References: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
In-Reply-To: <20240423-feature_poe-v1-0-9e12136a8674@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Michal Kubecek <mkubecek@suse.cz>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

Update to kernel commit 6a57f091622a.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 uapi/linux/ethtool.h         | 55 ++++++++++++++++++++++++++++++++++++++++++++
 uapi/linux/ethtool_netlink.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/uapi/linux/ethtool.h b/uapi/linux/ethtool.h
index 4d1738a..3884bc4 100644
--- a/uapi/linux/ethtool.h
+++ b/uapi/linux/ethtool.h
@@ -750,6 +750,61 @@ enum ethtool_module_power_mode {
 	ETHTOOL_MODULE_POWER_MODE_HIGH,
 };
 
+/**
+ * enum ethtool_pse_types - Types of PSE controller.
+ * @ETHTOOL_PSE_UNKNOWN: Type of PSE controller is unknown
+ * @ETHTOOL_PSE_PODL: PSE controller which support PoDL
+ * @ETHTOOL_PSE_C33: PSE controller which support Clause 33 (PoE)
+ */
+enum ethtool_pse_types {
+	ETHTOOL_PSE_UNKNOWN =	1 << 0,
+	ETHTOOL_PSE_PODL =	1 << 1,
+	ETHTOOL_PSE_C33 =	1 << 2,
+};
+
+/**
+ * enum ethtool_c33_pse_admin_state - operational state of the PoDL PSE
+ *	functions. IEEE 802.3-2022 30.9.1.1.2 aPSEAdminState
+ * @ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN: state of PSE functions is unknown
+ * @ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED: PSE functions are disabled
+ * @ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED: PSE functions are enabled
+ */
+enum ethtool_c33_pse_admin_state {
+	ETHTOOL_C33_PSE_ADMIN_STATE_UNKNOWN = 1,
+	ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED,
+	ETHTOOL_C33_PSE_ADMIN_STATE_ENABLED,
+};
+
+/**
+ * enum ethtool_c33_pse_pw_d_status - power detection status of the PSE.
+ *	IEEE 802.3-2022 30.9.1.1.3 aPoDLPSEPowerDetectionStatus:
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN: PSE status is unknown
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED: The enumeration "disabled"
+ *	indicates that the PSE State diagram is in the state DISABLED.
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING: The enumeration "searching"
+ *	indicates the PSE State diagram is in a state other than those
+ *	listed.
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING: The enumeration
+ *	"deliveringPower" indicates that the PSE State diagram is in the
+ *	state POWER_ON.
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_TEST: The enumeration "test" indicates that
+ *	the PSE State diagram is in the state TEST_MODE.
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_FAULT: The enumeration "fault" indicates that
+ *	the PSE State diagram is in the state TEST_ERROR.
+ * @ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT: The enumeration "otherFault"
+ *	indicates that the PSE State diagram is in the state IDLE due to
+ *	the variable error_condition = true.
+ */
+enum ethtool_c33_pse_pw_d_status {
+	ETHTOOL_C33_PSE_PW_D_STATUS_UNKNOWN = 1,
+	ETHTOOL_C33_PSE_PW_D_STATUS_DISABLED,
+	ETHTOOL_C33_PSE_PW_D_STATUS_SEARCHING,
+	ETHTOOL_C33_PSE_PW_D_STATUS_DELIVERING,
+	ETHTOOL_C33_PSE_PW_D_STATUS_TEST,
+	ETHTOOL_C33_PSE_PW_D_STATUS_FAULT,
+	ETHTOOL_C33_PSE_PW_D_STATUS_OTHERFAULT,
+};
+
 /**
  * enum ethtool_podl_pse_admin_state - operational state of the PoDL PSE
  *	functions. IEEE 802.3-2018 30.15.1.1.2 aPoDLPSEAdminState
diff --git a/uapi/linux/ethtool_netlink.h b/uapi/linux/ethtool_netlink.h
index 2503b26..b61c04d 100644
--- a/uapi/linux/ethtool_netlink.h
+++ b/uapi/linux/ethtool_netlink.h
@@ -913,6 +913,9 @@ enum {
 	ETHTOOL_A_PODL_PSE_ADMIN_STATE,		/* u32 */
 	ETHTOOL_A_PODL_PSE_ADMIN_CONTROL,	/* u32 */
 	ETHTOOL_A_PODL_PSE_PW_D_STATUS,		/* u32 */
+	ETHTOOL_A_C33_PSE_ADMIN_STATE,		/* u32 */
+	ETHTOOL_A_C33_PSE_ADMIN_CONTROL,	/* u32 */
+	ETHTOOL_A_C33_PSE_PW_D_STATUS,		/* u32 */
 
 	/* add new constants above here */
 	__ETHTOOL_A_PSE_CNT,

-- 
2.34.1


