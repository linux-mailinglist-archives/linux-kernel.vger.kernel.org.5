Return-Path: <linux-kernel+bounces-105217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E0E87DAA6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A428E1C21220
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498A1BC37;
	Sat, 16 Mar 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxHeZiVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3151B299;
	Sat, 16 Mar 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710604889; cv=none; b=mzbIAJXVDN9WTx2ZBrWrsT4KRDOz/KzgU6HJqbyBtsV0RYwNc/ezEHiwH+oKeOMi41Bv2K2gFBL3oR+CYdt/QsrgibhEMS3MgWg30qgzG2FmfXYvD0FiGqBK9RhHeanzq/G2Z3r2Bs6d03vH78iUkONS9+ZJHPtCNmV/CQo/6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710604889; c=relaxed/simple;
	bh=E8gpcSQ4g+qjnbdy6/BOeXM1PQg+hZZkOsNPJV1YA+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AepKFr1nKXoopRKzVOlLYA6pHYsS9kYjxdfBpaXkxziLdepqvCMwkOiEDEfBOYin5vR1LsKOtIYps+rxDGoNBAoOJHhyqpfwSRNFq+TxLpBdzZU6yH+piDTtyNkAzkUEkao+c+McPRii5fvn5Q7+zRPsH77k4O6ygNOJvLOmqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxHeZiVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8A9C433C7;
	Sat, 16 Mar 2024 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710604888;
	bh=E8gpcSQ4g+qjnbdy6/BOeXM1PQg+hZZkOsNPJV1YA+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxHeZiVmueWwHy/Tvld9s1FsYsofbgvjQqJ2wBze7H2Ldfmdu8z7WJLEENRkvB5yl
	 +V+3+DpToZpyT4Udw0s11ZnxK5g8V64EfNBOR3yqSf93PzbuxpC0okzC9hLGbXXp9m
	 +GbxG2BGQaXUPbqQMcvOt7/yfxuqZ5KDIQWKTQLUpPknoYGH5nK7HHlbXWqmBHk5EN
	 +xNSK0vBWcRoaeVX7/s4/sN4NoZkg9qLcQeKmNBETBHt+UoLCulQ4SGT09pi2F6MGC
	 wWXuQUfkk8uIFBv32otHrlN4K+L6xTWfO1aYXwMzSzq793luTaZ6+j+20V/3yj8x5H
	 rQhSiewwWp4GQ==
Date: Sat, 16 Mar 2024 11:01:25 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Luca Weiss <luca.weiss@fairphone.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT 0/7] arm64: qcom: allow up to 4 lanes for the Type-C
 DisplayPort Altmode
Message-ID: <liah4xvkfattlen7s2zi3vt2bl5pbbxqgig3k5ljqpveoao656@iacnommxkjkt>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
 <CZUHV429NTF7.1GW9TN9NXB4J1@fairphone.com>
 <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a7aa05f-9ae6-4ca0-a423-224fc78fbd0c@linaro.org>

On Fri, Mar 15, 2024 at 06:35:15PM +0100, Neil Armstrong wrote:
> On 15/03/2024 18:19, Luca Weiss wrote:
> > On Thu Feb 29, 2024 at 2:07 PM CET, Neil Armstrong wrote:
> > > Register a typec mux in order to change the PHY mode on the Type-C
> > > mux events depending on the mode and the svid when in Altmode setup.
> > > 
> > > The DisplayPort phy should be left enabled if is still powered on
> > > by the DRM DisplayPort controller, so bail out until the DisplayPort
> > > PHY is not powered off.
> > > 
> > > The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
> > > will be set in between of USB-Only, Combo and DisplayPort Only so
> > > this will leave enough time to the DRM DisplayPort controller to
> > > turn of the DisplayPort PHY.
> > > 
> > > The patchset also includes bindings changes and DT changes.
> > > 
> > > This has been successfully tested on an SM8550 board, but the
> > > Thinkpad X13s deserved testing between non-PD USB, non-PD DisplayPort,
> > > PD USB Hubs and PD Altmode Dongles to make sure the switch works
> > > as expected.
> > > 
> > > The DisplayPort 4 lanes setup can be check with:
> > > $ cat /sys/kernel/debug/dri/ae01000.display-controller/DP-1/dp_debug
> > > 	name = msm_dp
> > > 	drm_dp_link
> > > 		rate = 540000
> > > 		num_lanes = 4
> > 
> > Hi Neil,
> > 
> > I tried this on QCM6490/SC7280 which should also support 4-lane DP but I
> > haven't had any success so far.
> > 
[..]
> > [ 1775.563969] [drm:dp_ctrl_link_train] *ERROR* max v_level reached
> > [ 1775.564031] [drm:dp_ctrl_link_train] *ERROR* link training #1 failed. ret=-11
> 
> Interesting #1 means the 4 lanes are not physically connected to the other side,
> perhaps QCM6490/SC7280 requires a specific way to enable the 4 lanes in the PHY,
> or some fixups in the init tables.
> 

I tested the same on rb3gen2 (qcs6490) a couple of weeks ago, with the
same outcome. Looking at the AUX reads, after switching to 4-lane the
link training is failing on all 4 lanes, in contrast to succeeding only
on the first 2 if you e.g. forget to mux the other two.

As such, my expectation is that there's something wrong in the QMP PHY
(or possibly redriver) for this platform.

Regards,
Bjorn

