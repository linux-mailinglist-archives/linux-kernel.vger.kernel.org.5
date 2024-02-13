Return-Path: <linux-kernel+bounces-63704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4578853378
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C51D28BFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CD05B672;
	Tue, 13 Feb 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="kKJZfbK6"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481357895;
	Tue, 13 Feb 2024 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835490; cv=none; b=VKgfN2CXu2r89jBDPWwgDwlnUo4a29JmU9PcOqONjfE/a9liImzMO/SpDuFCfB4fmhGJwvbUuDwTaQefpoSbhGpe1bXkDnLt2jqyyI0TSjYSzaQEZXsdM8cf1yIOf+xOFHtwB4nT4ndEE0bhuWbEuWPQAYiuUZhWnV2SNDjTVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835490; c=relaxed/simple;
	bh=x4S8ah5WJl/uf3kXxUCXe4tbYsSxnfK7JXcPCvJvkpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sUkhHLG+x+HPcdJ/teqH/UyF7Z8xQhelcCOKHIYPPzgnzvA6r7MjUv7jF1GhBsPw1ikLg0JxfU6rAsQ2RV95DUgDLIQ3orG5qnzl7OSwtSp7AGSlh+Nu3cOe4MrXFtdwZPvDbr7+O0nss61DmLO8pLrkP4scQuZP4EuS5rg4ndk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=kKJZfbK6; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59a45d8ec91so1500362eaf.3;
        Tue, 13 Feb 2024 06:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835488; x=1708440288;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/koUAJuOq2yoMW+DFG7xcmj/JHxhyhpssaBFm6eUxic=;
        b=nibEyAOe3VlauqWCowy26JEXFQFDS/AxcvkPgzTrhEQaUxQ5GD9BVselteBNsPVcXC
         zaCf00MfhTG01AzvDEqINs2vMQSIYVlcy6UmU/1TaMXvvR1usXAo+5AQi8DDq8im1aVS
         Zl9koCePhagtP+M3OrDpFnlkMfFMazZgorcmo0tFIWhey9IoKRaK1vnFT1jwd33dHggN
         yIF2n7kpzW5ewq2kAZnVAcBARB12gQZ+jZ+85arsJb3WEN4arVJ8z38A3XXWSF5NEd3M
         3IzGNp6ij6IgkoMJVHEjDv7cjphpkQc4XNV5nlWVHHvAZeEZF8VfMAuZrUNusAI2CN6G
         nuxA==
X-Forwarded-Encrypted: i=1; AJvYcCVUsk6lRqv4U7AJNNmozhp8S2FxclalGTt1XLdXsTGvA4g6r19izH4Q/mWu7FFoMX/kftPn59AZRDdB3LIm1mr0atuuoUvKv83X60JF
X-Gm-Message-State: AOJu0Ywg6huDSauVZgjHJT2S8a09v/PG0T0ifQIA4GSV+EtmmZSHMUAD
	m2KTwnM5dpLQ74nOgAcQTs/Ozvj598WEb23xLyyeBFTxg9U4zB7KGbZ+k1LZ+FPtXQ==
X-Google-Smtp-Source: AGHT+IHnFQiuk45vNF0lVylFWopt5oz7whr92JFPCkKu+Tr4MWG6q3MrcmlXlM4h/W8eU0CoLc0cIA==
X-Received: by 2002:a05:6358:8421:b0:178:c712:b123 with SMTP id b33-20020a056358842100b00178c712b123mr15223844rwk.5.1707835488062;
        Tue, 13 Feb 2024 06:44:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVi8lNIRqnvNp6eE79NasI+QrdXFzfVj5qdVdbc8JuSgsDzSQSoX93Z1za8+GqsuO78UzAlS5QRBG00Gb55EdWSrJywwWr/5Hg7Uni3zCjU2vffCW0l+JwiuUbDNBafgcsNgunriNwbaR8mpJsC6mUAKnp6gKeu6yC55s9uEQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e26-20020a65689a000000b005dc4da2121fsm2179737pgt.6.2024.02.13.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:44:47 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/koUAJuOq2yoMW+DFG7xcmj/JHxhyhpssaBFm6eUxic=;
	b=kKJZfbK66GtvPf5/yM5BiBy+9LYKsFzyHen3FiFkTDRsUPjSCskhnXbJSfbDT3w7wGYWQo
	6miamfLaK+CsQsGZVvE5hqrRoPk0ug56OHCduBOIJzfZXG4R47wyv/bItTujijb81r81P7
	7AuR0tSTxlACmpkM9EelL91wzYGXxj3BD9m9+bHKJSYyQ/bWPYxl2pOXOnlnJMll+lBwTJ
	5qUvDgtMcQY3l85o6JFXAG5s7yV7MQQHqL45nkqaTQaGADoceBWFGghYMBoV2Zqo9GJQZV
	5kig4cIMQup4/qstADSlUnzc++jfK7znZ1QdIajGqTBr7QUECCKIdmUzvU9aBg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:45:25 -0300
Subject: [PATCH] tc: make tc_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-tc-v1-1-5ed32393a73a@marliere.net>
X-B4-Tracking: v=1; b=H4sIAISAy2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0Nj3aTS4vjknNTEvNIC3ZJkXVPzRAMLi7SktCRzYyWgpoKi1LTMCrC
 B0bG1tQCdgL2LYAAAAA==
To: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
 Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1617; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=x4S8ah5WJl/uf3kXxUCXe4tbYsSxnfK7JXcPCvJvkpE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4CF/6PFxHRALyI+EbBY1D1/GBATSk0yLcJBD
 ppUuoSaYpaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuAhQAKCRDJC4p8Y4ZY
 pn7ID/4qHdKj/emUKknvnS7paINQ6CSK1Ia5Q6pDN9jGqs6+2kG7HBzsCg9rPoZ30QeO3hQeD3E
 af/FLf3Moi4r/VvuGG5EsZUnCHTRdJStO/wuA8UWFG/BI+qO06ACrdDSSd6JT072HVGSSJE9qEP
 umyTmzC+zLXtSnqg7JuUWpFlHA3wA/tD9dl1fNdjgjWQhDKGx3KPrhFzJzzVPD14U3bdFYBmISU
 LUDXDtP3f7PQtgvt3WtdODxuXVgKNrHuxhUnc+MiwivN8Cb2B7DCmURXHcTmIPwLRbITwgojowg
 nsz9v9USV9aq+V5ffnqZR5uZ/RvGX1rCmrzdR3rS4mGUJ6JOcwz+6UT3NmKO9F/rBeiO0NEsh/D
 +CAcjAZ0qWmy2PU2HvNnkv8ldh1Ml2/R9rOjP872DdxppTStA0nSDOBE3S58BflbJhtRbpPJWA7
 JsJpEp76kmVfwibiz77XwfiCQzk9VgyEiE3dsd45CUNe2fs6ONgT62tcocVW9SCHFzjZ8M2kxKY
 M8S3MGffQH5QjuBvl5aMvZ5XQSi2zd/E9V/29R1po+GRQBhnAOYAbBrOrP+NwWDVafJPloUVGVD
 rnwpBXY6jd0vC0+oyKHrwWYyap+5Cc4b42B4Xl5c65Up5lzEFwDTVoYHdzVwsU6L2yhn4F1C7Yl
 +NFeXBJahLS2fDg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the tc_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/tc/tc-driver.c | 2 +-
 include/linux/tc.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tc/tc-driver.c b/drivers/tc/tc-driver.c
index d45f2c1ff341..1c9d983a5a1f 100644
--- a/drivers/tc/tc-driver.c
+++ b/drivers/tc/tc-driver.c
@@ -95,7 +95,7 @@ static int tc_bus_match(struct device *dev, struct device_driver *drv)
 	return 0;
 }
 
-struct bus_type tc_bus_type = {
+const struct bus_type tc_bus_type = {
 	.name	= "tc",
 	.match	= tc_bus_match,
 };
diff --git a/include/linux/tc.h b/include/linux/tc.h
index a60639f37963..1638660abf5e 100644
--- a/include/linux/tc.h
+++ b/include/linux/tc.h
@@ -120,7 +120,7 @@ static inline unsigned long tc_get_speed(struct tc_bus *tbus)
 
 #ifdef CONFIG_TC
 
-extern struct bus_type tc_bus_type;
+extern const struct bus_type tc_bus_type;
 
 extern int tc_register_driver(struct tc_driver *tdrv);
 extern void tc_unregister_driver(struct tc_driver *tdrv);

---
base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
change-id: 20240213-bus_cleanup-tc-57a088fbfb73

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


