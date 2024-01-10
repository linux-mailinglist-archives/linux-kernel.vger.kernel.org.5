Return-Path: <linux-kernel+bounces-22247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D15829B68
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC4C1C221B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567F64C60F;
	Wed, 10 Jan 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRuYHojv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964734C3D7;
	Wed, 10 Jan 2024 13:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86F2C43390;
	Wed, 10 Jan 2024 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704893599;
	bh=80gsdR23OIMDUmaGo86P6z0jlYyc+cs3tLIj2ceqAEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rRuYHojvCugPDSpoU3P//lFkFdXY7opAArZFaL3Zr9788k4aYSZsFPf2j58BZ6NVB
	 8kfOX5BlyQhSGyb0Ex3PCsjO7JNNPISfURp+Q/m90qMQLtREQsOJ4zFs9NU9vN9RXm
	 Ps5dHXUm6XVlmQPKIfHqKlV1UCO2BN1sJQ7za+TZ0CD44Gyl+naHv5UNjowsr+m24Q
	 t3ElTGyl2alBm0DQrO9a6o5YuUIonf+a7ZUCikcqj8tp1tf7bJZDDY4QixVJ8JLUsh
	 2MHHbAiZC5kU4HiGyvKKxjVeRk99e/rooBTJ07I9SHRLvyjjYP03++6fIyDJuZPsDz
	 trHs22lyGlWDw==
Date: Wed, 10 Jan 2024 13:33:13 +0000
From: Simon Horman <horms@kernel.org>
To: Sneh Shah <quic_snehshah@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@quicinc.com, Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH net v3] net: stmmac: Fix ethool link settings ops for
 integrated PCS
Message-ID: <20240110133313.GA9296@kernel.org>
References: <20240109144729.26102-1-quic_snehshah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109144729.26102-1-quic_snehshah@quicinc.com>

On Tue, Jan 09, 2024 at 08:17:29PM +0530, Sneh Shah wrote:
> Currently get/set_link_ksettings ethtool ops are dependent on PCS.
> When PCS is integrated, it will not have separate link config.
> Bypass configuring and checking PCS for integrated PCS.
> 
> Fixes: aa571b6275fb ("net: stmmac: add new switch to struct plat_stmmacenet_data")
> Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>

Reviewed-by: Simon Horman <horms@kernel.org>


