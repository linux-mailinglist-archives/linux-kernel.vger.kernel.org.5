Return-Path: <linux-kernel+bounces-139232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7383A8A002F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9ED1F26A51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED941802B1;
	Wed, 10 Apr 2024 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NctKVa6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4360617F371;
	Wed, 10 Apr 2024 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775507; cv=none; b=AZhoX4wwqh1CyzbahRyqyDHM2xgYKbZVuJesqeYGQKVjPY3A+Jrz3a150EGAjiDKWZZOyGTuTqa1PsQ9sQPk5PwjXU6Bg71si+HVijshGifPZkue8c9h78jahOGlKLYv2IcETpxWGJE5KLAPIkMym6V2xunQBN7V+KVArjeafEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775507; c=relaxed/simple;
	bh=9YYPyx0qIUyI2HnU5/vkhTGz6+QCGmfdShkQKgzhQ6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTErlucS5XhFHraCFYMvCa30A8OlR8+XFCjux2+7F3XlxPFLSorAHnPLK/Rf+AsKLoefCEOkDP3xQvxcWotK8D3FZAsyUXPQ0rxBR5wGiMIeuxEpUiS8h8RYAPt2v/LyFcmRm2bU1DbC/OyqULQd6RN1djgtfIDs9M8IsdxEv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NctKVa6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C449AC433C7;
	Wed, 10 Apr 2024 18:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712775506;
	bh=9YYPyx0qIUyI2HnU5/vkhTGz6+QCGmfdShkQKgzhQ6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NctKVa6nDuwhkik7DjWM/8gh6F+hOS55GKTNqBVCX1nBdzkyfiYssDUSeRGXdCF2S
	 wxkoec0/uuRSCRW7Pq9Hi/Ha4DvgRKER3vzJ3UHVdATxV7WQlxWo3GNSvHIVE35aqx
	 bsSYCoy+DFdkQW2vjW4ebXc9IH9SRhMxnDOl3XjC4NvcVIPC8xPC/B/9gT8BaqDCCY
	 KvQWXcWzW+TSyFFnROqICrLEUwMaeMFms0kmBgJBAayEctO6ln8J34GTEZ7ScOb8zy
	 lHcNfa0Wt6RGjRIAL6b7ilVf22abWc7Wj2xhgf9XyTvvADKixDs7OD44sWp35AQkdP
	 EFEigzh7HECrw==
Date: Wed, 10 Apr 2024 13:58:23 -0500
From: Rob Herring <robh@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Magnus Damm <magnus.damm@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-renesas-soc@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: net: renesas,rzn1-gmac:
 Document RZ/N1 GMAC support
Message-ID: <171277550043.890351.16696873966908975164.robh@kernel.org>
References: <20240409-rzn1-gmac1-v2-0-79ca45f2fc79@bootlin.com>
 <20240409-rzn1-gmac1-v2-1-79ca45f2fc79@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409-rzn1-gmac1-v2-1-79ca45f2fc79@bootlin.com>


On Tue, 09 Apr 2024 11:21:44 +0200, Romain Gantois wrote:
> From: Clément Léger <clement.leger@bootlin.com>
> 
> The RZ/N1 series of MPUs feature up to two Gigabit Ethernet controllers.
> These controllers are based on Synopsys IPs. They can be connected to
> RZ/N1 RGMII/RMII converters.
> 
> Add a binding that describes these GMAC devices.
> 
> Signed-off-by: "Clément Léger" <clement.leger@bootlin.com>
> [rgantois: commit log]
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../devicetree/bindings/net/renesas,rzn1-gmac.yaml | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


