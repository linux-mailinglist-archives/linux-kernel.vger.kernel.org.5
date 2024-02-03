Return-Path: <linux-kernel+bounces-51246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EC1848844
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71F7B23A5D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40120DD2;
	Sat,  3 Feb 2024 18:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="H97NBcnp"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324423A8
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706986394; cv=none; b=d4AZinKrQUnGcdbu/XulVY1tDOJe0dadu55eUHzI9qNSVn3dyKE4YNRuB0EDvxPv8pEe2l89PN0xX3KexOIVxuHtYNTkhfZBV2S0y3u1BOKw0Cl911IyLDJiB83SrvuN8KRDAC2uIhe0s0wX9XGuE9x6jnf/g4RODE8kvycgEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706986394; c=relaxed/simple;
	bh=DMQ8P/LGJBRCmHwEmxktQacfWtwbjDULAMo73R7wiAQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L5xaRQVDHBVDFpXhSCRWHmT5Xd2VSiS+iKxYrj2I2KHm1GFnU03f1sxCRbL8FkD+VfitTz8pAPwUwBhQPFOU9YtmxBL+VSKjEWBAjqwc17f/6vljjCTkRTPF5WFFvydkNOwVmYm01Lyc+1Cm96Frsp/JNP/Vq2Yg/kDtYEoHfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=H97NBcnp reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-295af27ec73so2541223a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 10:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706986391; x=1707591191;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OZiekaIfpVrKOF3qlNauN16zVWw+/1GjqDEklLmvnts=;
        b=NyX65vYyOBr+vhx2AE6FMvIaTenFR4JEnZ/sG7S1Se6kW/0prskbjWTyD6Kz1FIqWi
         QW01XCIMelqwsvtcxhgIWcI6vN/bxpgWF6787jtSSzD/WJ3dbT4VZ4drQb9AdSuCxe8o
         fP2jyujs9LVrf8RyWaw3djgr1WV/rFg0wx1AHcQWW3zbBnNmp85VdXedIWjKifJLp2G2
         zXgsmUqMKPU0a0v8/5rZWQEqWIymNp1ihxqmpFW2wVjieYtiXcJ9FSbsZhZw07ULB8Nc
         mC+70lX+1GGWMeIxnSQjaT7JEhqDuHS//AMsFKfwvMB6BdiXQmqiSArKyV0RQG6LCu5D
         P8/Q==
X-Gm-Message-State: AOJu0Yw7/chMCDKqxOFksCjGNiwXfGGPziXDC3PA6HdDHEflr5BXNJUh
	vVYXhd6R2ciK6LvFTBU+SDNCBDuJ8pyCoikjLGl+axthtkt5Yx6i
X-Google-Smtp-Source: AGHT+IFqLotwZ+hQeDo37iliFJZepy3q/2BZbRkjOXY4QBZFo73gskAH5bb0qVTSKR5AWfd6OLrGcA==
X-Received: by 2002:a17:90b:1014:b0:295:f310:efd6 with SMTP id gm20-20020a17090b101400b00295f310efd6mr5231697pjb.43.1706986390968;
        Sat, 03 Feb 2024 10:53:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXhGFw3RCfKea7l4V9sFQec+KG8sGmKcqPuZBoeIDD3LDJwGnGU4R7RYN5Ty9EMkdB10ONC6MN4vn6dE9GENBhkKSbja5TqgQNwLqRbuovwYC41AJFpjEarUOVfSNZaGMGrTEHsPSfiFbaxUrXIhPzNO/wa5I8+KJ2frC37FZrZDbHMqgBR0E37giN09AYX0TWxIqzPgBKZYDmiWhfHnVM=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090adf8100b0028df5c748e4sm2119387pjv.44.2024.02.03.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 10:53:10 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706986388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OZiekaIfpVrKOF3qlNauN16zVWw+/1GjqDEklLmvnts=;
	b=H97NBcnpZQ59hIs5U/nx99cmSh4vblAVkS4yZRJavzuz0qX6V6CYy6vn/R7wctxO8ju9Ql
	oQehq2n+r+IAj0PTYhkGn0st5hFzkmrv5k+Obh3VuBq1MEE1iyrDlaIxVgcAb0fX+6d76L
	DkHb9jM4+UCVTT0eisaM1HdwoR0jVdJ2NojvVOHuY2tEI2QwqLwqukxqok841mTfvzs/hF
	Zrt8+rguJ8HF/Q/rhTMpEdybUUuCgS6bZSElhgZEkKcviiQjLJC15yyvLM6qeMZ+ez0gLu
	KajZ6/8MHRGJxrWMg+JbHJKXsLYmz4XP5OGq91WxayeS7VS5L5r6HaybFMs6kw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] drivers: xen: struct bus_type cleanup
Date: Sat, 03 Feb 2024 15:53:36 -0300
Message-Id: <20240203-bus_cleanup-xen-v1-0-c2f5fe89ed95@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALCLvmUC/x3M0QpAQBBA0V/RPNtasyh+RdJgMKWh3Uht/t3m8
 TzcGyGwFw7QZhE83xLk0IQiz2DaSFc2MicDWiwtWmfGKwzTzqTXaR5WM1NTUY1Yk6sgVafnRZ7
 /2PXv+wGEV5g+YQAAAA==
To: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=DMQ8P/LGJBRCmHwEmxktQacfWtwbjDULAMo73R7wiAQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvoux0PW32SbhsfI597K/NU/w+vQgdmNdCHwJK
 LXOgiyVXqGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6LsQAKCRDJC4p8Y4ZY
 pgXqD/9Hgb+Kr23vOwiCVsyz6tS8SSlJymR+rzt8b+oFSLBUAHPA02/D+eCzFgN5gzQmavvwB3o
 3xtsKg8AUqbZNmLvQSnO7ahHqeevzhRjG8vqgxwOBemczrTzh3H/WublHvK1ojsd0aTLI0AMrUt
 xChU1a/m82yZHHslgQTThr8jHjPOW4cjzReI9o/Xl2hOLuXK78IE+a51ZnY1SUI0W+tP6cE9LU7
 /gSZwEftp4SuL+R9rJrwSfeWbSc2dLxuvf/yNiYITEswhQZCNTfxd9wU/IK85cv2K22W5AMTbsY
 ObdpjtWaZZjAwZrt+VU8B462reAEZxRDiFI51TsiED8p9274RmMDC6MQFwPxpRThDSoIGqhvTdb
 jejuZVSPrIOfWdVEP/ERXcgVDjb0mDkEmeYqQb/5hYrVK/cCqcEcIVrylekfh1iGzj5xqgtffqq
 A0lXEgMFT7OC6FtqcwHtxs5GXUCqNYqmHRoZoy4knRlYeSbeypMG4gIYb++4vaeXNLdqV22T0Sa
 I57ls3glisePCcjL8vs/TNJs0WxMVsyTJje2NqcyibPhNk3ZQW0a+ET+4Bk1MrPFR0r/teZSuBX
 Yji3PGK+IL1jbILrn6vl5DKiftOPm+dQ5PqK08Z7MhhtnNXnUjB1BKC+Gq5cz4MQb38zA4Wlw7N
 +bdOFgxWnlcea8Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      xen: pcpu: make xen_pcpu_subsys const
      xen: balloon: make balloon_subsys const

 drivers/xen/pcpu.c        | 2 +-
 drivers/xen/xen-balloon.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 2d2db7d40254d5fb53b11ebd703cd1ed0c5de7a1
change-id: 20240203-bus_cleanup-xen-da95a6226a35

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


