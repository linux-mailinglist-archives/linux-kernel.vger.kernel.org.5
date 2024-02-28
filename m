Return-Path: <linux-kernel+bounces-85307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C0486B3DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469E9B230AB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA9E15D5B4;
	Wed, 28 Feb 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWThLdHv"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7E315C8;
	Wed, 28 Feb 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709135789; cv=none; b=roSEb85+F1Hw4TbY2E70oP2k6PyBD5b/899+l2dlcLg/9bzIEAhIhL7AJB0p859o7QNrNzk+t9uk6zt8TkYtwpFVZgih0OUSxWgOESsVp1dKBz1VxBLPh1LmFy97ngrxoWaAIEgDyizIGCJ7anKeujU47qYXooFSFi15rO1bT04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709135789; c=relaxed/simple;
	bh=4oMFZxzX5PZA/M9VG2s4kgB/DZ8GhzCcWfCzEPQkVt8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IUE3h+U2OoP9nookdLwWvwFenoXQ4vWHu2qH+xc1cu297DzP8C1QC0kovcyks772kIj30fxzeZJoeURm2yDEiW2SH1hqZ/FKroGnK+51qRyz7Jg+h9NkJLB7QjjCXXywe2KSbW+ZG8UUBNlB8fz/qyj8K8wdzYct8XwTuUIf7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWThLdHv; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23114b19dso79799881fa.3;
        Wed, 28 Feb 2024 07:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709135786; x=1709740586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Zr38ZfbAtVyJs0WSKTX26b9HT0iMoobWLC4JSkjjuk=;
        b=OWThLdHvZEMmIBUxwa6IzIM3BmDlh4d6EX53fDo3MdYEzcI/MXMJktHTmmnHOGvKJX
         7su4Npcr1QjY0c+sjz9t8s0vsUMPhp7i90YuqnnrpNbakxFGWLBrol0h0WGTUGvJznpS
         gcd409oWO7emaMpHCzHXWGAB8RJZZrf5BvCUjrTQtUaKsn+QMjRQnJc4BPF4QUxhNAqC
         occ7aug2KfEFekVXVLsV+HOrvk7NAvic0DXflkJrptxR80WuvnKd4I05YwoIyKIA0bmA
         mahZHU9rcFNrCQ3FNhTnQjHNbAmJ0Y7Xsf9v7hXmVfkiokVuVYid17pUrceFucaede9m
         VsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709135786; x=1709740586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Zr38ZfbAtVyJs0WSKTX26b9HT0iMoobWLC4JSkjjuk=;
        b=OfJWXkwlv+7qAvAlsacvey1cL/mHJ43qI1DyKjTrWQ5Z3pGcFmH5tsPDx641Nu60zm
         g0FZnqgBEqPq3CF8vxuHoUaJsRYn9Jm3nzwBcEarM1UH70JJ6ikmnyBKHyfIWgAmgiPP
         MEdSomY00VjA568jQoMwCmvpTkj9k3CAt5a/ua5dLa7QtNXarxs5R+XrMXCFRG5Js8tx
         vg3VsjLZkfP+imSREJq+1epRNNRyPsab3tQ9zpVLExIk/nTyLmA6rtyjPUPuHxOIBXEY
         xnXhlGXbYEJjTtiVR9IJCqqPfFqjk+YSBm6dInIyKZpp03PtQ7XcjfQefKxoQxjuOx/A
         G93Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHmv/u5jh1RcQuD+OaKRf3v2UalfOJBgA6PJ3ntdEL5CsKZQn6PFQApIKdoomkbNj9UpKdyFl5dDaWFIuYWXFuXZ0rchnddKuB5XCCde+3PTb96v6+TXjmDJogtZvvcbA9Tiy8
X-Gm-Message-State: AOJu0YwPra0Vnd4CHi0byVAe2dIAC4M1hBKZ1S4VsYHz7hk+GTN6vDqj
	G4oerFfjFT/4w9QxF0ths8j5zRV4NdkXnYouiHRvwsK+JPvUt7gEuLeLEHXesQnyFg==
X-Google-Smtp-Source: AGHT+IFNobqy9dV9FmZ8nJcVhIZ7gSPgpm3c1uQL5miWa0hstEvZcs9iBhGYN77ZysQDhJVYR3TbGA==
X-Received: by 2002:a2e:a716:0:b0:2d2:e554:976 with SMTP id s22-20020a2ea716000000b002d2e5540976mr351159lje.14.1709135785839;
        Wed, 28 Feb 2024 07:56:25 -0800 (PST)
Received: from rand-ubuntu-development.dl.local (mail.confident.ru. [85.114.29.218])
        by smtp.gmail.com with ESMTPSA id e1-20020a2e8ec1000000b002d2d8d2ee45sm164863ljl.12.2024.02.28.07.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:56:25 -0800 (PST)
From: Rand Deeb <rand.sec96@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	voskresenski.stanislav@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH] net: ice: Fix potential NULL pointer dereference in ice_bridge_setlink()
Date: Wed, 28 Feb 2024 18:54:48 +0300
Message-Id: <20240228155448.121603-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ice_bridge_setlink() may encounter a NULL pointer dereference
if nlmsg_find_attr() returns NULL and br_spec is dereferenced subsequently
in nla_for_each_nested(). To address this issue, add a check to ensure that
br_spec is not NULL before proceeding with the nested attribute iteration.

Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4f0d63fa5709..ba2bbd53d543 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6530,6 +6530,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
 	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
+	if (!br_spec)
+		return -EINVAL;
 
 	nla_for_each_nested(attr, br_spec, rem) {
 		__u16 mode;
-- 
2.34.1


