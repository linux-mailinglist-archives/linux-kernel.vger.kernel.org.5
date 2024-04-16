Return-Path: <linux-kernel+bounces-146987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C68A6DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C37B26ACE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D046130E29;
	Tue, 16 Apr 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wc+0ijUd"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55912130A57;
	Tue, 16 Apr 2024 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277158; cv=none; b=KuP2p3cfiiUNWYJc1U1OpsyqM1DojFNAKyO6n4qSGzZoi4nYbPZWhiWNZbVdhXTy6EEdkHoh5SEE/YPzs0a+8iVBJqcJU/E3tWZotpvxKnQm27ShvCUyid/m6c0j529mN7TqsB4olMRIaJ94DvCzfTKF7VbglfVAw1aijcPyVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277158; c=relaxed/simple;
	bh=Nee0klNczzXXdVsbbxNrNAe9EZXbzlkhe7k0ay+DWp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlTbUwJdWFdvDTG8akF6ZAvOwDpKMPaMp5iR7z//HX+0Uv9UGlYizbg3b2vN0VOJ0ndEFfZ8Ne/mayUYV+5pcnS8bmQPSKkoDhSk8tBQhXZi72l8pzfdRkLQWy3J7MJ+8nQ3wzcdN1zwyCkT6eu49LVMyhNCFp6TvRmn+l0qfOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wc+0ijUd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-349545c3eb8so492753f8f.2;
        Tue, 16 Apr 2024 07:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713277155; x=1713881955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPlMwU0r21lmv701IrsAmWv+8jqBp9Lh4gdhKs5vLCQ=;
        b=Wc+0ijUdtKB6wKbUwYSNbw8GVMud0x1tzYxC0s9vgoxJ2LEhT6j4AtikKRcAnGjSDc
         SBvSI/T5/y65ci0bSMpLTPwJESXBOuwtvsLBCxEvosXH/K36LpZpjl2YAZwlkKuf9pSQ
         t7fn/ji8g36vSeJFT203k55sg9tKu19aCXMGJRYrV7x/yxA1225iXTGlM1dxD7Y1vp7q
         ogVKRudA0fOHK/J2eFXwrYx3FmHYIKCy0jenFGydO1clho3kHDMmX5MM8u61pTceLSLz
         js6mQCLOtvVv/PUihu+ZGVPPOJ0i5tSf0FDMpvZ6jZoYNBLhZkN++UnKkp0LkhwtjtSe
         Ahjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713277155; x=1713881955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPlMwU0r21lmv701IrsAmWv+8jqBp9Lh4gdhKs5vLCQ=;
        b=QyrxA3DkzoPt9Z4PkpSXcY7Rz6VAMx8RxolwRDn6XVkYYNeCILRA9F+3HrP3F9++HX
         z/Z9aTlN2TLI/8NrB/gj/ltsbot9/7mha0FMbGGknxCOjkMoq48/XNajCadmOoiLFQFZ
         k1Wb8FPvU9Mlbh8kAcVsNlKJR0QLo1acOBRApiF/yGZBKygiPfHkvyDq6RP8iGOBFzD0
         4ghlQtGUgKPwKVi7NgOU8B6Abz7hJ8AFm/6s0VRzIlsuFYDnPkoI30d8Sy2tmYHKl6Ub
         pFmAYsuzibe0UETYkoYV/I+uHpk0l5rLNrDeHXKfv5rfMwzKY6ECIyXl84MWiF3gbBCh
         yt2w==
X-Forwarded-Encrypted: i=1; AJvYcCUwG/23dEVjxEZ28BtjBsmmqaEHHuLtXq2JHSYhUzjiNw3KgmcP3fdCbEW5iPTPWwYpgjbVk9f3LX3QFMplaVO/wbjblTFVVnsdOKdiW5MLsHyu58wmScsSLobr1Srpka/nS/nb0UGjwiI=
X-Gm-Message-State: AOJu0YyvmhqCmn0cH9PeKT0d3UQU9gftuIr2fGZFGZHQyzJQSWgVGK8c
	FhqcOiPR5WrJ3hQKyS7cPJi7RqwW3asS8w4CtLLFNLq2az7lODJL
X-Google-Smtp-Source: AGHT+IEZzv00yF7BllXr8OH/cKVVc5yOZl4HVoOrPS3fQ9aYwHYUkg8sgoEe5/Vwr79iOaQO4aWt7Q==
X-Received: by 2002:a05:6000:1cc8:b0:343:7896:209d with SMTP id bf8-20020a0560001cc800b003437896209dmr8900303wrb.22.1713277155479;
        Tue, 16 Apr 2024 07:19:15 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation.station (net-188-217-57-233.cust.vodafonedsl.it. [188.217.57.233])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b0034625392416sm15055114wrj.104.2024.04.16.07.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 07:19:15 -0700 (PDT)
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: 
Cc: martin.hecht@avnet.eu,
	michael.roeder@avnet.eu,
	tomm.merciai@gmail.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] media: i2c: alvium: rename acquisition frame rate enable reg
Date: Tue, 16 Apr 2024 16:19:02 +0200
Message-Id: <20240416141905.454253-3-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416141905.454253-1-tomm.merciai@gmail.com>
References: <20240416141905.454253-1-tomm.merciai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aquisition frame rate enable reg have a very long name let's reduce this
with an abbreviation.

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/media/i2c/alvium-csi2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/alvium-csi2.h b/drivers/media/i2c/alvium-csi2.h
index 9c4cfb35de8e..c1453ba885cf 100644
--- a/drivers/media/i2c/alvium-csi2.h
+++ b/drivers/media/i2c/alvium-csi2.h
@@ -63,7 +63,7 @@
 #define REG_BCRM_ACQUISITION_FRAME_RATE_MIN_R		REG_BCRM_V4L2_64BIT(0x0098)
 #define REG_BCRM_ACQUISITION_FRAME_RATE_MAX_R		REG_BCRM_V4L2_64BIT(0x00a0)
 #define REG_BCRM_ACQUISITION_FRAME_RATE_INC_R		REG_BCRM_V4L2_64BIT(0x00a8)
-#define REG_BCRM_ACQUISITION_FRAME_RATE_ENABLE_RW	REG_BCRM_V4L2_8BIT(0x00b0)
+#define REG_BCRM_ACQUISITION_FRAME_RATE_EN_RW		REG_BCRM_V4L2_8BIT(0x00b0)
 
 #define REG_BCRM_FRAME_START_TRIGGER_MODE_RW		REG_BCRM_V4L2_8BIT(0x00b4)
 #define REG_BCRM_FRAME_START_TRIGGER_SOURCE_RW		REG_BCRM_V4L2_8BIT(0x00b8)
-- 
2.34.1


