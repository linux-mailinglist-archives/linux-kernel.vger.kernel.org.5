Return-Path: <linux-kernel+bounces-82431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74A868473
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528791F2293A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1EF135A70;
	Mon, 26 Feb 2024 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="biDX9XVZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0541350CF;
	Mon, 26 Feb 2024 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708988733; cv=none; b=BJXvR+hJGMTG3JVQgq3YZQl8wu6+blAkV7DqXdGf6dS3jAeRWq9uStCHzNQhaS+tRULNLjX6LcUb56aOvt6YTPQ0hkZnmQWJ8WxNpjJbG1NRakgfPFmuIY7k/vM20JwT3BsSd1hm/++g2C8c4K+iz/QZRpbHIPslYwLLAkkw5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708988733; c=relaxed/simple;
	bh=TWzun0oNIPfc6lqE3DTPBQ4RosQxCFz5BwOT4xEIKSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMoQgVUQ3eG48O6dhBw23K0PTlj9/PBaBgQlh+gvDohGBR/ixek/svdURsq7h6ETxb49siW81EoGOMjwRS/cqKDji0LsSoxrRt75Jx3OJe5NMAa+mIfK0UHZoGSqhDD9tcIWuCworOvS1Kdtnq2oEaQlWsRSyvYo/3uxOLqgViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=biDX9XVZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pYmdkgX1dVrE40bWWH7YizC1+wHj2Ilzj2iousZ5MvQ=; b=biDX9XVZoNS+cu+iILmQSUl1K+
	Qg9ttG/A56qZt0e4lsHbOPZw1aHansTRFWg7u3iBfNdZv0inSyJh+RRvOrrYAm72UhuCMqRUD/KCG
	5Ojfv0AiI7kvUVIbFYnMiYQiIeYZlZGzXUM38f9nmsFFD8fcu/6Cn2Xmyc4O66l8g7+w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rek2P-008lo4-S6; Tue, 27 Feb 2024 00:05:33 +0100
Date: Tue, 27 Feb 2024 00:05:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Sarosh Hasan <quic_sarohasa@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>, Rob Herring <robh@kernel.org>,
	kernel@quicinc.com, Sneh Shah <quic_snehshah@quicinc.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Subject: Re: [PATCH net-next] net: stmmac: dwmac-qcom-ethqos: Update link
 clock rate only for RGMII
Message-ID: <89c54319-82d0-4cb3-b3be-ccdf6dcf2742@lunn.ch>
References: <20240222125517.3356-1-quic_sarohasa@quicinc.com>
 <54b8c58a-6288-4ae6-9ed7-aa7b212e63da@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b8c58a-6288-4ae6-9ed7-aa7b212e63da@linaro.org>

> >   static void
> >   ethqos_update_link_clk(struct qcom_ethqos *ethqos, unsigned int speed)
> >   {
> > -	switch (speed) {
> > -	case SPEED_1000:
> > -		ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
> > -		break;
> > +	if (phy_interface_mode_is_rgmii(ethqos->phy_mode)) {
> > +		switch (speed) {
> > +		case SPEED_1000:
> > +			ethqos->link_clk_rate =  RGMII_1000_NOM_CLK_FREQ;
> > +			break;
> > -	case SPEED_100:
> > -		ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
> > -		break;
> > +		case SPEED_100:
> > +			ethqos->link_clk_rate =  RGMII_ID_MODE_100_LOW_SVS_CLK_FREQ;
> > +			break;
> > -	case SPEED_10:
> > -		ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
> > -		break;
> > -	}
> > +		case SPEED_10:
> > +			ethqos->link_clk_rate =  RGMII_ID_MODE_10_LOW_SVS_CLK_FREQ;
> > +			break;
> > +		}
> > -	clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
> > +		clk_set_rate(ethqos->link_clk, ethqos->link_clk_rate);
> > +	}
> >   }
> 
> if (!phy_interface_mode_is_rgmii(ethqos->phy_mode))
> 	return 0;

It is a void function, so no 0, but otherwise this does look less
invasive.

   Andrew

