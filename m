Return-Path: <linux-kernel+bounces-63711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8E853386
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380DB1F29656
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905D5788A;
	Tue, 13 Feb 2024 14:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="oA9hkv2L"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A722319
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835692; cv=none; b=oh06xgLL2NR1na2/0EJIzM2TY4f8fumUL/HesSDlAHbe2lkSg6fk6+Kgui6RV+Afkn2mltg0RjBkBV6PpcfwWQ75hx8Q4N2OrkmY0XheazHnA/qQ5BSYksdDrfnpvxo/aNlB+FXQzX1FPOA/7K4pGCardCaKrHYlOE/LKXjPaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835692; c=relaxed/simple;
	bh=BMmZXsY9H/lvyrF+pWUwVVNy50Ddcy1WXYEU8BYOimU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=btHYnS/mLH8YtaiulXlS832lTpmjehwy8ZSdvVPSSK+P1R3BKdQGPD41jzP7ZRo+ZatRRsaC7MY2OgkO5CZZq186WzUwFhF/Ws5G16TRiHbkbZSHsD2f7vLgU0Sru62WHEkQPyusR+AVXHLjs0pEmsPxvDMrN6hXckMAnOC4w8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=oA9hkv2L; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e0f5934813so770199b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:48:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835691; x=1708440491;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVD0TL5FjdYCE0fBI4VASK5HAhJZtTxASORBZv/qreY=;
        b=BeFN21LDR7dp6Qb7/ul0Q9+VKzJqDkmDqBfo2J1odmViU6BCgIdbofGJQGA+Vf3DnA
         3wKrgeRqwTRi+5enMEQ1Kpbq3jev+8Ow1miSZ6kYkUSZnBylmIb3QOoFDkM/nXpdxoSz
         a7sh0EyuSzKlj9pch6o1VCtoZnreFkZsCWxUOxVihnh6FE8L62mrhR7FdZjAG/+qlZBT
         hCnA74NdyudqnPbSV7Czm0sckOYzB6lMDrBlW5WaZWekwzFXmRGnixDsO9YwUIhiGYpj
         QVeQC5sq2vf/+EKRMaBUAmKGpKgog9Tf3iKt5I6Ik1vKXTekOlsYjSrbe+Nv8fDFtFLw
         tuJg==
X-Gm-Message-State: AOJu0YzVeYFlgye4zr79YFbC/2XwEItwSbPZgrYRz0FT8X4iofGOvudt
	8oKXaNAtq91+QCecgK9hzJdf+YOL6Epum6epskID7WeeG2KlTGri
X-Google-Smtp-Source: AGHT+IECnu/j9/fvXxxGTqHpighrGZlOCpO69z2SljbWvAfKaP09QeyMWz6oXTadisj52swGHwUOYA==
X-Received: by 2002:a05:6a21:150d:b0:1a0:5fd4:7987 with SMTP id nq13-20020a056a21150d00b001a05fd47987mr2294824pzb.29.1707835690753;
        Tue, 13 Feb 2024 06:48:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLBNIOd86sXkDKDYZnXWN1qEWVSaeLwlDsTuy1cxAu+fYkWlb9dc1FEqRV3297pu9FwW7RG5vwZ6So37JwnycW+Ejtj2dhEZmOXA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ei8-20020a056a0080c800b006e0f438e9aesm2010654pfb.63.2024.02.13.06.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:48:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UVD0TL5FjdYCE0fBI4VASK5HAhJZtTxASORBZv/qreY=;
	b=oA9hkv2LfmXaG6d7RkUAkqBLxdR81QppWXBaQJzeVDyjVsxcsCuvwbexKDquxborKby/It
	u6GsDbiMwvYHpa+gErCXgfwnWtIUT+g/Dn/w1bDsP1dEAIA0d5sTosTpHM0aLK2D+VR8g1
	yL+bhFud19KEJTz/QcmV53J8/gMofNV7zrizUoadJThd06VL0jg706/7bKxb0youtMdbYo
	m+IWCJLmAR4lyb+8Fpggb3yHOkwEmyq4g5qEtTjwUkL1A3Q6GfQ8Wro8ZY0sf3qyaAbeV2
	8/mAGvCv0SGILHRXmHJC5rEk/7777DjX/foiTi/hN63S2yPwWKOdfhuXZkNaeg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:48:45 -0300
Subject: [PATCH] pcmcia: ds: make pcmcia_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-pcmcia-v1-1-97273c37e277@marliere.net>
X-B4-Tracking: v=1; b=H4sIAEyBy2UC/x3MTQqAIBBA4avErBPUor+rRIRNUw2UiWIE0d2Tl
 t/ivQcCeaYAXfaAp4sDnzZB5RngZuxKgudk0FKXUqtCTDGMuJOx0QmHB7IRqJq6LVHW1VJACp2
 nhe9/2g/v+wG0KQr2ZAAAAA==
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=BMmZXsY9H/lvyrF+pWUwVVNy50Ddcy1WXYEU8BYOimU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4FQsSffny5hLZAhRfYsdrNJgWoZxkIM6cleO
 8BNQ8bsKu6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuBUAAKCRDJC4p8Y4ZY
 pu5gEACa34R2eyM69Kw8vKORlS7qcSqbmvj2te2/ZQJdKlgzWVNgI55I3AjTIKEW30Xtdu1soIQ
 SyPLDHfE5sGW1t1QJnr3s1QlCMd9x3k8YYSeQ7UAS+KAH05WL3DbVbu9stTSErfT9uVkBHLLfTR
 Fr4w8bo0nzcSLz8rRhYID/oNXEOY9f/KUdIL+qLyjBAn7KAjhDTJSEC8ZG/M6ctjRDPN9N8fqZJ
 Ix87w+SrzgNNNXOds7Sq9p7DzvaJAwPlnD0DBeEmG0jkVWi6pG7mPvRXIS7pW7cfMrR/QiGZUHa
 Ouz/TtVSLo/gIHFmYXfjeVlvdr3jmZiRwINX6ArVM9sjhaZfMvZshnz1LygyHxkSqBprnIQvNID
 tvXG9co74d++JKrQ6fo6Y6yvzapBmc03rAzxYhPZiM9SC8bdMzGJ5jGSC/W3vsg0f4N5mBljN6C
 DZ/S5IxeYYg95IgDRKXOAnk8nySKkmprO5Zqb4o5dNnGkYepqqycZMDeUxVvfqc8+cqm9TOBayo
 FODIpt4QErS2jqUfDXuiIhbf6ZGvqk/FCfsr2QJ8z8sIN+gyGlHXvUd4T/jmDYKVjFSQEwPPb7i
 0tKuw9Rw+TSMhf6D80ZNuNXgpaQ+l3KIc8/BX9kk5YjgXy/jy2Dw5xlQdmla+lFPFOpqq4e7CoL
 6ujTzvU06AgSf+Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the pcmcia_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/pcmcia/cs_internal.h | 2 +-
 drivers/pcmcia/ds.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index 580369f3c0b0..999332bc4378 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -132,7 +132,7 @@ void pcmcia_put_socket(struct pcmcia_socket *skt);
  * Stuff internal to module "pcmcia".
  */
 /* ds.c */
-extern struct bus_type pcmcia_bus_type;
+extern const struct bus_type pcmcia_bus_type;
 
 struct pcmcia_device;
 
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index b4b8363d1de2..d3cfd353fb93 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1406,7 +1406,7 @@ static const struct dev_pm_ops pcmcia_bus_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pcmcia_dev_suspend, pcmcia_dev_resume)
 };
 
-struct bus_type pcmcia_bus_type = {
+const struct bus_type pcmcia_bus_type = {
 	.name = "pcmcia",
 	.uevent = pcmcia_bus_uevent,
 	.match = pcmcia_bus_match,

---
base-commit: 4f733de8b78a209501041a4b0a44c83ece0e8933
change-id: 20240213-bus_cleanup-pcmcia-c18794c076f3

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


