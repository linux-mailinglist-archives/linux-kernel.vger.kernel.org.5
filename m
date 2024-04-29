Return-Path: <linux-kernel+bounces-161849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E28B5228
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35BF1F2197A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D522301;
	Mon, 29 Apr 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="XKQapkLQ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD822134DE;
	Mon, 29 Apr 2024 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375119; cv=none; b=brHzbJpl9jXgN+E6hgZQX4eZhIpXKZdAi1oge5jnbt9HRqHl17VYLhJLGx9Mo08H3xag4hWg1yrvBEOJ2bn+Qu4Y7S94bWr/cwH7OcQ9okDr7cemjc/8q8tZGUQDgHeG3ISvN3RN2vG8RaBi3pTrPR21kwyrROjb3UlgdTyFx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375119; c=relaxed/simple;
	bh=AkB16l2d8zShJAWap2HKlTOHGrssPwSZSU7S5r1EcMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U25SGY7hcI46KPnCAKykcstWoknx9MurjNMJWey1/1OkpoacPECOMf0MFs49jmfqLmj5GPmb6bfpk3bIlcLkntb7YX7E0HaeZhVu8H8HYLu/hweza5EvSbotKkHPT/2rMLseaH2KuhBLktw7Ypv2SN3fR8+iqylSwA+A692QMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=XKQapkLQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=AR7EKzJbNScSDSl4HGuD1ekuOyaMHYWeSjknrxIfYFk=; t=1714375117; x=1714807117;
	 b=XKQapkLQEIOT38cXy1ojiZFSOvNuV2yuXJ6kapRmk0xWvRQPPuto6Bt1gyM5EWuESUHkoQtrzp
	qoH8pTAxMvpfrcSfoO7S0LsFtO7mkXhUmstRTOIljTP5tB3cycafrgvmVNb8sZgJmRqa600CXyDDk
	nP+sJq2E1eJHdzm0PWpSsVNv+GgK3peMqu4NqBQSelKNEVQr1sog6+qrbH8naE4m3QlrG0Wv/HCTh
	GmAalAtlmE4iqzjLv9N1isfTJTa2sy2bv8H4xjh4KB8YjUsufda1BvYZbEguxiYAgJhmTSEqavwse
	5A9Zrv0MetJ4fxi8FQqHzGvhZ/vzLkBnGdLng==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s1LHT-0004e1-IR; Mon, 29 Apr 2024 09:18:31 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] docs: stable-kernel-rules: fine-tuning and 'no stable backport' tag
Date: Mon, 29 Apr 2024 09:18:25 +0200
Message-ID: <cover.1714367921.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1714375117;b475376d;
X-HE-SMSGID: 1s1LHT-0004e1-IR

After a recent discussion regarding "do we need a 'nobackport' tag" I
set out to create one change for stable-kernel-rules.rst. This is now
the last patch in the series, which links to that discussion with
all the details; the other stuff is fine-tuning that happened along the
way.

Ciao, Thorsten
---
v1->v2:
* Add reviewed-by tag from Greg to the first patch.
* Change the backport example in 2 as suggested by Greg.
* Improve description of patch 3 while also making the change remove a
  level of indenting.
* Add patch explaining stable@kernel.org (w/o @vger.)
* Move the patch adding a 'make AUTOSEL et. al. ignore a change' flag to
  the end of the series and use stable+noautosel@kernel.org as
  suggested my Konstantin and ACKed by Greg.

v1: https://lore.kernel.org/all/cover.1712812895.git.linux@leemhuis.info/

Thorsten Leemhuis (5):
  docs: stable-kernel-rules: reduce redundancy
  docs: stable-kernel-rules: call mainline by its name and change
    example
  docs: stable-kernel-rules: remove code-labels tags and a indention
    level
  docs: stable-kernel-rules: explain use of stable@kernel.org (w/o
    @vger.)
  docs: stable-kernel-rules: create special tag to flag 'no backporting'

 Documentation/process/stable-kernel-rules.rst | 234 ++++++++----------
 1 file changed, 110 insertions(+), 124 deletions(-)


base-commit: 5eb4573ea63d0c83bf58fb7c243fc2c2b6966c02
-- 
2.44.0


