Return-Path: <linux-kernel+bounces-148066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF48A7D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04D22814FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1150A7CF3E;
	Wed, 17 Apr 2024 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxpr1qaQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD0C6F065;
	Wed, 17 Apr 2024 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339388; cv=none; b=AuN+Ab8Xx3S4zKRjzUR2aQOZS7my4IURi0xeYAX0z1HGam+7SMsPG0KW39JlTVfj2qr+a7l7l0NbuPIKbQWWxCs+q+ZL3mfAoRQO9N2FFHq/r/ca+ycSvSmxJLu/vB3koSrrNB5Ub80Opy/Gp25AMZoB/k6ojSEAEJC+P6H1h3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339388; c=relaxed/simple;
	bh=qqyNaWkr1bQ20TqnhY9ZIM5WeICxKh/paEFKiMkqgls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo5gTHuHTlIto+MrIEUhWs9UhgM10CBuhbadV4ek/mKv+iJWSQI/0kdwJypNuSJlCJO2wP4ibLdc0sjq9RlVoeGwfOJ2FrEYuOEeJFTohdDczeSU8Cio6bPgB8j8aBtXUtBfepi6Q3TNpuw3zbs87L/fgENnJMdELYj/YuPvbbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxpr1qaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0558C072AA;
	Wed, 17 Apr 2024 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713339387;
	bh=qqyNaWkr1bQ20TqnhY9ZIM5WeICxKh/paEFKiMkqgls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sxpr1qaQPUn8AoYZsQL3FLZLy3Fp+Q7sRKQzVEzAH6oRjIWtpAWRA2K/j/AEMQRDR
	 prS4Nc+prxyj5nhG8W0VwBqpjYvWSS0WKYL8yFNtk+suf3pVDvsKmzejjpjehmosDR
	 AOOFebvqA3plOBwFF9ieGcVBoFn0fffVUW2P3ZYGnwJok0x+ZRxax/3QYQbVRMKP/C
	 HJ9RXV7ROnXDLlF+QEL0W+PyTlN/DUG9/0bpcUY+q9eIhbv1nT+c+Wo5Xn6vnXhBZK
	 W9o8QB5y8L0gmfB39Pm2A/GkNF/djK+wkKk+wsVw5mrAug96B5AE6+U+wpvZS2X+S5
	 uhSRfGlwYP6+A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwzqE-000000007L1-3BbN;
	Wed, 17 Apr 2024 09:36:26 +0200
Date: Wed, 17 Apr 2024 09:36:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Chuanhong Guo <gch981213@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add support for Fibocom FM650/FG650
Message-ID: <Zh97-jls0BP5nHnL@hovoldconsulting.com>
References: <20240312062913.12723-1-gch981213@gmail.com>
 <ZhzNM_zouHPLdvBz@hovoldconsulting.com>
 <CAJsYDVK+Qy-w_Aa9_ns4zZutBJx1HTxm0467chHh0XkLb-4_tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJsYDVK+Qy-w_Aa9_ns4zZutBJx1HTxm0467chHh0XkLb-4_tg@mail.gmail.com>

On Mon, Apr 15, 2024 at 10:46:52PM +0800, Chuanhong Guo wrote:
> On Mon, Apr 15, 2024 at 2:46 PM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Mar 12, 2024 at 02:29:12PM +0800, Chuanhong Guo wrote:

> > > Fibocom FM650/FG650 are 5G modems with ECM/NCM/RNDIS/MBIM modes.
> 
> In all 4 modes, the first serial port is the AT console while the other 3
> appear to be diagnostic interfaces for dumping modem logs.
> 
> > > This patch adds support to all 4 modes.
> >
> > Can you please say something here about what each port (in each mode) is
> > used for?
> 
> Do I need to send a v2 for this?

Generally, yes, but I amended the commit message when applying this
time so no need to send a v2.

Thanks!

Johan

