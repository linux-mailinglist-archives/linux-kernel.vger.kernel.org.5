Return-Path: <linux-kernel+bounces-40084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522083D9F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 255951F21712
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FD18E3A;
	Fri, 26 Jan 2024 12:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rh8bK4v3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D278D272;
	Fri, 26 Jan 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270931; cv=none; b=mKCiIp/khGKsm3dL1eKgWIiZ1k6JzraqMNzxmVkO1xWKdgHla1wiqW1t4P0XXuBAl1k5DIPWUmdWqRTlZjnGVtlfUUKTgMcURM/bKr9CEgELLynG9XZ+v7rpZs7fzJ918pvRFSvEXXxlSqqTA7JgUz+R5xalvVuVe3SHS69m8UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270931; c=relaxed/simple;
	bh=2/q4XHUCYwKPjUKj8RkPcqshZkXMhs2N63BzsBsf2YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKYTVA2MFX7hAnQ9wCK/eYvaGlOdpjaiHS+GPkfiZl5Whv5tLncqiyD2+Rr8MZ4iLosSErNvRXBBArsoYCGVTUitv4HVswY3b7Cjar0nF+50BXflJlUQHNG1Ix6rUOG13uPgSYTGK3D8ZxRAACgpHAhSwexSKLK07rBgfKaOo7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rh8bK4v3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40AFC433F1;
	Fri, 26 Jan 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706270930;
	bh=2/q4XHUCYwKPjUKj8RkPcqshZkXMhs2N63BzsBsf2YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rh8bK4v3ntLyatWLubhi3KLb4tKTcf1qL27b+Bi2UOd0o7rB+ijOlLWxGYvwyCZGD
	 yFPBbm59w584Fwnpwu2j9Bw332dqZYjeLOsfcfwYzzhKp+IHr+VBZYjpeuI/GproSn
	 7SSB0PpD/YFu8FQlEXD9ABUOyLm1Sbq6P2hBfyDcu8rPqASCAlpWFQdQJmSW+SWvTZ
	 GO2Sz2FhsBCcQNdx0ndW6dm1wd7neuNcXqFzm4hOU6SKP/8JUOz/T5Rfk17hI+qDY2
	 03W/VHV9XPb6h/cJ40m4gamj5a+tgOytPk4uNoatWiZl50IFoDF1wX2986mZpgfmES
	 VykaIyxn7vI6w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rTL14-0000000049Y-2efZ;
	Fri, 26 Jan 2024 13:09:02 +0100
Date: Fri, 26 Jan 2024 13:09:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Introduce additional tsens
 instances
Message-ID: <ZbOg3nq4q_B_Pr_t@hovoldconsulting.com>
References: <20240118-sc8280xp-tsens2_3-v1-1-e86bce14f6bf@quicinc.com>
 <ce77861a-b362-4ecc-8e92-7fb846c7e508@linaro.org>
 <ZbOCrET0YPujMpom@hovoldconsulting.com>
 <e1322a9e-86b5-4444-a40f-85e46d8b542f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1322a9e-86b5-4444-a40f-85e46d8b542f@linaro.org>

On Fri, Jan 26, 2024 at 11:48:03AM +0100, Konrad Dybcio wrote:
> On 1/26/24 11:00, Johan Hovold wrote:
> > On Fri, Jan 19, 2024 at 12:31:06AM +0100, Konrad Dybcio wrote:
> >> On 1/19/24 00:00, Bjorn Andersson wrote:
> > 
> >>> +		gpu-thermal {
> >>> +			polling-delay-passive = <250>;
> >>> +			polling-delay = <1000>;
> >>
> >> Hm, did tsens only gain support of non-polled reporting with 8450?
> >>
> >> If not, we should definitely update all the relevant SoCs.
> > 
> > Did you determine whether the interrupts work as expected?
> 
> Yes, they seem to!

Excellent.

> > We don't want to be polling here unless we have to (i.e. polling-delay
> > should be 0 as per the binding).
> 
> Even better:
> 
> https://lore.kernel.org/lkml/20240125-topic-thermal-v1-0-3c9d4dced138@linaro.org/

I'm not sure that's better, but either way we want to set
'polling-delay' to zero here as we don't want to have to wait for that
binding and driver update to hit mainline in 6.9-rc1 before merging this
patch.
 
> Believe me, I'm not omitting you from Cc on purpose.. I usually
> realize I forgot right after pressing enter on "do you really
> wanna send"..

Heh. No worries.

Johan

