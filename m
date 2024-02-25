Return-Path: <linux-kernel+bounces-80222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D54862C36
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 18:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6722816BC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF876182D8;
	Sun, 25 Feb 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CFrZN5sD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6D12B71
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708881044; cv=none; b=GAvN4zAjbJLT/NQNQN3Hf8Mnnmt5mhHpxamZyJrcYVE2COHf8/3YQne/IarLSH5fo+oFNCXw0yvdAfAxymdslodOBamLxCqC3LS4RbJevJR0pYMGVUAdVayisWNZb5vw4PHoyQs8xB/IUH5Op8UUy0eL2JW6PwY/2R/tXUcjWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708881044; c=relaxed/simple;
	bh=R8pqexfgkHZjN5t/xmEc6sMPJXA5Q8cmpxeGc7Y4ngk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn4+huxzjA6J5iNfYHvO0pmbIe8tqS30hDap/B9xU70QLmeBE9BK33frcIDX7cRLgiUbmcoL3aiWl13b/ZAPhRoS/22yD2V34oMOlSu1XomeBGnLobaTxHrkfF+WvDabEdqB4TeKag4DskbOM3Lx7ukmk9I9f4tenTl8EtUnX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CFrZN5sD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1B01340E0192;
	Sun, 25 Feb 2024 17:10:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AiJKIYYIVaFs; Sun, 25 Feb 2024 17:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708881034; bh=K3NjjxIM3fbilSHTxJtaJyRZbuGILYpA/oZu5XVGHrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFrZN5sDDrZ0qvKUnwzug4RS0wWqqUEWn2TVjgvwTjjDaZxj7X3Ir40WiCAjdlp3l
	 2F9fMpTDVgRbIBJwLmJ/ts+1p8Ik0jj6bCNjBIwd5te0Ko5llqlwlS4Kh7AGg4oA1E
	 6TuEOP3NzEAu/ur9D4Fe9qY6ANPkaGPNM4/3iS1woi4POpCSgwmEFv9IemdK5PnRwx
	 3xmOCTOhgkOIZyWODtUC3zFI8LeW6lf4PQOf96TmPShtjaBYYdo7JmIarn19m/WN9a
	 HSM7ytTcSNIJGxd3M1FCeLZoAVou6BjVuECQBtteNUa0JTA1fkOsUj7sK/iQGcYSBj
	 7Jrt7sljSnYPc/1dEEbL9UBcWVcgUy6DJIRU1ifddIkVPewxHPe3anNq6j5CX/Q9dx
	 pw/bgV5/4HhQv4NRpFi/XRqr9MDoOBFKbm+u8lgxBdbgp7iAWJmEjdrLLy685QFAqM
	 hhyBnUR+KjrQPFlHgjsVNILpT81/OQLTVYLDOXfidGHDfxFJYzznPnDDBJG1sitXCl
	 7WDfxBvN0wMnVHuCydwR8MHWTqlpYI0fewN/eBwZXSgAJSFFaZ+4NGBA4VaHPxOB8P
	 IqQFG089hoxPNcWboKWhhRIftm2+JLqy881fSWhxBQzhLvzXZqE5A8sLAyvrXoiqB9
	 KPYr2X4qLLNimA0A/bHA5j6E=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B396C40E016C;
	Sun, 25 Feb 2024 17:10:27 +0000 (UTC)
Date: Sun, 25 Feb 2024 18:10:20 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Biju Das <biju.das.jz@bp.renesas.com>, x86@kernel.org
Subject: Re: [PATCH] genirq/irqdomain: Don't call ops->select for
 DOMAIN_BUS_ANY tokens
Message-ID: <20240225171020.GAZdt0fAu29EuoLgJh@fat_crate.local>
References: <20240220114731.1898534-1-maz@kernel.org>
 <878r38cy8n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r38cy8n.ffs@tglx>

On Sun, Feb 25, 2024 at 05:19:52PM +0100, Thomas Gleixner wrote:
> Bah. That breaks x86 because it uses DOMAIN_BUS_ANY to find the MSI
> parent for a fwspec (IOAPIC and HPET) which gets either picked up by the
> interrupt remapping or by the root vector domain.
> 
> Fix below.

The guest boots fine now, thx.

Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

