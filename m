Return-Path: <linux-kernel+bounces-165962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4E28B93E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFC7283912
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4C41C69C;
	Thu,  2 May 2024 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hy1F1vzB"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD2152787;
	Thu,  2 May 2024 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624483; cv=none; b=ECn4X3N5ng59EwDOnq169hU57mCSJuUAvfCku3g54GfFB5WuVpbEHtSMv3QQKl8nuo2W+4KyhkgnhW+ZnCw+XtYqsbbM/Eza+Xtf++d+uvyXMS9SaHa3N4+g18HCVoe2fOPidOdT8Q6fgp6T6iSELigzyiCPbimcEFxemU4zu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624483; c=relaxed/simple;
	bh=cQcFEdgdc6pC9GqB2gbSdsy2bAhuFyqluR262OhVmVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EpUOxkbVkgkpqMb7/ZdeH74ZF3M1u77EztVxv1w6VQTram6PumzbHvGdMpNwFz1INDq+v3SjL/PepNuRnvTe9ppLjdtB4cf3G/p40D8oTbfdwQClDmlNNOpb4pqSVBMQPUX/s020lU4bF3w5+R74+8N5/uQZVpzJ5EGW3K888+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hy1F1vzB; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ad21f3e5dcso5139984eaf.3;
        Wed, 01 May 2024 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714624481; x=1715229281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzbfs0wiOv7uq3FgsVma6gfgD2lkV5u/sFounqmBNIY=;
        b=Hy1F1vzB2fp0+unxxifRuJ8lSUpSpn8AmxVWNDQehZZV7K7GkqjQOAsMpbehfceDPU
         smef9XgU1WryLZAKXFvNrUiQO5yu8m34rMo12OT/XMq+tqpbXmOBwd5yFcjnSbpAgPJ9
         21I+6zQSJtJ78pQBhf5uc+rCmbA1BIr4ihbzEVvp7iMzfuQvV/kKnBwpNZqgF7OM5BlW
         huR3Krl/ZgrDe01ce/sNOW3XIofPolQ8xjipFr4eSRa2sDeNKNU6c6+f6daBtnghyXg6
         b/Vk16AF/2nnX7XPeyMyXKDBWul9+tRJFCAplePbODKZPmrqXFW+zGrFHy0Ub3AWmfBh
         PUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714624481; x=1715229281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzbfs0wiOv7uq3FgsVma6gfgD2lkV5u/sFounqmBNIY=;
        b=AZwQvBfw+RnCt7ntFsAWvahcsQdRtUEdFuYjWo+ZmgQu7vt7V6ZORb+B8Kqd3zG7HI
         nEtA7S+WhPOE/a98fjJbY3UUqt4mC7WwE1DDuRkAPyLmzY0lwXZM0iCXozIM3sialBF3
         dPLVBC6zKbYaZUEjoxPopq7lw+ir5BT250/vMsvCn5rYBw4QD2YlbtG76U1q4be94wIC
         A0RArJcLKbqVxpoWa7fiIFL1li4usjAOe5VrHAFwS6zC3OBBR13UxnF4u9wNdQoVmGZ+
         pniCCAO/cu5QM2RlNrDkfbUQFzsmV0q8Fy+a48HC8NUlgKcTSi0GdpDHJ33ZJ3ZYEwL3
         2OKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY3n4n8LcpvinEU1e5wScgD9dd4zAatjaSdgS6nP1C1N1ZVHPfAk5dwxPfwurTl1I0oNvJ4oaKQd8lGcuq7hGmPARLEhz1J5PfSnbe2iZl8jJUvcDzP076c565btnL9wq0UE4I8J7YJVI=
X-Gm-Message-State: AOJu0Yyn5xnI8d/lq5fUDacs63uwcpLNCxAaZzPPeYSc1zeFYMVNsI+l
	fnyObPWnHWgFYuMsB8iKbyTMyJaWpvwpWUw/cvpyUbBRAAYbAuww
X-Google-Smtp-Source: AGHT+IGeu/ACFu3SjAKNGVfjeMh927PMA1C6f2aJpIqq5+0IAzwlmCSEygLC+J2eN5WRx5QXO7/7Dg==
X-Received: by 2002:a05:6870:2151:b0:233:60e7:52bf with SMTP id g17-20020a056870215100b0023360e752bfmr4986671oae.50.1714624481027;
        Wed, 01 May 2024 21:34:41 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id s17-20020a056a00195100b006e64c9bc2b3sm251133pfk.11.2024.05.01.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 21:34:40 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com,
	hpa@redhat.com,
	gregkh@linuxfoundation.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: atomisp: Fix spelling mistake in csi_rx_public.h
Date: Thu,  2 May 2024 10:19:15 +0545
Message-Id: <20240502043415.88434-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspelled register in
csi_rx_public.h. This patch fixes the misspellings.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 .../atomisp/pci/hive_isp_css_include/host/csi_rx_public.h     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/csi_rx_public.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/csi_rx_public.h
index 693154e8ec2f..7e37f0809034 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/csi_rx_public.h
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/csi_rx_public.h
@@ -94,7 +94,7 @@ hrt_data csi_rx_fe_ctrl_reg_load(
     const hrt_address reg);
 /**
  * @brief Store a value to the register.
- * Store a value to the registe of the csi rx fe.
+ * Store a value to the register of the csi rx fe.
  *
  * @param[in]	ID		The global unique ID for the ibuf-controller instance.
  * @param[in]	reg		The offset address of the register.
@@ -119,7 +119,7 @@ hrt_data csi_rx_be_ctrl_reg_load(
     const hrt_address reg);
 /**
  * @brief Store a value to the register.
- * Store a value to the registe of the csi rx be.
+ * Store a value to the register of the csi rx be.
  *
  * @param[in]	ID		The global unique ID for the ibuf-controller instance.
  * @param[in]	reg		The offset address of the register.
-- 
2.34.1


