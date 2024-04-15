Return-Path: <linux-kernel+bounces-144529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 572918A4777
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97954B219F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CFA79E4;
	Mon, 15 Apr 2024 04:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hql6mJai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287BB63C1;
	Mon, 15 Apr 2024 04:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713156253; cv=none; b=n6rpZ1iVDirvq3Q5Io0m910I4i99+2ulnLJAqeZhp0TpH7aHhZGiZsoq6U5fF1+JoB9XDD7W8XiJd1kKkh2DnAFyK+nIXYCiFwnBI2IhrqTj/L/PYvQvGRCoFGptk0H1suw47LhFxWK1A67gQs7Ykz4Jq/+Zy17IAoZGS6tdrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713156253; c=relaxed/simple;
	bh=vZ4Y9rzHzuTAME5FLTs29rLfQFyi3HdmzoeeAzJchPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=el/mETaY1tHhNADjM7J3lbIDnVQ4HIUJwWOwkwl1zL8WAV8Ag6KTxkiCyl8mNUKr2O4yAoK07cPUYaGOO7ofd/1oaj2ZaD524q7VygEIwQvdADEE6fiARPj/CL1LWGFZp4/QtnnyYvaSVvpXbtp/j8kA5IAQhWep/xX5YPRqxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hql6mJai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D14C113CC;
	Mon, 15 Apr 2024 04:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713156252;
	bh=vZ4Y9rzHzuTAME5FLTs29rLfQFyi3HdmzoeeAzJchPc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Hql6mJaiLst9dQjXchdQd4TdX2v+TlT1PzJlnfWJcmjrAZcfBvLLE61TKyQhyvwkJ
	 aoxaSIsghwzucmGqS+Dn2oYFLdUEZXdhG43Caijf/TyQeHeHfEBu/OmddORO8aDGcx
	 pbfndGFXcVvNDtScOH8S5SqEGTLlO62JCShZcgP6iSeDv/qhu6od2zrQRqdBM+SxsR
	 wTO44oO6oq1nI7urdXSpqaUIJWMiyMqGKf+I2kkdp+/hkooMOTmOs+olGERFUDpeg2
	 Z4tWLQiGlFUs36b9bAB5YMU2z6Kc+tFwlhJT65JtstDsrBtES5rAyjavf5j0EQi/9J
	 d4yl3str4w+Mg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 839E4CE105C; Sun, 14 Apr 2024 21:44:10 -0700 (PDT)
Date: Sun, 14 Apr 2024 21:44:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>,
	Leonardo Bras <leobras@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Yujie Liu <yujie.liu@intel.com>
Subject: Re: linux-next: manual merge of the rcu tree with the risc-v tree
Message-ID: <b147ca95-c0e2-4729-b670-a1ee605369d2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240415123247.0d27eb39@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415123247.0d27eb39@canb.auug.org.au>

On Mon, Apr 15, 2024 at 12:32:47PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   arch/riscv/include/asm/cmpxchg.h
> 
> between commits:
> 
>   07a0a41cb77d ("riscv/cmpxchg: Deduplicate cmpxchg() asm and macros")
>   54280ca64626 ("riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2")
> 
> from the risc-v tree and commit:
> 
>   b5e49f1af563 ("riscv: Emulate one-byte cmpxchg")
> 
> from the rcu tree.
> 
> I fixed it up (I just used the former as the latter seems to no longer be
> needed - I also undid the change to arch/riscv/Kconfig from the latter)
> and can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Agreed, it looks to me like I should drop my RISC-V change in favor of
the native support.  Please let me know if I am mistaken.

If I do not hear otherwise, I will pull my commit out of -next in favor
of those two on my next rebase.

							Thanx, Paul

