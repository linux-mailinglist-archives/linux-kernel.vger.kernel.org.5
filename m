Return-Path: <linux-kernel+bounces-12426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FCE81F4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DE71C20E25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFB323A7;
	Thu, 28 Dec 2023 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNrWRZ0B"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74515D2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d45f182fa2so18572045ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 21:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703741359; x=1704346159; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4wrXuBDdQR1JrqtAidYtGXT/UZktLXAIUHcsugG1q0=;
        b=fNrWRZ0BcDDYxZLkSpI31wjRq83VQwL7KllLIs9puqxkeyoR9Rudb2zkABaw7A2PpU
         ZyhxQugPHqGbPTUgjNLqcNlnjkeCitU8IeMibmwaDPYvWLMslxTWRPz2a9LzuK0E+iiT
         z5vJcUYISYzDEZNc/QM+b6ScqZHDXYms4GrikeW9vmFrZrvE34mgyGj8dT86XefUf/aL
         TP7M6IKmIa9m2vak+aaEYOhOkAnWer7B6svB/CJ5N0O3j8oe+OPTAixqux0ksVDlUlYh
         N22qKtU2dfjg1r2UHb/rjALSiHa+BVmTXmOfBdkFvoydoGKOY48Z6GEEhpWGOUH62V7J
         v86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703741359; x=1704346159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4wrXuBDdQR1JrqtAidYtGXT/UZktLXAIUHcsugG1q0=;
        b=gypqBeX5Tkrt01b+AYIBTroaaAdUdhCdqMUxu7UxuRduwJcti32aaXTcNq7OTdS8Er
         fj9CSHmZkjYZe2re89VOPU10LMtFWgyCy2SZYKfw3O2Uc6NXllleHg7ovmLUxhLqlB/3
         7tQfKk26G5h4q7QH0VDFDfpbPrzEgCeElMph4PXUu8c57lDwZ4Jn1UTupP6mqlROlACp
         zLM40Ss4FTkRKLQk+M34SQZCOI7hf6/pIbR6wp7DRWuVyOJIm1T+fOKqfB4wXapBRCLf
         Y6q1yGESOO0XyLNxdx4gFByMnFG+8N66pM4X36pdTX/QqcWmvX9Ui8VJkpCdBaYbaBwh
         yw/Q==
X-Gm-Message-State: AOJu0YxK13cHS1LreVwKCwMe3VvWa8E8df2bfucJWh7TFR0ybsyhFFZc
	F4mJy3YMWe5UWngJfQMrTPwGm7PczOB6Nw==
X-Google-Smtp-Source: AGHT+IHHGfSXRmYt4sOEi0zvGnO3QGTmhrJKVc+PpJqkEYRmshLT6zpqR8p4t0JKp9qKt177O5CAKQ==
X-Received: by 2002:a17:902:684f:b0:1d0:6ffe:9f5 with SMTP id f15-20020a170902684f00b001d06ffe09f5mr342433pln.83.1703741359089;
        Wed, 27 Dec 2023 21:29:19 -0800 (PST)
Received: from localhost ([122.172.86.168])
        by smtp.gmail.com with ESMTPSA id c22-20020a170902b69600b001d2ffeac9d3sm3716220pls.186.2023.12.27.21.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 21:29:18 -0800 (PST)
Date: Thu, 28 Dec 2023 10:59:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, ulf.hansson@linaro.org,
	stephan.gerhold@kernkonzept.com, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OPP: Fix _set_required_opps when opp is NULL
Message-ID: <20231228052915.ft4e7hwgtngfsyc7@vireshk-i7>
References: <20231223023421.3818297-1-bryan.odonoghue@linaro.org>
 <20231226055936.pzyt4xjzlfhfqb4y@vireshk-i7>
 <d50810e0-b8e7-4394-975f-d77d8dd24849@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d50810e0-b8e7-4394-975f-d77d8dd24849@linaro.org>

On 27-12-23, 12:41, Bryan O'Donoghue wrote:
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Thanks Bryan. Here is the merged commit:

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Sat, 23 Dec 2023 02:34:21 +0000
Subject: [PATCH] OPP: Fix _set_required_opps when opp is NULL

_set_required_opps can be called with opp NULL in _disable_opp_table().

commit e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
requires the opp pointer to be non-NULL to function.

[   81.253439] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000048
[   81.438407] Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
[   81.445296] Workqueue: pm pm_runtime_work
[   81.449446] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   81.456609] pc : _set_required_opps+0x178/0x28c
[   81.461288] lr : _set_required_opps+0x178/0x28c
[   81.465962] sp : ffff80008078bb00
[   81.469375] x29: ffff80008078bb00 x28: ffffd1cd71bfe308 x27: 0000000000000000
[   81.476730] x26: ffffd1cd70ebc578 x25: ffffd1cd70a08710 x24: 00000000ffffffff
[   81.484083] x23: 00000000ffffffff x22: 0000000000000000 x21: ffff56ff892b3c48
[   81.491435] x20: ffff56f1071c10 x19: 0000000000000000 x18: ffffffffffffffff
[   81.498788] x17: 2030207865646e69 x16: 2030303131207370 x15: 706f5f6465726975
[   81.506141] x14: 7165725f7465735f x13: ffff5700f5c00000 x12: 00000000000008ac
[   81.513495] x11: 00000000000002e4 x10: ffff5700f6700000 x9 : ffff5700f5c00000
[   81.520848] x8 : 00000000fffdffff x7 : ffff5700f6700000 x6 : 80000000fffe0000
[   81.528200] x5 : ffff5700fef40d08 x4 : 0000000000000000 x3 : 0000000000000000
[   81.535551] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff56ff81298f80
[   81.542904] Call trace:
[   81.545437]  _set_required_opps+0x178/0x28c
[   81.549754]  _set_opp+0x3fc/0x5c0
[   81.553181]  dev_pm_opp_set_rate+0x90/0x26c
[   81.557498]  core_power_v4+0x44/0x15c [venus_core]
[   81.562509]  venus_runtime_suspend+0x40/0xd0 [venus_core]
[   81.568135]  pm_generic_runtime_suspend+0x2c/0x44
[   81.572983]  __rpm_callback+0x48/0x1d8
[   81.576852]  rpm_callback+0x6c/0x78
[   81.580453]  rpm_suspend+0x10c/0x570
[   81.584143]  pm_runtime_work+0xc4/0xc8
[   81.588011]  process_one_work+0x138/0x244
[   81.592153]  worker_thread+0x320/0x438
[   81.596021]  kthread+0x110/0x114
[   81.599355]  ret_from_fork+0x10/0x20
[   81.603052] Code: f10000ff fa5410e0 54fffbe1 97f05ae8 (f94026c5)
[   81.609317] ---[ end trace 0000000000000000 ]---

Fix it.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
[ Viresh: Implemented the fix differently ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/opp/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 49b429984bdb..a6e80f566e9b 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1066,6 +1066,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 			      struct dev_pm_opp *opp, bool up)
 {
 	struct device **devs = opp_table->required_devs;
+	struct dev_pm_opp *required_opp;
 	int index, target, delta, ret;
 
 	if (!devs)
@@ -1088,7 +1089,9 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 
 	while (index != target) {
 		if (devs[index]) {
-			ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
+			required_opp = opp ? opp->required_opps[index] : NULL;
+
+			ret = dev_pm_opp_set_opp(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}

