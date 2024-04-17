Return-Path: <linux-kernel+bounces-149033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6E8A8ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58421F2196F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFD173332;
	Wed, 17 Apr 2024 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L8iZ/xHi"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B11172BBA;
	Wed, 17 Apr 2024 18:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377317; cv=none; b=oRNpSICrtxZkqxsSus7MdE5f3h68wxR3K+joLUxKsl3rolVxMBbZWM9IuDHspAFEAuF3/MWbywKKsY/dFG5qV2+PrJdj6LSWLe++5TZXk8pxPN++g8uW2/KGmU8js0eUtlv0nzb5CqNknCQrf40u5QBK5NEHrAM2WM7YDa5Z0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377317; c=relaxed/simple;
	bh=yScqRp0Jg2+VouccAT2Uycta3VO03GkGoJ4Bu4O9Mj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpczYNrbJTl4xBavgt9bAUQMDvmk/CR6VB5eXvWknCZ+aF7D6jV2r+ogUZwRUoEaTIQN9SmGHJX3mdFR2HTWYVp/Xu2hVnjxCZJs99sDOAiBM7bAh5KQug4/7Dub8Fv+ijxWa2JY+GoBigpHRwcZfw4vWSz0bftOP9vDqb9jHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L8iZ/xHi; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4793CE0003;
	Wed, 17 Apr 2024 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713377307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zYtwhfXVLaMvnCqB5/9WQLxlola4N7x55igQ2xpirys=;
	b=L8iZ/xHiqXbrS0rt1SLs+GnYBh9FQO1sk3Ozm/KX8WEp20h9jl86Obe6kfW/QQ2ggZ4vud
	oTS9gFDRPg53gYCgUYiKACit6tcxV+IYwCl1wWpTNeFXW4p/RyoKAo0eY7dD4DAKB3+Yng
	PEiulenBD+o1VWy+qxesEr3FYRiOOpe1ZQ/lq22OIPCj/GPEmARFc5BbwHAGIcb4pMUhfN
	/kRJqioj8ySTutMfW1xUxZez3A0S8d7lOLnHsc35R8CKHeH+IucfOmvCYazkbuBlx5ag8m
	zXWel3C7U1vQgoOgeMwBckWHoAK7mb5Lb+41ljZsX75M+HvRyChgt0au87y2FA==
Date: Wed, 17 Apr 2024 20:08:23 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add a driver for Epson RX8111 RTC
Message-ID: <171337729016.24784.6697230911963690244.b4-ty@bootlin.com>
References: <cover.1700491765.git.waqar.hameed@axis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700491765.git.waqar.hameed@axis.com>
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 20 Nov 2023 15:49:25 +0100, Waqar Hameed wrote:
> In this patch series we add a basic driver for Epson RX8111 RTC with
> support for only reading/writing the time and the `ioctl`s `RTC_VL_READ`
> and `RTC_VL_CLR`.
> 
> Datasheet: https://support.epson.biz/td/api/doc_check.php?dl=app_RX8111CE&lang=en
> 
> Changes in v3:
> * Remove macro define `RX8111_DRV_NAME` for the driver name.
> * Remove macro function `RX8111_TIME_BUF_IDX` and instead use the
>   offsets as indices directly.
> * Remove `rx8111_setup()` that disabled extended functionality and
>   interrupts.
> * Remove comments explaining register value conversions in
>   `rx8111_read/set_time()`.
> * Check/clear register flag XST (oscillation stoppage) in
>   `rx8111_read/set_time()`.
> * Change `vlval` to `unsigned int` in `rx8111_ioctl()`.
> * Remove `case RTC_VL_CLR` in `rx8111_ioctl()`.
> * Convert all `dev_err()` to `dev_dbg()`.
> * Convert all `dev_err_probe()` to `dev_dbg()` in probe.
> * Return without printing from `devm_rtc_register_device()` in probe.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: rtc: Add Epson RX8111
      https://git.kernel.org/abelloni/c/c6a2fb6d14bf
[2/2] rtc: Add driver for Epson RX8111
      https://git.kernel.org/abelloni/c/f8c81d15f4bb

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

