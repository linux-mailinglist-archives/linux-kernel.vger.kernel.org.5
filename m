Return-Path: <linux-kernel+bounces-40618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C09B83E341
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B75287C63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB412421C;
	Fri, 26 Jan 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itgfnOi4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371F2376C;
	Fri, 26 Jan 2024 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706300370; cv=none; b=avFuiJr+9QuRZDA7G8WBuCHrYl0LFdInorIotXX/0hePGbx3pHvu+jAZ61OnD1rj+HSVpj3tciyoe+CC+w6FRALQlHuQZIPPG1kA/7IdLXtz6kRj4Q52l4MfUmyb0PSskG3yrTP7kec4l7Th7FFW8O+t/hUoWPu/ZK5duZFQE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706300370; c=relaxed/simple;
	bh=awpRcgfVITqJmr4m6h4D7QiLDSW/PQz0VRDDLkPva8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VagifDht05tJt4QfInTPx8qyGlcb3jF2KYJM0rcNIUlWmX0yQErRUOjb8oTk10bsP6oDk1ElXCRy/+/6H0k9sLjsP6hCU8HzVc0hyliYdGoW9f8FTTsX6vJ2Bdh9+fzvZX5eMOfvD1XpxbxDz/PwKPvnqRk3GnqhLxoj/WoXIbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itgfnOi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C85C433C7;
	Fri, 26 Jan 2024 20:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706300369;
	bh=awpRcgfVITqJmr4m6h4D7QiLDSW/PQz0VRDDLkPva8Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=itgfnOi4w6ElrBtPlbwuYXt71w4C7FIgEdFIdykJMv2Tu/jW8Ums3HKR64Hl1v48o
	 YxQ0t5yC9Lfg3pfiobJ7IlXjPeLofQVmw8PiR2mqxQQKGaip8sPjNNk+od/1Fe2Lyc
	 yoJZJ33BUdCEV3fwOZCWHuvrUEDXC6c19kPHOFv8WfLBqDHsj6CwxRZwDo7RMY0Y1/
	 qRIeTFzLCrJD9QBQZ47+XsD2UR1gYLLhhStXkMQ6VRaXcMkXb6L9UR7/LZcQO3xl5w
	 6MuD9tVdSVx56gTAuwxVJ1h2AeHMLQm2YvlrEMHDnHhv6FAioR2rzf8XeIRqhvgZch
	 YlFCZ4monKulQ==
Date: Fri, 26 Jan 2024 12:19:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: rohan.g.thomas@intel.com
Cc: esben@geanix.com, alexandre.torgue@foss.st.com, conor+dt@kernel.org,
 davem@davemloft.net, devicetree@vger.kernel.org, edumazet@google.com,
 fancer.lancer@gmail.com, joabreu@synopsys.com,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 peppe.cavallaro@st.com, robh@kernel.org
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: Time Based
 Scheduling
Message-ID: <20240126121928.48a44327@kernel.org>
In-Reply-To: <20240126173634.13162-1-rohan.g.thomas@intel.com>
References: <87msss4gtj.fsf@geanix.com>
	<20240126173634.13162-1-rohan.g.thomas@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 01:36:34 +0800 rohan.g.thomas@intel.com wrote:
> > The tricky part here is that the whole devicetree bindings story for the
> > stmmac driver is filled with such configuration choices. As such, it is
> > only natural to add the property you are suggesting here. I completely
> > agree. But you can also argue that it is "wrong", because it does not
> > just describe the hardware, but also a configuration choice.  
> 
> Isn't this requirement of using enhanced tx desc instead of normal tx
> desc to support TBS is specific to Synopsys IP? Switching from
> normal desc to enhanced desc at the time of tc-etf qdisc offload
> cannot be done without traffic disruption, which I don't think is
> acceptable. Since this behavior is IP specific, can we consider
> this as an OS configuration choice?

Why is traffic disruption not acceptable when TBS gets turned on?
User has to install the right qdisc to enable TBS, I presume,
installing qdiscs destroys the old ones which also leads to packet
drops.

