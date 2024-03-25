Return-Path: <linux-kernel+bounces-116659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B9788A209
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF9F1C25EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5993C1B04A9;
	Mon, 25 Mar 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="g+X8BfP7"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C9B82D98;
	Mon, 25 Mar 2024 07:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711352405; cv=none; b=b1I3wgjEwM0jhN99XkmxmSYUutE/5MiAkz83EnANBDnxLHRRYnmWGSWNF7eqbW2+bnJ8VSur0clDi6ndboKRLeWnzL8HRq+cTGtckWRU9+YcvjPwO2YlFk+KZTy+voli1qJbR9SUStbDva//XkKMCKX1BCdYa/XMpn1lWJiruDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711352405; c=relaxed/simple;
	bh=P57Y9I6HUeQDxtauGaO6GSib3ALlVXY8LaHqz73i1f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7vxoIHQJdSzV5SkkyvWTZWtpya/A8HRZlM/07OxhPvNCYpSk8eTZues/FUl/akCfM2yzL1yy1vXx0rM/wVHX6IiMse1nkBcfyrp8VkHLh6bUpQhNvlVGmopi6IOAone077P9G0DGjDc/dtimh+2ClfmPfsAaHgihq8B+w47WGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=g+X8BfP7; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id F06E1603C4;
	Mon, 25 Mar 2024 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1711352402;
	bh=P57Y9I6HUeQDxtauGaO6GSib3ALlVXY8LaHqz73i1f8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+X8BfP7UAqtNQ8ZFM7VgwQinktNdorUxeqytHyLkjTUiXzCek6R0jqRYD11os0S0
	 boDprVrdjuxGB8ot5GDZXKDiR1R4IhFbYikVjPuGDX9+ayiTdlRiZZePp7USDaO24N
	 T96vqRYLetIHrCZRZnvNZ3lNRLFkBuGvZcTDCpd21OqNUaRHXArL82HnXXGFLRhhsv
	 w46xvAQcj9wJVi3V0dqyWVsTu2nXqp/+8OyCNgXCPfXn+GemV9rPaWXhDOv6U9RkPn
	 +8+xBNcYLAwT6UQ4v1ghKL6YtPZbDzp1my35hOrLiCRsw8rBEhg0zZnlc8fYVzqslT
	 akrkEtlF1mQdQ==
Date: Mon, 25 Mar 2024 09:39:50 +0200
From: Tony Lindgren <tony@atomide.com>
To: Nick Bowler <nbowler@draconx.ca>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	regressions@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: PROBLEM: Sun Ultra 60 hangs on boot since Linux 6.8
Message-ID: <20240325073950.GF5132@atomide.com>
References: <d84baa5d-a092-3647-8062-ed7081d329d4@draconx.ca>
 <20240322051531.GA5132@atomide.com>
 <d7337014-09ac-8a35-7159-e75ecd2707b6@draconx.ca>
 <20240322064843.GC5132@atomide.com>
 <20240322090657.GD5132@atomide.com>
 <193a134c-f0da-4a45-b45a-a3605f91cfa4@draconx.ca>
 <20240323064925.GE5132@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323064925.GE5132@atomide.com>

* Tony Lindgren <tony@atomide.com> [240323 08:49]:
> * Nick Bowler <nbowler@draconx.ca> [240322 14:12]:
> > Yes, with the below patch applied on top of 6.8 things are working.
> 
> OK great thanks for testing, I'll send out a proper patch.

For reference, patch posted now at [0] below.

Regards,

Tony

[0] https://lore.kernel.org/linux-serial/20240325071649.27040-1-tony@atomide.com/T/#u

