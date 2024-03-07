Return-Path: <linux-kernel+bounces-95613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317B87502F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE0FC1F23DE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2F112DD8A;
	Thu,  7 Mar 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfV2V92V"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903D12F371;
	Thu,  7 Mar 2024 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818569; cv=none; b=H+TaOwsKdv6txrvTWFx2gI71PcRGTEbehGoQEWuxc1WlDL7uO0OssIRAQEfVrUzp4mopb0FMJyoued3Q/8b0xOsy0kW7uIcaaKCJJQG8QXji69GrqXH5f1HYu/xPAX7kjhFRH5rEmOinQGeW/de4mXYBciodeqyWIn1CQP9s9QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818569; c=relaxed/simple;
	bh=kPd6mmXqJlgeS1LgIgTNMjfo5t5AhILJdmhpHy1uxyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csmff/d9p4QDN8L6spf52w5NHxiyhEnoDdmRmOTn3+exFWEw+9m74L/jnwkTwVksn95N1IztF6rUEBYTrVIno5jdFNNlibZHW/bkn6W3kuA/BArvj6BZ/BxR/JxB7DLxiK11o/XNiUp4R0H/Mriv2H0U5BCCRiGliofStvaWURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfV2V92V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e285a33bdso481740f8f.2;
        Thu, 07 Mar 2024 05:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818566; x=1710423366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1KgEltFIoyV/v4bc8+VtNWH2xoTrTmJYgfHpGTY7mHA=;
        b=HfV2V92VWS+D5YAJ5q7iIgpYNq7QvQ4I+igjFhiXH/BC0/sNu5l9hA1MsXwsmuu7Ci
         BsnzDaM3ONTlcT2rBJQExZvSXj6XC3voEWsossA8VErjfVaTjXbE3ZOxhE7/Z4lRgznA
         cAQ1B/olRhz0v+rhoabEf3F3nd5MLK5RqvZgFGZCARtot2blnbk5XzXCG5S3d5vHGB5x
         hu3bKHk9S7YlJ63QW5xUJd5fLwBpOl9U3qyZ45FDRKFrHzFNolB+jShQNd9Gg9kITyAJ
         KjoipMaDYU9OvxUY0WqeNmNyOG+E5fD56uWsBUMAxF/Vvvy+2g7hAqpJ5T2Oahc8R7Ob
         rliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818566; x=1710423366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KgEltFIoyV/v4bc8+VtNWH2xoTrTmJYgfHpGTY7mHA=;
        b=nUHpETUfBTGiZgM6zU9dpe1QNM/I5cBReEwMawUO1G6sCkgBkFOdKsvtMDUTsQjPAx
         w+Bi2v9qj3nDotrDCLTRIDmzvkZELDCFSImY1Xw3fIfccniJG3kSej4NsfyI2sQePOWx
         8A831QURGRFXW9LR4orxcsN/lfpFF6sW1lRp9hSibKJEet5I5s21DZeeZEqIAM/e82Bq
         nvlvItr7mgBqr2MJ9ubfJxhwpXgNUG2hvf5WxT1x9Ji1bcx2hvIL0RrE0WOaeoZsuK8D
         /Oi0IriRbjMGkkwW/HOpdFazxIAtRkxO92F4KHFtqY+CFoAUCAcErNMcmfyXuTtKD6lu
         WSBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyLGvbxAuhQ2IjzBUdakdFx+r4raHY83Hdau2GdBGe/DRJFsvcG1+GvqcFRhtl4TTYlqI/cgUkXRtUvH/WI8PkFWY1xe+c2a5BrAjBROZGThB+0QCYlhKxpndx+WjU0zjJgCVdNKh8Y2Cdc+CzMLIsidlT0q9Jg0sg6dl4IDfsf2LD3Di3x9utNNZ9Bg==
X-Gm-Message-State: AOJu0YyHPCYXCcb+G38fXIVpe3o0ZXUPsPiBgec0/SBDoN2a/H4eG43N
	9RWZz6ucL7rscYMCfxpJYZItUuNsG1IjVbnkx8xRt4qW+8AdjvzS
X-Google-Smtp-Source: AGHT+IEqqBYmdNbWbOxi/AKixJKzkGPw9LEH2Z2epCP38cLi8XKLklPOQ0wvV6mb+hPFifQflYlB0Q==
X-Received: by 2002:adf:ffd2:0:b0:33d:3abc:8a4a with SMTP id x18-20020adfffd2000000b0033d3abc8a4amr13749829wrs.62.1709818565701;
        Thu, 07 Mar 2024 05:36:05 -0800 (PST)
Received: from laptop.. ([62.23.155.154])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033db0c866f7sm20679901wrb.11.2024.03.07.05.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:36:05 -0800 (PST)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: 
Cc: Erwan Velu <e.velu@criteo.com>,
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] doc/arch/x86/amd/hsmp: Updating urls
Date: Thu,  7 Mar 2024 14:35:59 +0100
Message-ID: <20240307133601.103521-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading this page, some links were broken.
This commit updates links to get documentation actually pointing the
intended content.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 Documentation/arch/x86/amd_hsmp.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/arch/x86/amd_hsmp.rst b/Documentation/arch/x86/amd_hsmp.rst
index c92bfd55359f..1e499ecf5f4e 100644
--- a/Documentation/arch/x86/amd_hsmp.rst
+++ b/Documentation/arch/x86/amd_hsmp.rst
@@ -13,7 +13,8 @@ set of mailbox registers.
 
 More details on the interface can be found in chapter
 "7 Host System Management Port (HSMP)" of the family/model PPR
-Eg: https://www.amd.com/system/files/TechDocs/55898_B1_pub_0.50.zip
+Eg: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55898_B1_pub_0_50.zip
+
 
 HSMP interface is supported on EPYC server CPU models only.
 
@@ -97,8 +98,8 @@ what happened. The transaction returns 0 on success.
 
 More details on the interface and message definitions can be found in chapter
 "7 Host System Management Port (HSMP)" of the respective family/model PPR
-eg: https://www.amd.com/system/files/TechDocs/55898_B1_pub_0.50.zip
+eg: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/55898_B1_pub_0_50.zip
 
 User space C-APIs are made available by linking against the esmi library,
-which is provided by the E-SMS project https://developer.amd.com/e-sms/.
+which is provided by the E-SMS project https://www.amd.com/en/developer/e-sms.html.
 See: https://github.com/amd/esmi_ib_library
-- 
2.44.0


