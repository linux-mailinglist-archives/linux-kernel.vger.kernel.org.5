Return-Path: <linux-kernel+bounces-134546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898C789B2DE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD4701C21105
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C5F3C466;
	Sun,  7 Apr 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8WEBy6M"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6A3B7AC
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507029; cv=none; b=i7GruvRJAfe2Mr8/5d4cq2ENPLHU7CIb7InNI/1swy83iOOFrwXby8QawCYBCgxMtOa8OVW0p9W+eovH90CCbcRg2di57xAO4T2T2aZhABhOqg05dgPFQKcydAL5GaD9q7TTxMLOtgBmJqCO/Htz5TqPlXcdHMofl/hXjHWpZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507029; c=relaxed/simple;
	bh=FYDSYbmfadGmbe6XpAJqrRrZBX6gmScLt/RVQz821d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lkcuXl455I1QsHM3cG0lsnzJwNhlRIW2wAeNDBjpL+3gN7jk8GMl1npa2mEjs1NKGKJTMjXQKm1Sbbdl5FZ3AA/28TLsN9xQVk1TbKsmLWikIYRyOHmFFcs5+Mfk+O5CRxkk/DkaOx08/kW1oJFRQvklCma0Pi3yuugqDLGwX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8WEBy6M; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so4398919e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712507025; x=1713111825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vscs/vp4w/DCCZB4T9EYacJgn/oMnEE7t/RUrWC0J30=;
        b=l8WEBy6MlK7G7HnTu2rg5PyVJ+4T7N8yzFhFI0CZXWsI1FNkOnUosgN0Qb2dmmB6xq
         qo8JvGu6yC2WbEhbmJ/kXxdOB4n6RA/H6aa19k3wEHgQJ2UotGPr0ePNukN/YT4/CDum
         SJWer84/06hrwZmD0wco4MqQffQS4FgQVjQL40bEGETCKx9HRDEQakne1m9I66QwAMx0
         2/bMLHoFom7SNEOftnGFamOYDMcKePEBSwa7stGb/RN2QB9/FhsSV2XngxeT/pbcZQO5
         B6Ge/X91YqvnNTVBLyZLbcBZ87StZ9NqaGqRkna5nQDkbl04EtZ+D6MBVDYS/D9OTNKf
         crrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712507025; x=1713111825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vscs/vp4w/DCCZB4T9EYacJgn/oMnEE7t/RUrWC0J30=;
        b=QWr7a3CGY+JTtNZMYNwM4cDbVpsNXLZfumHQ/8/k9qUo0KMpLW/1TCGJiPZzQpQF9z
         +Z6NecjvJhSENTVByN+dG2WFQtFRQYVndi5SV0aRtNrFvIn8A4QSAF1qR2tu/lk3nDIF
         OV2J8BiOVvDhFGi7vJYAOqvcl2KppSZpKOu6c285UOsw+5OSxNyA9OdEh7LE8WBr44Xi
         paT5PIZlKDlh67z8O0a5SICVWf2B4hT+HoSLpeM+zg5L1yB6Yujk6CY7UhfNZ6AMerjr
         Ugn97KeIF3COPmOnEQdnpGIitF/GWanxyQIiyq7DPvIk2glRMSzDAohGOtyvhEBCh0LE
         K2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVwXYb6+5Wc4WBis1vlO0jUMowsP+cqQTX+KOxqV5VRJZP00jNRgFKsBwf2QFy9zhdTW+gnw4yxkYfsOi6EqG/vyvyuy4ioOhEXP6m0
X-Gm-Message-State: AOJu0YwUPi3qu7RVlTd9vC1ShbSwiZFD10Dgkg1zF21azuTNGHbvczcC
	JHAbDhvCarYataVhJTZuYri25A0zuv40fSX/iz30e1ILvLK4PcpglP3pCIQq31kDNl0tcfrHHP2
	W
X-Google-Smtp-Source: AGHT+IFTroclcEILQ+ze+mBcd9b3SxEaZM09rIp/V8POCBbv5tIoL3icq37ZZdxfWFkBbAy1JYVerw==
X-Received: by 2002:a05:6512:475:b0:516:c1b9:22e9 with SMTP id x21-20020a056512047500b00516c1b922e9mr4454812lfd.17.1712507025226;
        Sun, 07 Apr 2024 09:23:45 -0700 (PDT)
Received: from [127.0.1.1] ([79.114.172.194])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a51bed388a4sm1811626ejc.139.2024.04.07.09.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 09:23:44 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Sun, 07 Apr 2024 19:23:23 +0300
Subject: [PATCH v9 3/7] spmi: pmic-arb: Fix some compile warnings about
 members not being described
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240407-spmi-multi-master-support-v9-3-fa151c1391f3@linaro.org>
References: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
In-Reply-To: <20240407-spmi-multi-master-support-v9-0-fa151c1391f3@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Johan Hovold <johan@kernel.org>, David Collins <quic_collinsd@quicinc.com>, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=FYDSYbmfadGmbe6XpAJqrRrZBX6gmScLt/RVQz821d8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmEsiE01RcIzvn1/GAP/pGKGg17V5zKKsmiEOUp
 BIJQ/dwspmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZhLIhAAKCRAbX0TJAJUV
 VietD/0YfHXAxrcZlJBMPjukOj1ghQjxodW3aC8xQgQLao5CTb7h1UPdxdMgsa5J1leJN/ag0L8
 4/65veby6zyHkMUCo7J/AP3VM3s0CJj9QjSH4c8/rh2rIfrl8qO9lFidlG8SBVBEhWQQSgHZd4N
 +be1VE0ntdVuBO3KqD2NEgk7vxERBfFai1XeLkNOyP7uSIT+arBNUmjYCsHxdWgj4/odjfF5Wtm
 oBEpPl7+o8eYvBIGiRNRW/Y7WYZmMwjUzK42OwbedJiRtjbJ+CFcfmfA6nwZGL3buwnSs+ON6S+
 yvXi/JmJVcmhpr6aoAF+VbtkWv+FZoFO95Sf7litHpDOxefMCZ/gDGj11UhfKxItIe+//FvtE4Y
 3cZ0kRadZgqv2HrVB7a4Ob8DnJ70aYyysKJyUjWg44eNOklLri+NAELM1c2X8d5gl/vwhCSl/8f
 dkVADc0iagQwCBgyNSFR7I1Ls6OYb36lK7IDy1bsszlLwgWmgybCa+56Hskgot8PS8IOfxmFue/
 GnXgwV9Fon6AHXclEdY1wACkUqPfl/Z70Qq1DCbSomiI6Cd6y7AFZ4dk8bVwm5S1sEzBeB2Zjvi
 o3O1tKwABdyXM3UV9pWDh3GRDyHIrrw7oYfe9n+2XpAfJLauzrBUgWh6Lvgz6U/bTYCJTM3imW4
 erkidpCuwZu41Bg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Fix the following compile warnings:

 warning: Function parameter or struct member 'core' not described in 'spmi_pmic_arb'
 warning: Function parameter or struct member 'core_size' not described in 'spmi_pmic_arb'
 warning: Function parameter or struct member 'mapping_table_valid' not described in 'spmi_pmic_arb'
 warning: Function parameter or struct member 'pmic_arb' not described in 'pmic_arb_read_data'
 warning: Function parameter or struct member 'pmic_arb' not described in 'pmic_arb_write_data'

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ed1180fe31f..704fd4506971 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -132,6 +132,8 @@ struct apid_data {
  * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
  * @intr:		address of the SPMI interrupt control registers.
  * @cnfg:		address of the PMIC Arbiter configuration registers.
+ * @core:		core register base for v2 and above only (see above)
+ * @core_size:		core register base size
  * @lock:		lock to synchronize accesses.
  * @channel:		execution environment channel to use for accesses.
  * @irq:		PMIC ARB interrupt.
@@ -144,6 +146,7 @@ struct apid_data {
  * @apid_count:		on v5 and v7: number of APIDs associated with the
  *			particular SPMI bus instance
  * @mapping_table:	in-memory copy of PPID -> APID mapping table.
+ * @mapping_table_valid:bitmap containing valid-only periphs
  * @domain:		irq domain object for PMIC IRQ domain
  * @spmic:		SPMI controller object
  * @ver_ops:		version dependent operations.
@@ -232,6 +235,7 @@ static inline void pmic_arb_set_rd_cmd(struct spmi_pmic_arb *pmic_arb,
 
 /**
  * pmic_arb_read_data: reads pmic-arb's register and copy 1..4 bytes to buf
+ * @pmic_arb:	the SPMI PMIC arbiter
  * @bc:		byte count -1. range: 0..3
  * @reg:	register's address
  * @buf:	output parameter, length must be bc + 1
@@ -246,6 +250,7 @@ pmic_arb_read_data(struct spmi_pmic_arb *pmic_arb, u8 *buf, u32 reg, u8 bc)
 
 /**
  * pmic_arb_write_data: write 1..4 bytes from buf to pmic-arb's register
+ * @pmic_arb:	the SPMI PMIC arbiter
  * @bc:		byte-count -1. range: 0..3.
  * @reg:	register's address.
  * @buf:	buffer to write. length must be bc + 1.

-- 
2.34.1


