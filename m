Return-Path: <linux-kernel+bounces-32455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E35D835BEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16741F25034
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E572135C;
	Mon, 22 Jan 2024 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="ceA1FGY8"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094FF210FB;
	Mon, 22 Jan 2024 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909491; cv=none; b=q8EHtzY0KGY6dYj2tS9ZrZMsnltqJVsEJWc6n0TYZECO4mXBfigaG87eIVHW2+q6ltTr0U1esYlGLXqGl5sl058ZjO5Z1z69T5vM9PqAy/8ektu1c/DwRVDgosd+DIYPt0gTL+FapeiR5ITKp9XA/oPqhTSxCdUHAC83qTJ1Gcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909491; c=relaxed/simple;
	bh=czpiByVlENYrQx/+R4rULYlFTIy1imrFPgezbHyqTMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a/GEgMU3lagwDIyQQ7A2N7L3xJ96/X6I/UDj8jPmjWjs2t8FKDAdCDnIOOjzszbYtcqnYxKZXJk94BVwoqfSqQNRnKGDOLplH/Cs72HWUlk1UZ+UgheHj9XCYMQ2BqAgIUGmwlt26I/VPnOX62L//u+MouQfFqMZIxpvgnTe1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=ceA1FGY8; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rRoz1-00035T-8T; Mon, 22 Jan 2024 02:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=czpiByVlENYrQx/+R4rULYlFTIy1imrFPgezbHyqTMA=; b=ceA1FGY8cV6jfh5O7pZ5
	KWjC6/ANBX+XEVNLmElXqZvK6789RC4vvLkIawjYorcPviRBGwXXtkUeTppw0QkSAsK2646G34SUg
	N3ueivq5XDXtpco12nRI+iVgOYOScoc+7YfojLNTD6Bx1B1Ow4+DIX1Mjauk/qvZpStlrWWvQet0I
	GJzZuwHP/r1NXkr5kJw3vcLRnaLF6CKqwTG9jEuzd17gCdBor3GG21PIE0bmpTgtaPsuk7+uEDBco
	RgbydZKIKlCyu7ek6PumypfMKHBoPQrjiexTBtWlj/8L34JC4Xrqyg9IF+my1LeXjQa4mYIb2CWLT
	YNmVRYLBBTjQ9g==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: Rob Herring <robh+dt@kernel.org>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  Primoz Fiser <primoz.fiser@norik.com>,  Stefan
 Wahren <wahrenst@gmx.net>,  Christoph Stoidner <c.stoidner@phytec.de>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-arm-kernel@lists.infradead.org>,  <upstream@list.phytec.de>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
In-Reply-To: <0348afb6-24df-4088-a3f5-6b5df8081c04@phytec.de> (Wadim Egorov's
	message of "Mon, 22 Jan 2024 03:42:18 +0100")
References: <20240119092835.21462-1-othacehe@gnu.org>
	<20240119092835.21462-3-othacehe@gnu.org>
	<0348afb6-24df-4088-a3f5-6b5df8081c04@phytec.de>
Date: Mon, 22 Jan 2024 08:44:36 +0100
Message-ID: <87v87lerrv.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello,

>> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>> + * Christoph Stoidner <c.stoidner@phytec.de>
>
> you dropped me from the Authors list :(

I must have used an old downstream device tree without your name in the
Authors list, sorry about that.

Took your remarks into account.

Thanks,

Mathieu

