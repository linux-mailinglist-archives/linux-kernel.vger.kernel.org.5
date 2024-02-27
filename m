Return-Path: <linux-kernel+bounces-83990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6B86A123
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0242C1F239B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D7D14E2C8;
	Tue, 27 Feb 2024 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gXMM5bLC"
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EF14E2CF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067074; cv=none; b=fM2YJnb+3I4RuX3VgJWZvVIJs9cuS2nLU1rWUZREV369reKU0Plqhf++8+37FXYVedprOZ5JlIpJCiD/jGx1eh2t+AQcwyES3962RJhQTfmBCvux9T213Zqd0n7h2PWmRVNXB4xIn7vyQkzPoEAkN8XS6leNhyTiB8TyH1yYDrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067074; c=relaxed/simple;
	bh=CHjYuJEs1YGST1wT3cXrPmtA83Fz7pwoVCFfvmEsfoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVGp/niESjSkygzfKNgaW03m6J+7EQizLXj2I0HPEog28Kb5Dmz9P4iHCPTnPhD9/yOjm3XXMVXdYrh8u7wWHJEPxBIsIwQ9IAw3/J/cV8MEIqbAI+37tZ9bQW9v+i1HjvVWf3e7q+ajEMU0ShCU5OJERf3flRUa2lW2F+gdbYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gXMM5bLC; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id f4PjrRU7nxsbMf4PjrnVjY; Tue, 27 Feb 2024 21:51:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709067063;
	bh=4X7OgnhzA0408NmQJznS3WtjF09N6jPBQZSZ+cdPFMU=;
	h=From:To:Cc:Subject:Date;
	b=gXMM5bLCajy5uQYD5Vmf2X16QRsXPNaj2madgH6f/begypQJvO1AsoFa5s9aioiMi
	 VUeoehXAIMYdPyHkTw8Q6hKxFp7LNvVOc0flIN25qiPFUlnL30vn8XvuqLodmCMZaS
	 BSAyF3CE/hOYUqRGyNIZarhIPY1mSpYgUhQ3ScQ5vaMzx7yvj8OuROnxBsiApuosqC
	 qZSk9L5hedtKfNgF5YoXZwcYjZGF968ixq9NA2s5ZL4Ed9anprA8dw/WqeEK0OXdR4
	 OCKQAoVXM+P/EfD9QMmVo1c6Mt2eVwVespEP+yizOus8zrZFPsMcN/L9aHfpNO0ljC
	 rek6feTdO4ocQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 27 Feb 2024 21:51:03 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: andy@greyhouse.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net 0/2] net: tehuti: Fix some error handling paths in bdx_probe()
Date: Tue, 27 Feb 2024 21:50:54 +0100
Message-ID: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch has been split in 2 patches in the hope to ease review. But
they both fix issues introduced years ago in the same commit.

Moreover, the 2nd patch partly undoes the first one.

So, if preferred they can be merged in a single patch.

They are both compile tested-only.

Christophe JAILLET (2):
  net: tehuti: Fix a missing pci_disable_msi() in the error handling
    path of bdx_probe()
  net: tehuti: Fix leaks in the error handling path of bdx_probe()

 drivers/net/ethernet/tehuti/tehuti.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

-- 
2.43.2


