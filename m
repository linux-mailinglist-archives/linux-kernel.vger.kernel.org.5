Return-Path: <linux-kernel+bounces-136680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E1C89D707
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7921F22107
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE9281725;
	Tue,  9 Apr 2024 10:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SB08Rwjx"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9A58119
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658751; cv=none; b=G4YWgdbkjk0l7bsikts7G6ymvOEFlUFrnPSZ6yUZ6HWjOvhp+9NjOzJ18ez1BCZnCnnfom4lntFzVABr5jj+XJ3CR8LUxejlGsQ6+WxONmVdIVqnnf6Ie76kY/4RK1iH+//YafxPcQT4fD5E3UoGdk/qcB7qnaiRXgixlYcZCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658751; c=relaxed/simple;
	bh=UX9k3/oswSpfOSvNZcldfTNpVEuueE8+0oPvL3d72Ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgwmF7llq/Bn7WEB518QkionNPcALoLDyjA9IQTqYJgBNOJqPlCT1adaKzCy7A8S4Rgh9nXOD1gg6okMYkSim6r7/IBAWr3um3hKJGj39ptnJtElyyRJgIWorxy9Ia82in4KXUda6rnhU+C6qW23/vHidZYX3QC7T+D3ea8msrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SB08Rwjx; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa16c0583eso1791465eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 03:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712658748; x=1713263548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6wiRCdd89h1sVMfB48/ixg+/YiJUwbUXTRR0BuEf6E=;
        b=SB08Rwjxu7Ls+gAb3fV8ixQMYHqvxvETrfahPNf8G5XiVDnP/O0L8Rm2nPyxe4UysD
         qvQX/m7OYxot2c31tTYnz/aHRQSRqj6Be9GPAKx7hO85pLDdrIDqc+2gOCZp/TWTmpmx
         lRj7+bfGoUOyBrGQ1h4+Rvcvsn3wnW64R6nnTRjGWu/VpvVFy+wXWOVRJQRFGSvLDi8s
         YgDjsj6UUwsFeVHe9smE3OrBjYEzOLt/vyM30du/OJtX9vb2qiI3uQvt50E1svHuebCP
         85V+aYa1LpXSdirkF94z9ZZMz6gtUMY8z3u+3oqpEx0VbkxjnidB1VW2f4WMk0uXzs5u
         hRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712658748; x=1713263548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6wiRCdd89h1sVMfB48/ixg+/YiJUwbUXTRR0BuEf6E=;
        b=qiMGLxPpMlkONtRSPVQkl87IcMarMd3kXCWDSOb989kD8SFzkPeNZUNvzvHcDjjQh1
         4/NklkRC23aE0Wcz79HDf0wxozeQz1N4zogd2hwt5gyqzh44Xxu0t2B2+hS01omlY1l+
         gzQ0j/tDpJkbDRP0cAyWQRYqiuBDaWJlCu8hXvJD04CVXtceOsL8qrf+Mxy5je54krVZ
         GUXtTmox8or2wAWHUsm+96RUc28xf+msSKSLOMERZxXSjvGQEuuvw2hrlDLJdFeja92u
         ISAi+3QvqgmSb64c+zjjCnATxf6bkhg76OTq3Cts9yNdTkztIXYazncZ74pSfT6dXe0u
         vk5w==
X-Forwarded-Encrypted: i=1; AJvYcCUOUNyPEp8ftr8z4jvtA7NNoahihHA+FvwlFPnzA4AlKvH/ShaFg+9x9Q1UelmZ+vO4m0R2bIxlKUBZ1P9ld20EUOLbAEzMNyTePogW
X-Gm-Message-State: AOJu0YwySryS3bwlZktmkMrq4u3OCH9wQDJ/RyQHMfFzP9HvKMJREkvZ
	a0+OqwtV1UCRZQmRLomY3GYpVZGMIrs3dmoBTnpwhpwyVuRP/oLpFQqVrxZbkDDkM2ljXjbVwRB
	7
X-Google-Smtp-Source: AGHT+IFEn7fzGVX4ENx7itTb1ycHDldkvgWUd8eaiNCRvLKK78VmQRDlwjkEc3HvZiTxCd71tp4LJA==
X-Received: by 2002:a05:6358:d3a7:b0:186:5f1:3827 with SMTP id mp39-20020a056358d3a700b0018605f13827mr11380787rwb.18.1712658748170;
        Tue, 09 Apr 2024 03:32:28 -0700 (PDT)
Received: from localhost ([122.172.85.136])
        by smtp.gmail.com with ESMTPSA id e1-20020a630f01000000b005f072084432sm7878536pgl.38.2024.04.09.03.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:32:27 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Vladimir Lypak <vladimir.lypak@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Fix required_opp_tables for multiple genpds using same table
Date: Tue,  9 Apr 2024 16:02:19 +0530
Message-Id: <c274500b623b83c00c0460383cbe1cdc7490eeac.1712658693.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The required_opp_tables parsing is not perfect, as the OPP core does the
parsing solely based on the DT node pointers.

The core sets the required_opp_tables entry to the first OPP table in
the "opp_tables" list, that matches with the node pointer.

If the target DT OPP table is used by multiple devices and they all
create separate instances of 'struct opp_table' from it, then it is
possible that the required_opp_tables entry may be set to the incorrect
sibling device.

Unfortunately, there is no clear way to initialize the right values
during the initial parsing and we need to do this at a later point of
time.

Cross check the OPP table again while the genpds are attached and fix
them if required.

Also add a new API for the genpd core to fetch the device pointer for
the genpd.

Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218682
Reported-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Co-developed-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Vladimir Lypak,

Can you please give this a try and confirm that it fixes the issue.

 drivers/opp/core.c        | 31 ++++++++++++++++++++++++++++++-
 drivers/pmdomain/core.c   | 10 ++++++++++
 include/linux/pm_domain.h |  6 ++++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e233734b7220..1f64b703b744 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2394,7 +2394,8 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			const char * const *names, struct device ***virt_devs)
 {
-	struct device *virt_dev;
+	struct device *virt_dev, *gdev;
+	struct opp_table *genpd_table;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
@@ -2427,6 +2428,34 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			goto err;
 		}
 
+		/*
+		 * The required_opp_tables parsing is not perfect, as the OPP
+		 * core does the parsing solely based on the DT node pointers.
+		 * The core sets the required_opp_tables entry to the first OPP
+		 * table in the "opp_tables" list, that matches with the node
+		 * pointer.
+		 *
+		 * If the target DT OPP table is used by multiple devices and
+		 * they all create separate instances of 'struct opp_table' from
+		 * it, then it is possible that the required_opp_tables entry
+		 * may be set to the incorrect sibling device.
+		 *
+		 * Cross check it again and fix if required.
+		 */
+		gdev = dev_to_genpd_dev(virt_dev);
+		if (!IS_ERR(gdev))
+			return PTR_ERR(gdev);
+
+		genpd_table = _find_opp_table(gdev);
+		if (!IS_ERR(genpd_table)) {
+			if (genpd_table != opp_table->required_opp_tables[index]) {
+				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
+				opp_table->required_opp_tables[index] = genpd_table;
+			} else {
+				dev_pm_opp_put_opp_table(genpd_table);
+			}
+		}
+
 		/*
 		 * Add the virtual genpd device as a user of the OPP table, so
 		 * we can call dev_pm_opp_set_opp() on it directly.
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 4215ffd9b11c..c40eda92a85a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -184,6 +184,16 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
+struct device *dev_to_genpd_dev(struct device *dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+
+	if (IS_ERR(genpd))
+		return ERR_CAST(genpd);
+
+	return &genpd->dev;
+}
+
 static int genpd_stop_dev(const struct generic_pm_domain *genpd,
 			  struct device *dev)
 {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 772d3280d35f..f24546a3d3db 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,6 +260,7 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
+struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -307,6 +308,11 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
+static inline struct device *dev_to_genpd_dev(struct device *dev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.31.1.272.g89b43f80a514


