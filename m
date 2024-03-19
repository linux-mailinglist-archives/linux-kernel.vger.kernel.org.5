Return-Path: <linux-kernel+bounces-107760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08B880154
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CD21F247FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAA081746;
	Tue, 19 Mar 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GQykNv4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D27F7F6;
	Tue, 19 Mar 2024 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864197; cv=none; b=WE3rOBt90Kl9Vxx1BEF2M6znsMKsglKNf9h+qlnH8cyF/f9J6vDRsJKaG8A1vCGdRTKriFLfFunIxsDw79M9MGfF+KBqejTJyfJiOwk7HAr7SXnojPtaR8MOfWyz6AzXw670GAzceFqXr1VSy0OGCshT1Roo+0OMnkzFVtN+9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864197; c=relaxed/simple;
	bh=+voahnlPtlKXWhIdh6ZvbBRDSKewT58b6XkwLBATBs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+4VsJPg8dd1CETNW6+4sV+XTcOJ/mA1G4qfbG2OFkno+b0+2eMnhR6fHn9ZQETh66P5rMymD/Iur0RhDelrBFQzDrPnq/yqR+bjamWy2J4irVqcFnjxGQKrL0ik+fd74zkRiYAT+mD4deBKMzePCLYPb9JL+HHTiwYMNw/m1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GQykNv4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34885C433C7;
	Tue, 19 Mar 2024 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710864196;
	bh=+voahnlPtlKXWhIdh6ZvbBRDSKewT58b6XkwLBATBs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GQykNv4jqSVsGqK7aButH1nz5vVakQLEs5Kfy7VWh4LHBww3lx17IDdArNeqelGju
	 dr2Upwk/dUYfRldBc1J8dhYssWkC+ERTcRQ4b5VL52xNw3VDIgkf8IsBU01wLfxZ3c
	 +ZV8ldv7aumnK10StnNpTYEdW7n/g5H06W5NBQ/8=
Date: Tue, 19 Mar 2024 12:03:15 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, 
	Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, =?utf-8?B?UmVuw6k=?= van Dorst <opensource@vdorst.com>, 
	Russell King <linux@armlinux.org.uk>, SkyLake Huang <SkyLake.Huang@mediatek.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/3] Fix EEE support for MT7531 and MT7988 SoC switch
Message-ID: <20240319-uppish-idealistic-giraffe-e17cb4@lemur>
References: <65f7f17d.050a0220.3c75a.cde3SMTPIN_ADDED_BROKEN@mx.google.com>
 <5514243b-c795-436e-8628-8f421c900bcb@gmail.com>
 <ea889226-3649-4f74-8c38-67c459e4ea4d@arinc9.com>
 <20240318-quizzical-raven-of-plenty-ef21f5@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240318-quizzical-raven-of-plenty-ef21f5@lemur>

On Mon, Mar 18, 2024 at 02:01:58PM -0400, Konstantin Ryabitsev wrote:
> > It looks like my branch name was too long again. b4 0.13.0 cannot handle
> > branch names that are too long. I'll keep it shorter for future
> > submissions. It'd be great if Konstantin could provide a specific limit.
> 
> It's not really b4, it's the web endpoint and the version of python it's
> running. I hope to fix it soon by applying the same workarounds as we ended up
> doing for b4 itself.

I've deployed the version of endpoint that works around this bug. Hopefully,
you won't see it again regardless of the message-id length.

-K

