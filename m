Return-Path: <linux-kernel+bounces-86182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B286C0C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BADFB20CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095BF44C8D;
	Thu, 29 Feb 2024 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Arly37qj"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6645A44C60;
	Thu, 29 Feb 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188682; cv=none; b=U4Le7Um+sc9Efda1RKmL7J9nQQ2wg1weQXkVfsftj3mwP70g9bW6rWqVEfkH4UE5EDKUcl6T7KJpu+4UYM/NemXC5BlGgmDwEUbujnaMbN2g0khKBacLiP2yjk2MyNoaMi+NDoVQs17iw1sqvGMm5MWdzno5b1tCW/uF2smi0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188682; c=relaxed/simple;
	bh=TYRAVAH4IMfHLxfWypr9OolYo0gumgQZwdK+S3nsvvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t9w++9p0LMUKebGTfEzarCcnjQqfAp88uIztcqIYyUCbH11wM8W80ZIiFzbWGkKpsgRAjbYQJwNHms9ooydIKotq1o6qvHp6XENpDVev3aHI7Z/0nvbY0TboYnBF15ndZ3yN33KUfZ39/s8clB6pqBPVnO2mbwHPXHhRdt2500w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Arly37qj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1709188677;
	bh=8jp6tWwTFbOuHhqd3QihKvXNUZOM/iJjGERmYJI7sHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Arly37qjNDRDE7QhxbFdyAL000Qjzjoq28bx+VH7Z6wIOdjVZ71anNzdtIiVkQKg5
	 ZX2fM0qrQc9sDT3jR85bk4fSubV6lggkWPDNA9ZyRDuHHWaQ5k/WICwdTrUMB8XyCz
	 ZNfzQF5lcttHCAlQs8lGTz23/CMHOAjYwYDAz3it386OpTELvrVukqRdhI6UUasuJE
	 LuzRpZIBkwVYdBEMq0AQsiN6Nx0bawnrtCk1Y6MqbUZesV0tEh79E1CutcW1JRIJxQ
	 eoVf+cEN/G+T51n1XPZ99AvBUf6peStnrS88s51bmvv7gGZU2jp/+FvQ4D4vaOlEmC
	 97niIGWdGcvcQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TlhP12CMDz4wcH;
	Thu, 29 Feb 2024 17:37:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the mm-stable
 tree
In-Reply-To: <20240229101721.58569685@canb.auug.org.au>
References: <20240229101721.58569685@canb.auug.org.au>
Date: Thu, 29 Feb 2024 17:37:57 +1100
Message-ID: <87ttlrg4hm.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   arch/powerpc/mm/pgtable_32.c
>
> between commit:
>
>   a5e8131a0329 ("arm64, powerpc, riscv, s390, x86: ptdump: refactor CONFIG_DEBUG_WX")
>
> from the mm-stable tree and commit:
>
>   8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and mark_initmem_nx()")
>
> from the powerpc tree.

Thanks. That's a fairly ugly conflict.

Maybe I'll drop that patch until the generic change has gone in.

cheers

