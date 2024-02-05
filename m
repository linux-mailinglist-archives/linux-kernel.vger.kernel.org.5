Return-Path: <linux-kernel+bounces-53237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAEB84A273
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961DAB25036
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320F64C3DE;
	Mon,  5 Feb 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoBI3GEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661B24C3C6;
	Mon,  5 Feb 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158022; cv=none; b=KZC03VTB7M5IhKSmOMyEqDRFYP4wcAmluULyA3KLDJbQzOuEnMnR0NCpk/RFRZZInZ0fdCBg73cyTK4SIZ10ff7YMp8p95HsuebV81BXxhyl1CHdRb2g1c/sOVaTwTg4j9494UEtHq/A6gdAHTHNzVn+vsGXaTJMQm/F29dDtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158022; c=relaxed/simple;
	bh=OMpuFYp2jnF+MtIul2XGUwcOea6+QDQ7KKMjIrGCNbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YG9G4bWDTqxi21KuMRIT1+mC4AwOU+ZdI+3p93FKQ1Q71YG/ZFHAs3wXbkcT9r9Ft8WNB9CNwhz6W9ZsrO8tEv6X1i5nR8lFeCQ29B+NCnAF5voCX/04LerxJPwyflF+lUSHlMrU8YB8yKi9lpkM5VvqP0JDwoU+tXT+DkBYkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoBI3GEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB90C433F1;
	Mon,  5 Feb 2024 18:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707158021;
	bh=OMpuFYp2jnF+MtIul2XGUwcOea6+QDQ7KKMjIrGCNbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoBI3GEPGCdugQDRKMbiYTzMfkh3t9fccCfY6tk7r7UtfdqFfAmne/A80hkIrZpSW
	 5sGjVSALvMngl/H6IL44p9ftSd969fGHeV7Oy8uUMzRwcbFY/I4vzwYk5dFKGq8BmW
	 AyiFKAyq+2CucJD76BRK0JJgYl2024CbOXrl7UzovvaMh+ax5hWb37zMbIFew4F9xH
	 suRquXmceZfXo9d2pTDGBCXYLow5orClBv6+1P1OY/aMjFzlJhkCqGsYCAuVbfoL89
	 jaCSjyu79HmirWOJ7wm/p8gQ8SwgrU3jvSG5JOYmrRvEcNxS0/CyPdeNiD3i/T/1Wb
	 Twf20KepIdgwA==
Date: Mon, 5 Feb 2024 18:33:38 +0000
From: Rob Herring <robh@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
	sboyd@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom: Fix @codeaurora email in
 Q6SSTOP
Message-ID: <20240205183338.GA3905881-robh@kernel.org>
References: <20240202171915.4101842-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202171915.4101842-1-quic_jhugo@quicinc.com>

On Fri, Feb 02, 2024 at 10:19:15AM -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> addressed there will bounce.  Govind Singh has left the company which
> appears to leave the Q6SSTOP clock controller binding unmaintained.
> 
> Move maintenance of the binding to the Qualcomm Clock Drivers maintainer
> as suggested by Bjorn Andersson.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

How about the rest of the tree?:

Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml:  - Sandeep Panda <spanda@codeaurora.org
>
Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml:  - Harigovindan P <harigovi@codeauro
ra.org>
Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml:  - Odelu Kukatla <okukatla@codeaurora.org>
Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml:  - Kiran Gunda <kgunda@codeaurora.org>
Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:  - Balakrishna Godavarthi <bgodava
r@codeaurora.org>
Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:  - Rocky Liao <rjliao@codeaurora.o
rg>
Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml:  - Shyam Kumar Thella <sthella@codeaurora.org>
Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml:  - Srinivasa Rao Mandadapu <srivasam@
codeaurora.org>
Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml:  - Sai Prakash Ranjan <saiprakash.ranjan@codeauro
ra.org>

