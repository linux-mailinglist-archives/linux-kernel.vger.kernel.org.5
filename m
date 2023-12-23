Return-Path: <linux-kernel+bounces-10209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8781D146
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60027284F3A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B18ECB;
	Sat, 23 Dec 2023 02:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFR7a73g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C80A5A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d352c826eso29211915e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703298863; x=1703903663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln0tJvVMlAk3UfGMS9i7DjhHyigyKbrD+CwvW3MaF9w=;
        b=TFR7a73gC0qLmHxVItRCc5Pd3T0VRgFYTt4fItthZ1TKgO20CZ8mwazZhfz129Elhf
         HQ47lONmcsocyZAjJREcl/at0q4VNuPtptpEZuudPopU95L9VM0w2wwsFp57/UlNeKQU
         41MO5z8N6r7my1qjIpi7gpAkd/OfbPdFji2HN4VPo0bap8g6AdbtG1c4xmZcUFRa3bFN
         gpp2du+zZwtlEDbL7g4B44ObctrXyyM0C/Qyjdgb5Hr152cqUpAybJIymCw1PQChvWGk
         oJQIDjdvmHSkZzvsSVjDy0kVEunrX0i+9iY0bG2wdxoIpd5X6Pr9kJozIdYfSwkWjt6d
         I8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703298863; x=1703903663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln0tJvVMlAk3UfGMS9i7DjhHyigyKbrD+CwvW3MaF9w=;
        b=Ne4BQgPqaIVAUxFQb4QY7kyHJIh0GENw52eoGDs0h1Ig0FVUXwKlWbuwScu5dD0AL6
         Q+BGHWJvc/vIZOE3z2fVIT9Ta8DSGrTmrcE1fOTf52r/vBTEVI40GEGxMtGoupncGQTv
         QFq/u3OHnTYgNVInPL2+/3LWUVQB1kX3iwzKhNyHmDnOxDQPJYDNpSc+1g31WNe0MZHC
         LWD4XC1Vsz0e94tHjHk8E5xGgsa/CRUO+BaY0xDJnncNA9KodqOtzSTD7VWZXQ8Bid9H
         jz1ls6/jy+nwes0tzObTSRJtyyOzUQQXH14xfbKubxiwAhBhT+WSqT7yKHpT+OqGNMJK
         4g0Q==
X-Gm-Message-State: AOJu0Yy9yZr+z9JZQGfysB2B1wWsSWu32d25UlKRzt8a5r8DgoQtKHRp
	CaHf8T3mcgWwW5W2HGfC8iwnSOk5ff3sOg==
X-Google-Smtp-Source: AGHT+IFmAV48mY4k2x+6N76Kx5phOtnJs+isINenAthmauF6dl5YsH9s9YvlLJEpV7bz4MVF1ZZYHA==
X-Received: by 2002:a05:600c:5387:b0:40d:3838:bbc1 with SMTP id hg7-20020a05600c538700b0040d3838bbc1mr1168191wmb.104.1703298863197;
        Fri, 22 Dec 2023 18:34:23 -0800 (PST)
Received: from sagittarius-a.nxsw.local ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b0040d48781acesm414810wms.0.2023.12.22.18.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 18:34:22 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: vireshk@kernel.org,
	nm@ti.com,
	sboyd@kernel.org,
	ulf.hansson@linaro.org,
	stephan.gerhold@kernkonzept.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bryan.odonoghue@linaro.org
Subject: [PATCH] OPP: Fix _set_required_opps when opp is NULL
Date: Sat, 23 Dec 2023 02:34:21 +0000
Message-ID: <20231223023421.3818297-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

When the opp pointer is NULL in _set_required_opps() use dev_pm_opp_set_opp()
to set performance state 0.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/opp/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index c022d548067d7..182e07ab6baf3 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1083,7 +1083,11 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 
 	while (index != target) {
 		if (devs[index]) {
-			ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
+			if (opp)
+				ret = dev_pm_opp_set_opp(devs[index], opp->required_opps[index]);
+			else
+				ret = dev_pm_domain_set_performance_state(devs[index], 0);
+
 			if (ret)
 				return ret;
 		}
-- 
2.42.0


