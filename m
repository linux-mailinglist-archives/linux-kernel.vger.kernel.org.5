Return-Path: <linux-kernel+bounces-39233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44583CD32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE2B1C23E80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E23137C2B;
	Thu, 25 Jan 2024 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qR5345bb"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE75135A5D;
	Thu, 25 Jan 2024 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213527; cv=none; b=pPd4lIBlbL4z/P+qcX0GyRzKA/kdfUNdriQteEQx0qoOwqW0fZIKrnT1JDT0D3aUedUaxkFjS0Ij+n8Pkx919hxO5hyyi3FR0z182g3hk4PxEWfC08eoi9VhAeLGWTeXf4JqEDo0vmdHiaBzruE35vCbDPbsHTOWGmCl03YHlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213527; c=relaxed/simple;
	bh=27T1NLakmj/1AjMRk4+ROq1pwjUNd9JBGAB/g87CZHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjTLw2B2iqkJXwoVEphlQ6bAqe4WPFzc+t+gbxbgrcm2ZWyPbB5mtc0ajwt41XUc2+nSPaTX8IjDW0xrs+7H6yfrxZ4SzQ0618GZqqYIc2b7AfQNJXKbP2/UTBxNoO1UdSItRDhbqSzpbkaHUrclSsZ4RfYrWZZdsqDmcOXjJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qR5345bb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Tz53wyPc4pe7G+zHxuZ+8kfW0OKtKOOeDrNRA5aAh9A=; b=qR5345bbvV3FW3dFU60qy6qAtU
	w9Fi8jlp17mR78eUdVfv7ptyiU5xkkV7QdVDaGii0+VhpfUEZgERbU59ShuajSe2EQYxRvk43QdlL
	X1KurnZRnC+vzAF0tagW5AdIxZirEUyc4egP/lBzY7mgIX8GAmWeRg3tbQ8fnvbXz9Cw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT64t-0067PO-3X; Thu, 25 Jan 2024 21:11:59 +0100
Date: Thu, 25 Jan 2024 21:11:59 +0100
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
Subject: Re: [PATCH v4 4/8] clk: qcom: ipq5332: add gpll0_out_aux clock
Message-ID: <635f5e41-1ca2-4b4e-86a5-fdb8f7b27ef9@lunn.ch>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-4-19fa30019770@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-ipq5332-nsscc-v4-4-19fa30019770@quicinc.com>

On Mon, Jan 22, 2024 at 11:27:00AM +0530, Kathiravan Thirumoorthy wrote:
> Add support for gpll0_out_aux clock which acts as the parent for
> certain networking subsystem (NSS) clocks.

This answers the question i asked for the previous patch.

Why did you split this into two patches?

Please also give a more detailed description, rather than the vague
'certain networking subsystem (NSS) clocks'

If you device tree and drivers are correct, i should be able to work
out what the clock tree looks like, so there is no point trying to
hide the information.

     Andrew

