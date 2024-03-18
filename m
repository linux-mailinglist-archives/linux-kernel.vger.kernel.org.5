Return-Path: <linux-kernel+bounces-106357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB27787ED02
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE951C21108
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3425338F;
	Mon, 18 Mar 2024 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRLIsg/b"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31289524D9;
	Mon, 18 Mar 2024 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778120; cv=none; b=mnFC+NeNXKX0ug36TF8ejahOQU9RFvCCiP4yzsdKTq8rR67f5tCt7uJEjFQ+P4K2BgdJT+eQwscLAzjesBUfEDlNQ9AB2sZfBe0GbsAfQm2irbs8qWlUMFEczyhJ1L0IcSB5oAtspH1bdoDWWRqhZXhaeLinPeXVXlzn3jsZdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778120; c=relaxed/simple;
	bh=r9AadNTuPj/xHpv1vyybelqf6SDyu4UcuMa6Gu7XF7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBpeh6geN/idiqOP1P5yx3kthjUU2353u42S64pvmtkjZ5JdRlVIMAB9czqssB1JnGLQutbSL6Q5CKktsHjilyx+Q+1tZ//oytRGONn14yDioKQGDEN/pPU8JnscKZ4/pHsmVIortNNJbytiQkidTTK/J8ZZjXDq+/X/TyPiC6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRLIsg/b; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e672e10cfso2341191f8f.0;
        Mon, 18 Mar 2024 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710778117; x=1711382917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YKLWsywpi4s+PmNOe+tGA4RWXOrI7pQM1T4s6onJuV4=;
        b=dRLIsg/biOBxB6KswPncR4Xgq9ES4a0Zpn4d8vJfvSTsuuLHcv6fEblw1yR0eoRhM6
         bLWMa0buVTTyDBlSG5Xq7R/YhGY3UAdomVTDpc7C89QiCDhqjL5LuupnmfW4HCZlEmNw
         eHjPO4SIjoPbfs9XiaEgzxRE6MDFKj6uEZ/MwbRoGTMm68Utn7VqGwsOSzR8zO6WX5cW
         MYm4bbsrctv/TG6JPrnqrpta/xFU72iUUv/0BXcTm7uZDnMnoZujHLHxTTkhIfad1NN3
         kkOo9MLBzOJyMMTC+SVQH5svR8Q3fUUZG1tbTMd14WVrAs9AIr4SwvC5lZs2aJSMvJ+v
         N5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778117; x=1711382917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKLWsywpi4s+PmNOe+tGA4RWXOrI7pQM1T4s6onJuV4=;
        b=hQIv957mUMU6w/QYf8op+yzlp/XBvsDvQF6l+lyxy26SUl7nZWWK/C7sq6YORpPUFE
         N5yHhK5mX39Sy6uDPIft9Y60YI4DfnmLCWZNgeXwppkqncme5xdvdCJCEDw/sFthS7y+
         guATFhHtC5WlTTpN0nHDCb7GEfT+hhEE9DWCfq71ZrltSjYRxHC+WXPW0TdLajwk+3u3
         C95afyd6/sMR/GOdznPB76l10oBwrkwtTtslNvB2U6BCNd25p6lTEAiaL0GB5loQjawK
         mwqXk9ZLC0nbd2OrosusI4lOcrsXpVao/jwDPO+o5oGPul9ru2ymQwwu0rTBV74CIOAd
         cOkg==
X-Forwarded-Encrypted: i=1; AJvYcCUT+CJ4e4WZ2/7FIgE4AN0aFzbu5btQWtrHXT+28DkMj79sDsr1L8D4ee/QkqAOeeghxfl6WOg5x5TnLkwhZ9QSl9JJDS3wRGvBfNvnGP+beeS4eok0ACQVO0y3Aus9p9rDAGn5UX6LgXjU6dyf
X-Gm-Message-State: AOJu0YySZaGRMlRVh+8wFCJtEDVvNHa23GuQU841nKyACrc516r+HJVK
	BY1qWR9D9gJzLcROaq5/sND6CqN5a0Z8+ffd78RQ8b4nDRE9LuMQ
X-Google-Smtp-Source: AGHT+IF+WXgSTtiErR29FiASJITXyX/ekIh5W6iYS1sCMmTLsE3ZHUXvOC17prI5QI1kZ9aB9qY4MA==
X-Received: by 2002:adf:f350:0:b0:33e:3555:bb57 with SMTP id e16-20020adff350000000b0033e3555bb57mr10082782wrp.42.1710778117097;
        Mon, 18 Mar 2024 09:08:37 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0034174875850sm2686930wrb.70.2024.03.18.09.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:08:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Brandt <chris.brandt@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] Add OSTM support for Renesas RZ/V2H(P) SoC
Date: Mon, 18 Mar 2024 16:07:29 +0000
Message-Id: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi,

This patch series aims to add OSTM support for Renesas RZ/V2H(P) SoC.
RZ/V2H(P) SoC has 8 GTM channels.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: timer: renesas: ostm: Document Renesas RZ/V2H(P) SoC
  clocksource/drivers/renesas-ostm: Add OSTM support for RZ/V2H(P) SoC

 Documentation/devicetree/bindings/timer/renesas,ostm.yaml | 2 ++
 drivers/clocksource/renesas-ostm.c                        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1


