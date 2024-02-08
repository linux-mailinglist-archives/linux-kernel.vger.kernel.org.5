Return-Path: <linux-kernel+bounces-58221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4D84E304
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8521F23021
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B478B63;
	Thu,  8 Feb 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fn+y3RHy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F076C61;
	Thu,  8 Feb 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707402073; cv=none; b=fAfvDVagsLu0v9glVxyLSEDZ4TVLyxMt6bV7pCkBKTcGXESX7Dj7RfEYRiA/Gb75K+d0uk8aQpxcreibYfgY4hayWCyoYE1mrD55JXgVzB6APH27EuMRF2J5vDN8dNNV07Cdin8Xi5TzJLxQLUzgo2qTitAgoS/5HSohGQdweT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707402073; c=relaxed/simple;
	bh=GaDeZXV4dc2OYZJzYMgwmK8hKNrvFyr+yDQf6sSNIXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCCV9vlR24Kl6rill2lyCySG363Csm2T8eupiJbaOiCoMZ9YYEaSu+jOCHWnlp7u/ctPKO8cSR3dG452JVozh5K8Z/Nzz5E4T9kH5RaBL7t9oJL8rFgPu9EqCqp0pGQl74/RWaoiAhEe6uUtjA6EL5Cj47BRptJKhkPu9kJ7bEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fn+y3RHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2CFC433C7;
	Thu,  8 Feb 2024 14:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707402072;
	bh=GaDeZXV4dc2OYZJzYMgwmK8hKNrvFyr+yDQf6sSNIXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fn+y3RHysctmIDC/Do1HGOtjfDSDwnnGT/+4hKdAUbqXwI42Okt5iVA9d8JKOBfTB
	 frBD078E/+EK9IAWGrB2QygvqVUmBvI70OsNNS7VoSLA4lLmqnuPoul2m8DLC814gE
	 NtT1SM4eWSeDtFqbHL+Z11mu7CYa5wf4O//ucVWOvDE5cPNWAtPg2vEmJAPKb8B8EC
	 d5meRShQhNULpoh/V+32qAyPvYxO4clH7XKyw86EnHTR4GXl8LZ0JxXn1yefGKRhOy
	 +H1TghCxlEbaP58TGSi0VUnN4KN14vWFGoV6GbAcybe5ZYTkJvGCUklc33lYVpDxCW
	 nMJ6ui9A6t97A==
Date: Thu, 8 Feb 2024 14:21:08 +0000
From: Lee Jones <lee@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
	Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: linux-next: Tree for Feb 5 (drivers/leds/rgb/leds-qcom-lpg.o)
Message-ID: <20240208142108.GS689448@google.com>
References: <20240205162653.32ca0d08@canb.auug.org.au>
 <c50e4e60-8e4b-406f-9bac-6a45c083a41c@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c50e4e60-8e4b-406f-9bac-6a45c083a41c@infradead.org>

On Mon, 05 Feb 2024, Randy Dunlap wrote:

> 
> 
> On 2/4/24 21:26, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20240202:
> > 
> 
> on riscv 64-bit:
> 
> riscv64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `.L0 ':
> leds-qcom-lpg.c:(.text+0x106e): undefined reference to `get_pbs_client_device'
> riscv64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `.L468':
> leds-qcom-lpg.c:(.text+0x1d64): undefined reference to `qcom_pbs_trigger_event'

Fixed by: https://lore.kernel.org/r/20240208110748.GJ689448@google.com

-- 
Lee Jones [李琼斯]

