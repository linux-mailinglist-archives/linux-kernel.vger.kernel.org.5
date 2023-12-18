Return-Path: <linux-kernel+bounces-3103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29C816778
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F3DB20FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6740D514;
	Mon, 18 Dec 2023 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF3/QkBK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E003C79F1;
	Mon, 18 Dec 2023 07:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA5AC433C8;
	Mon, 18 Dec 2023 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702884962;
	bh=zeimWpHhWWA8eyB7rpxlO3zzz/jvLSGyYM8Lzhg1ZP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UF3/QkBKACNQk2M2xKlmyayHAyNTEvGzpDPgj9nlDctMHZJ+NAOLvr/h16Cied7vs
	 BCEzwwgN2lRgo+sgXHDHQz7iQJgFO42xRO9eHbJCA2TNMXgDWyUqJwHfsE3PKwbDMY
	 hE9jtptgCmcB+bDLLvn9g1XDg10CSx8sI0VBo+3jshwsEfj8hQaN+USoF9c9h6vQnY
	 9lOQO2ASRU6Tq829+IiiUk3AE3HmOFaIgdy5HZY0R/UJyX0bUz3pjVKuJ71nLMUyYJ
	 Y3AtNjWMNuYVz5H7ZIBi5NZn9BOQT77MAGKWZ21MUIX9PbyGFCmtsFU+aFyLeH81qg
	 Iep6+36AkFuNg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rF8AT-000565-1r;
	Mon, 18 Dec 2023 08:36:01 +0100
Date: Mon, 18 Dec 2023 08:36:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY
 interrupts
Message-ID: <ZX_2YTxSKg4sE2js@hovoldconsulting.com>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
 <20231214074319.11023-2-johan+linaro@kernel.org>
 <ZXuv8zgm4kl3fwZV@radian>
 <ZXwBj-EAZ1rE8erk@hovoldconsulting.com>
 <ZXzph8s_WF09VdtZ@radian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXzph8s_WF09VdtZ@radian>

On Fri, Dec 15, 2023 at 07:04:23PM -0500, Richard Acayan wrote:
> On Fri, Dec 15, 2023 at 08:34:39AM +0100, Johan Hovold wrote:
> > On Thu, Dec 14, 2023 at 08:46:27PM -0500, Richard Acayan wrote:

> > > Tested-by: Richard Acayan <mailingradian@gmail.com>
> > > 
> > > On a Pixel 3a, plugging in a USB cable doesn't wake up the device
> > > (presumably because there is no wakeup-source property) but this gets
> > > USB working again on linux-next.
> >
> > Thanks for testing. And yes, the wakeup interrupts will indeed not be
> > enabled at system suspend unless the wakeup-source property is there.
> > Did you try adding it?
> 
> Just tested today. Adding it does not cause the system to wake up when
> plugging in a laptop on the Pixel 3a, but that might just be because
> USB wakeups are disabled when the adapter is configured for peripheral
> mode.

Right, wake up is currently only implemented for host mode.

Johan

