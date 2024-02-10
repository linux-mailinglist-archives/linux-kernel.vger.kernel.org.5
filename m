Return-Path: <linux-kernel+bounces-60436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB5E8504E7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8924FB2235D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5515BADE;
	Sat, 10 Feb 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="KVkQc3fn"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C32B9C2
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578370; cv=none; b=RCbcmoa1/pS9rXeuA6azfa1pJiMRkFY4yhiV+5ImAO/n49cKFnnNEmLJBYL8evgFZD0hgNjp/ReNQMJ1Ng4Q80ivMCEbXDhSm39WSBYo9jKzJZea8tmre8fHeslbw+QlI1GuJQ2tpJ0cePtOTSvBALXWjAjAYBgvfCo6hQwWkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578370; c=relaxed/simple;
	bh=k4ZPbdMBSpS74PR9EcxxOoA2GQUuClEk+6rG4wsBqpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GpVXXD/UGqnWH9QVOqTd62qvYIQhKddFthk7v1JPvMSPLJsVkUDnd4hB4TeBkpQWZjALBUmoBvT5gnEtO+I52+PFjzTv4P449RdPwbktaCqjlcJznZo3oTJd/Jbo5faKXzaBE7w8uWGRzKfrDi7Ymh4FMwBvXjXVygCQa1qJ1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=KVkQc3fn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d746ce7d13so16381135ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578369; x=1708183169;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsUsCEyhzx03i2SgArN/xYYk30AXakYcMi5W1lGUnSs=;
        b=rFaQ0GLqv5zkJgx+1/fTZ2OupjApowIWM+EkAw4QOb+Jf7B6txqssPX/1ScDggh9se
         LnTgWuV+KR89yRcqc6R+yowxdhtCSlelesEtt2v6pUHxvg+YzjFlOKViVj6deKRzCcXy
         k1/bAxS76sT/8KuiF+nZ/yH6UJZ9brXfnd93FwRagFs5B7cRVqWrUmLlAYrIsYsELZl6
         BQFi0wkUe7K252pC6ZX3biFDSuYPyK2NbVP7W+szlV0jqSpkSZL8v6shJLaK8ewBfBQD
         c3O18k0U+ZEuvucx6zrOJ8AbzA3f+AiGyvcbbYGaGa3+TZ34QG+NAbmmVX5pqGLJ5uc1
         b53g==
X-Gm-Message-State: AOJu0YxJ5PjjeGkkG3vd4EVxKbSd/+LAu8Gjhb6C0XUZnMLr9qx7TYv0
	guzgdV815stvm7d8xHy7AkdwK4dyL7FS1GhaiPMZUnFt/xk3DHA1dZqTkctRfHENjw==
X-Google-Smtp-Source: AGHT+IFSY0jhWg0y578FWopUbBCr/50dclMYzaGgQ2cBhplPmJvNWnyp1dplcOLwT3mz+DKp0awb9g==
X-Received: by 2002:a17:902:d48b:b0:1d9:b5d8:854c with SMTP id c11-20020a170902d48b00b001d9b5d8854cmr2735292plg.58.1707578368784;
        Sat, 10 Feb 2024 07:19:28 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id km12-20020a17090327cc00b001d8ceaa1a5bsm3162339plb.304.2024.02.10.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:19:28 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707578367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UsUsCEyhzx03i2SgArN/xYYk30AXakYcMi5W1lGUnSs=;
	b=KVkQc3fnpv/4UntLdU+ycqcqEIHp59ZGgnmHUJPimIPCGGJyqKVgQRaOwemVns8CsY+y55
	hgc8kq5i3HAT2I1iZ6fl68woP8Nt/GQnJ1dyeaCa/HnsO7lFV3vzzTquXfaj67Tg6M+BTP
	5kqWbiPXLL2062izL8wmXs00h9CLPkvpyxchkCwJgc4MIKJk92Wsyc7Ji/FtNef5ihIO+z
	mr4P3QfpKOt3uP7LOsoNOFIGTHjUEsjh8MWYQ0WvkYFlr1S6TgJHqQYzqQ8v98T3nNEUj6
	yCR6PtgZM9I82F5ios/CMgrdy6cv93J+tFvRLDYO2USJ3gKarXU1EL25vrHpvg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 10 Feb 2024 12:19:44 -0300
Subject: [PATCH] EISA: make eisa_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-bus_cleanup-eisa-v1-1-279725834456@marliere.net>
X-B4-Tracking: v=1; b=H4sIAA+Ux2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDI0MD3aTS4vjknNTEvNIC3dTM4kTdVDNTA3Njw1QLs2RTJaC2gqLUtMw
 KsJHRsbW1AKNsQZFiAAAA
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=k4ZPbdMBSpS74PR9EcxxOoA2GQUuClEk+6rG4wsBqpY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlx5Qjc1v243sGwqJSvi4cOPbN+ueE3fNqxVbpY
 XlI+VFR+ciJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZceUIwAKCRDJC4p8Y4ZY
 phFnD/wLQU+oRDf6fXN21VBjbIQJzs7YIgBIYhl1igwkXVuK0W20xiReLT4ZzrGCPXWZU8KEJ3U
 COiiNTlW/IXCFzDc+kSKW4AsSzthMli/s9Y/cDGzbsICb5/5xMxPNTjx2utKWLG9h8xgOC0MZYM
 CnlnUFAPX1BuO+la4nsZJpd7rH4+wSvwB8DW2oLbHYzU/2bJBACqU6CPtcRYnoeMe+xJLRjNxdb
 zuOgPv67KF048YH5yA53gn4qZC3p9b5jM4+boDphOY8uvNWS7aVUuU2c17EjeWPeb911ft+/+Ra
 sSnDdf7IyVmJ34tUfSRbjUCUAEh6PhKTYbBFnw8WQrujOCN/J/Mn1Bjjj/haHbB1sNCJ4WeTpLC
 YtMfIfJKn+HQHLwYkO2wrreMfBA29tqG1LPzlxHQTdCL4bj6HuTWV366yH2TMObfqWvtR0Nn+xx
 nJQyEuM2gbOYxisx8Go/WcTVzGmTO5HUkRbYnqqpUhEeGG8FLpLfr75PoabQVtqITF4Du6Tuv7a
 Dsrrs8CpTvGhry9qfGrcWmBxUy1qRby/8xjh1ONN8ZxIAtMqPRY+7zicmLiOgTwuvJl8dahI8oC
 uUoU1eSm6zS3i5cpRZuya3nZP7iN4RDD6ay74QhkZ57qLKuwjBDwF1+H5jNCLtWn6ErLUBfofow
 XGcpnU43SEJuq6Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the eisa_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/eisa/eisa-bus.c | 2 +-
 include/linux/eisa.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/eisa/eisa-bus.c b/drivers/eisa/eisa-bus.c
index 33f0ba11c6ad..a7723536412a 100644
--- a/drivers/eisa/eisa-bus.c
+++ b/drivers/eisa/eisa-bus.c
@@ -135,7 +135,7 @@ static int eisa_bus_uevent(const struct device *dev, struct kobj_uevent_env *env
 	return 0;
 }
 
-struct bus_type eisa_bus_type = {
+const struct bus_type eisa_bus_type = {
 	.name  = "eisa",
 	.match = eisa_bus_match,
 	.uevent = eisa_bus_uevent,
diff --git a/include/linux/eisa.h b/include/linux/eisa.h
index b012e30afebd..7277d450e092 100644
--- a/include/linux/eisa.h
+++ b/include/linux/eisa.h
@@ -65,7 +65,7 @@ struct eisa_driver {
 /* These external functions are only available when EISA support is enabled. */
 #ifdef CONFIG_EISA
 
-extern struct bus_type eisa_bus_type;
+extern const struct bus_type eisa_bus_type;
 int eisa_driver_register (struct eisa_driver *edrv);
 void eisa_driver_unregister (struct eisa_driver *edrv);
 

---
base-commit: 047371968ffc470769f541d6933e262dc7085456
change-id: 20240210-bus_cleanup-eisa-e650731e86c5

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


