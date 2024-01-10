Return-Path: <linux-kernel+bounces-22844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0A82A3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5546E28A83F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47DE4F8AB;
	Wed, 10 Jan 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b88GyTBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B750242;
	Wed, 10 Jan 2024 22:24:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EEEC433C7;
	Wed, 10 Jan 2024 22:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704925470;
	bh=AoQukHVcIbmk0qSi1i/n2ripa6DEo4EtqV+Fsg0EiLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b88GyTBR19+wvSfALyqT9ZOU+D8F7q/RzFN/2ZDwFNEmzFg1uFbOu78QHWfCR7Wf8
	 PQ4S8QOraaWZ30Ok6UM1Ip+dGYaFpN0YDaHr1kF24sc3jqPoS+p9W8Cu8xU95SpG8O
	 LcJpF836kf+paYwZBvE4hgtvjlF57TuXbpQa8GYL7DWo9BJeoAFDI/It7e817rL/1E
	 ZeCywLE55Ds+lFCQygYvV3xr7fvo2VlvRx03e9qF6RGxLUSYgPtDj3+wAY7HS52ikn
	 EYyeKITstDwkMW3mHObAi+F3XMhxOT73IXQqlxkpohel9EImhm2p2Xxz8+YD2ODubr
	 M8q9+z+kGORRA==
Date: Wed, 10 Jan 2024 14:24:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luo Jie <quic_luoj@quicinc.com>
Cc: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <catalin.marinas@arm.com>,
 <will@kernel.org>, <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
 <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
 <jasowang@redhat.com>, <brett.creeley@amd.com>, <rrameshbabu@nvidia.com>,
 <joshua.a.hay@intel.com>, <arnd@arndb.de>, <geert+renesas@glider.be>,
 <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
 <nfraprado@collabora.com>, <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
 <jacob.e.keller@intel.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <ryazanov.s.a@gmail.com>,
 <ansuelsmth@gmail.com>, <quic_kkumarcs@quicinc.com>,
 <quic_suruchia@quicinc.com>, <quic_soni@quicinc.com>,
 <quic_pavir@quicinc.com>, <quic_souravp@quicinc.com>,
 <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>
Subject: Re: [PATCH net-next 00/20] net: ethernet: Add qcom PPE driver
Message-ID: <20240110142428.52026d9e@kernel.org>
In-Reply-To: <20240110114033.32575-1-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 19:40:12 +0800 Luo Jie wrote:
> The PPE(packet process engine) hardware block is available in Qualcomm
> IPQ chipsets that support PPE architecture, such as IPQ9574 and IPQ5332.

What's the relationship between this driver and QCA8084?

In the last month I see separate changes from you for mdio-ipq4019.c,
phy/at803x.c and now this driver (none of which got merged, AFAICT.)
Are you actually the author of this code, or are you just trying 
to upstream bunch of vendor code?

Now you're dumping another 10kLoC on the list, and even though this is
hardly your first posting you're apparently not aware of our most basic
posting rules:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

The reviewers are getting frustrated. Please, help us help you.
Stop throwing code at the list and work out a plan with Andrew
and others on how to get something merged...
-- 
pv-bot: 15cnt
pw-bot: cr

