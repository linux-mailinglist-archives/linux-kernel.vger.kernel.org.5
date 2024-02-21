Return-Path: <linux-kernel+bounces-75037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53885E201
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE8228593E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21780C1E;
	Wed, 21 Feb 2024 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="breAbJ+L"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F9878B70
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530824; cv=none; b=moz/4QNPiID54Q3nMcvifx3maBUs1blQeqvTJW2SuvLSt/dm/eWczzPxZBhvP8XxoSpcZetd3T1iRw6SaovamjOkEjyAbwhyBr9/1bmU/Y/nFXz6++wVkGCGdzFc2m6dm/eCEH/94ubX3zflBcmVDmHr5yZBZwRzAoYPgCCiZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530824; c=relaxed/simple;
	bh=6xz5aPsBX0YzguHEclK1HApba8bEXqvZsyMAcdJEEvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bqUnVAdo8sZaFe4ETA5uTVKPKgxH6qC23SL5sMojNOuFQ5372e6AIz2Rsvn8KfVrXFI/y1E4/Ad2XrIUlapAnHNvfEjSLqwWqc7YCqaZwNuS2LkIxpmEwqNzogNK0iPBwbVXPM3awcPYbV389/RscsHmD4g0rlYwKx6JT1ueTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=breAbJ+L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3eafbcb1c5so384951366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708530815; x=1709135615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s6LiTvJMvbPXcFOFTULZCUqQBYVsGw/MmQXT/bOYE7M=;
        b=breAbJ+LZ9JDL9EZojt2ShbtqU8MQqkSZHZoDVyOrBT5q8L7FWasQTRZPdtPUxd9MT
         zGUW4bEJAFzSeoTgK8kQHAiYZ2PIwfzQuQdDffbVcYGZsfaQ4z9bxSkNZI570ajSF5QL
         op682puROYt6upa16O6M01fpKpwLU08Jc/Aq6RWtGi9CO5s5/9Nvflly9A6pNubsBM0w
         X6mFxSyDrkvlm+Kmp+M/GinHCJyjj2+JKqhMt/mJGPlm3mE6nqcOQ0401KGsYk+GLWS4
         +ZwpjdK0sl+tsVI05P1g95cvJMFliABxAOjKKWPsGPQPCxhh3IbztwtcuT4UalgOUjJS
         TNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530815; x=1709135615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6LiTvJMvbPXcFOFTULZCUqQBYVsGw/MmQXT/bOYE7M=;
        b=vud4CS1I7QcV1UwPotYMbnVSwDIxIt4xYzNfAznldRg3V7SXHV7vEWQ18M4qdSOqHJ
         2B1gXc4wTwNkW+Nlb381LP7L+zMvikM/OENPcFzGJWl0WuGmOrdllGSKn2oG66VU46B8
         3z2S6EgFFlYgjIsIc9rPRyCA/B1LWEZsY/TL1cSwe+bDB0bKKgJm+yl9PC3LjakPmdze
         AiKWSBGhhpRck9CnmyODRIYLp6/YQSG2laXWt6BRwzF5HZ7G+L/qlNDVf30iH9q61M2v
         koboKKPbtiF7ReiIsfnhnqsnejRf9wvbHTycIQQoCzYrAuk4hZKDESN8mHmOyxWLaSeN
         UcaA==
X-Forwarded-Encrypted: i=1; AJvYcCWQyVQJ7Y/uJoDR9mhip1kurXKtlhL0M9TswgJV8Beigyqn9vcY0tMGSPdMjFvK6odGGUKfO9Ym0j6ri6AKaxqaBNBte/s+SCLOOhFo
X-Gm-Message-State: AOJu0YynHTmIAFWLa2Af3dJsl6nj0mkf29YxnFt0UKsKgzJET5fokeSN
	CgYkaQ2nbAP04riyyhqXabLz7qmz+vgZtJswaZjAJH0oNZIodv1bt1y+teEyQBg=
X-Google-Smtp-Source: AGHT+IFE4zwxFjCJHrZAERl3DSemXFsfva9O1/7EkX0FhQTwRi1fB5VCpX71HZcX6YL+bcfO1EQk+w==
X-Received: by 2002:a17:906:c794:b0:a3e:9885:954a with SMTP id cw20-20020a170906c79400b00a3e9885954amr6409023ejb.65.1708530815542;
        Wed, 21 Feb 2024 07:53:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a3f2a25d84csm927556ejc.41.2024.02.21.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:53:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	arm@kernel.org,
	soc@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: drop ext2 filesystem and redundant ext3
Date: Wed, 21 Feb 2024 16:50:33 +0100
Message-Id: <20240221155033.44160-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4 filesystem can mount ext2, so drop CONFIG_EXT2_FS to make builds a
bit faster.  Drop also redundant CONFIG_EXT3_FS, because it just
selectes EXT4_FS.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..08a4a3102f08 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1571,8 +1571,7 @@ CONFIG_RZ_MTU3_CNT=m
 CONFIG_HTE=y
 CONFIG_HTE_TEGRA194=y
 CONFIG_HTE_TEGRA194_TEST=m
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
-- 
2.34.1


