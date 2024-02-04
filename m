Return-Path: <linux-kernel+bounces-51771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DFD848F21
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA044B21E10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6F82263E;
	Sun,  4 Feb 2024 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="IrDo/QqZ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D308422638;
	Sun,  4 Feb 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707062806; cv=none; b=dEL9IgF+JrANr/846qdUMe7o02Ak4IOOXw/uf8lSr/y+f9F1UwMEqRkvl8v6DMAJcRA1dBDkVcu7/e1bjUwmatlBApq5193HRCD1oblAR9BBaOmbXch7seAtPK26HeBNleyLRh75KZQhLL1YaRek84ZpmhOHtuikTpbM152Myo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707062806; c=relaxed/simple;
	bh=NGRPqGsVHE0UEYGIKYs7klDgBUg9AeOL1bqJcet72+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b6q30oKDpihsNkQIJu+Xq9B6MWYsUuqK/HGx6pjXiRco8DFjytffgkhUOha7+N3Jyn077mEjk70t+da8hSUB2RKbsh0e08QE0leLEX1a4L5+mc75vNmGenqGSM28f31p7VqwHA/XnOJ3KnrVi/XbCPqR2q/iPuvi+ayXwcrbLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=IrDo/QqZ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d93edfa76dso31085595ad.1;
        Sun, 04 Feb 2024 08:06:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707062804; x=1707667604;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z36dRHY7LpnrJF+rM2BIRQuCAUrP8aB0bQLP8Y+QGrE=;
        b=HcAso5XfAK3LidzDBcCvz6Nj5AJmJjnzQPy6ZdJuzUnWBSjAJGI2KdmmRd+IL82A65
         j0RaEEgzBwgSUPUkHSirYs8gyqKMoc43uYpZ2UWIOjtcw0dAi3TMlYgH8mfg4nVEQELK
         sR787LRr5jCR10G3qfeA4hLsIDxfA9uJSgKBM4iFrQD8IgU4gq6nZBaBxhtUvs6u44df
         xEyKS/Kw0l7ZY0SG7QuRMBAMleKqz9aWo30nREFEzjfpf8ECLfLiCYuAMfdbtCV02Z18
         jlusi9+w4Lr3kf9WxGGKRKn5KJCZtyrj6efajlkhELDvr5LupYARtrWKxCNTD3IErVbC
         jrLA==
X-Gm-Message-State: AOJu0YyGD0HwM1xnIzXTrVO3ezhWf0AhShehJswZ8HLLR3duLV8Tq2OZ
	ZQHCNgV8/pPnv6ICjT98mRCkHelCQ8mvHqIWI7YRH9mLL2CEtTzP
X-Google-Smtp-Source: AGHT+IFmqwIrUp49lfbA4xA4DO0fKzsU8tPeSfNoX2ztfG9e3WEVeMErQv8EHRSXKu+hOkDwWoWwxA==
X-Received: by 2002:a17:902:d2c1:b0:1d9:b5d8:854c with SMTP id n1-20020a170902d2c100b001d9b5d8854cmr1038273plc.58.1707062804261;
        Sun, 04 Feb 2024 08:06:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW3NLjkza/clYaUge7PnmNdCg6fXgUy8hgvWGS1AQRwpels8bA1mu9lYpjDGEqgIVLDqygv2zOESqfo1oeu6CXW0hwPdLkXEDil/9ZpUTb4XpCVY+Sk+AaEytvXLnc9yfYFMB2K7Z70aOAlXEf8TmAdChtNbsud1ITVbD6roBMREuyDmcBRJKhWY8ro6nLOYfqYJocDyjQ6rLwoOSqSjLqLKRlGncak9V6eFd+InXJw7agStw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id e13-20020a170902cf4d00b001d8fe6cd0f0sm4693879plg.150.2024.02.04.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:06:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707062801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z36dRHY7LpnrJF+rM2BIRQuCAUrP8aB0bQLP8Y+QGrE=;
	b=IrDo/QqZos7tn0XQ9QCQ1+IJWPzh6ZdjELcJrIxcS3omKVUJ5izWcJ39x2qg8114Vn5u9i
	j46o7DaMBqgdTesH3Drrs85eRoa+hv987SIyNGDdS4wacgzt1alFi/DDd45QleXNpfSRLF
	Yhrys1E3qrL0qGSjkODlSCCKI4nLOj7xN4Lw3W63cRX03JUG1g66RnaG6T3kvkRu6LFOo5
	6DLc+BuCibjOEQ0y9kzQYI0SMDFRsZQAWCaCQGjdq+8OXz5sQ3yEryDpsOT12N4s2KqL/E
	bxjF256hPH+by6aYvVcH7SkVxT7jsAo40iy7fxyCsJxG2A0l02xAtsEeLm/poA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:07:11 -0300
Subject: [PATCH] device-dax: make dax_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-dax-v1-1-69a6e4a8553b@marliere.net>
X-B4-Tracking: v=1; b=H4sIAC62v2UC/x3MQQqAIBBA0avErBNs0oKuEhGmYw2EhWIE0d2Tl
 m/x/wOJIlOCoXog0sWJj1DQ1BXYzYSVBLtiQIlKolRiyWm2O5mQT+HMLTTaVvkeu0Z7KNUZyfP
 9H8fpfT+mwZamYQAAAA==
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=NGRPqGsVHE0UEYGIKYs7klDgBUg9AeOL1bqJcet72+w=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7Yw3yyE+neTtEwU9YHmvpQ+IBR1XFaEIr8w3
 l738UxeLMaJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+2MAAKCRDJC4p8Y4ZY
 ptXHEACpFojr7rJxMdxjIxXm7xawLNR8i4/CaO6LWnnFuAFeWaiubKR18pFlwisnwX0OSqmM1PI
 yJqqqwyONgbljzKMoGK6pk22MEakRmmbhSGShAl6Zitp+vkF8KBPZOCQQVQfmniSjZRqTNoMby2
 rNZw0zF7Z3cJRXSwswmtTdvuKwbaZqZGHZW7LCfFvMlMnNMgp/SmNDGw3gTF10n346IAmUtUeQq
 21fKfpg63tiaa1GvawCKXk0rbc/S+UHaPGReyDW7dgqUMeJrL/tV75eH5UZLmOUWBxEKQyqC9SG
 FdCa4f1xnK8KNJjrp2Oes1ZpPbZAxh74uZ0X8QFa8Im5/qzevFgcZM1Ome/fCfHrEc81sgcq+lk
 lQgaJlqiUI3bhN4rHG45CYZTirL3MuDervOf3ThFdzlszlRHLMCoBonOmVY/ZRQntJpvDXVNTLe
 0Limb7si4ZQQyadkD9eZB1rYgEKNJFqe2EJAHlSjpfQEL7+1f92i0BBooljLe/A2JweRgX0IHB3
 N/YqRRwXzaJN6dAJLszkDzb1ayRdWhkmUe3TUMyaGtlcmIn1TU7S83QvynQxnJh0o8ssAHZl9da
 ZIE9XwXF2HfCl1dltvAp2xFSiwQ5rEXpHHXvgG1c0siKpMUTOoSrOy70Hp6Qqt2IQzGx/APpj3R
 hqocF023jjDTyJQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the dax_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1659b787b65f..fe0a415c854d 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -222,7 +222,7 @@ static void dax_bus_remove(struct device *dev)
 		dax_drv->remove(dev_dax);
 }
 
-static struct bus_type dax_bus_type = {
+static const struct bus_type dax_bus_type = {
 	.name = "dax",
 	.uevent = dax_bus_uevent,
 	.match = dax_bus_match,

---
base-commit: 73bf93edeeea866b0b6efbc8d2595bdaaba7f1a5
change-id: 20240204-bus_cleanup-dax-52c34f72615f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


