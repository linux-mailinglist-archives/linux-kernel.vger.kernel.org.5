Return-Path: <linux-kernel+bounces-126370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B1F8935C6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 22:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C72B20E9B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E1147C8A;
	Sun, 31 Mar 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yYKADDy6"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFBB1474AF;
	Sun, 31 Mar 2024 20:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711916939; cv=none; b=aUn7ZolK/FiCipUu3sbAjO6jeUitHWCPzmdRxMACeEmiLxUoxNnhn92mcMMii0YRWmRvWGCZY/KFXWVdH7JlXiDU7gqy6dX0yOagydGqHx9wd3MAf7YUJcnbk7mhGj5hm1gQJ5KrfUGJdWXG+DiZAsEM47WkhMhjmki6FHMiJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711916939; c=relaxed/simple;
	bh=Z3G7fKPwlf7fDLO1S2xwxB+dd0bn/W00sK5bHPCx1IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN0CRqgYGi8hx+4xUO8qfS+ojJS/kyqkXM1Mmc38xU9SoB7EGRoSHy0u+znstLMJaGfHkqYvOrdRfUT0x0ibX8kzGTQfQpV1gTlEPOyES37lAgHMqDXTbi66pLWVsKsr6oeStJlanZdV+35uKfT68JbLaPak/kX3ieFEr/92axY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yYKADDy6; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id DA8DD1FA4F;
	Sun, 31 Mar 2024 22:28:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1711916935;
	bh=W1WdIYmDPtY1FTrhgpULK7tOKrGrAvCVnwsv9uNfoms=; h=From:To:Subject;
	b=yYKADDy6gHK1jSpdNY4CXDG/jkfpvK3H5NM7GgLm5YW5ENNjcdedzPI1b64Guxn5d
	 DJ1ZAFAxyF0FGp8ObYSu/DlIQ5H4W3vDWrmjl/v1CLw5xpHesE/yo93ict+NGnZE8Q
	 R69h7iOswshVZb3kQVx1cwikpZSgUNqZUCtB8oMGKQxgNHEMUurVwqIGfk5YGd73nJ
	 w2HMtUPvPTAUwSdk47L6tnFvtJEOsBL/w2KmNnsEs4R79fO7+twxy6ZDRxrIzsuVsW
	 M05beiAyPViRJq8sNPDUY7a+Ti60TX8A7C3N9k+hVXyQw6l15Gw5iDmdm2AyAMj6/M
	 44lI24y91X01w==
Date: Sun, 31 Mar 2024 22:28:53 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Brian Norris <briannorris@chromium.org>,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
	ath10k@lists.infradead.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 6/7] wifi: marvell: mwifiex: drop driver owner
 initialization
Message-ID: <20240331202853.GB4116@francesco-nb>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
 <20240329-module-owner-sdio-v1-6-e4010b11ccaa@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329-module-owner-sdio-v1-6-e4010b11ccaa@linaro.org>

On Fri, Mar 29, 2024 at 06:24:36PM +0100, Krzysztof Kozlowski wrote:
> Core in sdio_register_driver() already sets the .owner, so driver does
> not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


