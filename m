Return-Path: <linux-kernel+bounces-74244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1A485D184
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866161F23B66
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109203C461;
	Wed, 21 Feb 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mA55ch+d"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA53B2BB;
	Wed, 21 Feb 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500970; cv=none; b=pNIWdoyeWDcAjceEMSufuIwe5aMDlPJ5fIP+/rQQH5mT6ND5q+7yfPes/M3qj/9lmCRTsdwhvtrkT/mUitEVO/38ga0M/EdsV1t6XNRvdehfT95wjyCkBCB7Mn7jE0uqwLYAKIjAVflxioyuKHspBK6qzvA+wMB/r0IZhjlzlCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500970; c=relaxed/simple;
	bh=4x1gKlUXgIJ30tUDf7PNApBvh7+J02lCw/2+XUCipmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggmISc/h5Y5FQj3wkXrP4t6+tMV5kDb1RpoXGKTIwH/yY/q5BD4wX7ZAr6+6CqZanF064trp2V0pThtx4vAZkTXJFbnppi50GbYbC4Hizjy6AssKp+tynRL/S1pZrchW412Xb3Ai/y9deG6UeNGjK1DsySpuzSbN0Em8Q4NkvTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mA55ch+d; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d23d301452so3270641fa.1;
        Tue, 20 Feb 2024 23:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500967; x=1709105767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s5S7Rjd01NbU6qXT0lu7h6Sx5qHS9b3jLYRU5TvpOw=;
        b=mA55ch+d1kCttncDchu8IBSQNcUCuF4j6GE7U7mK5VZrL1msux1KpmF5WHIMGb67SQ
         7l4E5bT8JYvQlQF3vxtvTGoj1bP8/QPt9l9agqRrs0lNW7wjSdCvJmK//almoEbxpOpy
         h0kyOQ7df6e/ArUHdC4DceXoYQAS7OYRhMa+I0I2E+/RcEFQtWxK8e13Kd+IsnZwK/l7
         6WhBD6ExRni55wEOaYV/Uq4xEn1mrNUNs11riEzYhgUHRJxbFp7L1frG16TWejtrDg/I
         j+rhknKXwFf6Kd0oPgBKL6mC9Z4Ss2ZyOamYZjhUM5cvXcPxxThW0tPw05SgrQsyWo+t
         0hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500967; x=1709105767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s5S7Rjd01NbU6qXT0lu7h6Sx5qHS9b3jLYRU5TvpOw=;
        b=grE8wJwbgfzSoAmQy/+Y+3FozI/8Ky1Y4k571CCt7CkS5wAnhPFiXyT4GRXwRuYra5
         4XezTcfY+yKFS8X56yTq7yRVqy3WXiDCveUlrd8Iy885wr2RWpm0EP9nNb5exj2kFZ1C
         et1W8Uxo6g7C1uDbToMwRPPU5OiT/Tc/6Ui9mpSBCxhuUm/6zQ/Y370AVGoO5tp6Z1QT
         m5BMYItfrHQMnc3vw/SNn8aJcJK6oqAQq0/+JVei+GyEqQUjwPaoEnBcrYDbIByXwpJH
         dWVfDJYCyHZsJHO1kEmZt43KzdABvPG9RQYUCK5qQxqEarzOKJCBsahLh5gAww57Ur11
         h3pw==
X-Forwarded-Encrypted: i=1; AJvYcCXvCdo/OVzxyqVnU2Y+xEhZTu7N17L9FfdgKDgzzDbQbQUsLCtfUf6s+dj1X+NG52JoGrLTMqTVmWZt1JG/mk0WIs79Mp6HMUsDUqP63zeoP3ESDT88/b0Bs68YcGsf4bMrdWJudG9qlA==
X-Gm-Message-State: AOJu0YxvzwOK3i35tVCNnmvmLFG3zb2UnReDxcpbOjQ65hEWOOLBfgAM
	ORfWB2Hm7qyVaDCIz11lJ9r/c+FM1PTDNcCljJzjQU0kNu/jDGnZ
X-Google-Smtp-Source: AGHT+IHf9ihh+ukC4DGvCnT6oFM/5FyFNb3aV2Gky6aCyQwGpqA8iWryapoTZDRWQfq2B9XpuPeQLQ==
X-Received: by 2002:a05:651c:210d:b0:2d2:4c08:a865 with SMTP id a13-20020a05651c210d00b002d24c08a865mr2914185ljq.50.1708500966802;
        Tue, 20 Feb 2024 23:36:06 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z3-20020a2e7e03000000b002d0f99a7fc4sm1722330ljc.79.2024.02.20.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:36:06 -0800 (PST)
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
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/4] dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
Date: Wed, 21 Feb 2024 08:35:22 +0100
Message-Id: <20240221073524.20947-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221073524.20947-1-zajec5@gmail.com>
References: <20240221073524.20947-1-zajec5@gmail.com>
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


