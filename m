Return-Path: <linux-kernel+bounces-51247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FB848845
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D128592D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2C5FDBD;
	Sat,  3 Feb 2024 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="HgpwLjLE"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638138DD4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986396; cv=none; b=JbN/6U2mdviIEm5p97ZejolMsGUiQdwnhadulk9F38WG+Gom0jHnMujrgBAqsuOwObkJOZYfgu1daOxFRQm7ctKGtZl15lwPSSjCzrgV7qgVlHu08O2UxV1kPffYU0ls6eO8DMi5OWaUycLjhDelfYJ4dsQGCgncJCVhL1rwVlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986396; c=relaxed/simple;
	bh=uVbAr2jHnQr3MqspyOfEzRc9k0HTklRcQDcrLwrPX2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SqLxx4cG8Tj+yJUIGbuw4Rqndr+zXBmGDVIA/D/yyRxIWcw+i8ZE8fF6Ib+lC0tyyZvAVVbnxiD8yuZq+mLJQY4L2MIi9OwlbQJ2iBShd2XlfkK+PbPGkVxHUBXow0JkK1QP78woKi+kHvJNNd21H6jCNaYjY8OMD7whX/LlVks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=HgpwLjLE reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2966f32dbd2so122108a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986394; x=1707591194;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhpVXJ+IMs5n5HNm3DBIJeHeLpAjHMNMhg7tgPyvFRk=;
        b=klmOzQwAaZ2MnX/0DWq92Rpba/Ei8p44LXif0cCZgLkSS+n4LrYse3B/BJsBm8weh6
         2WUUE7NXIssF33hyfhWQB2Z2U6wqvqu5WkfsD2pHWWaPHzcCk8Iy4sOx+9rlHyNKb1QK
         +kr33Tz35WAz88NVNGUHE40hGpZHiZ4rTTLq1EiAMo8eaV2al60prnPEHJUBFI8n/CQS
         2mDnxCQf80PgBHRAma2InN7SdWxr4TuCXa2qNF9RsrdmFA8Gg1i8aroT2tLBRZo/WfWr
         AnIS51FrqvG9ZjEv+eQs6GmxAKLaNC0rKr78wb+Oz721AcnMUnStsBvN0vXNosWaVzQq
         vJmQ==
X-Gm-Message-State: AOJu0YxpdkHyIaLIdvIlmcaf6iMDy4W6fJl+a6+rWZCv6+/NbBh+wfmk
	H9B4r2LmGHr5wLWx0ClaRSlvGX6FaWqq4VrC8KbkfUlRui0y9ShN
X-Google-Smtp-Source: AGHT+IHNiV9m9PnT9NfWWTLKS5PfvHJH3YAPWwmMb5gceIQF3VaO+pK7Qdw5HKIhnVCxyVRzaLS1KA==
X-Received: by 2002:a17:90a:fd84:b0:295:ab00:e9b9 with SMTP id cx4-20020a17090afd8400b00295ab00e9b9mr8137370pjb.5.1706986393946;
        Sat, 03 Feb 2024 10:53:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXU3F//e13WRqDNIvePL9ElC+L1hOrpM9eXVNU4WUyGNILtV/P/hwWPIxHcY/Hvjec4tjvqzgBxTPCeEAppBqwINIMrDzRToVZ0tb5Z/wj6qHZyi4NVR1xqob4Xsz+T70MOVp0cAogc/podyejn4uFBRbE4r4EOOtlGtaKY7e2jZh8oi3f3/uNG4PgqC+bs/xyOW6UAaWOlg2fGjiWqRkI=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090ad48f00b0029636e02c83sm2143181pju.35.2024.02.03.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:53:13 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhpVXJ+IMs5n5HNm3DBIJeHeLpAjHMNMhg7tgPyvFRk=;
	b=HgpwLjLE+5IojjaDPw5lVDBUECMPSExHUMPhE++AL5xcGmYR3TeDz16MbH7zvVuZcuV5RZ
	4CNrmHvySWMapk0sZFaMJeQB6tvCEaW0NIrF7d4w6ZrmiMrby4BgZAvN9+tjz2G++u4r4w
	g1WohaDiXSkJ1PbbGFjguIfXcDkazNeuHAmnsCs4+TAQfGKlZ7bW55I1mz//fZzFDUowaB
	tk1ydtFuveiyVSiNX44BG98XUe9QjlUuP2GlA8LuzUTVUjJx+In/cmZUhiecYr1pC45nAL
	G5A49wyLaW2gu6Xab/A/hPxI/xxjRRLzA32U6yU+UZiHTQntU4nRd9xKIoQPuQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 03 Feb 2024 15:53:37 -0300
Subject: [PATCH 1/2] xen: pcpu: make xen_pcpu_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-bus_cleanup-xen-v1-1-c2f5fe89ed95@marliere.net>
References: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>
In-Reply-To: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>
To: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=846; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=uVbAr2jHnQr3MqspyOfEzRc9k0HTklRcQDcrLwrPX2E=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvouxTV6WmgHhD2cBPYK/XUfsjwDH4uwBWaCje
 UD7Ddr2uBiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6LsQAKCRDJC4p8Y4ZY
 pqGCEACkMVwx/dvxAGqkTeMv3vt97i5rt0L9zEHqvNbgGvxqXH7vIcUCDiuX+ziP0EpEUVdYV7k
 lpXpbodhjS9FFsFGFz+otupP0ETTWlykpYf/fV0R6CVcDHTGeh0KsvlBE7wUod6gN+x3+70cpxV
 EUX/Gy7KTHd/1RUYtnvcWjdNXky9qsWIHZ2gUY29UljGu+pWgXXM0y6N0bWUdI8jOVr/O08mscj
 NWZMFj6l0KmP/xmu/YZtnsvmmG59BTE+1TDPZMwWv8Bc0NBN/Crf+cdpOUHf4Ttp8Pm2kGuarNT
 epDpJ5MtH4kwMI2VrQfnzo7rBSHjPn0o2n1LofwAcPMkcJ8dP6YA9/p3MC+hfScuRVo3pmo44En
 zjZwz2RoD2zzRhDoj1uJqjWwVl6bsxnTOgHp+FRHWnCzFb5QBWGpGYD6RskC7YyrywFqE5cr7cW
 pU4zo1L7Cx+k2hvWPt20+Q6fuF4zike1ItHUAfV1yGVnk5vMDQYUMgYzaDanTJInoosriAsw0mi
 OpefvNjEidNZXxXHfsem3ZpKpUonrVqErVqmKcEgeaT2BKa4DoqQMwyubVpOD8pSA2KOMZyWWpQ
 IBegfAdUOBd2Jv+Tf2UkaszcT1FEawY0F5HjWONwE5U2joStmRWirRS/yA3lTCeB2laJlFHBY9L
 waKgnT3rwMWDgAg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the xen_pcpu_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/xen/pcpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
index 508655273145..c63f317e3df3 100644
--- a/drivers/xen/pcpu.c
+++ b/drivers/xen/pcpu.c
@@ -65,7 +65,7 @@ struct pcpu {
 	uint32_t flags;
 };
 
-static struct bus_type xen_pcpu_subsys = {
+static const struct bus_type xen_pcpu_subsys = {
 	.name = "xen_cpu",
 	.dev_name = "xen_cpu",
 };

-- 
2.43.0


