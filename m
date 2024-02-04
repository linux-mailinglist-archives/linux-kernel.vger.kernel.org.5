Return-Path: <linux-kernel+bounces-51778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455D848F32
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59A92824EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B622EF6;
	Sun,  4 Feb 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="m/PjIpdF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD822EEB
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063697; cv=none; b=PdarmNZ3HeBLuqlvVLzw4lVD8SxWWVPFR/gR0G8v7FCCIh4vdTQU+DsdbrbNlUB9Ato0ylp+S5anskb4spP8Nh7Gc541tK2VGPV24mufXF0cxj9DvGLhonX6P2NUjI0mxXWLMnoXi0mmIdXVDS8OukxkG0Kj6Syoh+rJgwrJ/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063697; c=relaxed/simple;
	bh=f4g0B6Kx2qQGDzj5TKbHojILvQvjrOvj4uV5u0fl+gA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=m00ckrI+J12nOYmMqd0L4tkEFmIV6R8Ktux3bzWMeOXf+foxN2XOW75o4Auhi7Tkgv2Zh2s9qcyn4ivWP/vXpeWENT1bRPllr2+N8+hoKOK8mEWsixnp9Rg2eWpB58Sb8vqd44xOPmpUKGQj4FyFWKCB5+3zwudDLhVLLgvKziA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=m/PjIpdF reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d91397bd22so27810105ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:21:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707063695; x=1707668495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBRzpZmKL8Mxt7wTIYbgyOd2f41J7zTkgClkvdrUgBI=;
        b=FGS51/u7598BxuJHP/1P14HbqLj+DZTALz69y0tnY7LxFXZraHMECWF9cnUEuZUsd9
         ThiT75VO+ZY2UrOZTlyBoYMs/JTPK12JApnpAWNt2kLCF9qQ2q+nPNVqXSst5lpe02nY
         f6l4n/qSpxZuyMEqtW1RCnWou+DdnoznpndrZ7J16Om4zDLPwv9ZPgenATbEgXhe1tZW
         CY5mFmIdjgGGZ4QCSpBxdmgvWecvNJYzXqqmZGtf9dd9wbvA2eyla18kQ5eFw6ghRPG3
         6w1vZYeNcYrqaZeuV+cFW3CR+en/gPuRYHCFee4GiRNqwQIY1s5vuRy3bdqV5CNQ6zix
         Hh1Q==
X-Gm-Message-State: AOJu0Yx05mKMq9kDkbQK7Ei7csOEhHQO5aiJzZa1DHzFm4NYufi6kK5n
	xsizNsuSG4xkSqUOF34+2/51RNskmZ5N2uFDFfBv/P8melT06E1U
X-Google-Smtp-Source: AGHT+IHfb/BjK97UTB84A52DmVrV+RJKQoJzm39ZyQgxGFSCxyv0EkXXrBhHVqWHX8b1MiQ8Mww/rg==
X-Received: by 2002:a17:903:234f:b0:1d9:751f:3746 with SMTP id c15-20020a170903234f00b001d9751f3746mr7302939plh.49.1707063695590;
        Sun, 04 Feb 2024 08:21:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUaT2/SLJxNaPG0manu9DD4yvECh8wmyfxLIiTqRm8wM2tKN9AFWiY1Pf3Sg0d4dBe9bzj8j4+SYB4x1PE9lWh4GCf01Hkfap94kOg0zGRZ/U4Fdw8WHHnjMCGtpTaLfSG5vu7hXwDa+N7SVKAlMZniHwyF8lOIguip9fZ3xmUJxyxnDcjVduplErRs00TZczp1
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170902fa8700b001d95a6afbc2sm4743979plb.244.2024.02.04.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:21:34 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707063693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TBRzpZmKL8Mxt7wTIYbgyOd2f41J7zTkgClkvdrUgBI=;
	b=m/PjIpdFgLg9xRMmEHpAB9P0saMwGW0iHVmvYgOGJWSV+VdFuHOLq0qTxNELUJUSu8yCN6
	Fk4WGkMXqft4IT0QHwQ0xMBvC0BCzitBs9rKdT+UjLuCcru9wbC8i9/FE3ts5tMUxjiJtF
	Mjc3Ho+PhPSNRin9H5LgBfZokLSMMNssJ7J6mwUFwxv5l+zbIkBI067vHpaYG7zO3Yt6jM
	SCLqRmUeNr25rLmAktLLmIlQ6neT4EEhAK2hO0PQQ8tZLDYcYpVTMI8dN9NBUqjsvVJzNs
	nb3Pqc7W2rkIbpBQDbAAP4vowLAw3KCDYz/U5EODMm25A/s+iTeakYfjnvrG9w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] ntb: struct bus_type cleanup
Date: Sun, 04 Feb 2024 13:21:59 -0300
Message-Id: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKe5v2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3bySJF0zA2MLAzOT1BRDSwsloK6CotS0zAq
 widGxtbUAchfht2EAAAA=
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=f4g0B6Kx2qQGDzj5TKbHojILvQvjrOvj4uV5u0fl+gA=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7mr7gxg5DQZzX8XNHIVBQEsvx/AaYi6n9YVO
 w/ybG2AhBiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+5qwAKCRDJC4p8Y4ZY
 pkfbD/9W9vgwj6e7LA+r1b25ETLhICLFPoO/VNAD8QmoScmiadlsBFGUwkwc5MlJpVjMIIEgOrd
 7m93y2eiBKBDB3+M+KnsGZP6/7Twpib38TnddXPIfEm0ltVLYy2MwxOioPIQoeypPpJyf+2Y/J/
 tFzK+tYMgYvSiKsbekkcohh0ViCj8glpoDWcWSoBAXM1hRrWPl4V5x7SkIfFUCB5VduNZ7BrmDw
 xScJrDxIh8olPQsVXHoXUtQhIRKIhLBbeghOK9YnUq+V63hCuZM8ZPNBFrO0v4UGxXU/IvzZw6r
 QFxeW6a7K4dKC29F/g/lcAR0IPHFcEhjhpj5DnU9KyBPNkIspq0YRfgeynwWSlrfW9id/93FUFI
 uWoEL1WLw09je+6PZDLUQalWMk6rlfGvnMl8OI0ZuhDkMZxD012nbyL4MJVv0sM5jYe9IRrARsR
 I/ke7ZH4CidgkmprT8qMed7bbQ9c2/6kIx5ixW7ro4FwZxEiRLwWUFIvMeBkbz7ikdWtc/zd9uX
 dbJVAdEeD9806OROmyoeK9cBz3OjshMtsjsF1MoESDMIhWuUvcuP9McL0mehzVa4PKpS0QQdM6t
 33u92RZVoPlA+hIxO7St2M2tXb4dE9D4JEe37xkp4chyVLkCqljIU9ITCJAWQWK6DVpQKtHFKUB
 Ela6RpZlHnjEiaw==
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
      ntb: ntb_transport: make ntb_transport_bus const
      ntb: core: make ntb_bus const

 drivers/ntb/core.c          | 4 ++--
 drivers/ntb/ntb_transport.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 9341b37ec17a8793e8439e9b18354ba69556b786
change-id: 20240204-bus_cleanup-ntb-6038064ed198

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


