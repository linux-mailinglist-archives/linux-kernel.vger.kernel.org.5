Return-Path: <linux-kernel+bounces-82254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2769C86813E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 521B1B218CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2730130AF9;
	Mon, 26 Feb 2024 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOI6cbvZ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580D512FB28;
	Mon, 26 Feb 2024 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976481; cv=none; b=KLCVioI1eHoKgc8KGq6x3z2uYXzD4rIC3I2tTHfYPR5DFBaYOFoQIfPUEoAYkoE9jx/5IA0sy5gmhtl4TY22hhZDwAqEaISp4fAsIcbPrqRkh0ECSxEebgEP10LRuv61GysCbMXzFpB1H7XDDx5N1V778xeqC8t0BBZH3L4Z5K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976481; c=relaxed/simple;
	bh=LZ9TktC3T1afzZRvN0TOC30yL2jLq66ga59kBG/bxIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJk3HkpbXVP8zvjfiFGNW86pbXzDdtYsGsQNTz0YN7MEiITyDVUqPvDihmDuFbssprsKicQRgFfYuRqwLE7mcnPYyAKvwltf6ABM53C9d0u9gFqw5SvcmPhJpqItYdD2NtCENOCIZTb5RwHh26a8AkYUlhwvGnD44FD9b88oqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOI6cbvZ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512bd533be0so4195920e87.0;
        Mon, 26 Feb 2024 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976477; x=1709581277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjiHaDggzrFKsMAmUUXttaUHY0jzI+UD/FYH2klkGCI=;
        b=IOI6cbvZ2YcjRgChvrpkn0BRJDyEDjO/sFCl6NJi+91NY6fxLD4uNkOsvOWgdtGfAO
         6xNK5gLqwFVT8CdUIQ2fEZZXXvXhA8eVfDckxtG8msh+VQowed4G7TiS4zeXdSAM1/CE
         xrLTvUDTwwQpclRttibOxuATcNHI8q8GUaA236+JXD7WIgeuRovDLvToNrnWtMIcGGs6
         jt+UW6m9FDuZsWQaK6B9N1nyy8I9qMo9rhCToLYwdkbSj0ZUnxHiUTGYF1v445Q8gMsu
         Nq6UWFWLusUvffv5tyuvC9G9AzhwjMehIrvwgm1Bwmp6BIfrcIbAjLEi6bJN36PU3uvM
         ryfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976477; x=1709581277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjiHaDggzrFKsMAmUUXttaUHY0jzI+UD/FYH2klkGCI=;
        b=IGIdKEp08vMePlYAYWh3PCdn3Or55VciG9i7p/JTrcMgHDvjGugZ1gHziny0XiMvtp
         T3kqCxeD1HsL626Ya6qfAwca37j4CZxmHkC+jcIUJxNQEPkTtENlKbE7znEn2oLDdd3l
         sN5WIKeCdbqJJa719sp4SwF1unC7udXNKpLrw4iUasIKmeiUKD2nFhCz2Dhqc8QQBevz
         bEjGcH1FISTSv2mELHsZg2satPPTKKmawmyeRoY8zRmYUCrwnveDTl1z9xyUHjuzfyOd
         5H6mzXWmtZA422lcXIhvpvAYcKIa39NF+M11uUgNTpZFuNmBtaI9BgbsBLkqldqhKdx8
         ZBPA==
X-Forwarded-Encrypted: i=1; AJvYcCVLCrT3Jn/i9seshqkYDXqQ0BmN9K0r+9lCAnbTofsi2fcRCvXGpgON5iN7mKkCn/k/SHBza4ucEuGYvneFlLxnJpzl7rkbenkdgj+5iAwg5bwzJnv0ZIbnq7t7ZA1mhTNwdmVS4icTj8k=
X-Gm-Message-State: AOJu0YxslWIKOvJlpRW7qlXwAkRyfVoPDt+uDNhfPVPbkvT7zNwqfIe8
	IrKvFMWX/4/T8GlyO0UG3QbF1tCmOqEgpsO1O0OtbduPzCNbm6nQ
X-Google-Smtp-Source: AGHT+IHk0+kGg8qkAx4O30qkhPyRnxnO/DpdEWeMAUgJB8KQnYrL8v42KTLdnLyAAMPxLw147/sJng==
X-Received: by 2002:a05:6512:3a8f:b0:512:fb30:aade with SMTP id q15-20020a0565123a8f00b00512fb30aademr3882586lfu.3.1708976477319;
        Mon, 26 Feb 2024 11:41:17 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:16 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/6] staging: media: atomisp: Fixed "unsigned int *" rather than "unsigned *" declaration in variable declaration
Date: Mon, 26 Feb 2024 20:40:19 +0100
Message-Id: <20240226194023.69070-3-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240226194023.69070-1-bergh.jonathan@gmail.com>
References: <20240226194023.69070-1-bergh.jonathan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This code fixes a code style issue where:
 * Checkpatch suggests using "unsigned int *" rather than a bare
   "unsigned *" declaration in the code

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
index 23893189ba82..9c15b8a1a93e 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
@@ -187,7 +187,7 @@ sh_css_sp_get_debug_state(struct sh_css_sp_debug_state *state)
 
 	(void)HIVE_ADDR_sp_output; /* To get rid of warning in CRUN */
 	for (i = 0; i < sizeof(*state) / sizeof(int); i++)
-		((unsigned *)state)[i] = load_sp_array_uint(sp_output, i + offset);
+		((unsigned int *)state)[i] = load_sp_array_uint(sp_output, i + offset);
 }
 
 #endif
-- 
2.40.1


