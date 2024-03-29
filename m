Return-Path: <linux-kernel+bounces-125100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD68892015
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360D328AC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30E14B062;
	Fri, 29 Mar 2024 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EqfkgPBQ"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CEB14AD38;
	Fri, 29 Mar 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711724148; cv=none; b=sQcj5wFtClguP4WRc8jRZbDLKGN3VkzELnhF4mBGDaR2QA2EBDOFzYu596egLxlklIR/g3Mg+g47EWwrqm1edxGAL0iRg8iqizUyIxTMIYw18aIIzSHqbWkPEsjg+bpfpLR9b5hxlct7uJH/0bWAQvr8kqljol/mV9i/OKomUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711724148; c=relaxed/simple;
	bh=ihbrrhYcTyaieDKOE+LOMZmYTYEL+xpvPfnHf8MiO7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eveYebTrAvpt6jzfan6j5XiCdrfPKU0FzdY/TZ7zWM0DxAZ+9fQVZbmu/2y0GTbTRz3t5757ChYzA5h60kiZ/lKn5SI8z5HrJTOkm+HdNUCJbYin12AVJWBjtrAcpgbDtFuZsASNU9fiCfy0K5KYauvjnmfGJnWYuJKS42KqXzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EqfkgPBQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7B52647C2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1711724146; bh=PXm3w4Z0JGYtJZAMcTUoMaoTUfHsVKupxXhu2HVQYEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EqfkgPBQrKiXwOUD4rRr1Rbrp6dxOXCVBV69ADoLePocDHB/Z2QGTm/rTQrw09ITl
	 T7aoczhr4EdJu3hBfrVypKXv3fzciAGFtyF5og6On4s/KjKleWT6i8womJz6gQ8DbP
	 NL9tmvIAYTcDdNAzko8+oKRmeQpssPiIKxyWhXT6YurEBysjgI0MQ3+n0Z8BsRwxMn
	 zBbsoizYjHic+0ruJn+zB4qjJT/5YEQxGStj2H+ylzFp3fJiqX0880bLQWjuRV/Ucs
	 shDJ+2ydoyCMIBOB7BdER9IZvIRLBMYibemUz6kxtgJk/4oaJoD9TBxa7foMPAAPoH
	 CKZz9cPNV83mg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7B52647C2E;
	Fri, 29 Mar 2024 14:55:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vitaly Chikunov <vt@altlinux.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH] tracing: Fix documentation on tp_printk cmdline option
In-Reply-To: <20240323231704.1217926-1-vt@altlinux.org>
References: <20240323231704.1217926-1-vt@altlinux.org>
Date: Fri, 29 Mar 2024 08:55:45 -0600
Message-ID: <877chl5bpq.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Chikunov <vt@altlinux.org> writes:

> kernel-parameters.txt incorrectly states that workings of
> kernel.tracepoint_printk sysctl depends on "tracepoint_printk kernel
> cmdline option", this is a bit misleading for new users since the actual
> cmdline option name is tp_printk.
>
> Fixes: 0daa2302968c ("tracing: Add tp_printk cmdline to have tracepoints go to printk()")
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon

