Return-Path: <linux-kernel+bounces-106947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4887F5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E4B1F221D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 02:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC380C0F;
	Tue, 19 Mar 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EroTr9JS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851457BB11;
	Tue, 19 Mar 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816556; cv=none; b=QYv0ZavpMpMOUaHjtkAtQvvpEwEuiH8o50QlRMQ8BeAeURAAmfMwbE2d6mGbPYo8pKmGxzCfHVHVNwz1uHXIpeU0xsRs1RJRBRhzbpsc/UFnIR0HhU8pGYr0wCNWLoCyAL/1en8m6vaXQZQ7lKBkzXOA76GuxnDcjauehZjLJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816556; c=relaxed/simple;
	bh=s2n+yJXgW6xoysB19AK2uDSaXLsoRLgw3iAol4Um9/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExL5hlpmxn+gR6UrFxB+tZCsJro3e43Xs5wum5+60Ihjf6baFYndbKTdM3E0DXfvbZyWNdnk2C+C9tX0DcjEsZtFHk2oa0DWXX9PB1QMoPg7+E99gOxuASueB+wY0prRW88XzuKKhE25SjRX/ShKdy9staOAi8EheYO/EP+1ucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EroTr9JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F92C43394;
	Tue, 19 Mar 2024 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816556;
	bh=s2n+yJXgW6xoysB19AK2uDSaXLsoRLgw3iAol4Um9/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EroTr9JS0RHreBnc4ZyAMI97T3FZ7/brvJFZPamFUMBMj+jsHQzCxaYq/jmazOL8j
	 kkiqo0GSizaCSaCYx0Po3J+0TnyrKvwgEuVrMs0iwXwQUbnPqyjaQ7DgTLVjyaVJjo
	 VXIa7nsdDP4tu63Y3PPxwvDc2XEdDfcYoneGfDDZGcm/fIK4mqfTMt/NUTkmb6A0zU
	 n21Re1l9n3Yfk/fMTj/geZMWfAwePOFv2YCqDG8T+A8oR5cidjTXInOEQYZIMlngDc
	 mDMfVUYeBpjxKWS/8xeG7xNFlN6AEAcsocAhNHwMzX7DAJ9J+hoUw+bi/5p9KN6o9E
	 SkPzHDti6DnkQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quic_ppratap@quicinc.com,
	quic_jackp@quicinc.com
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Add missing hs_phy_irq in USB nodes
Date: Mon, 18 Mar 2024 21:48:46 -0500
Message-ID: <171081652650.198276.471951657360642409.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219075720.640529-1-quic_kriskura@quicinc.com>
References: <20240219075720.640529-1-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 Feb 2024 13:27:20 +0530, Krishna Kurapati wrote:
> Recent binding update [1] indicates that there are hs_phy_irq
> present in primary and secondary usb controllers of sc8280xp.
> 
> Add the missing hs_phy_irq for these controllers. Since the driver
> doesn't use this interrupt, this change has been only compile
> tested.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Add missing hs_phy_irq in USB nodes
      commit: 343dfe6206b2793f7f5196b849dfbb4efcc5c048

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

