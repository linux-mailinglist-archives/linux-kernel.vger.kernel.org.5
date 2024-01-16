Return-Path: <linux-kernel+bounces-28364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088882FD54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22081C25B88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98001BF5E;
	Tue, 16 Jan 2024 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cfY2OqOC"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F01D68B;
	Tue, 16 Jan 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705445819; cv=none; b=FM/6J73LQZYruPzSHvGmfe5rsqt2vWeKx+0l1LNxzO29WO7adoc0KBmRB8ozhn5mfVHRK0uWhmZ23o3/uvj88HW1N7v4u4ZhkEmhOtYS9m0BcdfeHn5cKmaGAGKU+mszln5qQ/RLaCDSfH1RWA7bhNB7yTCTjzjwgMUeQml8CX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705445819; c=relaxed/simple;
	bh=plU7Fyl05aYaKwdG/SP/6ie/ejtRdcYCuh2yJUj64x8=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ZNSWklHRnyQP3UhtoIBbJwR4DP9gnuiccG3eqUreDDJYucjlQdFfGSoBWu+eGJMpc2Ws5lqcAaKPnrpieYfqfqUglmYZzqdg9psEmuVVz9YDZcrQAc51QPd07g4Ohoa/KQ0SWM9qz+pksaNmk51b8s27GhqHaD9d3TFVjm3cwgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cfY2OqOC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8mVrgl5xMNMm3WZOrIWhZNDZHloqaD1XFaFbuzdsviM=; b=cfY2OqOCFRcI1e3AOkEb5pDgSI
	iYgrk6FIHj2duCg0p3VQP/3DuAf5Ocz273VHzNCGbmWA585dW9wPwlj4i8fBGqzcClfUnP2C1Zdid
	LFfgC8uRLttGJjLtHzwCab7cyze7pd+Kw/7RoHf6HpN1iKia0rjV+CVnwdR0auZstPoo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPsMW-005MUt-Sm; Tue, 16 Jan 2024 23:56:52 +0100
Date: Tue, 16 Jan 2024 23:56:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jie Luo <quic_luoj@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	quic_kkumarcs@quicinc.com, quic_suruchia@quicinc.com,
	quic_soni@quicinc.com, quic_pavir@quicinc.com,
	quic_souravp@quicinc.com, quic_linchen@quicinc.com,
	quic_leiwei@quicinc.com
Subject: Re: [PATCH 3/6] arm64: dts: qcom: ipq5332: Add MDIO device tree
Message-ID: <6975e79a-67eb-46d7-8445-92610b8b5198@lunn.ch>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
 <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
 <61973012-3f74-4b58-9575-3bc5199f61d9@lunn.ch>
 <5c88945b-4a80-4346-a77c-82a68ae02047@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c88945b-4a80-4346-a77c-82a68ae02047@quicinc.com>

> Another one is the MDIO slave(gpio25, 26), which is dedicated
> for receiving the back pressure signal from the connected Ethernet switch
> device QCA8386.
> 
> There is a MDIO master block integrated in QCA8386 switch device, this
> integrated MDIO master is dedicated for generating the back
> pressure signal to IPQ5332 SoC.
> 
> This MDIO slave block of IPQ5322 just needs to configure these PIN
> mux for MDC and MDIO PINs. No additional driver is needed for this MDIO
> slave block of IPQ5332.

So there is a proprietary protocol running over the MDIO bus? And its
completely implemented in hardware in the slave block? Is this even
MDIO? Does it use c22 or c45 bus transactions? How is the slave
address configured, or is that also hard coded?

	Andrew

