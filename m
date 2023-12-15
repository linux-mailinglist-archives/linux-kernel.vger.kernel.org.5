Return-Path: <linux-kernel+bounces-1334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD1814D93
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328DD1C23D48
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5823EA71;
	Fri, 15 Dec 2023 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDKJ9dkh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CE3EA62;
	Fri, 15 Dec 2023 16:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959DBC433C7;
	Fri, 15 Dec 2023 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702659178;
	bh=8IjvF5iJkjju7Z3yvp4kM4LeQ9eitPcA1kCaKqS2XcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fDKJ9dkhvD9n3sIcnsjDipC3oElLx6SP8Jc52RE73Hw+kZvmY1VNkc9Gy2kekBWbz
	 UULa1KTBYL5g3W4CsCzG+jOUaH8HjVOpUswiyFE6TEyn2EQuhJR4KbtDXegXC7VUnp
	 OJTvcRN3mH6KB76GP+1rX+jeWE6+gWhX2HEkiE+uXbJ8kqVGQOV455HgeCqNxcSZMf
	 hop51bq4wAeK4G5YQ/+v0YMpISQQGZ0Jt2k5fr3Mg0vW5g68eL6tKld4fTTBvtm+iG
	 ViolCq1Bjf+MX7akGl8ueSlmWIBkyiCRsxJER89AnM8I423aOQb8gFDW4OY0il5n1M
	 Rh8s8DfJgOUyg==
Date: Fri, 15 Dec 2023 08:52:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
 geert+renesas@glider.be, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH net-next v2 00/21] net: ravb: Add suspend to RAM and
 runtime PM support for RZ/G3S
Message-ID: <20231215085256.1b275115@kernel.org>
In-Reply-To: <a84b6250-dfd8-4a33-b247-5dfe2d28472d@tuxon.dev>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
	<20231214112658.583cfc60@kernel.org>
	<a84b6250-dfd8-4a33-b247-5dfe2d28472d@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 11:44:32 +0200 claudiu beznea wrote:
> > You have to wait for fixes to land, we marge the trees every week.  
> 
> The intention was to let the reviewers know they should apply [1] (if any)
> for reviewing this series.

If there's a dependency please post the "later" thing as RFC.
We can't apply it, and it saves us clicking it away in patchwork.

