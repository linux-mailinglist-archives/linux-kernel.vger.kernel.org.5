Return-Path: <linux-kernel+bounces-99318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6430878681
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA1D1F22470
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F57152F61;
	Mon, 11 Mar 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daCI+he2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DEE4D9E7;
	Mon, 11 Mar 2024 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179007; cv=none; b=ovZHW4AAAmBCVinJG6q9TR8zM1QWt6xDU2gOgYFHAc2r9HS6tkrDRfTVUR0I5vusuBvTTsfEiEC40KJz3L4GIIgW3RcQ1IpSK4Ef/QNN4TZedDwnViAI8fhs3ga8vArcZopPGs2iWZPfLepFplWXUSv6vPVZStKOc34F4BJkRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179007; c=relaxed/simple;
	bh=buzO+sFEpQ/5zCrBZhxY5AnpQSXE49oy4edP8NiDR8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYF1bzaIjK72TLPHB7frD0cr26LlbLdO0siorT7AupK87IQ3XBuSOwbNrwiupBEVzC8rjFxzhNhgsMfC+24QCNh8KHJO2nY2ppRcCBvLW2b8ZCwJDQTwxPohmu1swKbih2V2ikzyeOjJq4BaONyAZ0FCbEkjx8N30iOlR2edSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daCI+he2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666E7C433F1;
	Mon, 11 Mar 2024 17:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710179007;
	bh=buzO+sFEpQ/5zCrBZhxY5AnpQSXE49oy4edP8NiDR8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daCI+he29AgFiKQspdIJ0+mjpXSeGL7E3xZn2hPLdKbhmzHXUBFE4u3+m1TmlTji0
	 DKQru63fHNsDqFlqSkzxnU5OwwATX43GdJ6S4nay7fnHoakIr59fKB3yFh8nvcuvWt
	 rESiTLw0kmJBdLvR1/AhntKlAaPztaUGhvtlsvWWoEo7OkLp/mRCn1Xd4VIntnIVrH
	 FnfnmiFlxLS4aWjciaidA0kpUH14AXfUzZEjRZ3YeivXFzpnNQaUhA+ZJShqftAyr8
	 Ryk7wN5fQz0EIGnZpjhiXqNBlMAdZMCtD3LHduMs9A2A/YNIpmfWvzEC4qAeNn1x1Y
	 a9UD6Wu+ngJNw==
Date: Mon, 11 Mar 2024 11:43:25 -0600
From: Rob Herring <robh@kernel.org>
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-usb@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	linux-phy@lists.infradead.org,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: phy: qcom,qmp-usb: Add QDU1000 USB3 PHY
Message-ID: <171017900463.1476132.2926850011741467415.robh@kernel.org>
References: <20240311120215.16845-1-quic_kbajaj@quicinc.com>
 <20240311120215.16845-3-quic_kbajaj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311120215.16845-3-quic_kbajaj@quicinc.com>


On Mon, 11 Mar 2024 17:32:13 +0530, Komal Bajaj wrote:
> Add dt-bindings for USB3 PHY found on Qualcomm QDU/QRU1000 SoC.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


