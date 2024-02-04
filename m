Return-Path: <linux-kernel+bounces-51869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84391849045
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8575D1C21043
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F37525568;
	Sun,  4 Feb 2024 20:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="nMS88LQa"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17603250F4;
	Sun,  4 Feb 2024 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077132; cv=none; b=IUI1jE2mQcIoeICSdVjP8pbNNmdp8qtdp2162su0q8UpdCnV1NQJqdysFz8YWimV7duWfKqMel6A+kefGpjbD+OJvYZCW2jX5PxAnIC54FLr5OOsqdq78Fr1dw0qFqEWNZOOa7o1qD2pcdm/Ma06GXC0kg9L0i4DxCIzdx1rZhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077132; c=relaxed/simple;
	bh=oEJ4JhtS0wXcYfKGUCUlUbO6a9vJjiMWTLf8kU8BVHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=duljL/31X8k098f5dOdJoKmSsQye+nV0HPlEy4IFN6PqeUpERmTBB+ZT8J17S0/8+MozDT0Tlg6fM2nHbV2QHsSxvx0qufsdgH99/5iCGf1L21Hhmt+pde+hTzFie5gGo/HemOx2Y407Jqs+O8+QDqsihqYQ8lDRa2s5RtnxB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=nMS88LQa reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d944e8f367so29244665ad.0;
        Sun, 04 Feb 2024 12:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707077130; x=1707681930;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mjI4Kmknsf20qmE5l06ItyuuAfH7RZdp4ZZ/sVgV8c=;
        b=bNMutOFCV3fPJ2LSGZNAfd/Fp2ra8nIgl33qZzc6aaRDM966O1mS/MTnXZLPMJPtSi
         qf1Edzr8UnVeiU1GsLSpz3S32DMex3EkDAD1AFUqCYZiL8gGCUFmDbhFAWviPxGdT+ww
         nSGRZRj2oX8ybzgh6mq4J8nEQocVS3fu1M6CMmqPBzlQmFvEKp1ph9UlI/3Jr2kKDYYE
         82/vLkyd3GVbot0jM3N30tFCEDHZOed09sMkhhpmFi+zRteR4za3+abD86TIdMIvKB64
         /9J/3pXe2YhIiJswK+DWEct7QTdxZsy1hw777KFmUnKLDnzCdquL8t04h0JHLc2OsV5Q
         9EmA==
X-Gm-Message-State: AOJu0Yw9jz7xPZTMWzMZSPAsNWqACzen74JEm9tz/qOxZsgL0eAQTVk7
	QI7Z8RQfH2u7odwGv7TBnP6EMqeenp+3CNznCEq94cKRPsC+8yTq
X-Google-Smtp-Source: AGHT+IF2nXTe6APFDAqxt8zpMBtpuynDrkZISSjP3itcfXtof3+GMWt+GoKL5XG07EFjbqte68+PNw==
X-Received: by 2002:a17:902:9a4c:b0:1d8:94e4:7712 with SMTP id x12-20020a1709029a4c00b001d894e47712mr10935455plv.29.1707077130239;
        Sun, 04 Feb 2024 12:05:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV/2nECvWWs7yf6LyQDJBSCXUWYtN58+qaB/IMRzSFHP3m3WFKgsphdDIeE0I7NdNORV+J8DuNxK9b6LaxjTjO805umDvI2wkdRtXfRkZwlpIPaRWtXXHNW8yhQ2Op+eNs3Co57rwtjJfUODg8KprWkJx0abd1mH3qSWEb1IlElSPhl9zSoFTef1JxC9TMfILpY
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id jy3-20020a17090342c300b001d9a41daf85sm1380291plb.256.2024.02.04.12.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:05:29 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707077128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4mjI4Kmknsf20qmE5l06ItyuuAfH7RZdp4ZZ/sVgV8c=;
	b=nMS88LQaiVxp9TvFogmtDAfJgW/92E5jJT3JCULXe1WqAWthmrlFaW93hAt1Hexdrv+Pgt
	BCCupuWZIT/6uRzEl7THqd3DuwjuvRWhDYhTrPXkiWH24PAiWio35CDCcstgFwM9yPX2OI
	Roj94Ci87j2xKb79+3hczHWYP7p4TWLvTQdH4xn1+DfpNaitAzT93el8GhgN2nJ56Qr7bO
	4K5f/aTaAgoBuj4APsP/6bLYfUJ8BIavzLjbpY6ktr2CUUanzcwcBGlGxhkX3lPvwFX/nM
	7p34gjfuCX7o6fVwae+JSkSZGXT2z8ZvGIi+HysQnBsCcIy9hK+WuByyiCfmEA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:05:58 -0300
Subject: [PATCH] memstick: core: make memstick_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-memstick-v1-1-14809d4405d8@marliere.net>
X-B4-Tracking: v=1; b=H4sIACXuv2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3dzU3OKSzORsXQNzwyRjUzOTFAsDCyWg1oK
 i1LTMCrCx0bG1tQB5OpTcZgAAAA==
To: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=oEJ4JhtS0wXcYfKGUCUlUbO6a9vJjiMWTLf8kU8BVHw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+4m2NDsQtytOCNt1FBI7M7m3IYnmNvEnr0QL
 3zc1VDvUByJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/uJgAKCRDJC4p8Y4ZY
 pqcsEACjeGYT6x+D0Voi3eEyiIzwhf2iNp0sJ1wB4jT55WDjl43tqocQhvYcasXvx5NDenknIXW
 z52RZLvVYsTF24Qmu4/q/FPZhXmsQ2+xEWHZDTJFZDQlMk3agVgpMygfJm9A49TJFjITFv4dNIr
 Yv+nZVHGRpKLHU8R5YYOl/zWhHLMc1VmLEoJ0KTHYEX6eAQvMeUPQMQmrWH6bJB7jkA3nGIypM2
 NE/KC4+pmRQ/05FXQU0AKqDMPHYKZ+AXR2vNZLZvl1V3QaY9bH7MlL4ZG4Rmmsr11QQez8vUhh0
 k2jEYGDFC7yDrfw70UeP93NEcrZ2Se0Ms4obD6x9PVOVGjkR1Ey91H6l/VIkuPsCB0n7jVAG+zN
 VrRaur5TOuuNOyG3rsxEu2T1YbCV+h+TlGo6xhHk7wack7wk6D3NDyY5gKf2Aoi40s8scdI/zR0
 26sUx5YSTIgbm5pX/6YeGaOTMLazGDuTfHsgGttPv9G4q+R+KljabVm+QH1baa8isLcnNKHz677
 ROSyyZjuogS6q6hJcjT3+rZ2sVETSPo3Axk++kpijDi4hsqrtK/zlMs+6xsXOjCisqWMiROPcrX
 i3GcfwoIHhfgdV4M8F7drY0PGS0F8HYO+W2mEPZl0+o1HEnYn7snPS6sUKvsxlfwJEBEBxQACjs
 vZOATeph0T3j+Jg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the memstick_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/memstick/core/memstick.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index bbfaf6536903..23fea51ecbdd 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -164,7 +164,7 @@ static struct attribute *memstick_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(memstick_dev);
 
-static struct bus_type memstick_bus_type = {
+static const struct bus_type memstick_bus_type = {
 	.name           = "memstick",
 	.dev_groups	= memstick_dev_groups,
 	.match          = memstick_bus_match,

---
base-commit: 4e99ffb173faaf38f010acb369bff57a20e9e531
change-id: 20240204-bus_cleanup-memstick-071b3564d808

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


