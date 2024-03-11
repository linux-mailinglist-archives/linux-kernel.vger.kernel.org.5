Return-Path: <linux-kernel+bounces-98999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B559287822F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AAB28535A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4591B44C8C;
	Mon, 11 Mar 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="dbH5KVPf"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628C43AD6;
	Mon, 11 Mar 2024 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710168610; cv=none; b=JO07krPJfpBCkAcdWu1f/Uc3MaB44SH0g3bt6AmQcPfwVZxzyhKv5ww9sKbF3iJ3Xa2wftT3c0HPMY1kRGkPNh6i3S49PjN51lWlkWYZEMzjTxkJlTmkWPatjCZwPPUK8SbISKzvzv3Mba2wKGq00jK7ag+0bWfQj5rPqfMAnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710168610; c=relaxed/simple;
	bh=kBJKJg20FxGUAl0PY8lgXbL0cPSGy5Z7z9B/93YIOqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/971XYo/32aCo2OzXb+B6JBlBOcLmK95hbnawSkCKYDw+I8h5X5TLF2F8B2s9ChScHwhKEBaabGznBtcAx9bsYpjr5ZJSfbwqF77RIDFko3/osVVkJ236zyGTwGQdk2E3p+5m0Rs3SQFVBsWaW/K+VwsWHbImyctue/4we3Ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=dbH5KVPf; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1710168606; bh=kBJKJg20FxGUAl0PY8lgXbL0cPSGy5Z7z9B/93YIOqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbH5KVPfMJ+o2z6SyLKtamYMfMqMVPzfeLzDPI7WhFQRnNNW1a+uFupzmIEU4K46c
	 s8aZOUjdfqlkmCfvxa2Jj8PVeER0cZxzsFJOjD3AaiofIWS9McEhomabp0E0KLud26
	 1Zpw6laH37h4AAMT+UNNNa40hPSQalem74qJFVS7nQNKnXbSS7wYVqCD4RLEYe4JCR
	 BEoUU8mPegU0VgTIbtJY83ZBz/A039HGgz/MzW8AD9b6osc6zsLAyFybHxAjmGpQAQ
	 /0Dg5SXzGxGwFnhcm6PuNOvsycfhKefKNUDq6hpYgHJDhWY0WGkBMpjv8KqyWYymmS
	 Ur3f+eG0Xi7Rw==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id D49EF100100; Mon, 11 Mar 2024 14:50:06 +0000 (GMT)
Date: Mon, 11 Mar 2024 14:50:06 +0000
From: Sean Young <sean@mess.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v1 0/5] media: ir-spi: A few cleanups
Message-ID: <Ze8aHt0Q2iwFWb8i@gofer.mess.org>
References: <20240305174933.1370708-1-andriy.shevchenko@linux.intel.com>
 <Ze8UTyZQ_Ev6s4fz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze8UTyZQ_Ev6s4fz@smile.fi.intel.com>

On Mon, Mar 11, 2024 at 04:25:19PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 05, 2024 at 07:48:25PM +0200, Andy Shevchenko wrote:
> > While removing of_gpio.h where it's being unused, this driver seems to
> > deserve more love. Hence this series.
> 
> Sean, any comments on this series?

Looks great, I've applied it to my branch.


Sean

