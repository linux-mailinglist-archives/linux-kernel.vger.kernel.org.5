Return-Path: <linux-kernel+bounces-63379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48858852E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86111F25AEC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1362BB06;
	Tue, 13 Feb 2024 10:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="wnGlKvIv"
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B55250E5
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821691; cv=none; b=Dqg9rE2y6p1Chz3EGmvnCihUcldnEsAoavmyoObAylQ7dN2eM+WQUDKNHynjhTUdBrDD37sg6Wykkmjk4rnDc/2YkaoRcSp1y8f1kK1FdZV0HhfQ3fMTDBdhlYBm4fuKQVhRGv8yib3VZZygbT0uRWl0UIpo0yDxJdAegHHlZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821691; c=relaxed/simple;
	bh=U6sw6/b7Wo9TPD1nNjD1SdrmI2VZciuOyU4cyudmr0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzuXOO7fUrkilnu2Uz9vIBrkS/VZet76+FKDAaGPEhke193Q/Vnd74bjdiyHBnEJPzyggKrXYnTudkAGzCMxat4314GEigiafUMlXAYLMuXt4rDFbHPmuWeuMVAbZHpNIa8/pu1hXgpY5mjDPdbELKUw5oEpXj1fuYf5dg5lsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=wnGlKvIv; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=U6sw6/b7Wo9TPD1nNjD1SdrmI2VZciuOyU4cyudmr0U=;
	b=wnGlKvIv1slYWYzQEBrWd562FM3Cqqr5ngwXuAMN/Pw3ciXu4VaGQzCANZyelSPIw8xFujzEjfx26
	 u6EkCmTWAaVxZ/MUyThc7tWsWjBdQV2EHCgF604wYcKONqNgflwU/EVke6/QQthE/z1NGlxNaImDFa
	 i57TTXbj+rQ6n0OHl1n+GYi3VweVVYj78CDX4L1VegvH2056Dmk4nYWEJMqLaYHDcegzrJ9VzFge2o
	 gCt1VBKVwIU7mwO2eNrXb4njSAFL6+smDV8RBs+NDznTAU3VnvItZOVMGKVtFUltpOGEBqjIR6Ifsf
	 9AiAJodlgrJOAZ5qHbbw8I9Zx8USeyQ==
X-MSG-ID: 248259d2-ca5e-11ee-8d57-00505681446f
Date: Tue, 13 Feb 2024 11:53:38 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel Ojeda
 <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>
Subject: Re: [PATCH v1 10/15] auxdisplay: linedisp: Provide a small buffer
 in the struct linedisp
Message-ID: <20240213115338.2311c4b6@ERD993>
In-Reply-To: <ZcpMLXTfc95fGTae@smile.fi.intel.com>
References: <20240208184919.2224986-1-andriy.shevchenko@linux.intel.com>
	<20240208184919.2224986-11-andriy.shevchenko@linux.intel.com>
	<20240212092500.62f006cc@ERD993>
	<ZcoF9ZxPBkVS_6Da@smile.fi.intel.com>
	<ZcpMLXTfc95fGTae@smile.fi.intel.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Andy,

On Mon, 12 Feb 2024 18:49:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Looking again into it, the allocation separately with linedisp structure
> is indeed too much invasive. I prefer (as we save lines of code and deduplicate
> the buffer at least for two drivers, including a new one) to leave this patch
> for now. We may rework it later on. Do you agree?

Agreed. The additional overhead is probably not worth it. If the buffer size
needs to be increased later on we'll take another look.

Robin

