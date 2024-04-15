Return-Path: <linux-kernel+bounces-144902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0378A4C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DA02812C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78C4E1C6;
	Mon, 15 Apr 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs/wGaEu"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36547F50;
	Mon, 15 Apr 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176373; cv=none; b=nuuO3sT1iX/jTyR8QmaK/bV4fojCLkZKZc6DFj5XgYaAe3+rk8DWrNd82WCEHYlGy6clc8GO1P0IOkvMzu2c3VzwpnbqUQ37/R0vTi67+wXAUNXaHBWxuOdAjG9Ot+ZDCVyP0I0itOVimucTtQOilrd9C08+FQyQfuuIKeYvUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176373; c=relaxed/simple;
	bh=z0lUnRnJ20hdiXpMZRnobdIYEG92hyGdtmMXMY7UjPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EDrYc+fkkwB6pGCDkFYItfrSUFdG1evTSkfVtphFFlJpZutK0S4DaPODf5MWccViBqMQSzgA5Jfw0dhzpSZY6FN4twiAYYdh64HZZdIpTIB3U0nk/IUlTZDuXvrCnHXD94LD60tG0+hbumfoWUwaaH4CGbqwwOhLqXEPBkU7FSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qs/wGaEu; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso1999443f8f.1;
        Mon, 15 Apr 2024 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713176370; x=1713781170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KG194EJK11CX6gvo6DvtRQREQM8gMc9FVpOEjalH2pw=;
        b=Qs/wGaEuIB1XWtOqZMZzkPrnRGJNvNmKS/80vmeKDgZR03FgB8r8myNiHO9jW/gHrR
         2DV3ieoJoN99SWU2Ej4yPfIFxrsVrLIsSb4mJrM2TD6sd5EKUQ0PgtThTRNM5bhFeZmg
         9pPSZxzXnDn696KFondO7kCoL1iFRQsPu6QW2/UniAFES6ptIMMe88iVCnLD/fw+GeHk
         eswRI0ghAbD/YHnQtnZf+eJtDOQNjEiLwh3RhNRO2C5PZ7R2PWuez6rr9JzFWoZbKRPp
         WTe2xVwwYUT/K1hM2zlv3vSd+mnSbab+uDcoxFUkEYnDutO8+zXinr3i0XXeDm5MuwR9
         2VQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713176370; x=1713781170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG194EJK11CX6gvo6DvtRQREQM8gMc9FVpOEjalH2pw=;
        b=hRWNCqbRaZ8MSDBXTl0wLsfnRh+ch+2bO0JFC5VlX8Tuyviz/D4eORQDxdNkUwEBnl
         E4uu/Wgy5R7/Qz4ZnnDwZPIQUGWVpzc4TtaYqR0SNHx+B0xGoxyeAuE0jOFysjC719le
         LKe7QvSnLtzMB1gBGZarKgd4iMX7yb4ME7Cu9tmL45MjFt4JLf6jOpVmgcBDD4ATjAy0
         WM1mqYNWX8QSxqgX5n0ngeB8Hf/SFkWwuWcx53smQHSI4he5qxGgfeN9YQOZrZZujiD0
         BJWsean75Sp0Ouvm//Eu1dXVX1pGYR8l7E91RzxsZamHGnOO/djiUIzQg4FB5S1RhHJn
         lA9g==
X-Forwarded-Encrypted: i=1; AJvYcCXPnURcwam3xRBA8XQBID/Cwagp9dQ6delOL7L1XpG95CMLecgADk9X9gLTxSbuLowDY8mnK28J3NwVLKnKFhAiD5X6dblNJCLIvOA5ZQu3ks6mnZ8AYXtvYFSJlO62YLiWr/Vmg/Cw
X-Gm-Message-State: AOJu0YzaIGvcVkLVTK4FwLVGo1XXX+S/o572i4IjYw5LLoBId2xKifSB
	PXTfjJBegkYptKCMgaXFCF1uFEdor/HrADBFeEFyFdmtSmr5FvIY
X-Google-Smtp-Source: AGHT+IHVtzOXafYbDUSuB8izRSCQlP6f8luo9hqQkPhmgEpooak5Fh6B4tfYcWAFBqOPTX+Ekapr/w==
X-Received: by 2002:adf:e80b:0:b0:345:f96e:39b4 with SMTP id o11-20020adfe80b000000b00345f96e39b4mr5327672wrm.8.1713176369944;
        Mon, 15 Apr 2024 03:19:29 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6281000000b003445bb2362esm11629201wru.65.2024.04.15.03.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:19:29 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] dax: remove redundant assignment to variable rc
Date: Mon, 15 Apr 2024 11:19:28 +0100
Message-Id: <20240415101928.484143-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable rc is being assigned an value and then is being re-assigned
a new value in the next statement. The assignment is redundant and can
be removed.

Cleans up clang scan build warning:
drivers/dax/bus.c:1207:2: warning: Value stored to 'rc' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/dax/bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 797e1ebff299..f758afbf8f09 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1204,7 +1204,6 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	if (rc)
 		return rc;
 
-	rc = -ENXIO;
 	rc = down_write_killable(&dax_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.39.2


