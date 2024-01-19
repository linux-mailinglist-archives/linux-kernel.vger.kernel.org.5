Return-Path: <linux-kernel+bounces-30955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B938326C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1D2284E89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE473C07B;
	Fri, 19 Jan 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="qJyVTM0J"
Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB83222;
	Fri, 19 Jan 2024 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705656716; cv=none; b=jQwrxHnz+/RPr9TvEd9drTPmHbvNng8KBcO+y2dbRRGczeNDFtJ8+jti0nFXM8eFx9/665aj1AuWTc41FyJUJFbzv7J5FgSFLEArHzOT16qfuFfsm5VUVc/jKUhCc3oBMT2lV2Bvp5T6GGRzmqw9fxTQIZlxziq6R88Vm3xHJPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705656716; c=relaxed/simple;
	bh=jfc1fKf0XR2vJEJRDRpRq080VPy7M39owZIDub4aX70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aS5ZES9r8b2Ij5CR1hNcrK+4UPxept9iRUFgDbOX9HJur0L0oB1PRQL/R+TYVlyMCmVWNXEOEM8Aztms2i65RxaSMS+gM/79oH+fIe8XR3EolYBzAU/q5mPKJH6cCPzeXjrd9nygOQFB/ZjzSN0VLAMHfDrVecsjxFVBZw2k7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=qJyVTM0J; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <othacehe@gnu.org>)
	id 1rQlE8-00047a-7H; Fri, 19 Jan 2024 04:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=jfc1fKf0XR2vJEJRDRpRq080VPy7M39owZIDub4aX70=; b=qJyVTM0JUsrs9DrgDWCO
	Kk1xj7Yvc0JhM5+uQ+icdohrCTlCe54id6HZo1qdit5iLbai/8J1LTS1RYEUyKm0L8Cp8mQZiXEOs
	kLfSDBp9tTtiicW6B0smrhUbSFKqtQk3e6bd3dP/goYraYTIbjGCxOXP6o+9+f3XohqUX0sIxVLxH
	ZYu8Ox76K0VxsPuwQqpuPCi0+KQkUyqbbdi5uUtnxgP+fgI6fS+XdoBJuGRTjGfScTOjbfx8nM3oS
	b8xzxSXdKhJrGW/Vk5Vq+BHqyZIUiQ64ae5fWifDpWJ+zzCwxkIhVpdujdd2XGMSaSzJaGRJMLylk
	x8qPUu3P45EgYg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Rob Herring <robh+dt@kernel.org> ,Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
  Shawn Guo <shawnguo@kernel.org>,  Sascha Hauer <s.hauer@pengutronix.de>,
  Pengutronix Kernel Team <kernel@pengutronix.de>,  Fabio Estevam
 <festevam@gmail.com>,  NXP Linux Team <linux-imx@nxp.com>,  Li Yang
 <leoyang.li@nxp.com>,  Stefan Wahren <wahrenst@gmx.net>
Cc: devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/2] Add Variscite VAR-SOM-MX93 support
In-Reply-To: <20240108110241.8555-1-othacehe@gnu.org> (Mathieu Othacehe's
	message of "Mon, 8 Jan 2024 12:02:39 +0100")
References: <20240108110241.8555-1-othacehe@gnu.org>
Date: Fri, 19 Jan 2024 10:31:49 +0100
Message-ID: <87mst1654q.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hey,

> This is a v7 adding support for the Variscite VAR-SOM-MX93 SoM on Symphony
> Board.

Friendly ping :) Is there something else that I can do here?

Thanks,

Mathieu

