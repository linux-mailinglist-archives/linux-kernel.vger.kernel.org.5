Return-Path: <linux-kernel+bounces-72364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0700185B279
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960C9B21BED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C079757313;
	Tue, 20 Feb 2024 05:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnPYsscA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BAB535C6;
	Tue, 20 Feb 2024 05:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408363; cv=none; b=uCeUbbnJWJU5tcn34KiTDCpq/UOQYp/4Lo/Y8+qCdH9AlyhVaWLlUGlqSdiG8Jfi0KbXo+R3644eyfTqH6dEG8X7wkPicb6Xc7KKPWIsrw6K5ZffY0cxmYGt7i3xivL7aZkEENPmgbl3gFssoafMrFr4DmlCOr6PI3DufkQJnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408363; c=relaxed/simple;
	bh=sf6cHFogLC3iWJUeEjZ1tPh41/rXPEDXAcBw4W0tigE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTaAgdUIUlD/yLVyoJdfTXciqrnUOu46O9xdWtexCLNLCD6wj99xdr3TzAXtp9HESA3mlLL/0hrMQOPCruitMpBScdEASTSehKjsJ13K8tMuS5ZsEVJkYH30BwpVWwc1WnNwFinSJXuROs5VIyQ9AOu03B2QkQ0iXeBxk7j3XZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnPYsscA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d73066880eso48797385ad.3;
        Mon, 19 Feb 2024 21:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708408361; x=1709013161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+eLh40wqn/+mK2E6bNVySX3D/F3rcpuKtT1oXgjrJc=;
        b=jnPYsscAlMMOM5RkAOgs+eEQBQrWqL/uPhQSvG0OgXJA1fqtQNraGn8HLKlFhn2YNl
         zD/77pZsjf9dB+jeumzgSudTK7CY340XJmQVSpGgsPokDaWcmXclg2rtst8QOhMqalBu
         ePp/exiW9wg/0QDmXZpGv/1kUscI1OF1SaZSFteNdZliRQWO2BTSKrRSBZY5bNrdANcK
         kmts4GnwC3H7nm/VdqkGjrE47w7GNbgS9jd9dJ+QDOFH1uq0txSNCjCqMqbOJ86feOYh
         PBSugtE7LawSn4iBmFYDA1ikTwkTlv+J+fEHkIwg4L7TOcmG6gBV0tqL5luuwkuMne6C
         n3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708408361; x=1709013161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+eLh40wqn/+mK2E6bNVySX3D/F3rcpuKtT1oXgjrJc=;
        b=iD5zBL2YDgvhPxcDEkyGK+A9lbXJa3QAIAnT1M/CatNjAETnZup/7024nR91mPPDVJ
         2idASWmZOlCibp3gF+crVOG0LE3msCTnvfEbAIYFim9/YqMiod3xtM4HmOPLfsE4fqKx
         BIfA0n53M4qCngYpA/yiLYncEwItPEy9steaqzcL3eQu0iIQh82mf6Nd7+OsUXozqB9k
         5e/AW7V//NeyqTLvwfLGm+CSIC9wlq/uu8PXbfRvnI6XSyv48+PS/EfIYN2/5JADeV6V
         LP9XmBCeFxS5nHd9sH+7PQLlSFOg/fultVhhigE7x9WplzGYIECISQUsnK3zIVvfHTXV
         SKsQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2hrbFsc6ykRjwTsqj7C9ckTP7zxV9nmWJ4S6g/c1A0EEajnRUEVnqcwf16HVw7PInqCs5g2foX2dqTrbpFiMxC4RS3MBltm6WMYwGUr1608IuvxgEHNY98ejC2sO4NS0JCACmLULdYvneIA4zPINY4Q==
X-Gm-Message-State: AOJu0YzyOgUP+Xr8xBNwBw2S7QBOKYVKtNCl/OzMeHzYFAP/rHMXaL4y
	EbFolU5sjCTALPwq5Ev2IiZvpqQGi4ZbC/nXTAUtiXwDUvFdf5K4
X-Google-Smtp-Source: AGHT+IFcxjVomKnuPCfORbFriPLght8Su35SJ1dGpgiKYxDSobtRy+5zXqQv67WgT1eaYRFtnX+E9A==
X-Received: by 2002:a17:902:eb8f:b0:1db:b36c:715f with SMTP id q15-20020a170902eb8f00b001dbb36c715fmr14133321plg.24.1708408360855;
        Mon, 19 Feb 2024 21:52:40 -0800 (PST)
Received: from localhost.localdomain ([110.46.146.116])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001d717e644e2sm5306488plc.247.2024.02.19.21.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 21:52:40 -0800 (PST)
From: SungHwan Jung <onenowy@gmail.com>
To: "Lee, Chun-Yi" <jlee@suse.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: SungHwan Jung <onenowy@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: acer-wmi: Add support for Acer PH16-71
Date: Tue, 20 Feb 2024 14:52:31 +0900
Message-ID: <20240220055231.6451-1-onenowy@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Acer Predator PH16-71 to Acer_quirks with predator_v4
to support mode button and fan speed sensor.

Signed-off-by: SungHwan Jung <onenowy@gmail.com>
---
 drivers/platform/x86/acer-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 88b826e88ebd..771b0ce34c8f 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -584,6 +584,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_acer_predator_v4,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Acer Predator PH16-71",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PH16-71"),
+		},
+		.driver_data = &quirk_acer_predator_v4,
+	},
 	{
 		.callback = set_force_caps,
 		.ident = "Acer Aspire Switch 10E SW3-016",
-- 
2.43.2


