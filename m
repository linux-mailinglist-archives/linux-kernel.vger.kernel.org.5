Return-Path: <linux-kernel+bounces-129380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF8D8969DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF261F2A9F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621DE6F506;
	Wed,  3 Apr 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="mIsoNQEB"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529525C61A;
	Wed,  3 Apr 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712134879; cv=none; b=pd3b1VWqbynQ0cLilC9JdbwsuwSuCuHk1sD9SplyJHi9iwjIaqVbNlXi29ba7EIGgtQWF+I0IV9Wl7OrbtvOGkUD151qoAARd2WGndqa4HlA+zlaZIx2YF1sg+EymjtWI8AePLL4jiepKXEA2ayEur0cuCYGYVdi8DhSbHOm27c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712134879; c=relaxed/simple;
	bh=RwX4+h2W/jkk5/PNkcJ79ypl7zLQ5SQh1pIdrH5iB+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4J6N28eE86km7RF/gngGRBtIlGki/Ctl5WquDnEKQ4AJLwSX6/BIe+5OkWWwS3U7t+cNPNNSbkPBRAYd6eUqPX9hZ5NXamP09yvuQf3bGrKVJ3Wo4KvpWaomdo7bRe7MNkCIVPAvVk0fKZ1emwMkmvmxdXfyrWGFpMv51j2TIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=mIsoNQEB; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 4475A60857;
	Wed,  3 Apr 2024 09:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1712134877;
	bh=RwX4+h2W/jkk5/PNkcJ79ypl7zLQ5SQh1pIdrH5iB+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mIsoNQEBk0aiA7X2MuNEp1LJktOrPDulD/e/0dPoe+cKItMgYoSHGXLz9rSY2Pe2Y
	 GR9JF/amWclvdSjJt73wY0hN/7FDJiMiJ6fMRiQlQp+ndNvQNKjnCeu6tt1bBDK0yR
	 ZAGmjFaRK/L/bE6ARsdziVkLiR2Cp7I7wo26zr07wUAzSxY2KiWsw+FkFSdS7vzgSN
	 ltFU6FMPmH30HBRCQl+PhMy48xf6DAIBsNZWzqKLK0ebnHrRChdTOtkRtAZDiiPFef
	 vEIV08VMsadL33T1E9D9UpH4A+oSaNShw2AxFiWtEbuyvtdMy2BEeIEj9W3pFRT6SH
	 0HDiBEAEfBZzA==
Date: Wed, 3 Apr 2024 12:00:58 +0300
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 11/34] clk: ti: dpll: fix incorrect #ifdef checks
Message-ID: <20240403090058.GM5132@atomide.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-12-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-12-arnd@kernel.org>

* Arnd Bergmann <arnd@kernel.org> [240403 08:18]:
> The problem is that the #ifdef checks for some of the structures in this
> file have gone out of sync with the code referencing them. Update these
> to match the current usage.

Looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>

