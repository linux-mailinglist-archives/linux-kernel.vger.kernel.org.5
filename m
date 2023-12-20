Return-Path: <linux-kernel+bounces-6557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC9819A52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFB128680E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252851A70A;
	Wed, 20 Dec 2023 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcLIS6hA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421B1F5FA;
	Wed, 20 Dec 2023 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3366827ca79so2850978f8f.3;
        Wed, 20 Dec 2023 00:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703060360; x=1703665160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/05gyybgBQlV8UNawEOqfKB7YfVOa24q0Xo2YzuiNgE=;
        b=NcLIS6hA0WFWnyyPg5x4AsEof5jb3eisfq8GU26dSWOQ1HMAy+i38qIchtQDYW3T8T
         WXVwgW6k+Zr/gQDsUgmEPyRB1hshwqyEM0u9awVWhKhZ0lhQAwi6ySoY6+q6qKtsw7ur
         sFC31UfAUTGJJelwTwXymfXRMXouBPJBMHrnFDlgFcnFoBdN3EVYiatjql90tG+tLPmW
         ZrxCMv37z/OTIhvX2VPudSlNmSK51LBW58cd6XPXxlqflYJO16c4V71QSbeFBvJmUIoq
         b6mb5bEwHfoCOWFQMBewL2b4xp/o9Y9aSG3JU6arUVvWzFoXq3r+co7KNKTNti8XtTOW
         dabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060360; x=1703665160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/05gyybgBQlV8UNawEOqfKB7YfVOa24q0Xo2YzuiNgE=;
        b=rJoY1nDmYPkGaGq3ckjgqIzGrAm39wdyqpVlGm04ZTPNNS2lfqG//+1y2AlWGETXHw
         DVEp7f3eqvPTX7vLKMreZB82Rew5mMJppFmNFT4wSSaRs5bOlemX/xrVQxCbEJy9apII
         Zh9uTVe7yxVh1SAC7igMsCbF149M2qi3kTtuWRnV0QzOyJI1CAEDB+forrnAjwkQYJ+C
         Ln6ssYazxDF061IqbvbZkZwycokIMy0lSCcXfPoMg4d1WGmfvF4DiKL1BmhNFQvpAaYo
         7DaWeqU++cioGrbsnoIyXZ+Hb555gqpsfBXXNlzPvtAKHBBoaemPRpRx/IlaaV7bQRdT
         4n6w==
X-Gm-Message-State: AOJu0Yx1qb+PhX7Iaz+OcXbvOIuQ5CmbRxqR1a1Z3h43Wqc+PXHBX9el
	050u/kjiobz7SBCd33Plf/M=
X-Google-Smtp-Source: AGHT+IFog72/NYEmn/ARAMtEPu7RpxbMux1aS4MRnpL01zSM0YLu6DTfHMVrweV75lqLrPlcAz1EEQ==
X-Received: by 2002:a05:6000:137b:b0:336:68f9:e829 with SMTP id q27-20020a056000137b00b0033668f9e829mr2556088wrz.9.1703060360101;
        Wed, 20 Dec 2023 00:19:20 -0800 (PST)
Received: from ran.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id t4-20020a5d4604000000b0033642a9a1eesm18627820wrq.21.2023.12.20.00.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:19:19 -0800 (PST)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: richardcochran@gmail.com,
	jonathan.lemon@gmail.com,
	vadfed@fb.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	maimon.sagi@gmail.com
Subject: [PATCH v1] ptp: ocp: fix bug in unregistering the DPLL subsystem
Date: Wed, 20 Dec 2023 10:19:14 +0200
Message-Id: <20231220081914.16779-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.26.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unregistering the DPLL subsystem the priv pointer is different then
the one used for registration which cause failure in unregistering.

Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
---
 drivers/ptp/ptp_ocp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 4021d3d325f9..e7defce8cf48 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -4492,7 +4492,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&bp->sync_work);
 	for (i = 0; i < OCP_SMA_NUM; i++) {
 		if (bp->sma[i].dpll_pin) {
-			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, bp);
+			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
 			dpll_pin_put(bp->sma[i].dpll_pin);
 		}
 	}
-- 
2.26.3


