Return-Path: <linux-kernel+bounces-57074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8784D3C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524BF1F2218E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0212F38B;
	Wed,  7 Feb 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgnVeJYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129C12F5B3;
	Wed,  7 Feb 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340919; cv=none; b=p7cONrbI+k1eg7y5PLrtMh1/QTyJlSTswYUXs3GBryuJkBUkgrGZbSiW0OOzqhmuHYpx/nOkrHHy4NvQP+nnIklgUrJr5QuAPU62EDR0kkTiCkdM4GWMeK7URRk6hlmMLptpV7yRcR+6C3KrUAKPQ4JC/nNri6W0N7r8XGNhgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340919; c=relaxed/simple;
	bh=T4dKGluWwNhVczRT6Xa4bYlNUXP1O8lVxoA6WzByoTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmWIn7KSDJ+l4yLl5o7EMqV9vGMyuBjxmlOyxYMtxt91xw3aa5n+RUscue0rvgiTpImaAvlmfJBb6RFf/3DDD5Rg+GmeZM5znWhWx/3FX0/J+gquJfmz63C8zWMYw8zKOao6x2M0cPVwGDt9i5tEO3QEYziXoLbRYsjc7bgOHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgnVeJYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF55C43394;
	Wed,  7 Feb 2024 21:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340919;
	bh=T4dKGluWwNhVczRT6Xa4bYlNUXP1O8lVxoA6WzByoTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgnVeJYJhVh9FBY7IBFt70pILKFr1aCutoTrM43EeolfoYR6+rEgBdCJ1GZ6IbtfA
	 UDw+JULdq3sGkiSUCxzi+Zz4wIRXbqkXoa/mIjJv1FaoOgk+SOmRv2o7wVJZkpkFjP
	 RmpH51IK04W6XU9iL6Vr+RSq9a5pgPX+WDHMazGrsCCou1TaJwVoSwDcm8WPKmHqdO
	 Eqa0PIShMSrqdolGqdvqLJ/EHe5j24oIK8NyV0AERP+XluGQcMJwLU0N20xN+Sk1YB
	 jLbaHNrQhO3S/+0oGn3Fvrj9RID5nCIa1aerzBxmaRpx5xL/HHGvFeyLUe9t8rvUru
	 0lo0G4K+PtPmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.com>,
	=?UTF-8?q?Marcus=20R=C3=BCckert?= <darix@opensu.se>,
	Sasha Levin <sashal@kernel.org>,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 09/44] HID: logitech-hidpp: add support for Logitech G Pro X Superlight 2
Date: Wed,  7 Feb 2024 16:20:36 -0500
Message-ID: <20240207212142.1399-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit

From: Jiri Kosina <jkosina@suse.com>

[ Upstream commit afa6ac2690bb9904ff883c6e942281e1032a484d ]

Let logitech-hidpp driver claim Logitech G Pro X Superlight 2.

Reported-by: Marcus Rückert <darix@opensu.se>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index fd6d8f1d9b8f..6ef0c88e3e60 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4610,6 +4610,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC088) },
 	{ /* Logitech G Pro X Superlight Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC094) },
+	{ /* Logitech G Pro X Superlight 2 Gaming Mouse over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC09b) },
 
 	{ /* G935 Gaming Headset */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0a87),
-- 
2.43.0


