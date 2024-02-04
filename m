Return-Path: <linux-kernel+bounces-51752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF16848EE5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DE7285887
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB28225CF;
	Sun,  4 Feb 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="GrpqJD19"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFD0225AF;
	Sun,  4 Feb 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707060185; cv=none; b=DpKs2uuP/1bEbpe6P6MB0nTCpyY8b+AIkF0+7bHbEwUaDJkRLEGQJNb/SatW3vcm3Op7pGk65PaXFPU+BqZNx6tL11SishEmK6a6Tw83i2xImkb0PZf1Zhi9+aQCsdf8WE43Q5VAhhiW6q6T5Y7+WJCZYhH6kP6dxpFYc/d2l8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707060185; c=relaxed/simple;
	bh=Z7tqLqwry4QYsO7CP1hOcz9gdbiXKhTnDDku8swB15o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=arcMrgAEhIk7s9Sz8wISkKyxLqtLPcJ+yz1KwXV10lvRI4W5q/xlZj8HG5+ynv5DWNftB6RFR6bQTfdaeCf8Az0TboDfN53GYpx61Ms6zmL5EHKY/5H/tUjFZ8Dk7zxNDbxiYxJDgwKEcXldc1kw8zT2hGLApxFd4fhAT+wyYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=GrpqJD19 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e03d97bdd0so74766b3a.3;
        Sun, 04 Feb 2024 07:23:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707060183; x=1707664983;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WWtw+i47SirkjtosZbzefB959BbNUbvyVb3ZOTGbLE=;
        b=B5BPuHgsElcCVBTexvauv+prILNXoYGoJmvRjvfTs0qv61SmWktltA8BIQS21jldbG
         6ybjJgdDCjSJwxoHjvkOEg+3b3n0KLzKbkvZyEHHmflhjsyMuTtSeKtAW/wC0od2Lssb
         uad5pXvocsdgTOxwea5Zb+Zr8ZGvpJ0BvVRsnyV22zhA69bV3aHWHaV8i50XLGaoUf4v
         ZMrrfhgQNg55dgrtzNJ8P6kX40FvjZa57WG81SGEWBd3MPKyztQIvKBnl9AKWV28M2ie
         VMbJUWFF5ylx/x0i83QGGF297k2XJsWyWaf6yKsafNZoy8tqKqRwLbjTfjpHmfOHICOI
         kouw==
X-Gm-Message-State: AOJu0YxcTyjWBPeIFblcq3vkuSOAxqxgE7BFKtOJWbfinlhFp7LDQ3bn
	CMln5AB0iTQKkCO7HZBNMBXRut7wMiM1/B+lHAnR3f1zRBZL0VcRJup6EnYeaIZbqQ==
X-Google-Smtp-Source: AGHT+IG2H1pTod8iivPu/zhM8g+vt0l0s3gh0icMUbOcZ3PvGVtfg2k700VP4KffGdsWZvZWT12MZg==
X-Received: by 2002:a05:6a00:845:b0:6e0:3f63:ed64 with SMTP id q5-20020a056a00084500b006e03f63ed64mr895084pfk.34.1707060183601;
        Sun, 04 Feb 2024 07:23:03 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7VhM/FCuX1kuX0EQdXozB6zOMkd7T2X6xesrLp680J+Mxu5+yHesF3biAOKgi+4kzk+ok9HyySAgWm3ms2tiHevYZHUarKXzbojuhzreUNSdEsAi/aohnDp5QIA+ISPTTxwIIfupByuoMJjMcWQYjK/SuCmBdz+QQUIM=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id d9-20020aa78149000000b006da19433468sm4948507pfn.61.2024.02.04.07.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 07:23:03 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707060181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3WWtw+i47SirkjtosZbzefB959BbNUbvyVb3ZOTGbLE=;
	b=GrpqJD19R1YlioLbh4YT2d5o8WtFDvgYJBQiIHXsnHW5iUPh8CreLgPaqsT429903NoIaM
	AlsJinW7/tOvmoO8fKFIrdCVRmk0S9bsJ7QOG1Z2NcwNDu1HEeaPJGEPdLVjZPKmuoaXSf
	/gzq6tSccc4HsXVYNMGpD/c/Amckm1jcfeS7eUHTGXt1fjeFN2x7dYtOUZuEfUPs3RSnVp
	mIDWwHxzYRADDMmQjCDged+O/4izkH029IcBH1mvg1VFztzoYEUxW9WBgXVtFB0KBk6H1g
	tZt8fjt/tcfXJzr6lMxOh5ApZinzzbPydtaE6s0tx22QdrV5iACEfocLi6/Wzw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 12:23:29 -0300
Subject: [PATCH] ata: pata_parport: make pata_parport_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-ata-v1-1-2bdc1fadf356@marliere.net>
X-B4-Tracking: v=1; b=H4sIAPCrv2UC/x3MQQqAIBBA0avErBNULKirRMSoUw2EhWYE0d2Tl
 m/x/wOJIlOCvnog0sWJ91Cg6grcimEhwb4YtNRGammEzWlyG2HIh8AThfWq1c3s0coOSnVEmvn
 +j8P4vh9ydCZrYQAAAA==
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1209; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=Z7tqLqwry4QYsO7CP1hOcz9gdbiXKhTnDDku8swB15o=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6vzWdGOp/61KMAyLddaXX+YIyL1lF7xR5TPw
 zOGuWUppAqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+r8wAKCRDJC4p8Y4ZY
 pjwdD/95R+XtJOkaSUqu27ZMrUW6Odyf8GSALim0a8frE+hQ7ShXpeSuijEpAn6EwFhfMnydD7e
 iAG5lWudLLzYz3xVIFparT/8VUHFzVfw09RprxgmcfOukcH3fisuexI5AZKm2C7ZhEewEHRhFnM
 UlKTjn8oKGd1yn27Fu7JyVfa8vLnUGfVjigrdp1WSMRHdG6MIZEAV7qzUWm4TMlqcjS1sJ0OGd9
 duhBaVGdYcmC3vLGIkrrmwEyvWHPytI/ecEgWSR9nSY/3tzzrv8CvYHXnYYaBXFlGaYTx/Z2SC6
 XAVYA02HZkMISOnNkWDr/Egk3Q33b5QTWb5p6fTOPH+2mzqkg+olc8ng1RAf9Ocw6J8vgsOplXr
 H1c4R6aSitKMNHVAyGCOM52e/MkO6gEZfOT53qh93+Pb1AkyI44l3/PL0scRMLzets15AtF76sE
 vQOW3grOifzJW1MRU6MGM6YcbRSMtn1kLYtYctwLzaG5SGONIK21VG3w7rek9vDiH7xZY0Cg5hA
 cU5BaSm0ikkUfQaudCO4ZtDDqx6FW+boyVinKug6JdeOT2XmuaG7I3PtJSyeccH2YX41INXbVX1
 uejyzBesYfJ2AUQFzICw+wjwRJPFQuJprGDYMKL6Al/Q67+TQqsV/A5gfsvPncmcUGWl9/2kxqx
 cWypD00yhwpfZNw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the pata_parport_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/ata/pata_parport/pata_parport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
index a7adfdcb5e27..9a2cb9ca9d1d 100644
--- a/drivers/ata/pata_parport/pata_parport.c
+++ b/drivers/ata/pata_parport/pata_parport.c
@@ -464,7 +464,7 @@ static void pata_parport_bus_release(struct device *dev)
 	/* nothing to do here but required to avoid warning on device removal */
 }
 
-static struct bus_type pata_parport_bus_type = {
+static const struct bus_type pata_parport_bus_type = {
 	.name = DRV_NAME,
 };
 

---
base-commit: c8474c7273ac3bad718c33118aa82efb7b374f6e
change-id: 20240204-bus_cleanup-ata-bd1625fdab09

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


