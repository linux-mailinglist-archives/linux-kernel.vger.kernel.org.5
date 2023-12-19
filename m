Return-Path: <linux-kernel+bounces-4994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ECD8184F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A621F24E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B60014265;
	Tue, 19 Dec 2023 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdNQYv38"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE5E1426B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e34a72660so2899466e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702980143; x=1703584943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=bdNQYv38mRfK4iCTNmU55oIGvRLPtVPgbrdtFQj1YDWX2bl0DBQuk2I1FDxrgWyzLQ
         UPUds96MyOGz2mivRKI9x27qOgSg/ObxZyEvHm73s3E4iLbAK+rJL1cF7jj42RroDom8
         gfblqRtPtBR+FFKl3EcVcaDk59MAqse8dpU0xBJQZFmI0em4QK4MQ5W3+WHRWtigcWkh
         yJ1Jy1shgztXZyIq66vdhhJJxKOsGMO713rNhmlUnG/PmC6K8QfgvFofngQy2i/lJYr2
         GsfTeYhMu75kBq7ikbO9ZJEG4O0mbCGQbYGQWbKxuk/eOAoe4sHcq1ISgTJ7P2kh9e7i
         o5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980143; x=1703584943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDfnExpJZu5lDtrGL4NOnG533YvholurjpF0JSG0JHA=;
        b=xAnhSZJ5rAlCzAy+2HO5ES2WMSyovn8+ENDje2ewpYuueLy4G5aX7Ny2qW5kPQZlo/
         w3rhov1xfiiWzcNeIIt1zT4NeAAxRVugu33PI6sVPxWfXx2d6vcYfncNc3JaNp+XQw+E
         aVhfItoY5TrY8/+65uj8uK1QiIWSbbS8632WMdcGCO9QaK2YBuGEZFvwcE9INdioL1w2
         gQ6dMZeeyRcDcb63VmfbACtOH7XyyA5HTw/UCc8/tvNZ3TlEy+cerpThpfoOcy0w34n5
         8o5FYb5kJaudascEA4iGk3IT/l9JEQjdXUJQQSlaltR7GIU9rCtmRQTEdDzqJrb0ohq+
         Dx8A==
X-Gm-Message-State: AOJu0YwcGdlxJ//wB+vR03oODmZBFTUkOtvtfteCf5UktoMdMi9ACkOU
	jCRigArI20Uf4GW4BVk+BfA=
X-Google-Smtp-Source: AGHT+IGGyi36JojkdScUn6fM9cojSilK3uIeYR37ylgaQGGepsG17xKE2lLl8KGvgmI8cf12vBdpMA==
X-Received: by 2002:ac2:5e35:0:b0:50e:35e5:f22a with SMTP id o21-20020ac25e35000000b0050e35e5f22amr1537214lfg.16.1702980143419;
        Tue, 19 Dec 2023 02:02:23 -0800 (PST)
Received: from alsp.netis.cc ([2a02:2168:8a0b:bd00:ec0a:381e:719d:789d])
        by smtp.googlemail.com with ESMTPSA id s11-20020a056512214b00b0050e4bf426desm42161lfr.246.2023.12.19.02.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:02:23 -0800 (PST)
From: Alexander Sapozhnikov <alsp705@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	ToWill Deacon <will@kernel.org>
Cc: Alexander Sapozhnikov <alsp705@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iommu: amd: NULL value may be dereferenced
Date: Tue, 19 Dec 2023 13:02:19 +0300
Message-Id: <20231219100219.17332-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer 'dom' which was dereferenced at iommu.c:1993 
is compared to NULL value at iommu.c:1998.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexander Sapozhnikov <alsp705@gmail.com>
---
 drivers/iommu/amd/iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a0924144bac8..64a88e67be9c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1985,6 +1985,9 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 
+	if (!dom)
+		return;
+
 	domain = to_pdomain(dom);
 
 	if (domain->dev_cnt > 0)
-- 
2.40.1


