Return-Path: <linux-kernel+bounces-166684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748748B9E21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC281F248D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F55215D5A2;
	Thu,  2 May 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dtUw95q0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455115991E;
	Thu,  2 May 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665829; cv=none; b=BBPp0P4l0T9AtpYu3wwER1rlQPsYL9cE8m8NRDmjdOfUOrI2wzz9L2DW/qY+oDb+AgGmz/5MaSEkC8hOk5vo9Z80PJ1AxOv6eiosVsDR0cXhtVOIkrShocyl96HRyXtwBp5LoT1f6tjaULxYr9ErU7QUQ98FQDgzNf5H5xbaWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665829; c=relaxed/simple;
	bh=C4p74GXwgBU9xVrDTLpTjgvTtnUYi96q//QK5IQzsNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XmSk7zTL7PiGiwZNgARJcESJ8xijCMj0l69Gy/ITlzgJTn0JCXMgR2S/ws52ChZxBCfoOiARvodcEgLFilxO2Is1VGTSMqU2XH8WjwfPhDnKDWk1H6gjspy9DgiXCQROYtORipwydvlgBMKvTng13WXNebWk36hHe5cKvjO4JCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dtUw95q0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 868CE47C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1714665827; bh=aQ5qTPoGJifQI2mnWAfO0qtqKccOBd/tOi8k7Fk0gQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dtUw95q0Geajx3oGs0seWfCk3LUg1lEQvScPl1MB87g8q9LVQOqgNLLRIX1eKNe62
	 /Pr4/44bmoX5JkoSc/AiyQdCazIMuvIhGZtxQ/6ENBJRdnApNY1lbNtkY8F89WHxsN
	 jEEZONcaLxRSOr9mpztFn6rqU97eF+AlaHyD3+zjX4mMZ16eatIhhdwCAvMly2m5m/
	 6ln9ns31XbwwvKtkpiInnDnwrRpNUSGvQCKv6cafxV7iR32X/IEgYOc5ph/I/fdoYB
	 0l2euBo/5Lf2RSCj2s6TGkru1fAQSaWnZz5nmrIFhjj12STiR3KLwA8IltzmT25qKI
	 1MHuIcg2vQFJQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 868CE47C39;
	Thu,  2 May 2024 16:03:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Remington Brasga <rbrasga@uci.edu>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Remington
 Brasga <rbrasga@uci.edu>
Subject: Re: [PATCH] Docs: typos/spelling
In-Reply-To: <20240429225527.2329-1-rbrasga@uci.edu>
References: <20240429225527.2329-1-rbrasga@uci.edu>
Date: Thu, 02 May 2024 10:03:46 -0600
Message-ID: <87sez06w0t.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Remington Brasga <rbrasga@uci.edu> writes:

> Fix spelling and grammar in Docs descriptions
>
> Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> ---
>  Documentation/admin-guide/hw-vuln/srso.rst                    | 2 +-
>  Documentation/admin-guide/kernel-parameters.txt               | 2 +-
>  Documentation/admin-guide/mm/ksm.rst                          | 2 +-
>  Documentation/arch/m68k/buddha-driver.rst                     | 2 +-
>  Documentation/arch/sparc/oradax/dax-hv-api.txt                | 2 +-
>  Documentation/arch/x86/xstate.rst                             | 2 +-
>  Documentation/core-api/entry.rst                              | 2 +-
>  Documentation/driver-api/mtd/nand_ecc.rst                     | 2 +-
>  Documentation/driver-api/scsi.rst                             | 2 +-
>  Documentation/driver-api/usb/usb.rst                          | 2 +-
>  Documentation/driver-api/wbrf.rst                             | 2 +-
>  Documentation/filesystems/directory-locking.rst               | 4 ++--
>  Documentation/filesystems/porting.rst                         | 4 ++--
>  Documentation/mm/slub.rst                                     | 2 +-
>  Documentation/security/SCTP.rst                               | 2 +-
>  Documentation/translations/zh_TW/process/submit-checklist.rst | 2 +-
>  16 files changed, 18 insertions(+), 18 deletions(-)

Applied, thanks.

jon

