Return-Path: <linux-kernel+bounces-51775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0A2848F2C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AE81C212D1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839EF22EEF;
	Sun,  4 Feb 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="CKOk89Wj"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972122EE0;
	Sun,  4 Feb 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063218; cv=none; b=FIGuWBXtX+hYiZH6vMJFWUBGaLP40EdogcX9NSv5ybwaqDkv0WRyRNponuHbHRRX2n5T4EMcWiThMYYRZ7GP7LsJ8KuXMoFdzVKt6f6vUxZgC7E2ZTxwFOCOUXEEr9V81ZkXhwIq3vJv5YVzDCrJtc+Ovbt9UjF2hStPKJdbJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063218; c=relaxed/simple;
	bh=TgShaFHPoP3Kn1TopBdrlrcCUbL7pn3NVxXgfCNsZ/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TDcMfFTkriH3rV/cFuetxg5wEKsES4Xr2+pIbr/ScVohB41aBOz3gC3t7+Gf3i8MhYz0sRm4gVraBUToWlpOlqm+e84A1f+i3IXEVTd2oo8Vlo02KV6BOGk/G32fdw947I86VgVpotlqLpU6mYu+OhnxyzaRhB5wANOwF2HMXMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=CKOk89Wj reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so2378574a91.1;
        Sun, 04 Feb 2024 08:13:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063217; x=1707668017;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j895wKcHeXQZJMdGzfGU+B0tFjcF0tffVFSqSapa/yQ=;
        b=eTb3rWQ1ID02EynVC0A8yL+gzAYRa0XLiwR4lEkHfqLZZ307T1NXkWhPc3paiJap6Z
         kJwcK5fzJSBxL332lL3ZaLzalLHaKG9N08a+e3WamiNIOxOYEIfvJ/zcSy4gJBUqB++A
         P4SsdtBP9GUfq2gcD6POnVLJHEqBnCHLMwgdN34lHTN+NLyrtm1JrPrivprTWLLNfzYZ
         I/Hplw+idWGWm09Yelfwd05N2BiYjv/a8OIPi1GF57dfIro5nq9t/fQixgAVeu/k8kYO
         bJi9jJQRKJwO/DzZaIItxH9mdaeq6aSuzFy7vkbpzVCnZTPz23CqS2jbeXILrFqdsrNS
         +aHg==
X-Gm-Message-State: AOJu0Ywy3vECWB9bBeU9jdH/wP2bV3ypf2Btt+KmNr+BXxI9zXNnq/YF
	qs3Jj2FNFAOunvU3WrTVi1D997uqJoLtLaRd5VecvmMdGxx8fyDs
X-Google-Smtp-Source: AGHT+IE7wftt5fJcizab0kosuFSovjbMuArVg2IktHPYXrVXjlsP67gFbimtBhExDvESA7jQicw3OA==
X-Received: by 2002:a17:90a:f48f:b0:28c:3e2:2d8a with SMTP id bx15-20020a17090af48f00b0028c03e22d8amr12143414pjb.23.1707063216757;
        Sun, 04 Feb 2024 08:13:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQpIItCKC4/HggsTvDjo0xAjnl48o6jSC3Nfo8ez6+5H8nuSj5eUWxjLABSD3usb22oEFQgZMcbjq2YKh3iJV0noz0BhC2Rl+serF34uMj4K3xQJ2G70F/b8DkdDXXvTGi8AoimFy8CHjTrsja9jvyHWysJtLrwTuqVWjtg7yHUXu6bMLFHYQWyRxN6oKu4jBrLMkSenHVURtUe95M
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jg1-20020a17090326c100b001d8d3b94404sm4709310plb.137.2024.02.04.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:13:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707063214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j895wKcHeXQZJMdGzfGU+B0tFjcF0tffVFSqSapa/yQ=;
	b=CKOk89WjQlOhcXFU/ySoTySlPOYLXIg2LIimX62ojk1MB5KqimYWtUX9DJ2wdhN12RTq8R
	UV9Y0QvRIT7uOqe3NNPQS0ws20hhUOmJP7299aCy5OMUSRdxkDMqdcXcH/nyaBiBW5j/Ao
	f/LuXrxcYOc0BmwFgLTMuQlMwe6Qun1ZNNZAP0D5rTxD+Z6w/z+Avvh2WMGxTvnN9TAmFM
	ETT13fDkpiKJUxId1JL5SMhakTOg3WkWk0kRQtihFEx944A4w2M+DBM2U72m0Qfby/B7RY
	FvHJ6s/p8PJjjT9Af0qQ5XbxXvAs+hbYqi8PwxM3ak7BVVvx3fM2oC4Jbf0DQQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:14:05 -0300
Subject: [PATCH] fpga: dfl: make dfl_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-fpga-v1-1-dae8b5bf7220@marliere.net>
X-B4-Tracking: v=1; b=H4sIAMy3v2UC/x3MTQqAIBBA4avErBNM+6OrRITZaANhohhBePek5
 bd474WIgTDCVL0Q8KZIlyto6gr0oZxFRnsxCC5aLnjLthRXfaJyyTPjrWI4otRy73qxDVAyH9D
 Q8y/nJecPURkuYWIAAAA=
To: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, 
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=TgShaFHPoP3Kn1TopBdrlrcCUbL7pn3NVxXgfCNsZ/Y=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7fNm4LCLEaZHRrxilHOODNiUcZydOc/yohJU
 iBzzwwA0HyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+3zQAKCRDJC4p8Y4ZY
 pm7jEACJb0uv0JqkxMe2d7g/ah6Y6i7cCaXIC8eyG2pFX0dWNYfpfXY4DAJTzuz+xGlnSpF6eSl
 sWBma8Kv7oYslPVXRJyC8ynMo5auW7iQheR3DLpY8Z7HnW8BXrghvR/Is2V9cZzJK828vD/eejU
 OCRc/FhDZaLrRgZyosHnU9zD5299lRfSRtnAhrndR2bLIGE1bGvIrwir1w1UBL/u4/VUbssFczp
 n9pbO2j0LzVV0jlKmc6ONmr8rZ0Wv8fbD+qb5s+02L2gFd9k3MnB6QqOxndb9/11D+Ako/orjUS
 6GZ2xgPkvDfroqgBHD96d/54zQBKsq9d7L3yd4KZyMs5tMI+WQLNnZXJofEWRMAgUtQ06Y+CX8x
 QBae/0sLLTc97GUozedbYHC/mySDa8lCy5Ivk06IYmnIEy1U8HsAfpVc5LTlz93h0lHjtm2H6as
 3kR7xM6aDJqOrBtr6l1DZ4pg72G2cNOgUv5DKOAI5pTbyZP1f6tv87ZsVCdXxHXX33Y8r7Lnifw
 QetAliHzNO5xkq7OvC+D5PmqraOgY7JzNKaqOS/GV599Q1HDgHE+nM71TT9xAdrbP+kfJm3YLhB
 nr73nICL6fwkqK3cERZbAQlQg6xWHQPOsizbYbf9ndYGz/xkSvCjwKTrC/MWcakBt3OCrVxY6c/
 miIr8pAYkhpTsrg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the dfl_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/fpga/dfl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e6d12fbab653..094ee97ea26c 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -327,7 +327,7 @@ static struct attribute *dfl_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(dfl_dev);
 
-static struct bus_type dfl_bus_type = {
+static const struct bus_type dfl_bus_type = {
 	.name		= "dfl",
 	.match		= dfl_bus_match,
 	.probe		= dfl_bus_probe,

---
base-commit: 8680970410625875c34d6b97b6fd89d7d62a74ec
change-id: 20240204-bus_cleanup-fpga-e8e3c3d562b7

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


