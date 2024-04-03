Return-Path: <linux-kernel+bounces-129100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A868D8964F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3798CB20B57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AED52F92;
	Wed,  3 Apr 2024 06:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ywIH0Mpz"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188D17C64;
	Wed,  3 Apr 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127187; cv=none; b=bMcL6x2tciWaoaPynFx1QgKB6s0oFOfB8c5aIg4Zbh0ERjvM0Dlmq9hxEpbw6Nu9Nq9rabC1dEf+VoYJeSOgonLLvHzPz9ReH5gRMVDH5o0quUpoWoOOvJm6nS7qX34VMiHVTXt3lPtseXtwg6bRrhHqbbYSIUrJYWVtvZBn3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127187; c=relaxed/simple;
	bh=v3b+8QaTlALli4d5q1lR+Tk4QvcKg7ry9GG0WZA9FgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHiJskCG8NGxsInqrtpfsAfQv8D1ea8/bjdwVFXtMDBJv+EFtODgPoCFOTZhJgWhqouT4WiDPNPQZSyhmybtknRNhSxw6218fpQxevr42hpP71o2TVLpArcFStt70LlgYoxLMk4G2ivqw0wV51xxDtIwyc3FKtdp7p+RX5Bkwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ywIH0Mpz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 39C031F9B3;
	Wed,  3 Apr 2024 08:52:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712127179;
	bh=v3b+8QaTlALli4d5q1lR+Tk4QvcKg7ry9GG0WZA9FgU=;
	h=Received:From:To:Subject;
	b=ywIH0MpzDo9EpbfI3KmGMd0njsOf/Hts2pTnq9bsOUgodetFUv8P/GtgWiLLZ6V1v
	 /c4TgNyOFsYB5DJtRu8o+PJThGg7S6UBusd8CUIvuXrwaLQ07iJFx1BuFWdEqcBMpQ
	 CfSzsdNIvKYHc1jA6oE3h4onrsLfDCIebD4Q3tpD6TXRLnQxg/H9MSR3mL6yWKYewu
	 rLfZzcKkz9iCAJXfK04Y7UkD09vqH398moGSd34ko4mSskjI5XpfgmYmDHV9lRQ0r9
	 AFj4amrSNyqbb79a3wFCo3wM/sXiIQDgVEglU6Qbv6n7FdBpoyUniWEKFHjVl5hAvc
	 LobwXwmHgJJOA==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id B9C667F989; Wed,  3 Apr 2024 08:52:58 +0200 (CEST)
Date: Wed, 3 Apr 2024 08:52:58 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: Francesco Dolcini <francesco@dolcini.it>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	adrien.grassein@gmail.com, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	marius.muresan@mxt.ro, irina.muresan@mxt.ro
Subject: Re: [PATCH 1/2] drm/bridge: lt8912b: add support for P/N pin swap
Message-ID: <Zgz8yvj2gSNk-0KU@gaggiata.pivistrello.it>
References: <20240402105925.905144-1-alex@shruggie.ro>
 <20240402165307.GA31874@francesco-nb>
 <CAH3L5Qr-sT+Q9ZvNSxHKwVMr8-3fU5WPvvaccEWWH49x7oWMyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3L5Qr-sT+Q9ZvNSxHKwVMr8-3fU5WPvvaccEWWH49x7oWMyQ@mail.gmail.com>

On Wed, Apr 03, 2024 at 09:32:41AM +0300, Alexandru Ardelean wrote:
> I did it like this, because I don't have a board with the P/N in the

You use this 'P/N' both here and in the binding document, to me this is
just too generic and confusing.

Just use some wording that people familiar with the topic can easily undestand,
the Lontium datasheet uses MIPI RX DP/DN, MIPI DSI DP/DN would also work fine
for me, or at least DP/DN that is the working used on some MIPI documentation.

This comment applies to both the changes in the driver and the binding.

Thanks,
Francesco


