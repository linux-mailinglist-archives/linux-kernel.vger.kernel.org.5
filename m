Return-Path: <linux-kernel+bounces-89770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BE86F56B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED29285B9B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE335A113;
	Sun,  3 Mar 2024 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zdt/uSnx"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29110A0F;
	Sun,  3 Mar 2024 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709474595; cv=none; b=acpAs6K9zAarty/kP1UC4kRFI7/8fLfuVpJVEIkoc71DyfMFAyFfSaeA0mo5y//oSmKGgszRM9JJgssdZgzgVKzvnaV7CKW6r31fLsykoeF1oGmM6FJmwUTcRmGeaNO6N/r7O28YgK9J2AO7kJ8zpVf0+VpbsHx/DmzTcMvN/uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709474595; c=relaxed/simple;
	bh=GcRrrhSiF5AAKh1PHd2VAH5HKAEAngywhX940o4lkaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gzx95JCqrm/j+mhNKchdp2FOsHVy/M3AqMxm5f0EmvVSjPMROMKLJ9BycqJ3l6ahh3h/YPVP9hxxrJnoocYMVihBXb+foUwhrsVD7fvvRsGfNOQLgWBdvk8R8Ru4B/DOki410O/f5TKG7Nb0p4nuh7ysHJ6o5J3n03Y5bjGlMbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zdt/uSnx; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dca3951ad9so34899725ad.3;
        Sun, 03 Mar 2024 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709474594; x=1710079394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFQ98YPjoSiE7pLH8hM4Oyp0KYOd8bXf5NOCcbae+NI=;
        b=Zdt/uSnxVaVJ8RQIPDHZ91hQootcp6Z/fJyLcLtLfXuJ5MUaSD/eLDqFb/b5GQQHZn
         qfx0pmZCD++N77fTSlCWbsoKPGtDQw9sL1lGPbODPkQsnHIazRF39pW9ISaqQbyJdoZL
         ymTvTcWeLYgrw970g+cmkXxqu8VGyYjYe5JAqAt0I0kz8xhMb1LS30vxFVCcgzKxVn4D
         b2YLSSi2IGRCJEJ6RenJIbt+tBQN9CcmvQrjRz+sjrTAWKZaYtUGb0lSsfpWftt32E2X
         GLkrxuIDo1Epnd1kyuhLrBZUNSNM9ugDNLh1HafMFE8TGssmyuq+7scBZMbINxDssx5W
         y+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709474594; x=1710079394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFQ98YPjoSiE7pLH8hM4Oyp0KYOd8bXf5NOCcbae+NI=;
        b=mSt5Z1VnuVn7v0oBoRr0LD1ryZddFnwiF+LtqxlCfhLZuaVdOtSduhdSjl2b0JNV4o
         kQXbY1ydNPJwTF7JFQ6p99S9PhjzLvO6VriGwmrxjvqXWMmr4010mgoq7nTYomsZY/AH
         oYM+eWPNAVpK9KVsFRWsb5QWYhY3cqsG3SZAjlRiR5bRkii9/SaOnH6UvvNQSMzhBiD/
         6VzA+Jpf9pKKwySSM3i/zMB7EQX+eOXaHe8A5KI2aurOpr3q/MsPru0Y9Wg2Dx5KL55P
         MM5Sr2/S5XXfrlBxNJbkgd+p1oba2DmWv9WVyKaD1yC96cLPGepUmp0PKpfKqsB8ThPK
         ec6A==
X-Forwarded-Encrypted: i=1; AJvYcCXPcKgFSvk7Rop7JRun8tzO5H0KZCL2tjfmsKWJuR0gsSC1+lBP8In6XG+Ml4T+voJIXzamHiyXK1e7eTe32Dxka2raHMQMhl1PZZv0
X-Gm-Message-State: AOJu0YzqIXpA6PVj10hqtAqwowAxaj09HMfhANgYMd9LJvvHdMGPfq+5
	ZtmC43SyhFkpca8+l8VWWi+QhhEThJmcxXYqZ/GcYtOCqzVtlR9O
X-Google-Smtp-Source: AGHT+IGcI4h9YJxZwOWa0u1VlsELtdyebJRxJxuPwoT15Kli9cxOhA/NxWDXMGUp++4906EAzHxPcg==
X-Received: by 2002:a17:902:e809:b0:1dc:c93e:f60d with SMTP id u9-20020a170902e80900b001dcc93ef60dmr8848487plg.49.1709474593874;
        Sun, 03 Mar 2024 06:03:13 -0800 (PST)
Received: from kernel.. ([2402:e280:214c:86:98b4:6d91:d5f4:8f27])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902b78800b001dcc1597377sm6651412pls.230.2024.03.03.06.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:03:13 -0800 (PST)
From: R SUNDAR <prosunofficial@gmail.com>
To: william.gray@linaro.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R SUNDAR <prosunofficial@gmail.com>
Subject: [PATCH] Removed priv field description to prevent kernel doc warning
Date: Sun,  3 Mar 2024 19:33:00 +0530
Message-Id: <20240303140300.6114-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/include/linux/counter.h:400: warning: Excess struct member 'priv' description in 'counter_device'

Signed-off-by: R SUNDAR <prosunofficial@gmail.com>
---
 include/linux/counter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/counter.h b/include/linux/counter.h
index 702e9108bbb4..b767b5c821f5 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -359,7 +359,6 @@ struct counter_ops {
  * @num_counts:		number of Counts specified in @counts
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
- * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
  * @chrdev:		internal character device structure
  * @events_list:	list of current watching Counter events
-- 
2.34.1


