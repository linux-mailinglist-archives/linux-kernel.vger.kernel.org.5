Return-Path: <linux-kernel+bounces-29891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E60A8314C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C351F211F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40403208B6;
	Thu, 18 Jan 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPOthjpz"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165522032F;
	Thu, 18 Jan 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566351; cv=none; b=OliqNNjH7M2XaysLlb7+maWkyP4QONQxUXUIQSMLrA2QuEqrYDSxCpZFBfK3OoXsxU8Qs2h3zHybso7SG9hwQbVFkxnfW3fznrjSK5+keURJkuMkdy7Zyc8ogmE3HDBCcf/m/A83gFeB31X+q2CcgbjSlDdC3dTsRnBcxJA1ixI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566351; c=relaxed/simple;
	bh=rjcD1lGmw7xFLuU8IAfAb0NXO+BHQ4z6dDgtWOpRPfU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer; b=GExvcawPMoFNw/iznX54mofk0+X/9kRfxSkLod4SiIWM36o0KMtjftjnf0UTHqTvuoZMm47WRIntS6qo8ieCwz2GluGC1Xd7YBwqBYdp64mnl1PKudUk400ddxynZuIrNqS1E3Wqi4vCHFbQKFOwGVFXkoBnTLR5INtymukwBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPOthjpz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2c67be31edso823971766b.0;
        Thu, 18 Jan 2024 00:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705566348; x=1706171148; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ckg4aZXATh9bXDX8WnAIEQFE0u7PIBO0Zt6Knu3GQL0=;
        b=hPOthjpzJ4+nLYZ02Flklkdfh7+2mh/7uxAgxU6+E4+2em3JHRUlRITXswCeSc3S8P
         qtqtjLGGZJeTP7T3ofGK1sGrdhzNArtg7rphPijrp5Ea6qcvdjdujpJmyCWhUUE4lL7m
         Rhp+RUIvo5XDtuJFvLdCBRpudNaS/hNW/bs/u179GvYL0P5ZAYX439u5xWQYiHJlYZum
         m0+acibrrqwHrXBDHX6YI7tqWi4FXvnxVrqe3HHpSDfHkcuF6DPtFNXfDV89jFsRUR5n
         rkowtQU9tfzQc5Wi92KPMt6/KzMAzsxyvHUukkI9rqEaeXq/mXOD4dZcScGMiNJe6WgS
         fLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705566348; x=1706171148;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ckg4aZXATh9bXDX8WnAIEQFE0u7PIBO0Zt6Knu3GQL0=;
        b=eBWFmIp4mekNoW4SOYBIDPfQg/3H0mgB0qrhPXB5uRnefywtQCwaG+RU/IEIaZc3uj
         cUkB2xP9kWV0H2fvFNt3epaqzKn08PEK32FAtUR0fh0fHP7sKTgMM64pJXjHx7+k+tT/
         CxoNBjYnWV8pKTeY52umlyfqqrKKqg84goOOB4DfTQhO9sm4UOjBbATPREOYz6zxwBdN
         Q5N2iJ9c0+13kVegwjrpYFwmzab7GjP2oKqK+y8bxLCSI92qAj2Y1SmFgAjjWJiiEktO
         7HMCUzT56DK4CHICTCn0Ta01J63DS2p6nTtc+PxmNWBViAjQTlRI5ZfcgIp41HpMxHAE
         +3+g==
X-Gm-Message-State: AOJu0Yy6ntuxYVZlsH2zelmtF51dXMRkpiddoLDIZCZq5l7gJfNGfP4/
	22YKherGvkxDu8vFZS9aRMUw4pdJVObc+nSuaczBrSeBbzU6UKXj
X-Google-Smtp-Source: AGHT+IH+yOi+2MEEHX62qfjwVkyt0comH1cbZHZP2TCk86e1/kvaMgtABMxehv4m6VtSPGcbVR1GBA==
X-Received: by 2002:a17:906:30db:b0:a2c:cda6:e73a with SMTP id b27-20020a17090630db00b00a2ccda6e73amr138931ejb.98.1705566348076;
        Thu, 18 Jan 2024 00:25:48 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:1513:e9cf:521b:ef2a])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906488800b00a27aabff0dcsm8957644ejq.179.2024.01.18.00.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 00:25:47 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	linux-wireless@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] wifi: clean up needless dependency on non-existing option KERNEL_6_2
Date: Thu, 18 Jan 2024 09:25:45 +0100
Message-Id: <20240118082545.22262-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit ffbd0c8c1e7f ("wifi: mac80211: add an element parsing unit test")
and commit 730eeb17bbdd ("wifi: cfg80211: add first kunit tests, for
element defrag") add new configs that depend on !KERNEL_6_2, but the config
option KERNEL_6_2 does not exist in the tree. This dependency is used for
handling backporting to restrict the option to certain kernels but this
really should not be carried around the mainline kernel tree.

Clean up this needless dependency on the non-existing option KERNEL_6_2.

Question about this config option was raised and answered in the Link
below.

Link: https://lore.kernel.org/lkml/CAKXUXMyfrM6amOR7Ysim3WNQ-Ckf9HJDqRhAoYmLXujo1UV+yA@mail.gmail.com/

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 net/mac80211/Kconfig | 1 -
 net/wireless/Kconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/mac80211/Kconfig b/net/mac80211/Kconfig
index cb0291decf2e..13438cc0a6b1 100644
--- a/net/mac80211/Kconfig
+++ b/net/mac80211/Kconfig
@@ -62,7 +62,6 @@ config MAC80211_KUNIT_TEST
 	depends on KUNIT
 	depends on MAC80211
 	default KUNIT_ALL_TESTS
-	depends on !KERNEL_6_2
 	help
 	  Enable this option to test mac80211 internals with kunit.
 
diff --git a/net/wireless/Kconfig b/net/wireless/Kconfig
index a9ac85e09af3..10345388ad13 100644
--- a/net/wireless/Kconfig
+++ b/net/wireless/Kconfig
@@ -206,7 +206,6 @@ config CFG80211_KUNIT_TEST
 	depends on KUNIT
 	depends on CFG80211
 	default KUNIT_ALL_TESTS
-	depends on !KERNEL_6_2
 	help
 	  Enable this option to test cfg80211 functions with kunit.
 
-- 
2.17.1


