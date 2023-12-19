Return-Path: <linux-kernel+bounces-5540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E553A818BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737FD1F25697
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F41F939;
	Tue, 19 Dec 2023 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeECeUvV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4611DDEE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ab37d0d1so14806965ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703002449; x=1703607249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kdL75RZ+5hKYU79DC1Z95eLZT4SnTmp8NGTefIW9pcE=;
        b=SeECeUvVA274L8BsLGQIb2NN0X0X7S1wt2geB4hekY9Mrr5hykrSnwt+QkSUha0AdP
         87+Cw98y01g4frCpulcNNUX9HAh670cofjVo+VumaoBNBKsX7nGETd/L5auO+b55H9En
         ZgZZnHV90h6PD6mxsOP2OCSQdu7urKiwpegVgJ6J7x5Nj8ZDCKrYCM+YU9wAK2evgO2B
         sYBQStbImnj3KJKdtbPCVXNIu8ZpSY5yDZQGmP2ORnigQlOSbq1diiqoqhgIffEQxRMJ
         Ebs9WNZNQuDHYm9MYGOq3YNnX4ihX2B2Vc8fa+FVdCZ0ib/i4arkKcBZ7n8CN40WyBG4
         ZJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002449; x=1703607249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdL75RZ+5hKYU79DC1Z95eLZT4SnTmp8NGTefIW9pcE=;
        b=HGzDw9KcDCiawDZyf/UUY2G6vPkk3Nth5shLnJ6AEAJ8bOqNdgacqRyyFkpCgB2GlG
         7+LPV9AT3Nba/FKyL325LvWXHktDfxojiZm+c8U7yC/s35MnwHvHmy0255C0b3sskaWa
         0oQ5vlufwlGoOADXZgc6Cnwi8ILfmBiupZBp8rmriA5A4xAN44AcscNFgJ+8bUDzW8xE
         w+9ejhlbU1kt0lgA9gaNMG76TY0Gnwm+WXVL8yt4ptYxEIfEJNZvD9CFJ5eTO83j2+dz
         yvCKW5ezASXqzFa2GCsO0fzm4W2Ikl5Q5owZPuRGQLRdu1alfdNSESRqwkBW4eZ753I/
         fkXQ==
X-Gm-Message-State: AOJu0YxRFUMF1+uo/WOFGH4i04NEiOCy577PTqnyoy0YzcHazUHKVzmU
	pY1wFOACbsUJZO/jf2BCSMbwttaco4ht6rrJ
X-Google-Smtp-Source: AGHT+IFIxa5c5QlB4jj19PCj9xVWdx+ESK81oNfGXCP9AEmKKNNhniCCf2yDQIsPhY4SAb+aHkH2uQ==
X-Received: by 2002:a17:902:b708:b0:1d0:76c2:e352 with SMTP id d8-20020a170902b70800b001d076c2e352mr9336265pls.94.1703002448858;
        Tue, 19 Dec 2023 08:14:08 -0800 (PST)
Received: from yqt-VirtualBox ([223.166.246.87])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090322d000b001d09c5424d4sm21161036plg.297.2023.12.19.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:14:08 -0800 (PST)
From: Piro Yang <piroyangg@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Piro Yang <piroyangg@gmail.com>,
	linux-staging@lists.linux.dev,
	Linux Outreachy <outreachy@lists.linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 RESEND] staging:vme_user:Fix the issue of return the wrong error code
Date: Wed, 20 Dec 2023 00:14:02 +0800
Message-Id: <20231219161402.50510-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed the issue of returning the -ENOSYS error code when an 
error occurs.

The error code of -ENOSYS indicates Invalid system call number,
but there is not system call error. So replace -ENOSYS error code 
by using -EINVAL error code to return.

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 v3: change the description and format for the patch.

 v2: split two different changes,
     only fix the issue of wrong error code.
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5c416c31ec57..9bc2d35405af 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 
 	if (!bridge->slave_set) {
 		dev_err(bridge->parent, "Function not supported\n");
-		return -ENOSYS;
+		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
-- 
2.25.1


