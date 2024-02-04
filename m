Return-Path: <linux-kernel+bounces-51696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 699FF848E59
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CD51C214EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFF1225CD;
	Sun,  4 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="iP//cYTz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB7225A9
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056498; cv=none; b=GX9oEUyz+p1/cFvHmB3W3U4C860Xg2rlkEfwHJovLOTEgbidRol0sXoCaWRbSj/4D+SblyJIUgINKhsmUD0nveNRgx3aohk7J3yKZuS6qJH2nyMZfODf9HLVCWCo/Ur90h5IvjXQaxyhbjE679Bv8fUbWnXhF941b5gwxtfuiFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056498; c=relaxed/simple;
	bh=iahNaCAw9x35B3s1XY/K+RpDIjbPDPVEVSA4vTRhVu8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sosv3BMvfPJjth7+9eAf2EwpmxVYytJCBLpx1fnNbE8eOZ8TeUkyOlVV3xvoC+pGrsOCEknmTZtgskjcNBWiMPWFUGH2zHYWlvWjMdE13yXh0NiM72ZwJRxWMvDDqm+3nDVr1NGy+6xb82aZ0/YoQDtMg/nkkjbGru5+7QMhSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=iP//cYTz reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d73066880eso31460285ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056496; x=1707661296;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UyoXp/8QYdgxWLoRQB6OIS41/J+8oPM3qkFDqrn6KSQ=;
        b=tKir2t8KW+VctO7RMod5TLNemhIQuXHrEB7HEnbY/gpcZPMRlAhipaZat4Z6n4s5W5
         l6zXl4vPDKfNslGJbE+EjmDuX4OfC9Je89gCgTwaLGUgupaqzhlb7zcmr59BR4DWdgM+
         T1KmjpnXI1tfgUUc6KfVYtBnt3rOYnQnfLTmU8U9fTJz/H1JcFxfgg/4XeTWEEL0azbu
         kO3+b/kXUng9fllAJUlMzINXdFiO94j//WsF0aHMJxo5UPTLWW6VKLWYk2j0yrPwbudT
         p2igavf/npmDwP00Pr9yK+OvTfWIFaRgsGajtvyKqGbKrr+dRezXxeOCTp1bfRWIWj+r
         VIvA==
X-Gm-Message-State: AOJu0YxVzwqBXLF8wtezVd8ITEhHxJtaX8BiDV+wDxHQO8lsORF5M2KX
	FxNtdpb/zM2ahH/cfltOw5d2ersiaSFE1Qw+6ki6oifzPCVOCEfP
X-Google-Smtp-Source: AGHT+IH0NjA6VU+9PQZ5WKP9L2fAgDWu6h5Yb7luZQCwoVBPRIfE3fYTikWLmB64G8Z2QFGaoCs2Wg==
X-Received: by 2002:a17:902:c412:b0:1d8:f202:2e26 with SMTP id k18-20020a170902c41200b001d8f2022e26mr17817888plk.48.1707056495788;
        Sun, 04 Feb 2024 06:21:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWIZR+/JPp+Rkl4I9agNPvayvxHEANuaQ0k/CTuOylfTj5besd8eLl9iwqRb2Po4rZNpgT6jcuxVyYEgmIxepk+0bHeTEDmGPsRcmyu8xnz8gsZcWcJE7zDFGf5mVSKvsEC3ZGWXeQanUiPpHx6jfl/BsnjJ5WR2JENa6dStvnfkxY7sU+uYZ73cVYjX58awIpKkEIhiK9gIUUX9YOnFGUIFvgWfnu6Acm6PX4CC8l4yEHxSodv2n+EebepuNe+b/4U
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id je5-20020a170903264500b001d8a80cbb15sm4569808plb.238.2024.02.04.06.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:21:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707056493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UyoXp/8QYdgxWLoRQB6OIS41/J+8oPM3qkFDqrn6KSQ=;
	b=iP//cYTz2EBlm4D/IAmcu3Gb2J+ahsv8JdtKZ/rfCw+lxxatjUX2RAr/mpjnUa7CevcUlY
	vgJQtVvheyzNt69dAKlkrL1HIsVVvf9clf04u+k55NeMBGkedWFZc6PyuOkvLQKzRH1w4N
	gfYnKEiQ5S0YZikSRdIm64gNk+DU++2IBu+vt9kFomKYaluLSvzASS1PLT8rCu55CNntiw
	Ryt4BmWMItgtrk2fjmUdQIPGawMFPwOz3wBCgHImYJ/slfIvZz031aVIGGC1hrMXs6wu/a
	49eUiaIAGvHHWxI9pP/4kwOAqzPtUpwnDWRQzp7xoI1wzcejJojTGaZP9lm4wA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/4] powerpc: struct bus_type cleanup
Date: Sun, 04 Feb 2024 11:21:54 -0300
Message-Id: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKdv2UC/x3MTQqAIBBA4avErBNsKIquEhE2jTUQJko/IN09a
 fkt3ksQOQhH6IsEgS+JcriMqiyANuNWVrJkA2qsNepazWecaGfjTq/8cXPwpFrUhO3S2aohyKU
 PbOX5r8P4vh/yveOqZQAAAA==
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=iahNaCAw9x35B3s1XY/K+RpDIjbPDPVEVSA4vTRhVu8=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv52ILOpbsRHWiEOk3oWovwY2gvTTp4p2xo3mX
 YJ1akfIwluJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+diAAKCRDJC4p8Y4ZY
 plOhEACmO2ogmhmLilOE6SHmErWs/7G0IDnQjLIcD5osz6jC6KJHOtXnVZxVabtuB6tDpkhGAjH
 eheA7iVVxFDv2NK4nR6zPxahrFHYO5AtSFFgQLexzpxg4P6hHIPhWVpsbsxMaYkkaIxrFIUYtgp
 40IuW50a7LjaBI1DdO8hlpBp5f8iVLJzp1JGenIu8xSUlMbFMHHzT/7g9UJTKvrj1sgEuKQ8A0q
 q8Oi3eXEC2L6yjALkMnkFeexEJiLwN7rKZ6AqrnrLjNnW93DB+5v2J1xG5sfBtY46PPcXu9onFh
 j0ArD46z78eQj4ki4K4v8PcisEtRPxkgrjsWJCMbUQyKa6ItrnSx8RUjfJweApBWg0Sh8NVBOZr
 wmV+rroOw58ndS6pr5EZLLhflo8OtS4oLuZ4FiMpx1Hui41zT8oCVKXx9Ze/wYRvTIeLAo90TEX
 5aM00mwnQ09Lnfv+vHOHN7glfo4Az5yxQfN0CVj5wPXbe4JBvYTEYvhtfIM96LtgpF45T7zAJOQ
 FZQOk/POgA0Rfajki8r5He7tzac5jqNoa4oHoFYOk8tJISa3QCCBtDjtx8fGw7QMaGHsDanvF8t
 KIavvsBf6DQpds0/QbI33yf9n967xEBhpfk+/cOn+qKcDkmYrIhbIaY2qeCvi+8mwvPTwcQEpOT
 7uMsnof/Z4Q/Thg==
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
Ricardo B. Marliere (4):
      powerpc: cell: make spu_subsys const
      powerpc: ps3: make ps3_system_bus_type const
      powerpc: pseries: make cmm_subsys const
      powerpc: pseries: make suspend_subsys const

 arch/powerpc/platforms/cell/spu_base.c   | 2 +-
 arch/powerpc/platforms/ps3/system-bus.c  | 2 +-
 arch/powerpc/platforms/pseries/cmm.c     | 2 +-
 arch/powerpc/platforms/pseries/suspend.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 44a1aad2fe6c10bfe0589d8047057b10a4c18a19
change-id: 20240204-bus_cleanup-powerpc-720c27d8f15c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


