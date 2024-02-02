Return-Path: <linux-kernel+bounces-49054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2E846557
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88EFD28BCDC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C944463CC;
	Fri,  2 Feb 2024 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sy8L5oZZ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D353A2;
	Fri,  2 Feb 2024 01:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836614; cv=none; b=pbofN7sIKfXS3bAQKHhgLTYDUhSma9Hy20BOV3qGlZj7AOWCqUMKpRNvkoA5SN7GuI4ISQo2vVc26VMw2iGxFx+LYDcMV4EymOKluxtdei1gz8oNrEpOU32hNP5rQVCNJ7FrtoIGnEjG7VvpULZ7hQFcMQK/o6XKbEpOoN2+DQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836614; c=relaxed/simple;
	bh=yW5AGAGXClWKsZDkZkhBCsAVxDNe52eYj+53BwmQDfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HaUV6fg6OohbgtGSfzJ7WyrxalCZzFOvM945QLs7EDAmmWQG2DkM+av9sQEVRHTSmKyIzSMk0mxkqlxKidUC3j3v+yHHfYfVDHWCtefcboWESJX2F6buqYW8Pj9lxRJqR5yELSQxatKbhYglLUDbB2JRq1NrJVepl8vXOQCKYvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sy8L5oZZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ve/7LM8S/UJI1k9A6JeJcpf47mw9cyjHBuN+rVj0Xw4=; b=sy8L5oZZCzX6PHTspscT1E0mJI
	cpSQgyHpRSqvG8i9XJ0uamEVcZpSe2roUWTUcNv2XvXUVYe+kyl7EQcOH5jg9JhuRvJZrT50siQ1x
	Kb7OFvG2nFo5O8q+uXIk8w5Adq0Xgpakg4N3dXtsKH0+s4wTcxQ15j9PF1wbg1K3tpcU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rViAa-006jga-Fk; Fri, 02 Feb 2024 02:16:40 +0100
Date: Fri, 2 Feb 2024 02:16:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 6/9] dt-bindings: net: Document Qcom QCA807x
 PHY package
Message-ID: <2cd72962-2fca-4436-91e7-e1695525bab5@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151747.7524-7-ansuelsmth@gmail.com>

> +  PHY package can be configured in 3 mode following this table:
> +
> +                First Serdes mode       Second Serdes mode
> +  Option 1      PSGMII for copper       Disabled
> +                ports 0-4
> +  Option 2      PSGMII for copper       1000BASE-X / 100BASE-FX
> +                ports 0-4
> +  Option 3      QSGMII for copper       SGMII for
> +                ports 0-3               copper port 4
> +
> +$ref: ethernet-phy-package.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,qca807x-package
> +
> +  qcom,package-mode:
> +    enum:
> +      - qsgmii
> +      - psgmii

There are three modes listed above, yet only two values here? Please
describe how they related.

> +
> +  qcom,tx-driver-strength:
> +    description: set the TX Amplifier value in mv.
> +      If not defined, 600mw is set by default.

Looking at other bindings, it seems pretty normal to include the units
in the property name: qcom,tx-driver-strength-milliwatts.

   Andrew

