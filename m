Return-Path: <linux-kernel+bounces-167351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CEF8BA85C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5DB1F2244F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB1148854;
	Fri,  3 May 2024 08:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adgumGdh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727F219EB;
	Fri,  3 May 2024 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723888; cv=none; b=nbIh2orLXZlSvkeGr9qHkhdWUrhnq4TdiLsYpMzMk3mV/R4bDQXWAjKGwfbumfh7L5GO8hCmHvKxzOb5GjsIPtkp603d/nwjzKuxYcMiYSym3ETaRVfVBR5+pwLnh8Trz3KYOZ/hz3Y1vGClprmTX9Q0cryuWc7n1fTGoXV9AQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723888; c=relaxed/simple;
	bh=zW8kPPzhTDL3Y+nV9+ePejm9frxfcTnTVBMJ/MpjjNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo+GRLYIF33PNjjI6srMCcA2C96UAeTaSaepP65S954WPTqDG4jhE9EPBai3gw4M41qruhcQLcvv/RC29p6RdYb1f11WbOT0DZ383lYFlvH2gMKumvbhINFUCjRACJPAqNXWPDRkIPzSrMj1lIWFjf8j2xP7ztrpBRrzkr3/n7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adgumGdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCDBC116B1;
	Fri,  3 May 2024 08:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714723887;
	bh=zW8kPPzhTDL3Y+nV9+ePejm9frxfcTnTVBMJ/MpjjNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adgumGdhDzuxmYh3kAZsp0gddPLx5Abm3vM/6/swNyiLE1H1qalo40Uo/rvtXd6bH
	 Sq/wMf52ruyGpfkEbeLc9lJXznj2rJsCVrW6ADI9MmzXDn0N9uOHBMmKkJi0J1Dgf3
	 mRIceLQNNJKOmbTJRlqnxEU7ZWULJCN8u/pd1yRLHKWd6l7hZdIRAZOU24JqGopwzx
	 rrpjcREwOH4+9r2W6L2Qn5YUsAFwxvgZVRhoP3bIfBbWWLbp5l2ZBjjtYC+/I7DGn2
	 oeMWU/OX3l3hZx2DRqh9KvDCPGpfv3wkTldS8KTsb40ySBnYoJMZ3g/nOMG+rQZ7FC
	 84Hp4otqKv5+Q==
Date: Fri, 3 May 2024 09:11:21 +0100
From: Lee Jones <lee@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Chris Zhong <zyw@rock-chips.com>,
	Zhang Qing <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v4 0/5] Add RK816 PMIC support
Message-ID: <20240503081121.GH1227636@google.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
 <69945c53-1fa5-4fde-b488-6056c5471095@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69945c53-1fa5-4fde-b488-6056c5471095@gmail.com>

On Fri, 03 May 2024, Alex Bee wrote:

> Hi Lee,
> 
> it looks like all patches except the MFD ones have been reviewed/acked by
> now. I hope I integrated your feedback to v3 [0] in a way you were
> expecting. Also I was hoping this whole series could be go though the MFD
> tree, since all the none-MFD patches depend on the changes mfd-header.
> 
> Please let me know if there is anything left for me to do.

I have the patch open 'right now', please bear with me.

-- 
Lee Jones [李琼斯]

