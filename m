Return-Path: <linux-kernel+bounces-147166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D6F8A7062
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FB51F238A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87E0136649;
	Tue, 16 Apr 2024 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hdopmido"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CC5134411
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282804; cv=none; b=tM/CqmL9vaJmprI0l+ISor35V8fh4etu2E/hxmxGj7rO3VU8vDQyevYaoavG1hVZtWRK/U7R63NsvYPNbx0bD1zW4GLZVUx6gxmA+yCr7b3yXxBg2ErVaMbjgtwIM35MOp8TN6eOCLWj74HLF93ZPdiJ0Be9LmmBtz8h2OnKTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282804; c=relaxed/simple;
	bh=IeDOCl06JfjlPFghfO35UROWR8m1btVVgKsMaQNA6d0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/gf7jpCQnCws9XIZU55zA/rNiwmgd5tboNuPY9+TlKhfDqmT4UZv7uE/BeeH+gN6r7EzNlvT9gW2Nqvg7RzBH+x/3vnbdfbLafz1jhJIu46Bj57MJibcLPgFHjL3tKjBENcU3W4FAmZfPcSDy5bP6E/zV4ve4oYcVTew7GI3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Hdopmido; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso3948859a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282801; x=1713887601; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY9nQ8l4JTZHkXj0RAXQ+RxUAnmtTi/8jZw7waEm2L0=;
        b=HdopmidohNM+HsoijDEm6F1Idg/if+/j45EKIzep3S0ENbD6Hv2TqeIqQcS/LHdFXH
         7psecJK2L6p5k0GBqyT+0jp9L8Rk1MQT37asNoYOf1C5uk+fyMXgUkKxU2ie6bOdny4q
         w4+qACg/66VFlCyelVv5ok+P7/qHlE37eayPcEeAn+kSds96YJJkPTrIxbt3Y4Lp6Swx
         J5XMz5pV8JbVC/O5Gal190IElhDXhby4eXsW2t1siGLVP3HUUYV8qPYR0mD3uf0jQQsN
         DjOD/jEOuFRTQn87AwZBl7m0DBCLirnlATmIM8fKq5dOdjAnU5CnzCFACY57nDxMvfKt
         tgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282801; x=1713887601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY9nQ8l4JTZHkXj0RAXQ+RxUAnmtTi/8jZw7waEm2L0=;
        b=IdUPFzCv2Iv8xgsDfEl+vmZsG6sPjsxbWeAnuJBLduFWEFcrvnmmb1hPLGTYFdiT6I
         RaLHdDXCa56pBdU/KUs37d/v9E8ez1uroJCRPOl4CVZfgzGxGo3m1NN9S32qiiFqvOLm
         P49VnBetg6UGB94TqZV3UsI6iyfJ4xQ5fCj/3O2huA5wUl3Aw/WBc2ty7qQwfEkXFIOA
         CbGSmxg+z+9y50ewRZBQB3fRHeI1/MeLW3Wjuo1iiEQXvpFMkmkTDLEdEZh7n2f5Y6lf
         /hYNnf6KLFDA6CdfuRZe5ZInb4xN4tw2fNCIQL6kSaBIjD3sXYb8ANitFu9AwguM/w++
         s+/g==
X-Forwarded-Encrypted: i=1; AJvYcCUn0qacg6JwLI2cDON4WlMCjridNWXjf93hhzex0Zoe0HjT4iudF0Rw3jsHtEpmU3wsHF+CitOqcA3wvdp0np6fq7qZsjwmXNganww0
X-Gm-Message-State: AOJu0Yz43asCWToLzoG+fGoRVJRN9ZEj+zsv3W9cqmyzm9kNqFftcUbS
	Lp2aRYjxjwPj6fyXtL38ftqdt0+mnNijEXrIY04f8bKsTRyDS+Qj1ODVlmK7IxI=
X-Google-Smtp-Source: AGHT+IFHhEszesK9q09DsR/2xkoSYe02wtLO0cXjArvzx9HgMzPqi6DEF0MkcuxXMCf+zXa2GmXu3A==
X-Received: by 2002:a17:906:d28f:b0:a55:33a9:7f10 with SMTP id ay15-20020a170906d28f00b00a5533a97f10mr2555951ejb.32.1713282800855;
        Tue, 16 Apr 2024 08:53:20 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:20 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:03 +0200
Subject: [PATCH v2 02/18] dt-bindings: display: mediatek: ccorr: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-2-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=IeDOCl06JfjlPFghfO35UROWR8m1btVVgKsMaQNA6d0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7q+HnTXMENk4xikmBtAqBzPzqGGoQTN87rhFQk
 sL5tZI2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURYtPD/
 9Qm+/9xOYNXV0ZxQe+5NoZUD6q0aKZfjTzUxCwH02q5XEjsHWdaLH6zWsDsPkVwMuCKzKcizClDjvx
 NynHcFjOS+89EVdprokd+qZoM14inG7kJ4axYW7ozOAcB6gbOAwBtOmpUsR5/XK9c+iw2vNy4AxL8U
 B4BVG6AfwKhlx0RNzBLgomixGSAddHxIpr5jf0YnvB2LX5z6sBO8FK5P2G3nIbNTu9Q/3q8A6/IrMi
 7md5PGdAKiTK6v2Sl6kdlhKJMUtkNtlPdvvebkfNGOrCSdfnQjhoGG4E+vlHIKBlYIfmLNtQh1tjp2
 xEPAETS0seMkLxfQNT+D574GNpaY3HaHZ9fKa9W+fqad0nBI02IcRjyssJZeDbcz4xAYiw4t1OCIN2
 jyfO79XA6cgbDmS6x+uh/RE3RYZyMNu5O/OILPXtsUVGOvwFqHJnXgCK0Zeh2qHi8jo5GlK/lW8+RH
 0rPz/NkrQRr8Mgs+5xTxN+8cqwvtXvnZh9d8qf3vkjlqcWH5i1lm60sQFjxUcJv8k5ohXBz5hOB2Eg
 zlo5360N1S08YLYo8RpTi3k4bA33I0BRki4k3XzyxiuvjGKtlngWsAMta4R5sSKjbtJWUNAXTxWF3m
 /FiP6xYGFesR7PHXVNjoui9oFDOnQ583ecoKMc1WodBAyB0gxsnDLH7VS5aw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Color Correction on MT8365, which is compatible
with that of the MT8183.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
index 8c2a737237f2..9f8366763831 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
@@ -24,6 +24,9 @@ properties:
       - enum:
           - mediatek,mt8183-disp-ccorr
           - mediatek,mt8192-disp-ccorr
+      - items:
+          - const: mediatek,mt8365-disp-ccorr
+          - const: mediatek,mt8183-disp-ccorr
       - items:
           - enum:
               - mediatek,mt8186-disp-ccorr

-- 
2.25.1


