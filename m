Return-Path: <linux-kernel+bounces-6083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A281946A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA4F288359
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6D3D0CE;
	Tue, 19 Dec 2023 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONISxXJa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E93EA7D;
	Tue, 19 Dec 2023 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e281b149aso4601022e87.1;
        Tue, 19 Dec 2023 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703027709; x=1703632509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uS+jo/cah5+bM2v33qxNfOnHr9iwo5Ai7zggbcCPXcY=;
        b=ONISxXJaqpc0x39nqOHGyMOiaOa2zL/XOItiVhZqBG9cMOUSCTxt6LP/k7Smh4zim1
         eI7m8zfpKJ7EjhKf6Rk0Az2UvZX1x0ZJMM91KDVtwlRuyyry70e+7KKmdTdjdpD6DZji
         NzT3DPXtRNs5orFnk2M1YmCFlkcJyrOnvCP1wIlas+ISRzb59+OFqYVV5U59CD65Mr9B
         p253wuLSMPmrEOniYNy1T9+FpQHZtgZlSzowrsG2KWWkOz4b6Dl46edTmSjnqDccnA6k
         PSNht3WXBzM42sVqCKHIuVe3BsSBbmA6kTnzBXA8cBUYXdLtCJfC+Z1L84lFViLGMJM4
         +jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703027709; x=1703632509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uS+jo/cah5+bM2v33qxNfOnHr9iwo5Ai7zggbcCPXcY=;
        b=GkMMAKQwi8egUmz15xofwL7QoTg5Hsmjw7iGp4F5XIv4oP3yPVtarjnTlUHbjOzIx+
         RvLGBF2N2eJUHnQ6rPjpi9QAWTgmu9qQZTcS7/nhtLQfQ0jIszVcv978qqs08BiBNXbG
         KtjbPTQSK9dvhmYLcO6py8fPNRxX9YxI2rZrWS558bs0ff8dnUxrsA1ihQxQ0S1Iwwkp
         kFtAVagvpb0mzzS4n+SVf+MaJMg4sNQkx/ZYivK+e/ORzaKfAma7TqjflTZq38HMRROb
         XDXPdsx4HANJq0egoJhznOSyjoIF3va148tcEBFqMKt8guZ21ByJ2bOBwfDCh7hTzuYW
         VC5w==
X-Gm-Message-State: AOJu0YzSEvuTl+VXZfLE5kF5jOcyz5HGzHc2UNhHkugrP9p5pjNxNG/0
	DqUEa/6HJxkr/LSZ+6xbo9C98XQO0tE=
X-Google-Smtp-Source: AGHT+IFOzhD77cypKuovPHId5eRYIT5ovGCKQdgQe8QtFUgDqlE/In6u89k0WIuYI2Dd4haVwt/TCg==
X-Received: by 2002:ac2:4ec6:0:b0:50e:35e2:a6ad with SMTP id p6-20020ac24ec6000000b0050e35e2a6admr2124077lfr.83.1703027708873;
        Tue, 19 Dec 2023 15:15:08 -0800 (PST)
Received: from localhost.localdomain ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id fi8-20020a056402550800b005528001d5c6sm5657742edb.62.2023.12.19.15.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 15:15:08 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: Daniel Thompson <daniel.thompson@linaro.org>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] HID: sensor-hub: Enable hid core report processing for all devices
Date: Wed, 20 Dec 2023 01:15:03 +0200
Message-ID: <20231219231503.1506801-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the commit 666cf30a589a ("HID: sensor-hub: Allow multi-function
sensor devices") hub devices are claimed by hidraw driver in hid_connect().
This causes stoppping of processing HID reports by hid core due to
optimization.

In such case, the hid-sensor-custom driver cannot match a known custom
sensor in hid_sensor_custom_get_known() because it try to check custom
properties which weren't filled from the report because hid core didn't
parsed it.

As result, custom sensors like hinge angle sensor and LISS sensors
don't work.

Mark the sensor hub devices claimed by some driver to avoid hidraw-related
optimizations.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 2eba152e8b90..26e93a331a51 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -632,7 +632,7 @@ static int sensor_hub_probe(struct hid_device *hdev,
 	}
 	INIT_LIST_HEAD(&hdev->inputs);
 
-	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
 		return ret;
-- 
2.43.0


