Return-Path: <linux-kernel+bounces-57062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7184D390
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B31F277C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C25128838;
	Wed,  7 Feb 2024 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV827iex"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B4127B4A;
	Wed,  7 Feb 2024 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340635; cv=none; b=NAXzZkJT/z0dSZaFmbr1ul+yZdEfKDokepA3jO/tPG/w4ShOuWRthBVjeoPS3rPAKaunaiDJO3J8uHnTgyva5z4MQWbdL3CnIbJnwMBC9AYPtBz7AI7HLBst9TmHs/2us3nJY8990UjzI0dbY/6dqD3H09JcyOesvFjWNU8OzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340635; c=relaxed/simple;
	bh=NYZpM+IYT/xIIde173sVPPc8ESzfdo3M3EJ+e0bPr+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hlfTPBLgC/WuGovOYjqP86w1tORQEYBL08a/zyeT9ruXFtHhjZAVDH8a0s1y38b6U2ZN2v8+HtlMV/R/hs9N+SOharG8HIw3dqY9ciCfNiGShzz2j8fawtm2mqdfY96NETeA9X0S4zZz8FKPS4s2Pq1f3yZGlVHDJJXHq50kGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV827iex; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0ce22b5f3so7704291fa.1;
        Wed, 07 Feb 2024 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707340631; x=1707945431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iP3kkGz7gSAbzXRqG5pPEc7tTjDb7YBxeLYLponH8zY=;
        b=GV827iexO4lr8renPwjEvkD5IMKYRPr6HUCH1Hfq7EBTclWMVpsi/a1g24/kls1PHJ
         MBNZY7QBZJjMb4mxIEZxfvXUfR/XHizvOqipc80+WRcxIpSIfdP8e2uvS0es8T+7TJJx
         +7bJgaJEYzwQKLkYTZY814XAqE1CPzuT0XBq13Fihnq2+tRhOreFo3IizjNCfsBBgEcC
         TTWjS0CQue+4jFeBIQzLpSuCrVh3IzkRtISctOlCRqPD4wFPMgBK9s/Y7V7Or27Lt2HV
         Vp7xTno1aO9T1BseNSncKu1VgC2E6oSB0R3PULDvFldRBE2u9Wzwz9Rz/eUf+GBSAOOY
         U29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340631; x=1707945431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iP3kkGz7gSAbzXRqG5pPEc7tTjDb7YBxeLYLponH8zY=;
        b=DwiME0/tEkcY5KZHQeEtVjMH7UYjLiAQwQE20FnJViZT8nW5DAipWVelpGPZw167V2
         MjGq50JOmvbaLz/ZbqyleWUR+lGmDR5Lo0Xz21hWO0TVU/bSxIcmj+qpC2f3aOTKpeNo
         0jQLIXeJzqVkHs0zmEib30OsVCx0jyhMMGRAxTVgwrhzOOQS4kds8MIoyfkxWKAaCLd4
         xHlNxtOIzx7GmPqjQi4qls1Xba6PEBnEfWb/g9OfZE0lGkopszenzaOvSEmTZ9/EFEvk
         v+aKawRtgpl62IuMtSEbcOUIk5QxBPn/jnv10+6P97X4riwP4KTVImPcOmSLlLvMLyXR
         Wq+w==
X-Gm-Message-State: AOJu0YwQw57kRnnfg0QeSYdl/Ec1nx744o6rkl3mPxRbuevJD+y4smMS
	+S0i6aa1KuvvumSVVnkQzk/0X/AvhlKurE/ciT2HzpQfib5ZvW7K
X-Google-Smtp-Source: AGHT+IE35ydyNRdeBiun608Q5IICgMiFIz9bLPPUgShkXaDCSERuMRxS3H9edeajjWbgjtwQmVXiJg==
X-Received: by 2002:a2e:804b:0:b0:2d0:66cd:8637 with SMTP id p11-20020a2e804b000000b002d066cd8637mr5329506ljg.41.1707340631222;
        Wed, 07 Feb 2024 13:17:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVOW9H/KoRuIOZqIaCNcQ9teVy/xZScd5YEX1yiC0meAeHMO9a0nseEaPKHBVtotbB0Xeyw0kmUtTURHobEJED8vPDK7MnsYDhfedgGysFIB+aOiMOkSL55E9dPMRhSjNhoFh9BHxqPoNY6ByXDhcDrNuLJHgwL5dIFcDeTv4rGfLih7HpB3JtsrgdEtwT1N5+u5RpuhIjuD3Z
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3314-d4ec-5095-daa3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3314:d4ec:5095:daa3])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e8300b00560622cd10fsm98362eda.68.2024.02.07.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 13:17:10 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 07 Feb 2024 22:17:08 +0100
Subject: [PATCH 1/2] hwmon: chipcap2: fix uninitialized variable in
 cc2_get_reg_val()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-chipcap2_init_vars-v1-1-08cafe43e20e@gmail.com>
References: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
In-Reply-To: <20240207-chipcap2_init_vars-v1-0-08cafe43e20e@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13-dev-0434a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707340628; l=1189;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=NYZpM+IYT/xIIde173sVPPc8ESzfdo3M3EJ+e0bPr+8=;
 b=hq+dmogC+6WNc0XZnq3PNPzOt9pIgsUJm+gwsRP/m9lKu3QOnW3KGWfDztWs+IJwJqgWG+Q7N
 rIZjrohiaxkD+kYqaRmcjseSLLW/ZU0T8oDYdgzsyl6QFC5oJRn7iEG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=

The reg_val variable in cc2_get_reg_val() might be used without a known
value if cc2_read_reg() fails. That leads to a useless data conversion
because the returned error means the read operation failed and the data is
not relevant.

That makes its initial value irrelevant as well, so skip the data
conversion instead. If no error happens, a value is assigned to reg_val
and the data conversion is required.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-hwmon/294e4634-89d4-415e-a723-b208d8770d7c@gmail.com/T/#t
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index a62c507b1042..3b604fc5d8ae 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -324,7 +324,9 @@ static int cc2_get_reg_val(struct cc2_data *data, u8 reg, long *val)
 	int ret;
 
 	ret = cc2_read_reg(data, reg, &reg_val);
-	*val = cc2_rh_convert(reg_val);
+	if (!ret)
+		*val = cc2_rh_convert(reg_val);
+
 	cc2_disable(data);
 
 	return ret;

-- 
2.40.1


