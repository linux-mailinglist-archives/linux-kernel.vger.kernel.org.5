Return-Path: <linux-kernel+bounces-39229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA2783CD1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED42D1C24CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0174513666B;
	Thu, 25 Jan 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ch5/8b3f"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73B134730;
	Thu, 25 Jan 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706213145; cv=none; b=XfxHBL0xPIhv615+qqP55sFilt11Pi0Lo1UHbyC0C3t7eNhWdLts4uf+0vtXDJbT7N+jkvQ+JbepholezYduIhf8SfKZ/gaEJBEdiOo5R7wDdGTRPBfkYrK/WWR8g4OQBn4YmWvNYY2MZ69jTwhwIXA8n6c4CDwV/lQnMNWCP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706213145; c=relaxed/simple;
	bh=WBaEFU0HD/ZpYZcSyEk08bbjDIygWcVOBE8OjlEUd3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTMcybqrLfcJV4DDvcsHh/qfrjS2mF7xspYv6Fwl6xRh0MV7TQ+4WkaBoNBeDmXXwEcBZ9FsAUI1lX8/TDOaap+L1vg/PUZfJPmec1MQHWnDfXBG1ZI3+GHMWcnn7pqvWGr/ojN4nV2ZXb7KQNvZoIT51lby9Em64ktbOovrSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ch5/8b3f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PSP1mwXt7pbVQqCb1c1AUqEAyMaE5dkMskynL1tp6dg=; b=Ch5/8b3frcnqGViJrO55oIG1hK
	KCyHsGaAI2M2KL74z6fIm3tlvk2bgW8h1JTdxUdqjXUSl/LlZ8XgIJoHwGHw6hP5vIJEoIfgosfmy
	+FeuruMUTm2HxmCCFeGWn96d6zPTUdGwoCpS47jNJuQV7CtycTpMfVlXCt6p2holagKA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT5yg-0067Ml-Ai; Thu, 25 Jan 2024 21:05:34 +0100
Date: Thu, 25 Jan 2024 21:05:34 +0100
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
Message-ID: <7a69a68d-44c2-4589-b286-466d2f2a0809@lunn.ch>
References: <20240122-ipq5332-nsscc-v4-0-19fa30019770@quicinc.com>
 <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-ipq5332-nsscc-v4-2-19fa30019770@quicinc.com>

On Mon, Jan 22, 2024 at 11:26:58AM +0530, Kathiravan Thirumoorthy wrote:
> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> enabled by default and it's RCG is properly configured by bootloader.

Which bootloader? Mainline barebox?

> Some of the NSS clocks needs these clocks to be enabled. To avoid
> these clocks being disabled by clock framework, drop these entries
> from the clock table and enable it in the driver probe itself.

If they are critical clocks, i would expect a device to reference
them. The CCF only disabled unused clocks in late_initcall_sync(),
which means all drivers should of probed and taken a reference on any
clocks they require.

Please correctly describe the clock tree in device tree, not hide
clocks because your DT description is not complete.

    Andrew

---
pw-bot: cr

