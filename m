Return-Path: <linux-kernel+bounces-13460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1BD8206E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B12281A01
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846E4C143;
	Sat, 30 Dec 2023 15:39:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637ABE65;
	Sat, 30 Dec 2023 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rJacF-0004OX-00; Sat, 30 Dec 2023 15:47:07 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id E81F9C028A; Sat, 30 Dec 2023 15:45:25 +0100 (CET)
Date: Sat, 30 Dec 2023 15:45:25 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: Allow vectored interrupt handler to reside
 everywhere for 64bit
Message-ID: <ZZAtBdDIO2Oj+k3X@alpha.franken.de>
References: <20231221125405.229100-1-tsbogend@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221125405.229100-1-tsbogend@alpha.franken.de>

On Thu, Dec 21, 2023 at 01:54:03PM +0100, Thomas Bogendoerfer wrote:
> Setting up vector interrupts worked only with handlers, which resided
> in CKSEG0 space. This limits the kernel placement for 64bit platforms.
> By patching in the offset into vi_handlers[] instead of the full
> handler address, the vectored exception handler can load the
> address by itself and jump to it.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/kernel/genex.S | 8 ++++----
>  arch/mips/kernel/traps.c | 9 +++------
>  2 files changed, 7 insertions(+), 10 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

