Return-Path: <linux-kernel+bounces-106532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99287EFF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AB06283073
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2349E5577A;
	Mon, 18 Mar 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h91g4/lF"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1782E381C8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787900; cv=none; b=BQpSRKyqausJy0iI2rUZTVBd9pRhcdrwoBJgE8VnCF3sbTSes635BYDtq6mWo7rdmOquzH1vLtWb4qEKVYgfaJMQPAhSZlZ+9Z6cw2T7O2UQoO5UuU7dAIcO/NZ0OqQFlzMY18Dbe6x4dVjExw0D/XZ0PgXVaQ53qCT+QbtbW4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787900; c=relaxed/simple;
	bh=ahQLJbLApCM8ufyy92oRhxd+4qzy4sps8/Rvg6hzEmo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FyZJPQYIRV+I2rcVWpHR7jK2R3JxbgAI/BTTsAJaCQXTBONwHOGJrYjD2jTXFulgiUM7MEhcPreTc6BIWl8QS3+9Nu1fPMgphWrzDcjpTRadeGffOFJTZA7JaMvnrZK/FthhTgD80om6/EBhSA977/MWRWwpI0Dh3Osd/Lz/km4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h91g4/lF; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e69a77f41dso360259a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 11:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710787898; x=1711392698; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W4S6X4A8DTBN48FZBm9DivzJsFjgIU/rIF1zK+bYOx4=;
        b=h91g4/lFDcH+/yHo9/D6nLTJBoGVFQbpsoHZ8DmwX4DjKrlQ9+l7rjz6/c2/vH/iyO
         bphBFOfBbtiIzneAxg1Qi6YnQwPCAojsfMZDyn+XfqCJBbf86bRGYKF1FkDInpIHl6RQ
         dJqkETe9yBE7N6yCR64nnwHxTcANhzsrEohTjbymc9tgtStHhKV8K3SE+2crE2QTKdWv
         qCMjaCHrFOfUmp23dE1Jn6BhAEYZE4Fy5r9UAQLaknsGhc+tOL8HPhAr3sXAnuoFplbp
         XBdiAFLd0WtVSBRqTIiVZzRUzkh/71Q/h13XsTjdETdgcgMprsjUeH2PDuPdQZOMdPGk
         2xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787898; x=1711392698;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4S6X4A8DTBN48FZBm9DivzJsFjgIU/rIF1zK+bYOx4=;
        b=ncQePMCvxXuaxihfGPdKL3fqHLM8QDaE8gcFLfqo2C4zvqanQQbci2PDc/e20l3/Vl
         ZW9p0QwcBxwY7SDMmG4t0eYBj8paqjbuB2GTKp/VrPTBgFSGVaYiYiBZkN9BLgFYp4mi
         Pg1mMQzX39BIWfAO2GhqWSbZINl1TvPBjwiRq//Szi+kEQ1xmjv05KIrT6vMSgcvMjGr
         Vz62643MO6+Mc85bqOi9rS2g6GDdavyH4Wrvb25ZSwGY4qRLRmrr5sJnnuwTvOOkXHKK
         +XIwO8m7/IaIoi7hAdRv38l9qRAR/HR+FsrMkcxKRyy+2OqSrr/tDqLBt7jswJOlwQ4S
         CneA==
X-Forwarded-Encrypted: i=1; AJvYcCVeSJakVP/DgL/7ctHXnjXRQ0YecYfg4R9jPkyRss9kCNMWySSZoH99fo+8Nf1gbFrsUWfoock9x4ByJ4EHhwUWrXwgzBKYqjuAnoN1
X-Gm-Message-State: AOJu0YwN3McaxViploSy7ElYZJZAqyGPOPl1ZwxcYbbBHt+mhQURrb0e
	rs3z2Gz7Nz367OpT6/41YHQ8AoMMM3ylO4yyfR73zX4VA9+VyasY
X-Google-Smtp-Source: AGHT+IG5BmiYocILJJdGnJUPa1f9DZp9BfwZ3Xo/xOjn4ptsOpFPYVi2UNsPewbbhuLYOwUscKDOAQ==
X-Received: by 2002:a05:6870:4629:b0:221:a97c:eb64 with SMTP id z41-20020a056870462900b00221a97ceb64mr644274oao.13.1710787897919;
        Mon, 18 Mar 2024 11:51:37 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.68])
        by smtp.gmail.com with ESMTPSA id v22-20020a634816000000b005dc26144d96sm7525201pga.75.2024.03.18.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:51:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 00:21:34 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH v2] staging: rtl8712: Fix line length exceeding 100 columns
Message-ID: <ZfiNNvks6v0JGhRA@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
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
change in v2: Fixed the alignment to address checkpatch.pl warning
---
 drivers/staging/rtl8712/os_intfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index e77fcfc465ba..1b11f8b04e13 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -222,7 +222,7 @@ struct net_device *r8712_init_netdev(void)
 static u32 start_drv_threads(struct _adapter *padapter)
 {
 	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
-			padapter->pnetdev->name);
+					   padapter->pnetdev->name);
 	if (IS_ERR(padapter->cmd_thread))
 		return _FAIL;
 	return _SUCCESS;
-- 
2.40.1


