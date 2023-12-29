Return-Path: <linux-kernel+bounces-13273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7488202C2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB981C21A52
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E3F14AAF;
	Fri, 29 Dec 2023 23:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4fyKLTG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7409414F63;
	Fri, 29 Dec 2023 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d5adef341so30847535e9.3;
        Fri, 29 Dec 2023 15:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703891231; x=1704496031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vDk6yXubdjleW8KS/Yd5sSQPNErxsx6AQraKAf7z34=;
        b=j4fyKLTGIIHjNof0pM1qcdiI9x77g1InHO/m9XreeA+oKmBhyje6qx22XWedSK5V+b
         eUkgQPsGEYACZy6cVCX4Q2uekB9ICQcIFjtQyj4NU6pnk0XTQlRj3qXdvAWSy4JEumTj
         T8+khs+WAbDvDS+qAhQt3EX9kS3CXc6jpV/YOHQwYC9Uc2x7Gsr/aJBZhEYptpjvbKLz
         5O2ltO+pCzpwIxv+lsuvjKp0xYqu7LqpxRk++sShfX6/9h7uaPh83H0Ig5S0pQBFNERO
         YDOOmpnQK8ZYK7JQA6YLG7n4+gIAOBFgF6lzAUZbri9ciucgrl7Mf6PN9s2GjP0DPRAE
         fsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703891231; x=1704496031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vDk6yXubdjleW8KS/Yd5sSQPNErxsx6AQraKAf7z34=;
        b=InPybni4XTxzKtcK4sb7a4Ypa36v1hDyNZ08BnxdzEMojGhnM2oqtRSfSaj03TBqgk
         9tU3M2m+ldXNwy3676VKFNYPgZgBUu0hCpAEHJhryFPJ+ylrzjiwpM+IFWvbuRKlrUP9
         /oMmiugoscZF3PEic6/Q+GXoO4t6y0asKQFfSUkr/MTzbvy/0kk3uBbbr8aOn8oEvHHc
         W5exKzIyEMiIzfS5Mafb+v3CHJ/SujHN4BZf2rqysaqYKnhixdA5hUc+y0ZBIn1m1I7k
         s6Or4bApx6KcrcD6g7LbPVGm3nkErGRHHc8/NlHsgOh9FFAo2VxT5UalFAYHjJN8OZie
         qRNQ==
X-Gm-Message-State: AOJu0YwAc2i56HsZgN5OhWYWdEdieGU7rezmjM6QViIV4pEj7ek27wmv
	srNuV30walDLGjtbDARgWV3c+9vTylahww==
X-Google-Smtp-Source: AGHT+IF3UYBCxCiNIMXnJZC8QJViApDP2JWnU8Qnqn5rwy+SwWjB0hPF7mhaFrbh/V4dDhkOIOCtzA==
X-Received: by 2002:a05:600c:4393:b0:40d:3cdb:5dca with SMTP id e19-20020a05600c439300b0040d3cdb5dcamr3992985wmn.316.1703891231325;
        Fri, 29 Dec 2023 15:07:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:842a:1ce:5301:f733:18af:2fff:3d3d])
        by smtp.gmail.com with ESMTPSA id hg10-20020a05600c538a00b0040d7c3d5454sm2922681wmb.3.2023.12.29.15.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 15:07:11 -0800 (PST)
From: Dorian Cruveiller <doriancruveiller@gmail.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dorian Cruveiller <doriancruveiller@gmail.com>
Subject: [PATCH 2/2] Add driver properties for cs35l41 for Lenovo Legion Slim 7 Gen 8 serie
Date: Sat, 30 Dec 2023 00:07:03 +0100
Message-ID: <20231229230703.73876-1-doriancruveiller@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver properties on 4 models of this laptop serie since they don't
have _DSD in the ACPI table

Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>
---
 sound/pci/hda/cs35l41_hda_property.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 194e1179a253..8370da3d14a4 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -71,6 +71,10 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "17AA38B4", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B5", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B6", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
+	{ "17AA38B7", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{}
 };
 
@@ -377,6 +381,10 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "17AA38B4", generic_dsd_config },
+	{ "CSC3551", "17AA38B5", generic_dsd_config },
+	{ "CSC3551", "17AA38B6", generic_dsd_config },
+	{ "CSC3551", "17AA38B7", generic_dsd_config },
 	{}
 };
 
-- 
2.43.0


