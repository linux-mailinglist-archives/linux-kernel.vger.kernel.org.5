Return-Path: <linux-kernel+bounces-140501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25388A1738
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BAFD1F25166
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FECF14F10E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="egsevXKs"
Received: from smtpcmd13147.aruba.it (smtpcmd13147.aruba.it [62.149.156.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9933145FFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841940; cv=none; b=poutxoVkTA9IJcRv0dmdnEQxvfjd2iALqwnZlrT+0scLHumIjVw412JhuUIvBU8DvFvnT0DEyHge2aktvt/TW2swcFC9cqx29KRVDebW1tjpZPSWdXYOPuZ9Y0+fmrvPCKl7A6ng0lUJeUNGpIY3KigJ/AW57M05UBbL/dGrq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841940; c=relaxed/simple;
	bh=F/4VlDVKnyWrcnoOPdyocDWU5sYwgOSBDCSbs6FvBs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cwgj85CijBP+dGRXQQdvOPE9u5FwRoonKQma4GXaalR0Xo6bOfHvDgfJHi5VKwaPd3OlTgcr0zbCjvatj4JwJ2NodVjVmEn5XWN5fD4QLI6zC7BfGf8lcL7SUrzseTqHvZ4/DV0FHjlRexVb/dJ608hV8YlZXGcBRRVyofr4Tak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com; spf=pass smtp.mailfrom=engicam.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=egsevXKs; arc=none smtp.client-ip=62.149.156.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engicam.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engicam.com
Received: from engicam ([77.32.15.153])
	by Aruba Outgoing Smtp  with ESMTPSA
	id uuNiryEQZiznzuuNjrna0P; Thu, 11 Apr 2024 15:22:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1712841744; bh=F/4VlDVKnyWrcnoOPdyocDWU5sYwgOSBDCSbs6FvBs4=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=egsevXKsfLiGmcfxqngWvyYRqUwwUGsUelDN4sDjSGoCnVsbd620za5+cJCMk+W/Y
	 mFlrOdl/d8B67Sb7x7aTwNdw1bYew+TiM2xO0OUWrijdLb5SCqgX50+ZrSfeXZR0Vl
	 E1SuY//3GVGyhpJFykUmLy6S9+fRUX4pgTSFcmH6cG2suWbBIpUKLGK68LQuAq/VsY
	 58MmICNZIcmljeAcJqgPucSnuIFo44IvSgdYzUXxQFKUyu85zoGOO7MFoKgqFyBt6T
	 9v3HjjcqOWgC/VqWCYH3b1xjyFq6c1nPAyKrzGDRcKV/867Z8/8poVE8VhDd/n1/sT
	 xfMEd1+4nMzWA==
Date: Thu, 11 Apr 2024 15:22:22 +0200
From: Fabio Aiuto <fabio.aiuto@engicam.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] regulator: pca9450: make warm reset on PMIC_RST_B
 assertion
Message-ID: <ZhfkDrDYlTFd1gOJ@engicam>
References: <20240411100138.366292-1-fabio.aiuto@engicam.com>
 <243d9eb2-aaab-4ede-bd07-aa609b5d149e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243d9eb2-aaab-4ede-bd07-aa609b5d149e@sirena.org.uk>
X-CMAE-Envelope: MS4xfH2JJT/EWTYhzkwzkuiL+ZHgD5zKPRY6eNZmjOR09r9LkMECwzwiJ2HfOKFxE4IZ9BBl4qHWc6ZCkY1/OXP+y3ljkZMeOVgxiXo/6JKrjbuEtEmi9VJ7
 e9rmwPBchV43ggxblYUb/azpNALAT9FpT2Ul6JaVl8blsv68pQQEcLG7NI4QoQyMMJrQmX6DETQFqBd2G/rSfgFrtm9HwhqSyh8+SIIUBM8oWdJ9jU1Hf/uC
 FZh/cFhaXv2Ry447LuMgkw==

Dear Mark,

Il Thu, Apr 11, 2024 at 01:37:48PM +0100, Mark Brown ha scritto:
> On Thu, Apr 11, 2024 at 12:01:37PM +0200, Fabio Aiuto wrote:
> > Hello all,
> > 
> > sorry for spamming, this one have the correct email addresses.
> > This patch adds a property for to control reset behavior on
> > PMIC_RST_B assertion.
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that 
> any important information is recorded in the changelog rather than being
> lost. 

I've got it, thanks. Do you want me to send a v3 or are you taking in
consideration this one?

kr

fabio


