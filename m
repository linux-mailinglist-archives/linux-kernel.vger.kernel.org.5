Return-Path: <linux-kernel+bounces-63699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5356F85336C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7805F1C22B77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B23D1DFEF;
	Tue, 13 Feb 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="l5smCoRw"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F365757873;
	Tue, 13 Feb 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835407; cv=none; b=ZJS/CrAsJ6S/wfcwn2pR2Pga/GbCu5vg03HYDeuxNA+CQynbxKPQM2v4vOqZg5sdHJ8FYc3azrQJY78GBXoly1+QCHx6/XDED2pioJcQJLb1grJGgHkP5XFDwFU3+ocydM+pv+C7LcfZmCC+my+ILDC1TSOM52mV1z46wR/aowU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835407; c=relaxed/simple;
	bh=WNpttQEDrqvt8dFJV77xZZnD8lcLZbyCkaxL6f/dDNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CqFloXaVDBUiSN8khC1ZmSW/fUbMg55ZGH9cc3htPiQXyT0Q/ydkicq86n6sfKV/5JpxtA3hyYFj23oxMWm5XK0EisHzFziOM2A4KYotGWFjiXCMJM4kBK/+aO+V5AXA9vMIsnB1/YsoWs68DQV7Ve3B6oWc3RI+t0bkAluj84M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=l5smCoRw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e0a5472e7cso1700101b3a.2;
        Tue, 13 Feb 2024 06:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835405; x=1708440205;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYNucHgPMrt9ZK1QrIVWntmjSqYfyys/m1XF/v5jsto=;
        b=ZLD+ELwgfnfRDX0wGiSux4tQdaFgRgnRb9VRVTW4bbLU6SB0Co++hRmzqZ21BXhMvg
         F0/mQVhav2Jvfwpma+HY973w5YiBKbYkqDg2enSVJXOiQIKeLceunXQA1ZtkKmRYeuOK
         ck57yRaKL1JcFzoN+OfHkU+gFmy9So2v3trSNp0TOBI5OvCfdLfIaMEVTln48nv6gUbV
         2kHtIlSZhjeAdmuqxUetoaEXUaRnBAzIDzAYcVO5M72yoi4SuCXVmPBFoKx8/nuhGNg8
         FhsFLveO14foj/yoW9TrPXjrv1H5TozuLu0+5Og0uqJXIqn9BpIPriAHWVKmwrh3zcI9
         aMgg==
X-Forwarded-Encrypted: i=1; AJvYcCVueWSirDsOEoIzQ2oL4DRyt4WtjoCwFfradmuDtymsNlxPa45ZbX3xTgIZHCuNLI0K0S3AnX++Fwocc/XM5p0lzdnZjv+4cdvb45OtBNWE6ZODygnqTW8wvTQNJFdTYO0ztpGFBAmaPSPADA==
X-Gm-Message-State: AOJu0YwNWC17o6/nXcHj4VvHX8c7yQToh6gUdmB0BJ+eSlJjxv7Zerqe
	dzVikXjwmu+mO2xudx+mdA4lzMepRigRJOjs+1/M1E2u9M+75xQ1
X-Google-Smtp-Source: AGHT+IHLLGlo70VhjAv4z5ov36ZrZKFq8nDNMCqLQZYEXHlALKW6yInWY/9G7HaH9+IuoqUeK7+Y3g==
X-Received: by 2002:a05:6a20:ce47:b0:19c:93b3:c669 with SMTP id id7-20020a056a20ce4700b0019c93b3c669mr8122107pzb.29.1707835405253;
        Tue, 13 Feb 2024 06:43:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4zBhh7yrmLk5zu+RrfnMjm/6ZEH6JfqqMa/JIvOBxWQhZW+wzh6usqXGWcwMUagazDoJJGAkLZEYCozTpKub2l4senvn+V8FphaQAQiiSDfFZvkVdEO9czIVLZpFekJ8E8CTbCBhS6qpOysUOtnJd0Pr7Ldn0IuKaqqe5LTLYGq/81T3cqeWqo+pp00fjqK9SGMGwApeArmdoPWQkZoKDrTJ+DbWEhfqIRs3LRZ26tSGvl/Vg+mzHyef12XTJT5pDiATujcy055BrcvTl
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id z5-20020a62d105000000b006e08437d2c6sm8099904pfg.12.2024.02.13.06.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:43:24 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FYNucHgPMrt9ZK1QrIVWntmjSqYfyys/m1XF/v5jsto=;
	b=l5smCoRwvk1Mx5BdQFCdQtU/3ZsJ1FNBT66X17YgwebdIbuSshfBM3SXwxe8hYvs7LGKf6
	5FM4DbiGVuXj22gYOtU9H88lu0RNr/b7f8I0N2lYdX4skI6p0MDtGCE6dqlQ3Z61h2xGIk
	v045CjiSyBnCALlcewuUAfLibBQDuWhzSEYZF0eCdRHTSmr0/ojheAnrURXmTayNdPd4x1
	9QbAzG2iube256TVDuBdfYQQVzG8RlJNgmOxtCVTuw2ev/25yPNpo9ih2sTFlasDMqHEqI
	SWgB4SGxSFzVIP10zrLAuEFIsRmiSGr6LvYUuqu8Xqb7UVK7zGM7g06pWYk/hw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:44:01 -0300
Subject: [PATCH] soc: qcom: apr: make aprbus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-apr-v1-1-50c824eec06d@marliere.net>
X-B4-Tracking: v=1; b=H4sIADCAy2UC/x3MQQqAIBBA0avIrBPUCrKrRITZWANhohhBePek5
 Vv8/0LCSJhgZC9EvCnR5Stkw8Aexu/IaasGJVQnlGz5mtNiTzQ+B25C5K3o3aCdFv1goVYhoqP
 nP05zKR8fLAWPYQAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=WNpttQEDrqvt8dFJV77xZZnD8lcLZbyCkaxL6f/dDNg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4Azba+yedlJSxrLcdV5QSQIj/y/UhcAHPfbF
 dDVyANESOeJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuAMwAKCRDJC4p8Y4ZY
 phWnD/9rAPaaWWA6BJ6yJMPj/UIdqpENn4eB0nlph7th67CZFFwn3Q5o8lddz4AEEo4p7tPB5AB
 cgp4O7LA7iCH/ExEypmt6bMZzwVFCkgBABtGEYWq+9gE1s5iAZGPl/0Y6EdiHEhXHe6MSHcA/YG
 aWFlXIxp4liOhyVy1FQHtxakUUaCAFsFkrv+A5sEzCDp+EjV0NrHA6j/OtnMgIuCRqD27yDkSSp
 P0651lFbSuJPSowMFTHWZ/7jWjF3stF29rIt0JLJ8il0P2frbyA+zBp3AteLjduDCaikJQ3Tk1o
 GoV8uQcBRbfDU6Z07X/LO8rZ5Z8pXTQpIwpme5c3M2+dBIOFcscOYfVd4+s6Gzdfm66vAWy/bRA
 ibktmLZzaNWOQrldMnT1AvtL/QWDh3d4tFTapi7DFZX0KklDllYtHSuw4Pt7ctX9Jmj0+MBYCtg
 3+WiMBTC1bNUgkOlfB5sOdtB50t2qzmQUjHv8WVn8oD/sXQBXLmZ3iSNrfakyXmooAa95AqbXjI
 V0wlpBlIaFtWal8Lbjl5SufroglOceEYPwJ5FzQ2z/aj3oUFDMJO1BrNA9EPFdEOSKu65sZmVS3
 D9co0V2ciBHfFcmaS0YIXv21Fg5j+hOoN27LTF+nfrWZ+qucYMTubmd6xoZaOuFGdpxHCHqbUyq
 ND+n/BJP/jpCp3A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the aprbus variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/soc/qcom/apr.c       | 2 +-
 include/linux/soc/qcom/apr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 1f8b315576a4..50749e870efa 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -399,7 +399,7 @@ static int apr_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return add_uevent_var(env, "MODALIAS=apr:%s", adev->name);
 }
 
-struct bus_type aprbus = {
+const struct bus_type aprbus = {
 	.name		= "aprbus",
 	.match		= apr_device_match,
 	.probe		= apr_device_probe,
diff --git a/include/linux/soc/qcom/apr.h b/include/linux/soc/qcom/apr.h
index be98aebcb3e1..7161a3183eda 100644
--- a/include/linux/soc/qcom/apr.h
+++ b/include/linux/soc/qcom/apr.h
@@ -9,7 +9,7 @@
 #include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/soc/qcom,gpr.h>
 
-extern struct bus_type aprbus;
+extern const struct bus_type aprbus;
 
 #define APR_HDR_LEN(hdr_len) ((hdr_len)/4)
 

---
base-commit: f7b0172f074a435a34bc0902b6cdbf1a3e935e27
change-id: 20240213-bus_cleanup-apr-305f89f9058c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


