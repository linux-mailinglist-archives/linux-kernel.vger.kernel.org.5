Return-Path: <linux-kernel+bounces-22449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D6829DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE914B26EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03C44C3D7;
	Wed, 10 Jan 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn3RcY5/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117274D597;
	Wed, 10 Jan 2024 15:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DDC433F1;
	Wed, 10 Jan 2024 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704901465;
	bh=UGLylYGp4OT/HO+0IwkDTTy262kYznvfcm8xA4pCvH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mn3RcY5/10Ai0jFubxRI66229hWCMvG1Sx9wDSXlxvYR8fGidL6QyIs7j0HBoNQKD
	 uqi/iReaGBUMEUIdasQmRT3G5WE3nstCXi6w0d0eYtgewSqycVHvcYfQEKgitds+fY
	 apu5cTuJ4YJARV3ujWCNZ1vlyQu0raxvsLPYA+rbfncoraMnIbeAypnRCWGXvzvoEw
	 i8rat7ttfYTchAbLPgKqJff6219AsPHQK7WilY53fTvmO1QvQ4/I5y2ZNaR5kcjxgn
	 47lOV4B0Aw20Yhw2B+4yo9V5BC3a/CmDix8+oFZoECpPvy0WcYY5D3xhr0PP4Bn2ez
	 8kTljaKT6kGIA==
Date: Wed, 10 Jan 2024 15:44:14 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, corbet@lwn.net, catalin.marinas@arm.com,
	will@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
	shannon.nelson@amd.com, anthony.l.nguyen@intel.com,
	jasowang@redhat.com, brett.creeley@amd.com, rrameshbabu@nvidia.com,
	joshua.a.hay@intel.com, arnd@arndb.de, geert+renesas@glider.be,
	neil.armstrong@linaro.org, dmitry.baryshkov@linaro.org,
	nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
	jacob.e.keller@intel.com, andrew@lunn.ch, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ryazanov.s.a@gmail.com,
	ansuelsmth@gmail.com, quic_kkumarcs@quicinc.com,
	quic_suruchia@quicinc.com, quic_soni@quicinc.com,
	quic_pavir@quicinc.com, quic_souravp@quicinc.com,
	quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
Message-ID: <20240110154414.GH9296@kernel.org>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
 <a72405c2-c891-4db5-9ac5-42ca1c36cafb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a72405c2-c891-4db5-9ac5-42ca1c36cafb@linaro.org>

On Wed, Jan 10, 2024 at 01:24:06PM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2024 12:40, Luo Jie wrote:
> > The PPE(packet process engine) hardware block is available in Qualcomm
> > IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.
> > The PPE includes integrated ethernet MAC and PCS(uniphy), which is used
> > to connect with external PHY devices by PCS. The PPE also includes
> > various packet processing offload capabilities such as routing and
> > briding offload, L2 switch capability, VLAN and tunnel processing
> > offload.
> > 
> > This patch series enables support for the PPE driver which intializes
> > and configures the PPE, and provides various services for higher level
> > network drivers in the system such as EDMA (Ethernet DMA) driver or a
> > DSA switch driver for PPE L2 Switch, for Qualcomm IPQ SoCs.
> 
> net-next is closed.

Also, please try to avoid sending patch-sets with more than 15 patches
for net or net-next.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#dividing-work-into-patches

