Return-Path: <linux-kernel+bounces-78108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D3860F04
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994211F22D30
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BD5CDD5;
	Fri, 23 Feb 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+A0y8VM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CE1642A;
	Fri, 23 Feb 2024 10:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708683437; cv=none; b=nYPpWhldYwytVHJjCu3Ju5V6yHP1anKw4HaKPL1DtGdzY+7JX0SrwF4Wss8n66E2g3ySUD9NAp7202nJpTHOq7s8X3iuZYo2pK7Ptf8zVeBh3KrE0SHyr2vXmewa7d6HKc4T3mS0GEWhtfb4jsCAwfKitwuYkEYsglnwq0EVS/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708683437; c=relaxed/simple;
	bh=c0OZTON+IyLGK8jH+PJEy7n9q6DXqULXWIdoEBe68IY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WZB5oFQCJygWW5Trt/ZdAMeVd/V1C3cqmCGnlI3Mk2p9khdigRXIY5Yd+Rl16hjFt4ipkle9RTuD2J5q1Cm5ePBVpC91ugoYdXNcdpHOSRQ5BGUYZ0iczAiahe+UawXnnsEZhzJjzfM60rsWustLVF99w9AFl+KL8gwnKPSsHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+A0y8VM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so31688766b.0;
        Fri, 23 Feb 2024 02:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708683434; x=1709288234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKqhZPN7QFsjLPpu788l1fzAnbgMEFuSuh/7MopxlUQ=;
        b=S+A0y8VMZ/dBZkdTX6CrAXWp6gsY2NWqWADeItrO5jEr0P4vrU10nd1/6HLWTa1EeF
         KdM8EsVCWmwAiPD8LrTHRySK9I0At7xLSMl3jAoo0Kj5WNWXRZft9zRQGASvSUxbI8nk
         h5HMfMQtLfrb7maSAyM0xI/5mnzDY5l8x7j+Ih7IQU5iCj4hOh3yaDjmvgTFPw8A/bEw
         fzd2p3dYgY0KR/GiyNNC8xHilM+6bqdxc1XlRBraBoM7D6gK5XnfaR6R8olpIfF/o0IE
         U1qWxtERRfTkykofjHqAX1eUD/VvYCnn6SQymDTxygrMKQXQupzIplH/OoLiXpgMRkyD
         5k4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708683434; x=1709288234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKqhZPN7QFsjLPpu788l1fzAnbgMEFuSuh/7MopxlUQ=;
        b=WKZI8RiYYzsH15/67HOIKPqCluJ06oynv1KdZ+ShLIcpy1SXtEaNozadKTfUPwg97U
         REGCTE8zGvYE1B+8yT9M72DDm/T8H2Cce/C+edWjcdC6ZGJXAB4IQSawAkRQ26eUXpx3
         fdcZIuoGrAJwXP9Hqh1DHEzZ68SW47S43gsM2ZE1CFf0Tmzd2qDrdXPEey/tAljOCdJG
         NpA16qhEXScAfV5Y2X7La9L6Kayz6mK2KQn4AqLK6IOEGneP/xnOTCjd6/V4JAauAxfi
         hjqUx8KgOWCYXNqeBDY1DcQ0dVpVGypp+p43SGzyPPaquQgY1soYAZ5eJ1HXnSBvOlrS
         J8gg==
X-Forwarded-Encrypted: i=1; AJvYcCVigVY4L/ZzdchEB5ofSqPk8G3tmbRz0TUglck40R87wcS1pscPg/SM+YjCDEZclUrQHjAQ2V64jFhPmFgDTDqBiVZZphYld4WfLqtT/4sNZGLxwunY2uGdcKuqRmP/5f3eRIjd4j4bSA==
X-Gm-Message-State: AOJu0YwpWwE4rg5VEnMe30TQBsDENt1HcgCeUWi8UFDbV4XKLy8l9OEY
	uJavDEMpR61r9/Z6eVcsvT2FoyxANTaYx+/I1AvZjKZFbXKEfjdy
X-Google-Smtp-Source: AGHT+IHoB9J+dJYQcazfnWb1yekpQwyTDdvcQJglDlRe3xWoGrqXygy9/ozIWp27JxUIezptovLTJQ==
X-Received: by 2002:a17:906:b0d3:b0:a3f:8f30:d094 with SMTP id bk19-20020a170906b0d300b00a3f8f30d094mr927527ejb.44.1708683434188;
        Fri, 23 Feb 2024 02:17:14 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ti7-20020a170907c20700b00a3d99dc3f3asm6667250ejc.67.2024.02.23.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 02:17:13 -0800 (PST)
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
Subject: [PATCH V2 0/4] dts: mediatek: add Cudy WR3000 V1 wireless router
Date: Fri, 23 Feb 2024 11:17:05 +0100
Message-Id: <20240223101709.30072-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy WR3000 V1 is a MediaTek Filogic 820 based 802.11ax wireless router.

https://www.cudy.com/productinfo/1637722.html

Rafał Miłecki (4):
  dt-bindings: vendor-prefixes: add Cudy
  dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
  arm64: dts: mediatek: mt7981: add pinctrl
  arm64: dts: mediatek: Add Cudy WR3000 V1

 .../devicetree/bindings/arm/mediatek.yaml     |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 22 ++++++
 5 files changed, 100 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts

-- 
2.35.3


