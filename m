Return-Path: <linux-kernel+bounces-92562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D187222E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DF51C20E4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036A61272BF;
	Tue,  5 Mar 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7WwB6yu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A91272AC;
	Tue,  5 Mar 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650712; cv=none; b=J08hEM/f3pTwdYT9QRtw/k+eAuwyDHQXCwm+pA5fE2AMeXFzHVFJ7gctGWneX6rI1xq6v+rvuW05/uUrl1phRmDCPPFD2ammcvCUrw8c+CXArElM+z5cFCPEn5es+Uu1oTHRMJzq6ELa41AnV30ozN26jjz0oUwmnyk6HxHLSS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650712; c=relaxed/simple;
	bh=h/P3goLMUxLj5fuwUwNyF1B5oRaia4FNBO96222ZKJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=netJmhuBpIGEaJy0E3cbDnIychtkaicMN6lsn2SY6k/0VtnCeG7Mq+CyI4AbxUmgs+QT9q1gczF6IYuX23C4MIXIg0uEHePc2uBGNBJTXhtiB6/BrGk0pFT+LRAsKEDJyprhY0vVMgqg/v6O5kCRLzagb9t+cpMaAc+J0yFf4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7WwB6yu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914DAC433C7;
	Tue,  5 Mar 2024 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709650711;
	bh=h/P3goLMUxLj5fuwUwNyF1B5oRaia4FNBO96222ZKJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7WwB6yujek5CUa0aO0at5Vo1A/YG6JiylctOK5N3NkPR5U2Dchi5EGBqkcl13tdq
	 dCGFsOTsFG9UH1XRr4eBWtmN1BVkZfGGil8PX9NSM2zcQ7MeHGLbcGRPpfRhTvMIbV
	 qqnk/9aGzKnym9o8Bm8lJNVVs8xckLGH6Zr+JN9wOPFmmBt3CqiBRcfPHhXKUlbD8J
	 uuTzg8MwXuAFjYD1bMFLVvkOj044pXVyuECvc98hOgN5iPSfIVem508KiDQY8bLDVw
	 OZGTLm/2h5uPsT7dZ4jQk/zhoRvQ+bTAomZvbcvQAytjfGI7LggqOIrIWkVJnBxJjl
	 BTrBybamIsRZw==
Date: Tue, 5 Mar 2024 08:58:29 -0600
From: Rob Herring <robh@kernel.org>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
	Kishon Vijay Abraham I <kishon@ti.com>,
	David Yang <mmyangfl@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: phy: hisilicon,inno-usb2-phy: add
 support for Hi3798MV100 INNO PHY
Message-ID: <170965070901.3343660.17802969888046943603.robh@kernel.org>
References: <20240305-inno-phy-v4-0-a03204c9cf1c@outlook.com>
 <20240305-inno-phy-v4-3-a03204c9cf1c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305-inno-phy-v4-3-a03204c9cf1c@outlook.com>


On Tue, 05 Mar 2024 10:19:48 +0800, Yang Xiwen wrote:
> Hi3798MV100 also has a similar INNO USB2 PHY with slightly different
> register fields offsets. Document it in the binding.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


