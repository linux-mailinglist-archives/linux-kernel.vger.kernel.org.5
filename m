Return-Path: <linux-kernel+bounces-151191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B18AAAE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE2E1C214B5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B660173518;
	Fri, 19 Apr 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOhAolNj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3EFF9CD;
	Fri, 19 Apr 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516732; cv=none; b=rUoj1Q6CtKzw7IQHZQ54lUQMKwYuOTIkz8ajVZXz7506uEytwOFq3I86iAqwNBIRxImgWmLWpbupuuxsJk7Vg+THqZnhDS98fpQT0ViueL8SaZWQWbhg9E3YP9npOP2Z+LTCXFh2B9yYtRH+xua1SxcUNbTVGr7eXq8EwhS8aM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516732; c=relaxed/simple;
	bh=FAJo6bXc6VfCCiKWl8JRXUx3bAnkujOQezd5Z/Gr+UI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dhgw1zdX/0cw0w3moz0tCar9Yl0rxdGY3UOfjBs4+TWL/HpN3Xm9eS3ySNPjehWVUkyLf4KYhBfx4f0ZPHc4XHTKJvvmSeQTD0+9AaZ/FN28eFaPX3kCb+GPCup4D2Hs4gAwK8dUbJl2dn/GCR3jFA9bduCiW1owHbyas6Wh8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOhAolNj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-418c0d83e61so18923075e9.3;
        Fri, 19 Apr 2024 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713516729; x=1714121529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5LGjb2F9FFTJBbYNZWOBJ7u8v0HHb3dxA+L9Lp5Uwo=;
        b=ZOhAolNjNttFl9B6WMlNywyEkQzg1kQebqY4Ngjb9zRfOhiGyASYvl1t/z9axw08SI
         etSBgDYVKKeHfKFcRAPawMvFzTpq+jiBGOWMd6PvQrgKgMJ7lGPXRtkaunXxIvzEyvxz
         uAnkRsDcgB2jh5OMj8KfpOl9eaaZrCBxVKwKBVxnTpQP4qUBqorQMOU1MUZ9wqFov8C7
         BG73ReFLExnKShRSi/jzwBPlSxFx3PBbTk/62IK9Dy+DWQIUtB+yIKA9QBZx00fC5SEi
         tgkiPTqWxkZRg+TJKjy0121URr0WHL8fUgjSILaiUt10yXt1o9aLwZUIkYLk+05iSXqA
         AUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713516729; x=1714121529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5LGjb2F9FFTJBbYNZWOBJ7u8v0HHb3dxA+L9Lp5Uwo=;
        b=eABLVPbrtcVeAVRXOsn3Nhkx7Vi4F6pRb5pvdt7XaTjfKtAyz5/3JF03HhB/syksXZ
         npC1LxdTNyzGoBbMulWGeLY/WkIzoMPqtS4NVuIOzZ5YTMUiKgktfLIKpqJBc+sGs9uD
         JgGO7crU4Qam6sVERM5zPQ11RPvC5hG4Lgzqe6ieJJCB+Y0i9g0JaKOAVH+eW4PDqoBh
         tAtUXmffyMyMlLzf5ixgKsF6wDusGIAgw1olDdS8D37jd8ffiyk3LVN+ic8W1PADgpRD
         xz8FYMxW2C5jmDjG6ES7q+91AWPYKRehVctMg0hC1ROgUCh6UQpZGDhviyZbPTFpuuDv
         iPxA==
X-Forwarded-Encrypted: i=1; AJvYcCW6l2c9Yo6D59SM9HncYzDDk9k3rExMcIyI1rSCsh6xLcX0+w/DZZdWZJodPfkUfdXKP3bjsdNqTTcwNQEvCspZKMMtbTxnZeIlEfrN
X-Gm-Message-State: AOJu0YzXJWhXExlAazsHPszHjiC8YUayHKozDppqPIELJ0Q3UuIlbv2j
	ACzr8aLboIxRqRo5VK1GxOA04B3bOLee0ryUkFDPgUTNL2lD13NL
X-Google-Smtp-Source: AGHT+IFAVjENaP6mjBDpze9INfmCIbwyjNdRH9Jc2GJLrSjfn8Trae1QHtNdTtuEVFDzpvWL1+KVvw==
X-Received: by 2002:adf:f085:0:b0:348:104c:c105 with SMTP id n5-20020adff085000000b00348104cc105mr1072630wro.46.1713516728513;
        Fri, 19 Apr 2024 01:52:08 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b00418d68df226sm6373876wmq.0.2024.04.19.01.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:52:07 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crash: Fix spelling mistake: "crahskernel" -> "crashkernel"
Date: Fri, 19 Apr 2024 09:52:06 +0100
Message-Id: <20240419085206.888416-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_warn message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/crash_reserve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..7c87b5efcc81 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -132,7 +132,7 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			cur++;
 			*crash_base = memparse(cur, &tmp);
 			if (cur == tmp) {
-				pr_warn("crahskernel: Memory value expected after '@'\n");
+				pr_warn("crashkernel: Memory value expected after '@'\n");
 				return -EINVAL;
 			}
 		}
-- 
2.39.2


