Return-Path: <linux-kernel+bounces-94967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FF874755
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08424B20B77
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826E15AF1;
	Thu,  7 Mar 2024 04:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aNzYXf6s"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0694B63C8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 04:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709785457; cv=none; b=OnZCP2WmSLb7dLLuLdyG7cMnZpvx1FXKb+jD6NyjBnRCmrmyz69faG/LbMC7hSQU73sfUTTzjy2CCbn7mG285H79l12tO9vV4KCXjp5pNi7qVJgkmT1o3BK5ecOyW/lylMGmtfnq178w4dgpPPgPmiwdOkiAU0O034m9XKSSbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709785457; c=relaxed/simple;
	bh=G5xzXG3tmJ4O10paWZNuvW+7YeniVtjtDYCN8ZCDbJo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uEZ7uBCJI9gHzs+48+VKdNTGQUR2y0TkFmSbO+lxR1kngPAEVB3PvWLc1/y6MTKD2v/MD8voaDKOv37kFmUfrihGGaUVX4wHwarBkQuBi2kxsSqilKzopXqp+3EQLtgzvmomwAkD/ZDoWaRvuouVu8tGHAG/Jp3yS8mAg8YSGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aNzYXf6s; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709785444; bh=G5xzXG3tmJ4O10paWZNuvW+7YeniVtjtDYCN8ZCDbJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aNzYXf6smOOT2Pr+Ab4cZAIStvwwr0EbB+S0l7/mlJu4lJk3xBrT9hMNdwkZxi2nY
	 tA1BlDlePxx0mhxZp4pquRhj4fjrYU5gSgMfm6DNXhSri9ygCBf17JT7xTvG+I55EU
	 4/fJ+b6FHCfH89oDf2UK9QV4jfZF3VBTb4qmPPrE=
Received: from localhost.localdomain ([218.94.142.74])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 2B594042; Thu, 07 Mar 2024 12:10:53 +0800
X-QQ-mid: xmsmtpt1709784653txrxhimiq
Message-ID: <tencent_3DA771302DA0E15ED8BCCE4B902485585206@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iC5tPQ5PBtKH2GdRobKXdFP6gisixfwHnwONJbWMKm7iF3ibqc6Y
	 38t4Gc+baFdg65Zig0nvvZaEroDU6zZDSbWdLycYa7o+G482uSOtTewVUbMgFfciLkn72NAie0K3
	 uIAL/p09R0QZ/rK4ZFHFLvhmnlYej0YJCj3bz08Lm5PXOGzQVxyOG3uJz8vckjDwmXoTgkIPIQLu
	 Ro78DFT0dw8wuaXA1TMjXXZ8iOp9gbltZtjGuHAEfY0lbLEfHvtNPVFLH0zjC/skY241puP4+rW6
	 EB/nkipwFjUoocnDTPjFk6psXkGdX+g3XDGv2Gq+cO7NltX2kJ0lOtPcutnLcfSfz5Vhg+4Fk0di
	 ksDJXK5iFpXyEuS9snb2u58Oo2GIRrn2NB0w8yLEFUpRe/NTLCcgo3WOS6/zZ/fe7ZYFLeEwX+ks
	 HHZQ1my/yJDnY40ybsQuQKOYusMzWlIGm+5ETTAlxAetKy1EZeHDVd51AQDXjWBbHY4xV1k9LDKW
	 hgStaxPUoNDYJn6OBmFLLmzQZf2xJs6TFkHYmQ4DtHfD7YMDIC03mLRsrrVDXVuTr+D2XcKy22hN
	 CE7KX4FMDeybDXy6Gkq+1vuGiFudlqgOKZiLkZ0srBR+z0zoKBrmYDYzAM6bV1ceGx+g9+ybcoD3
	 8AbFJbf5OCh7zLQDaXivJ8rQdj6+PAjNNmrWOITbL0LVyfKmQaJr7bq0yhupyhPCKSzl+0Fi1Lld
	 Wpztqp4mjRahCTXWkc/zk5ipsALSNVKf8j2NUM5RukBy2pdP+sACInt7QiWmQnLCXDtdaLmQKBo3
	 cyLErH86wltpHWJ3AsCvvzv/wGLt/J7E7gFdcQJT+0Un215wb7JjzpU0Blt6i4qMPjEWuQzciJAk
	 X0lZxWu4TsNPfGF1nvMzi8RSewNjW3IKLoLR443qu00be+Orc+N/3vxpj71GkjHjclhYN+/hxkwh
	 +Ws7EkaP2ThI6l4Amzler5oLh07XpBqaA4H9AhqpuRArvHDI+Hr9PT/THN1exqetkr6wB1oHY=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: paulmck@kernel.org
Cc: boqun.feng@gmail.com,
	dave@stgolabs.net,
	frederic@kernel.org,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	lilinke99@qq.com,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	qiang.zhang1211@gmail.com,
	quic_neeraju@quicinc.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH v2] rcutorture: Reuse value read using READ_ONCE instead of re-reading it
Date: Thu,  7 Mar 2024 12:10:52 +0800
X-OQ-MSGID: <20240307041052.86803-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <b01c476a-64ee-4030-8bc9-3807704efacc@paulmck-laptop>
References: <b01c476a-64ee-4030-8bc9-3807704efacc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for your work! This change log looks good to me.


