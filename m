Return-Path: <linux-kernel+bounces-109336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2668817C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB4F1C21C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3D8563B;
	Wed, 20 Mar 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hANtYHem"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FEC6AFAE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962369; cv=none; b=m68zOuGtA8yRQdPmHQIB6D+nI1RkpsS0/VWWtuQdo4kaKYhIbPgBQeJzOjfgWj+iBh/7QW217JnIkrf5C/0jRXl8W2Mj2VcPdEagBeZpkuxImAEC4UHpw/y1bk3EhRtz2w1aCfIymp4/LZNylNrut8YoX3hFgcTlQpNqoiXzcOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962369; c=relaxed/simple;
	bh=QoHfLb2g+qiJ0TmFaeUofXdDKDug3TX0m3qwW2VjAaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G+OgsyKekhgcdTFQwccXzm6oVs56TbLJHfmBl5onlurMBIJnqlZ/ENPp+qQy9Sq95bw5fxmWTXnRpeoEX4K928AlWJH0yoBngRQU0vYhqdore0/e3vSNmxKeeaShKlQFZIXkkY9bKqGT3wtit8i/MwYC2cStIpEhR471iLFUWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hANtYHem; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so156443a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710962367; x=1711567167; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wtBgrCuQv/Ty6F3/cQmfzGOsSNGCIllNxgP/B6BFoUc=;
        b=hANtYHemvoCg4fU6K+z8fqkd5vhul+B7hFtrxBkTXnn3v5/5DHdaLGNDrJKn4ltryP
         /CGFc8zFOhg68phxNhjC7LIA2X2hZiFIWBIYlsXf4JfK24oaGeQtCyM0SEbrfQoBxXa7
         Wt+lR88/dpVZEmOobSMigTisQFDUZi2bQtGimDJSCvcRa2fGZPI4QpkOFOnCTyiOahuW
         vLo5iTwzPRvbrqgAlwSe1DlLXxc9OqrBEUK/8YhiYKAYlfP8GpOhOWAbDU8T2g5pjAYl
         SurkyFKqxvZe/5nYKGqcg1ZXVKWD06eZCPTosj1FMjmxXkLopKLkdNtTRM6J5URboLea
         VQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710962367; x=1711567167;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtBgrCuQv/Ty6F3/cQmfzGOsSNGCIllNxgP/B6BFoUc=;
        b=VIfO9KX/fj2VOFmKoHH2eFxRuk1WpAzfyrpQJ9nuVk52wHxyUwtkYN3ZwxMQqldxPJ
         NEKFKer+axQAT2EHLWdExm9HWGXNL2Wj8tBxL5NF593App/0Q5AocNg5wS72gQWL0S1F
         UcUtVVHo/7AL5csAjhvuUZZKiShJHZtK5Rqu1dWhfoP3rFyUKti9/t2+PcLcwCQ9KLNb
         KE8ROZ+Fe5skZ+CHY9j72VHIZpZeDHDsvaaFM4TUkQR2RnsG+xBy8sDrFk2h7Ahz3VdC
         FNBqeFUBVDuLX6b/S7p3maGr+Up4/oWI1M3VlTr2JnhxquD+k5CZLQAhG8aIg4BxJfWt
         MbeA==
X-Forwarded-Encrypted: i=1; AJvYcCUr7WvXI/hqm7qdawl3RVMgeDARg8AXNOtmLJHzijfNhX28UuDQgrTbp43vbhGH7fEOniTlMn6ldFhDG4VURzePpiV6W2Np/QgW4GUS
X-Gm-Message-State: AOJu0Yy8qG1JMSohF7ZR7qJrzoHvCt8dVs8HiGKII1c9YdBPxa4dMySG
	/x0STgYDpvhFE4gZeYab9o8qTgrUffecBIVcesKm1sEhHlJU0Hbe
X-Google-Smtp-Source: AGHT+IE565uzCAYJTWR4ZSLFMmQDfp9qI6zF41cgTJrfxadF+tqY8xfSl6p/rjzV0MaQIdOxx5gK4A==
X-Received: by 2002:a05:6a20:c220:b0:1a3:6c63:8f9e with SMTP id bt32-20020a056a20c22000b001a36c638f9emr6084699pzb.27.1710962367018;
        Wed, 20 Mar 2024 12:19:27 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm4325036pfb.122.2024.03.20.12.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 12:19:26 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:49:23 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Fix line length exceeding 100 columns
Message-ID: <Zfs2u95QOKHAiR1B@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Split the argument list of the kthread_run function call across two
lines to address the checkpatch warning "line length exceeds 100
columns".

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 7554613fe7e1..1b11f8b04e13 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -221,7 +221,8 @@ struct net_device *r8712_init_netdev(void)
 
 static u32 start_drv_threads(struct _adapter *padapter)
 {
-	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);
+	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
+					   padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
-- 
2.40.1


