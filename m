Return-Path: <linux-kernel+bounces-110565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 045398860AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC0F1F22821
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F8C133425;
	Thu, 21 Mar 2024 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/kBiwgh"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC85CB5;
	Thu, 21 Mar 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711046637; cv=none; b=iNAdsJd0x1aTVDeu5LDmGFGy43CMQvc1bRR4hdGwvcIVOiq8df8QGjVR6AfkMkKgcbnEDJV21JGff68i5doNayk2iv/9onJFAPP4hzMF0AbYezIEAQGTKC2opBLrsc+TJWaDCkmp22IcdG262YWPFvDadtbE/jCuJSAO36lyzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711046637; c=relaxed/simple;
	bh=qb/Bf0zXY7etChiyat2ZjXEDTHS7YWl2pfFPxlK7XNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f9u2YZOoG83A+SayYhDaeCDcgpGENdjoGRXqaLRE0hTN2Dfz/ePCf+iYmapTvav5olyc+Gs29tAlsGQ3heCOF+gZ6jSxnEw6DIjfq6KuT6vCgXxDrqhOmxZpAC3d2em9UK+mSaHtByRBFzfbRFTdbt51HH/vsuUvhAnkXlRhfnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/kBiwgh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56890b533aaso1584409a12.3;
        Thu, 21 Mar 2024 11:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711046634; x=1711651434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3YRi7CjBRkbKzL2OgLfygDYkiVqLApDwF8CS48Fl/4=;
        b=f/kBiwghPzQdYjipKjBp3qfA+pZj2oeiJcGtEKdK8Wp8iV+syeEuFXzcSd2CX29s8/
         14LWCpdW+ev3yW6yqejGa4R9DdIT9jr2kG7PMQKBgrX5CBnQZmHumqZJUE4k6+A+pLao
         Jc/rVwcUEUt3XBm6BwMzUlZJan6cfLI5uJcvBKVNQjo3PMnYTWppzwXufJaZ1M0Z3Vov
         YfCaDo0fP27G9fX2cZgFsOAWjykZsgSpXEzw2pEdVxNaq8M6jFz1cLXTqr2Bq5Jt9isB
         K2yFbcZIksN8bGhKIZEKQwMhtC8DBvznSuaaTauA3q9v+WBEDfafaCH1aECjtiKC5yML
         jc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711046634; x=1711651434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3YRi7CjBRkbKzL2OgLfygDYkiVqLApDwF8CS48Fl/4=;
        b=nqqjlTT1jvRiSqrHmpDntKJNKo09l+JEhAW0/83c9dJDt1/dSpkvGaVYbgvfRrAOFW
         aE/8N3JAaVu6cJ2uDclCFAurq1ix5AR5AILeD8HCLL7HmtAKG9wW5kgtLRsJv+gPL0JL
         67aBew+Rqjf+1bSirgiavJDRiUPvdpj2NSTP4E6Up2q3rUloyMVmBKnouVWfatv1TgVR
         sj0yPi8d6u5M5FSvwpuvD8VRRIhqARKD5E6SDjkBu/b8nGwEO5kc8Tsctmwk0iQdbHB7
         KuOYOReM1350c7REzjpP7XsUv34akrXfKDKQGmbsJRq7zoIFYTNPXlAuAel6KFFRAz7R
         ZIMA==
X-Forwarded-Encrypted: i=1; AJvYcCWx/y16KGDHpjYOYwCre/2U85/52ULJiI3Z35xJN/xmA5opmNFe1rApV6I0Dj1ZPtVlkYc1zAbTsuChBtcqVjq3qZP/mL4nnPUmoKJrG8vz3Sd1XHqsoEjlVRX9VfsH8Zp2LrD/78h7hA==
X-Gm-Message-State: AOJu0YyPvcgI6G9vZG92jr9TNTlz3x4jJ+M9B9rUhry+aiZHIlaa3fVF
	fpraE/OF52G6FFA2mS97DAseFTCeYzRrnqPoveCQZLuiRKlOzrEG
X-Google-Smtp-Source: AGHT+IEFiHREKP8OZY99MKua7vP3dIM4RLhMeHsbw+XjxbzuNF+ZCfqYHSxtkpjGdUDBwcJAT31ZEA==
X-Received: by 2002:a17:906:b4b:b0:a46:edfb:ff68 with SMTP id v11-20020a1709060b4b00b00a46edfbff68mr195840ejg.5.1711046634142;
        Thu, 21 Mar 2024 11:43:54 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7db2-5855-2c59-b89b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7db2:5855:2c59:b89b])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090616c600b00a4576dd5a8csm188627ejd.201.2024.03.21.11.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 11:43:53 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/5] dt-bindings: hwmon: convert multiple devices to
 dtschema
Date: Thu, 21 Mar 2024 19:43:41 +0100
Message-Id: <20240321-hwmon_dtschema-v1-0-96c3810c3930@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN1//GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMD3Yzy3Py8+JSS4uSM1NxEXfM0U4s0E0tDQ4vERCWgpoKi1LTMCrC
 B0bG1tQCDcjUqYAAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711046632; l=1900;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qb/Bf0zXY7etChiyat2ZjXEDTHS7YWl2pfFPxlK7XNM=;
 b=LOtmOlWuGJJX1J1QTb6GMHIbOB8AUQtCR2RcGKO2IgzNuYJegE0yHi9i1d4c8pEUHYeoO5Fsk
 Jp0xXdmoM1tARxzZhRyS8V3i+Zh/xozT+HvOd6B9c5uZUNkTIj6vQOV
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following existing bindings to dtschema:

- as370
- ibmpowernv
- stts751
- ibm,p8-occ-hwmon (moved to trivial-devices.yaml)

Additionally, pwm-fan.txt has been dropped because it was converted a
year ago, and it is not mentioned anywhere in the tree.
I could not find the rationale, but its current state does not seem to
provide any valuable information.

The binding of the as370 looks very simple, but given that the reg
property is not a single address, I have written a dedicated file for
it. If reg = <address range> is valid in trivial-devices.yaml, I have
nothing against moving this device as well.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (5):
      dt-bindings: hwmon: as370: convert to dtschema
      dt-bindings: hwmon: ibmpowernv: convert to dtschema
      dt-bindings: hwmon: pwm-fan: drop text file
      dt-bindings: hwmon: stts751: convert to dtschema
      dt-bindings: hwmon: ibm,p8-occ-hwmon: move to trivial devices

 Documentation/devicetree/bindings/hwmon/as370.txt  | 11 ------
 .../devicetree/bindings/hwmon/ibm,p8-occ-hwmon.txt | 25 -------------
 .../devicetree/bindings/hwmon/ibm,powernv.yaml     | 37 +++++++++++++++++++
 .../devicetree/bindings/hwmon/ibmpowernv.txt       | 23 ------------
 .../devicetree/bindings/hwmon/pwm-fan.txt          |  1 -
 .../devicetree/bindings/hwmon/st,stts751.yaml      | 41 ++++++++++++++++++++++
 .../devicetree/bindings/hwmon/stts751.txt          | 15 --------
 .../devicetree/bindings/hwmon/syna,as370.yaml      | 32 +++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml       |  2 ++
 9 files changed, 112 insertions(+), 75 deletions(-)
---
base-commit: ebc9bee8814d12ec247de117aa2f7fd39ff11127
change-id: 20240320-hwmon_dtschema-7f58f49118aa

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


