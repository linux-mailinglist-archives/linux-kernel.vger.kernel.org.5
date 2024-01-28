Return-Path: <linux-kernel+bounces-41586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED483F4F5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608A5B21E66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0761D524;
	Sun, 28 Jan 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gg40532A"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8FDF6C
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706437357; cv=none; b=gNRiIHy06O/O/kY9BmKXXeVtHL9C/MT2cKmXmkAlJKT8o1Cq6cHOJQZtGRhQh00sMGtXJeC14p1eJCT76pY7RUNCjk7aqhq6pFTPU9FMbngIUNbzTlgnJ/JM8FZet6+2kDk2Nf1238lysPQmQmy/viOwCNh0EZ6/S4QC/pNRUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706437357; c=relaxed/simple;
	bh=1jyGYBxQljDpPmnMrORGZudzs8YuOvvIAR0vEWYgXZU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MqYtP94dDVgQtdF+AxrGpTvH/z9iPnpcNzSR19te9dVA9IQDVtZ8Y/4KDWy4cF4bV1xIRavTdZL7rpcCHlOEuWmY5VWlKnjOEtwL6Lxua2/qcUw4Z2nZIofPTTtwCXipcvsHfLHMTsx3H07+Yg16MdRqCs4kkc5vBi1RQkl4ZZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gg40532A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB82B40E01A9;
	Sun, 28 Jan 2024 10:22:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rq6zGMukCGKA; Sun, 28 Jan 2024 10:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706437350; bh=XvoQDsasovu689xaenFWPJzjR3i2LGUruk5ZV73msTk=;
	h=Date:From:To:Cc:Subject:From;
	b=gg40532AhX9fuy6vY9oXp5qRXTg4wNT1BYUq0rnI1ZAcGo0o+/JSkB/q+pFWx6oJl
	 scZmftVYzD1uKEFaahOCuF65YYNBhtnXl9vt6JLaKnzRG2xqr24TrXroS1gXm4lZMw
	 3tBNPogjShwOckTsx8hweu3wLOkqDvOO9OaGNcZyPqyzBuGhbSQQrpE96YWizoe5o4
	 G0skSyCrssVglw71GsaO8d3gVri5DwQqhv6NLuPZQ0E0TIUNQQYigXSs+XEyRVFZrs
	 opkogIFVXRfZfBqb42wDxniM/DN/tWGG/M+TVlt6i3pD/uq0PSk5hpbAFYLiO9PtHt
	 ihowQ2Fc0Sn4R+GpJSdMoImc+aBPGcljuOJMdL9y+mN8J/PmqysabkR2olcELWT8La
	 anFFqWy6Sv/oxjoVRevriFWNuYfICBK+1WHUjRLpcIlW8wYzJHRXXFdqIIehPnrmjz
	 xFIgUKuJmK/7amI2XAieLe6q6/MPASyP8SCWmo04/w+6Rn3dMK3CYBqmt1xZaqhafr
	 Y2nkYx1Q685JsGriez+kwh1DHBQDPFN07aJXn2Xe8U8jfB8Y5/JhfKgDn2+kOb7jyi
	 tF9Fn4S0oYf3OsnupxXlcwEDOdF7weURBm3iR796eFvUDk0Penp5JsI9pTEATd3s3Q
	 0sGBJrbDR6p2+HR485z7Y79g=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B73DA40E00C5;
	Sun, 28 Jan 2024 10:22:27 +0000 (UTC)
Date: Sun, 28 Jan 2024 11:22:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.8-rc2
Message-ID: <20240128102227.GAZbYq41uhKVmVFc_F@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent IRQ subsystem fix for v6.8-rc2.

Thx.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.8_rc2

for you to fetch changes up to b184c8c2889ceef0a137c7d0567ef9fe3d92276e:

  genirq: Initialize resend_node hlist for all interrupt descriptors (2024-01-24 14:15:41 +0100)

----------------------------------------------------------------
- Initialize the resend node of each IRQ descriptor, not only the first one

----------------------------------------------------------------
Dawei Li (1):
      genirq: Initialize resend_node hlist for all interrupt descriptors

 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

