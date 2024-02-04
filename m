Return-Path: <linux-kernel+bounces-51713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA9848E86
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6024E1F22142
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107491DFF9;
	Sun,  4 Feb 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="gTePWLzz"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C41EA7E;
	Sun,  4 Feb 2024 14:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057590; cv=none; b=nwJvJ9PatEkPwf8Ukh2Xk1P0FRFZ1FL6IzDkmnFFwKoMxWr2aAOWgvjWTsUTuPwDvKRm6EcONoti0LC53ouilEok1DI5ZtZ2rEsxxBF9/mDsxj+Z3US1Nv7qseY8k+bjiNVddRHU9jqwZZH5A5vf1yELAT3yaeSy0AyH4bXOPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057590; c=relaxed/simple;
	bh=YPtF05/G1lPm57cNsmvdhqj9M4hNZFetbczpZyK0TVg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PCpfXJdAOZ2va9lY/lL9C+iI1rpMGZmhf8kq6FOBbTkeY972As4bA3oSS3Z31heok5z1r3Iz4/ISIc7gKYTUq8IThfDpqkVz9CDJ06pkr/Rp+93ki/8bMK6uP7jhtL4g+3Xw4bPvenLswJ4W+A2edh+xppmozl9UWJ23x+QtpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=gTePWLzz reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d9b2400910so662925ad.0;
        Sun, 04 Feb 2024 06:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707057588; x=1707662388;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3ERBkTWboSgSMwK6QkBGheNdAxRHtxD6ZHyTOKGmeWg=;
        b=NY2RHNkIHe0fOODCIh+AqTSGZKx8bnrm7KU1Bv2XEg6J+YFVvtzYBgWoWmJmtUJcV3
         hETRswqCY1C7fyKH/BKhvcARa/iK+PJrUAJmLN7VL3jM9b/tiMh6c/fp9PIdk/n1eF+Y
         hj510JbUSuM1IM/bj2GwV+HZ3kZWYLxatGrp/lDLD0G6iU7oPVsaw+UP4KLJRTl7Hvb6
         7B9quds3JyaoAM45aaxLuCYyFLCyEeSFldNVX8F7eyrlieN+LRz9f9+Rg7g8EroBd4fA
         pHeG8zHh0O1tDnSWKaQd2co+C0XqJOzijDuTiZ9/gMsyYQOtV/QifI2IPC83YY1D0D58
         vphQ==
X-Gm-Message-State: AOJu0YyCaXgUolAXvnYoW5soYvHWS8PZtqGIjhjOnpEXLntH5xd/59ln
	55QPwaAn0bNpj2IElZ+uCalyKtwGO4QTaJb8lICba/3xbzKcrU/V
X-Google-Smtp-Source: AGHT+IEIBRA3ABRqNapbWepV6ZUSgEf+wQ8ykbkFrOeYtCQ7IKlF4pL85kxRaLZOG6KiM0wsOLW7UQ==
X-Received: by 2002:a17:902:da89:b0:1d9:6206:9cd4 with SMTP id j9-20020a170902da8900b001d962069cd4mr5722144plx.25.1707057588045;
        Sun, 04 Feb 2024 06:39:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXA4OdxuQ1bwDEWMzle5g6C5hyTpaeS+ZOAL5xNx4hzRrlf70ElaLF4YYw2te6JLe64Yzbj+WvjFRXGPnrKFJ0aolOLKcBviWFpPlv29nzaIn8qPu+skD8bPOpiHAmxB7jRWWHqivtQbUoRkDkzmlp+SoMuSBJAU5KPizgd8KRddaS/baEQR1yyQSVY3HvsMryigzcpsNf9HezWCc=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id k15-20020a63d10f000000b0059b2316be86sm5255776pgg.46.2024.02.04.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:39:47 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707057586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3ERBkTWboSgSMwK6QkBGheNdAxRHtxD6ZHyTOKGmeWg=;
	b=gTePWLzz//Xk8FSZCjOSTHK45f3hfJawOFXU82jYV0SgRGmdeA8N2NuLJwd11l85ZQD5WK
	N7kUcE8YrwB+flxqTKw/BeGnHjFva4rU5nYg/mZp3HWJYJmu6IgW7pBXhFg9LiS4pwg81Q
	6y23d+Qm103ol3Amj2Uzkxt2QEmOUR3r7Vl1NY6qVJK7rMWaV+jdbW37MXvL+KdMZfWxn6
	xIJ9ykKezTaIsVk8Z2f+7at3Xq7y4DZlXSt77qm+AC9Dy/qa28THXZEVLwVDe8UqJW6WvT
	xe6AQrKVnpc6mxZJOxRj2IUL5AO4xvQIVgqUqBkH24rTKCYOcCQ8n716egfVzQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] platform: x86: struct bus_type cleanup
Date: Sun, 04 Feb 2024 11:40:15 -0300
Message-Id: <20240204-bus_cleanup-platform-drivers-x86-v1-0-1f0839b385c6@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+hv2UC/x3NQQrCMBBG4auUWTsQY0jFq4hI2v7VgZqGGVsKp
 Xc3uPw27+1kUIHRrdlJsYrJnCvOp4b6d8ovsAzV5J0PzrvA3WLPfkLKS+Eype8464cHlRVqvF0
 jB4eI2IW2vSSqmaIYZfsv7o/j+AGUkJbycgAAAA==
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YPtF05/G1lPm57cNsmvdhqj9M4hNZFetbczpZyK0TVg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv6HQR/0gLexaFXTDxQRVNnf053sR0pirknkZx
 BAiT8Ltsx2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+h0AAKCRDJC4p8Y4ZY
 poWeD/9PwYtqWdcVmFevIkT/24+TXyNX+TbA0st6K8s6D41Mg+tN0aqfsvyhCAeeu/ljEn2rCcX
 HMlf2WBqTqAIAtb80AuDZN5PhwCMVdaNHO4VQstJsCs0EoQ18yx1mASHYHZWwLbV5Of359U86MG
 xsrhof2dpAH9YEeTBlt4o9YR8rJ64LtqveWCzcjcwSld20S6DbnGJpkbizjU2942UDdNkknkTTo
 QlsiqzTu0tYZdYLe1KL2hc0fy+yTsLK2GlPgfH58jIg8op1eGLJQsbmSQg8pa+sUcrzHlArdBGa
 0f63lXciwdnGBVXQIc8+drKWReoagZD6zJvO3PqI38UB3+PUcacOXQrwM5W5c5F+iZXeHYmfYK3
 IIPobO1vhBhU1tTd1mEBP9h/02lHnVG7SjUBqpXTzRd7r2SyuVDlmHRp3v2UwfCTnz/+ESP7Gos
 rztNy84F1LBl5HtsWUgS5c8I8PGWHeD9wIbyLvd+2UiCl7Pw+T780AMp6Zjgi4fsnCtwXovynqY
 laLo8S+hcLQXdJXNckN70rskO1+t0skh04eZzuMf/MrLS7vdrO4VeeAHlpj3g0ePQPH+UdGBhQh
 ZONBJdbsdikC8b4Z8yN8q1yfWKjiUA8sMHG0VX6d7a/ydmseuPc6iJO4ib4Dvv2LnE+T27OCjn+
 9rVvdkjt+C6wg+A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      platform: x86: wmi: make wmi_bus_type const
      platform: x86: ibm_rtl: make rtl_subsys const

 drivers/platform/x86/ibm_rtl.c | 2 +-
 drivers/platform/x86/wmi.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 682c259a849610c7864cc75d52415c782c78653a
change-id: 20240204-bus_cleanup-platform-drivers-x86-40e6e6b4773a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


