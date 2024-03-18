Return-Path: <linux-kernel+bounces-106359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFB87ED08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C28D1F21C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6E537F2;
	Mon, 18 Mar 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvzuPbWX"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B453385;
	Mon, 18 Mar 2024 16:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778122; cv=none; b=WI+lkF2qDFF11eTyfzv/BkOfHn6fIMey8KtUNVucKLBcFhvoqbOKqyNhKnQbSUMabgRUkmuIp4xIbEoXoBsoCCl7gn40gR3Bf02jxlMuvcJyG0BOpMxlkhcgK7OdFLOpdEaIV0CC5XM+zCFR0J29VMqFFogsuvrZjAUbqxPbVEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778122; c=relaxed/simple;
	bh=EmaVoP+earJuSu2o65o4pl6OdAyua9nqaR2HtePrF48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqcTT2kIaOjvWRxFjLgMNbSacq1rittf6z1ICkQk1TY/xXXQgifp+St2h0+VOxWdt1KLUOzGF4we4j3W4JSXFkYoLL67QNJDaJxnHOyGdq2ptPGLo6IZSh98IZuOg8exEQx5PsMXTEshIjh2gaxpwu+lfnwy9EZVD8SrXxdSX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvzuPbWX; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so3294832f8f.0;
        Mon, 18 Mar 2024 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710778119; x=1711382919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddHXVjuqLW268HLK7jnmZpsNduOijqKpccgoOAn1Qkw=;
        b=ZvzuPbWXqq3+rv9LSit7EflN6wOPJXDRP+9c4CpX6lzKkpVrFhO6CAcT29I/ezu+Dp
         t3Bvibof/XOpZEFJq6tGPO9/eT5trQ1GtTvskcHSuN8XqD263poDyKxjvWAnk9Pj0Hd9
         yD73E15Sz/tgWGRYDG+cIqD8z4PwocKb8rdY42l/mqkyK/17Hc8AavTBxDcc2lSQZ0lQ
         W31n31RGdZjHL1U+8niYbzbSrV4+UveFkuPc3RHPsnjZHNeBEqhjPpMdZgIxy8/+9QBA
         Y0cXaPA1NXZw7dqirXi7Z/DOzkf61cmPv1SuLsc4WskT/Q0bnZIgg1chf/SV9bxmu+jS
         Z9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778119; x=1711382919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddHXVjuqLW268HLK7jnmZpsNduOijqKpccgoOAn1Qkw=;
        b=s9vtfCJDDeuqMN4RwJ5n7ZgN7zE/PK3NMXppmpSH5k7Txlz3TVdQ7KJs9r2/2LHU2V
         iikeyAjXAFgMchCmZGIY7gjpd8yOcg1lU7tVW+AzWkodp/0xzKvUnsnjQ83+Ut0LZTL+
         UA2AmN0tA8IOncFlqBvYp921CubE3iosPcmkMNiRru3QOsXCDJdLJT7bwbFMAZtRwUEW
         Bpv9wrJdC1r2Hi5S8DOk4fSYzVdfxd4WYoNlkTyIutqo15DNWG8WVo7KwnH1vN/Jmhif
         1eUrjdsbZ/4GZuUIkUFgCRiJ6XN1zxxKQFPLLfvp4Nqh2neHK4OihQnnPBf5LbuF1V9W
         FpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxoHzePMzmyTeFv1W75NTwR2/p+zHcmWKzMBKoulVMNQ8S3b7KY1Dr3Ng+VH8rUIseFH3ReUsLzgJNsNx2IwLlJd3qCgdb+gTGD78izuhVznsh7AyuJWrdx7qMn9YHuaEoLROurFnmPOgDr2Th
X-Gm-Message-State: AOJu0YwxEpCdeUqKlJGJCD0qj6EBwznrXVNfW486l2CWKjW4V0F++GRZ
	LERX3/5DthsSGAYAj/9sIuADEc/+hzMKlIRMgJoV7yZDEV95G94S+98xHbuO
X-Google-Smtp-Source: AGHT+IFtqrZcMnGF6ca8UZ/MYdVWqOaQQ4YvkEpCU272vqBcP1q6pTRS5/qxg57iDjKOHu02upRSUw==
X-Received: by 2002:a05:6000:136a:b0:33e:6056:6b84 with SMTP id q10-20020a056000136a00b0033e60566b84mr9185105wrz.2.1710778119556;
        Mon, 18 Mar 2024 09:08:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:c23f:76ae:8149:291])
        by smtp.gmail.com with ESMTPSA id by19-20020a056000099300b0034174875850sm2686930wrb.70.2024.03.18.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:08:38 -0700 (PDT)
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
Subject: [PATCH 2/2] clocksource/drivers/renesas-ostm: Add OSTM support for RZ/V2H(P) SoC
Date: Mon, 18 Mar 2024 16:07:31 +0000
Message-Id: <20240318160731.33960-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

RZ/V2H(P) (R9A09G057) SoC has Generic Timer Module(a.k.a OSTM) which
needs to deassert the reset line before accessing any registers just
like the RZ/G2L SoC.

Enable the entry point for RZ/V2H(P) SoC so that we can deassert
the reset line in probe callback.

While at it use IS_ENABLED() macro instead of open coding.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clocksource/renesas-ostm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/renesas-ostm.c b/drivers/clocksource/renesas-ostm.c
index 8da972dc1713..b8b3c82b2528 100644
--- a/drivers/clocksource/renesas-ostm.c
+++ b/drivers/clocksource/renesas-ostm.c
@@ -224,7 +224,7 @@ static int __init ostm_init(struct device_node *np)
 
 TIMER_OF_DECLARE(ostm, "renesas,ostm", ostm_init);
 
-#ifdef CONFIG_ARCH_RZG2L
+#if IS_ENABLED(CONFIG_ARCH_RZG2L) || IS_ENABLED(CONFIG_ARCH_R9A09G057)
 static int __init ostm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-- 
2.34.1


