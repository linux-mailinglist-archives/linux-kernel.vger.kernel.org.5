Return-Path: <linux-kernel+bounces-102638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00EC87B52C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E433D1C214EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296FD5D73A;
	Wed, 13 Mar 2024 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1TzvUrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8781A38E3;
	Wed, 13 Mar 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372497; cv=none; b=HIHPOsHmP94Sz2Zay4QCudjbWvINU5Ibkp45lskaOO7OIoXx71yffQE6ghNp0s6x4BshWxkmq7n/4HrgdyvSvtKznsNEeXh4gKqs6fPUbDVQx1CNY0gViBbP2YIJKnAIp1p6Esd4O2iHtfHhs1+QVbPo0A+AWrjU32BxWkwXfQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372497; c=relaxed/simple;
	bh=bFw+xrxCOa8u2TLCE3nHHl1dTIg3OERcQT3EJYsmHBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MYUcIa8PeBGmKX5Qo4KCBneCIcqKYFIiXQNvIqbJlDZpOAzyjWm3lM3ARBwlRbdgDNQyYkqeEJDY7yxZr/G7sdSsBn/hTr3d3D1isiCoRHgGf/LXm0nwmDP5TLfX0lqZRIw2oYZzGvPEJraonZ8INHyNDdeZS5GQshWmJp+KKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1TzvUrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB16C433F1;
	Wed, 13 Mar 2024 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710372496;
	bh=bFw+xrxCOa8u2TLCE3nHHl1dTIg3OERcQT3EJYsmHBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M1TzvUrJLVq8ycew3FNIpAJzJ1ibziRDUW4guiXP7OiDSvfKGNFuvEuM+Lm7zHbzr
	 ON6LgnxSDywN3PLlBpH8BnI00X5288oLIWDeBCMwT1Gl2ifb/XLtuNMtND6JnFrLLO
	 7cuTfJnCnF3y0aZdvxAfPFNeL+vii89UMBA4LXRBygi4aXutbVlbc55QW2e25FYYn9
	 7JrCeG7ghAFHpAIf6dl/SZNWQnDmdUSUwcuK4iHvdJRdtDuEtc7mUEOlRO+JgIDW4R
	 IUBA4FhLMD3hbi0ViqyZiRn5/nM14WCg7aik39Y+WoOlcVhu4dXxZ4y8aFVB/uPqRG
	 sYHBhP+EWV6ZQ==
Date: Wed, 13 Mar 2024 16:28:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Landen Chao <Landen.Chao@mediatek.com>, Bartel
 Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Justin Swartz
 <justin.swartz@risingedge.co.za>
Subject: Re: [PATCH net] net: dsa: mt7530: prevent possible incorrect XTAL
 frequency selection
Message-ID: <20240313162815.1bc0a740@kernel.org>
In-Reply-To: <48fadb58-4b81-4271-919c-102943354c01@arinc9.com>
References: <20240313085546.710679b0@kernel.org>
	<48fadb58-4b81-4271-919c-102943354c01@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Mar 2024 23:12:19 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> On 13.03.2024 18:55, Jakub Kicinski wrote:
> > On Wed, 13 Mar 2024 14:25:07 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL via B4 Rel=
ay wrote: =20
> >> Reported-by: Justin Swartz <justin.swartz@risingedge.co.za> =20
> >=20
> > That's way insufficient for the amount of diligence and work Justin did.
> > Co-developed-by, at least, please. =20
>=20
> Fine by me. Do I need to resubmit or can you add it while applying?

Please resubmit.

