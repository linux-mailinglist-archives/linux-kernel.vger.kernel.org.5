Return-Path: <linux-kernel+bounces-68956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169A3858266
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7371F2622C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F5130AE5;
	Fri, 16 Feb 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="LPjR3/f8"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3249312F5B4;
	Fri, 16 Feb 2024 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100701; cv=none; b=aZLN6yasy4Q1+ODrezI5S7BUfwT7Nu6fzjtKTzZHWwS1tGPXHjXmUp2nlIuOM/cm+5i9ypeUJts20q55woaShEuyH1icRqEdjnousInaT1kZuiWgLFlVB0GDp1w8UUiV06kJ7yJPDgfrvtL3Qwb0WzDLyxf7ePTf3ZEDudQ0fzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100701; c=relaxed/simple;
	bh=IiwebuLg1zAARr3zoXcuN6fqMxygnCfTRjlPE3fRF14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpIxiEoLnCKqUMZOqq1kNdYRSHqNvvto58ui5r0Fl292PZ3kRAmiRSyG9q37vM3fs5AyMUjfyboGmnbpli+B4md66DFufEJWqbQGsl21ZWSzkcDo9wWcvY8XwKywdeYaBywtEQbCYVijaaFJ/4ezy2xHu05ClMbdvwOwU8V7cmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=LPjR3/f8; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Tby2K45qDz67wf;
	Fri, 16 Feb 2024 17:24:57 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Tby2D5ngbz681Z;
	Fri, 16 Feb 2024 17:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708100697;
	bh=ADpbRI1kQeqTzulD7Oa4Zg31R5ifUeD8WHrikku+Xt0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LPjR3/f88cY9uta25ku9CYOv6/y5QHmajJ7iLE74yMRPOH6vukHDaBZB1rj6kxy3I
	 5zwcsqYXoZQ2LSb+vZCn0n7A/CWHibS28xdTHDQIUZEUL9UBBuLZ6vS78IuuI2VhOl
	 7X23KHrEE4CzrTIrPmDrrC2wr02O5K3l4vWdOTjA=
Message-ID: <35253cde-17d0-4089-bd51-fdcdcc5549a4@gaisler.com>
Date: Fri, 16 Feb 2024 17:24:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: select FRAME_POINTER instead of redefining it
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org
References: <20240215135749.1909812-1-masahiroy@kernel.org>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240215135749.1909812-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-15 14:57, Masahiro Yamada wrote:
> Because FRAME_POINTER is defined in lib/Kconfig.debug, the arch Kconfig
> should select it.
> 
> Add 'select FRAME_POINTER' to MCOUNT. ARCH_WANT_FRAME_POINTERS must
> also be selected to avoid the unmet dependency warning.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Applied to my for-next branch.

Thanks,
Andreas

