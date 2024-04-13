Return-Path: <linux-kernel+bounces-143862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C289F8A3E74
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797D528209B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502D55761;
	Sat, 13 Apr 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3wlmw+V"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15A2901;
	Sat, 13 Apr 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039769; cv=none; b=r+1C0ADOrRapw88ELVeUOl6EqTyxlYahDjF3uGxz6q/p/Wf/c7VN5AOZ4Ytdi/TW0H9RXhfVsapWW+1SbO/8BfdvvMc/xIDoij7HmjSOmeu07BoI3JO72kNwZVnf/o1r+7ZO+WpbtQC8+SWo+0OGGFYC6hOtiJKqs2hiPrBqFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039769; c=relaxed/simple;
	bh=bnx5sa8KDICe1vW2NAmHoFaeywkUORylyqHPjnVp/BA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IPJpORcoOCP72grg/x/fUen9EcY5O9FngwJHOp1oTBqDuZvlCIb6cvOyDp77eL9K3xj+XC1jvIfR3lgNgwxV30oAf/z5N+Wv43bLWQ6nzdOotsUHlzOxP1giA/pyQvndPRLQ1iLFDDC5UEMZs+Wa7EXyBlhPqc87dept/ERGXr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3wlmw+V; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so1878794a12.0;
        Sat, 13 Apr 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713039765; x=1713644565; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMG7QinvL5fvXvhlkGS6yquNkWTfPbeKbJj9JJN47FA=;
        b=J3wlmw+VITQU2Chk8jkEZ9arIfA+63JNmou7S4vbOTGq3eQ2lbquuJ9NZPqvDJq0AW
         ot0Q8gkc+p9A2ALAh3oSaEyTXjRn0WIABIPi3/zw7BcYJkmiNSvG3N5PERQhiRAuB8VV
         iayMhbmjUlLtvcEN2pxg/t8nwYLGbsN//c6GOhi6aIZsQYNGFBEfFh3H1WoCkqqROV/5
         Kc6n8voA29y4ZRb8Z2qAWADInVMhxYNIBhXPrFFmYSvDwc6R5pg7i3bHcxF4b8qp9wkJ
         JCHkZueA+twA5+GA6d/vLzopUKEUoTMejJxCSLaIh91wxTxspvAp2mRbNQb4vAb1GFpy
         251w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713039765; x=1713644565;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMG7QinvL5fvXvhlkGS6yquNkWTfPbeKbJj9JJN47FA=;
        b=uOXTtErs2Qocr7G9sVTKmeyDggntDCFR/8P41sYs9ksuA7MaQrUaCRQMQu9sA3gAU5
         n30BNj7qGUioTBuB0LGQO5jbtzQXp0EB3lITfpfI+N911nY9zOgqFiNuv8HRuSugaear
         sSgp7JKzJ84yjYCC1NG4V6dl2HTMJhcJ07hIo4A1EYNTY3s2XxJLJ5QYgFApbXOLeswg
         5Ep7Id5nfd4+NBo+uN5vo1dKZlxrTRvdyIkmL+vOD0atkfxaYO3/b0Cij6ajwBmS6TGh
         QQ0OXdAFueNIMMFdMiizPySZ1G/PXHDcaB756VHhkUP3STW5LY0kmx2+f1QJGKe08Gf+
         8zeg==
X-Forwarded-Encrypted: i=1; AJvYcCWGHm4S6nFZGYjwxLdbBEke6hhnJ+hAbiCADkZck+pcl6bq7Ny9ni1yTXaAP5d4sKsPsoYCLqCfFqpqp5CvpcWuuD7czOaEqIj1F87FQpdWFJK/NLtBzqj8JyM0l8gAg8MKg4YPt3yikw==
X-Gm-Message-State: AOJu0YzNsVJmlAI7zTuufsfG9HA6/mVY2RQi22sYVyRcYriLxS2aDp6m
	/ilNF9k7jM5AgnsO1n1+fB9PFn11s4AUptr7Ch76i4o4eSEQMeQOHFW2+AeNBAk=
X-Google-Smtp-Source: AGHT+IEsB+cHdlx9K9FNSEQ8EBqYbBYDYSfIouBtzUo5TVCXTptsRk0ac0wtO3XnSf5mJphM+OEMbw==
X-Received: by 2002:a50:9b55:0:b0:570:1dd9:f16b with SMTP id a21-20020a509b55000000b005701dd9f16bmr392424edj.26.1713039764648;
        Sat, 13 Apr 2024 13:22:44 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402161000b0056e2f1d9152sm2881222edv.93.2024.04.13.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 13:22:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/4] rtc: convert multiple bindings into dtschema
Date: Sat, 13 Apr 2024 22:22:15 +0200
Message-Id: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHfpGmYC/13MywrCMBCF4VcpszYymaQXXPkeIhKTtA3YRpISl
 NJ3Ny0I1eU58H8zRBucjXAqZgg2uej8mIc4FKB7NXaWOZM3EJJEiRULk76ZKereDooJpIak4VY
 TQk6ewbbutXGXa969i5MP701PfH2/UPMLJc6QaSnrUlKrRUXnblDucdR+gBVKtIs5/sWUYyNIc
 a7uWMtyHy/L8gFDfrtN5QAAAA==
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713039763; l=3124;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=bnx5sa8KDICe1vW2NAmHoFaeywkUORylyqHPjnVp/BA=;
 b=PyA3c914YDhLOl3SoDtKOi+FMBNuMKW9+wWIfwifi+Tny4hwNMF+Ektaon7HNNZUuJbyZ5uuY
 3mlk07mgOcwCCpGxdG2f9xUrbgHTycqC6/02u1izGaMmelxyjfwrYbg
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following bindings into dtschema, moving them
to trivial-rtc whenever possible:

- google,goldfish-rtc: trivial-rtc, referenced in mips arch.
- lpc32xx-rtc: trivial-rtc, referenced in arm arch.
- maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
- orion-rtc: trival-rtc, referenced in arm arch.
- pxa-rtc: add missing properties and convert. Referenced in arm arch.
- rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
- st,spear600-rtc: trivial-rtc, referenced in arm arch.
- stmp3xxx-rtc: add compatibles and convert, referenced in arm arch.
- via,vt8500-rtc: trivial-rtc, referenced in arm arch.

The only reference to the lpc32xx RTC makes use of a 'clocks' property
that does not describe a controllable signal (it is in fact a fixed
32768 Hz crystal, the input clock of the SoC). Remove this property to
better describe the device and avoid errors when checking the dts
against the RTC binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- Fix typo in commit description (rtc-aspeed).
- Move lpc32xx-rtc to trivial-rtc again.
- Remove 'clocks' property from the rtc node in lpc32xx.dtsi.
- Link to v2: https://lore.kernel.org/r/20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com

Changes in v2:
- General: squash all moves to trivial-rtc into a single patch.
- MAINTAINERS: remove reference to google,goldfish-rtc.txt
- lpc32xx-rtc: create own binding to add the undocumented 'clocks'
  property.
- fsl,stmp3xxx-rtc.yaml: document missing compatibles.
- Link to v1: https://lore.kernel.org/r/20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com

---
Javier Carrasco (4):
      arm: dts: nxp: lpc: lpc32xx: drop 'clocks' form rtc
      dt-bindings: rtc: convert trivial devices into dtschema
      dt-bindings: rtc: pxa-rtc: convert to dtschema
      dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema

 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 51 ++++++++++++++++++++++
 .../bindings/rtc/google,goldfish-rtc.txt           | 17 --------
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 -------
 .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 +++++++++++++++++
 .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 -----
 .../devicetree/bindings/rtc/orion-rtc.txt          | 18 --------
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 ------
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 ----------
 .../devicetree/bindings/rtc/spear-rtc.txt          | 15 -------
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ---------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       | 18 ++++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 -------
 MAINTAINERS                                        |  1 -
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi             |  1 -
 14 files changed, 109 insertions(+), 151 deletions(-)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240406-rtc_dtschema-302824d1ec20

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


