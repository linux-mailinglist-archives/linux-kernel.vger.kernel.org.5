Return-Path: <linux-kernel+bounces-158119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D838B1BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79BE91C22A76
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A9F6DCE3;
	Thu, 25 Apr 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HXd1znKR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711073A268
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029817; cv=none; b=DeBHexcz2azvUk8IqbsB3qjKY2qviEC2/n+v8d1RvSH/Im7Ro3pupfQrwTdd2Ju5eHx2U6ibPEHY/ha6/6qbeRQV4r/2ItH8PJTJwLPVpW6w1Qdr2BkGU5x5YiFVrFF1MAyertZRhXh8gamQIjcqaWcERjLk3JmEN4DCSNoZcOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029817; c=relaxed/simple;
	bh=SzpkZG/BeOZDLG+Zvq2cvblBayTSaO3vjmv7avb8+ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UR84LYl0rfBYWawUvv1UmF/lyaGoFUJruINlboMKMtJl01ys9qztHnyVSS/BwxwHz5rnNuNg55xtJoiZPMwBXbUFc11jl0IQigIbtsZWayrMK8Od3PDFdGs/z1AW2Zxuvx9wpewRU3hTBLRb+mYkLbVIWeANwQ937lk+00vCnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HXd1znKR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34af8b880e8so393611f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714029814; x=1714634614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fyqYJZkfjwdUua+TcDwE6H7zALfuiwgInOkn4JY+Ffs=;
        b=HXd1znKRYU/FCgEjLYkIpLHYeN6zelOUXvW70+u6KBbq+xh/Echb8Z3U8olpfqfXkb
         QGezHMlS6IUq2X2U7vVJq1666nAlWjbKuW/EEYiprMHNK/OloaDmpeDcRKLQd3+ckjsZ
         qTpO9D/6ja3u5nXFMgX4MTdm+22by9MB/niZRdyBdOh1NrZPUJXSFYATm+L7de4/pb6D
         /qUZuue32oFbzsnAVLnm5u6/MrSAr41+qvfGpCptyBNFpgdQLxUfzSOlMULkijMkhk2J
         ODtAZf4MYZTTsvmIgqaOR30Q+evxXZdn1PYrKRRgy7Bn0Eg3ioj92jrqY3deT1NxMA1f
         YEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029814; x=1714634614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fyqYJZkfjwdUua+TcDwE6H7zALfuiwgInOkn4JY+Ffs=;
        b=uav1io4+Hi3lxsU+RG+e3Gq6ktKKmAMjOtkLg+FSQjLHfU6/tb5UqYrap8MvWW1f4E
         hssl4zqnD8Hj4qiPmGG9K34VM1s/Zm6Fkd1Yz9SmuA/6uQghXsBD9d9lNbjHwlfLi7zF
         uSsMKOomh0sCBDHsogdbyoj/Rg7w+oloSLkytdZv5tF/tB5+PQuFZTAI0zvwg7n8Ru+h
         Xsoyl93O0eLFuorNe9x9nUoMewMcxQxr7miS5umIK+n+FZB03nEH9ZtGg6JzV5zpNEMk
         wEm/3nDxxQ/LOYCW84lKan21MXhDvHGJ4crK6CTZ+0MeGyMGdpNXmL7CvTvEZUDqA1qo
         oDJw==
X-Forwarded-Encrypted: i=1; AJvYcCVJC8dDTvIfcw5tia+p3gxw1NJ9d2/mPxa5lbKJ3fPI5AzRz51v70yoBoieYBl8Q0Dw0iyI0ObG4a2U7qirpNW+Qh4++87tXpWcG4Uh
X-Gm-Message-State: AOJu0YyvZZkibiFWld4lNCF/QCY8Wdzi+htW2pgsJ3EnLnSSyVlyNVr7
	VpMV1hH7ssv2O6ONOb7TyWdpkaDpQ8Q11s/arScr20EIMJaiqdh4uAhQCA9xJto=
X-Google-Smtp-Source: AGHT+IF9upKBqBUrgVowAM5vRClJmwFn72xk3n62VcAc5CgAfgBJavs62vuM/qOhHT/YvDf1UPIGsA==
X-Received: by 2002:a05:6000:1b87:b0:343:cee1:cbc1 with SMTP id r7-20020a0560001b8700b00343cee1cbc1mr1258604wru.14.1714029813746;
        Thu, 25 Apr 2024 00:23:33 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id cs18-20020a056000089200b003437799a373sm19176297wrb.83.2024.04.25.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:23:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] w1: drivers for v6.10
Date: Thu, 25 Apr 2024 09:23:29 +0200
Message-ID: <20240425072330.10049-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.10

for you to fetch changes up to cde37a5bdb0ed2c4c7b86ef688e5fdb697525a57:

  w1: gpio: Don't use "proxy" headers (2024-03-25 12:06:37 +0100)

----------------------------------------------------------------
1-Wire bus drivers for v6.10

Few cleanups of 1-Wire GPIO driver to make it more robust and easier to
read.

----------------------------------------------------------------
Andy Shevchenko (5):
      w1: gpio: Make use of device properties
      w1: gpio: Switch to use dev_err_probe()
      w1: gpio: Use sizeof(*pointer) instead of sizeof(type)
      w1: gpio: Remove duplicate NULL checks
      w1: gpio: Don't use "proxy" headers

 drivers/w1/masters/w1-gpio.c | 62 ++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

