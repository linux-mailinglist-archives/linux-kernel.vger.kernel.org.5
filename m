Return-Path: <linux-kernel+bounces-32713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9579A835F46
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DAEE2890AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CB93A1BF;
	Mon, 22 Jan 2024 10:16:25 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC03A1A7;
	Mon, 22 Jan 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918585; cv=none; b=gUYew6htka9yaACd/DhFtnFmutu+UqpTe64C4sq2Nz7zR/IOAalCZWqudPKgilJTk8imUqHsadG/51grJ0pDESMQoBPCG019infpFiauejajLq8JJRce+r1pRAxeMAG9QJV7LcCc8Kdof7iO/QjMUdIX5b+MPth2c810ll8hEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918585; c=relaxed/simple;
	bh=2R3QyF3uRlQ5Mls3A4OUEiNQb5dQNkEWdO3XEgaWQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUtk0PeaONTdktdxXFY6GeKgCK5IuRDk1aXzSxttgl2W8yDmtsXQGRlLlHBb+RuR3O8BbgiaLDgohHejEvWntjl2Z3uiD+wic1/Yl4qqVNH2/2QL6Y/+BTPNZ5ReoEm4MqxMcrkhgismZlqxQlxLGR7QZn5Jua5ENKBVQu+zRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rRrLi-0000SW-00; Mon, 22 Jan 2024 11:16:14 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 72416C0135; Mon, 22 Jan 2024 11:13:41 +0100 (CET)
Date: Mon, 22 Jan 2024 11:13:41 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Cobalt: Fix missing prototypes
Message-ID: <Za4/1XrqPLipZWnx@alpha.franken.de>
References: <20240117043101.371421-1-f.fainelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117043101.371421-1-f.fainelli@gmail.com>

On Tue, Jan 16, 2024 at 08:30:59PM -0800, Florian Fainelli wrote:
> Fix missing prototypes warnings for cobalt_machine_halt() and
> cobalt_machine_restart() by moving their prototypes to cobalt.h which is
> included by setup.c.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/cobalt/setup.c                   | 3 ---
>  arch/mips/include/asm/mach-cobalt/cobalt.h | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)

applied to mips-fixes

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

