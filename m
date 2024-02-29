Return-Path: <linux-kernel+bounces-86147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44786C066
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1736928875D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F273BBF4;
	Thu, 29 Feb 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="sF65JYxY"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C22E2CCB4;
	Thu, 29 Feb 2024 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709185723; cv=none; b=pLhEQTAcMu5yAYIZ5F5wErJdaH0+4d8I/sCzNE79FXPtW1hrcDNYMYg2If5lfGrerEhI3Cof9fg7O5iemRJLA035+0xMs9wn9wa4eZP1T3dwLicY2UK+gFKKThQ1yUcct92IEMW+mofMyz5S4uoqPBjpUjz8k0bFZcf3hajFb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709185723; c=relaxed/simple;
	bh=tDQKgdaHcpbkKuo/kf6JeayU7YHnwAHOd5IVTL7HkJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVifNoZvsPhcKE7mstAniAkfq27SZE1HcBPLN2lulqlRC6dseNTcNeA1z8DljxAoCDC41oBd0f7NXZDZcq0XcWwwvClbE+g5zZIy82RAgncpyA4vDILpLC+PzSbqEnqu8IvOoliL+B/sQqNGNOApxcELhq3NKUq8sQDqdiTWojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=sF65JYxY; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 5ED7C6045F;
	Thu, 29 Feb 2024 05:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709185718;
	bh=tDQKgdaHcpbkKuo/kf6JeayU7YHnwAHOd5IVTL7HkJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sF65JYxYrDt48aFF3Agq0mdF9wwwsusp4wAkXtttjH+J2wUdGDAxBJd1nvjHF/G+a
	 znvPAaCDDywsOK41KhnW55QfJO57e9CsVXIcVUQOwU4LG+CRcc16YUiuGRsrBvoYmo
	 bachV/qV5xsgTi+FB9PmKXn5aP7K7bLOkscBGKNJMuPi4xz9bJPBwmK5Sk7XuvqFiM
	 hDBjOpwLq7XCngakzPcu/potKcsYrdFo6kAubuVl8DaIjRcUNAzVWsu3Ie36/85iXz
	 wkIkkgb/bCMBERxV8ms1/tUuF1qZ5NWQf4QtniMoBxDpzBttO3qUSMtZg/U0KlBSER
	 fJgO9wx07V/NQ==
Date: Thu, 29 Feb 2024 07:48:10 +0200
From: Tony Lindgren <tony@atomide.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: clock: ti: remove unstable remark
Message-ID: <20240229054810.GG52537@atomide.com>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
 <20240224091236.10146-2-krzysztof.kozlowski@linaro.org>
 <2df72cc0d2be877c1f6eda8ebcf79508.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df72cc0d2be877c1f6eda8ebcf79508.sboyd@kernel.org>

* Stephen Boyd <sboyd@kernel.org> [240228 22:59]:
> +Tony
> 
> Quoting Krzysztof Kozlowski (2024-02-24 01:12:35)
> > Several TI SoC clock bindings were marked as work-in-progress / unstable
> > between 2013-2016, for example in commit f60b1ea5ea7a ("CLK: TI: add
> > support for gate clock").  It was enough of time to consider them stable
> > and expect usual ABI rules.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Makes sense to me:

Acked-by: Tony Lindgren <tony@atomide.com>

