Return-Path: <linux-kernel+bounces-82257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F48868144
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0E628DF31
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176B131E30;
	Mon, 26 Feb 2024 19:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBq8PWGz"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54057131737;
	Mon, 26 Feb 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976486; cv=none; b=WJmeoCsdI9VaB3Fnn85f/qV64VESkDLbRFs270XGDCT3r3iXOhoakSU7CbnGftUztavCU1WH0Pota6kzu+O5sNTvjahCLMQ2XGWhLvvumfnqM+D+XgS+uHwPhbZQv8kO9aQCufXFywqTIdOwiTdtlX3C4QSEclKhf91VOIgNd0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976486; c=relaxed/simple;
	bh=3LXynpJz35uPYPFQErKfp01pNySda26m/V0BEYGIDxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMbyiJLExeRgJmlD5dKrmuOemQY7nwef3Y7vTS98/P0lZL4pTXJwIS88iS8pFjigzSRcsgdn6pkXrg7THU8eVXVOtn3BMkJga3sAfiNbeTNhLvlqRxqUaY6YwZHwlI29QICghiv905kdQP729d6E9UQ8zuJRHexkK7kJpnrcF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBq8PWGz; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512f7332252so2500948e87.0;
        Mon, 26 Feb 2024 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976482; x=1709581282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGuvBVp+m5k1ETtOCwdqge3NqphlJ/HDGkIyhZQL1/0=;
        b=gBq8PWGzKKxAKY+lTs7glVlVMRCTuEz8188Kmt9TdqbuEPuZlYrg9N+29vikhpjXZg
         ZBiBEX/oRYLq/X3tIrt610qwQzaJj80U4Fgy03i8e3O774zPKUITfKg1XYQeTTzEvkHY
         5uKSCpn2hkWc217yfSSoT6p9P74gRV2elorOJW2Xuc+QYfbInWl/tqk9UZpJ3yT8VgwC
         Pl7AIrjkG+sAQH9T+FBmc6kpq1ylFeAg2TzOtDmS5i4Yx9GbaFmlIxCuZ628iJca02v0
         YS61ucnCXqVjaRUl1qSn5nBIvAXjE/84zSk52HIEivPKekZeDB243gXauywF+pbsHuaw
         6uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976482; x=1709581282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGuvBVp+m5k1ETtOCwdqge3NqphlJ/HDGkIyhZQL1/0=;
        b=PTjnUFAHa4c1eTqe2vFbhTGk6LEsZaJ1G+aE0ZsjjpnqYCjhSE9IIrEtnMRJu4btFE
         WLO2kPlwH3oizrvtKUgdSKMWq4GaKRP7P9ysuvyOfZl0tAjx+dhV7pWS1jpIVkH4oSqJ
         BgaECyXZy69b18de3R5MMgyik1m+yCUHWvGLB9ldPzrPykfK2NsmiRf37elEjKEa7fBQ
         dasYDlee5Ukfdgf46VO9VUNLOnCxjibVuFZuMBt+2oTFxNItUTkjYfEG08QqPGVc0VbF
         ekDDkmWVlPwGoBXZJUU3yeAHzF6Ae585QIn7NinV9buuf48M+swvFfHlTAs4bDSLpuLp
         dqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSL0VyVqZY9C0EtRvIvRtWBTCSBXIm0GrFTXH+r+PVEmFBduT3lvK1q7Vp5Nrapy3NgRUAiuXUOZdTbwb0BiMCbFuAFnngab0FYj80OJw7TjoKc/v3R6pCC4IVXaDzmc06Y9pHV/PEC4w=
X-Gm-Message-State: AOJu0Yy6Tqa2fPwJFJ44frQC8j6GOk5oFCCj6cEHP/rcUTxrAMOrYwW4
	CNQdB3x9m+C9Zi9m469dbcvLZrrsYvOD81dRACeTXQfG7hQSOjcqybdYJg2r
X-Google-Smtp-Source: AGHT+IF5sO6Iyn1y1uJmKrHVW6kTAvcWAA+GU2ZstxFzIxf6uUOGT5w7YCp1Zo1K0LmA9zhQnmJIDA==
X-Received: by 2002:ac2:5b0c:0:b0:512:bec4:19ae with SMTP id v12-20020ac25b0c000000b00512bec419aemr4640366lfn.60.1708976482486;
        Mon, 26 Feb 2024 11:41:22 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:22 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 5/6] staging: media: atomisp: Remove unneeded return statement from void function
Date: Mon, 26 Feb 2024 20:40:22 +0100
Message-Id: <20240226194023.69070-6-bergh.jonathan@gmail.com>
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

This patch makes the following change:
 * Removes an unnecessary 'return' statement from a void function
   implementation

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/media/atomisp/pci/sh_css_sp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/sh_css_sp.c b/drivers/staging/media/atomisp/pci/sh_css_sp.c
index 281cbbb89a14..3ccbfcc553fb 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_sp.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_sp.c
@@ -642,8 +642,6 @@ void sh_css_sp_set_if_configs(
 		    *config_b;
 		sh_css_sp_group.config.input_formatter.b_changed = true;
 	}
-
-	return;
 }
 
 void
-- 
2.40.1


