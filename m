Return-Path: <linux-kernel+bounces-37434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D583B080
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AAE7B30263
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C5681ABA;
	Wed, 24 Jan 2024 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATJhlZuD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F467F7DF;
	Wed, 24 Jan 2024 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117486; cv=none; b=Y2d1trPVipw7wrx9725BBkcr60M3Xtd78eVZRliQ+TnvX4a8QuUbgufdGSrksuEQSQ5mn0rrRk7Qy75VT18AWt3JZGyXnGCRfyggIiEvmjQ/rnkCsbG8VSq/t0mgTJpdlSbzvY08fXqOQIF+hUTnz2y5ysCB7N98Jy92jw4SH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117486; c=relaxed/simple;
	bh=aLmX14WDixfWepTlPL2UfETmkCvxuNoUTIPblBdwtgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvzSlQPMfQK+SC08h3w9LiR8fPG++SeZ8LcWIOy26pgAlR3/UdnMc0GIHk4P6HcYstfhTRIOz1q/nLIrofekIhnK7PhPd7Lfi3hCdj5JEkmqEH8WBcg38AqhV+6Z88S/b7V8A19j3ndOzsi2+l8L9gCuCOsJie5bJ97UAyEVOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATJhlZuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845A8C433F1;
	Wed, 24 Jan 2024 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706117485;
	bh=aLmX14WDixfWepTlPL2UfETmkCvxuNoUTIPblBdwtgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATJhlZuDjQZkEDdr1ptpV1EyONmrejEnPMTGiPqns/587HK0Q1PTbBb2Ux1JtFdnH
	 xfUrNqpFYt4+a38dOdWLLmUEVn6g+xy+SzUEWAiL8KPPmuTfUupd5q53dILmO/3SBo
	 7sOygRELEeMCSc9OxwCEM8pCE3lFgfiD6UAFemyY=
Date: Wed, 24 Jan 2024 09:31:24 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 28/33] usb: gadget: max3420_udc: Follow renaming of
 SPI "master" to "controller"
Message-ID: <2024012418-undercoat-strength-85d7@gregkh>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <f2a5160a4153b1b0f90bb3f84adc57e035d3da8d.1705944943.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2a5160a4153b1b0f90bb3f84adc57e035d3da8d.1705944943.git.u.kleine-koenig@pengutronix.de>

On Mon, Jan 22, 2024 at 07:07:23PM +0100, Uwe Kleine-König wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
> 
> To be able to remove these compatibility macros push the renaming into
> this driver.
> 
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

