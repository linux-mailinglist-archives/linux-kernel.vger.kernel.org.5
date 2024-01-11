Return-Path: <linux-kernel+bounces-23869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3593C82B2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADDA2885FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532D50279;
	Thu, 11 Jan 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xyiwDMkt"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B6450248;
	Thu, 11 Jan 2024 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RZZYfRnPOO3FwcjRLM0jK60UeYXHjeCKu2AE3qKo9Vk=; b=xyiwDMkt2KpmBS8xYraVAQvlHx
	ksUXbOKxjUC59W+Z9bFz+QIdkOebEt+meVCMITncKXRGJIwO5iUqPcZkDgta2x7LWy0KFng0VPcd/
	v4dgoZKkC5Bo919UCr6PatZgwj1ydrRC71urHkxqsxTX+s15PWZXh6EkMC1g4vUgWRyE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNxwk-0050tN-J8; Thu, 11 Jan 2024 17:30:22 +0100
Date: Thu, 11 Jan 2024 17:30:22 +0100
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
Message-ID: <61973012-3f74-4b58-9575-3bc5199f61d9@lunn.ch>
References: <20240110112059.2498-1-quic_luoj@quicinc.com>
 <20240110112059.2498-4-quic_luoj@quicinc.com>
 <4bc0aff5-8a1c-44a6-89d8-460961a61310@lunn.ch>
 <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e893c298-fbfa-4ae4-9b76-72a5030a5530@quicinc.com>

> Sorry for the confusion, the pin nodes are for the MDIO and MDC, these
> PINs are used by the dedicated hardware MDIO block in the SoC. I will update
> the node name from mux_0 to MDC, mux_1 to MDIO, to make it clear. The driver
> for this node is drivers/net/mdio/mdio-ipq4019.c, it is not related to the
> mdio-mux-* code.

So these is all about pinmux.

When you say:
> PINs are used by the dedicated hardware MDIO block in the SoC

do you actually mean:

PINs are used by the two dedicated hardware MDIO blocks in the SoC.

You have two sets of mdio/mdc configurations here, so i assume there
are two MDIO hardware blocks, each being an MDIO bus master.

    Andrew

