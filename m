Return-Path: <linux-kernel+bounces-56362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23684C93E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD921F27766
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C8199B8;
	Wed,  7 Feb 2024 11:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofNieulp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69938224EF;
	Wed,  7 Feb 2024 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304148; cv=none; b=rFIimeS7H4Z6bOyn+NE4NIw9cQuin4l8gtprzEo7psQ6feOuOo+vd51szZ//HIHA+/ctxyJhxWeCSKWDPd8O85K/xidgzu/Ii02Oh73PgHFQUkeAZh3ydqBeCoxYiUky7Qi7FKGtu+Wrnwx+Rkjz0pLYnmrvzGfRx9NtUcgqKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304148; c=relaxed/simple;
	bh=91DCFeQ7d3VJjnWv7geoiac+u+Qyv8mwJMlI/ARZNSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL2CLAS8fBWNmhBcns+TcnfwoyL6nRNe5sgZtjXyVIKAVlqbHU3JXAoxHafPxWS8aYBjrW9neoPMkybesyyapcb6f+cYzefiGElZprd6WErCZSYlvGs5Cvd4NPp8a5PU92D5Tt9nBDcBbuvu3LjOe2ra8D0LTka2Ti4Vi04f3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofNieulp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACC1C433C7;
	Wed,  7 Feb 2024 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707304147;
	bh=91DCFeQ7d3VJjnWv7geoiac+u+Qyv8mwJMlI/ARZNSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofNieulp1lv7S4WEoCoFFOejsfQCM/0UFI4LnmKrztj2CzYKy54049p3ECwmmLtzg
	 6BybZv6ROFqk3ejU0udD8uy0/peDzW+S8QdpKyiPYGE06/zu2xb9hSfRjaVvcJjP/Z
	 hlCazkBchNnA9ZRu5AFr8KyI4QItkouKcSImzUq+T4QNl9PBp/evBpM553rKPk20eu
	 S02Z1qtzt0eIcUdqagCdaR9RhXEUCigJ2OydxW9sSHXuQjCdpsCENcnSl/ZnDrw8rX
	 nGjFtjcQSECzWYySlTaZAFXUrUsLVriI26BAIKhTqO33DX8iiDRgbSnN42OpOjROhr
	 FiH50pSostpDA==
Date: Wed, 7 Feb 2024 12:09:05 +0100
From: Vinod Koul <vkoul@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 0/2] phy: mtk-mipi-csi: add driver for CSI phy
Message-ID: <ZcNk0VylU2mBsewy@matsya>
References: <20240111101504.468169-1-jstephan@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111101504.468169-1-jstephan@baylibre.com>

On 11-01-24, 11:14, Julien Stephan wrote:
> Adding a new driver for the MIPI CSI CD-PHY module v 0.5 embedded in
> some Mediatek soc, such as the MT8365

You would want to fix the way you send patches, the series is disjoint.
I had to apply them manually, but please fix your process

-- 
~Vinod

