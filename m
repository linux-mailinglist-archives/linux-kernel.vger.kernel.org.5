Return-Path: <linux-kernel+bounces-104812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5276D87D40D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EE41C20937
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B45490D;
	Fri, 15 Mar 2024 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ppg6CUna"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41548548F6;
	Fri, 15 Mar 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528622; cv=none; b=YbHpXkJaeG5jPmxrp89T3Kn0rlOBFw852Dbp0upAfQ9leUH1cQq8zoBELXZL7ktJoE2yYvu/D+xlAUpqtXdhrKg4NksYWL1/vjENAYyemFrzDlFOCOs5YQw7ZjQqLyoYN3Rs25cYgr4glAEcy5Yd+xCkn/G7dIgPfPplK1iD3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528622; c=relaxed/simple;
	bh=tmgcPa6hPAC5BWC8puAcQhS0P1RuvzQLq2tAgP9p1SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY5x/uGoCjG11w0Pxp2pOj8ZO9spklINdFW5EtGWoBccrOT67Gu4qKns7XphJR5kYhsxn3oVky9NtW99z7T08Az1EhNEJzEgbNbqdmCx/mqWsz81Is0RV7cH3IUTzqeBsNAEgjxKtcVEJnmNV7r5PQH9AFWpVOYzcaHewg6Sr6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ppg6CUna; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6082eab17so2237513b3a.1;
        Fri, 15 Mar 2024 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710528620; x=1711133420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJyaNPyqw2IdFqRfIn2kDaXxflGKfLH9sUwkufABDcs=;
        b=Ppg6CUnaQ2nWS/xv61WeJd+1sbORR9u3+VXpjmyhDFT7a0nTa/iUrqFLbqrUmXp/dE
         vB8NVDY2uwGJmO3vJFvcB2T+jQHiVSaGHj9ucEK/OGB7ZNpRH+mLZKWtWK64h9HbfRuh
         fVomguXMLxSwrcM/4QNZFI4jIynBHal5lrShiNa3yJPbHj3cBze+K3Pkv3ST5O9xFDHL
         49wkyu/N+3YidYLDCKtuylTNEehtUFaoULm7DDe6N8jvBsX+22YRnuZb1ubgi8Q4Zm1G
         m7EiKP/dNYGnO0Xdi1bQ1GxRsP9HyMmwOYcVAJf+10MngIz8sjQqez7LZKC8gnaeaMlX
         nQhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710528620; x=1711133420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJyaNPyqw2IdFqRfIn2kDaXxflGKfLH9sUwkufABDcs=;
        b=e60UI+d8rx2nuo9OFH5VJKG6Ym76ol9vLFpOr5Anjc1bapMC2+vGzJd8GEx6lA14vj
         jCjoTgEPv3xMwxoQgETi8YLifyayscGPSSA9WRRE5yEV6LGm1ZDlS8L4Jw2ykaW1gnjK
         460t3BEdAXlBWqrro4s6OGLl+Hp6lD1ayrxLYOFhi6UdTIYfgDqe1y7jRoRFi1yahh6X
         ZdoBO8B1KRMU3s7ksUU1Ky0O1xfYTVG47H2B2wOYfy5BeBpuQYNcdK61+xnX5/gVqnGK
         aojlParXLPlWRZmbr/6ThSXoX9Cgb526CoyLmN1vl57VPmsBMlYmasCotmBazPtl7ue3
         5zIg==
X-Forwarded-Encrypted: i=1; AJvYcCU47zvbbU/spXhhj8egsJPI7Ny3ioLdgkNgzyfByDRKqKvamQreWxDkgvg1Hsq3zjjOmdb1DEv0m+fmE64Ing74mGW7iTYneloIJ4qmskrUFuHV7EPxLzrLUog/sh3kgG/7Kjh7XQKynrYACc4w6VrYvwkn2Fv6PLw0TFUrxRLI+hvzgQ==
X-Gm-Message-State: AOJu0YwEXK7OyL4VUhjGtSrr+i/g3Ic6T3JcSEErcEnrK6kdL3lW0ziV
	7fjvn1+QS4NJgdYrUfZG5x0z1bIOQd1ahf2Q9Ba0YhS5xN2YzdpFb4nExYFI5riQqQ==
X-Google-Smtp-Source: AGHT+IHc7+H5cEGXqrctyaczStsb2ofp2iqgC06SmJk8JFddX4axEu63mOXWmXYSgCe6j/iNGhO5GQ==
X-Received: by 2002:a05:6a00:841:b0:6e6:8c49:f2f6 with SMTP id q1-20020a056a00084100b006e68c49f2f6mr6144160pfk.24.1710528619634;
        Fri, 15 Mar 2024 11:50:19 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.94])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a0022d100b006e6cc998be8sm3580784pfj.207.2024.03.15.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 11:50:19 -0700 (PDT)
From: Ayush Singh <ayushdevel1325@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: [PATCH v3 6/8] greybus: Add mikroBUS manifest types
Date: Sat, 16 Mar 2024 00:19:04 +0530
Message-ID: <20240315184908.500352-7-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240315184908.500352-1-ayushdevel1325@gmail.com>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add data structures for parsing mikroBUS manifests, which are based on
greybus manifest.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 include/linux/greybus/greybus_manifest.h | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
index bef9eb2093e9..83241e19d9b3 100644
--- a/include/linux/greybus/greybus_manifest.h
+++ b/include/linux/greybus/greybus_manifest.h
@@ -23,6 +23,9 @@ enum greybus_descriptor_type {
 	GREYBUS_TYPE_STRING		= 0x02,
 	GREYBUS_TYPE_BUNDLE		= 0x03,
 	GREYBUS_TYPE_CPORT		= 0x04,
+	GREYBUS_TYPE_MIKROBUS		= 0x05,
+	GREYBUS_TYPE_PROPERTY		= 0x06,
+	GREYBUS_TYPE_DEVICE		= 0x07,
 };
 
 enum greybus_protocol {
@@ -151,6 +154,49 @@ struct greybus_descriptor_cport {
 	__u8	protocol_id;	/* enum greybus_protocol */
 } __packed;
 
+/*
+ * A mikrobus descriptor is used to describe the details
+ * about the bus ocnfiguration for the add-on board
+ * connected to the mikrobus port.
+ */
+struct greybus_descriptor_mikrobus {
+	__u8 pin_state[12];
+} __packed;
+
+/*
+ * A property descriptor is used to pass named properties
+ * to device drivers through the unified device properties
+ * interface under linux/property.h
+ */
+struct greybus_descriptor_property {
+	__u8 length;
+	__u8 id;
+	__u8 propname_stringid;
+	__u8 type;
+	__u8 value[];
+} __packed;
+
+/*
+ * A device descriptor is used to describe the
+ * details required by a add-on board device
+ * driver.
+ */
+struct greybus_descriptor_device {
+	__u8 id;
+	__u8 driver_stringid;
+	__u8 protocol;
+	__u8 reg;
+	__le32 max_speed_hz;
+	__u8 irq;
+	__u8 irq_type;
+	__u8 mode;
+	__u8 prop_link;
+	__u8 gpio_link;
+	__u8 reg_link;
+	__u8 clock_link;
+	__u8 pad[1];
+} __packed;
+
 struct greybus_descriptor_header {
 	__le16	size;
 	__u8	type;		/* enum greybus_descriptor_type */
@@ -164,6 +210,9 @@ struct greybus_descriptor {
 		struct greybus_descriptor_interface	interface;
 		struct greybus_descriptor_bundle	bundle;
 		struct greybus_descriptor_cport		cport;
+		struct greybus_descriptor_mikrobus	mikrobus;
+		struct greybus_descriptor_property	property;
+		struct greybus_descriptor_device	device;
 	};
 } __packed;
 
-- 
2.44.0


