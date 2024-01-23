Return-Path: <linux-kernel+bounces-35626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE643839455
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4CC1C271A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600EE664D6;
	Tue, 23 Jan 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="iaXj0LPS"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58227664C0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706026182; cv=none; b=lWmtwBqCtODbQukLEXHY+kmZe1UYGJAN39dF2mTPc/t6olUvcwaIMc/QzR4SqSZcNjy8ncUF4NoGJ307EswhTR+Xzy0j8F6D2Dlvon/tkyn9Gh28tpMACi9elFpIRfx/Tw5IgRTS7vybH6UEwK2Xi2MHdd+UztV8blnrL4YZ7eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706026182; c=relaxed/simple;
	bh=iV75UO6ZkEr2mjAImDePxKGuDa0DKz++I8BI+1ZKjGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AWY2w5L5KjkAD+qY7h/A8kVpBJNoYrUkOQEXGI1kkQRDKsj4nKKucWVaOSblT9HdabmkafoU3bubum6t6gEvItkSBabYhO0HiQyAe0HeUOS22pTJi8Vysp6VgzuzvnPllTxd4p63HzlgmaDD5waJqC6928GqJVNROOrUz6q4v0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=iaXj0LPS; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso6400985e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1706026178; x=1706630978; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TCsEp2lpUC7FkoNHc/fEc8WeD5OX/0nFFUd/EH7Tzfk=;
        b=iaXj0LPSvSZv3hnx3l8dkrQ7+dH0ZqxjL3uhsxUTXmEtZ3ojAufz45Piqv8Nmcude4
         i7tEoFCoLaN5t6b0JJyLKNSAQ0EjqHe/fc2HFB4CA8VmVSqbgAqTVa/0vSq2qHAsjXOZ
         S+2RWUS/SZEYRGBCHdsqPkQdQjedl6NO4/B8bo9Fo3dhoAKIWW4n6q9fOtFB5WhDjFBd
         hPeDqSuoOV7WRkXy13g9hzVWrbZpGz2ZplvinzjrZND8U4hCMbms95Y4VMOe7BRyrYjj
         GTkwXt4GyOzygvw3WI4gMNmfCXwN4fLcawVH05gPVj5CEDuRBnDLsSzzC53jgc722ocv
         pjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706026178; x=1706630978;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCsEp2lpUC7FkoNHc/fEc8WeD5OX/0nFFUd/EH7Tzfk=;
        b=l/NLuQC2OwSF5T2i7QzTbAtGTBvymyuhSVMVhVgykkrVjaqq+70VP9eF8PubfxOupT
         7r/aaopWqen/wMzGJu6wI+7AKn8MWFw7CpnEmXgh2n42UWv9jLRrtu0OGzPYM0PMbIVg
         mWn5wZvlN2B/i6++0iYQmjy8JEk1R5X1Hju07gtjcMqEsVZ8UCqLuSU7uvG2J3jslKmm
         GigR8ZuajBTM/PSdR+w6eskyORxuELloy6WJTjjMyeMlkblSBggirxptk9r8UQnnNqQ/
         uHcUZVYUTrBQuaYuckx4nu9WCI/DMmrYMfMRyI89GIsAunLVGy0/WaA645fIauiesGV+
         ZBJQ==
X-Gm-Message-State: AOJu0YzdAfQFTlSswws9XUQnBbUmBlqf1m98Acq7gVQPaddkQ/qqJa/a
	OzmzMoGvGXn4EQd+sOg7Y1CiZik6qCX1QcrSxbrIIRMgop6cupKtwaQYeVqjtNw=
X-Google-Smtp-Source: AGHT+IGnnNSe1moGqxiwEYHIJKv7pqXFqRebOu3b3bLqL4dAFLPA+RPMl1SlBpFXalVBh4JuDpd0Hw==
X-Received: by 2002:a05:6512:402:b0:510:56e:f56c with SMTP id u2-20020a056512040200b00510056ef56cmr674541lfk.31.1706026178547;
        Tue, 23 Jan 2024 08:09:38 -0800 (PST)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id q20-20020a0565123a9400b0050e7be886d9sm2336950lfu.56.2024.01.23.08.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2024 08:09:38 -0800 (PST)
From: Mantas Pucka <mantas@8devices.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mantas Pucka <mantas@8devices.com>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
Date: Tue, 23 Jan 2024 18:09:19 +0200
Message-Id: <1706026160-17520-2-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1706026160-17520-1-git-send-email-mantas@8devices.com>
References: <1706026160-17520-1-git-send-email-mantas@8devices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 2be22aae6b18 ("phy: qcom-qmp-usb: populate offsets configuration")
introduced register offsets to the driver but for ipq8074/ipq6018 they do
not match what was in the old style device tree. Example from old
ipq6018.dtsi:

<0x00078200 0x130>,     /* Tx */
<0x00078400 0x200>,     /* Rx */
<0x00078800 0x1f8>,     /* PCS */
<0x00078600 0x044>;     /* PCS misc */

which would translate to:
{.., .pcs = 0x800, .pcs_misc = 0x600, .tx = 0x200, .rx = 0x400 }

but was translated to:
{.., .pcs = 0x600, .tx = 0x200, .rx = 0x400 }

So split usb_offsets and fix USB initialization for IPQ8074 and IPQ6018.
Tested only on IPQ6018

Fixes: 2be22aae6b18 ("phy: qcom-qmp-usb: populate offsets configuration")
Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
index 243cc2b9a0fb..05b4c0e67896 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
@@ -1556,6 +1556,14 @@ static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
+static const struct qmp_usb_offsets qmp_usb_offsets_ipq8074 = {
+	.serdes		= 0,
+	.pcs		= 0x800,
+	.pcs_misc	= 0x600,
+	.tx		= 0x200,
+	.rx		= 0x400,
+};
+
 static const struct qmp_usb_offsets qmp_usb_offsets_ipq9574 = {
 	.serdes		= 0,
 	.pcs		= 0x800,
@@ -1616,7 +1624,7 @@ static const struct qmp_usb_offsets qmp_usb_offsets_v7 = {
 static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 	.lanes			= 1,
 
-	.offsets		= &qmp_usb_offsets_v3,
+	.offsets		= &qmp_usb_offsets_ipq8074,
 
 	.serdes_tbl		= ipq8074_usb3_serdes_tbl,
 	.serdes_tbl_num		= ARRAY_SIZE(ipq8074_usb3_serdes_tbl),
-- 
2.7.4


