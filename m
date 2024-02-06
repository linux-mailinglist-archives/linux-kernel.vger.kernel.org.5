Return-Path: <linux-kernel+bounces-54317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909084AD9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EB5286010
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300EF745D1;
	Tue,  6 Feb 2024 04:39:29 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C374E31
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194368; cv=none; b=JqWVokMPvrqpgrXCQC1OOD2/Xa2zNzmzqYD0wiAjK0gDY3IVgza4Q3+6ZI33UvRLnWx/bbHlRgXye3powqUCUyJE91LQHktO3aXdedxSjWkYdCIKG/TgjmEaDptcNM3LhGCkknLg7sDRE+qHd58YYlSZO04vecuZn3HkFwTBLqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194368; c=relaxed/simple;
	bh=a6if2PZZMv87pSjoCr0EWpp2lFjAy5zDMNV8AVihP5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rptoP23BRKKKkTNvX28QFPCknlS7GYsrcy4vrUtjO7Sx8zNXnbFdywIOFOOHK3QrBa0sNt3Qy4DE/e8kskItRZiYfYuS/EyhS+fbTu8veeVoMDP3SCymLvMkzIIRnF2TOY6SVs01QuC19iWVQBPM5S4PX4CIBl+2hnTZs5I130A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42c2998d3a3so9284401cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707194365; x=1707799165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=senmCcpb6oQKScIo1AzI4134P39uh3oHZTUrZk50thA=;
        b=FZDOpE7hnTFoIgkpBAoiVyN1OQqJeitujDnJ7OFoLWX2eUAbhQ1brmZYHU5fDN/p37
         ySdRFn5MXUoZKvM3MOz3jz2dzr15HZLpCJQrpdLAG/3Te/Dwu6E42l2emPcZFhM85RYG
         r3a0lSYrmrJdgdXRpCu4BgY98y+BRZd4xvt078FeVje2xnvp/CXXR2B+Y1C4aYkz5vRn
         1RFV9v9vU7p4tGGCBZSsmI8gkLac0siaWGPdJGf5MQjmKOQXTKkJmHxVQUMffvP44sW6
         3ffUuNiqunpuMnn67Xy1SWJbaMiG/LJ06RSrd2+NGj66A4zYpA+4++/LtOWydLl2ln4C
         5GSA==
X-Gm-Message-State: AOJu0Yz5RB4/X+8pShidk7Qs21osE6M1KIJwRVB/pb1Rzt2tnU3vyk/o
	npx7KlCTaq2TIGv5BWZasQOEcdgyJmnF8OVZ1mFXihfXzA7nQKLzoS4IFa9B8XTXTw==
X-Google-Smtp-Source: AGHT+IGcE05hy3witzdXICUliH26W/tZcut4wGpy6+fD65vQDvAP/2My9Vn+0KLK2YEpJwwxA/esfw==
X-Received: by 2002:a05:622a:8185:b0:42a:a6fd:33e5 with SMTP id jy5-20020a05622a818500b0042aa6fd33e5mr1017027qtb.37.1707194365333;
        Mon, 05 Feb 2024 20:39:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXiB/kM/9k0t9Nc49a9OC7ywE1hrTybRbXH8tEJiyHXa83FenULXEkz/hixYN+adPd8nYLblZ5MMgGV/YQnm5MdkqQJYzDZ3Uw86h6oGgDa+WVK3yLzbQXAI59fUkJq46OlOgHsSnE78yt0Goim4gAaq8edGHqAiPp7KOzzu4GP8ywKXjbC+B1LavxYQQpTn9Zzpn/yoXp6j+8UgVQ8jfRq+hf7OrrEZi6CSuWf+E6mCsfBFFOw9s3XaBS29+LB3FohzaXfyqXIpT6e7DiKt5+e4Rwyd9h0YgIQldHgFueil8DNJxw=
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id f26-20020ac86eda000000b0042a8c890444sm578466qtv.1.2024.02.05.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 20:39:24 -0800 (PST)
From: David Vernet <void@manifault.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	bristot@redhat.com,
	vschneid@redhat.com,
	kernel-team@meta.com
Subject: [PATCH v3 0/3] sched/fair: Simplify and optimize update_sd_pick_busiest()
Date: Mon,  5 Feb 2024 22:39:18 -0600
Message-ID: <20240206043921.850302-1-void@manifault.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

update_sd_pick_busiest() (and its caller) has some room for small
optimizations, and some improvements in readability.

- In update_sd_lb_stats(), we're using a goto to skip a single if check.
  Let's remove the goto and just add another condition to the if.

- In update_sd_pick_busiest(), only update a group_misfit_task group to
  be the busiest if it has strictly more load than the current busiest
  task, rather than >= the load.

- When comparing the current struct sched_group with the yet-busiest
  domain in update_sd_pick_busiest(), if the two groups have the same
  group type, we're currently doing a bit of unnecessary work for any
  group >= group_misfit_task. We're comparing the two groups, and then
  returning only if false (the group in question is not the busiest).
  Othewise, we break, do an extra unnecessary conditional check that's
  vacuously false for any group type > group_fully_busy, and then always
  return true. This patch series has us instead simply return directly
  in the switch statement, saving some bytes in load_balance().

---

v1: https://lore.kernel.org/lkml/20240202070216.2238392-1-void@manifault.com/
v2: https://lore.kernel.org/all/20240204044618.46100-1-void@manifault.com/

v2 -> v3:
- Add Vincent's Reviewed-by tags
- Fix stale commit summary sentence (Vincent)

v1 -> v2 changes:

- Split the patch series into separate patches (Valentin)
- Update the group_misfit_task busiest check to use strict inequality

David Vernet (3):
  sched/fair: Remove unnecessary goto in update_sd_lb_stats()
  sched/fair: Do strict inequality check for busiest misfit task group
  sched/fair: Simplify some logic in update_sd_pick_busiest()

 kernel/sched/fair.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

-- 
2.43.0


