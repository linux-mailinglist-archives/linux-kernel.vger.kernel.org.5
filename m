Return-Path: <linux-kernel+bounces-5572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F0A818C75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D052876D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CA1208BC;
	Tue, 19 Dec 2023 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OppyjfV7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B843B31752;
	Tue, 19 Dec 2023 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2C9040E00C6;
	Tue, 19 Dec 2023 16:40:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Rr90sW9rsmbo; Tue, 19 Dec 2023 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1703004010; bh=N8TQERT7AY2VyJaorMXPyl/oOPj/llXaA3DFOWpy1Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OppyjfV7405XNI1UY5ZHnCUGpzNOREqLzP5oMwhiKRTUxQ8xqpvmYwz1NFZ4rxJaA
	 8OPE7/X4H/cfnj/MFWvE4yMqbSxjvbbVtPkYCNAcC7GrliAVCrAI9X1CMws1hXyrrf
	 NXnxHv+G3vbOrz0lX6VBC+Z5GXi9xhv2lBEv6RXudAY3mG+edq5qhOe72lhvr1m1cm
	 z3b5PdDK3/wZi02Paq9kP5b4HqXJS4HyX+fob5zPhtaKIa/xH9gIhNXLjG5YU5xRgc
	 KFNfHzMB84W5cyJsp5vNURqbEsHmDL182GJAddiarA8iPbnIwnZKs6r1RVryaVhTIr
	 SfstgSIZ7XP9q4RwfqBF2bVrH3+GXNSNTno3ynWs0mQsxLfn2UuNhvuUKENvdoVNjc
	 Km7mNR59htLEXRLGj+5BzQoYvuIT6EtDIh3tcZ65ym2Bp6+3PRqTQ25nwKQrdzwmt4
	 PY+8mTkVC265aIQWMCuO3QvJ+L8+cJc8Vb+wNccQ0+2oQwTvltjg1WCmJIfx/nhg4J
	 dyNke5T+x+scmfmqm+BaVTvVO24lIYtN2rGv3qwehuPnqR1QFr8ftuU1OzfbkEM0+a
	 g/AqbAZ/iFKqEo/gY/rQKHKURu/pr5BQkbJWfgmZAvVYvop0KE1qbhpGbEWQJbTiVo
	 P1haWAvY1xOFnwjtp3jjDVno=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F6B740E00CB;
	Tue, 19 Dec 2023 16:40:02 +0000 (UTC)
Date: Tue, 19 Dec 2023 17:39:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	avadhut.naik@amd.com, tony.luck@intel.com, john.allen@amd.com,
	william.roche@oracle.com, muralidhara.mk@amd.com
Subject: Re: [PATCH v4 1/3] RAS: Introduce AMD Address Translation Library
Message-ID: <20231219163956.GTZYHHXG0rSNKZyIOd@fat_crate.local>
References: <20231218190406.27479-1-yazen.ghannam@amd.com>
 <20231218190406.27479-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218190406.27479-2-yazen.ghannam@amd.com>

On Mon, Dec 18, 2023 at 01:04:04PM -0600, Yazen Ghannam wrote:
> +unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr)
> +{
> +	struct addr_ctx ctx;
> +
> +	if (df_cfg.rev == UNKNOWN)
> +		return -EINVAL;

Right, I know I suggested this but, will we ever have valid system
physical addresses in the range of

0xfffffffffffff001 (-MAX_ERRNO) - 0xffffffffffffffff (-EPERM)

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

