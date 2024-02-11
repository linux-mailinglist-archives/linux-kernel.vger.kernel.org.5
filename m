Return-Path: <linux-kernel+bounces-60834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D63850A04
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ED41C20DE2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48C5B67B;
	Sun, 11 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="mhGl0oRL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABB25BAF4;
	Sun, 11 Feb 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707665806; cv=none; b=DDuf46z8GWs3L8q3v5h6o5YUSQ+QK/Ewgslcco/R1VOdm5YIo3WjlSFIITzh8k5Fb2BkmIq23JaD23XDUX6Tv0IJAJL9tRthe3QaIviPwm8WVd2h8vmb8TPdJqKE5DaPOGdOdmANatgg5qdEIDzDgm/1clVLWo6AIijElZ2UAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707665806; c=relaxed/simple;
	bh=jjSF6lq4krDwmprCM2e1i+Kdrar4fmP5e0LW+RJ2wmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tyt6R/ASI6lMloWXYnbblo82FIoIt/egVuRoCysNQ+QZMyiHXlNebsl7RVdnHoyLSpxFBFN3l9XeMLwFHsxSdytzD0WVi7R7Ew17h/AB7QPTh23aXZMG0zOGfPGDgEUvKvy912SS6B6eFa1QF9nxXCvVpwsphOvj0cSGxPpOZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=mhGl0oRL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso1276180b3a.1;
        Sun, 11 Feb 2024 07:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707665804; x=1708270604;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsC71mnuXWG0q9Nl+o1OGuAQFLxgfL9XuHk4wUGOUJw=;
        b=Ma1KcXlljvMhYB8DdmkGCFn7E14Nr+n/+1uONSdzczfiTaDaTquGlnA0EgRMyT67gB
         adaTqGS7BksH+PWxVOCulC+hTnI5OZfsFGqzO204Dc5SlFsRwb16gf/Tqvk6uoe+QUmH
         tLb0D2Et8nuFM3EfDyim1eph/ZcQY+36+vk5VuR7Tk9UC3eWk7SIoPwF466NErXZtBD6
         deVOIp4hOqCGa5jXbV/GrlS1VaaEVBzXoe3XT5un8THEuXn6FgqM7LQe0b/YUDli92IO
         iIKlnp00UcV9PIUwzHbM0hs8EczuRArJbDiMvaMMBobPagNgq8rZl422yc0TvsqjC2iY
         veVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSd5mJVMpq2+WdR5hdejenI0I5u2cd8sXIRCZOS3cYT+6vKEj5HuW/9x6jnFYseo4NoB7CZCfXQrnYDuwkwfIlFnKGe95uVkN/Ak27
X-Gm-Message-State: AOJu0YxLkVwqNwbNv4xXZwwOtlemDXCeywLmRzc8ZoW/lHyeaCu8Tnho
	uWV0SPIawmaXT8eKqWDz0W0pKeuLGgQo6r0RnZOdGIwb9gYDiiZGhJRMHC8sHTNQ5w==
X-Google-Smtp-Source: AGHT+IF9T4IOjEmQvR4mlXkGYzVOri3d75tfp7kA4LF5NAeUZhtq71G2fXkvcG/DMNcCbiz326ixXg==
X-Received: by 2002:a05:6a20:9f04:b0:19e:a873:9252 with SMTP id mk4-20020a056a209f0400b0019ea8739252mr6281323pzb.6.1707665803725;
        Sun, 11 Feb 2024 07:36:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbJklSaG0wLyxzy1wPY+FEUG5FIddlrEZ/6cqJ+FzwZJIOamHpPXWZm4iU3OK1TfRHdp1L0M+nvn6I9rw0xs/Ie71Oqe2pXbk8TKRMOLp7lDjsjEZ0F72+1Ew4LaKmz1Iw9fZVACLCgxwmEthy71HWsPQHOBKLK5V/aLO/4olMuR2bypWl9KRD3SnWup34+hz/PoyxZtVaIwwkZwyAqgoBA2oFw0xHIx+XOxw6e+du
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id u39-20020a056a0009a700b006e04a3a3df6sm3910899pfg.185.2024.02.11.07.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:36:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707665802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QsC71mnuXWG0q9Nl+o1OGuAQFLxgfL9XuHk4wUGOUJw=;
	b=mhGl0oRLqvgO3Km6MTeJsSLOqKrGO0Jfo7WGUSc4pzTkB91j+d+5UGnYXm5bogbwgLqtED
	n5a8x4kZhbfdxOI7WdlCTQjytrAMYJ1ulUe89WKcXfSAQMH7kFyF1KOYqY8jbPBxi1OdMc
	lqUC8ugu0Tig3Dg7nOZy7vmoce8Xl7bo2ufl+eFD+Y0z31eG2tS4sF7wHZsft6PKI6uOe6
	wxEmwT/W/TLtaM4+5ltGUE8j57emxcuncTwOGN57yRIkKatCevw1Gjb6XRTESJ+fYuGFOh
	2czDn93pA2VcmmEHgMN4fIm1Z1H1UPI8btNbrsg/lIow5txdTJcWNrptFqJArA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 11 Feb 2024 12:37:11 -0300
Subject: [PATCH] ACPI: bus: make acpi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-bus_cleanup-acpi-v1-1-08540c6e9458@marliere.net>
X-B4-Tracking: v=1; b=H4sIAKbpyGUC/x3MTQqAIBBA4avErBNUin6uEhE2TTUQJooRiHdPW
 n6L9xIE8kwBxiqBp4cD37ZA1RXgaexBgrdi0FI3Uisl1hgWvMjY6IRBx6IzW4soG9kPCCVznnZ
 +/+U05/wBp2rTfWIAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=jjSF6lq4krDwmprCM2e1i+Kdrar4fmP5e0LW+RJ2wmo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlyOmvpeM1qgXf1S8oUZUteHpAa7F8/a4xwyTMs
 T90cMh+DgGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcjprwAKCRDJC4p8Y4ZY
 pi+/EACJDPSrtQQCZRcys2FN3LBfpgESKnhCHF/kSH+u6ZAyO6LG5doimpOofZNFe92tIb+UiSW
 U/+SQOpd2WBzD1ayOceap+3NAXLDmunZFFKlXFtWipHz83B/Xb4Q4NHRUrTOFs+aOiWs3Ha8UoK
 zOK44P52z49nRwhds1BuUfADr6lQ7wRqKHFk1SflwlwIntFaRa6WEInjlRFYUp06HZNI7wGvWWS
 Rd2ndoMBwhTlOKtHEe6FKHRApBAYrE9v9zyTqQu/SGFwCr///OemlL1D9pv9wKbHL/KYrGYIR1l
 Ohcb/IzY1xUUrpDn0Qd7tOUrP3vWGgiHV0yhZMDWFQGPXzA7q3Fe5rsj3ZJDIpe5+yPn8S7OqEV
 d5UdBifwGyYie/FGrZAXP+zshScdvcRGcCxwSLhOZfNXD7LWGSy3cdMP0Tx4zp4QeBYwa31wL/5
 02A89hCSrp/Aog9beeIglI2gNGubfDQuzCtFUh9KGqCygpB/+g6r0Jfv99H5BlgkQZ1Zbynfbh7
 0q+o1RKApLxecOsdRHqErlMCF0c7/w87wbsZsQaCRmRP8TVI2kDsaqEXYPP0Lv/rZdhTkqJtfHt
 KV2nRy9mDYN7LstncXMxNt3Bh2WH/Vwy/0h/gj1MR0OZogG8XYTooLGZDWoVEnDdM5H74A/BUmj
 p7dU99AfmpjVYgg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the acpi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/acpi/bus.c      | 2 +-
 include/acpi/acpi_bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 569bd15f211b..d9fa730416f1 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1097,7 +1097,7 @@ static void acpi_device_remove(struct device *dev)
 	put_device(dev);
 }
 
-struct bus_type acpi_bus_type = {
+const struct bus_type acpi_bus_type = {
 	.name		= "acpi",
 	.match		= acpi_bus_match,
 	.probe		= acpi_device_probe,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e4d24d3f9abb..f67aa93ba53e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -582,7 +582,7 @@ void acpi_initialize_hp_context(struct acpi_device *adev,
 				void (*uevent)(struct acpi_device *, u32));
 
 /* acpi_device.dev.bus == &acpi_bus_type */
-extern struct bus_type acpi_bus_type;
+extern const struct bus_type acpi_bus_type;
 
 int acpi_bus_for_each_dev(int (*fn)(struct device *, void *), void *data);
 int acpi_dev_for_each_child(struct acpi_device *adev,

---
base-commit: c3c4923f2082353762e8f46dec6e3b0f165a1606
change-id: 20240211-bus_cleanup-acpi-7ad5cc04089c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


