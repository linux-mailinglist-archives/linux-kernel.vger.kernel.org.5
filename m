Return-Path: <linux-kernel+bounces-110173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6E885B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 295B51F22ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B087985959;
	Thu, 21 Mar 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRDAyzpL"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FB2CCA3;
	Thu, 21 Mar 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032364; cv=none; b=Z6mburHYm6HPrIWh2O6wMLHcWqeOvxy6sOOuT2GUgGIiwA3A0Keb8DA3BUkDPcGBY3AiVlswZlkhrt5S9aVjJXQYkEJupNwd9Q5Ds8RaTF+CS+NEcZxsqvK/LyWCb0owChEsixYR61h9RZ3iM33PydcrAtT0Z8xsNns5I0ViXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032364; c=relaxed/simple;
	bh=OfwtyNv0NGZVAPQHDJSgGA4HlElpaFAtixCskOiVVOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSjg6ffJXnyfkhS31p+v8bJLA8RkzTbeDxfRDnts59Twt4UhGOVQfD/DPWidD2UbcAl+NXc6fayJLwhi8r73aREMiUXRSX6aC3ACVgf2yuSvQuN2CESqfumSb8yu+rdTwWYvTxB4s0WCK/EpdyOptMvkD5bW+t4QHhUvLCj2xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRDAyzpL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41468f6d584so7608975e9.0;
        Thu, 21 Mar 2024 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711032361; x=1711637161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOqVqPFdDpYJadCbJKi0U30RYgqb7Iv89z4lJW8U+Vg=;
        b=NRDAyzpLRu7lrssiac8brN6mT1pCdzNg95YTznsEtCESCybqXi6ykQtAd3uy8C1DoY
         V3tTMjF3QLubw0sMyTL1chz1j/ceBTma9hDqamI0io0ETeDdc/cGrJiHGqiEVjMIV+qH
         24u6CgL2SoUE1YrPwsA+fde95kv9K/0bA2StaXkFMMLzbMGH4B5Mgm5TYOpK+1uy0oZe
         HoCa53XlGKwePV5eiMepyVUypC6+W13V0dzEVuBVdZjYFPVTuqP/yLrmHZPMSjsiHO3S
         bOWBITp8hvcBvINKRgec+SEt+cnfoxsmDQYY1He3ZTR9P1/GkeVTlMsGaXpb29IG2upt
         AC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711032361; x=1711637161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOqVqPFdDpYJadCbJKi0U30RYgqb7Iv89z4lJW8U+Vg=;
        b=JU/zsw5DZGMAo/5f7ZG0c7JTqo6oMoMFnGrbugx+G3aFcXg6HNtss/81E2aSNkpD5e
         BMFPIqCVmYUp0oJqyELRcZbG/cGVoW6goiL0YJbPJVg4LRqvGeCRX0UQbhB2VKl0gCyL
         IdYIeLNUcNZKU0ANJJN2FJ/ogMAwiUzmHRx8YeefG0UZ5nAj/1pVcsnRFl5NTi/kFOTw
         I+hhIFcssu/wzYoxQPhRtqHdYweubXoKh41t122Z6FR77ZsJMYLcynRduP5E6e0UfhO8
         AxDZLuE3KaJ3P+XUJknKX1HGCFXAZuv67nYpfA3gSiNMM5hZMAmNPKjRA1XrNE5oIU/t
         vxRA==
X-Forwarded-Encrypted: i=1; AJvYcCUE396WuOsrUTMUjrxxbQhr2os3NxtOq0BgudIFI2iqc1rKevKvN7oYIQkCsHPjEQu4d0bGu1OCHwZDFFUvxi2jMAqjsMsVN0q5snQLdbR3IXBWPmhqlcfGeYGqB1YDAeS0i6/Fk33/qv4=
X-Gm-Message-State: AOJu0YzyJa922fMhGu1uuyytI/Fi4PN5KWeBcFy8DLONzidnsnoToUyF
	LaC1TN+hnjc/Z/pcUu9ZpHaQgoHFJBvPZnch42VjfxQxoEsSIzNYKRmfJ2tn
X-Google-Smtp-Source: AGHT+IErliQyrBovUF8V7LzMWKoHse25SetDdT76a7ul21lsKo/Ninq86nVVFYS8b7/SuidAd/M6/g==
X-Received: by 2002:a05:600c:4f06:b0:414:1363:539f with SMTP id l6-20020a05600c4f0600b004141363539fmr7990016wmq.8.1711032360380;
        Thu, 21 Mar 2024 07:46:00 -0700 (PDT)
Received: from fedora.. ([94.73.33.46])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b004146d736fcdsm5253378wmo.36.2024.03.21.07.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 07:46:00 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 1/2] HID: uclogic: Store firmware name in params
Date: Thu, 21 Mar 2024 15:38:04 +0100
Message-ID: <20240321144553.262409-2-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321144553.262409-1-jose.exposito89@gmail.com>
References: <20240321144553.262409-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A future patch will need to access the firmware name to expose it to
userspace via sysfs.

Store it in `uclogic_params->fw_name`.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 14 +++++++-------
 drivers/hid/hid-uclogic-params.h |  5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 9859dad36495..79ec3eb80f84 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -121,6 +121,7 @@ void uclogic_params_hid_dbg(const struct hid_device *hdev,
 		params->invalid ? "true" : "false");
 	hid_dbg(hdev, ".desc_ptr = %p\n", params->desc_ptr);
 	hid_dbg(hdev, ".desc_size = %u\n", params->desc_size);
+	hid_dbg(hdev, ".fw_name = %s\n", params->fw_name);
 	hid_dbg(hdev, ".pen = {\n");
 	uclogic_params_pen_hid_dbg(hdev, &params->pen);
 	hid_dbg(hdev, "\t}\n");
@@ -652,6 +653,7 @@ void uclogic_params_cleanup(struct uclogic_params *params)
 	if (!params->invalid) {
 		size_t i;
 		kfree(params->desc_ptr);
+		kfree(params->fw_name);
 		uclogic_params_pen_cleanup(&params->pen);
 		for (i = 0; i < ARRAY_SIZE(params->frame_list); i++)
 			uclogic_params_frame_cleanup(&params->frame_list[i]);
@@ -837,7 +839,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
 	static const char transition_ver[] = "HUION_T153_160607";
-	char *ver_ptr = NULL;
 	const size_t ver_len = sizeof(transition_ver) + 1;
 	__u8 *params_ptr = NULL;
 	size_t params_len = 0;
@@ -870,14 +871,14 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	}
 
 	/* Try to get firmware version */
-	ver_ptr = kzalloc(ver_len, GFP_KERNEL);
-	if (ver_ptr == NULL) {
+	p.fw_name = kzalloc(ver_len, GFP_KERNEL);
+	if (!p.fw_name) {
 		rc = -ENOMEM;
 		goto cleanup;
 	}
-	rc = usb_string(udev, 201, ver_ptr, ver_len);
+	rc = usb_string(udev, 201, p.fw_name, ver_len);
 	if (rc == -EPIPE) {
-		*ver_ptr = '\0';
+		*p.fw_name = '\0';
 	} else if (rc < 0) {
 		hid_err(hdev,
 			"failed retrieving Huion firmware version: %d\n", rc);
@@ -885,7 +886,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	}
 
 	/* If this is a transition firmware */
-	if (strcmp(ver_ptr, transition_ver) == 0) {
+	if (strcmp(p.fw_name, transition_ver) == 0) {
 		hid_dbg(hdev,
 			"transition firmware detected, not probing pen v2 parameters\n");
 	} else {
@@ -1028,7 +1029,6 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	rc = 0;
 cleanup:
 	kfree(params_ptr);
-	kfree(ver_ptr);
 	uclogic_params_cleanup(&p);
 	return rc;
 }
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index d6ffadb2f601..412c916770f5 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -232,6 +232,11 @@ struct uclogic_params {
 	 * List of event hooks.
 	 */
 	struct uclogic_raw_event_hook *event_hooks;
+	/*
+	 * Firmware name, exposed to userspace via sysfs as it is used to
+	 * identify the tablet.
+	 */
+	char *fw_name;
 };
 
 /* Driver data */
-- 
2.44.0


