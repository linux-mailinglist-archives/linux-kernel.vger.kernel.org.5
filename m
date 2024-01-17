Return-Path: <linux-kernel+bounces-28681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E58301CC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AB2289105
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE0912E6F;
	Wed, 17 Jan 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAM8yJ4D"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CD12B6A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482109; cv=none; b=LQ1N0Ko94DYIx9TB2GOteGIc8FNCjUhdTjSR98vXQPX6WOHGICCMpeHOKJGC6N+XJMrNaOiDcRolLQ6hwaVuix2PNZcWedn3GVfa7C6Wsq3zAe8R9NMQ1x522fGgOZ0YiCKoP/th7Dvzjrjh6oycDEOtffwzlIpFtN/p6TeK+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482109; c=relaxed/simple;
	bh=CFba6yBxMqahDhxXXbyJrpczbPpZcSOe7fz27cRHjRs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X4NCiGOD5hdToTvD0cZs+0tg+57H2Okvq3zjXkGQHTJOMK5VMXbIjw7yUUXRszph4f35AQJQVjddBsxu7QusmJMmXjn6EMVh8NzUcgqXJDAlpfWtf9xLYR+92RkGAfdBbi7ZCijpRI8pTQu+ADG3s2bL3owWuTpRJcSNBVGm4gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAM8yJ4D; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36091f4d8easo43049955ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 01:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705482108; x=1706086908; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3EbBfiXII+xqP/XocniUaecVX4i3H4jifFCHOQtVck=;
        b=dAM8yJ4DmYT5twfY9O71ovmlYufjVdIdlhFupNMhLqaZbFYCVfg8R1eDCXrr3nEV22
         wOfwZwvfT87jfNEBTeI2Oz+VCLdvCQzCNo58qUqbh3V22TpyQdSCDTkGCA/ZwWjU1Z6Q
         YRTaSWqbVP60IKMuhNYP/8in5DfhgZ7g77YBklYjSpcjmz0gv5b0CJJg7j7+Dyc9h6zD
         p0fCV5tGvomsa6aYkaEuaMb86sSUCb6o8Bt6M/+gUYBq4AcNeDTLYRF6HK5uEq5MjCmH
         hnJcMDnQnbR/EwtMg32Tm6FWUpWU6Yh24lD3LP6yfcSEkjNeGNZJ9jH6ckbWyjcVInwP
         Pc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705482108; x=1706086908;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3EbBfiXII+xqP/XocniUaecVX4i3H4jifFCHOQtVck=;
        b=F/yIOcn9WkmR9WBkoC7R+shoGqfUSJtMwsFpxyzuDXNduYcnHdUKkX+Pq5u210AKm1
         G6YsdLXVThAyBnPQjGHau6/NvPVjTE6Ss31eMPvur11FHrgkfrTJUqsq4hiR4E6kQVXy
         Pf7PLIG66OuP7qzXqrkfe/N5lAhilBs/3FToNphjTJI5p5AgrZa/wYR5cB6ce78C9J+J
         rt2HByzBYh/LeRGk+SqPZnjTwim3IB2QfdxZTiybuThWwVlmh7jmAFqEfvRJUhnGmCJA
         tnE+8PGhEvabd7CNcVOf8aJCBkda2dztLHXpDA+6vV0qgvGlZynAmhKZIjxdsImQV8xG
         FCcw==
X-Gm-Message-State: AOJu0Yzxm05g3SDxYwaNs7XoxQW6wcIHLWQgug8+E4Hcjs9REzIneW6K
	1Fsxyt95JTxO8xJIB1zxpHo9vCrV2m4/zW8A
X-Google-Smtp-Source: AGHT+IF/txay3bURG984EnkgcClPO8mxtHxppsINIYZVhy8bi5zPfnHfQiKBfFrL4SOKHCawBORVQQ==
X-Received: by 2002:a92:cac8:0:b0:361:8ce6:af64 with SMTP id m8-20020a92cac8000000b003618ce6af64mr1967974ilq.1.1705482107662;
        Wed, 17 Jan 2024 01:01:47 -0800 (PST)
Received: from LAPTOP-7VGLEE77 (19.216.252.27.dyn.cust.vf.net.nz. [27.252.216.19])
        by smtp.gmail.com with ESMTPSA id l23-20020a635b57000000b005cdf9c8e922sm11508014pgm.85.2024.01.17.01.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 01:01:47 -0800 (PST)
Date: Wed, 17 Jan 2024 22:00:33 +1300
From: Hoorad Farrokh <hourrad.f@gmail.com>
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: remove unnecessary braces in while loop
Message-ID: <4vmxiuz5u2f2vehngdccj5q7bakpujagk72ty5ounfv2nfzxgr@lqkdn5fecc23>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixed a linux coding style.

Reported by checkpath:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 1593980d2c6a..0145c4da5ac0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -127,9 +127,8 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
 	phead = get_list_head(&pstapriv->free_sta_queue);
 	plist = get_next(phead);
 
-	while (phead != plist) {
+	while (phead != plist)
 		plist = get_next(plist);
-	}
 
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
 }
-- 
2.42.0


