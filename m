Return-Path: <linux-kernel+bounces-14379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C290821C49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6181C22022
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958BAF9EF;
	Tue,  2 Jan 2024 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WANGHwWF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B19FFBFA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso54390055e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 05:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704201079; x=1704805879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvu173ekwBOeXVa4GusHqI3IsRPkfn6/W4VPO2scDNg=;
        b=WANGHwWFz4pVgvkaUFvwTzckxUKMCHqUgFjqlKYhdmqIAp6c8lzCOkdOxlhzy+2myb
         ZKMAKlZcCXPd6rNkUwLxHLDJbnfJY6mhnnm/Fg3T1SUmhpP0zVhRVY6z3JR/NJ1rxjTz
         kjVLhtDTBRKi2E2riK2KVVUZ9GFEBSwZR+h8+DZhOw2QpXj9R48gSTta2t3K6s2pCPlJ
         81BRY2ICzC+vwSKrUrh94hR9LOLTDiKWCMcRQktj0tAOpkmMA2DMhx+TXnO9X1rtnuSp
         bMHaiE8KoFJ1sRVuTDLB6rvKzGpTogF9145hRvtQ1DzgJehPxWGbGfGEjK2Y0wsaPFvA
         utyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704201079; x=1704805879;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvu173ekwBOeXVa4GusHqI3IsRPkfn6/W4VPO2scDNg=;
        b=rhJ0ZfrEmt6gm5W+l1Q9OvjBKcy01e2bwamuUV+BFFyam8+T19Z6eDFxa/y6NnM6W1
         D3cowo13amQAegGC5vcJx15fQOeitZiGyDQL5ybLcroKR00+xP7tCfMFyiarSafi5/Vr
         eJbMpRFMFn1FH+kSVawkN85Vn0zJ+wZtjASO2okIsTuSfBDn6J0pEo1reQqp0+OFmShm
         qU7sNLvPRER/cFQatIpjFuRQxOYJs9Dzwc8zW/dMdbjnrCSSeD6rlR6QpWK127sr9gov
         E2zHeXyMypcXkvisoM5HQKXRW/DVAZzPS2sxVSgohYElOcQ+B4OMY9GCA2gHbPgYRnsW
         8f3A==
X-Gm-Message-State: AOJu0Yz6ox4YyuCTKgykw4BlhLuHsDMSPiyeWuN5XyixSUlGvmFWYbPu
	OTRr2X4awD78qBSxBdUKk6YI7SnXmA7HrA==
X-Google-Smtp-Source: AGHT+IF9gbCNra5uzLEBnEzGzcv5ksqDpG2nrYHiTl1xo2kQQcHi1I8nDZ25z3zjUq2MPWLBQMnnsw==
X-Received: by 2002:a05:600c:2184:b0:40d:5c89:e254 with SMTP id e4-20020a05600c218400b0040d5c89e254mr4950796wme.71.1704201079698;
        Tue, 02 Jan 2024 05:11:19 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0040c11fbe581sm44799576wmq.27.2024.01.02.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 05:11:19 -0800 (PST)
Date: Tue, 2 Jan 2024 16:11:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 2/2] cdx: Unlock on error path in rescan_store()
Message-ID: <a7994b47-6f78-4e2c-a30a-ee5995d428ec@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e66efc4-a13a-4774-8c9d-763455fe4834@moroto.mountain>
X-Mailer: git-send-email haha only kidding

We added locking to this function but these two error paths were
accidentally overlooked.

Fixes: f0af81683466 ("cdx: Introduce lock to protect controller ops")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: I rebased this patch on top of the other bugfix that Christophe
    JAILLET pointed out.  It's easier for backporting to do it in this
    order.

 drivers/cdx/cdx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 40035dd2e299..7c1c1f82a326 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -575,7 +575,8 @@ static ssize_t rescan_store(const struct bus_type *bus,
 		pd = of_find_device_by_node(np);
 		if (!pd) {
 			of_node_put(np);
-			return -EINVAL;
+			count = -EINVAL;
+			goto unlock;
 		}
 
 		cdx = platform_get_drvdata(pd);
@@ -585,6 +586,7 @@ static ssize_t rescan_store(const struct bus_type *bus,
 		put_device(&pd->dev);
 	}
 
+unlock:
 	mutex_unlock(&cdx_controller_lock);
 
 	return count;
-- 
2.42.0


