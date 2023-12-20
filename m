Return-Path: <linux-kernel+bounces-6892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61C819F03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04BF1F27274
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0376B224CA;
	Wed, 20 Dec 2023 12:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHcHwK+I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E602230B;
	Wed, 20 Dec 2023 12:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15834C433C8;
	Wed, 20 Dec 2023 12:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703075323;
	bh=TtG08+j99UlMDZ8py7v5K4WE7w/J6irsa32HPbV+mDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pHcHwK+IkPWNqwk0JCdolYEkFluoGmH+orJz3NQHp/iN2JpGBkc4Ve0hwPUlhbTk3
	 P+k4oA0aSsz+tYOhC5xJ6YfFIxOVyACa0EZpamTVimYw7p6ywoWPubGZt/5Y62ujgs
	 EkIA2sCgUOI8aUHy6ZGVJtWGadgbsXcWSj8qzDDZSCX2CDizMbMCPOZtbM7IUu4jBO
	 EmyYzpEblw7XtbHq6JXz9O6xuouaFuQmAIIUHsxnBCvgZP3FouFa+9jneBuObwOj16
	 mROumDXLeMu2F3c96liv7pTV0jaYJkO81g/AO0cJeAf23MZ5K2/Tl3HTvcJG225FU6
	 9q8YVaaqxzKeg==
Date: Wed, 20 Dec 2023 06:28:41 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, Tengfei Fan <quic_tengfan@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: (subset) [PATCH v3 0/1] arm64: dts: qcom: sm8550: remove
Message-ID: <x37zfdxjz2eyamg25xaxa5lewr7ypppu2hobwhyg4udlugc2ns@aqgo54ljbyya>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <170301441259.365364.2180258670074890979.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170301441259.365364.2180258670074890979.b4-ty@kernel.org>

On Tue, Dec 19, 2023 at 01:33:37PM -0600, Bjorn Andersson wrote:
> 
> On Tue, 19 Dec 2023 08:31:05 +0800, Tengfei Fan wrote:
> > The address/size-cells in mdss_dsi1 node have not ranges and child also
> > have not reg, then this leads to dtc W=1 warnings:
> > 
> >   sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
> >     unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> > 
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1
>       commit: 53081095936cdb1501d6bcf6cb703fdd3ac71b85
> 

Sorry, I thought this was removed from my queue again. I've dropped the
patch again. Please address Krzysztof's concerns.

Regards,
Bjorn

> Best regards,
> -- 
> Bjorn Andersson <andersson@kernel.org>
> 

