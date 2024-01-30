Return-Path: <linux-kernel+bounces-45106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF49842BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB301C21C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D48157E6B;
	Tue, 30 Jan 2024 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGrcLcSM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A43157050;
	Tue, 30 Jan 2024 18:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639221; cv=none; b=M4/07twpU9b1F7FYvN7/oqVDVb5Yc73V8nDNAdS2WFVkISWrtoumUgaD1rIAOcxh+gOjeBAG/al5rEJHckAw1IsdhdffRFw18I3P5z7KLm259hF4oe7h/jNgcu8HVdNivTyPSE6viNBDWy0sDUnFoFt+RvTmRISF52dpMHPOM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639221; c=relaxed/simple;
	bh=HI3jiLjEm1LUR2gZFKB/wxXaBglKCk54jhHtHgjpbOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZ0dC24DWvrOuqlswLMlyVC4Ray9jFo7O441i8NqxLI9cn/L+Qc3TtlAbaKUw9i3HC9ILGe7SptASNeiWkIMhNlMOFBVRwqpb84SF2c53iYg/JP/ga+Ec4R57yciS7U9kiV7kipRLu40QgRKdGvqO3so6XKpuFJA+FrfDjqpcCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGrcLcSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB3C433F1;
	Tue, 30 Jan 2024 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706639221;
	bh=HI3jiLjEm1LUR2gZFKB/wxXaBglKCk54jhHtHgjpbOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGrcLcSMAIBayWpIhNoGoJjNUu7h7KiMyPIMmyerBloa7mxiqX84suGkDBW9TArvb
	 s1XHCOqNhRpAp3RjVVHDZkTS878WYNQQ9QpbsemrnCUp4wxbNLL481rtGc7PxT4ear
	 2zt7RNWLLOCOBlflOKSb+T9IsgMJburRDV2f0WUkmj94lYw7cN5JCBp49VlIaG3VfD
	 6UJHFzk3LsjnvHBW3Xoc4ofWOXpMKfqFD0HYDcWcTty/y3S6JehmqsTS71Rcght9iN
	 wKtkXvOlPcRaEGT+PxjBJr6DvTS/dS1w0Oqgdt0cA+EhFkRZkgQW/pjdsCTpisSEL0
	 Xw/RgrvrDYzbw==
Date: Tue, 30 Jan 2024 23:56:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v9] bus: mhi: host: Add tracing support
Message-ID: <20240130182654.GD4218@thinkpad>
References: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>
 <20240130081152.GH32821@thinkpad>
 <20240130092252.32801387@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130092252.32801387@gandalf.local.home>

On Tue, Jan 30, 2024 at 09:22:52AM -0500, Steven Rostedt wrote:
> On Tue, 30 Jan 2024 13:41:52 +0530
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> 
> > So same trace will get printed for both mhi_channel_command_start() and
> > mhi_channel_command_end()?
> 
> The trace output will also include the tracepoint name. That is, it will
> have the same content but will be preceded with:
> 
>   mhi_channel_command_start: ...
>   mhi_channel_command_end: ...
> 

Yes, but the message will be the same:

mhi_channel_command_start: chan%d: Updating state to: 
mhi_channel_command_end: chan%d: Updating state to:

Either only one of the trace should be present or the second one should print,
"mhi_channel_command_end: chan%d: Updated state to:"

- Mani

-- 
மணிவண்ணன் சதாசிவம்

