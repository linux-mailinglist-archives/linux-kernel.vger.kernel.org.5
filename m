Return-Path: <linux-kernel+bounces-155739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A528AF673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4218E2848E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E002213F441;
	Tue, 23 Apr 2024 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1KA1lBx"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3613CAA0;
	Tue, 23 Apr 2024 18:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896691; cv=none; b=rN14n8b+ZRFbYDf9QTCk/OZeKQh77PmNm7am0eN9+NcjoNmoTpV5PJ+Fv5/tn3jgl2/v6kDSkhgOOaHiFTYrZAxueUiKT/OlxTL/QTfrEQ93R400tfaYXloXd6H83+usxVw4oiA89qq8vGDamqsH3FWdEwVs1AU5UNbiOE2MfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896691; c=relaxed/simple;
	bh=p3JlOqRXkNqNUSODCJNAdvZ3sOeFtm/V+AGVfgtEuE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UA7yYG6ucdbaaQ2wtk8oOSWbg5L/kRQk2OuJ8pdy5D4VTO+w9mDuJ2mRfuF6LbQWjPOJnVlmdinGZkNm2Ao/HH5kzbKmonsv1I7TlIURZrqhQHoFA6TwrknDJcpBUmmiBfQGhsCz/zRweqyCmwoDaYT9JusMKaGtFhJSX+blcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1KA1lBx; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-344047ac7e4so82241f8f.0;
        Tue, 23 Apr 2024 11:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896688; x=1714501488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lhyk3FSfoj7YoDJTnL9w1+nogs2o+l2Px073/lLINys=;
        b=e1KA1lBxrYS1OK2V1Dgf4HnJPQNz4YLI2jksFxwIwaRV/BvjHG1Vs6St4llTtopI1c
         i/aBgXkbND3l82HhpAp6uKyl8GJneTRQIDeuKRgBw0ydvt0Kzj3zmZ9S4W1Z0LX+3stw
         5bWQQUPlU40IeixiSaoeEz/aOxHAe/Kf6JtBIjU7LS6OboekF5hCHkbOqMAEy9OG2b/j
         xbJoyfnlXbtxFlmJVBczroZaJwzoyX3twph+SVzGwWIcgoOZowTkZvVPMXIPMHPUz5cp
         CWezmNqQogGx8v10dPB4vpzcMoZ6xoyAiv8ugijJDLC0iJQFpCRYjBU9wJusaL1kbazE
         lbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896688; x=1714501488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lhyk3FSfoj7YoDJTnL9w1+nogs2o+l2Px073/lLINys=;
        b=CexYtFns4346hnvxLi3DKp7Kve32c717kPiW5kZZX23v1GBhO4ZQ4/XCQpHM8QbO1b
         qAhp+ttHlIfwVFjuRr/jgZeZYOcE2oY/6fNvEmZm8VzyJEwi2w/8oJGGaIVgAKQNK1jG
         SRsGJsqEc9n1QHsjoWUSqydYTz2kq4CUndOS8cDMd/q6Tn2jtMw5aPzneR0EM2pUVCPH
         WoUnrHeUFVfYPuNR+67f1zXCjI4szn1yc2Y4hd6uGzQwzs/SRRiY1QoPXacmuZCbkf+m
         4GSlN3CN2vLb/1e8uURW9VolWX3EStLbCcuDRntxsDgsvoKBRRKsIxLtcQudYL5iqMJ9
         3/ig==
X-Forwarded-Encrypted: i=1; AJvYcCUpqX234B9nc0YCG2uR4S26tPsnef+PILFEWklKa9c/Ny7Adf2cvMQHlAjqif+8ESmURiQQREJxnlHMn17bYKw+ErL9Oomd7Euv2gPN6FsN3SA/e1/5AxbR0RvB6wLpJGpUJ+i0sl5iZfM05efcqDFdBLA2KB7ccDtA2XSho+N8utZklRZn4BtkgRw=
X-Gm-Message-State: AOJu0YyPsezSL8gvunhD/p0D444wPuSKwzcffW2ZYgNd7xArnNcWzEOl
	YHkV+I7p72GjQ083nwVC+28w1UBHYyjV4SJh9E/knok4XvtElr9L9qTNOddV
X-Google-Smtp-Source: AGHT+IFbwEc7PMZMOosujS7ic2BsPpmeKJh9S5aG8DsnbSL4wabuY4YQv7IYgb4IXEAyuMue8uu2xg==
X-Received: by 2002:a5d:4604:0:b0:348:cd2c:d2fe with SMTP id t4-20020a5d4604000000b00348cd2cd2femr173146wrq.13.1713896687828;
        Tue, 23 Apr 2024 11:24:47 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id t15-20020adfeb8f000000b00349ff2e0345sm15319164wrn.70.2024.04.23.11.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:24:47 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] Update compat strings for SD/MMC nodes on RZ/{G2L (family), G3S, V2M} SoCs
Date: Tue, 23 Apr 2024 19:24:25 +0100
Message-Id: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

- RZ/G2UL and RZ/Five ("r9a07g043")
- RZ/G2L(C) ("r9a07g044")
- RZ/V2L ("r9a07g054")
- RZ/G3S ("r9a08g045")
- RZ/V2M ("r9a09g011")

The SD/MMC Interface in the above listed SoCs is not identical to that of
R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.
'renesas,rzg2l-sdhi' is introduced as a generic compatible string for the
above SoCs where fixed_addr_mode and hs400_disabled quirks will be applied.

v1->v2
- Updated commit messages for patch #1 and #2
- Dropped SoC DTSI changes as its a hard dependency
- Grouped single const value items into an enum list.
- For backward compatibility retained RZ/V2M compat string

v1: https://patchwork.kernel.org/project/linux-renesas-soc/cover/20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  dt-bindings: mmc: renesas,sdhi: Group single const value items into an
    enum list
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
  mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S,
    and RZ/V2M SoCs

 .../devicetree/bindings/mmc/renesas,sdhi.yaml | 38 ++++++++-----------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  9 +++--
 2 files changed, 21 insertions(+), 26 deletions(-)

-- 
2.34.1


