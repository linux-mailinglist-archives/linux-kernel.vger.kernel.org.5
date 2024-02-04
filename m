Return-Path: <linux-kernel+bounces-51897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D56CD849080
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE45283279
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7032562C;
	Sun,  4 Feb 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="uMX78pb3"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09525564
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707080095; cv=none; b=n81A0KsumwTxYBkoRnoNSoxEpxQy4kF0bg0cuqXD8kx9TbcMTW4wllnIUf0AtlFk7nxZr9UBprhGeECCmBQMMj3eqk5LDFNgSdsgpCgknehaKWSU7bipKmW8arwEOONpfPXRu0tZgqiPfTcOYwl5FzTZeSXZRtLWCt3lTMpIu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707080095; c=relaxed/simple;
	bh=cRAjYVT3aU/0L1PTARLaimpHmTVl38ZB4JhjFVFkB38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nsHwg2NoVMixnCLZoUdQj0f8pp4UN74And/vjpchfDVfo4eqi1/3F2GhipvrZylh1iMYcMWdcHjWfm3WrOkF0Ldd1Iwt4giVhe58TrySGk1stE2OjV5AgVRlubHSisSJa0umMOHZ2JdABgd2RkPJGWulLi76va01ew4CW+pzAqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=uMX78pb3 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e11faeb125so1901665a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707080092; x=1707684892;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAu0zvaIyFYOf/16euiq/gY/arIjrGPDYqgSqZ1rc3s=;
        b=v00BP6dimARunkTjIeLg0VCVXSwS+PWYE0cWM/wPNqe1nFvYI2m5IBC0DUUDA/cnGg
         exCvVtZyJBghGMGV74z/Obk/smY9VNUvJr4ND7qb/0zbOZGawiETnff6o2zmsr5YpVpK
         aAB4Z3GZfSXozyvRWWEpy+WFdUXUehCROk9hV6X41ZLZt5bQ8bj3pgFPINn9AC3xXlUN
         rXs8O5CfVT4roO2JfZRU1fDEHJXv04O67ElrhUnVOCp2c+SYtPbQLukfEhwvJPqmvj7D
         0jDwNLuOHE5iJzCqP5YydDsbesLXw549Y5leHjIgezKy624NB6DdbI+bdu0g1PI2letF
         diDg==
X-Gm-Message-State: AOJu0YxXdTbYeOxJVI/bhqriAd2mNvylm60urCFVUO7D+DP4IWjyb+Ar
	aYXPBj9UgvOUUU7YSKcRa3HCJGRzQGPxMz6lh9tX0/Oro1wTzHBG
X-Google-Smtp-Source: AGHT+IHZvCEtBdmvApPLSUHStDJGlTb662Kk8hfhdfS4qVWT2fDV1AC2f1S7dTBExDoWng8OQnMZ6A==
X-Received: by 2002:a05:6358:796:b0:178:b0c5:25e3 with SMTP id n22-20020a056358079600b00178b0c525e3mr14140538rwj.3.1707080092555;
        Sun, 04 Feb 2024 12:54:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVzI98puzGg4k9tyw+p4AZJZ/pbVmC4RGWs+eyYEPenHBzO0OeeGeZn4PKXc3JYya8DLk56EXOGfE88PS50rQrZM7gJ5ZTn9HoK7w==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id pv8-20020a17090b3c8800b00296852b2df1sm1534565pjb.21.2024.02.04.12.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:54:52 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707080091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WAu0zvaIyFYOf/16euiq/gY/arIjrGPDYqgSqZ1rc3s=;
	b=uMX78pb3b4VCrrb5LmEhjTSYkNScydvPn+SO4lUhVhBT87cdZppXTIRILwTlmH2TneG9KZ
	C/eBMuWfkUpCDarY89nNkemv9JkxUXjh/EFaSdPbiNdesIAqBhaWm0r9FKNOJhO5NxGQX2
	JOFKUcNuUu9HTjCrebNX7ZEcjYNXWOwlzJQFB1npDKZk2FV3qKdbL+HzxhKoQ7ilugzdah
	JMibMx1ipMsmDy15YpLTF7CpyGVyGdtwJYvp3yj06s6U5GI3NbY1b06fKKS8lgvQqksG8F
	ME/nLx6xxhjQcTYw2yOKhwSNbIfmag4gnolN8wyWJRFrivphrjZUtZbH/o5w0g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:55:22 -0300
Subject: [PATCH] w1: make w1_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-w1-v1-1-a0f4c84d7db3@marliere.net>
X-B4-Tracking: v=1; b=H4sIALn5v2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3XJD3VQTs0RD02QLI2PzNCWgpoKi1LTMCrC
 B0bG1tQCBLAPaYAAAAA==
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=cRAjYVT3aU/0L1PTARLaimpHmTVl38ZB4JhjFVFkB38=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/m5U+00f/YTQlvlD9f2cq58CpxerCZ0bWDD+
 bvM2J4VST2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/5uQAKCRDJC4p8Y4ZY
 pmKkD/9MpcidHxC4R8cGb+wEgoGtOiZDgb/kjKh+L6c4YnZ4MyZbxYJdhknpUayfAhcXuQNNgAz
 koODwYRJgtx1Up3FvIvrRTaPAmvkH+Rpkb3dGtagKLZSEJZ2zAfzMETth3/NDKfpTjgPL8v8Y+R
 MX9Ob9rUg1L0fqLeU6jUM9eEGMEk9oB5O5DY0MM756/dM95vJZZyElVhWYuvb9uPw864c8bqPv7
 fIDhD/96uZmWJGIMYz+hnZCv1sveCIp+oZozNWghHYHPIh4YPPfIQyV20QaIdw94yQz6FyyqJOZ
 IZjWV7yHJiUyZP1PVAddHkpPvSKFn/hcRC86HecQ8YaKmYh23tLDArOlKVVi7vBOVme8ekZF1e6
 UOFWNZGFxWyVlFhyYnXeDzVrUU7JiFA9vNqW6h5EAliOyMI3UNG/oe/O8+0kX+bpf4HoxjUCWJq
 XIGr6MxpaH71jLJ24y2c8DG30ffO+mc1miLCNFN0/Ldr0hoaga/TGVm57iNBxJpINKOPpuSIY1/
 8ah2E49NQDS0E2kKLHxpyY2SRItItI4l+Mn8W1awx/c4o84CGCI/7oX+2JNVTk8v34IJrcdce8K
 9uU6QtD8hWFGG9VN0aJGa5eX6Z6ADxhBF1Hj/5tfYJdZFo+FJV7AQvm0uEk+1R1ZoscYQAZiafq
 g5QTKnUiojlQfyQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the w1_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/w1/w1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index 5353cbd75126..afb1cc4606c5 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -167,7 +167,7 @@ static struct w1_family w1_default_family = {
 
 static int w1_uevent(const struct device *dev, struct kobj_uevent_env *env);
 
-static struct bus_type w1_bus_type = {
+static const struct bus_type w1_bus_type = {
 	.name = "w1",
 	.uevent = w1_uevent,
 };

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-w1-e46a15c8237f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


