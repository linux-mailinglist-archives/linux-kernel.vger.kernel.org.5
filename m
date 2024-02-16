Return-Path: <linux-kernel+bounces-69056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC078583E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25765283819
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C1219ED;
	Fri, 16 Feb 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4LoqQsbW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9C1E53F;
	Fri, 16 Feb 2024 17:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103810; cv=none; b=syUhZlItkmtED7m4c58JqHP0/4uBsvMD2AKRnka0Eoy92JiL/wJl+ZFuqI/1uevlKXus4rI+OoRyZqxe+EJCqmW97fQVkPBaNUHJR8eWJ7JAsN/ghnfIzqVzFoFLLvEnV0oRrfu8IytiiFPEXMqUorNF8v0inRBQgrPbeQl/WAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103810; c=relaxed/simple;
	bh=3pfy3uw6X4A5yd7ITUWZQtrvTmTq4SidsDEt+RRdoz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc4OOiOKr4p04QAZumePrFcGtytfk9aUPO+4HfC4wSa/sTCjKnCUf4peIpsgb9+Cr1aiir5DBTwR974AaFj0XcY7OoOdffLYbp8HR71+ujOz/aP2T1hq7QpYqpMkebOKr7wyIr2CLiqpR82Gy4mab1yiFu7brmmZLiqsKmqaJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4LoqQsbW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l9mYR212SPf+R9mwmI8TrJIzfSG5c5mRs1Qtd2wu1Xk=; b=4LoqQsbW0LUQvAGL26r5DYs7C2
	N6jZG5oN0YVkqrD4JZ0CSnYCKKVwGtrc0DcawUGSO88B8jpSh7Un3PuVuROheCX/nDDBI8sRrZ6RV
	RmMWNkhMQLn6JT1XnZx/JLj4Cw67ryxo7c6vCWV0s2ye1u3dw0cfpC3cgoZtLHjxC+7Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rb1pT-00805C-TI; Fri, 16 Feb 2024 18:16:51 +0100
Date: Fri, 16 Feb 2024 18:16:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/8] clk: qcom: ipq5332: enable few nssnoc clocks in
 driver probe
Message-ID: <9638a213-76a5-4a72-b6b2-018ae50305be@lunn.ch>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
 <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
 <11fda059-3d8d-4030-922a-8fef16349a65@quicinc.com>
 <17e2400e-6881-4e9e-90c2-9c4f77a0d41d@lunn.ch>
 <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c9ee34c-a97b-4acf-a093-9ac2afc28d0e@quicinc.com>

> You can get the source at https://git.codelinaro.org/clo/qsdk/oss/boot/u-boot-2016/-/tree/NHSS.QSDK.12.2?ref_type=heads

Cool, thanks. But is it really u-boot from 2016?

> Yeah agree with your comments.
> 
> QSDK's u-boot enables the network support, so the required NSSCC clocks are
> turned ON and left it in ON state. CCF tries to disables the unused NSSCC
> clocks but system goes for reboot.
> 
> Reason being, to access the NSSCC clocks, these GCC clocks
> (gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk)
> should be turned ON. But CCF disables these clocks as well due to the lack
> of consumer.

So there is your solution, make NSSCC a consumer of the clocks it
actually consumes. If it needs these clocks, it should get and enable
them.

	Andrew

