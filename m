Return-Path: <linux-kernel+bounces-27565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04482F24B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47ACC1F244FD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A146F1CA86;
	Tue, 16 Jan 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LejxPcOi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A31CA82
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705421995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VtfdvXRNB17p3c2PDVPPiJ8T0g2/8Q3uhYEDheCyPqA=;
	b=LejxPcOiFzzZ1/2JvUn98cN0TZGZQ8C9tUMe9DaKcs6WRcEbSct8jDdS3a5myH+AfQuC8x
	09/BbZhN52mGGz0Pl3Ch2yxv6GOFT5iKUyx+w0YsVRCM17EkVyYuqdwaIWUKZNMVhe5H1v
	k8upHfMdq2ltRtJualXenYc2o6BUW3o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-Sjh_dcLCPwCIjArwiTO_Xg-1; Tue, 16 Jan 2024 11:19:53 -0500
X-MC-Unique: Sjh_dcLCPwCIjArwiTO_Xg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-68158f3b169so54436036d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 08:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421993; x=1706026793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtfdvXRNB17p3c2PDVPPiJ8T0g2/8Q3uhYEDheCyPqA=;
        b=vta8eqQs0hNd7s+OvBPgdMiAAFeadS5eOvtXOQyNo1NnL/5JLXQFs/4RyiM7aDRbhR
         tq2fPzLWm5XmzKfTaSQ4ML42DE45xSW+QGvLHf0vGlDga9M8SnSLOW6kAhb7/3rCYkr2
         0xc1vZ2XTpTk9YKLaLlwNpGkmKllzpPhwih7ztLOKz8gz0zof4Ch4RKzotBbtPb9QgoV
         x37dT7No0kZqxQ+0N5GHpgMxosgcUZO0IIptD73LBzF9V8Q5j6GnLyqEHMXcKUTepyRx
         rlqEj7eGulgobWBV/EYs0QAbI+nM/EcGQSXzTQVtssPfpat93RUrD/snVSZ4a1fx4Y0c
         63bQ==
X-Gm-Message-State: AOJu0YzVVMj6HtAa9UbAMDYRZ2duLbZqjoBR+iKfu61WJt0zewG5QSOk
	YCCHdOY5CM5aPzSNoYMC6DJVYAUz9qmoMzyeYVu7MSZN33wYDUIjnb8SepMQGBa2tUm9nhMrrYt
	UjqPYBjJph5uHkh4R7vRTDMSegJmJVAzj
X-Received: by 2002:a05:622a:5ce:b0:429:f4f7:33ee with SMTP id d14-20020a05622a05ce00b00429f4f733eemr3696647qtb.54.1705421993069;
        Tue, 16 Jan 2024 08:19:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENadD0GDBCnyUuQH24uStLAQbwqSZeGZVdRC9IrdFUPT+/XFipqeut+E7wdQxg//leX/Zd8w==
X-Received: by 2002:a05:622a:5ce:b0:429:f4f7:33ee with SMTP id d14-20020a05622a05ce00b00429f4f733eemr3696633qtb.54.1705421992776;
        Tue, 16 Jan 2024 08:19:52 -0800 (PST)
Received: from localhost.localdomain ([151.29.130.8])
        by smtp.gmail.com with ESMTPSA id fd10-20020a05622a4d0a00b00429d3257dd6sm3809166qtb.45.2024.01.16.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 08:19:52 -0800 (PST)
From: Juri Lelli <juri.lelli@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] Fix handling of rescuers affinity
Date: Tue, 16 Jan 2024 17:19:25 +0100
Message-ID: <20240116161929.232885-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Recently I've been pointed at the fact that workqueue rescuers seem not
to follow unbound workqueues cpumask changes. This small series is a
first stab at possibly fixing what I considered to be different from
what I expected (it might very well be the case that my expectations are
wrong :). Long story short, it seems to me that we currently have
several cases where a change of the general unbound cpumask or a change
of the per-workqueue cpumask (for WQ_SYSFS workqueues) is not reflected
into the corresponding rescuer affinity (if a rescuer is present).

In the following:

 Patch 01/04 - Adds debug information to wq_dump.py script so that we
               can more easily check workqueues and rescuers cpumasks
       02/04 - Fixes cpumask discrepancies when rescuers are created
       03/04 - Streamlines behavior of general unbound vs. WQ_SYSFS
               cpumask changes
       04/04 - Makes sure existing rescuers affinity follows their
               workqueue cpumask changes

Please take a look, I'm all for feedback and better understanding of the
details I'm certainly missing.

For additional context, a related discussion can be found at

https://lore.kernel.org/lkml/um77hym4t6zyypfbhwbaeqxpfdzc657oa7vgowdfah7cuctjak@pexots3mfb24/

Branch for testing available at

git@github.com:jlelli/linux.git workqueue/rescuers-cpumask

Best,
Juri

Juri Lelli (4):
  workqueue: Add rescuers printing to wq_dump.py
  kernel/workqueue: Bind rescuer to unbound cpumask for WQ_UNBOUND
  kernel/workqueue: Distinguish between general unbound and WQ_SYSFS
    cpumask changes
  kernel/workqueue: Let rescuers follow unbound wq cpumask changes

 kernel/workqueue.c         | 28 +++++++++++++++++++++-------
 tools/workqueue/wq_dump.py | 29 +++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

-- 
2.43.0


