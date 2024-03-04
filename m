Return-Path: <linux-kernel+bounces-90396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D1086FEA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E561281BAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8E3C48F;
	Mon,  4 Mar 2024 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oDT/Xu+F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jzxjGBOY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847573BB2E;
	Mon,  4 Mar 2024 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547149; cv=none; b=WJu6yNKoEk2/WG2c0ZfAkLXqQ9JDmr6di5du361A29NwwPZ5E00TLAYxnvFDs5pcTcBza8TcQqlHECp+LuxaZo9vaQ/c0tbfgBaWbZ/etpFIQxmeG4zNzZlEdzu+jDP4fkbrY8tXa0f9BE3/EU2fVdSSn99FaOtuijhn195Qo7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547149; c=relaxed/simple;
	bh=OyN8YEdrBn8llpG2kEDC2mhfQ0B4aig3D3k4rEQFbBw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=sq3v/Ht9BeTe92ecg0d6WFR/glyNdKvgVyJJagrhQbCuR4xrSX5FzIVFVFD4NqYNlHnouIGpcQUCFt+zvPdGfHAO5h8+bHGQl2A5xntTs3jCwVZK41ZtYNNL+SmkFytNgNTabW2iGRUy2JkvuCa9Pyc6ohmxDx/W26rktXhnrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oDT/Xu+F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jzxjGBOY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240304005104.732288812@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709547147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P1puNPiaRZsJi3LvDbzvEOsTfk74hgQ7qSp99Hl7hDM=;
	b=oDT/Xu+FEWupD4WnJWzYsbwIgFGDT62w1IljV+6VhDRUEI0uFmkEdEZIwd/bz4ru5CAjxu
	EupYV6NbSQ1mGBHqZ+w30oZ8J+NOz9ZnEt1eLBaVFShhVvkO5NYeKnYaRunauESYbWvt43
	QzIh4T3utgPwd1onET2WvD3uG/Frvyr/9hZ8QOKOcNe3x7EaTXLdhiKKKcQ+pOyd36cR0D
	jhxvobHod4bk4iU7x7YM2lJtM1hl0uXIlbZTvp8rvEtJaJjW44eMOLsBM36zq20QKFjhaa
	p2Kh9H1nsPAwDFtOPoD/cEj40U0uBHJRY+qoIYSlegmUgs0BKrZP+lnieV4MzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709547147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=P1puNPiaRZsJi3LvDbzvEOsTfk74hgQ7qSp99Hl7hDM=;
	b=jzxjGBOYUFsGZ3hZFO+xR+Yl3T6Gy4lQJbVwQhe0DyXuo9xEy1rqaQWSf4Mktc1N5pUcAV
	fyQjBS9nqaBbzsDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org,
 lkp@intel.com,
 oe-kbuild-all@lists.linux.dev
Subject: [patch 7/9] x86/cpu: Use EXPORT_PER_CPU_SYMBOL_GPL() for
 x86_spec_ctrl_current
References: <20240303235029.555787150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  4 Mar 2024 11:12:26 +0100 (CET)

sparse rightfully complains:

bugs.c:71:9: sparse: warning: incorrect type in initializer (different address spaces)
bugs.c:71:9: sparse:    expected void const [noderef] __percpu *__vpp_verify
bugs.c:71:9: sparse:    got unsigned long long *

The reason is that x86_spec_ctrl_current which is a per CPU variable is
exported with EXPORT_SYMBOL_GPL().

Use EXPORT_PER_CPU_SYMBOL_GPL() instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
 
 /* The current value of the SPEC_CTRL MSR with task-specific bits set */
 DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
+EXPORT_PER_CPU_SYMBOL_GPL(x86_spec_ctrl_current);
 
 u64 x86_pred_cmd __ro_after_init = PRED_CMD_IBPB;
 EXPORT_SYMBOL_GPL(x86_pred_cmd);


