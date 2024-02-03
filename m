Return-Path: <linux-kernel+bounces-51149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3BA84871F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3B6285887
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7F5F552;
	Sat,  3 Feb 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="BOmXPGat"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0815F47B;
	Sat,  3 Feb 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706974317; cv=none; b=uo7CZufRMgTfmJfr88rd/wNjQGJlqhlPT6evU0BFoKsn/2nxKcM2xMCQhr1XNhAifsR/8j6xFQztoSwKu+s2ywtY+Otj8AgowK62al8K+LTHx2dbuApngJWxCOC4hwPzgXPIMgDSKQK51vw8dggXZWoybJo0gw9GHL7oMRhp8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706974317; c=relaxed/simple;
	bh=YSZsrBNc4lkUfiRW88bNuQMEiyztwov5LMvAYeDsszk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=suggvUi9R6wJ1q2vHvP/jQfVG/941E0Iji2PqZ8WO32H3AyrS4bL0yjlLvQUmBrY6sglKWYiYnFGp+9peVerZV3d9CynPGPWTUbFqfw+UoJD57DlesusAHWv2qxP8N8XST/vyT+vLa86zXg7OKiGwViR82AT8wb65hC9y39MO80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=BOmXPGat reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2415447a12.3;
        Sat, 03 Feb 2024 07:31:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706974314; x=1707579114;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EfEAya2Po/NTpzjg18kA111lBWjJucJyUKngKegUbBU=;
        b=Ih5a05UY7Eim0kvapUHq0Ub8n5pdKpiFTedFm1TThGQwBVyk9GKNISQcp/xszo2HLs
         SVqPX5bafX12vOLdWsayEF1J3IwalYkc+PjMiPBep8tuM6IXRAc9s9R7YzyedIwbRMMe
         KbsD3oUZDij1DCJ3L/S+wj4r0VAf+yRF5c39pfL7ynUEimWLp5V8Nm1thW5iuVfv0hhA
         1pbaWW6M6qnH0VzQlq2+J4N5t6Vq4P6u7qMFxUdcxmqH1S+trc/9w3WEt2Y4VyZREPIg
         578cOSccQDmjyqKKO+PHjIWhPiWTBoUIE6fZos3Qivkq5kkUOOS1FgDtAWBmM+lc44vi
         DOlg==
X-Gm-Message-State: AOJu0YyrPMoDVztYutnWl1+zXh96S3J/Tj8R1qUrgYBA29EhreKN1oHW
	roXImY/0O+lmE0SRiBHoqzyA3Fa8XCdPd4jejglp6r+fZfohAb7tR7QLAHEm0pLJfw==
X-Google-Smtp-Source: AGHT+IECdtNfRCSA3EcS8wa75aIpomiY9JafyCrxU9ezFA/RY/KaPzjFlQup91n7A5XiyE1P7P/NhQ==
X-Received: by 2002:a17:902:be07:b0:1d8:ed67:c360 with SMTP id r7-20020a170902be0700b001d8ed67c360mr9261873pls.65.1706974314326;
        Sat, 03 Feb 2024 07:31:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWs7cjf5YC7ZgY/ZV3UzOQRLKa5NjYeTt3NXigxIDEuY3+4jff8eWrsDZcQpMOrOEqSEX4fIu6ZBHgAZeQTT4mu0oyGo49x5/3glhxLzeOlSJnU4ds3SHwP3H+705m3ypjEno/EkXLHJOsUuuke4LyaoqgHfyJtZG/gP/AFNwaq0r+BGQQVmcsPGWJ+wlG/AoZW+z41rUtt0VWNJ5iTP4r2Ts+IBr9YOznOF4GonU/yU+Fgf3RYMSub4V3yFKQa
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001d8f81ecebesm3353636plg.192.2024.02.03.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:31:53 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706974312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EfEAya2Po/NTpzjg18kA111lBWjJucJyUKngKegUbBU=;
	b=BOmXPGatoiVZEN5RMjCaJryHndwzJ61dwBsEF1iytQppuFwb6cbfpSY0MM7RBUyM5I1Oad
	0KFzOrNMTqLbDYIU/+CfACYEpYV+2EJ9K99nQu9e+BF+m0riDXLRuC4gyVdk9otRd94KDo
	A6Sc2tfqz57OJv6VXtHuagDxOj3s6+OFNPXvoomK5wmDMysRM4LXcWSFSYZxsCYTB1lI0a
	g0Ub61/OJ0eHT3Rl8zhI/88UOazsjZI4fAuz8gEdF7+qQssiLH8GHChreGA/+TpUIBow/b
	B0XntgsV3Us7FfaRerhH7Fh3TfnO3hsWMNucU3xQRaoisNRinW1DYtVaCKzxKw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/2] drivers: media: struct bus_type cleanup
Date: Sat, 03 Feb 2024 12:31:25 -0300
Message-Id: <20240203-bus_cleanup-media-v1-0-33e8feeab912@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1cvmUC/x3MQQqAIBRF0a3IHyeYVoO2EhFWz/pQFkoRhHtPG
 p7BvS9FBEakVrwUcHPkw2eUhaBptX6B5DmbtNKV0srI8YrDtMH665Q7ZrZSAQ2M0Q6uptydAY6
 f/9n1KX1xWMuPYwAAAA==
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=YSZsrBNc4lkUfiRW88bNuQMEiyztwov5LMvAYeDsszk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlyDz2NvgyjwFsEn7QGhyvd/HeOP67s39xmMF
 BQsgLNgSA6JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5cgwAKCRDJC4p8Y4ZY
 pkWyEACwAQmWU3sp/UQX+qvsVBloMSCedQe/0BjmYBwnUDLy03hpqcJPhHKvfB5qJ5o+Hj6Tl14
 fx3EpmVRx6ow2bl/BFZ5KtVBgNv2Uzho6sxvAkoNhVpYI3P/WZjVjNqbe4NnARyIqvOliCslpwA
 p5yv5nt7NCCggFlovsmKTMdGO2aDDD1CXNDhB2IVkgowVwpYaONqUHMU/dIWRziVEhy/gJnsWl8
 fBIao9MMsdkn0dYH3/vMWIIJk4t1oQTym/zr5LsEdU7JM1f3Clkoi0Lpg1e7Te9gSnT426mYwiA
 TkWjt1oIuz5x2h46MHiijHNay72YCKgVmlor2nqpjeStgApCgu3/GOQJn2aE+ppD3Y1EWgldqaQ
 jq0wQ5uw7iHQKo/mu0uF/UaNJl0h/R3D/bIlJOHyHiOT8dajeRbSbBiOhtPpw5v+CiZsCa6DM5/
 qRHTOTipIfaPZcG+xskErOpFS9hm2E0wIpwcESkjV91iOgsIOK6QE4dC7sGXuRnKYmeeBxXTq5d
 +9fIP4ofHQnpY9rYvoswRn09M14a3DDPUyzBEp/W1S86Dc+/T+o0/+XtVLHOqiqjJIN7hbeZdfk
 ZpC9WTy0GPiBCR2AJGPZcLq07nnCkkBc/1d46lOViLyctwMRV6AdplqyLLGNOidqazXKc72lPiO
 399mVj8DJtDtMEw==
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
      media: cec: make cec_bus_type const
      media: media-devnode: make media_bus_type const

 drivers/media/cec/core/cec-core.c | 2 +-
 drivers/media/mc/mc-devnode.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240203-bus_cleanup-media-0ee6e332fef5

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


