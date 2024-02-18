Return-Path: <linux-kernel+bounces-70223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75008594FF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5991F1F22C4F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E936AA7;
	Sun, 18 Feb 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JLyY/0Ob"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDA5672;
	Sun, 18 Feb 2024 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237751; cv=none; b=CFhmFQBdldSwl3PC6z5P0FL+NNjxUFLiS+TF9S0A7XjVj/7TI5eDcrCE7ozinx8h0SwegWENYWFKLtM9GwZucM+ItAFeOGppyBjouUgxBPMdbEUtEUL2MZt9PyOr0I/7/yIMaGrjLKoYP6vxOcy9ZITE0A0BgzHmkUAO2jRazLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237751; c=relaxed/simple;
	bh=i33jKdGMPfEsO7OK08HHHsozi96jCFD5WvhVa/NzbrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FT3uGDMW6Kf0dT3JjAeWitKglC0gSE06zWR2f09QFF5x0hRDP1wnRx7cxZMk09fZiY3CnBkMoEftrsHZQSLPbXu6xc7b3RY4rHPLbIR1BcmHHRmyiKKcIsvqAqaGilBXO9zehNIw2wBP39xJZwgEZCtBzqLKJW0NLQJ+ZgyGwDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JLyY/0Ob; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=xljAw
	Hk97c4aICi24IHrYPC+CEFrr5TDfUdCKV5ij0c=; b=JLyY/0ObBH02kHPofdSVa
	7yduhIGNZbe5j7rZe19BIrx7MFdJ2xxNxRzc5XY7a/BjIgU4XLLmDq9lgeoHDkoZ
	fB0/XJaeBhLuiaKHxC27OzuTFNcaMG3LIrwbHMFPcC2no1OiOSYjNSJ0qbw6AUZ4
	MsOtNETOS4MQVqJ8WRqn8Y=
Received: from localhost.localdomain (unknown [39.144.138.207])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3X1V3o9FlTGBpCw--.34987S2;
	Sun, 18 Feb 2024 14:28:08 +0800 (CST)
From: Xing Tong Wu <xingtong_wu@163.com>
To: lee@kernel.org
Cc: Pavel Machek <pavel@ucw.cz>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
	Xing Tong Wu <xingtong.wu@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Henning Schild <henning@hennsch.de>
Subject: [RESEND PATCH v2 0/1] Patch Resent: Enabling LED Support for Siemens IPC BX-59A
Date: Sun, 18 Feb 2024 14:28:05 +0800
Message-Id: <20240218062806.3932-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208120901.GL689448@google.com>
References: <20240208120901.GL689448@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1V3o9FlTGBpCw--.34987S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrAFWktr1DWr4UtFW5XF1DWrg_yoWxGrX_ur
	Z293s7Cr45ZF9Iyay0kF1fZrWa9rWUAFWUAa48trZIkry3Zw1kJF98JrW5ur1jqa13CF1v
	9FZrXw10y347XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjMGQPUUUUU==
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiqByI0GVOCSrszwAAsH

From: Xing Tong Wu <xingtong.wu@siemens.com>

This patch has been resent to incorporate the necessary changes for
enabling LED control on the Siemens IPC BX-59A.

Based on:
 eccc489ef68d70cfdd850ba24933f1febbf2893e

changes since v1:
 - Creat a resource dynamically within the .probe() function to eliminate the use of global variables.

Xing Tong Wu (1):
  leds: simatic-ipc-leds-gpio: add support for module BX-59A

 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 53 ++++++++++++++++---
 2 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.25.1


