Return-Path: <linux-kernel+bounces-119137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DC88C4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD94305930
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB3812F5AD;
	Tue, 26 Mar 2024 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kw+yyoYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A307576039;
	Tue, 26 Mar 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462051; cv=none; b=m0GnDJFOt2adF9+BuBZmtQKi08QF8odyDwNWJyM7muiUYOhLMIBj1w1WvUG4YCxwzICv0QqZ4p4Ke4jqtX7QOsqNLbLz3CpB+KhZELqcKOjCXFrxki4IjeHKpeySFrBNH265B+HSP83fP9m9Wcejkw5wuRY/D9Ib4ZhCWL+PtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462051; c=relaxed/simple;
	bh=n8Ai9WT5E8KuQqv9JDpEM96sX6yIfhCvpLz33RE+NGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUS6jBuwvHOwsjyjQJkMyMVK6Vfc9fWghH5twc+5xUlRG6SMjujUERW5JQb//X5MrGFjn79cX4Fzi2TMNRe5gC1ecQ/iH1a+Bikvn+6N7uvvlMpKjPsd2cLPvBr8nREXXCDU3wUaFmfrizu/kibg0YkippG/r9ANUTwc9YDgMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kw+yyoYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C00C433C7;
	Tue, 26 Mar 2024 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711462050;
	bh=n8Ai9WT5E8KuQqv9JDpEM96sX6yIfhCvpLz33RE+NGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kw+yyoYw+oApGop72Rxpvg2dupC+MUZpXR+IknCgqsX+7U4FvJj8mRoUUi8KP8+J9
	 7Qy+8qs7ZwSe18EzLobohS4lMF5v6akd83jsRr3yVvhUSpFPQpR9fS6yjiYluzaktj
	 EXzRAlUA6a9KnXbBTfUVGB77Ppnxcjzv3/lfJziQ=
Date: Tue, 26 Mar 2024 15:07:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?5bqe6IuP6I2jIChTdXJvbmcgUGFuZyk=?= <surong.pang@unisoc.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?57+f5LqsIChPcnNvbiBaaGFpKQ==?= <Orson.Zhai@unisoc.com>,
	=?utf-8?B?5YiY5pm65YuHIChaaGl5b25nIExpdSk=?= <Zhiyong.Liu@unisoc.com>,
	"Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Message-ID: <2024032616-dumping-blustery-aeb2@gregkh>
References: <9d39b91505c4449f98e8431e2f257f8b@shmbx05.spreadtrum.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d39b91505c4449f98e8431e2f257f8b@shmbx05.spreadtrum.com>

On Tue, Mar 26, 2024 at 10:47:16AM +0000, 庞苏荣 (Surong Pang) wrote:
> Dear Greg，
> Share Android Phone internet to Windows PC via USB still need the rndis feature.

What supported Windows PC still only has rndis and not cdc-ncm support?
Or the other USB networking driver support built in?  Windows has
deprecated RNDIS for a good reason, let's not continue to insist on
using insecure protocols please.

> OK, if rndis will be deleted entirely, this patch can be abandoned.

Eventually, yes, but as is, your patch can't be taken given the quick
review I already provided.

If you can show that there are Windows systems that only have RNDIS
support, and need this increased speed (i.e. that they can also support
the speedup), and fix up the other issues, then we can review your new
submission.  But please provide that proof when you do so.

thanks,

greg k-h

