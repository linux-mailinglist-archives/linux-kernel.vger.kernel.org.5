Return-Path: <linux-kernel+bounces-116773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7542E88A3BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278371F3DB78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB315991A;
	Mon, 25 Mar 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEOwyqP/"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79C14659C;
	Mon, 25 Mar 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362675; cv=none; b=iQcP36RnCGrTgouCKfyhiiqGt2BQXnwWy5EqXbAXy1napq0OLTWer5HIVMtZnAh4ub0kS17ncOR/g35QfXlXSzQ/3wW5T+Aa/Z/tcI9H4k/kVE1/5ZyefJEkUxxEhKZTnXO5caY14IDQM++JOgpVDz9CYlTD9tqaBO/vJvaOlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362675; c=relaxed/simple;
	bh=qzP073KpR18hqVmhwSFwvYqRIwDMaaj97OZEQGAprsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AD9XdlRqiIuv33OaruZUOCw349LN6hL2CqLCxO2WDS2lI553wy3h/gO5LG41kOyd98OsV0pt/hI2d3j9Ev4eabrAuuSXb1NaghiNi0mfyolOAdJkZWdS+K5GkXBAcKBrZPavIiuCUIzz6ORT9pZaDX9ZJiRgS95Ho8I+2iRG4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEOwyqP/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d2509c66daso50353541fa.3;
        Mon, 25 Mar 2024 03:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711362672; x=1711967472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITuIJ48ycyvFs85EZCOH/esp3dFgohObI9gAbMbkThw=;
        b=KEOwyqP/CLeclPk5il8HJOTuLXuqpdTCTFFJrlY/zzdq6NB9Yf7mJIUu4MQO9Pn+oG
         UQC6vmhB8uTC21rxFNbS1IVUWIY265O2f+tq/aLeAsL5fz4VQu0GX3MkzB5FFj92vJlf
         8T//7yVb2AAb6pq4p/eE1gsq73dKNGMN3nT4tIVieUwS5Oc45M1XPpX9LlFc7c/nQp4z
         Y7B2mCmccqsMgX5cD0fV0ak2zoSxlXkFvdh4s0HlDdqTyEArw3YTwcJxxYAoZXG0yzxm
         +VDrBD+vGOPEKvzvpURJe0WJi8M0ZZCHsTHuIO4u4ZnZ+fKhFTovF3hiJ28ZPcv1cBgc
         3HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711362672; x=1711967472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITuIJ48ycyvFs85EZCOH/esp3dFgohObI9gAbMbkThw=;
        b=pLulwUkpqTn3DnRwObHoSOVu9dPrUm+a5s0xdotsBHM4V+NxeEVNh52QpfsuU7Y6UN
         ISDugDIV1mqv6Kag8fnogIatUIL6ftaIBaVkArprSvB0nkyJZ5FhqxwHHlBccKrzrdq9
         7tZ08Mn4WuZiNF6niQa6kxemVjp+v44ZrdOmz48JjAXO8qGXJ+tRR0rzrBm+B6ah8+uS
         RkmrJnmoPe5KNM9/BpOs6yR9UZibuDmiN4/qxbMvq8TUE4l9+US+17WgHXhRSYBGo2ya
         QbBn+LIjv/tOmaF8c3MDu7UOsSFvBIZQEGaaLxB/g+heWydI87nFtWN+N2EPwLG86HDc
         m7yA==
X-Forwarded-Encrypted: i=1; AJvYcCXMCkYKDAasEojT87dUGjyTpezBB9xPDJfScXK98dJHwVEu2CtnMw0XSkanZkq7OrAAXmdwel7wbI/HCgLNXTlAMbEqK7mZShoMHTgUsX1ngpTv1WVntRXwO0x5V1rGKTVA7vIwmE4RKkU/L01EhUw4gQn8AFjzwHIgIeNy/sWQld5Muw==
X-Gm-Message-State: AOJu0YyQPeS651QMXYq7/5gHHyUlvuJ3rtw2U//RUzMfS+hPCR4wIOZJ
	vkCiwRw6USSKEwNhm6LXrXkHAgBd3eJQNq++FEof3hj7UMOhGIvF
X-Google-Smtp-Source: AGHT+IHbEvUfaHQnzm6ZbUyi1TE0Z3wDxGxFHJpDIwcA/5e6DTkA5nfqau/NqIPKGSOLrgKUIQmStA==
X-Received: by 2002:a2e:994e:0:b0:2d4:2958:6daf with SMTP id r14-20020a2e994e000000b002d429586dafmr4358600ljj.20.1711362671784;
        Mon, 25 Mar 2024 03:31:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id be3-20020a05600c1e8300b004140e701884sm8063878wmb.22.2024.03.25.03.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:31:11 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: rawnand: qcom: Fix broken reset in misc_cmd_type in exec_op
Date: Mon, 25 Mar 2024 11:30:48 +0100
Message-ID: <20240325103053.24408-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103053.24408-1-ansuelsmth@gmail.com>
References: <20240325103053.24408-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

misc_cmd_type in exec_op have multiple problems. With commit a82990c8a409
("mtd: rawnand: qcom: Add read/read_start ops in exec_op path") it was
reworked and generalized but actually dropped the handling of the
RESET_DEVICE command.

The rework itself was correct with supporting case where a single misc
command is handled, but became problematic by the addition of exiting
early if we didn't had an ERASE or an OP_PROGRAM_PAGE operation.

Add additional logic to handle the reset command and return early only
if we don't have handling for the requested command.

Fixes: a82990c8a409 ("mtd: rawnand: qcom: Add read/read_start ops in exec_op path")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Add this patch

 drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 19d76e345a49..b8cff9240b28 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2815,7 +2815,7 @@ static int qcom_misc_cmd_type_exec(struct nand_chip *chip, const struct nand_sub
 			      host->cfg0_raw & ~(7 << CW_PER_PAGE));
 		nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
 		instrs = 3;
-	} else {
+	} else if (q_op.cmd_reg != OP_RESET_DEVICE) {
 		return 0;
 	}
 
-- 
2.43.0


