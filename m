Return-Path: <linux-kernel+bounces-80110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8B3862ADE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8B1C20DBC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5213FFC;
	Sun, 25 Feb 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKjhkt8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF119134A5
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708873202; cv=none; b=Tf9tARiuLf0bd02UpGqsGVis5QXkk1Nf6qCqmtDCZynExq02P75aczb72Uik/PK017rJZ5Cin8dBlr+hIla8VNEDwGvYVgNAPWuXi0h91XIjd6/SO4Kog3hsV+4DgRnem8aeWEqdWc6u9fZZ9OQvBmW07t4I4Nja1gPkGZ3OMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708873202; c=relaxed/simple;
	bh=FgRHktBN2s+oBV3CXUtROa4TN++zhYFVdeO/sgk7JVA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AekMAMkPuMHy90JaYGQU11XZVB88VZ0IdOdZWkXTV0340eeU5SGcD72yuG+RGnD/PpmxaC6pndN4bxI1lT/uX2H0XUpiOQUUc3EkIjhbeD7CEPSbJzm+poMnhp+2u35TSjQaa2nqLJgeSD4whtHP3hj56IXyw6YMfm97oq54vGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKjhkt8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52EFC433F1;
	Sun, 25 Feb 2024 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708873202;
	bh=FgRHktBN2s+oBV3CXUtROa4TN++zhYFVdeO/sgk7JVA=;
	h=From:Subject:Date:To:Cc:From;
	b=fKjhkt8cmERKJaUGUTMhKnHuCozTugPyl1yGXhhP2T9baJnr777ybROFya1awyyxo
	 2EMLpzA+bytLRn6EJ6fbrFwo6qI66unSA/QfE6D1dng7umyD98bA9/aQmz8VIswMk1
	 FRCJtRgpvRAKr+/dn5b4vUXaCY48VufAFr4r0jCeEYT7HcAGJPTVanBTDyhOOjfDoZ
	 6vkd2JudGUV8We+U/sQmTeRNMIiefMWv1SBd/ibDJ21gwpootc1Kx8SvetSHrmgQOS
	 ZyBDOJdh7Gcr7RhGW0K0AgzjbdsKewipXMRC8l5eDcOw1RuNF3BAhM/qECNlheUo7p
	 ngQ4POjr39C3Q==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/8] regulator: mp8859: Cleanups and enhancements
Date: Sun, 25 Feb 2024 14:59:26 +0000
Message-Id: <20240225-regulator-mp8859-v1-0-68ee2c839ded@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM5V22UC/x3MQQ5AMBBA0avIrDWhSnEVsaAdNQkqU0Qi7q6xf
 Iv/HwjIhAHa5AHGiwL5LSJPEzDzsDkUZKNBZlJlUirB6M5lODyLda/rshGIo9Umr0yhFcRsZ5z
 o/pdd/74f6ZMlh2IAAAA=
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: linux-kernel@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FgRHktBN2s+oBV3CXUtROa4TN++zhYFVdeO/sgk7JVA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBl21XpyQ7FqWAuUIlNxl4dyLVAlsrZxyxeCC2Yi
 1e6N0Qx5V+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZdtV6QAKCRAk1otyXVSH
 0DKwB/oCN1G/d2K/Z9y9mLl0IdFaPZYDJElxl6voDGBjjS/PZOA1fIv2Exq/mtGpUOOWn8NLwMd
 5HjdszxTPkCNCGnOkgEeXzlzWaHHJnKXLbGXYjw9iEEZSHQWIW0eagkbDmiZC03ZQqDYrlM7sYg
 NOdZGk4sbyiGqtA9T3cN297/rm1JuK8kEQwH9TQQ2Kao1V6OnEvosMSG1f9jvmyoUvK/qI/YjsV
 8ZGleD6CH84sM0md/xT+scrohQKSbdcmi6MRcqBgxObmkz2KnXrIExr9LwAURxKAVulHlQUJsjZ
 sxw/NBrQLFiqvqMOQgc4u5qHxqICTsEVUi2KTBCEwREb9+yc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

I had cause to look at the MP8859 driver together with the datasheet and
noticed a few small issues and missing features.  This series deals with
many of these issues, the device also has support for interrupts which
are not implemented here.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (8):
      regulator: mp8859: Specify register accessibility and enable caching
      regulator: mp8859: Validate and log device identifier information
      regulator: mp8859: Support enable control
      regulator: mp8859: Support mode operations
      regulator: mp8859: Support active discharge control
      regulator: mp8859: Support status and error readback
      regulator: mp8859: Report slew rate
      regulator: mp8859: Implement set_current_limit()

 drivers/regulator/mp8859.c | 252 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 251 insertions(+), 1 deletion(-)
---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240224-regulator-mp8859-eebd7c16c374

Best regards,
-- 
Mark Brown <broonie@kernel.org>


