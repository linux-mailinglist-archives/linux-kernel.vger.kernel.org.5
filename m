Return-Path: <linux-kernel+bounces-119030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACA88C2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3341F66DC3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116007173E;
	Tue, 26 Mar 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvX+7qv3"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F128E8;
	Tue, 26 Mar 2024 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458209; cv=none; b=ujtJ/S/67kEtNWJq5PpJ3Jhet+/C3OpY9XFW16UoJBi7Ki5fqlIHQD2Rr3OvRvnCCXv6V5nQAC0/CsCFJ00Y923Me2nAWDnTGpfh5ys+zN5Z5au8uEKpxsug9cuD9ZZUz9u/eNqbZOmT41JwZczIxskalmZpfLa+7iMCYv61EIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458209; c=relaxed/simple;
	bh=+FhhRxT7C84hEImrOqevSzjSw39HhBXEwv19zjNQaIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KeIsrTlCd1Hu83O0vhF1ksVsnV9Wwph45iD77w+qRIz94iX/LTCvJgv8ki0E41Sdfdbtm5XlQZtoFjpQQywHirxEm08nwmBcoJl8Q0oEAXQn+KWsxCb0+ZyTHVnuN3kzd/5OUQPdXAHMydS7eMFTMqVEIcLXyjjdYhJBw448I90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvX+7qv3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso9495079e87.1;
        Tue, 26 Mar 2024 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711458206; x=1712063006; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QYmh51LEOzN+NihFa+3AsPFO3SRwSe2SPndTbPe4Vt0=;
        b=fvX+7qv3tFVlnUZYzS4WMFTfVxwhP6N0EAQeE1kN4bES4koe58+ZwsPSZzS0U0edVo
         W+3/qPQulpgfYjmkyIA8uC7knXUUdAe4f9ytOL5O1PCHzhheE5QzXeZa4ymjygGbiIsh
         J/UH++gQGrkR9Sk95fyusbnJzy5EEXdlLq2bWUi2lqz6OIUy4ObbLAdmQcppb048sAAb
         6u9eMhePJfgGWRDxy30PLCVPikk7BeqUBCJGuMAyix9AQ2b4kDOWrahiE7Xfw8Dc5ZtV
         J6CJqGVsOTnzsUFQnHMTPbt9fdKurtOOicfwzwF+CSSXa6HPZsnItFG469xWhD2sBj0Z
         B+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458206; x=1712063006;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QYmh51LEOzN+NihFa+3AsPFO3SRwSe2SPndTbPe4Vt0=;
        b=vLMISqlAP9SB/txQPOjhB9SRH20TDsV7TcQJyZOG2kW9Z8Ld34s0+n774Jh9H73Fa/
         kXkoLr6B4YRdlQQskfw9D3lD8jDH6AEo/aL/4nNrGctUBkTdKvfNPEVyQZqrVnFq1HU7
         2v1kVKOcTEoSweDK/D8emzpuI3ymI8Dh9PuI7Petq6bf5qMQLcnP2Sc/hMRN0xdp1ctm
         ZKYJYNVwpZBzCnLazKyrORo9jZfAkF00ZtLYogSZvryibPcVDEyM2vwhE50LK0S3quw3
         g5ri/eFcuGJnuzf0cHVZ6KWEforawPZ5OWjFIrJwdquW0WYpA0uG3f/7LUd4e5xKgwIj
         3HKA==
X-Forwarded-Encrypted: i=1; AJvYcCV3pfn/7oBcfeSxvUl2Uy9RIspVCw2eeCwODAUS2nZBN0+jVxals9XoCCJTREYTQ9pgzLcoWCf0BcB8SlPrQTZTIQdzMYOHMhLQhS8YIB1bO2e93iB3rq/b3twqzaDaOPTrQ86+1jlmxQ==
X-Gm-Message-State: AOJu0YxbYH9l195v1BUHla7/YZrVH2v4EfaIIY8XGWPDHq07EWxQKfsv
	kYrnsm+PKMGeo6jFjilk4CyGyz37f+QukWSW0pQn9LJgMHZq8mC3
X-Google-Smtp-Source: AGHT+IFODD4Gl0HxVCiF/9V0SOihSYufgOxSUugBuMnHEz6PzbgVoV2LniUHJBJoEck1ggSsemVoxg==
X-Received: by 2002:a05:6512:21c:b0:513:e031:739a with SMTP id a28-20020a056512021c00b00513e031739amr8039317lfo.22.1711458205516;
        Tue, 26 Mar 2024 06:03:25 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b4b2-cd0d-1ebc-3c05.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b4b2:cd0d:1ebc:3c05])
        by smtp.gmail.com with ESMTPSA id wg6-20020a17090705c600b00a4a3580b215sm2206279ejb.80.2024.03.26.06.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:03:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v3 0/4] dt-bindings: rtc: convert multiple devices to
 dtschema
Date: Tue, 26 Mar 2024 14:03:22 +0100
Message-Id: <20240326-rtc-yaml-v3-0-caa430ecace7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJrHAmYC/02MywqDMBBFf0Vm3ZRkRlvtqv9RujAvDfgikVAR/
 71RKHV5LvecFYLxzgR4ZCt4E11w45CALhmoth4aw5xODMgx54TI/KzYUvcdy+9EVChpKyEg3Sd
 vrPscqdc7cevCPPrlKEexr78I/SNRMM64KrRAKWRZ6WfT1667qrGHPRLxLBYnEZNobWVvpc1JS
 3UWt237ApI2SqzZAAAA
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711458204; l=2161;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+FhhRxT7C84hEImrOqevSzjSw39HhBXEwv19zjNQaIA=;
 b=j1MYt5XVObkjpiuxvq5hxLJ9FT6qXILg0SA09+5z4sWxdIc5Y6Jt2Gv/By4Xlc6msaAULUHbv
 wpvSjLteRGFDXHv0/1y4KIaMuZV8qR2VlY6jLVhpr4kSEWm5AE7XezB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following existing bindings to dtschema:

- armada-380-rtc
- alphascale,asm9260-rtc
- digicolor-rtc (moved to trivial-rtc)
- nxp,lpc1788-rtc

All bindings include at least one compatible that is referenced in the
existing dts (arch/arm). Those dts could be tested against the new
bindings.

It might be worth mentioning that the reference to nxp,lpc1788-rtc in
arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi also includes another compatible
called nxp,lpc1850-rtc, which is not documented or supported by existing
drivers. That generates a warning when testing against nxp,lpc1788-rtc.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v3:
- alphascale-asm9260-rtc: drop unnecessary reg description.
- nxp,lpc1788-rtc: drop unnecessary reg description.
- Link to v2: https://lore.kernel.org/r/20240325-rtc-yaml-v2-0-ff9f68f43dbc@gmail.com

Changes in v2:
- General: reference to rtc.yaml
- digicolor-rtc: move to trivial-rtc
- Link to v1: https://lore.kernel.org/r/20240323-rtc-yaml-v1-0-0c5d12b1b89d@gmail.com

---
Javier Carrasco (4):
      dt-bindings: rtc: armada-380-rtc: convert to dtschema
      dt-bindings: rtc: alphascale,asm9260-rtc: convert to dtschema
      dt-bindings: rtc: digicolor-rtc: move to trivial-rtc
      dt-bindings: rtc: nxp,lpc1788-rtc: convert to dtschema

 .../bindings/rtc/alphascale,asm9260-rtc.txt        | 19 -------
 .../bindings/rtc/alphascale,asm9260-rtc.yaml       | 50 +++++++++++++++++++
 .../devicetree/bindings/rtc/armada-380-rtc.txt     | 24 ---------
 .../devicetree/bindings/rtc/digicolor-rtc.txt      | 17 -------
 .../bindings/rtc/marvell,armada-380-rtc.yaml       | 51 +++++++++++++++++++
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.txt    | 21 --------
 .../devicetree/bindings/rtc/nxp,lpc1788-rtc.yaml   | 58 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/trivial-rtc.yaml       |  2 +
 8 files changed, 161 insertions(+), 81 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240322-rtc-yaml-473335cbf911

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


