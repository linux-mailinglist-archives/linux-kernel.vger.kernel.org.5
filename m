Return-Path: <linux-kernel+bounces-82179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F83F868052
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCE71C23FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4617C12F39C;
	Mon, 26 Feb 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hltUacoi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42612EBE8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974176; cv=none; b=iOw5o3dcaZn+t1EwfhpYCTM7n3Zb5WpfggoCTWCG3j/ihkEyx78lxxC6rQQAAeVbVKrKSafkQEKVTUFu1/SIEkg2iNRt0TZMl/AnTxi+LUKuQShMXzgiDH1bmgRcRhGFxAzKp9Sy3ozxQw1Q1UMTS9ZIxCqKdnOGywYnRKXoluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974176; c=relaxed/simple;
	bh=cSOx6sLrM+VFIe3l1eAHUzd6YTgL/QiWpTBCbztEAAs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IJS0RXoZtDzTkzNUkW5AQvhuUYqWgJ08289vP8FnKoKML9y5OgYaUwTvCBg9RIucI5GQ1sCOFZUerL6YbGbBB0oBgCkcoygAwl5i3vb/NVfH2ca5ew160aXMWrrnACXdgoxbPcaVxwRBaKrhX252zGdu4lCfM0uVEhdfsKz/0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hltUacoi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e4f3cbb518so887229b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708974174; x=1709578974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GbKtP8KDSOrYkQE9kgpbqDQbm2VGRRUZbNQNk3IXC5I=;
        b=hltUacoiO78HPZZpWjLccoLJBEUea4TBFACwrdskz3RY6EMSEnANzlfqHQz9fRD6dY
         Of/43L9yjCcLvTmTsjqxBUTFIw5aSV5pRSMHUhRnnoybTQ2wV4uPq8nwnoOf6S3BrNe8
         aCGRltqFgw1Mk63QZtZzmafHXtNVSg6uy7pLu0fAtCAAMOUy9QJ00gCTq0gPhWTsm4vY
         LXzosFAqlsIUPSy8SbC6wtRUhlbG83rDCGpuelM03bhkLtH+FKeepL21LiEiYG++nvUa
         GtIw75v+4MynHgyYLvmupMAaUUs73H6rO7aTcEwv9nk7jQYOrrzxmPH5uraJGen2ZRBZ
         FHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708974174; x=1709578974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GbKtP8KDSOrYkQE9kgpbqDQbm2VGRRUZbNQNk3IXC5I=;
        b=omUR61bFt2FmsGGZMEQnldMaSYp7KYDUIm1pkCFwM6D6VLnTGVKx00XDGLino614ac
         A/szfMJHRT8Ra1+ODJ8tg0K55wmyBlV9nCXKA27f6NhRZNdBfNo20n9yYoTt5o/Pb5iz
         gGkidj8kWSIJgvJ0ts+L66NDOFqMKYl1taiYU6cRnOZcF9R5tyfRRTcpQJfPq29iiDP6
         Vda/Qo33EUEfiVR99OtKinKdLBO3kELI+/oQZAoO59kMcAE/T4GEC8Q8aW9Kw/P0c3xZ
         jUbEnpU7i//BXHBd0gaL+r0sw0tDwBZOb9o8N9xI8S5BBh52bOqKpW8U6HeT0jLk5z1H
         ddhA==
X-Forwarded-Encrypted: i=1; AJvYcCWEupLM1nr+mK458CPqhxjRAeYh2mFTxNKVAkWe9RW2sTmV7I4/FQ9PnfTKCxmAzPdaJjnFylCrkJKA0MuFCurCdfPtJ4eibt0qEBzJ
X-Gm-Message-State: AOJu0Yz7hIWPszDzeJyGyRZ61RGTzvJDUc/38HFnDagyXmQpLc4Xk6rQ
	3j8I5TZ9Pd7+l6T2kjiuU2rxsD1Ts+FiYzwq7Lcl2ImTgHBgu6lZ
X-Google-Smtp-Source: AGHT+IHePnOGpaJBQGUtC37aPUNJR9tUv/59Suj881Mn9ReQnwXZcj+LlLbcqfQGpZf3xs7EuMHS1g==
X-Received: by 2002:aa7:8653:0:b0:6e3:b7cb:b110 with SMTP id a19-20020aa78653000000b006e3b7cbb110mr6469716pfo.30.1708974174449;
        Mon, 26 Feb 2024 11:02:54 -0800 (PST)
Received: from localhost.localdomain ([27.7.16.213])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a402000000b005e45b337b34sm4319656pgf.0.2024.02.26.11.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:02:54 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: suzuki.poulose@arm.com
Cc: mike.leach@linaro.org,
	james.clark@arm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Subject: [PATCH] Correcting the spelling mistake in Coresight subsystem
Date: Tue, 27 Feb 2024 00:32:45 +0530
Message-Id: <20240226190245.789200-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes :
	- "avaialble" corrected to "available" in "Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc"

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 96aafa66b4a5..339cec3b2f1a 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -97,7 +97,7 @@ Date:		August 2023
 KernelVersion:	6.7
 Contact:	Anshuman Khandual <anshuman.khandual@arm.com>
 Description:	(Read) Shows all supported Coresight TMC-ETR buffer modes available
-		for the users to configure explicitly. This file is avaialble only
+		for the users to configure explicitly. This file is available only
 		for TMC ETR devices.
 
 What:		/sys/bus/coresight/devices/<memory_map>.tmc/buf_mode_preferred
-- 
2.34.1


