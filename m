Return-Path: <linux-kernel+bounces-142667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11B8A2E93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00AD51F22035
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFBC59170;
	Fri, 12 Apr 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AA3GGZZW"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FEE4597C;
	Fri, 12 Apr 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926230; cv=none; b=CSnc2+Fj4K5arB7JL4X9a4aJtqtOVj5CXsfSM2qsIM+BRyguhnKbUmtvR9SaJo1v4ZxiI3t/OAx558lPHdOtVqzK0nj/EVtICoMkFi50umy/v5IQDmLaTxjtehZ0OII/qavutT2I20bWXCwVHoBPtODCQpO32nV95vN4M/+/GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926230; c=relaxed/simple;
	bh=RfwAPgOp5LejBlfDqP+Nmw/PGfFWYFcMyq/91l48VgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6sZEltuMjMlSZKVbQp44SW7GTq6s+IkeiQn94OMGHirBjOHLIXc2TC2pnEz7f9huv7SbSuq4pnDmWj9N+Yh2vLLn3JMgsM/mqFu7uG+fI/dPmiSbZ3lL7ILIdPql2Sx3dhLfttibrL1v4qzEUiBQaGce8StNZKQ6k7L8nq9S6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AA3GGZZW; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BEC5120210;
	Fri, 12 Apr 2024 14:42:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1712925728;
	bh=MajZ5hUyuuKB10smjUCbtBuKZkOL7rvb1r77L66soMU=;
	h=Received:From:To:Subject;
	b=AA3GGZZWDf93Z9MzYr513rqfZspeYyVtjBNikZlSCkmryx/pzXQ76AFeeQN7CePVb
	 Qvb7fjhAef5W9ZqQ2zl7op3Gl+T/fjrQTvRMjV1GSBnHkcPfw6+vrw2b45oNJe3+h2
	 +kqaS9WPzhnOG0VUrjjqfVvFmOpqTms3LkOp7gYBJ8gXnCJbVoOxfDtbJIdGqEobO3
	 bHldUn03uciNcn69Vq+1m0yLGBcn1R5+SQN68Oinw+2Lh5zX/IHT5nXaItec1jPWEy
	 pXZnVFJXD8MFFWbwrc4nIualBfjPWayRRx4X4a0pnY8Jc3439jNeVHF8x4sEkPaxKQ
	 BK+zeffz9iqcg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 590AE7F950; Fri, 12 Apr 2024 14:42:08 +0200 (CEST)
Date: Fri, 12 Apr 2024 14:42:08 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Roger Quadros <rogerq@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, afd@ti.com, srk@ti.com,
	r-gunasekaran@ti.com, b-liu@ti.com, francesco@dolcini.it,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ti: k3-am62*: Add PHY2 region to USB wrapper
 node
Message-ID: <ZhksILmpPf5l_-cU@gaggiata.pivistrello.it>
References: <20240412-for-v6-9-am62-usb-errata-dt-v1-1-ef0d79920f75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412-for-v6-9-am62-usb-errata-dt-v1-1-ef0d79920f75@kernel.org>

Hello Roger,

On Fri, Apr 12, 2024 at 02:52:14PM +0300, Roger Quadros wrote:
> Add PHY2 register space to USB wrapper node. This is required
> to deal with Errata i2409.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Closes: https://lore.kernel.org/all/20240408095200.GA14655@francesco-nb/
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Thanks,
Francesco


