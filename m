Return-Path: <linux-kernel+bounces-142231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501448A2942
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D1BB2814F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983CB5028E;
	Fri, 12 Apr 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHZoX7m9"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC674F5E6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712910345; cv=none; b=tzDtGAuXaIR3ppc3QwFmNWKdXkaYPhKbOcFSI9duOvGYK2OBpOrOjIZ0+ZTPM4/HgAOy7Tx82TdcWyV7i22Ovwd1t6tgj4GbTyAvbhoJcVFKlCeBT/q7ew7yVcDt4uaFjkKZQQNZT+R0NWifcxVvge55sH63e/g6WmV9zJQxPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712910345; c=relaxed/simple;
	bh=XlNSyD7mVXNmtkUW+UZj34vv2u6JqsZlZ8WpD7Idp+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uKAE0OSZ5uTlFEOI6FElRvvQO6MJkwdvUgLczYMfwsh9P/ATDp8AGnZeyvNmQORktK0jWWMh612+gGjVftzp3v6IJsf4743gNfGnM/8SYVAn43ieC/2sSCkr3dO9PT6Oin4rl/XJgLFhmCG+7PhavRFwfFU+nI6A25Su7dY4Nlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GHZoX7m9; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44f2d894b7so65622866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712910342; x=1713515142; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBk3IkdFTVmum+vYtVeAJMby59eq87hfD5TBghPTWMM=;
        b=GHZoX7m9fPR0H/px2kkA3i7foDx0yb/n831EdrbErogXZwunVRFPVcbUlIxXqGBB3c
         059a+swXHiPvYxN+BDYx+vl1aAJ/vyRVfhZAUn1IAzKJjNLOTyyDf3WLEeyu4VbRFnaJ
         o/LX5eF68ZfsPxG4yNJBSMsNcyBfo7hNqVYmQafTygAjC4YQR2smt55u3bGC8oKg7Y7U
         TEiEO+eChhCkgOJx3QD5BUjDKDIf7+63Pl94K8FP02Ad/msqXocor5/x/OovoFWwjm1H
         qQ0WJ6rLJqz39Fae+O/qm04PPpsmxQxdYQ5wjHINDVIjmksuYeY1fk1y1/y9yWlo7Ejg
         J0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712910342; x=1713515142;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBk3IkdFTVmum+vYtVeAJMby59eq87hfD5TBghPTWMM=;
        b=RknGTWA+8SNPtfBfVA81dIb9zQhxz+tW6UH0iOEOUGuYqkI9tkxY6xm7Z5F3oS6hVT
         SaCsksHa3hrekJWfTKosdjj6z1sQXgOCJ5J4iPU4RsfzqYzKFVu2u50k/Swhyt689anL
         4dcyhAAB0TUpUE8obAy++3ns53kQoMo97fHi/AYHbb6Dnq6Szv/IZZGmNnDCOiamvHRk
         jTVF9KBqPOsZqBEo5rU5vlzGpCcLKdo11Atv+owThT9h61im7OQcMTpPmY5WdZeCCsxv
         OkVx12y+JVeiGHCI4v4l0G4u2BB8UOWprCsh000umXltnBcgXPRZ4aN6IfStZOL940FK
         9bBA==
X-Forwarded-Encrypted: i=1; AJvYcCX9skbvQQmH1EWVAFTUVLu89WJaYyh6DUrsRRyPShzTGFNXOr9S+WHE51wj/bVn+w53LEncm3YdO+nu/eEGDC8AoOuz76pYZXKj6mIg
X-Gm-Message-State: AOJu0YzAGzGQ2VbsxG9O5SGcjcgN/D1we04sdzmXtMUmmyrIYJ6aHKz4
	F9Yb/F0NWlQ80278FS3TkZLcCOU/eQYpoLigndL/gHAA5vUtlY/y/cBsPan2Eo4=
X-Google-Smtp-Source: AGHT+IE00wDPrRr8eIax00TpINor2PbGdsjSZ8kU77JYzzDd3jq7whb6zK+VFuCJsGHEYumc624Pkw==
X-Received: by 2002:a17:906:4f06:b0:a51:e351:9ad4 with SMTP id t6-20020a1709064f0600b00a51e3519ad4mr1518672eju.9.1712910341629;
        Fri, 12 Apr 2024 01:25:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id go36-20020a1709070da400b00a51fea47897sm1546872ejc.214.2024.04.12.01.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:25:41 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:25:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] bus: stm32_firewall: fix off by one in
 stm32_firewall_get_firewall()
Message-ID: <17dce071-21ef-49f5-be45-f93bbf3642ec@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "nb_firewall" variable is the number of elements in the firewall[]
array, which is allocated in stm32_firewall_populate_bus().  So change
this > comparison to >= to prevent an out of bound access.

Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/bus/stm32_firewall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/stm32_firewall.c b/drivers/bus/stm32_firewall.c
index decb79449047..2fc9761dadec 100644
--- a/drivers/bus/stm32_firewall.c
+++ b/drivers/bus/stm32_firewall.c
@@ -53,7 +53,7 @@ int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *f
 			return err;
 		}
 
-		if (j > nb_firewall) {
+		if (j >= nb_firewall) {
 			pr_err("Too many firewall controllers");
 			of_node_put(provider);
 			return -EINVAL;
-- 
2.43.0


