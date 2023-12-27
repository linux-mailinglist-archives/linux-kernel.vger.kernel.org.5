Return-Path: <linux-kernel+bounces-11757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981581EB41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5561F22AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BDE1FB5;
	Wed, 27 Dec 2023 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wv+mBK7g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA111FB2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a265d4f78bfso402019766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 17:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703640034; x=1704244834; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BAdkUhCF0OOr2fFOOWv7vL/WbcV+b4PYGfK20EZi0Q=;
        b=wv+mBK7guTFWMQa0iDwOw/xZaUFus7JxRPvvm1QJo5/NVqaiYas2AjQsTm+4Kz9AZl
         5jkA+q7oI/9wSCHya5MBB5vyodl4S7CTSv7iJfs871VU2eZqepV9qs2/B0IOsyIByFQa
         BOZ/OgE+NMjl1m3OizVUY/49L0HCNG6eXAMkZgHWNKvGyYWBkmbqBWuxvRn6MFbvx7ll
         epposTactvR4T/rdXANVwo7wny8zAMwiJ3ppRXb3h/iOZHlgE8zUpDT2qlBhB+mKJI+n
         TOBGOoO3W4rRHcX1PCxQl0/odGIYorCaWRkLlMAVLj7sQxDP2t4L05Cqf2FSz+7MTlq7
         t03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703640034; x=1704244834;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BAdkUhCF0OOr2fFOOWv7vL/WbcV+b4PYGfK20EZi0Q=;
        b=wWNCt2nBtiHlwtw6d9UxSYpH6EEZ8gyJpyMX2oMUZYqa+5kkiDQgZ/NDIEzD6aMA3G
         wNoBO95+sly/rVUcPWlw3DI8IXqxuB/VSz1qKYarqL7absYh8KH6haDqHA0W9+d6HjNY
         9ja6kdKyywL5gxMEckjc79taYVcG5/VUtvLKHkbITbyrFsePGER9qua4XMogY9bmaTRV
         d6q3yS/OqJ6YdpJssCYisV8SDJnxztk7BHDyJMtjGmGDerFdoYRSemxO/tksSkTvXSmK
         EvEG2NzEL9klLF3MJdgzj2X+FxGy+aH2CaZRrdRTHFBzQOMuopzW6w215cNArDw8ecv3
         8VyA==
X-Gm-Message-State: AOJu0YyBtNPH4r3JNYlSb11flDr/0KdlzufoELS2Z/6cMPfDDKKM3HjX
	1C13VwAcg7YrAzPSSiZ/Egk70iJMrwt14Q==
X-Google-Smtp-Source: AGHT+IGn07C+ejaWkfudutVG3jfYc2Z7lPpiyDpCmM2dhMVc3F10b8trA4Dv2FG5LzbOu68TX9qE6w==
X-Received: by 2002:a17:906:95:b0:a26:e106:38f6 with SMTP id 21-20020a170906009500b00a26e10638f6mr2628232ejc.68.1703640034634;
        Tue, 26 Dec 2023 17:20:34 -0800 (PST)
Received: from [10.167.154.1] (178235179028.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.28])
        by smtp.gmail.com with ESMTPSA id ey18-20020a1709070b9200b00a26af6131e0sm5293775ejc.7.2023.12.26.17.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 17:20:34 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 27 Dec 2023 02:20:32 +0100
Subject: [PATCH] pmdomain: qcom: rpmpd: Keep one RPM handle for all RPMPDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-topic-rpmpd_cleanup-v1-1-860ab141b076@linaro.org>
X-B4-Tracking: v=1; b=H4sIAN97i2UC/x2N0QqDMAwAf0XyvIJGQbZfGWPENs5AV0OqYyD++
 8Ie7+C4AyqbcIVbc4DxR6qsxaG7NBAXKi8OkpwBW+w7xDFsq0oMpm9Nz5iZyq4BuR36RPE6DyN
 4OVHlMBmVuHhb9pxdqvEs3//q/jjPH9acHEF6AAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703640033; l=2631;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=tqvTOGMWBoqGPdbq/Qmyk7WDy6NCPjMrsy0aBwvZfA0=;
 b=kEipfeXyLbryIcGNe05HzKxOOylVoBtSOOCD9EJV2YN1xHKTkFxSKO48nhxYYwolZaPCcaQx9
 OtiKUWCN+bmCK93Bj9mDS0vA4lpc8JHTRYQUn4qZoLV8o91WoaWn1pt
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

For no apparent reason (as there's just one RPM per SoC), all RPMPDs
currently store a copy of a pointer to smd_rpm. Introduce a single,
global one to save up on space in each definition.

bloat-o-meter reports:

Total: Before=92010, After=91062, chg -1.03%

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pmdomain/qcom/rpmpd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/qcom/rpmpd.c b/drivers/pmdomain/qcom/rpmpd.c
index 7796d65f96e8..90b62767f9d0 100644
--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -16,6 +16,8 @@
 
 #define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
 
+static struct qcom_smd_rpm *rpmpd_smd_rpm;
+
 /* Resource types:
  * RPMPD_X is X encoded as a little-endian, lower-case, ASCII string */
 #define RPMPD_SMPA 0x61706d73
@@ -54,7 +56,6 @@ struct rpmpd {
 	bool enabled;
 	const int res_type;
 	const int res_id;
-	struct qcom_smd_rpm *rpm;
 	unsigned int max_state;
 	__le32 key;
 	bool state_synced;
@@ -879,7 +880,7 @@ static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
 		.value = cpu_to_le32(enable),
 	};
 
-	return qcom_rpm_smd_write(pd->rpm, QCOM_SMD_RPM_ACTIVE_STATE,
+	return qcom_rpm_smd_write(rpmpd_smd_rpm, QCOM_SMD_RPM_ACTIVE_STATE,
 				  pd->res_type, pd->res_id, &req, sizeof(req));
 }
 
@@ -891,7 +892,7 @@ static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
 		.value = cpu_to_le32(corner),
 	};
 
-	return qcom_rpm_smd_write(pd->rpm, state, pd->res_type, pd->res_id,
+	return qcom_rpm_smd_write(rpmpd_smd_rpm, state, pd->res_type, pd->res_id,
 				  &req, sizeof(req));
 };
 
@@ -1004,12 +1005,11 @@ static int rpmpd_probe(struct platform_device *pdev)
 	int i;
 	size_t num;
 	struct genpd_onecell_data *data;
-	struct qcom_smd_rpm *rpm;
 	struct rpmpd **rpmpds;
 	const struct rpmpd_desc *desc;
 
-	rpm = dev_get_drvdata(pdev->dev.parent);
-	if (!rpm) {
+	rpmpd_smd_rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!rpmpd_smd_rpm) {
 		dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
 		return -ENODEV;
 	}
@@ -1039,7 +1039,6 @@ static int rpmpd_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		rpmpds[i]->rpm = rpm;
 		rpmpds[i]->max_state = desc->max_state;
 		rpmpds[i]->pd.power_off = rpmpd_power_off;
 		rpmpds[i]->pd.power_on = rpmpd_power_on;

---
base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
change-id: 20231227-topic-rpmpd_cleanup-2e043dac9f47

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


