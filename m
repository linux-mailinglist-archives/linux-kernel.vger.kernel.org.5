Return-Path: <linux-kernel+bounces-109210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2DB881636
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA431F24522
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB06A037;
	Wed, 20 Mar 2024 17:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCBkpNz1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE63669E07;
	Wed, 20 Mar 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954717; cv=none; b=QIYtEwgAnRZKVqbYSAgUgHPkGrF071DD5oCVA05aD2eE1BeoXI5VZ/TNyymDuT3PV4IsEhbHVlmzi2rx898Qhzs96p+NOOeYc/0u7YnXJ/HK4y6bbPJTOo70oXPIp7fmmG8Mcr3OQ3GAYHhRnIDbxxNxrlZyOZzqHxEDYesRR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954717; c=relaxed/simple;
	bh=0aZFZCOeLAcN+NftH2PeOcpao57s+EO2JXeOavSTOno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XG10rEX5910uP6wrzay3D3CRt+sT5vLhXb/qKWK3kJulvNThBBamTnoUMpKW3EiQbI+S8T+4ae2aFQAt47adzX7KCT0gqMYY75+SoEbdGPsqS6VHMWjJ816WYU6yVOAncxh8d7ozT7IBnMC1ewJgsfulbBGQPnj3+/VKzJ/nMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCBkpNz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96409C433C7;
	Wed, 20 Mar 2024 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954716;
	bh=0aZFZCOeLAcN+NftH2PeOcpao57s+EO2JXeOavSTOno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCBkpNz1izIAQnF1MzhDvD0qkClOk9NfXEqsqtET5IxF5C2whK9ftPgRvICiZinaN
	 KdMEm7da5sCTMHPD2GKHXwsCzDbGqSCm6IbgVS8rNw0PlyOaaaqxehxG+LODHOmHkJ
	 UkiU0ECukWIcB60nUBNuRwipbi7ahHw349iRfmphgN4m/snQ+FHKdu9spSCWqlJsp1
	 /hoL7KKkazGYfjERiL2TEIeUhLBRpnwOxb85c10YeFLjbfW4kPLwWVfoqvBXwZSXhi
	 7wuj0yDfHp4io8dZrLsgb8/RAxe2IYDApPuvKclwRIVvPLfDOgogPvFwunOD7H3Ns3
	 Ad4kY66LwRtfg==
Date: Wed, 20 Mar 2024 12:11:54 -0500
From: Rob Herring <robh@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	cros-qcom-dts-watchers@chromium.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: bluetooth: add
 'qcom,local-bd-address-broken'
Message-ID: <171095471407.2028655.14348528428018722281.robh@kernel.org>
References: <20240320075554.8178-1-johan+linaro@kernel.org>
 <20240320075554.8178-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320075554.8178-2-johan+linaro@kernel.org>


On Wed, 20 Mar 2024 08:55:51 +0100, Johan Hovold wrote:
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
> 
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
> 
> The only device out there that should be affected by this is the WCN3991
> used in some Chromebooks.
> 
> Add a 'qcom,local-bd-address-broken' property which can be set on these
> platforms to indicate that the boot firmware is using the wrong byte
> order.
> 
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


