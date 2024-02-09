Return-Path: <linux-kernel+bounces-60148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8778500BF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40021F26CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDC138DED;
	Fri,  9 Feb 2024 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="MXCyppf6"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B916439;
	Fri,  9 Feb 2024 23:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707521252; cv=none; b=ae2v557ERTiCCRfZyC4RSgDMNtVJbhjaambLUvC4eY51uGHjyghsdSgr6DCqFOJYVmLB0wWHLVIAasBj0pSrgj07bRobJ0JOe1cRNJHN+5hk45OCeYmuK/GATkv78DlyIV0H9U4sup2ErR23ah2zcsPg0gEksN4Uv8eF18B5Zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707521252; c=relaxed/simple;
	bh=kCLT7qokmuFY/CFxh4tmc+PM1+RtP1qfIzM12mWcNj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=scd/wsCdlFDKoPjnBrpF9VZekUQgkx+2R7BgT8dbGkRW8KW+3h34SytNBMcidydy+c2ir/F4rJgAbrbSvgnH15BCmzlp8v4ds+oi8L9vpYdd29Nh6V3LIfnMy8fLDKsQSD7tDdMgxFL4Weyry7YnSc+tISpzw8mtvsNrOZdPhCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=MXCyppf6; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5957ede4deaso926983eaf.1;
        Fri, 09 Feb 2024 15:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707521249; x=1708126049;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BKEK4TZGi95ukxVkTkUsfUXe8VY89KvOv3l4m85x1o=;
        b=NfdwsqNEUVG/5TsZWN/JXKVpuzRvblvw5bMTI0J+l/jFWCP7FjEyAL+9FVyJZghUDB
         d5UCitORogl+S9u8G4QfqU3Qk5rCdAS/A7afRagAcWsxX+PvkII2hBNfKKCY+KmjyZgw
         Ro/qzU5nQ32KLyaks9DtGnjOTMdIJ987SK7i0U/oZy46sWdZhj0/R6O9rOBywYj8bcJN
         pTGoo9RzYz6nsgsicO4EYNuiu3UTib1ElHsv+sYB7Kd2opBetXt8GKUgi4brsYFt1v0C
         0l//6vUZdunWYg+U6IIb2OOyoYuW6FRanhayulnltdV9hzpdikGYGNlcAfMcSOKTsY/t
         HvQQ==
X-Gm-Message-State: AOJu0YyMUzM4hJWNGyQb5hlz6uJPMJ8aOUjkzurYEw9l4xWT7zu1ACQY
	LEm2wlNXP9RroYN4+RmV3tckV4fi1ti1eZGi4Xqx8/3dr7hxLyfA
X-Google-Smtp-Source: AGHT+IE2cNXaFyERMNf4m/KskJ3Htz8k3Lv0pRpSJBvNazvt2b2RcA8dQJEuzm/HLJBouy6EduTJ+g==
X-Received: by 2002:a05:6358:2607:b0:178:fe3e:1e35 with SMTP id l7-20020a056358260700b00178fe3e1e35mr1356333rwc.13.1707521249339;
        Fri, 09 Feb 2024 15:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWoZ40mXUi8fJ6bV5qepCv4c0hvB7se4/czJO3foYUN5RToOO1Vl2/na2xT3hIuzp9V+XfsHz4QAwesHfi1abx9zDQSujGuHKVOEISVUF8JoHGvA24zSbHVeRJGmo0LjbcFGNiDnFA6iA==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b005d7994a08dcsm2349359pgd.36.2024.02.09.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:27:28 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707521246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+BKEK4TZGi95ukxVkTkUsfUXe8VY89KvOv3l4m85x1o=;
	b=MXCyppf65CxfWZMJtWrLN4huAvuE/ySVy6TYTNv115995hjO/Jx/ujJ+GQivDwxMBzUmem
	5BJDUchSUG46x6R9m864p2Pj46+fJl0lpZ+iQd5OoD9C273d6XwcW98P752DyH6XrEFVaw
	KlR/SJxQZAJjWLVswf+iLCsPy7jIpGFwsEdODaof5zqJ5Xo0hJCKrodUBydgwhnYfTMQP/
	UJQDWYxLVFfp44jUE5PP5E+G75YRkLkLco0Zj4UDupQ3V43qdL76e7fFc+cQLP6daCk0iz
	j58n8NgjBIl0KmNCHTYP11goGa9lXQmJIyhLI97Z+SHyIOwbwminK4hyR4oLlA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Fri, 09 Feb 2024 20:27:48 -0300
Subject: [PATCH] media: bt8xx: make bttv_sub_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-bus_cleanup-media2-v1-1-8037c73bf688@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPO0xmUC/x3MQQqAIBBA0avIrBPMIqqrRITpVANl4WAE4d2Tl
 m/x/wuMgZChFy8EvInp9BllIcBuxq8oyWWDVrpWWnVyjjzZHY2PlzzQkdHSVA22ZWNnqxzk8Aq
 40PNPhzGlDwua8/5kAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=kCLT7qokmuFY/CFxh4tmc+PM1+RtP1qfIzM12mWcNj4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxrUBcElFvq0oGUo6//Irgo8tU4js8sFamcYLu
 elBwHTEtTWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZca1AQAKCRDJC4p8Y4ZY
 pq6qD/wIkkdl2Y4lktcyIsZbG3rG4nJH7ALJYB1a4vFJaWCsgN9B6VsWPtgrCPOVjAvZGt3mUx9
 0xZKioKaNoyUB6WbG0z9vsffno1dpVuZJ6l82n9CRDcO2b2ASNe9bxxRvyjdVFMVZXdB6PUKN1U
 sjF38D4QMJ+2dfEnVfoigplVP25qpf3F0XOTdBA/x3w8f/jusCM2DhlWiozC1YahS6Geg6WihH0
 FOY1hC27XkMzSd2GmeE+72pmxnJYiBxMBLHyrvXZePJNROgz32RAcoS7FwLYM1btQxhRgI3wjjc
 LZz1zIBZ6pVAZ1+LFs9VDO9Oid036aphOBmsCCfSerm0oOYv3YdDbN6JqssRVJ7zF9kFLlX9qfh
 CrwnPyodH2JM7I/+NbfAtyw2lvMWoEgRATReRmtr4LyJAcMHZVJmuaiLTTe1sb5mljHSgzfWp5l
 2n/ji1L/ZV51Zh+bdPfOSRi09mhZwHDjpaXPQpKnGKcMFxZT8hxNsqvVsZ8HoKYVzlBMwIU/iVN
 G0c5vvizmlPrn582uq8krw/WJ3W5gxhs75EVw5dIP/HYDtpqgoz0wLPILgp8yVJ3wLszKVH8/g5
 3+FMCci77/9tgGihsDoS7Z5ULFsgNykBEg8gJEEGmLSy7HwcBjjfFm1pVFHumCKnB8hOXe3hL81
 xH+dPmTFp/rsHAQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the bttv_sub_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/media/pci/bt8xx/bttv-gpio.c | 2 +-
 drivers/media/pci/bt8xx/bttvp.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/pci/bt8xx/bttv-gpio.c b/drivers/media/pci/bt8xx/bttv-gpio.c
index a2b18e2bed1b..6b7fea50328c 100644
--- a/drivers/media/pci/bt8xx/bttv-gpio.c
+++ b/drivers/media/pci/bt8xx/bttv-gpio.c
@@ -55,7 +55,7 @@ static void bttv_sub_remove(struct device *dev)
 		sub->remove(sdev);
 }
 
-struct bus_type bttv_sub_bus_type = {
+const struct bus_type bttv_sub_bus_type = {
 	.name   = "bttv-sub",
 	.match  = &bttv_sub_bus_match,
 	.probe  = bttv_sub_probe,
diff --git a/drivers/media/pci/bt8xx/bttvp.h b/drivers/media/pci/bt8xx/bttvp.h
index 0368a583cf07..a534e63b9a37 100644
--- a/drivers/media/pci/bt8xx/bttvp.h
+++ b/drivers/media/pci/bt8xx/bttvp.h
@@ -234,7 +234,7 @@ int bttv_s_fmt_vbi_cap(struct file *file, void *fh, struct v4l2_format *f);
 /* ---------------------------------------------------------- */
 /* bttv-gpio.c */
 
-extern struct bus_type bttv_sub_bus_type;
+extern const struct bus_type bttv_sub_bus_type;
 int bttv_sub_add_device(struct bttv_core *core, char *name);
 int bttv_sub_del_devices(struct bttv_core *core);
 

---
base-commit: feb8831be9d468ee961289c6a275536a1ee0011c
change-id: 20240209-bus_cleanup-media2-a36e816cbc0d

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


