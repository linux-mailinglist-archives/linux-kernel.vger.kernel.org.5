Return-Path: <linux-kernel+bounces-105579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74CB87E0B3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DA11F214F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1422626;
	Sun, 17 Mar 2024 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+OkOHl4"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63472135B;
	Sun, 17 Mar 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714741; cv=none; b=T08J5FXmTtiwUN0mQtOHoFhYyDqGFTNxn/++91vD4PMTdXTCBtTlKZnz9LFx2bfAwW4JBt0/SP3pnICINqIQ/j9ErbEElcRpI6GmBdgXSIkKiZeQD75cumz14irKa44hTr/YxFNjWD189CcMA+GRZAvvrRxFIoqGxZIVs/q4CMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714741; c=relaxed/simple;
	bh=dHr9Q6AK8e1ReScKhI+4HGEeOhl5Ub1OKxN596mIEOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/JVSYOrP4FMnQHW1PgGdjOlHxMItxIi6YTGpwc9BvoazXXEa6OR08003zZKrs+7GpuVE6mD6+YrDbqL1xBGbU58K6n3ckReJKTu7Uj+S6Xn+dt+mbmcGGZaSgHhAyCNApv3wHqjY4A4T3DNoRLJBSGjOndLyf7mMIShLLfBs/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+OkOHl4; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513d247e3c4so3000995e87.0;
        Sun, 17 Mar 2024 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710714738; x=1711319538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcJb7bj0vF5Nl8yAX54/kA3qijtSrrqL2OLIzgs28DQ=;
        b=f+OkOHl43SEfzSQGz6wQcTIjZBK+mnH0ZIR5NzLTDKdRnerFhUa2LBmQSnyMNqYVaa
         nfpO/AxSdSeV9QV1Fds5Ioiq9gFATmRXs9wX5oD7/V6vw3Hw9IcwbSQRNuibe64tpN0w
         Nyta3NdLRi4NOJRm0qqmfOcHkLof5t5lHcts01SF4bhcgy0g2DqoHJxCesZWXE3CdH9j
         wTFgh/ohS5ipNSEP5WvVX9iqXUK11lKMxeYAGeq3vb15HV+G2V4ULZREIrEOWLwUA/eS
         wWNDima+6o+cUD5snpk2MvUjdtS5MIUCFtFrnXpfdFDgrtcxVk3KoyMiOdgR0LNbcSyn
         jQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714738; x=1711319538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcJb7bj0vF5Nl8yAX54/kA3qijtSrrqL2OLIzgs28DQ=;
        b=k25eifyyfgcohuDJ6/rqikqWTfLfx4v52nU6toj94GmZuyIVhUwP88MpgOh8JwNGx7
         vbWqYYV6Uj2bjmw3Ry4qBbIxFHKFy55CChaGH73bbV6wxMmDbln26YhvcHp3y+ZHjjNG
         I0esYGg3UQ5XMDz9IlUGn8ATxZp4I2ud/lLn62NEXBu4i6d5/nUYGO/BxqwKlNHd6Kn+
         cnVwrAdlO7xLNHTKSC7WWrtjx5LpSnqOgNgh2s7KB/tBXraXuec2v4dIxSfqe6O6r5Wt
         DtTQdxKCuaOxVJ+q5/cbSku7yaSnBpmXMm/NPlmltLPSlZb2abajNRHZLZmC/KfITLGf
         hB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDpN3eb5P+XEDpW5ZqvWlUTUAQPGBovZHyiFvowokHSRGWl3d5bo5ZBAfLTa/pQbhAnH/71nO3HiqDu9WtRMLyoE/QbATbsPJZSYPI8kdnFralBB8Xt1SqPOKNd0ulVKgYatbFpIpyZw==
X-Gm-Message-State: AOJu0Yz+5WAu2EeLcKNVzPrYYSFgF0eTlXugfaFg6TEJmNMncJVDJQJa
	VOLLBBG7CDS27rHRctjOoiNO73FvviSpvv2Q0aYVeqtK4t06PzO9
X-Google-Smtp-Source: AGHT+IEEH1HCri2jgaEj2lmkHvpY4OJN9Rt4WUseuSkpkZzIe0tbV3kDqycBsohBoHJp9rcz/JDoMA==
X-Received: by 2002:a05:6512:3134:b0:513:d1d9:9eda with SMTP id p20-20020a056512313400b00513d1d99edamr3571987lfd.27.1710714737896;
        Sun, 17 Mar 2024 15:32:17 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b0051322c11100sm1366981lfn.221.2024.03.17.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:32:17 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 2/4] dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
Date: Sun, 17 Mar 2024 23:32:04 +0100
Message-Id: <20240317223206.22033-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317223206.22033-1-zajec5@gmail.com>
References: <20240317223206.22033-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..1cf47db94c57 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -85,6 +85,7 @@ properties:
           - const: mediatek,mt7629
       - items:
           - enum:
+              - cudy,wr3000-v1
               - xiaomi,ax3000t
           - const: mediatek,mt7981b
       - items:
-- 
2.35.3


