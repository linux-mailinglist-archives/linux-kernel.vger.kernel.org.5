Return-Path: <linux-kernel+bounces-167064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8248BA3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2A41F23EFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F49845C0B;
	Thu,  2 May 2024 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWmmhfZi"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAF42056
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692734; cv=none; b=tGUtUbJfuWWCl5qPdl/p86UE1a2E4bBoDdHROg1rRC2/DRgSpxRpmzpTM1/c//k4PdEolpDg+whDotCzpSl0ZBvB2vACBlMh/Bszw4QGbbout/KoVZLIZ2tv6c9OE6yJ2f7aRYgwxCzPLODs57hAjSOIK4k6ow1H9kMLOB6MOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692734; c=relaxed/simple;
	bh=7dqAqPc5jtoofxyWnRuoCg8LIeM0occN/PCKEq8ky0E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fi/4eFZibS3Ae6oCG/luBG1NwDXz6t6l5+iGb2tbYmzUk5kZYPC/J5/nrtBCLW3lFny14MmS7tOi2mysDAsRcRQHcnvfDailYfFYFKAPHEwSs0bw7OjT6Tq9KaBffqBmuSTldrwDl3OoMLO8UaUVsn/8+WA74DGRUCMhnARSSeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWmmhfZi; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de8b66d1726so1129196276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692732; x=1715297532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIltuOo/UMxTPopgbTGchZq1egfHJ5nqwS9l0DIwlU4=;
        b=AWmmhfZipE69o6fEZYl7T1l+wuiam8uVOXxEDf7FMEYHjeCGEiuPGBcP92A/ffcyI3
         JUYNqHO8I8ntmC09b1Yct5iUBRqrj7Z8IaJusDkhKEjYXEr5GuV/L7gT2x+4L+E0lSdP
         Z/yeXbTEy7Awt2NdwrMWhVs3SZilqnR+wLDIyZNtqd2IHKUBqLjBqZP3xWWH9k9otaVF
         K5IQiW3ijdP/xNL9szxoaC0/SZvh/v1euRlwvTjkgt/BCD2QZ4lGzexxNvBj03vWPsPO
         l9vM0fQqGCXVMKt4Li1MoPSOVnNEvGK3ZZSv9GeKDTAo+RNX62L3KejVm6dqPoEUNAf1
         Ezpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692732; x=1715297532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIltuOo/UMxTPopgbTGchZq1egfHJ5nqwS9l0DIwlU4=;
        b=tZidG8l0LNCv+ZpvlSSILAb+1H1xX3xS1yfSr9fJqmUuGEmxBUk88lPdX8KqyhaQTB
         gotPWIVpwH16YHlO4MYszDH6wJeWLy8Jg8b5KQdEnoqP3qwUE6Ujhe45nfD1HGR4Ysnj
         HbgCDX0zM4HH5sQfVjLubZapbOUNMJVMvlv6sMAa5ZZRuIT5W5KzuZxFdF8CceCJ350h
         +uEw94Wr4AEX7/l/9ao/d3HljW363NkVfiP5zHeNIc4lg7eMK4Q3KiLDBsJKT/pwNb1O
         04syfcjExmFOxBK0WbAPRkakpoHAaMo94+sXNj3TFEIPvgf2xXAzNGb+ZRhXz2KqUXqy
         f/VQ==
X-Gm-Message-State: AOJu0YxkM3QTugNQTZly3aaliPyul69g++AzVhA4o9LcT4X5K+M50WOe
	c9PVgXpCUCCZeQlQnf6C+mJ/ZyUw6+wtGIdM356I3DSxmbqxasBN78tuqg==
X-Google-Smtp-Source: AGHT+IFghE9Y+h3O2dRvkZCSIo2buTLHl1NFEpbmNbLUtoKsAvBmEIo+HLTbuVvaFzhXaAxLmWybXg==
X-Received: by 2002:a05:6902:2203:b0:dda:c380:689e with SMTP id dm3-20020a056902220300b00ddac380689emr2908827ybb.4.1714692729362;
        Thu, 02 May 2024 16:32:09 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id x193-20020a254aca000000b00de5a5fcee44sm425994yba.13.2024.05.02.16.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:32:08 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/4] lib: make test_bitops compilable into the kernel image
Date: Thu,  2 May 2024 16:32:01 -0700
Message-Id: <20240502233204.2255158-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240502233204.2255158-1-yury.norov@gmail.com>
References: <20240502233204.2255158-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test is limited to be compiled as a module. There's no technical
reason for it. Now that the test bears performance benchmark, it would
be reasonable to allow running it at kernel load time, before userspace
starts, to reduce possible jitter.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c63a5fbf1f1c..fc8fe1ea5b49 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2436,7 +2436,6 @@ config TEST_LKM
 
 config TEST_BITOPS
 	tristate "Test module for compilation of bitops operations"
-	depends on m
 	help
 	  This builds the "test_bitops" module that is much like the
 	  TEST_LKM module except that it does a basic exercise of the
-- 
2.40.1


