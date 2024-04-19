Return-Path: <linux-kernel+bounces-151426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0CC8AAEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9588282BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CC83CD1;
	Fri, 19 Apr 2024 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FatThHaQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413A9BE66
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713530406; cv=none; b=uxyPECqzB2oIr251lrVLgKKVvXHmH8GCLv6VkSvFhh16OV8Pq72ZLOlEcj8jiDXBcPnMD2HkGF44i9GRWaNoCU3UMUBzOg3I8Z5daY7J9xdyS2BMW+BkGOj4TCYNk0EWP299fjJBvIlMFzRy8E9KKnKSyYTr+SbCWNonll0WNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713530406; c=relaxed/simple;
	bh=gh+ce3V0R5u8LemmWy7Lb53EFXvlT/mC8nvuXLXwbas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k3Ixcrz3pkmrKufQ6+5OaJkUFGV6DbM2wnZGXQWms7CpUpnSLpZMPztYasLckiwscDgvT9TAfvYu1WZ37nF3IIbgXkFgqHxukws3HaSneV4nw9mWo9ZKo4qCvQDLbXdJQsdb3JtyQ8lOvBKCzrAsltY3cnEqkM0abhX/bRuBocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FatThHaQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f074520c8cso1950109b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 05:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713530404; x=1714135204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6gvbTkCl4kOc38ddXvfXR7xJWrUmpN2MY/YPrZ9UCo=;
        b=FatThHaQFrZehx4qG5T620iduv/tPwHyewrpzY8CflUjPh8CFk6n+Pji2byHE87zZZ
         ZZBwrGhy9Vry6xLNC8QttRsXs7+aYijkweVJcnIONvWIbpZJ0E/9Yni1boMAgyyEDEZb
         f73pSPStGQb8NWA9LzyYpNbtKryZv2nC9OcMQ9ESChyIFn3LlGfU+UZvsZB5mS/Pri91
         bi0EdYaU4+7/XClQCAW2a1sppFggS10D7IpjMAFy10UfHOCRjZR+DNstaLUhYJ61d0Bf
         JDTCK4mvCnXOt1OAC06YOVclyF8F8cIySM0tP5MfGSrhUqFpNzNJ42ZsY+CtRvLmuKZv
         OptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713530404; x=1714135204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6gvbTkCl4kOc38ddXvfXR7xJWrUmpN2MY/YPrZ9UCo=;
        b=enNxBBLe5UhrAWo1jHBT3MgdrMpcoACCzPiJycIhPUaRsb2NYDvEN1aTrBg2uxpWIH
         ggp+1MeQhz3QJvmRy6KDPLTCUsn4nk5262OJXQwb31KvbQMFpBvELGUGHC6z/GzuKXra
         VByZqkUK5sVZyduYGsQo+LY79NCVGmSJeyexNZu96LWQ1+Fy6m86+SQ3FlV7kV9qFvs7
         fZn60I3f/t2BUS11gowcBu8U5+JvWaUwNmiWXv26w/aRn6+aoAApr05QQoyhqkGG3rVS
         v79M6hDZPK1Wn5cdUscfvz9ymZiSHAnjQmr9TkxNG+i7oeJf2XDtgeWveQDEH/8tlSmF
         AuGw==
X-Gm-Message-State: AOJu0YxOoR31PjmnP88g9cL80/p0faQdYmVo2l51Jq5kOmo9QZGM1nsL
	mOwPMBRBgW5ymPkDL7Yv4SveoHwTf48DBbLSYLp1rRINVTc4Mjfy
X-Google-Smtp-Source: AGHT+IEM2FGG6AhfznV6YdsNoTzYj4xh8GuTC3lc/tR17kvmWE4VVWpQwpzUq9kNAkFraAhtBEYPqg==
X-Received: by 2002:a05:6a00:4b0f:b0:6ed:4203:bdd2 with SMTP id kq15-20020a056a004b0f00b006ed4203bdd2mr2342756pfb.9.1713530404553;
        Fri, 19 Apr 2024 05:40:04 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b006ecfb06413dsm3124953pfn.197.2024.04.19.05.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 05:40:04 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [virt?] [net?] KMSAN: uninit-value in vsock_assign_transport (2)
Date: Fri, 19 Apr 2024 21:39:59 +0900
Message-Id: <20240419123959.8572-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000be4e1c06166fdc85@google.com>
References: <000000000000be4e1c06166fdc85@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


please test uninit-value in vsock_assign_transport

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/vhost/vsock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index ec20ecff85c7..652ef97a444b 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -656,7 +656,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	/* This struct is large and allocation could fail, fall back to vmalloc
 	 * if there is no other way.
 	 */
-	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
+	vsock = kvzmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
 	if (!vsock)
 		return -ENOMEM;
 
-- 
2.34.1


