Return-Path: <linux-kernel+bounces-46443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DA843FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EA6289780
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAA7AE58;
	Wed, 31 Jan 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXiJcRJk"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE6E7869F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705638; cv=none; b=hgG+JBjh7LT7sxP5U7pV0CUCZ4tLUQ5mUj6oeulR3SGtOQViTqG8bynF5GVGt8pzshJLypfG5/G3aYtqKxROqeY0sDmfd4U8JHMuEz37MRiIK7tvEHqU191zP9+1MUYKGoleuXiyUrSqyBze9C3klWiBVV/0jT4bXiiUVXmL9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705638; c=relaxed/simple;
	bh=JfeMfeEnN893lB7oRpDj4HzmZahwCizVq6qzLQuZnx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+iC4FNxDOKAQnsdjsqQN7OvCJo+hRS5Ml5MWWrDggg4VClksstw5oV29enucOaJGdHER9PBu5pDzr4oCm2liDaPBwW2I/n2fXgD1l6pauUjwYEMzMTykE597ojUFi4CuztQvrFnkrJHiE1UlUrOnu6PaNzPBcHkbh2wEWnlaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uXiJcRJk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3651c87ebbso182060366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706705635; x=1707310435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m7DD5+v6R7La9ObGy1udtBj61vuNh6NTN+5s93nqhEA=;
        b=uXiJcRJkZ2x7RhCMDwTtwLwZLI54unGjkiIa1ihMa7YrEeFKVrrd6BMH3EuCnjTje4
         gvOH2wq2Jddv8xik/G0D7srR2e4Spm7hvn/jxL9Gz5tl0a0wsUSytjTTdtcTsipmO4T4
         5Y8QbDTw7MeDs3m+d1fkFVRkfNVFMYPz2awRuT4/qDYlA39ydlqOPVcI4fbceE8yzVLy
         MAoNY+m50KT7ExXeekfLpNSEUpmn3mBlDm3AG3y5UmlFBtXVKgXThx3MY7ei0j6l0HdX
         zyZC0gZHBi0i5Aitew5tHqORh9WxmRJCEQZ6j8DSJIpotcMlO1TGlJwywL3QzUvQTLD3
         AJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705635; x=1707310435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7DD5+v6R7La9ObGy1udtBj61vuNh6NTN+5s93nqhEA=;
        b=btav31Zc0EF08lPVMskNhObPgqPTx8umG92nLWJ64NNnklAyo5dYbn0kO3KnAUHAhd
         /YFuvKJ6jNxQVe7B3YgKK2w1Mt9J9Rdh56EtJ3JEYhrZ5K0ehjd1CWQvrvffrgnASzKQ
         V1/ukdTSV0skeGg2251jYTIKmaMpkBGW6JQUff2FRyEvp6Lfc2P3z0Z4fZ/ITfEEE1se
         LnbLoVN5beZb9CsGpwq7X7X65PipASXNB4Ra6RtHC8aa1PBqByB+T7iu+pPCe7e528pW
         XCJcWqmmiZCpB+QkLvHpTfOgOQCfWCqiqLYxNxofl+c4FfJdTm7qb2N6K6OcUlRtanuj
         1WTw==
X-Gm-Message-State: AOJu0Yw7uz2WNz7EKUhbhsWAZkZpmcy62zNVsjiV7KsZWuwXYc9x8tl8
	ywEn2WgH/YxJ8MDO+9dv40MJfI1t24wvgZp/UW3mlyzJON3TPsfc2KPvyY9b0NcwijBNjbQth4b
	8
X-Google-Smtp-Source: AGHT+IHh+5E7WDhAyzWWQLM2E33J1ndluJSuDHtMHUT4y5vtHkbpPBVpifO1tfGUIHIFqW68HNw1AQ==
X-Received: by 2002:a17:906:28cd:b0:a29:852c:dd21 with SMTP id p13-20020a17090628cd00b00a29852cdd21mr1040061ejd.10.1706705635294;
        Wed, 31 Jan 2024 04:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUAX5xN8J5gbaX9xvceyb8x4Cb+lAf5LMeiNd8+WxkOWeM7R5zIwvApPFGNdY6hzr+VW8AEQUKOxWA7BObDWUEQEv2Nu40EVAVXZT2zN2IoJ7Jn07tHg1aamojk1vdxaMU2GOMtMqknb4AyfDg3qyTYRs/rlqlcMxYaewIKdKEE3mzo
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a310c9d0cb9sm6092652ejc.121.2024.01.31.04.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:53:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] docs: maintainer: add existing SoC and netdev profiles
Date: Wed, 31 Jan 2024 13:53:51 +0100
Message-Id: <20240131125351.123509-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the list of maintainer profiles with SoC and netdev.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/maintainer/maintainer-entry-profile.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 18cee1edaecb..b49fb6dc4d0c 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -102,7 +102,10 @@ to do something different in the near future.
    ../doc-guide/maintainer-profile
    ../nvdimm/maintainer-entry-profile
    ../arch/riscv/patch-acceptance
+   ../process/maintainer-soc
+   ../process/maintainer-soc-clean-dts
    ../driver-api/media/maintainer-entry-profile
+   ../process/maintainer-netdev
    ../driver-api/vfio-pci-device-specific-driver-acceptance
    ../nvme/feature-and-quirk-policy
    ../filesystems/xfs/xfs-maintainer-entry-profile
-- 
2.34.1


