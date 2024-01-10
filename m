Return-Path: <linux-kernel+bounces-22437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10965829DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B251F27832
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AEE4CB2D;
	Wed, 10 Jan 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in3sKJOw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0413FEC;
	Wed, 10 Jan 2024 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A30C433C7;
	Wed, 10 Jan 2024 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704901213;
	bh=aOTgTnA8nEO8OVvqATRlcEqMBOCoeOSc2xVIPjbo8SQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=in3sKJOwfgN7F0JSNIXK8D9g4a6GmKrI9jocfChwTfMwgGmUKnnnmWdsqHVukn3cu
	 CoMrOrc9irVLHHOeYfet2aPT7hRGGvHw3DFURO7Xb0T6yfyEJIZUk6b8+rzSR0GOij
	 7sLECEmhcp10a86mFl89Y5IUtjMY2/sMaq+VP33WyhaDzUtG+ayk4Wn4Or7hh9qbb8
	 OfRdzLiFs7hmTUz7hHVW5XtgVsujaEFJVs9XmaQE3twz6ICICAshoVE5vGabiO98KY
	 xnwWaQevXX38VQkn7IHW5Wb4MC7B91Njg32SxFwP03XuOVzH+VmL3QHDx1UaB/Y8kW
	 alUKmcAYdd3gQ==
Date: Wed, 10 Jan 2024 15:40:06 +0000
From: Simon Horman <horms@kernel.org>
To: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
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
	kernel@quicinc.com
Subject: Re: [PATCH net-next v8 0/3] Ethernet DWMAC5 fault IRQ support
Message-ID: <20240110154006.GG9296@kernel.org>
References: <20240110111649.2256450-1-quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110111649.2256450-1-quic_jsuraj@quicinc.com>

On Wed, Jan 10, 2024 at 04:46:46PM +0530, Suraj Jaiswal wrote:
> From: Suraj Jaiswal <jsuraj@qti.qualcomm.com>
> 
> Add support to listen Ethernet HW common safery IRQ for correctable and 
> uncorrectable fault. The safety IRQ will be triggered for ECC(error
> correction code), DPP(data path parity, FSM(finite state machine) error.

Hi Suraj,

[original text from Jakub]

## Form letter - net-next-closed

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 21st January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer

