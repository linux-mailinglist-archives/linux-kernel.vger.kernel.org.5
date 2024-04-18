Return-Path: <linux-kernel+bounces-149711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E548A94DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 486601F20355
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED5985659;
	Thu, 18 Apr 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QU1WIzXg"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225E63C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713428886; cv=none; b=ly4bZSSG6/G09nMw7/FjMm2BxVoO2zCNZtK/UiuBx+Zo06dsiGFGUIX/5nL6nYQe9WDireCb2mczUzYVzsab7gMCuItMrrJwAhzJ701JxlVCqtR9pxU68M9abREB1NlJQblbWz+6FIfcBUHIHNvDjhmn9BHAybHTVIgvY2e9AZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713428886; c=relaxed/simple;
	bh=WzoUecFexsScuw55cPZeTVCR9zBOwDkkmgdVCvlRNFc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=A6h5ECdpDiq7IETbEjOb0ADZVN3rqjzuSea4YhDrRsYRkHqJczBZItyGI8fvI06hC+zMIdEOnKMXOi+FW8esM5bHGbNyinZP9JzAfv0RTMBsQfTcfzSk2CIkMiiBZclmQzQ3QZzJwh/0JwtKk+55ZMUhetiy5fYn+ya/rAiD5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QU1WIzXg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713428880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDIUutjkBtcMupJEPwPTtmltqD4/go0oHDIGSIsxcDs=;
	b=QU1WIzXgqPF9R+a7Ua9scuvOaWdUWh7ddESfB18+wLlGZZ/7YbBvwZE202eFLCt8RNrDy3
	XRzWT1WQPACyeDcqrbzIdXstZmBnV3qLaMlXSCXnGugugFG4fNyLuvkSFCP3pP/coDH3sC
	Ge8unEV65QfY/5H1curNB11Vtc2ZD3s6ri/ytDat3LdVp+GCtFBBlCtuGwCIU5EC3G8VCX
	nLjMS9Tj4D16a0spQVDjbK9hjRV9ZOgNcQCgbBjvpWGwHVDj/LgMar9DUjwdhHQ6BhDj2p
	AT2BzxUOUjNF4zHjEyCiQC9birPQxTNtCsVFcWe0S3tsOd55DU8zdWUu8dt3MA==
Date: Thu, 18 Apr 2024 10:28:00 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH] arm64: dts: rockchip: add PCIe3 support on rk3588-jaguar
In-Reply-To: <5932394.MhkbZ0Pkbq@diego>
References: <20240417141642.2243193-1-heiko@sntech.de>
 <cb2004e3-563e-4d36-ab69-89b1d9f6221b@theobroma-systems.com>
 <5932394.MhkbZ0Pkbq@diego>
Message-ID: <b36c5a6fd85e36f7b9adebf76dd0fb85@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

On 2024-04-18 10:12, Heiko Stübner wrote:
> Am Donnerstag, 18. April 2024, 10:07:37 CEST schrieb Quentin Schulz:
>> On 4/17/24 16:16, Heiko Stuebner wrote:
>> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
>> >
>> > The Jaguar SBC provides a M.2 slot connected to the pcie3 controller.

Just a minor nitpick...  s/a M.2/an M.2/

>> > In contrast to a number of other boards the pcie-refclk is gpio-controlled,
>> > so the necessary clock is added to the list of pcie3 clocks.

