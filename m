Return-Path: <linux-kernel+bounces-42495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B469284022C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718C1284F62
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E6655E41;
	Mon, 29 Jan 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oaqej0ZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAF5579D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521904; cv=none; b=LptdzPsBG3MUiewf37KyLOFg8IU+GwlFqewzZKja3zH8SRikeglDESddiPNwkWJIL4/qawSkkoD3Ns0R1Bgf3fKBIR52YDL0rhxvjh6QuABeMwOE9ZkxNm4JWg+ofMBfCseBDxvOFol+3z+iEwl0VjxA4C+X8EgMqfoQT9CII7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521904; c=relaxed/simple;
	bh=pPcqsz1uE3yIcm/qTdgdW4qxwK1Hx8R1HyPonk2uprY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0hShGNk/hxf6QFWrcP3MyBH2740PRBks0zdRcnS077MTXtfTrgTB+6qh+El72aM+w3bzzhMa5H3zqzIpViuwLq5Xsa0cOR+cNvbXyw13cdH+V/LT+QJW4C+kKc8fDLM+c+OkrAWqP4u+w86Yiqhe+2NQOAbn6xqAonrftjz9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oaqej0ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEA8C43609;
	Mon, 29 Jan 2024 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706521904;
	bh=pPcqsz1uE3yIcm/qTdgdW4qxwK1Hx8R1HyPonk2uprY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oaqej0ZZ+tvwKJxMIRiPCQLm/V6l8p1aL0VAtqTi0s8D9hH7dH8niv1rBxXPTD78k
	 sn+ZxKcQ/phWalG8E0pi1o6nicXKbjsyVyK3ofnNJJFAXF1I0kdS4II2+Obj1hs5dh
	 Gc5ATdyDlG97DC13v2EpHxVVkrU2/7JH8UfAcdYX+8UKZsQEdbHyDxPgvyxNVHVbIr
	 9+8GIFKQL+23YlvYTwlB8VUsjEbAvQwWELbyrVHXAdOXYYNTS2fGj5EGnyETldEBBC
	 o9JYsU/52KZuWTGX7wFgmOAP3nAzL9lbAUgEa3AWcGqKywZsVVx/i2byqWZC8DPHdw
	 b4Uejvm5Pu5MQ==
Date: Mon, 29 Jan 2024 17:38:52 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com, samuel.holland@sifive.com,
	ajones@ventanamicro.com, mchitale@ventanamicro.com,
	dylan@andestech.com, sergey.matyukevich@syntacore.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: add uniprocessor
 flush_tlb_range() support
Message-ID: <ZbdyLJ24I2fa6oNb@xhacker>
References: <20240125062044.63344-1-cuiyunhui@bytedance.com>
 <ZbdYijWK1PnHXn47@xhacker>
 <CAEEQ3wnSN8dLh3FcmHq5yPwQRdjLQa_VjcuTH+7YYZLOqCzaCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wnSN8dLh3FcmHq5yPwQRdjLQa_VjcuTH+7YYZLOqCzaCQ@mail.gmail.com>

On Mon, Jan 29, 2024 at 04:26:57PM +0800, yunhui cui wrote:
> Hi Jisheng,
> 
> On Mon, Jan 29, 2024 at 4:02 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > On Thu, Jan 25, 2024 at 02:20:44PM +0800, Yunhui Cui wrote:
> > > Add support for flush_tlb_range() to improve TLB performance for
> > > UP systems. In order to avoid the mutual inclusion of tlbflush.h
> > > and hugetlb.h, the UP part is also implemented in tlbflush.c.
> >
> > Hi Yunhui,
> >
> > IIRC, Samuel sent similar patch series a few weeks ago.
> >
> > https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.holland@sifive.com/
> >
> > After that series, do you still need this patch?
> 
> Thank you for your reminder. I didn't find it before I mailed my
> patch. I just looked at the content of this patch. I understand that
> my patch is needed. For a single core, a more concise TLB flush logic
> is needed, and it is helpful to improve performance.

Currently, riscv UP flush_tlb_range still use flush all TLB entries,
obviously it's is a big hammer, this is what your patch is trying to
optimize. I'm not sure whether I understand your code correctly or not.
Let me know if I misunderstand your code.

After patch5 of the Samuel's series, __flush_tlb_range is unified for
SMP and UP, so that UP can also benefit from recent improvements, such
as range flush rather than all.

Thanks

> 
> Thanks,
> Yunhui

