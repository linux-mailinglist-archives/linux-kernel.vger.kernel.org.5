Return-Path: <linux-kernel+bounces-145529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40838A576F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737931F238DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4327A82484;
	Mon, 15 Apr 2024 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWK2Oe45"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAEC811F8;
	Mon, 15 Apr 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713197660; cv=none; b=dTpoMBxSzIrcoJqNYRVFpuVnR4Ai1qaqR9HxVl5HoEzRF+bE9w5R/U4Y0Q3SXuWUwQcS45lwJARQ8wlNu0UtqnQSMTnYRFu3efVg8se11hsSnLZnCd+XkKCs75WIJ0i860hmUW+lR79e8AYoNKuk+PoDTPYtSeM+rLRAaPY2gtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713197660; c=relaxed/simple;
	bh=/ootUrK3FISZzlHY5cdyAk5UWo80W6lQ6cS8eI1Rc1c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iBaTmoj1jv7wFEgt/GRmxf1Zp4Mw0gbYNf6JMJEjw/B8/2KNBnc3vmEtgw6BLW+aExQCeprZCOqzjFe712e3hFl5FHluHoiPezS9ewnW4tHI6NbC+kxIT0LxvE0qGxsj0nAWGaEIYkATocQAg3ZnimpvboGFEnf81rwdukuPFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWK2Oe45; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3ca4fe4cfso21135925ad.2;
        Mon, 15 Apr 2024 09:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713197658; x=1713802458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+yP6zPxyPYg1tSQ7cI6u1fk4xG8ndbSRH117EG8ojI=;
        b=NWK2Oe45aGtzj/+/P9MkhPNS6FZetmRm7pOOjTt+Hl7osHjjXMszYAPjFZ60ttuOHG
         Fqq4RPI0CUe9I7ciWOiWt1oTf7xu/CHDY4HKWIatbprTAg4AHFfKgAb00lbsI06pCX0T
         my+VkrdUkU59lmhGDuxfyPW2/I+MWsIzf7sIcuMpiB1FBo+H0+dq/FptQ3TRoi5l2kdZ
         EF0M0n5kOihJCO6vqYFKb7iOPPfkzAklYrCWGI5Zg3HtZ+uwDbiPhSsU8DchZdUTeXnw
         Ghh0stECG9PJGG/ZL7nk/Xa8/brDVypvuD/rT12OPxbtZs5cPLd5xAcBB8qQjPaXOH1i
         11ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713197658; x=1713802458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+yP6zPxyPYg1tSQ7cI6u1fk4xG8ndbSRH117EG8ojI=;
        b=TPs22WifQ2XVHQknWaxbXSmjDylPGGxU8gantKqVtJvdSTgqPYhXj0s6OKSkWyFv/q
         hUFsH0wNQugClfZmWhBjf43Vt6e8sPfk5ZNjyTL5/8mP6DVxUfYjTN/AEPYjMMjwSlDK
         soZIugg4+CYvp/4LRJWOhDXQNpkQoiUCTDMoEjM4NbOqed1Nbw72+wdUUpm1RfCOY2e9
         mQzUsAVfzKxu854A57YuTnkkBuIxznRKDpY7tDB64LphzcB5Sb0KqXTl1DgdCx+44ouJ
         +SBJs4Ot+YcP3g7hfuMvzrm20LeFEKGngdSiBoCNZvertmNLnNwZ2JGY/8bVF/KsAkPc
         poeg==
X-Forwarded-Encrypted: i=1; AJvYcCUak/mlDhISt+f6rd0QJr4TdAFdh7G8PLp8HTyVcBB2mLMfHVbrQ0aVOv4XKdS5sHn8eGBK6v8Wqh5cVT3Rfu9nIgphXh6OWRXgXmICsXgiyYZYlrOB/Ks1cH/7sc1bDmCHkYv7jqCZZGso44w6
X-Gm-Message-State: AOJu0Yx+n5pBB7pkZzT2sHC+6ycg8tf87/ZphkootI435lhQpDUca/zI
	ehihaTgJ2/8+MtE9FIIpqVKCCnWbhIiClCRL8oZMcdkQoPIVk9SE
X-Google-Smtp-Source: AGHT+IFvb2zxtTh0r5yK4c7ctMgmX0LTXNnnxkj5eirzpA3VrIkdKLJmugyMB2FbcKh8F9G+aHtJPw==
X-Received: by 2002:a17:902:ce0e:b0:1e2:d4da:6c72 with SMTP id k14-20020a170902ce0e00b001e2d4da6c72mr15237696plg.0.1713197658542;
        Mon, 15 Apr 2024 09:14:18 -0700 (PDT)
Received: from dev0.. ([49.43.161.106])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902784200b001e797d4b8acsm1358664pln.174.2024.04.15.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:14:18 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	Abhinav Jain <jain.abhinav177@gmail.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] pstore/ram: Replace of_node_put with __free() for automatic cleanup
Date: Mon, 15 Apr 2024 16:14:09 +0000
Message-Id: <20240415161409.8375-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __free(device_node) to the parent_node struct declaration.
Move declaration to initialization for ensuring scope sanity.
Remove of_node_put from parent_node struct.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 fs/pstore/ram.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index b1a455f42e93..14f2f4864e48 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -644,7 +644,6 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 			    struct ramoops_platform_data *pdata)
 {
 	struct device_node *of_node = pdev->dev.of_node;
-	struct device_node *parent_node;
 	struct resource *res;
 	u32 value;
 	int ret;
@@ -704,14 +703,13 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 	 * we're not a child of "reserved-memory" and mimicking the
 	 * expected behavior.
 	 */
-	parent_node = of_get_parent(of_node);
+	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
 	if (!of_node_name_eq(parent_node, "reserved-memory") &&
 	    !pdata->console_size && !pdata->ftrace_size &&
 	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
 		pdata->console_size = pdata->record_size;
 		pdata->pmsg_size = pdata->record_size;
 	}
-	of_node_put(parent_node);
 
 	return 0;
 }
-- 
2.34.1


