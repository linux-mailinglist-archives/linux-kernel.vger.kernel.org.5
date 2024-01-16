Return-Path: <linux-kernel+bounces-27646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B782F3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33681C23820
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49C01CD11;
	Tue, 16 Jan 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWWP9Xee"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD31CD04
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428166; cv=none; b=gzIrwaRfRaTo8Yj/JXjqfb+RN1dDSTOLpa12hE3t81R7l6PQgGpELUHfmn2+HE4x6NZRpk67DyI/Qpg/WnkBNFZo5JsrCw5iE+g0tqsTsblTl7ghPEWH6XvrnNDbbQ07IAu5jSrhzImTTJ/tmvyNRtkf2Qawf0BxvBA1cjoWY08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428166; c=relaxed/simple;
	bh=v+fgnWQTOChA4pi9VwdH5nPWSuAGriGecQHcqyESx6M=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=HpJ2GJUHfTpSM2xPm2MjZX4arbK1x0l98HpVTRPP9S3mKmV9XmX9F6LPgQNDjK/VwvTGdrhsy0UIeoz6Mzce/Zfp75RQjYiaV8KajospMgdy2wdyPDoB0yYvNAkXvQWQoMuo9yPI1HbKNihg5XVEtjUK/Dm9vhP8YitXTvKl5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWWP9Xee; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e69b31365so35624995e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705428163; x=1706032963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJYjL6BFiZx8wOeqp8wC0/HJ38flo4v2H9cCLijIwEw=;
        b=pWWP9Xeesl1xc+MhhAozJvZcoZWCCzlNIGuLZhNVKXO+iRqfKXEWOhkAYn3+980RBQ
         HVAHVQ2y5wvFszH6JIjNllpp1c3cf4zizMqlFgwYR6JzxD9Nw9KBzB6ST6fnl8SQ5YRr
         X+dT+ZlXxTjRQS39vdJp30EsAjHfRvBIGQcT5dt6kZaHfs2nXm1g7Xvbck3shB00kSYZ
         sGcmqb+R4NQ3I4bdgxtePmkuHva/Zx/7XF1kCA7Lt1yX+zfs6ciba01HpK57U+HwYskv
         6ufYDe7WUPHHkGniZP6H7F78Y8SaG8k70ZDc6o6oXNX7ryyzJMpPqgEaZk/nz1572viM
         JRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705428163; x=1706032963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJYjL6BFiZx8wOeqp8wC0/HJ38flo4v2H9cCLijIwEw=;
        b=Nq7pxW3X4cJcfJ5nGaeSo9/yfNjwYOaO4Gyp8tCPGUdxbwKaDios0iTuhTYGEEp79z
         kUFjOqj1K/pql8KzbBGtdXwAxlh4GGe7ot3A57Kh0X1Bv5fAW8K5j9Cpy1NfRdR87mXq
         NYnRsYkQXv3ReePQHwv4WcDRdQ/MurQNlXF7tjWC22vZVlRHHqr1eYOiiJIEkC562sf7
         d6EycAk7IU4PNE5IepqjEz7KN7gCZqD/KCSl3rO/hH9hh3y09eNaCqTlOKL/bH7Z/dDI
         EJ0dev3N682ii0lh5MlDWY2gMdONYy0dD1InSZsmvg4/Guzn7ov/eA8YV3LEIrt0jzZt
         UyLQ==
X-Gm-Message-State: AOJu0Yy32mTyrvBieq45t5/J+lYRVJt6MaF7G+vKbi48NRqlpdS6nniD
	E4a+mcpl7FPwLYT+35sGDn8zROCZTGaW3g==
X-Google-Smtp-Source: AGHT+IHIlGi/iw4WjzgSXbEbY139w3f9hyEmdWEV6KFwVMUQEZ3/UJUJ5nsYqadi4KLgH0D4PlKTNw==
X-Received: by 2002:a7b:ca59:0:b0:40e:76f6:9618 with SMTP id m25-20020a7bca59000000b0040e76f69618mr1823538wml.92.1705428163455;
        Tue, 16 Jan 2024 10:02:43 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:b8e8:6736:130:2118])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bce0f000000b0040d23cea7bcsm9012645wmc.1.2024.01.16.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 10:02:42 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	sudeep.holla@arm.co,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linux-kernel@vger.kernel.org
Cc: lukasz.luba@arm.com,
	ionela.voinescu@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] topology: Set capacity_freq_ref in all cases
Date: Tue, 16 Jan 2024 19:02:39 +0100
Message-Id: <20240116180239.408145-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If "capacity-dmips-mhz" is not set, raw_capacity is null and we skip the
normalization step which includes setting per_cpu capacity_freq_ref.
Always register the notifier but skip the capacity normalization if
raw_capacity is null.

Fixes: 9942cb22ea45 ("sched/topology: Add a new arch_scale_freq_ref() method")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/arch_topology.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 5aaa0865625d..2aa0c6425290 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -417,9 +417,6 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	struct cpufreq_policy *policy = data;
 	int cpu;
 
-	if (!raw_capacity)
-		return 0;
-
 	if (val != CPUFREQ_CREATE_POLICY)
 		return 0;
 
@@ -436,9 +433,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	}
 
 	if (cpumask_empty(cpus_to_visit)) {
-		topology_normalize_cpu_scale();
-		schedule_work(&update_topology_flags_work);
-		free_raw_capacity();
+		if (raw_capacity) {
+			topology_normalize_cpu_scale();
+			schedule_work(&update_topology_flags_work);
+			free_raw_capacity();
+		}
 		pr_debug("cpu_capacity: parsing done\n");
 		schedule_work(&parsing_done_work);
 	}
@@ -458,7 +457,7 @@ static int __init register_cpufreq_notifier(void)
 	 * On ACPI-based systems skip registering cpufreq notifier as cpufreq
 	 * information is not needed for cpu capacity initialization.
 	 */
-	if (!acpi_disabled || !raw_capacity)
+	if (!acpi_disabled)
 		return -EINVAL;
 
 	if (!alloc_cpumask_var(&cpus_to_visit, GFP_KERNEL))
-- 
2.34.1


