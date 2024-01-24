Return-Path: <linux-kernel+bounces-37076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1783AB1E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42091F2A923
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEACF77F33;
	Wed, 24 Jan 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="RKbh3WSS"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD788F72;
	Wed, 24 Jan 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104108; cv=none; b=pIWFqtIGVbagqLLBDsWitVvKew1nE3Z7KnUEOeJxLhQ5koS+1M4m0T4urDTMYly+qkKZvcA0OYwtKHx1gq+9JRbR8Fl7tLpETuAJfLlXzTJzy68b99QtcZT/Qspmq+arZjc53qYjlCgOn4wxDP0xFTiG1x1c8usEjZ65508RHpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104108; c=relaxed/simple;
	bh=S9+36Hp1IxD1aQEtBPW086OEvAbuOTs2f1zL0QQ3N9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XGXSj11lF1sft87k1e7GS8zWMf9BRJVcZnBkbp54XohFKkHohf4C6nu7TZOSIlcc7re5gfxZwzhimsTo45HAR43jwModSb/2FWDl9gi+7BQ07qpuX+Ucdm21JdfdSZaNQ11mrgRpCeSseVSz4vnqlMhHvHrv7x9jvjL87w6zxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=RKbh3WSS; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rSdc1-0004B9-G8; Wed, 24 Jan 2024 08:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=S9+36Hp1IxD1aQEtBPW086OEvAbuOTs2f1zL0QQ3N9A=; b=RKbh3WSS0uIakaAG2939
	CgNcweAuV9EVLFIf/3+Xp6ag5Iy3O9MOui0jMOitNje0irDmRwiGBYpgGs//eLtbEQTv0nDH1pqFY
	BMSITC0+RQQeWWhQGR2Mnb++MpPyZbZWGw25CjZFOe8N2q7aXJH3Xzs8cto5u/6Iwv5M7IDXQwWqV
	QhQcq8PQ/38QX9GYEI80LQE3hX7xlNVoIlVtp41RUCEu5Nlk2EpFpWuQQ8CKCMz/Nx8hpEIr4Ax52
	w/J4SuoxuliWWIiySuJaRgsoJjZzJ43XWGiCAt1eJp74nIpSDb/DSE0+bbpDB4KhEMEjRqtnJlmwp
	+KT+A9s1Ob/Zjg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Wadim Egorov <w.egorov@phytec.de>,  Rob Herring <robh+dt@kernel.org>,
  Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer
 <s.hauer@pengutronix.de>,  Pengutronix Kernel Team
 <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,  NXP Linux
 Team <linux-imx@nxp.com>,  Li Yang <leoyang.li@nxp.com>,  Primoz Fiser
 <primoz.fiser@norik.com>,  Christoph Stoidner <c.stoidner@phytec.de>,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  upstream@lists.phytec.de
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
In-Reply-To: <47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net> (Stefan Wahren's
	message of "Wed, 24 Jan 2024 12:39:26 +0100")
References: <20240122095306.14084-1-othacehe@gnu.org>
	<20240122095306.14084-4-othacehe@gnu.org>
	<537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
	<85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
	<7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
	<08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
	<008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
	<47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net>
Date: Wed, 24 Jan 2024 14:48:14 +0100
Message-ID: <87o7da4zc1.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hello Stefan,

>> Defining line names should be fine. But I would still prefer to have
>> the muxing in an overlay bound to a specific use case.
> I'm fine with this. Unfortunately Mathieu dropped the line names in V5
> today :-(
>
> AFAIR reviewers should have 2 weeks time maximum. This was just 2 days.

I am sorry but it is not easy for me to deal with contradictory input. I
chose to remove the gpio-line-names even though it also seemed like a
nice addition to me. The idea was to not interfere with Phytec plans in
the future.

There is no hurry and I can always restore them in a v6.

Let me know what you think,

Thanks,

Mathieu

