Return-Path: <linux-kernel+bounces-1028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B677814976
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2857628674E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D52DF9F;
	Fri, 15 Dec 2023 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wFh8KTDa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230818C2F;
	Fri, 15 Dec 2023 13:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wtwSbmM7l1ab40jpBtWJLq9UlQFmWrKdHhgxv86nFSE=; b=wFh8KTDajmYxCZQ+++PVkwX39F
	BAZJl6fIM/4Ff6l4Nlmxirf6s+mhZ1nETZCaQrz/KkUhhmcf0sMyrlR13ZbN7LWJoX5UD+TyrqYx0
	u1Kf7VCqiDUKEdF3CYjSPy3ZIcmg08xaI+D/5saClC+cR8sCtpM3B2Amw3hU9TEwPGp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rE8Pe-0031iW-Sy; Fri, 15 Dec 2023 14:39:34 +0100
Date: Fri, 15 Dec 2023 14:39:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Conor Dooley <conor@kernel.org>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v2 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Message-ID: <3d89a725-ce81-4d13-b5e3-75198c408f78@lunn.ch>
References: <a1e5ffec-a20d-4389-83f9-ee09bd9d733d@linaro.org>
 <a84a36af-69f8-46af-967e-b06d028597a3@quicinc.com>
 <26c8b0b1-5ea9-45cc-adf3-0d0b03a1284d@linaro.org>
 <4b9c56b8-3b29-4861-a3d5-2da26fbc14b4@quicinc.com>
 <2e77e3b1-00b6-46b9-bfed-7cae3ffa15e9@linaro.org>
 <7bae46fd-63fd-4b86-9a56-73052cf0ea95@quicinc.com>
 <5a8095e6-b6a6-4d11-b006-31519e8d8622@linaro.org>
 <7466b655-2b7e-44f2-a510-6e0cc1b95248@quicinc.com>
 <602759ce-c93d-4111-9272-1dce7e4a170a@linaro.org>
 <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f656d1c7-ea86-405a-9165-9eb079ea6f2a@quicinc.com>

> > You keep answering with short sentences without touching the root of the
> > problem. I don't know exactly why, but I feel this discussion leads
> > nowhere. After long discussion you finally admitted that clocks came
> > from another device - Wifi. It took us like 6 emails?
> > 
> > So last statement: if you have clock provider and clock consumer, you
> > must represent it in the bindings or provide rationale why it should not
> > or must not be represented in the bindings. So far I do not see any of
> > such arguments.
> > 
> > If you use arguments like:
> > "My driver....": sorry, bindings are not about drivers
> > "I don't have clock driver for WiFi": sorry, it does not matter if you
> > can write one, right?
> > 
> > Please reach internally your colleagues to solve these problems and make
> > review process smoother.

Yes, i strongly agree with this. Its not our job as maintainers to
educate big companies like Qualcomm how to write Linux drivers. There
are more experienced driver writer within Qualcomm, you need to make
contact with them, and get them to help you. Or you need to outsource
the driver development to one of the companies which write mainline
Linux drivers.

	Andrew

