Return-Path: <linux-kernel+bounces-61176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE602850E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890BC281164
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E346EACD;
	Mon, 12 Feb 2024 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QHLMuBxK"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F4EAE3;
	Mon, 12 Feb 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724708; cv=none; b=cCNHshvyTWxmbG+4Jmv2KJop+zsrViRC4YvPYoTTxTe1oDbaWiPFl9N0oIrxAUBplMHdgTeUeY1/WdXoM9v6EEmSlCvpCrSD/u8CRtfvsVe5vB0x7KuaJkeWZ8NhePbcACKqLc7+GO0f78h9R0FBu2jBqPgSYktWyLuATWwRtkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724708; c=relaxed/simple;
	bh=ChLP6pbuX2n266hqFM2tnkNlDBSoV7MLNaEjbkanKOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekaS5vGvXuuio+sBdxfg5AuiLVdgD6LcLmPqMmzYAUR7uToDHbAiL503vJCdWVCfqI1TFttROZRPhkX2znev/HjBqKrXl3vqEQKkQA9YcKuAQz+gjb85e05irY2txtquW2rLiJf5t9MuqRGEQAZbAkZuVu+ITrtpvOFbOGh4x1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QHLMuBxK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 339EC1FE73;
	Mon, 12 Feb 2024 08:58:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1707724701;
	bh=4hwu309SeUk6g/9RpOPLjbl+0yrbn1Vtt3YfrGLQYvY=;
	h=Received:From:To:Subject;
	b=QHLMuBxKP2Gw8DE3/9RHOnt4TiG7jSpVnpdNjIXCezQ6q+z6anI++UX4m9IpBqcBG
	 z/c+iu4DRaYbuU/+dFY4RmDVGbZIVc2WKsfeIlW/Xy9gU9IsKb61aexH6PN9cMsaf8
	 x+/YXGSFfYVyRJ7okqcQJuMvLB///6UxJhwWTxHEh3E7SgWcaDT/jQGKWwtt803bMI
	 gmW7AorPGTKPmUIRLTTTyjdLisoFtQ1jYlosNX1Ouf96cHwF5fDJzOWPstW8rDomAa
	 bd1rHnIr44Y+NeM+91UgGspHg3uLzB/84r4GLJOf3cgBmaPMeHqlcQTqFxdu5ohwRJ
	 n19/KRrG54cnw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id D44AF7F9D7; Mon, 12 Feb 2024 08:58:20 +0100 (CET)
Date: Mon, 12 Feb 2024 08:58:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, nm@ti.com, kristo@kernel.org,
	ssantosh@kernel.org, chandru@ti.com, rishabh@ti.com, kamlesh@ti.com,
	vigneshr@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Message-ID: <ZcnPnMEknPjtwJtz@gaggiata.pivistrello.it>
References: <20240207091100.4001428-1-u-kumar1@ti.com>
 <20240211155459.GA4443@francesco-nb>
 <b27ea51f-ad29-4c8a-8f33-f51640f0c013@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b27ea51f-ad29-4c8a-8f33-f51640f0c013@ti.com>

On Mon, Feb 12, 2024 at 10:06:30AM +0530, Kumar, Udit wrote:
> 
> On 2/11/2024 9:24 PM, Francesco Dolcini wrote:
> > On Wed, Feb 07, 2024 at 02:41:00PM +0530, Udit Kumar wrote:
> > > Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically probing clocks")
> > > 
> > > [0] https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> > > Section Clocks for NAVSS0_CPTS_0 Device,
> > > clock id 12-15 not present.
> > > 
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > no empty lines in between tags and only tags at the end of the commit
> > message, this [0] reference needs to be before or moved to a `Link:` tag,
> > whatever works best for you.
> will below works ?

No, it does not fullfil the expectation to have only tags at the end.

> [0]https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html
> Section Clocks for NAVSS0_CPTS_0 Device,
> clock id 12-15 not present
> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for dynamically
> probing clocks")

