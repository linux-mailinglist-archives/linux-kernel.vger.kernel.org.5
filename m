Return-Path: <linux-kernel+bounces-13099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C081FFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D2B1F218F6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AB211714;
	Fri, 29 Dec 2023 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwkG7X7N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0811C84;
	Fri, 29 Dec 2023 13:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B04C433C7;
	Fri, 29 Dec 2023 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703856348;
	bh=Qjdq/NiV7NMUTpVZdpiyOV0E08a+f4/G4AzkNI+HNQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XwkG7X7NWOjzQloEY+Hjh4c45ux4z/YP8Jg6OlOLSrx7tZmUlFKpu0Zi2/YFmLYyP
	 poQzjlQhQ7peboc5IRDUf2EhKIuWfLWVk+mOG1WBt/FxoGVpDuaG3qGsQ5/sBjO2QI
	 XHBbz+fVH1jRT1bT4cY8xqtxpaZxI72AiC13ttVKyX32PG9XYxMV4IaT9fM/24n9WS
	 lRE4H33qAluaYRPQzMmYMuWUAGS2ZHE9IKI1A7A/J1iYnPDFYZGqUq8J+xfmREdaPl
	 YmRqWdfqHsKxqnERH0pjpA4v7EoJON3PXXygfFksqiYQBis8SQA3HvRUrjGG4/bwfM
	 iNDt9QBsChqDw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rJCrt-0000B0-2I;
	Fri, 29 Dec 2023 14:25:41 +0100
Date: Fri, 29 Dec 2023 14:25:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc8280xp: Correct USB PHY power
 domains
Message-ID: <ZY7I1brn0chtOzis@hovoldconsulting.com>
References: <20231227-topic-8280_pcie_dts-v1-0-13d12b1698ff@linaro.org>
 <20231227-topic-8280_pcie_dts-v1-2-13d12b1698ff@linaro.org>
 <ZY7DEpaIgvfL_A11@hovoldconsulting.com>
 <b730bf22-fa3a-4720-9fd1-79d2207d6812@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b730bf22-fa3a-4720-9fd1-79d2207d6812@linaro.org>

[ Please remember to trim your replies and add a newline before your
  inline comments to make them readable. ]

On Fri, Dec 29, 2023 at 02:06:26PM +0100, Konrad Dybcio wrote:
> On 29.12.2023 14:01, Johan Hovold wrote:
> > On Wed, Dec 27, 2023 at 11:28:27PM +0100, Konrad Dybcio wrote:

> >> Fix the power-domains assignment to stop potentially toggling the GDSC
> >> unnecessarily.
> > 
> > Again, there's no additional toggling being done here, but yes, this may
> > keep the domains enabled during suspend depending on how the driver is
> > implemented.

> No, it can actually happen. (Some) QMP PHYs are referenced by the
> DP hardware. If USB is disabled (or suspended), the DP being active
> will hold these GDSCs enabled.

That's not a "toggling", is it? Also if the DP controller is a consumer of
these PHY's why should it not prevent the PHYs from suspending?

Johan

