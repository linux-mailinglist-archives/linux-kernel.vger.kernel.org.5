Return-Path: <linux-kernel+bounces-138928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F189FC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094081F247F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324116F264;
	Wed, 10 Apr 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cibvtzGM"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC915DBA9;
	Wed, 10 Apr 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764549; cv=none; b=ID/8n+AoVFXY7XTQiOsp0MoAqNX20dtUba3igBTx4ZPTBm4mJh1sDcVaA7KtQl9Bdjg/iHBjISr9dzmLM4l6QuInsXWCbQP5ZJozlqn6oiNRAHj+1dKAj3HMjZHxuaxdURflmwZUZkedDki3Y8ranMQ56ZG5+0Y/k/GyQDdKGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764549; c=relaxed/simple;
	bh=aG6841BM+IzaM2wdf6XPCQIKX1BJoLnJgWWJZ09aXUc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=icqxXuA7W56Wib2Dr+9aqYblIep61FCRMg2wfylxtGXyvVDxRr25u6YQeZh8xqmTH+laWPQZBvWTyt+Vd+q5/VNIHOXpPLEM1LbJNDRvjMW4Pz9Wn5Xh1okp5vh0zRr3DoCd715gsLr2WRynQeplvRLmnOBzwTMwb4wotzVf03I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cibvtzGM; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a51c6e91793so647158766b.0;
        Wed, 10 Apr 2024 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712764545; x=1713369345; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jsjr/EUpS7jHu9EoCoBO4JHqmCRBqh6/KIR1YSfDMJk=;
        b=cibvtzGM27xJrL3OGoQAwLNAQsjGk9NjO++nx2UtiTmpkh1WjqImfJlAx8JMkL6bA1
         SpkL8bfKpUsx10XJwyhrO0T/NDrfTikAB204NQvRIjpdUwJ8l4Za4zaVz0H+/SoTZ4xD
         Xp1J081tMmel3/Oyh4DqiuDfkwwuJISZEIzGl2F0oUPB2FRbY9Tq8V26gXG6MJC16qRO
         Vca8KjIf2XNnZoNmPoGwz55UxwmfHB9J1aCu8OEZujSLvW+zspHwlxkFr5iFUO8icvyV
         /4CwmrKutnTipUhfqzHecwxvfLakRrS/14Q/1BqvM8ueWFAEGxpkSzHeRU1dSAYd7FW6
         C5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712764545; x=1713369345;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jsjr/EUpS7jHu9EoCoBO4JHqmCRBqh6/KIR1YSfDMJk=;
        b=GU0MaeSAuOfjRC5d7N8YxWpQ7fOCd9kynPZ+qIe4q03MAqvgyTSeZouvVxLA6IJdm7
         BFRMBMItRXbxt7ENtwCgZLeAr/bdpDHoaJOWNgmaC6+Yy7uKaSP3JGFLvn+uG8PTBx34
         PbmDx3H0QMBQdem1iJ4QpH5SRcrvlev7CC7ctcwFVrBEBD6KTet4Xbzh6bRyrp4ppSi1
         xOhUxXm8w9ibP89lg95aZhY0pwMYLGEoPpPtG4ZdohPn0VXcMPv+Kw4fArpgHj7i8VZO
         35IChgQUx0z8FHVWCdFMRb2wLNYSp6AVmZ+tvBkPZ/kk7J2oeEfPhFGL39M8KIcqBps7
         wJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/Nv9c+ury4LGx1sQ/Pa+3CIGErJMAi3JRH6f8FJXmDSJ7kHdwDvvJ2TZysj1EmIKc6jy7hfuRi8NsiOlu2MkuDV+nJCMJhcd9aBCkwJxZ31+1998Cn0/pU2Gz6Sj1NwVIUP+f2HO8JQ==
X-Gm-Message-State: AOJu0Yw25LpHwZpX/4CBXvUrE940zLNTsllRigeZzmfUhvpphTPFachT
	tZZLRVbOd80CDaXSEw/ISiPr5cojAxdEyYFR+gLUmWT9c+GwVlqK28qjM+KK1yHzgw==
X-Google-Smtp-Source: AGHT+IF1ADAUkQmkGJcp6oXbVsO2NNUVSgumq2+R9/e1RDxEbeDdhWqKmtLj8qqMmKKxMxSasjIpVQ==
X-Received: by 2002:a17:906:46db:b0:a51:d056:d08b with SMTP id k27-20020a17090646db00b00a51d056d08bmr90851ejs.0.1712764545559;
        Wed, 10 Apr 2024 08:55:45 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id qw6-20020a1709066a0600b00a52172808c9sm279884ejc.56.2024.04.10.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:55:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH v2 0/4] rtc: convert multiple bindings into dtschema
Date: Wed, 10 Apr 2024 17:55:32 +0200
Message-Id: <20240410-rtc_dtschema-v2-0-d32a11ab0745@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHS2FmYC/1XMQQrCMBCF4auUWRtJprEWV95DipTptB0wjSQlK
 CV3NxZcuPwfvG+DyEE4wqXaIHCSKH4pgYcKaO6XiZUMpQE1Wm11o8JK92GNNLPrVa2xRTsYJtR
 QLs/Ao7x27taVniWuPrx3PZnv+oPafygZpRVZez5ZHKlu8Dq5Xh5H8g66nPMHsJC+eqgAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712764543; l=2589;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=aG6841BM+IzaM2wdf6XPCQIKX1BJoLnJgWWJZ09aXUc=;
 b=vE6WWKn/PfJQl6Z2mF/T4S+0ooamNPIyWAComjIMzpGZf3t4nblGf7WzRI3Gd5nnqgkkLJ54Z
 rg1MNNHQsJxBMn808RjLrAfEPSzorjoLsdzH843SWqOs2s8K41Q8LrA
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series converts the following bindings into dtschema, moving them
to trivial-rtc whenever possible:

- orion-rtc: trival-rtc, referenced in arm arch.
- google,goldfish-rtc: trivial-rtc, referenced in mips arch.
- lpc32xx-rtc: add missing property and convert, referenced in arm arch.
- maxim,ds1742: trivial-rtc, not referenced in arch, cheap conversion.
- rtc-aspeed: 3 devices to trivial-rtc, all referenced in arm arch.
- pxa-rtc: add missing properties and convert. Referenced in arm arch.
- st,spear600-rtc: trivial-rtc, referenced in arm arch.
- stmp3xxx-rtc: add compatibles and convert, referenced in arm arch.
- via,vt8500-rtc: trivial-rtc, referenced in arm arch.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Changes in v2:
- General: squash all moves to trivial-rtc into a single patch.
- MAINTAINERS: remove reference to google,goldfish-rtc.txt
- lpc32xx-rtc: create own binding to add the undocumented 'clocks'
  property.
- fsl,stmp3xxx-rtc.yaml: document missing compatibles.
- Link to v1: https://lore.kernel.org/r/20240408-rtc_dtschema-v1-0-c447542fc362@gmail.com

---
Javier Carrasco (4):
      dt-bindings: rtc: convert trivial devices into dtschema
      dt-bindings: rtc: lpc32xx-rtc: convert to dtschema
      dt-bindings: rtc: pxa-rtc: convert to dtschema
      dt-bindings: rtc: stmp3xxx-rtc: convert to dtschema

 .../devicetree/bindings/rtc/fsl,stmp3xxx-rtc.yaml  | 51 ++++++++++++++++++++++
 .../bindings/rtc/google,goldfish-rtc.txt           | 17 --------
 .../devicetree/bindings/rtc/lpc32xx-rtc.txt        | 15 -------
 .../devicetree/bindings/rtc/marvell,pxa-rtc.yaml   | 40 +++++++++++++++++
 .../devicetree/bindings/rtc/maxim,ds1742.txt       | 12 -----
 .../devicetree/bindings/rtc/nxp,lpc32xx-rtc.yaml   | 41 +++++++++++++++++
 .../devicetree/bindings/rtc/orion-rtc.txt          | 18 --------
 Documentation/devicetree/bindings/rtc/pxa-rtc.txt  | 14 ------
 .../devicetree/bindings/rtc/rtc-aspeed.txt         | 22 ----------
 .../devicetree/bindings/rtc/spear-rtc.txt          | 15 -------
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       | 21 ---------
 .../devicetree/bindings/rtc/trivial-rtc.yaml       | 16 +++++++
 .../devicetree/bindings/rtc/via,vt8500-rtc.txt     | 15 -------
 MAINTAINERS                                        |  1 -
 14 files changed, 148 insertions(+), 150 deletions(-)
---
base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
change-id: 20240406-rtc_dtschema-302824d1ec20

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


