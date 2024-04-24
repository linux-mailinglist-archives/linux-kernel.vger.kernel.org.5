Return-Path: <linux-kernel+bounces-156808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080788B0872
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1AD1F242D1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808515A4B7;
	Wed, 24 Apr 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ie2F7g/j"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D315A492
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958850; cv=none; b=A5J+wUTUH5ULVVJOAD2i2xOUnTjNJ2WsBBpPljRd+hAcO72eftlMYmisgQrHMmYVGSrbq4El8hfj2sRbotDYvwxbLM4vKJxdrFl00/P6ELVmzT6/i+2pBjaoyM37WvemzcT2mu2GRiON7079y5ABo/rlyR3glUXCIk1F1FFR5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958850; c=relaxed/simple;
	bh=DZn1msmrvnUDpB1XYGLTb2XSqmSMQi5pdRoTelsZwaM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dXIEUioemNAJUqIrgpCldIrPFvg+mTCIgntAOb0EprW046c6PxsFNFJDb6hDNSklZQ2ekS1FKm27qY+tLQGGa7QL6hV4/DTRLvNR+vIYL8bxZJ1vBcw0MVyUPupvBfkKlQg0J0DdYCubVoFJilSY8i0q7d5imeTaot5BG1XHm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ie2F7g/j; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41aa2f6ff2dso17286755e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713958847; x=1714563647; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0lANIOxi5uxn7sMyfNP37wCyBCdh1cTCQaJU7DGFG0=;
        b=Ie2F7g/jhqM0Uk5g8zolDMMKc9OKIGjSZI/tzuqCrD0P3jv9wKaHsjIcK8rdrcPPky
         S0xK9Xx/97lL6WGoZk6lKcz2a6H8cudDiJfg/ncirdQbxsGujUeD7q05FzaLp+VT/pCA
         D9hUL/soUOcApysUSDKSld2jd4lwazqrXRctSdmk+FWudBBOFRYujTpGCGXAbo+xcHsl
         0oyfc2nJRIbgqTlrZaiFZZ5YBNiLHSlzaOquvzj+xRXwrJCFYdGm+l0As5PrWG/cL6jU
         gGWZl/Z+ws9L1ooeAsSrNFp0mWFjp+3ctRglvIqL4WBl72R0nVFwvHl1xjkr+m64W+Dc
         22hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713958847; x=1714563647;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0lANIOxi5uxn7sMyfNP37wCyBCdh1cTCQaJU7DGFG0=;
        b=ZDmJeROIVEKRJLVwJwY3FuEQ0CmiWzL7/m1H/j5p0Oj9jL5libMsTOF7R9oB4YQJYo
         HyqiGUQ27G6gsbxQxNqwg83afiS6e+x0XbiWcUW815jOJXva0htAKYICyPTB/LlYhjXG
         WbDHAzghEREWNZgnjx+4WlOfExTnYlbiQcf/sHHLz0dJVVO3B3SwHW/UVPO4SRY8xH6W
         G+A4E7+c4RaMRJz8xaM5u2NRlqhI5gtpdPuwQBMwjH5nmrgwKD8FgYwInhTtulrFN7tY
         vjcHL+PuQUbbdrKYuttFX2ERi1CYhDhkzSMP5WbCaV740kB+G/kMPvyTZnVKjG8A9Trg
         3xjg==
X-Forwarded-Encrypted: i=1; AJvYcCVj0gdyxXOMX4+OqGBt3kyX+gZHowh3iDwHTC2AZiezXzqnDpHzW/+2BB9tKo5Ybgw+Cl0uSrQkS0Umvu4PcAWJ1vPxINlaLM8F/spR
X-Gm-Message-State: AOJu0YxHw+yOh2IB+ragBjFQB89oIORmaR+vS+w5dHtr4PYl3TeczEtQ
	fnOA1/4d5GVsHWK/bxjpgkwBLOcriQTv4z9S6yLs3ilS4GWKtuLmeYPJypRm8wQ=
X-Google-Smtp-Source: AGHT+IFEpG6VVoFe2vx9Em8Wq34NxagOiwS0imQ3bplPo2B0dlfiYMxGiYckEUmIjeAACcHinXRoAw==
X-Received: by 2002:a05:600c:3d88:b0:41b:417:cd6 with SMTP id bi8-20020a05600c3d8800b0041b04170cd6mr886304wmb.7.1713958846907;
        Wed, 24 Apr 2024 04:40:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c1d1000b0041902ebc85bsm1305782wms.1.2024.04.24.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:40:46 -0700 (PDT)
Date: Wed, 24 Apr 2024 14:40:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] firmware: arm_ffa: fix memory corruption in ffa_msg_send2()
Message-ID: <cd5fb6b5-81fa-4a6d-b2b8-284ca704bbff@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "msg" pointer is a struct and msg->offset is the sizeof(*msg).  The
pointer here math means the memcpy() will write outside the bounds.
Cast "msg" to a u8 pointer to fix this.

Fixes: 02c19d84c7c5 ("firmware: arm_ffa: Add support for FFA_MSG_SEND2")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 9f89ee0aaa6b..363e86936461 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -363,7 +363,7 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *buf, size_t sz)
 	msg->offset = sizeof(*msg);
 	msg->send_recv_id = src_dst_ids;
 	msg->size = sz;
-	memcpy(msg + msg->offset, buf, sz);
+	memcpy((u8 *)msg + msg->offset, buf, sz);
 
 	/* flags = 0, sender VMID = 0 works for both physical/virtual NS */
 	invoke_ffa_fn((ffa_value_t){
-- 
2.43.0


