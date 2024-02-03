Return-Path: <linux-kernel+bounces-51133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F70F8486E8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431601C21682
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6355FB8B;
	Sat,  3 Feb 2024 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="d2fmhnBD"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA4E5F873;
	Sat,  3 Feb 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972281; cv=none; b=uubWj0+qCLQxXOEo3kzjhVKpK72QjcT335NUrblEKVh7rrS9ay8mI8HTgosEYbrfUGa2/gvRGli6JucjLXibcs6RCbeOP4VHasqmYBNI9erjGBss5c9m61LK2Z7o8UPG23VmNXJIw3j99i3QY4ayMD9Pzuc2krAfOPzl3yzOGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972281; c=relaxed/simple;
	bh=XfMRIcTFkq40BrOrZH6lSf63vQbs1uiK9evV0K5853Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hjzd3W73iLB7LsECmQKs3g8iQBRHwOWkZtPbbUnHTpjKR6gt5zzUuWjo5CUZIcJw9ictMGKLUGMRlWoQZe1zCANlk7JA98DgM81hEbXBiYbOPhx4iIPX/tNR5Rhd5StbI/l5NpVzxCZzMpoVtyW3CKwwzw0sijtb5yywB+Z21uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=d2fmhnBD reason="key not found in DNS"; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-214de82b6ddso1981828fac.3;
        Sat, 03 Feb 2024 06:57:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972278; x=1707577078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oa9DpOGPb7kCQUjh1d9Z1lrJmg3QieETmat4zMwZaek=;
        b=I9CJZqbAtrug7JaqzN0O7bZ4t4BrxxjdM8Y2Fz8M2RWtdFzAMpEUim09eabLfbdW4s
         5+Jh72opZtEGj0pQSNRu+NQd1IlgLAsT4hwOLcE1uFJE/znKbU8iLUpxpfU4izm+oSM4
         t3YzXlHKFDwultD8UpWwM/C5R/74gtazDf+tHWFfuELYuvG4b+vzDvKOnKt6Npm5Btiy
         GZMML794Z5CoQsKuArM5lc9nJcHsY76go1u7fEWuWAvsJjHC8It5fxsburPFHh0Z4wjP
         Y0U6NLEZPEORlvBIjv21BYBoZGHSLoIldUkH5yIbZzYz5gxeQ5NUjTmBZxogQ0hsSVSE
         fMoA==
X-Gm-Message-State: AOJu0YzAbXeAJhUUJ7qqkXRvuSi7oiG+VpZhYYKKAGFP+Ab/2anoyOW4
	6vDiOP89hra4CL8zpWxSl/HFo7dhZ2z2cZk1yCxXyTBbnXPZ+tdxIYejPRKOd5noKg==
X-Google-Smtp-Source: AGHT+IHEnP/z1IQkk0JTyayq8AkF9QIA8AtgzvcEQhUucxrK0lxlYIrJoj7P+ISajM8cwv7r/290Zw==
X-Received: by 2002:a05:6870:798e:b0:218:4be3:810a with SMTP id he14-20020a056870798e00b002184be3810amr3296631oab.37.1706972278413;
        Sat, 03 Feb 2024 06:57:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWLz+Xavg0MsVgD63uQClS4ifCV9FT65BspZ+00/a03lRADas/CyIWW4jQWRpQ5etDq+hdTmqupV8EhN5R+lSTq4xyz15tqxH+asa6Y3ehYLO0pff5GTY9viL+5Wiotnx3y77E5TX6wwsf1NkqiuFsEXenWcPGIvSpIOY8TAcl2r3FmeVpj5/yzZjMtqstw1OnKoANLoX1P/7LjpGy0uI2koQweT2RR6ztL3nONEOETMwK08P0Lawit2lMAes2EMU1QC1XqCcClsFDWKlOboVYkxoANJGI6VjTTDJlpdv38fa7prM0ubEwf4Xzp+Jx7pkV1cJ6l0hVs/4iXFx57LNEWlZF7AioYbof/owre2KCgu/EWVijctO+voC2gDklZBBu5T8+HM0SspVo3E69UvY1oCsDfc+qBx6kIw2avt8Rr2zCWcdJG0L0=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q11-20020a63e94b000000b005d6a0b2efb3sm3665991pgj.21.2024.02.03.06.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:57:57 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa9DpOGPb7kCQUjh1d9Z1lrJmg3QieETmat4zMwZaek=;
	b=d2fmhnBDYkT+1ZYnDEFkn7sFCepzhGOxcgWS36kIP/PcoIPZtPB9o5GCyPvoYMmDT6qiyA
	SSkQTMHTqEYwjGusZvM8X0Krfhj2Rq6MgCqVCj5AF0ZQ7o/QjYBKzXCtAOjehTF3ewEqMT
	g5UV1xSYoyIX5SFDsxaWYEWucnxurm2ALwB6DNV22uSTqNsRMSu9eUMoOCejdsfJ6iWqYc
	vsoURppwZ3ubyx6FiyFt1+LvZBrOvRkD/zKYZxGvyMHZt95RVgPztp+ndiTX/M7EiVsxlC
	24XFG+4dV0+PrjuVZj8cTzJlLjDUR6/F8fuFBN0oTmdNGdomcQNbs3+efngAoQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 11:58:02 -0300
Subject: [PATCH 5/6] s390: AP: make ap_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-s390-v1-5-ac891afc7282@marliere.net>
References: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
In-Reply-To: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
To: Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=XfMRIcTFkq40BrOrZH6lSf63vQbs1uiK9evV0K5853Q=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlSAHa4JKQqmQvqEspm60tMGiVhdwRwPFM7/p
 wikSsO/SluJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UgAAKCRDJC4p8Y4ZY
 pj+1EACUfPFiSEKyPzD9oK7gIK5boc8NXCEaU9G5XqdDucJSvUSLS3ctA2nY7ihB+tgIVk42kij
 PC4noq6SBSKdPAtYuSumT0Q9+VnpWsd+FreHyfB6dhZXx2DKYk0NYI2fFjXkTYUo9iBGTZbaoNl
 i3Gxu9LfZGmc4djnqJ/SbTUaoPlnZdicrEmymCbOHiXDqnr35V+RVJDjPsA+082CZK1Tl7bvBrm
 CqpwbiVQ1R5D9I0sYxZUgmxxPSVsb3+OJ97PDc2FwSZBtmBmkk5A/RBRdvCftCuG2xzWC1lrCQP
 Zco/306AeXNz7PaqbYPIAN/3cVKRefk1198Mbfy1dYut/tMjgBitih6ALwjHV9EKen5VlBwnXkA
 oT72JbFcQGctCyCKOTjIVrweWGL2Z3evdQLHB1RgcCKBFKdouoQZtx7NOOhriIchajXxhp1fzAb
 hozfeqehUFfrrQtjOmvDbn/yT2R11BCyS3f24hV54d2CPlUeoh893yb5hBmrTol37G2M4cEMV0V
 6O5KGWf/MZhl/LyG51xrEHzZFYXQEGXlTO1ecb3Q2mBrSAyhRC0nDBsb2vpVPudcDWO9+K0Q+yi
 I1dGfAsprqy0ViVN7uL5nsAm9xcx6odmfxtmeGpukM6UapEwH2aISf8hOp9BvEGP6uTG7odD1kA
 3Lhy2X9dK/wZ5tA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the ap_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/s390/crypto/ap_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index f46dd6abacd7..2ecf4d36e78b 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -135,7 +135,7 @@ static int ap_max_domain_id = 15;
 /* Maximum adapter id, if not given via qci */
 static int ap_max_adapter_id = 63;
 
-static struct bus_type ap_bus_type;
+static const struct bus_type ap_bus_type;
 
 /* Adapter interrupt definitions */
 static void ap_interrupt_handler(struct airq_struct *airq,
@@ -1603,7 +1603,7 @@ static struct attribute *ap_bus_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ap_bus);
 
-static struct bus_type ap_bus_type = {
+static const struct bus_type ap_bus_type = {
 	.name = "ap",
 	.bus_groups = ap_bus_groups,
 	.match = &ap_bus_match,

-- 
2.43.0


