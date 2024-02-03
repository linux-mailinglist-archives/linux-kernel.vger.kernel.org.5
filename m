Return-Path: <linux-kernel+bounces-51248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F13848847
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C1728594B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411335FF17;
	Sat,  3 Feb 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="d/b91IH7"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C85FEEA
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986399; cv=none; b=jsLpaTB0aDMEhf0F7UHnalNa93DCoZZp/ZCFhSOatXU+ATMeJS6q4GuWN/V5Ztzrj25EhXuhvxSo4Bbk7oB30kOf8OHjNpLy9Jay+VF+2EZKQMspgGDstd+ajUlLOxD3kR4qHF8odCAQ9+felFYh5Uxml9y33vxSuVsiU5IZ08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986399; c=relaxed/simple;
	bh=a15mtQr01yfWQWLF5/5WsbY/2R7o79ghPTBzDCe5X0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3VzXgojSGa5jO3tFCGUbX94j+6cOw+ur3VcWCAjbyzfHROsvXMm1wvHyxfjpPqr45M2+Msyw2IyTH53q8iegDp4iN4IE23G4XgkO89OsAWWc/uX/stgKon1tN/wKQ2vUA7wdjdjbVtX5RXs9e4WdkjuGcFhrnoQ1x4H6YK3iVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=d/b91IH7 reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d780a392fdso26681135ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:53:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986397; x=1707591197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMK6uKXfNz/nsGcon/C8VrTPd2Ab3T3BTLt2EsWBnyE=;
        b=tUnUPgihrqycHBW6f5uNaTiKCbJU9w+kOi6Lq82foCQ1RJ0e3f1OQKwnQlMrf++RXC
         On//SH2x0g9pZBJzJ1ZCvM1HLXQvShQUdRhHcBm3ZWmuGqpzvnMv5QsDCX9N7MZwI4xo
         jFIFlf3cI5iZB+GKpuBotFGn12DdXvxEzS50vjwQbGAVTGnGGRQ3Zaf6Es6R4kNNdhUd
         28lsjQROs0WtN12yVdO4mEqrgo9fJ45LLu/iBve0D6I/4c9CTXeqdLvbsyVGpIG6U4xd
         n5JbLH0CyloyPgg2rdvrrCsVCuyYknf4AL0ByJgkl7oMXreTwHgMGECfHnaGaPChjQtP
         gOhg==
X-Gm-Message-State: AOJu0YzyLCABMO+gpVVOiKXI62s9n88kITt9NapnJ5rZWTI2hBByX2QO
	8MXz6frRe3IBwhIa2k04AX9DrkbLiouOBxSD1DtIQl978kMc3m+r
X-Google-Smtp-Source: AGHT+IGbH6ZYJYqCyLdLrsDa8OizYNf648PZ/HHOu7tx8iYG0Ii4xFkddglDF0dNTfItn0AvcwNOSw==
X-Received: by 2002:a17:903:249:b0:1d4:e208:9b0 with SMTP id j9-20020a170903024900b001d4e20809b0mr11130471plh.44.1706986397240;
        Sat, 03 Feb 2024 10:53:17 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2Fadp/SGhL3HK6yTH0lKP3rfGEbv8/GAi3tzKf8/aeB0by5STQsj+r3op+wDEmYIuRn3Y/pBERUwnHxVAj4AYKwjYXs2RMwgg8oZjWyGFLFfGNnYidF/TBcQMLaYr33BdKR1jQVFG4GsnUWg1Hw7QkEcXLBHAY2zOJza4ElNmpOGKSOReeWllojdyhoXBArdQTvK9HvU0OGd8+ruzpG4=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902e2c500b001d974ffa1fcsm3058420plc.173.2024.02.03.10.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:53:16 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMK6uKXfNz/nsGcon/C8VrTPd2Ab3T3BTLt2EsWBnyE=;
	b=d/b91IH79JyEKl4lTtvPDJZkgOP3vWmmAkRT4CCuLWZ0q0cM4YSYxO5x90ynhmRNqoGAb2
	MX5rNMnI6UgqZnWkeyWxjhJFxu6toynOA6u1Xf39buDCaFsawntbhwVEJp4N+4J3Ac2VGr
	5JhntPbRQe4HHwF5nDA3tPxH7mRIfY9eC35llsvDKa1lKbPx5tocjZGIlRdh4fmxIRP4dz
	lDNqKI/O8JqdQhhFkkGn7Ql88HC6qMjbRvdMxfjHIwzMEgQ1Pv8KMtRVhdEHMuj4oHrKqI
	4GnnRAarZ2sl5RD64TTF9uXul3GTgCxT+M5jvICQ2/zjXOW1oyqh6CeYlAXRYw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:53:38 -0300
Subject: [PATCH 2/2] xen: balloon: make balloon_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-xen-v1-2-c2f5fe89ed95@marliere.net>
References: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>
In-Reply-To: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>
To: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=a15mtQr01yfWQWLF5/5WsbY/2R7o79ghPTBzDCe5X0Y=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvouxq6eiZcwBEfL0eKDgR/Tsw3cuRwc1xJx6s
 WHMrCFJCRGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6LsQAKCRDJC4p8Y4ZY
 poA/EACY3HzoQHClLbpnthOER522MUTZO2lQJLXt+WNqaobWySLeseiDeex2CGxWdeGsn4gzV3s
 SCD7J00yLWCX29j3M/BvDTPmePA+mavHsyQ8rQielbuNnr3B5iXLYmHFaBEHd4D2+LC7NolXmwA
 XDAa2sLewEnr7rvIk2PMjlmcHa/KIOh6G7Ls/12Q95339qmdPhDIbZk4NjH2KY8Pr8OAzRw4DpW
 UptByEzu3k1kS59uBT7FfrjvIU4fWmEmlJAWU/LoXKt+AlkbrOoNcKRsXX0Z174cxZlT6u3EHeA
 I2zaEzpITAelotRc53pJpVw4pzdKJoodaRIIF0+Tnolc3K2iclnHCHLVP4ZzSdP4cuSd5yaD/Me
 yyS84r5wQksXW4aqTvmhHDVz/YVK/N2O9wGRo/hQiDzT5LZKnBuXJWYc0zDIrLdI/Bint4kKJDm
 ygxa+XRL8U7KhpMsuSe2vrNMlvt5+r6SVeqQ+3PyxjSEIHm5A6Tlq87EC3InHuN7v+bv6ciEkb6
 WMn5YKTe/VR9rmjUqqIs9KaSOzg5EBPrU5KJAi+EPyEBuUOOYUoNxAaea7dJMRdHqRIhcyvb40J
 khD83wKupnXtMRyuSG2iGRp64bsE1ep9J/UU27/ZdmANXs+kxoaU0PnFf1APqUm18cS3GHxwLRs
 PWecp9qGUFo1M6g==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the balloon_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/xen/xen-balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-balloon.c b/drivers/xen/xen-balloon.c
index 8cd583db20b1..b293d7652f15 100644
--- a/drivers/xen/xen-balloon.c
+++ b/drivers/xen/xen-balloon.c
@@ -237,7 +237,7 @@ static const struct attribute_group *balloon_groups[] = {
 	NULL
 };
 
-static struct bus_type balloon_subsys = {
+static const struct bus_type balloon_subsys = {
 	.name = BALLOON_CLASS_NAME,
 	.dev_name = BALLOON_CLASS_NAME,
 };

-- 
2.43.0


