Return-Path: <linux-kernel+bounces-88356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8B86E06D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF2C1C20D57
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3FD6CDA8;
	Fri,  1 Mar 2024 11:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIaZK7QE"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54236BFC9;
	Fri,  1 Mar 2024 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292917; cv=none; b=nA/kfIY1S/qngJZrnuYVx19rwf/bZpflN7FyPhQgoA10zLQPRD7Q2usFaNs5yR75fvtTqleJ1kJawp/Vj6Mqgr60ZEvY7CNz8CMJy6crK84r6Xv/Nhb0QG7/jf0dhmuxRCg5LMLGTlm9Ow3UJyy96sU/EMhqIRoeNwr8AVXSylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292917; c=relaxed/simple;
	bh=eweBH8MXC7Oa2tU49s9FyefEcitZv3hyVqnOB4hbgAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kfPoXmt7/SbwlAh+PLF4RH4XbYuV1RVxV+0womS9js+H+LCbImKxDKOj5FW1IR5mlX17aSFVs7Hh3l3+wcqBABmnl7EcYKx3d/jyeAOa/g+5Ot/edshN96iE7Q2Xe5lG2c+xtyFx8Y7g1Yo77BCb+xL48UTGeJlinxR2gr+aPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIaZK7QE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a444205f764so252566466b.2;
        Fri, 01 Mar 2024 03:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292914; x=1709897714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvBHCXAWkp+ub17HVIW8VAtvFSItSjV35+r++B1AoCM=;
        b=DIaZK7QE/smWMVRijVasCuiZ+95fwvJHsmylJL5mUnJiFPQYtUaY/bmW5VzgK5I9HB
         F2AIYvtbGMUSSR8qw7mErJP7DaDwN+8CPmdhEcsBPO09HDB4YOC0y1gkJEyRs5OnSSZT
         f4hDbZBOVJNn4jwhybGu/BCfwPZoLX+HpRSBEBJQ5REsZH1/WokgBGlM4O76I+w8Ffww
         +LgK4BHnIVuPkunt2kUDwxhesRQ5gT5rWe9JQDmraBeBT1Y6DUV7ltbhzXyAOl4yi7wN
         pydfHTcNEYYqu1c6wG8EOMPyJZNXCbonmkm2N397LShPp7nAbuvYMVRJ64i1KnSPH96g
         CdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292914; x=1709897714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QvBHCXAWkp+ub17HVIW8VAtvFSItSjV35+r++B1AoCM=;
        b=Tr9bNIV6Um5mXNlKx6aYyTJ+iCae2uE0JlIbnBQR/TxNJ/y75/JXhmd2bgDB5bg4fr
         WTiirgJqddcZv9Nd+264HzB7LPA/rjMZCtSuXB3viEmAL+ZPEyfB8XFfAkLQ+LHEdCZW
         /2DQHwXgcjFIyHZaZk0N5Pw2vdg5fScIkv6eWAPR/WYP0eUVeKT8I60foKDw9pnc59qC
         UO5LcZie5UoGOKLGgIkyUksP+mjB/bfU2YE/8R3djDb7Tmv+HXplM1cLjVizOnvgauK/
         2ET+Ar+/6BZ0JylfdlJ2EqABOkzi2ycGYBwO/R/EjjpXAECnZZPw9bqili7xITy6GN+S
         4nXg==
X-Forwarded-Encrypted: i=1; AJvYcCVBevxp8kc4itdp3rTYSwbNuwSHG7XgLL2dzbCRpMQMTueJUoGB5MLHZ3XXdyhSIWVEcN+QZfA4Q9P6nRLDideBIRS4JYh3o2Oc0WSu
X-Gm-Message-State: AOJu0YzvN0rz0mbLiq9NO9fOSd5H/NEUeELycg0QwJsapSfyfBki0lHp
	puA24DctLsUmoP0GYfYc5IhZwpLZoVzajeQDO9HQNYmfir2fVEaJ
X-Google-Smtp-Source: AGHT+IGzLP7Sb0dwHUDkT3mh64fsZ9V0JvdBga7KakkhfMJd9QAeJRQfc5C47i6a6XnRNwidqmjWow==
X-Received: by 2002:a17:906:e211:b0:a43:fd9e:2d44 with SMTP id gf17-20020a170906e21100b00a43fd9e2d44mr1151665ejb.42.1709292913942;
        Fri, 01 Mar 2024 03:35:13 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3f5c39bf2asm1618457ejc.0.2024.03.01.03.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:35:13 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/4] arm64: dts: mediatek: mt7622: fix some validation errors
Date: Fri,  1 Mar 2024 12:35:02 +0100
Message-Id: <20240301113506.22944-1-zajec5@gmail.com>
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

One more step in cleaning up DTS for "make dtbs_check".

Rafał Miłecki (4):
  arm64: dts: mediatek: mt7622: fix clock controllers
  arm64: dts: mediatek: mt7622: fix IR nodename
  arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
  arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block

 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 34 ++++++++++--------------
 1 file changed, 14 insertions(+), 20 deletions(-)

-- 
2.35.3


