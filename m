Return-Path: <linux-kernel+bounces-101538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E8387A86D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783C21C21B01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551C4E1C4;
	Wed, 13 Mar 2024 13:28:06 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE243AD9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336486; cv=none; b=Gv5V75zTV8pUQgaashwfTifKMhQEmD3zAhMJMjU9oQZLEuMHjXh4HOeHjGe606otjqGyqd7Ij1iN+z90PS/RRKwIKKN2y3C731qKNMuqpAuRBt9koOSoXsGKgKGltNxSxYrpD78Z6Uayptgr1eAMUClh8tdSjKbxgxZmag/CuiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336486; c=relaxed/simple;
	bh=eUCcHp2pFU7IHx+l+V8Sy8kQ7qcKrmwjeTdIf98BhaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F4LH3nX0pAxWaQGaEqfSgulhzqgJnGPuZTHvZWp8tt2Zxir4ikN/GmtwBTmUPSO/hl5JaoG1eclumm3VqqBpXc4m6T0kpRgmFSXiqwWt14U/tBRwnZJ1vPtv0JWLXsA4tl+2VRT78Cle+gNUG+QtPnZBdwsmgrq4kLMPeI27PqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvrtC0L8Sz4xFf;
	Thu, 14 Mar 2024 00:28:03 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Sathvika Vasireddy <sv@linux.ibm.com>
Cc: peterz@infradead.org, aik@ozlabs.ru, mingo@redhat.com, christophe.leroy@csgroup.eu, mbenes@suse.cz, npiggin@gmail.com, chenzhongjin@huawei.com, sfr@canb.auug.org.au, naveen.n.rao@linux.vnet.ibm.com, Josh Poimboeuf <jpoimboe@kernel.org>
In-Reply-To: <20221215115258.80810-1-sv@linux.ibm.com>
References: <20221215115258.80810-1-sv@linux.ibm.com>
Subject: Re: [PATCH] powerpc/32: Curb objtool unannotated intra-function call warning
Message-Id: <171033598340.517247.3682725503551770232.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, 15 Dec 2022 17:22:58 +0530, Sathvika Vasireddy wrote:
> objtool throws the following warning:
> arch/powerpc/kexec/relocate_32.o: warning: objtool: .text+0x2bc: unannotated intra-function call
> 
> Fix this warning by annotating intra-function call, using
> ANNOTATE_INTRA_FUNCTION_CALL macro, to indicate that the branch target
> is valid.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Curb objtool unannotated intra-function call warning
      https://git.kernel.org/powerpc/c/6035e7e35482653d6d93f35f01e1a320573d58f0

cheers

