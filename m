Return-Path: <linux-kernel+bounces-51263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788A8848871
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 181E31F229DC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226FB5FDB9;
	Sat,  3 Feb 2024 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="gXfiWVzv"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FD15F867;
	Sat,  3 Feb 2024 19:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987675; cv=none; b=qr4bLKnEvIc+pdejPkdPt2TmCTGmTEm4amt3ZFmHs/CD3AFYWhqxNwB3BVLCG0RrxSpYPAvoqwL1oEg1RTAe7SF2dln0f6fN1e+bX0cgKogAXg5dsS+wuymBUR2AMNd2qJRKlxikUoQGJZPqqSjGT3BhZuHmhX4YCdNRoPpFrp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987675; c=relaxed/simple;
	bh=26n2wDOI+AnTt4d95yFKZbwl5d5B9VOn9T7RBM7iLFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ksEzkRzX2jLGCkKEgPEo5YRuif0ychIe7MaffJLKSIaNUnEK7UmuQlNBMxZdNgeHOUxY2S+fsrhECM/WywhOsGQs2gAFczGWkwWP1azWLrv0rFK4YM+v4DuapM2Av34IH5ME1xDLDL10qnRrpDWwzQE1hxsiGzpG8BWSWeVG8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=gXfiWVzv reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363890b20dfso12633865ab.2;
        Sat, 03 Feb 2024 11:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706987673; x=1707592473;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=trpSR/SMHy6euCOyEqDbId3cuSXXzCOrIO/s9NSPmMU=;
        b=JzaW1vwaIzVpFv/QUBEDAfULujleSKfLr3tTNwUpEP75SojQPNzgJZSqHMA4qzdmZl
         +CHyZRuw+pNuVZpE8AjgxwLN30g7ZfyaVkKcVXmv59JJGQEA1uUywL+V6pfupAXz0gNY
         XpTtEkimYmt6C6Nrv9jzeVrxdY6QoS6QayS9pPsHm50dSyt+AYaZ0VIwKZRmFefYMtjG
         FDaBqcIji96SXvW3soAe4IX2ovNSJxpbYlur0uXjxRaFLn1G33n3NbuRMrNmR7uayUyS
         4lRaj2GPuzMoKl426CVXVTY27caCoVcQp/uWH9Gy5QPHY69Rj/inVwcYjHeiTXeH77f1
         /AhA==
X-Gm-Message-State: AOJu0YxJpI8wU/lWhkcwtjfxzBErg/OYKjEa6GwgW65eBBaqnrUBN/NE
	/+Vx1wJZOrX1GUcfHu84y7vcd+8X59gWTLZcLdg6KqQUARVAtsxA
X-Google-Smtp-Source: AGHT+IEaz/no1SkqUx7Hl/PpO1AZUWZHzkoyp+/H3BN4Zini+Zn6oh6SMpp/W+PKrNGRxpQQwYQZPg==
X-Received: by 2002:a92:c14c:0:b0:363:ad00:106d with SMTP id b12-20020a92c14c000000b00363ad00106dmr6384127ilh.4.1706987672810;
        Sat, 03 Feb 2024 11:14:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV28A2SFe/KlYb57G09Zf+0/ybKX1QVVvEkGp+Lr1Th7/Nr2swaOmig3mOQKTb3C/sDN8IXO1JO/YaTvphK3RIRpne9sfERQU7rdbORwzZMh5zjtqDR24+ncsQfQytsY/SerQkNckPDbpjy1+5QY5QPE9XOwMUwa7YBo8E/X1E=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id a19-20020a63cd53000000b005d6c208fbd2sm3568432pgj.35.2024.02.03.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 11:14:32 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706987670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=trpSR/SMHy6euCOyEqDbId3cuSXXzCOrIO/s9NSPmMU=;
	b=gXfiWVzvcq+jMG+PY2rcjb2igyT2CStMSBWWdODnGsyHJ46WOF0T2JLgIL0qJmG9rcG5I7
	9dM+MLUSe2v0YVOcVZZDlbSkaMehd7J0bgnFtIyda9ziBwo/YPP139Vy88PX7Ppm7AoF/v
	uNf5Nt8Ci0OnDhx+WIWm68NnZEv6tkRu9wLY9iB4b6CJvuquxMislJCHO2hb+7xx3a4tih
	kzDx62G7Zm/GlRAVWgl5gg73CwXtmU0sXRUXmbjf0FOmK0fCvCpCpgD75nTaajR0ErDYSS
	rrSZdhhkB8iNQy8Ip2wLjYdaCsoqdJNT2WbImGuHMGA9t8Q5pKa6E23XV6oapQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] drivers: tty: struct bus_type cleanup
Date: Sat, 03 Feb 2024 16:14:49 -0300
Message-Id: <20240203-bus_cleanup-tty-v1-0-86b698c82efe@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmQvmUC/x3MQQqAIBBA0avErBN0khZdJSJMxxoIC60opLsnL
 d/i/wyJIlOCrsoQ6eLEWyhQdQV2MWEmwa4YUKKWKBsxnWm0K5lw7uI4HqG0bJVTHj0aKNUeyfP
 9H/vhfT+PenV5YQAAAA==
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=26n2wDOI+AnTt4d95yFKZbwl5d5B9VOn9T7RBM7iLFA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvpCzakPvRaeVx0/7hNimiKunBZOiW7aA+oKBv
 MmDx+drc2mJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb6QswAKCRDJC4p8Y4ZY
 pg2hD/9t18eCd5axwCJiGv4u6CeO6M1WhPE3/JDcPXrRy9JQjIpTblkO39qX6l3VjVSuYDNRCTJ
 Cfd0Zmdo1z0mbtuOXYLbSEJtoyMi9cf7ldLTTuWs3hToHYuUnlhBYBPfAPwVn4iGg/uoFX5Pg51
 S1HyqXLOvgJeqgbO1BT+fQIDfD2pJNvh3xwhgZY452RmW9loOIQlSx0TJy1nRqje/kRB+AxYd3C
 4aZVvuyNlFrQCRFQ7RDKrhiMhsSF0uDdPBB4XuQU3axfM0vSO5bzbp63GB3ALtb5+jx1CjzzWkn
 vvdvIB0QEpfwE5jkJeqoHGDryiZAIN4R0o8kgFqdcTlxvHCN1afkaNgL967OfaCvtEkDEZvlVQ3
 pswEXkPefSzU64SCAtQ0G1e1a0g6d+2vUeuzo217tHfh932rVMSD4CX+G0CjryfQrBxLoSlTiUW
 OGT6o5aHryPw+x/2a6NNzRA9IDsOBzaW/V+j2kazQd5+ZqyM6LpGQ7aWVTSBQKSQ7AWFTBDwXbi
 pOZ2I6fPpZq55ztClmq8kIclXjQzmAjvimWFurn0YPeBeLtwLeWXhnuMW1LWeRsiywYAr5/mluT
 kiRYj3BdcBWd6UWPS+P9ufArpWpVbX0KQFM3weIab+vED7UyXZVorW+wZGstZ+VFAB3NCBrEHl9
 ANORTyrl2qiNHlg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (2):
      serdev: make serdev_bus_type const
      serial: core: make serial_base_bus_type const

 drivers/tty/serdev/core.c            | 2 +-
 drivers/tty/serial/serial_base_bus.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: fccc9d9233f918ee50cf2955ae7134a7f3418351
change-id: 20240203-bus_cleanup-tty-14061d1f2f2a

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


