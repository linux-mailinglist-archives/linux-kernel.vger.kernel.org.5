Return-Path: <linux-kernel+bounces-147175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883E88A708A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9511F2525D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF9139CF7;
	Tue, 16 Apr 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h1ZKEsUU"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE013248D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282819; cv=none; b=hfmWIpSj9zhpIfYrndtxPz7zmY3YAlT8kARJ2kddJySKm1Fa6zSqfFSyrUYLJ5W0nXnuhEh4N8I7e7HE/AWHbAbK8Tyo8ixIONlGn+nLB5WjM7PnW8c1qp1r70XJlNHTEFNxgjbEMeqzdSB+j4PSpRyDaQ6yMkqhU89+YrE6WJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282819; c=relaxed/simple;
	bh=ofdmgJd5VzPCJdOxt//1dMUAAyFDN3WtUwt9Q4Dw2mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kt6R1eCdvX6ElINH+XuuVLJDagnHVdRsQXtneHqOHY8Tm9GgZgYroaQzeSkekQXa10/JvbH0NpX1nf142dCVbQtR2U0eAOHmW7FuoYU7mJssuP5h5BmWuaPC6KbXU1oqAjnScUvXOluBVnwiLp5OXj2E8Gvb7SUmjFBI2dQXGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h1ZKEsUU; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso7298914a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282816; x=1713887616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQKlqQdoXWwPEeES/FN9TpeW+WzqvlnmGreawKt4ncg=;
        b=h1ZKEsUUYVBB08p4xsNyMsOQsnnU48eN9gss+kQJKUJs2pgl9X2H2u9+uRWcDw149+
         sdNNqmhLSsKmxaPcVlArKB/sDPbh9+z+zWKfE7n4wvdMtXFrcnigDNiyngnSjS42fgq9
         ekYR7hBSdzlvgM33aoB+4apzQyKeOhaUcI4F8ZHPtJmyQ8RQPrkCpN4bJIx+tOE+mUCe
         KxUtCTtfQJnwbdHsyNf/EaOiDuL0dD7F+wExIBhPFFAraSBdDdePRWVctdkYC23eVfOw
         HoSHACBaEmvXh08zUFbje6p+1bfiD8fobuJQ0SvKKCculhGhhlKavvv3lFgdRlFdss3r
         Lfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282816; x=1713887616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQKlqQdoXWwPEeES/FN9TpeW+WzqvlnmGreawKt4ncg=;
        b=WDFfa8Elk60A+zOymP+qvHnkbb7DKk2oQ33ujBq6c11gjHIFAiJ6W4LDvKJx0rLJ9k
         Emwi4BRTzg7ryp6n5gSCFr7rbbC+XTtjczwCHuY8qKi5MkeRzt6yt8kXaxZb5QUd+8Ht
         7WHSUeryqjjYEth5Box1rh8C39g9ruM8gjK4Fh9WwX2DdBCKwg2dad2kjyAiFw7A6K42
         XAvb7R4p0GtjJxHuftvoy6pKK47gXjtA8ch+kUFbat3OhNdAXz+xkAOifG8Z8V5n89yT
         feL6myxCKuA2v/s5zafTIafaKjeLbgXscnD66vAzvb50JeNcz5RC9Fj9+OnmBJ/WdnQt
         HKMw==
X-Forwarded-Encrypted: i=1; AJvYcCWcHBAlCzgqtwJY00AuJoNGYzfn7dmteNFn6i6TH49SM+63g+753aGvADsadyWa1Re8vI8MVIjGvNCBggT1+eIAiXguw0767FG+OkUQ
X-Gm-Message-State: AOJu0YyvhLk37FVmHMqtXff2Z8mcfcdYaIZBXk2unPs2VpedLKZ6JKMG
	wWBImnL9wLgdXTF5MarTu/EocyhGz5ARTLk3OzrU7Lh82Bq5BLEVYhzdRlBs7U0=
X-Google-Smtp-Source: AGHT+IG5OHqnqUsnTyNTrbs2nYwMJVuo+moQf2T02fHCNlrjfcuq4FRmRxDm22VoPJC4CBn7dugEWA==
X-Received: by 2002:a17:906:c094:b0:a52:3623:f498 with SMTP id f20-20020a170906c09400b00a523623f498mr9213020ejz.31.1713282816235;
        Tue, 16 Apr 2024 08:53:36 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:35 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:12 +0200
Subject: [PATCH v2 11/18] dt-bindings: pwm: mediatek,pwm-disp: add
 power-domains property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-11-33ce8864b227@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=ofdmgJd5VzPCJdOxt//1dMUAAyFDN3WtUwt9Q4Dw2mk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qxOZhJwN+amyZRjgtZoEdl4pUWh8cCetZpi95
 2LCQ/KWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURYIUEA
 DDUtcfuZO39u2gAlupF0qEhOdmTU7v1BrvGt7UBgJQNnNAIdJx4pwcw38kzaVcxs/VJwBF8kosuLCj
 dyeS+BSNX/sXe39SV13zv2A/7Cajr+FXat4cehh3PqXq+oem/pS46y2EjVSpuwig8WEzoMHWajg+IB
 bqgl2bUfXUxg7ZQX3u0+7FcdRTYBCkRHVwTROX0GlfXqsoIqGAUwD1gFdxqRPhr0jyVhklRZRN07CU
 s22WL8eZh+pTXSmYQmbtFFLF8KP5yC7Djn18HtKSuxbPNXNnjbaAZ79ouQ5dyCm6hhTtpaJEeBPOQ8
 BpnlJhYdDl5qb6IbzdaIK7sedFkzKwDuAmebP+ATxYNo5HwH8qkPNGryFKCB4JsIVaNDRNNt4CHt9r
 zrJxCxzpDOCN3vlyoOGQvjEyq7yoeVT8q6++i2ndmp8/MUgl3RFVbr1Qq8srLeyOn1hVC2RpevzT1S
 f3DyogERJynn30zh1Tb+3bkC7vwf9h4XR7259YLQA/RE3jEewRf0iAPxeUsYRrSQziWUW7fRe3d3pw
 j5aeQ+dnpnM4JFhAGYk2gs+fIa613ERanAJ2DzFOiC9+QWW+W96ha4Q/u27vi/uRsXnx35Mmj44myX
 vCuQGPTCjQsj6M1gvir5mdsnpeDwBeek2Lm/PcUPl8Bj9I6uq+p+ONja2rCQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

According to the Mediatek MT8365 datasheet, the display PWM block has
a power domain.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index afcdeed4e88a..f8988af05287 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -52,6 +52,12 @@ properties:
       - const: main
       - const: mm
 
+  power-domains:
+    maxItems: 1
+    description: A phandle and PM domain specifier as defined by bindings of
+      the power controller specified by phandle. See
+      Documentation/devicetree/bindings/power/power-domain.yaml for details.
+
 required:
   - compatible
   - reg

-- 
2.25.1


