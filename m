Return-Path: <linux-kernel+bounces-139951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4408A0989
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 166AC285961
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F513DDD3;
	Thu, 11 Apr 2024 07:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8lWqN0C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56266523A;
	Thu, 11 Apr 2024 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819905; cv=none; b=WpUxvTS8WD5qVltft7suPWDANS+Osmk8yiJ5sAy9MYVHaeK66ZBf4RE345UP/vWm6VBHZ30l0oVTwlEysaKKh2LLqM2RpITEEpUniNuelbrPMMM15XPIqHIZUdxuY1wjA5SxziSih28rBsx0zg2cIEfOb4Z35aC6XJYTjmz3Uf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819905; c=relaxed/simple;
	bh=Fxl3UAxxdccge/7kQbDMtazesOqAlbDnWZK9DuxS59Y=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=SejrNnE1gJXtJ6rBJnF+zK/jVlprGk9wBtpJs0FP0w/QIjJaFrC/WL7VwSPZoFWcpqnEVyYWP4dMp4OKPn3Zor4OjaTmDybaSZauzeMCkfJQFvSTekIAc0R5vqoU0bdH6Gt2xYL+1a/09ou7/gxxrifYRy05ESocll/BrjITRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8lWqN0C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5E9C433C7;
	Thu, 11 Apr 2024 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819904;
	bh=Fxl3UAxxdccge/7kQbDMtazesOqAlbDnWZK9DuxS59Y=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=j8lWqN0CKk+hoSc6tvXsWqN3Y6MPkwduDHe9xcToKFwimYhHzc7F1MFPWHacMfkKv
	 qQXZdsg8GjJQIav7E8lyw2+ZUuqrkS+s/2H0sKGp0TBbq3dnL9d37cFexdebxwB3MY
	 BEl0OeZhvhCVbCNNcD8r9iM09w9T8JiXfdOmyNPv3OOpOC8Y/Pt1/gvltsyyVjw4GW
	 cCExcrZYrZungv+EcmPmaeLlBKCkPaDZgIIdfe6WFhftOEO1MjuFkxP1XRhT/yBih5
	 jhm9wethMGtpYcqT4wYpXUUE3EjmnGA1sr8Q2QqiVBb+DVKkAm0WTcJJEPJnVWdaoh
	 8Irzz+eQ3wTyA==
Message-ID: <91d20871180273b2898645ed61028882.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPUP7E7RmfOpN4C+BZT-52OeLe349NY_XPaj6HaiG_O42r9n9g@mail.gmail.com>
References: <20231215115914.11588-1-zhifeng.tang@unisoc.com> <20231215115914.11588-3-zhifeng.tang@unisoc.com> <057db34aae21f78ca68ca0cc2930c97f.sboyd@kernel.org> <CAPUP7E7RmfOpN4C+BZT-52OeLe349NY_XPaj6HaiG_O42r9n9g@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] clk: sprd: Add reset controller driver for ums512
From: Stephen Boyd <sboyd@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Orson Zhai <orsonzhai@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Zhifeng Tang <zhifeng.tang@unisoc.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Wenming Wu <wenming.wu@unisoc.com>
To: tang zhifeng <zhifeng.tang23@gmail.com>
Date: Thu, 11 Apr 2024 00:18:22 -0700
User-Agent: alot/0.10

Quoting tang zhifeng (2024-01-15 18:10:45)
>=20
> Dear Stephen
> We clock controller register block also contains reset bits for some of t=
hese
> peripherals=EF=BC=8C
> so reset controller and clock provider are combined together as a block,a=
nd put
> it under the driver/clk/.
> Under driver/clk/, we can also see that other manufacturers support reset
> controller=E3=80=82

I still don't see any reason why it can't be an auxiliary device and the
reset driver put in drivers/reset/

