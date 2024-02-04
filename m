Return-Path: <linux-kernel+bounces-51872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC7084904C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CBF1F220D9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C525567;
	Sun,  4 Feb 2024 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="R/a4jX7c"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD02555D
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077570; cv=none; b=FX6VFGJssILJX48FSOJ72LU1aup9hNGv+5RY87VHrEqCl/ew9ILakn1V7nXEhwLDMChLYyKjONrqiaYDlHFpBRBGdltVBHv62A23X+MpX0U+mUneF1VlXKHzVuQ/nHRAwJDzxLik0OQyfMc5fGz2zuPip2GgIIoZCpa2J8GMXBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077570; c=relaxed/simple;
	bh=OC4lh+EHjT5MPLvvYUnYp9HYtYGXrta0hdIBUFu/GIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KxNm9V+2GbyQChE29S9xCb9wa6O/sBigbNH3v1s04B1XJEHGskOm00Hl4cRQBkLyglCzZFH90aILfgXwN4wAqEcIZ+lUVdcu7C4RwZYfUDGt7ZjvxaK7zPCNpCKlO37l1/3/f59gWYtqWigroI98/7ArE3BaQ1JYIwC/wFZoEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=R/a4jX7c reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93b525959so30961955ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707077568; x=1707682368;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3ZhnkZZBIW4U13fJxGaiTN58+RG8ok9nnuiu7tCKF4=;
        b=O274BmaQ/Ukum//A4ndPdlVKIDkurdWvd+L+xsrKwdRT6W2GsA3x3czhLvgT04vvBV
         sm77acUOUmvEWxbFryeI+hN/l6Pwux0mpEFKjHlQ48UGHdW9K2iCqjRGAGLu7AbatJY7
         HNLs5sjk/mB/J0Rqt8WNjOcBnnvQzYbafxFQ3WmFLLKQkXKDuXSIuR1QG7jSFGySX5hj
         Q2d1tsU4iiaBOaLtkWXx0Ne9nBMSfbEdDFcBtn+7kYYq+s52hWmBgRYLtPgY7ANwG2lh
         PmdZ5yUv10wVdyR3diAH4bLQSF3qO8dGOcdzbfvmJvFN+WL9U4qEZ1j7r35BgC+3OgLy
         1hCA==
X-Gm-Message-State: AOJu0YxNIPo0EetR079PsETVfJOgj/8gWtp0npv8zScKkj0jw7wvYapH
	xkmksmDWCrCK0m1A+UkA33ZmQ/7Y0VOS950NReRY1gfwCUQfL+UJ
X-Google-Smtp-Source: AGHT+IF3lTGDQ/VppXnK77/kItoLDppB+vP0jtM2jC6zBWPT5JctL2/VPlWq4dqhiBKRbNkaNilxDA==
X-Received: by 2002:a17:903:11d1:b0:1d8:ef97:229e with SMTP id q17-20020a17090311d100b001d8ef97229emr4954081plh.33.1707077567849;
        Sun, 04 Feb 2024 12:12:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUuaQFQqTj9c9gyMF+Sshbjn2aDv7cKsXqNDjw3M8MtJQ2KcEXFww6zCT/+4EmyxJPpqlgMsZAknehqqb87vXtazDYgJmf17aOUKXCJXBVlqm/NnCI8MgRUrNCdg0UMKCzUSPL91QAGjHk=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 28-20020a630e5c000000b005d553239b16sm5613427pgo.20.2024.02.04.12.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:12:47 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707077565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L3ZhnkZZBIW4U13fJxGaiTN58+RG8ok9nnuiu7tCKF4=;
	b=R/a4jX7c9+VI+tPh8WYdRouu9OywPjab1ththF/Nkdv3mHvMpjIdns/ysII9vo9U8eKOMv
	T6fGfSGzpXUMBCCBzLyd6A1vSj2SHj0XiN9F6W5eC83c3WrSiNlEDRod4IdgfpZ68rEBc6
	cCfRnu3ElNXbn2qJTkBRYlgwEP0zZykTSNRuArXoLolUIRBXKjTM9PAy6nO2mcGy/Ekg3V
	fXkTCTEpRHGbNuSIHQI2sXhztqmWb+MaVLQgV2J6HOWYGB9+SZmtnZSCAtO5ZQhGEw8Z6y
	gpiBV5+qrdu6hKs5iMxk9rY2VyJATxJM/oj1TtKllP0mqNiISmIB2rfPs67tvQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:13:16 -0300
Subject: [PATCH] most: core: make mostbus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-most-v1-1-f5cd9a06e13f@marliere.net>
X-B4-Tracking: v=1; b=H4sIANvvv2UC/x3M0QpAMBSA4VfRubY6W0N5FUkzB6cY7SAl7265/
 C7+/wGhyCRQZw9Eulh4Cwk6z8DPLkykeEgGg8aiQav6Uzq/kAvnrtZNDlVYX6KuSvTaQMr2SCP
 f/7Jp3/cDXJ9ObGIAAAA=
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Christian Gromm <christian.gromm@microchip.com>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=OC4lh+EHjT5MPLvvYUnYp9HYtYGXrta0hdIBUFu/GIQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+/cyfOQKIRxX/hTIGqF3okmcksP1VTJ+XLzd
 7m/AEig/V6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/v3AAKCRDJC4p8Y4ZY
 prxdEACRAABUESE7l4QybKfyq3iKOV6apaejardP5fpj8cYhme6lNKlnhqhiPFDUOmDlUsAiDoj
 UAxrH99Y/LIfSwNHScz3zEr9Jf+U4buxdnNr+zwzqhgA8YjGrTOPop4I3bVcCpeuHj9mCekekOw
 HQGB55R5tIJnKx5EOcVbTDX70nUm+/NKgk0ol5cDu1f11AQLiulEQlQRK5BYUZwm1sltcLprMI7
 VU8YezKvspR9Q8XJ5VeF9AO04XxHr+XSPbfMzvLvuU5y5FZHtzKzfXs7aqNAq0xGyPuew46DbHB
 fa0blFU+X3aLmt+bwArb2+rtrRIXPscwyGvvRrzh7GNbfzvzxHq5ARWKZWLPGQIZoV9m0YmGqio
 0ZwRUaWQ0oig6H0tqmt7XnGtjfGubMChW5Uw27X0Ytuv9C8Y5SB8/+/jAszrGnZ4nWKYqA8BIcH
 goem3br2CTd+V17UKSL2XDljrz7SWZmf9wEufpsHmkzQ+DZK/YlK26zI+BUDA2pgypaUU8qnhml
 kvPahvDWstA3qHg/NWVeAQwbVavY/BTCKNKyVluy94LpKbCZ/f+LL1U7B+K68T3ucCFMyMGi7Vt
 RKPmTwaaQ9I8jEujdZ0d3SYiGMBexsRw48jkwwdNeVkvPt1ZiUW8gOH6rHAUgjiooIe8vbLNxQR
 hEwTgxDO21zkXvw==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mostbus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/most/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/most/core.c b/drivers/most/core.c
index e4412c7d25b0..f13d0e14a48b 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -499,7 +499,7 @@ static int most_match(struct device *dev, struct device_driver *drv)
 		return 1;
 }
 
-static struct bus_type mostbus = {
+static const struct bus_type mostbus = {
 	.name = "most",
 	.match = most_match,
 };

---
base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
change-id: 20240204-bus_cleanup-most-54c601760c12

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


