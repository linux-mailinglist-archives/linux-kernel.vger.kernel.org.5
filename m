Return-Path: <linux-kernel+bounces-51875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E7A849052
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6320A1C20DF9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180825573;
	Sun,  4 Feb 2024 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="bfChfQ5z"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4382555D
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707078145; cv=none; b=YSibqBnzkaJvj6LxfZAunJBCJFm6ZRkVe5aFAldJjsa19sZkmrcU9yjRrrH5io03cYXCmIghZD1hmdfv8C8Kto1jfBRo4bs/QxTNB/l81DzjwmZFF2PW7rttXxtHZe62+0ez/GNVks/KkoD1tHhXFMkerQD5NK3AXHYTpsCIcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707078145; c=relaxed/simple;
	bh=pbja1kS4RfuggV1C3llqAFdUk2mI4pujWIFIfEBHCJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YVH29lzus36OHN6OuFJQtvYHpRtnCPBIUnSpcmYgp/jnkqNj1oW6D58ZOExwmN4hdehsz+6aNwyaGH3aCp71Li5/Q+eNXloZWZFPqUYr1Cj1SXD069mh/P6k3EGEMRs/5T4QNjSa2uBudb1pYKRiYbc70+7CrbHs0WthoiN0heU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=bfChfQ5z reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d934c8f8f7so30717955ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707078143; x=1707682943;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9C3N67ToSHDZfAuF/i9tcOkChXWkO5qsLRtj9jLQOo=;
        b=ZjIHukTHn1RKHeTe0Jckh7dqKxXRNEsWdoz9NV2SJc+Of7JYv5pjtwMo+j4oaqk0Wz
         ll/3JO3In1opV+lxXVasg0PG0vtzYkrYje4iZpnIFA3PFsi8ibMwSlzU1fBCxL3hZbcA
         TmUq3g0PIrEjMTLgHLS4HJLWrl/h7a4wDXuttGA849UemdBlTQYBsJCL5EtWvD9oc6pa
         IiZ1kzFP4SDEeVxzAmmlzkiE8S2XzI2Vs5SDwxN2PWNTF5kboT+LSNgoxeQ5AJivdA57
         LAYtExac851c34qk3vatqHHYEu6iaFlvLh98tw57pDK2R5D2JmEqwbv+g/ODze5eQIjK
         NHcg==
X-Gm-Message-State: AOJu0YxI3sglAatVN15sB0io4x3Q0J3tj6Zbz4KE13OYqbIouez75osV
	hO0gDQGHOGMltTn0PMSvbeQrwcwzLqSHU8Dea9Bnsko7DSWhwNgg
X-Google-Smtp-Source: AGHT+IFSDCw85qFCFDnjtE7UUt0fZJ99Mu2Qi1ObpUbCqN0woTxR5+3RsAo3vaUKOV1QoWw+BbMIig==
X-Received: by 2002:a17:902:a3c5:b0:1d9:586d:5d81 with SMTP id q5-20020a170902a3c500b001d9586d5d81mr8642056plb.47.1707078143440;
        Sun, 04 Feb 2024 12:22:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUsVegiu8eWCzCREFl9hyigb38rVNWkL8pc3HUH/H+yZLcTYpXkDi3mqzJT8ht0IZxEPnuhtjGE0QRctsjWelUjn+akqFK1DHKmSg==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q66-20020a17090a17c800b002960e397891sm4880832pja.1.2024.02.04.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:22:22 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707078141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f9C3N67ToSHDZfAuF/i9tcOkChXWkO5qsLRtj9jLQOo=;
	b=bfChfQ5zl/nJ/vWNlU4t8+mydi0dMpT+fC7P3hlyQZkPAO2dk+Q9jSG80nBi3U6duIQBRM
	I1ZjOx8mBEtbg4dLi3EKXv/zZ6y9/TXeLTEVLiI30yDf+SSPi8QyHCx1w/MOu7ezalCq+p
	uWHtnSa2JqJWhS9rgkuFiNhRrOwt0tdxSVuMkxslEIOQ1xNY2nD4V9KJ3hCQuxo0r9VHgZ
	8cYnwMyMWMVDdetzWidC0pVTq21Pe7Uw0qBg/14UuZfuQxXGC1ainQAYJJfI/jXt+e81XD
	k/NGUg3MmXvtSEESCmzXDGRP1b/bftjWfc5V5UbWcH+WpwnWW9gXI+bDbwXmnw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:22:51 -0300
Subject: [PATCH] nvmem: core: make nvmem_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-nvmem-v1-1-21775783d1d2@marliere.net>
X-B4-Tracking: v=1; b=H4sIABryv2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3byy3NRc3UTTFAtjY3NTQzOTJCWgvoKi1LT
 MCrCZ0bG1tQBtqVa1YwAAAA==
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=pbja1kS4RfuggV1C3llqAFdUk2mI4pujWIFIfEBHCJA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv/Ica6EdA1fur4KJGsHqpEVogekSL6926k5O+
 izKDhG4TbqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/yHAAKCRDJC4p8Y4ZY
 ptt8D/9V/oWkdzKysfSHeliD2yG+bAEJv87oT7xraj2RzrxfB/k4SUBHLEt9lFJWxc0dBilE9oa
 U67m2Vx/3e3VcLi8o4zXiFtUKTRkaERn8wzXue6Fv35+F6VXbKCnMBLFXiSRYO/TgC4CVU4qjbU
 DiWOXdDjWJvcUETid9CPjfFtcl+wzA7zDZHcnffJDGVIPFqxI9h/9GowCF+tkjAdYG/4EJqH7dx
 mZdUEjZkYyMFje9WFbqY/jVm217OX7WsbyK6z32qXO1vRqsvtu1AdYKaULJTINYCAB309Ml5TVD
 KO/aplI5tlG7m+TNO6u/TTSRvwxJPfFfF7j/I9v/9h6Rq9+hGf43HPZqBl+NW8KVeMI9PkPb+fU
 GNOdWm7AM9FFuU/ch5mBY5dMI6ayPelJMUmqumKbC1smLgMpO1mSvNI+hFi1/bZRTGVmz8s0/RZ
 9vEokR7fUpmwOySbmtueZXLTxe3Vky2eDjUzVyi3tnrzXSZcn3MOS3Wn3FcIG+d2+Wr5Lh9pSx4
 WMgjyOcNmJzmSOHMfKFIn/+CWtsDpzCQ2RKuxX44qOL/LUVZv3mZiLOE4rEM187auVTBXlS29RX
 E9b4JdifNxQLPz5zF4R0GSTfVix2DFaIe69sBdJSWAi3Eq+Bb65QQhRFuPysXoHUpQMFWeA3+dJ
 byBGTfAuPtqrc+g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the nvmem_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index eb357ac2e54a..5236f11d4700 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -517,7 +517,7 @@ static const struct device_type nvmem_provider_type = {
 	.release	= nvmem_release,
 };
 
-static struct bus_type nvmem_bus_type = {
+static const struct bus_type nvmem_bus_type = {
 	.name		= "nvmem",
 };
 

---
base-commit: a0cfd5e997824d0bd8c7620d40cdb324121a2fc7
change-id: 20240204-bus_cleanup-nvmem-a5d83375164b

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


