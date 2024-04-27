Return-Path: <linux-kernel+bounces-160827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3FE8B4352
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05FA1C2275F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792512BB0A;
	Sat, 27 Apr 2024 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EA0ZA8AO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38524C99;
	Sat, 27 Apr 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178493; cv=none; b=reV0Q999XtkSbQ4ngZJTrmCXi42yK9CUt+uWBbHB/SEQV+eskyggv5ejpfMKrTvCxx6atBWY0co9AeKEYD9ZfaadovmBp7gQgzgsULZu3L0NW+3tbmi5IEeZzywzJISZF0C5eHfjkdDQ3P2l+Xoi/rnJYhflLlil/OR62xKWLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178493; c=relaxed/simple;
	bh=kKse7qeeWvYrD429eJ96E2SQpo1xJNpEemh1GPmParU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMr8xAmgLG5FgajjOSst4Ccer3aCTksa2zp4L4xmCGrrfgagULmuyt7L/5BkCLrAAt2NBz7++92n5SaIPivsAVaEA5WBlruOWIvqN1FVGnpB27J0ctGXGfCgG963WIpYHtq8PGAGT6+f5AvRqURCFeFKpOYAODlBG7VGa+/FS7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EA0ZA8AO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D12C113CD;
	Sat, 27 Apr 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EA0ZA8AO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1714178488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppcFKN4poZXjHDvsKOT93voOzAgufdEwNDZZHXEhnP0=;
	b=EA0ZA8AODrDwOKKhr/EnSX701lQsrGj5L17CaJge6+UVIrayhIl53AdzIx/N8dAwOKHo5z
	Ji+vaVYbeE8XHh6YeeMuo6o5OpM9k+aO12Lxn5U8EsWJAWFga6DtzegP4+GvRqYDqPk2oQ
	gxvB11QG9xU5VmPuB6TOvHWBu3UP8d8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6940f910 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 27 Apr 2024 00:41:27 +0000 (UTC)
Date: Sat, 27 Apr 2024 02:41:25 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Babis Chalios <bchalios@amazon.es>
Cc: tytso@mit.edu, robh@kernel.org, krzk@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	sudanl@amazon.com, graf@amazon.com, dwmw@amazon.co.uk,
	krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v8 0/3] virt: vmgenid: add devicetree bindings support
Message-ID: <ZixJta_sWoTsaprk@zx2c4.com>
References: <20240419224020.780377-1-Jason@zx2c4.com>
 <ba8e850c-756f-4839-b3d7-db8873f83392@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba8e850c-756f-4839-b3d7-db8873f83392@amazon.es>

Hi Babis,

On Mon, Apr 22, 2024 at 03:29:59PM +0200, Babis Chalios wrote:
> I also verified that this still works with ACPI on Firecracker.
> I also verified that the OF part of the patch works with this:
> https://github.com/sudanl0/firecracker/commit/f382e09a9b1e4453d2b231232d89bcb85296ac87
> patch on top of Firecracker.
> 
> Tested-by: Babis Chalios <bchalios@amazon.es>

Thanks for testing this. No word from the other folks who were looking
at this patchset before, so I'll move ahead and apply this to
random.git and send it up for 6.10.

- [1/3] https://git.kernel.org/crng/random/c/e07606713
- [2/3] https://git.kernel.org/crng/random/c/a4aded1ff
- [3/3] https://git.kernel.org/crng/random/c/7b1bcd6b5

Jason

