Return-Path: <linux-kernel+bounces-118578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4251888BCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43051F3B77E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00045182B9;
	Tue, 26 Mar 2024 08:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5/DJVz7"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D3779D3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443103; cv=none; b=QfjDl44sAEXMqmbW3sk/UUsGlW+apy4avz5T2WWFtjdVQqZXjx4tcfc2Ws4NxY5W1G5VEo8ViesKgj8zlumtlt+8Gp79qsmN8HWbESzgXW55nn5On2Wb43Emt6m2nituQ+8k0SUSUuMhR5C3tzF+FWC5CRhtqT84Ur5PmsfxQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443103; c=relaxed/simple;
	bh=TAyIPDmi1GrLGPqsrMnh3L5g+mcIopQcCnigvu0gFv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmKxlqqquhgoEdSMhakNHW4HGs6Zy+ecctWeiYAKJIV9gV4JHh2sIukYFnFjHa70eh/uGASpC0EiLQDzqHXtZSQZqjuVH/WOdogX6v8yN3oTInoMmiY/6idWj0+YYHbUT+wmtG/f29ndH8argu0c0MuaBjk2pPV8WM+VTe+KMIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y5/DJVz7; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c3d70191c7so449466b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711443100; x=1712047900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uFHWqNrwlUXAKVj4cLzNrqDv+IX5Brk/fK4JneaZOM=;
        b=y5/DJVz7KYXtk/csC3egJkGGt/eYXVuItDs1Qg3vViAID/x/je4ayMbObFARGPwn/4
         9FDDWgTYCEfwpVV8fqxbgLaijtb3vaE2NeN+FIaiSAiaIDySLy+o4Vs8bbt2RqowjPlV
         eZyiOhONlgORnAJzZU15fLZUtK24k165ANJKe3ECe8Lm6WTpnCaQs0C9VIfiSCm9pq4o
         CBIdj753wJIWeeQpYwUG++UMq84hk7D4x6dDRliah2IekBPS3BIBbXS+wVMQHbDVJHH1
         dNwWlWYrMtf5cqbPkGprIK9Y6w1cs+A/MVcJeL5ZRrguRSzGVP7XoJZkD4Z6M73/kzhg
         BnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443100; x=1712047900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uFHWqNrwlUXAKVj4cLzNrqDv+IX5Brk/fK4JneaZOM=;
        b=cgs4Sa78jH7lsTsTZnxqUcakjmfeZZm5xy5CFbfcujvJZLKVjYPki5v5bJlDt6ojIl
         QVP2OiWCpz5v2dAjc4GJEOy3oegcVntUcH8ynlpee4hS5BAgywUe8u3ysb0j7IE7VYfi
         itVaBsu7BvBkr3Bda9skwlcx8rkkpy8ZZu3je01l++WfHg9OVluWoKl3hl5p3FfG8JXE
         zLaMfOm3dakB7dkMQqTSBQIEUy3JRgR0+YMm/8H8OVLyuydety5KTxzga4NjjZyCPA8K
         JjOjLVD7Uu6QCbjwO0TEoe3Q7e3V2UoKGJsIV4rWa/Y7QSKDwKQGEnPQA+oZH28bG0iX
         sshw==
X-Forwarded-Encrypted: i=1; AJvYcCVE0dK7n4MqVSI4XEzb5PtQ8SKUJM8WTpYpIQpcKnOsdMkIRzvyeRXAm7M/KkkKCQ35NzQssplWJ7AIfxOCnJ387RK04XPlkRgW5Dj2
X-Gm-Message-State: AOJu0YxWqtevI9is+IDx7TuokUJMafa1zt4EHnwidnEilNcRNHCuj5xV
	GZto/47A4Au7c6LlXVmSzdPIskgRQoHQAJdw0eQA1bTlPt8Zgsyc6yMypn7XWw==
X-Google-Smtp-Source: AGHT+IFK6SwO2b3gQYpYOf8ZNDIOIbNJ/5w8Tdag6QREMUYwrwIp+4bbx4vSeMu2hitif60bq6e0VA==
X-Received: by 2002:a05:6808:19a7:b0:3c3:a000:50e3 with SMTP id bj39-20020a05680819a700b003c3a00050e3mr2576011oib.37.1711443100004;
        Tue, 26 Mar 2024 01:51:40 -0700 (PDT)
Received: from localhost.localdomain ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id t128-20020a628186000000b006e04ca18c2bsm5679913pfd.196.2024.03.26.01.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 01:51:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: kw@linux.com,
	robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Drop Gustavo Pimentel as PCI DWC Maintainer
Date: Tue, 26 Mar 2024 14:21:30 +0530
Message-Id: <20240326085130.12487-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gustavo Pimentel seems to have left Synopsys, so his email is bouncing.
And there is no indication from him expressing willingless to
continue contributing to the driver.

So let's drop him from the MAINTAINERS entry.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9038abd8411e..94cfebf41905 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16965,7 +16965,6 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
 
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
-M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
-- 
2.25.1


