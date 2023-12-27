Return-Path: <linux-kernel+bounces-12090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6681EFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DB41C21365
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5874597B;
	Wed, 27 Dec 2023 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqblgxye"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF14596E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9aef87d44so604132b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703692131; x=1704296931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pjCjvopsMmkUpLDLIhAy1zw+uPNcbrvoa5/5u1pFsD0=;
        b=PqblgxyewS86DD9R5rwWIMusuN39cZa/18wGHMPSYto3WfK9O6UCVR/JvDt73VrX+b
         WrvLsmhTnhmPYRjKalXSMSubT7l4Rk/XuXXgUOBwWj9VgbTeNzj+bWpN7jy87wQddyUI
         kPpLiX6+glQLdYzv1AEntRUwbHHHxjdjRoDFCkLMT4J5e0caUMPWDwfphLl33vgJuv/l
         61ucLJLvUDlcaiImd6p0hVcL9Sj4H0gs/Mc/RrwGX25ayrMVcZ0gZWzHQzJzrYiiQPdy
         HKi2ZsKFtYIo/C/dqwYDHbm5XXykeKJ367tyb575Q2cuTDl7N2B4zurAla4i4QOIbGlu
         PPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703692131; x=1704296931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjCjvopsMmkUpLDLIhAy1zw+uPNcbrvoa5/5u1pFsD0=;
        b=uSujarCjtDiiOgEZMDDFJi/F93tVZbcWOBoFAYI/MUx+LIkesFvgzRYqHuo5AhxKLu
         o7++EAr1vTgvDzep5VK5TIqm4m8gUY2ZKEd1foYKxKiPTdC/WRonAj37DKsHqvsob9XA
         /lrOVi20afpz0GMB7jptsPsJ0tOfQiwZGiZ4H6lrx6Z+Nq2ztoB1aEPFhedchEBJxKES
         iIpFl0UdnoO7c9mqPCh/LytRRZmrc/YMbKUJfu2tyuffag/VJssORInTiVe5a85sYTu2
         RHCIpYagfiMefcuZWPq+uCQdnDqNioDYiCmDLJ9yAD87ioaLr7aSfpnR0TC+uLyR58gt
         /y2Q==
X-Gm-Message-State: AOJu0YzfiQYq79TIZeEIlkEFV3Q8o7GSiPbzA80v8sMA/I18G625S0WT
	cgHOWE5ED6UxaMHXL12vwU0U81AlvGnosQ==
X-Google-Smtp-Source: AGHT+IErIuK7z+cNQhfvbCTyhrFnvWXpLG430En0nbHissSAMSNx0J/ZQ/N8h0a8jX89+AR+RBLc0w==
X-Received: by 2002:a17:902:dac5:b0:1d3:fb6e:f39b with SMTP id q5-20020a170902dac500b001d3fb6ef39bmr4494741plx.51.1703692131237;
        Wed, 27 Dec 2023 07:48:51 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902fe8300b001d408c45e19sm11725922plm.109.2023.12.27.07.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 07:48:50 -0800 (PST)
From: Piro Yang <piroyangg@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Piro Yang <piroyangg@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vme_user: print more detailed infomation when an error occurs
Date: Wed, 27 Dec 2023 23:47:39 +0800
Message-Id: <20231227154739.6951-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when the slave_get function pointer belongs to the struct vme_bridge
member is NULL, it prompts that the detailed function name
"vme_slave_set" equivalent to __func__ not supported.

it is similar to the vme_slave_get function:
when vme_bridge->slave_set function pointer is NULL to print detailed
function name by using __func__.

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 9bc2d35405af..e9461a7a7ab8 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -340,7 +340,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_set) {
-		dev_err(bridge->parent, "Function not supported\n");
+		dev_err(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.25.1


