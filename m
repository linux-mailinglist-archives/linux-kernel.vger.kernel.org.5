Return-Path: <linux-kernel+bounces-65056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE96B854736
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1F3F1C26BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17151125BB;
	Wed, 14 Feb 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="V8Q8eaEe"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BD1865A;
	Wed, 14 Feb 2024 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906903; cv=none; b=RtfCIyk0+sqLHahn9J/6jfkmAiL2R5Kx6cYZIVMf1OSGMf/DWvAhmCiRK0kKgvlohvVyazdkM62psbIHIJXpujWW6mShkuMa72OKDIIhSsioqumz3oLEuVsD1+ScUEcZURb6s0XzDuPTijiAs235q4T+yDgjG48kYb8lhyVRP5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906903; c=relaxed/simple;
	bh=lO39b6zNEYeGUW+5c7RBIt4+IKBta2UpObk3VpmNdmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLXhnxrv1WB6mD56PimH6CvEM/A7ZoA9dzze457nBZmS9vCJTe26BU3SU53sP7vS0SSTW/VSkpoEzICJYmnDSoB80wSbfOI/VpfD42mS5BzmgfZpgkK7HmFSbLqRxECviHlaa0aETVJr742t3G7dZGwos3CpGn3KUKBxxt03D0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=V8Q8eaEe; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A1FBB40E0192;
	Wed, 14 Feb 2024 10:34:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OIbLX5t72hlP; Wed, 14 Feb 2024 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707906896; bh=lqtQHHBr4vuZ0p95L/voIhIDE/NxuUWvlEEBAYbQq0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V8Q8eaEeyXAGtEupxphSXqIzh+4OTCzraq89eNJbtJJBMo0etxq6YLAY11THccWZZ
	 NMbr4cBcKUvcwj7dUs6eI/2/UrCh+LF6WYTZtQPMUUyQ1EOd6MZvLqlsMeQ+h8HP2Y
	 TIDovqq9Z22jC5odh2eMYcRcxrayBjV4+e4Pm2mqCVdBI0KvLp/WSL7apn2SaRqCu0
	 cRZ1YPUJkqIqLibgODNFevjfWmgFIVDAfwT43dhXAKVW7HDus3081QtK7GgU8WB2UF
	 vgtk2y4U88NrJkbqK0cQ3Iu/sIwoNc5oeqVhza2HnamKvG+5W1ScGF5eM/YTOu+3tG
	 GmuzLp+I9HDVvRIDIIDKLp4MxoiTHRmFqZoMgy/nR50q77o1UDuGeWj1oeeA/nsgLU
	 5u8w/Z9I+XXfQ060+qDlWCkRPEUv0OefU0MPblDOxQvwd7q7VMk4tqxMXjK7YIp4dQ
	 QkaS6BhSwi2lEwyCE1Mc7RUStjydaE9cJBZ1iQ9Gh1iS5Lt6JAzhNEmF3+QLLxBCkE
	 2SbFSBRIhXiGWHIPWIXrfm2G4xST9LTXEo99kc/0Hxxgq1z4A5+kQf0ep7XexS/6Ug
	 wVxjNm8NeKvOJxbCkqTdqfgSObccHKcO5RMQ54GxtyfOnH7X7GEZ/f8fOqc7lfjxIX
	 Yn+BVYj/jTLT7i2vPQ+7gCEg=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 493AD40E01A9;
	Wed, 14 Feb 2024 10:34:47 +0000 (UTC)
Date: Wed, 14 Feb 2024 11:34:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	naveenkrishna.chatradhi@amd.com, sathyapriya.k@amd.com
Subject: Re: [PATCH 2/2] RAS: Introduce the FRU Memory Poison Manager
Message-ID: <20240214103446.GDZcyXRkyf1bFzMh7L@fat_crate.local>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-3-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214033516.1344948-3-yazen.ghannam@amd.com>

On Tue, Feb 13, 2024 at 09:35:16PM -0600, Yazen Ghannam wrote:
> +#include <asm/mce.h>

..

> +static void init_fpd(struct cper_fru_poison_desc *fpd,  struct mce *m)
								^^^^^^


This is a generic thing and thus can't use an x86-ism struct mce,
remember?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

