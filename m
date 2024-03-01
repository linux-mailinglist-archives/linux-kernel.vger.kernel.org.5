Return-Path: <linux-kernel+bounces-89136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74F86EB08
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E2A1C22FAB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E2657881;
	Fri,  1 Mar 2024 21:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCPijtkV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231B5732A;
	Fri,  1 Mar 2024 21:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709327889; cv=none; b=V+QEx/xrekCyVZDxNiifb2EALu4G3fN9zKuclMR1vmgWnC781rCZ+L/fr6DO23elNaK8lYGqXaqDWg1uPTl02CuYyv6cfiwbleYGfuZPKQpVA3qomMUUtuCfwjusKe3FAGgJmvGqEnOkmzM3Lx0oGc2HMOyvoCWHSKb25vWIsbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709327889; c=relaxed/simple;
	bh=zxytVGMfrFUkY7rHqDZSUhzm0IK8y99ueBD485sWH9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9hQRh13A4bgPMORj+PVbQu9/F+/NAiU8cn2BQg2eJAg6ibwplTPJup/ai2S12G3e1y0xDLZRdUPIrh5tO4F32MSg37U/kGPBrrX7YHtQlIBArJIo3M+DtUB4hp/wjdqBskeuVyGDYuXiZNqfluZaZuo171QI2QU7KSGPFHjdoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCPijtkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FD0C433C7;
	Fri,  1 Mar 2024 21:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709327889;
	bh=zxytVGMfrFUkY7rHqDZSUhzm0IK8y99ueBD485sWH9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCPijtkVbQ0865AGd1T4TriEvEbD8D5U1299GvPKjhYoyWpCmvkd2F8wd8BU8DwxY
	 mHnIOva7/Aa7MxuBsF045XWM7rQluulU7BAauACMDJkokKG6FnxoElDCv6kw3u+1Bn
	 tAnGmadabtuDvT/t3CtHXGcUcMTqX/QZ8ArE11JI9ZNlrTCXgCg1F1rdCOmnc5hVbx
	 /IFAqQi3Nfh3YpOdyPyCruc4P1w2CiM4rmNtR3p6JMDrIISUPxoVEwhdzuoAOWrEH9
	 sXwnPwaAIPHl/oSzZCoHm0s3/+L9jsO+uUEiOSQBspk/6SNVeCHgdM1qUZlSY6Hi08
	 PoP5t6LXKXVyw==
Date: Fri, 1 Mar 2024 15:18:06 -0600
From: Rob Herring <robh@kernel.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: quic_bgodavar@quicinc.com, marcel@holtmann.org, quic_rjliao@quicinc.com,
	linux-bluetooth@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	luiz.dentz@gmail.com, edumazet@google.com, netdev@vger.kernel.org,
	davem@davemloft.net, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, quic_bjorande@quicinc.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND] dt-bindings: net: bluetooth: qualcomm: Fix
 bouncing @codeaurora
Message-ID: <170932788622.3054344.2673462722673584802.robh@kernel.org>
References: <20240223162027.4016065-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223162027.4016065-1-quic_jhugo@quicinc.com>


On Fri, 23 Feb 2024 09:20:27 -0700, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there will bounce.  Update the maintainer addresses for this
> binding to match the entries in .mailmap so that anyone looking in the
> file for a contact will see a correct address.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
> 
> Rob, will you take this patch into your tree for 6.9?
> 
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


