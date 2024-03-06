Return-Path: <linux-kernel+bounces-93288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDA0872D89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4485C1F260D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216DD14A98;
	Wed,  6 Mar 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2mGSS5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCC3D52E;
	Wed,  6 Mar 2024 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709695826; cv=none; b=DXt/eF++dXYpOP3ucGfGgIGsGRNN1RHN2iGpo0r7RMY0oz8YfmLPHwQdmUASbdb3JSfH8uhqG3rHReoTHG4zEbsZCA9tsmHQb1mdxSv0SNnJV14Obcz8uioaBiFWR3Ibf3mHjd2v3/CQjMWbCJMTgLBlk/6bF4H47ERXx7V9yDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709695826; c=relaxed/simple;
	bh=9ydmuSiSrlVH/L7VD6PnfU2OV2TwYr/t2FobneUWLqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1m3KeIi9fhmIARMrRAiERoYr0kiJWNvt/JLaVGAByFy6yWP/QlFPmE41nJXiUp+L7ifjSSN/6v2TJNC8W+ClEXe4yj0pTLG+1uo4jb+Qj8eag4YOXdRMgdHwf/prZS+kpDfVKyKU3T+jzAnD6uRG1Gd9L+MNKf26/s6qeXS1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2mGSS5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FDCC433F1;
	Wed,  6 Mar 2024 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709695826;
	bh=9ydmuSiSrlVH/L7VD6PnfU2OV2TwYr/t2FobneUWLqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2mGSS5M4QYJWmrRss/8Emz6yARdhfzTmogDXMRF4UbdTyBK7lKZEMHYOhrWXJfkt
	 tLn/F0jU29uO57T+qAFMLyxubrtS1vahlZRGVHbinH0vrGjh4hdYppZzu8jGoR8hfx
	 thoJNtY4HkvLf37JXnmumZ6yqmRnXtcEVumdCUROcD/9wg3Mg90HyBqtxFDMLS3cZp
	 H6uNK1RrAaC2MFjGjicWbsTugDwiH/xvpyBE8WFZJfBFGvPeJNiye7nahmzJoGWfpD
	 U41ihgczZWBVN4E7Edkoln1xBIvT+YjHuvMpTBgkcr0pAHDbVHIGJYdmwkK1lGXnXG
	 399i67T+Q1TBQ==
Date: Tue, 5 Mar 2024 19:30:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: x25: remove dead links from Kconfig
Message-ID: <20240305193024.6bcfa98f@kernel.org>
In-Reply-To: <20240305133139.29236-1-justin.swartz@risingedge.co.za>
References: <20240305133139.29236-1-justin.swartz@risingedge.co.za>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Mar 2024 15:31:38 +0200 Justin Swartz wrote:
> Remove the "You can read more about X.25 at" links provided in
> Kconfig as they have not pointed at any relevant pages for quite
> a while.
> 
> An old copy of https://www.sangoma.com/tutorials/x25/ can be
> retrieved via https://archive.org/web/ but nothing useful seems
> to have been preserved for http://docwiki.cisco.com/wiki/X.25
> 
> For the sake of necromancy and those who really did want to
> read more about X.25, a previous incarnation of Kconfig included
> a link to:
> http://www.cisco.com/univercd/cc/td/doc/product/software/ios11/cbook/cx25.htm
> 
> Which can still be read at:
> https://web.archive.org/web/20071013101232/http://cisco.com/en/US/docs/ios/11_0/router/configuration/guide/cx25.html
> 
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>

Could you repost without the "2/2" in the subject?
I don't see patch "1/2" and all our systems thought this 
is an incomplete series.

