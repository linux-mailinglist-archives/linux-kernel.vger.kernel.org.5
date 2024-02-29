Return-Path: <linux-kernel+bounces-87144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F079C86D02A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED68B286B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5613C9E4;
	Thu, 29 Feb 2024 17:04:59 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CC67E64;
	Thu, 29 Feb 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709226299; cv=none; b=INX+YEEDEe3NY263G9kVG/YcrCJhjOJWx9fEG0bFZJlihIYIySds3to10RDCw3EgvlyA622JRobW/QJc0jtxT2JjDd8hUeOnwA+YKBJyLRPMPqvbO2qUexchyKualSHSckhggKUjl3M99rJFbUbIDT5MxDXenMpFJMh/cleUNLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709226299; c=relaxed/simple;
	bh=NG0jFr87ijT5BYSsGI9lSmaYhaA9rtZkHHR8E7Yobbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXg/QZRNaYPYoBlpmoltdQFpyGxK3/KoSbpltRjz78Ds+IeyQE9O40zThXJGDkv9wCIbO6/25xaYjdrILi05aACyAZ02wQe5H3fJ0xt/h8btCZb0zwtiR6YMZ9Q/XuhVu55fgKz4J10WJUO+mk3DAzvin9FOvdykiW4f9nusQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412c286be35so3081065e9.0;
        Thu, 29 Feb 2024 09:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709226296; x=1709831096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umXmCN0wcxBj+OX5iM/0dix7BhHHVWXFpQt8h8LpQuM=;
        b=DvwtbSf8fmDZZmViiYwaCM0iwuKUutEOwY4Z+NHSrV9Xnppu0erIhmgZzs1UO12CcU
         7pJYqbnkutDtR46WA+GbRgCJhQXEpXzGktTuNSUwbupR79/PaJwwV9xOpD3o4ZVqRJbh
         gpr51Blr6Fw1O79V6m0CcUaO33yhWbYbIXm7PmAuoq3k0bIaTiN7OFBz60TRirQdBxXq
         9/1kAInPTvSL/YKd6dkMgyKm3MdcrteFa93Md9UDlDWkuOPIsfDYtuFd4uXf4VcgmPTK
         Vp839w1riF0doSjao2xfZK6O0Maczp+NJGtx13cago6ngWtK8NfB5LKog5ymka1wlVmQ
         sPvg==
X-Forwarded-Encrypted: i=1; AJvYcCWELUtkIfAnT/PbzMtVtUkVVj3RD/YvnW433oN2CS+jcOQCe1IqVsxVdVBs/LYH8t/yGN74PfSaUFYMIeGDw5i7Y5Z0jbINqxvKkUnU
X-Gm-Message-State: AOJu0YxsqpxA+6c8E3uIp3dlBSqt/J0j4Cn2jvi4ilGhNtBdkneSvt6c
	4Spv3aIhBVdt2B/k6CWhsPBluvJVgdr664Phg16jG3PNA9DOB7r5
X-Google-Smtp-Source: AGHT+IHvKKZ7GqiGM4f2qtzBGgJKbkraOZ+yYZ++KZ7cZ9NJD3RaUijXEZBljdzr+6+V2U1AZf+vTA==
X-Received: by 2002:a05:600c:1e86:b0:412:beb8:841e with SMTP id be6-20020a05600c1e8600b00412beb8841emr1928346wmb.13.1709226295504;
        Thu, 29 Feb 2024 09:04:55 -0800 (PST)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00412b0ef22basm2654717wmo.10.2024.02.29.09.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 09:04:54 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org
Subject: [PATCH net-next 2/2] net: bareudp: Remove generic .ndo_get_stats64
Date: Thu, 29 Feb 2024 09:04:24 -0800
Message-ID: <20240229170425.3895238-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229170425.3895238-1-leitao@debian.org>
References: <20240229170425.3895238-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/bareudp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 27408f0b93d6..339db6e4a1d5 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -523,7 +523,6 @@ static const struct net_device_ops bareudp_netdev_ops = {
 	.ndo_open               = bareudp_open,
 	.ndo_stop               = bareudp_stop,
 	.ndo_start_xmit         = bareudp_xmit,
-	.ndo_get_stats64        = dev_get_tstats64,
 	.ndo_fill_metadata_dst  = bareudp_fill_metadata_dst,
 };
 
-- 
2.43.0


