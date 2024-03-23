Return-Path: <linux-kernel+bounces-112147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78788763C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D369B22186
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22033EC2;
	Sat, 23 Mar 2024 00:46:38 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765B23211
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711154797; cv=none; b=UXjFgwm+hN6Bw522yMD5yjPEe+kKQOwAHMHVL/nq/DO96CHUe5rJaG07YjUb+EZbry7CeiWrB++Y07YtD3fG7nwOFtLUvbtBYYLE9+a/Off8Gu16e5oZPrAi+K1R10FTnLcwGhdJxaeLVwsw09nyuYtQ7LXcIZBGGRvNxE8A8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711154797; c=relaxed/simple;
	bh=xD4+laVQvCkPOG3yzzH2yCCbiBOFUt/MY9ihzz7uQzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R+bcNRwSUAMA1ByXDH4J3Nxx/YlJo/4BW1QziuopfNqWOrXlgu6svWj9PcKiGhGobeRTV1ewBVKpSrOwZxUSE29OkpElbDAeVPoUsyjJpa7KTYmrwy039rU4aB5Mt08+JjPobLeF61A3M3+4KWR4/PQs0LbKNT5t0K5c0gGVwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V1gVx0P0Fz4wyl;
	Sat, 23 Mar 2024 11:46:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b16329611deb89e1af505d43f0e2a91310584d26.1710587887.git.christophe.leroy@csgroup.eu>
References: <b16329611deb89e1af505d43f0e2a91310584d26.1710587887.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: Handle error in mark_rodata_ro() and mark_initmem_nx()
Message-Id: <171115475788.936455.13882639894804019812.b4-ty@ellerman.id.au>
Date: Sat, 23 Mar 2024 11:45:57 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sat, 16 Mar 2024 12:18:21 +0100, Christophe Leroy wrote:
> mark_rodata_ro() and mark_initmem_nx() use functions that can
> fail like set_memory_nx() and set_memory_ro(), leading to a not
> protected kernel.
> 
> In case of failure, panic.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Handle error in mark_rodata_ro() and mark_initmem_nx()
      https://git.kernel.org/powerpc/c/78cb0945f7141961781f815168f6873ad2b7ed29

cheers

