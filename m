Return-Path: <linux-kernel+bounces-58216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787384E2E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0806B28A28
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031487AE79;
	Thu,  8 Feb 2024 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfXLoc67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492EE78B67;
	Thu,  8 Feb 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707401588; cv=none; b=kzHLarzly3xrUk8CT+kOumwXWFtG/HxhqD7GipnhChGXvgmA3j3I4RHZJAEln2bHBSy7IIK7oNsNDb0k3ke+SZ3FQ/waoCc6ixwcRbNf4m9Zxp0E5z7LrvazEswpjz+q5F7Vmu1fQgm/ZJvLdsFEyG+zB/MqO1JySmQmNO9QBLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707401588; c=relaxed/simple;
	bh=CbtSnrMyGKMkAv5gEzutyCxzAJsaeUyxzbSiLdapCRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZD2xfU2xcxHG+GW+ZyRByaOzl0G4HujmTMUPe1rkvyGoAeOXJre8qSZseu11ezCOxJHAAq2pol3PVcSk+yD1y0D4lapolIi/5zT253exXZpPcTHprU8jvyI+MEZjYZv4ngh/Xi3ukedNb7OqGxZ/jMAEQ5KOipN1e1Ys6jYSMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfXLoc67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77490C43390;
	Thu,  8 Feb 2024 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707401587;
	bh=CbtSnrMyGKMkAv5gEzutyCxzAJsaeUyxzbSiLdapCRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sfXLoc67It1CdmqUYObtKlj4Me0VmAfabKkZ2nv80SQTQSRPRL9hDpmcNCnVtRUiz
	 mZqDdvXz8kOnv7MsWw4gZ9+wvNTkBBV5ix02+p8H4IfE8XXVvUtIJrxX2D1ObSuvq2
	 H1FQbnXEoDFR+CginG32YJXIG1CqqSzW6y1AKBRdGzb06Wa5yitPqWgT0/jVT00UX1
	 9L9UDziNFVpeo9KadcgxF6SlO38BekHXOiFpaYdlksbdn4yeeAlghxIDK0BFchZWKm
	 YmdCB0Hl3jkW06gkZf4Rt71r+l7wcvZOgaEDkjyYT73xVl0HyXugMmt3vUt/CKBaNP
	 MrN4eAskDTuiQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, broonie@kernel.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: andy.shevchenko@gmail.com, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
References: <20240129152557.3221212-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH v4 1/6] spi: cs42l43: Tidy up header includes
Message-Id: <170740158622.1056271.11724106959925085700.b4-ty@kernel.org>
Date: Thu, 08 Feb 2024 14:13:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Mon, 29 Jan 2024 15:25:52 +0000, Charles Keepax wrote:
> Including some missing headers.
> 
> 

Applied, thanks!

[1/6] spi: cs42l43: Tidy up header includes
      commit: 0863c47b4147b948a23f03031ac880096512a878

--
Lee Jones [李琼斯]


