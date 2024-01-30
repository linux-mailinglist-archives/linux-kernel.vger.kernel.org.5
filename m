Return-Path: <linux-kernel+bounces-44097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B1841D44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCCB61F25884
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD045577A;
	Tue, 30 Jan 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zws7NfIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026F5786C;
	Tue, 30 Jan 2024 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602321; cv=none; b=LsiKZlEIjM6ljkma2pdrmyLT4hYAhevxbQ52V25LyTn+bBW4J6UYHZuovtrx6cDvCzsZfpElbQ0n46i4GJ54MDWVV2vcsAj2P3OiPyg+I6H4kK/aPVGDirkTKwd38cIcLDEsYc8rFf2zDCrrUnoT/vHKO3xC8pP1yPLViRUQGg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602321; c=relaxed/simple;
	bh=8mFKFjYSUuOIu6xh7rNa3DzWL/XzU+Q5rtoh7P3ST+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjr0TurKivak7dyMuFkqDYi/j83JSIqakR4WAbXvz1tmiRMJcOoZTbKj4HufVpCxTM40fMax9jx+1Vs0oCTKp/1AMqTKBTzc4kgUDQD46pGa3PQra9y93la4rtXAbCRZ1MeGUsxphVO6sD+lV3OI6buaVgim2+VyUAeeMHsiAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zws7NfIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B26C433F1;
	Tue, 30 Jan 2024 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706602320;
	bh=8mFKFjYSUuOIu6xh7rNa3DzWL/XzU+Q5rtoh7P3ST+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zws7NfITdtoBVI2DvHJmPPMvFvvGeg0CSOceSvNai57g0PBFHC4SMN3uNBvo3vwge
	 /ReLfUwc9B4I6TvMFLDMCk+YuCfkEVdxjVG4EKaGXjqXr50Pp1fHdGi+x0l5rwdSYp
	 InMpucqq63wWnrep6OKyQrcfGgEU0luOO9fK0ljc6xlvomqYZVDTOmG2WKJmAk41YU
	 d2o8jLz8P5XRVY2zDA2C8i3z0kMuRAgzl0A4i5KIsffrSkB9rBycy17uimJGCoWX/c
	 /hfFXib1ooW+GM/PPrKahrzq4MNkGrcbo2rUFhRoisoluDNjMonwAhzPpTr/qTEFnK
	 qi9Q8TQ3LcBkA==
Date: Tue, 30 Jan 2024 13:41:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
	quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
	quic_parass@quicinc.com
Subject: Re: [PATCH v9] bus: mhi: host: Add tracing support
Message-ID: <20240130081152.GH32821@thinkpad>
References: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>

On Fri, Jan 05, 2024 at 05:53:03PM +0530, Krishna chaitanya chundru wrote:
> This change adds ftrace support for following functions which
> helps in debugging the issues when there is Channel state & MHI
> state change and also when we receive data and control events:
> 1. mhi_intvec_mhi_states
> 2. mhi_process_data_event_ring
> 3. mhi_process_ctrl_ev_ring
> 4. mhi_gen_tre
> 5. mhi_update_channel_state
> 6. mhi_tryset_pm_state
> 7. mhi_pm_st_worker
> 
> Change the implementation of the arrays which has enum to strings mapping
> to make it consistent in both trace header file and other files.
> 
> Where ever the trace events are added, debug messages are removed.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Few nitpicks below.

> Reviewed-by: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> ---
> Changes in v9:
> - Change the implementations of some array so that the strings to enum mapping
> - is same in both trace header and other files as suggested by steve.
> - Link to v8: https://lore.kernel.org/r/20231207-ftrace_support-v8-1-7f62d4558555@quicinc.com
> 
> Changes in v8:
> - Pass the structure and derefernce the variables in TP_fast_assign as suggested by steve
> - Link to v7: https://lore.kernel.org/r/20231206-ftrace_support-v7-1-aca49a04268b@quicinc.com
> 
> Changes in v7:
> - change log format as pointed by mani.
> - Link to v6: https://lore.kernel.org/r/20231204-ftrace_support-v6-1-9b206546dac2@quicinc.com
> 
> Changes in v6:
> - use 'rp' directly as suggested by jeffrey.
> - Link to v5: https://lore.kernel.org/r/20231127-ftrace_support-v5-1-eb67daead4f1@quicinc.com
> 
> Changes in v5:
> - Use DECLARE_EVENT_CLASS for multiple events as suggested by steve.
> - Instead of converting to u64 to print address, use %px to print the address to avoid
> - warnings in some platforms.
> - Link to v4: https://lore.kernel.org/r/20231111-ftrace_support-v4-1-c83602399461@quicinc.com
> 
> Changes in v4:
> - Fix compilation issues in previous patch which happended due to rebasing.
> - In the defconfig FTRACE config is not enabled due to that the compilation issue is not
> - seen in my workspace.
> - Link to v3: https://lore.kernel.org/r/20231111-ftrace_support-v3-1-f358d2911a74@quicinc.com
> 
> Changes in v3:
> - move trace header file from include/trace/events to drivers/bus/mhi/host/ so that
> - we can include driver header files.
> - Use macros directly in the trace events as suggested Jeffrey Hugo.
> - Reorder the structure in the events as suggested by steve to avoid holes in the buffer.
> - removed the mhi_to_physical function as this can give security issues.
> - removed macros to define strings as we can get those from driver headers.
> - Link to v2: https://lore.kernel.org/r/20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com
> 
> Changes in v2:
> - Passing the raw state into the trace event and using  __print_symbolic() as suggested by bjorn.
> - Change mhi_pm_st_worker to mhi_pm_st_transition as suggested by bjorn.
> - Fixed the kernel test rebot issues.
> - Link to v1: https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com
> ---
>  drivers/bus/mhi/common.h        |  38 +++---
>  drivers/bus/mhi/host/init.c     |  63 +++++----
>  drivers/bus/mhi/host/internal.h |  40 ++++++
>  drivers/bus/mhi/host/main.c     |  19 ++-
>  drivers/bus/mhi/host/pm.c       |   7 +-
>  drivers/bus/mhi/host/trace.h    | 275 ++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 378 insertions(+), 64 deletions(-)
> 

[...]

> +TRACE_EVENT(mhi_gen_tre,
> +
> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
> +		 struct mhi_ring_element *mhi_tre),
> +
> +	TP_ARGS(mhi_cntrl, mhi_chan, mhi_tre),
> +
> +	TP_STRUCT__entry(
> +		__string(name, mhi_cntrl->mhi_dev->name)
> +		__field(int, ch_num)
> +		__field(void *, wp)
> +		__field(__le64, tre_ptr)
> +		__field(__le32, dword0)
> +		__field(__le32, dword1)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
> +		__entry->ch_num = mhi_chan->chan;
> +		__entry->wp = mhi_tre;
> +		__entry->tre_ptr = mhi_tre->ptr;
> +		__entry->dword0 = mhi_tre->dword[0];
> +		__entry->dword1 = mhi_tre->dword[1];
> +	),
> +
> +	TP_printk("%s: Chan: %d Tre: 0x%p Tre buf: 0x%llx dword0: 0x%08x dword1: 0x%08x\n",

Use caps for printing the acronyms everywhere. Like TRE, DWORD etc...

> +		  __get_str(name), __entry->ch_num, __entry->wp, __entry->tre_ptr,
> +		  __entry->dword0, __entry->dword1)
> +);
> +
> +TRACE_EVENT(mhi_intvec_states,
> +
> +	TP_PROTO(struct mhi_controller *mhi_cntrl, int dev_ee, int dev_state),
> +
> +	TP_ARGS(mhi_cntrl, dev_ee, dev_state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, mhi_cntrl->mhi_dev->name)
> +		__field(int, local_ee)
> +		__field(int, state)
> +		__field(int, dev_ee)
> +		__field(int, dev_state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
> +		__entry->local_ee = mhi_cntrl->ee;
> +		__entry->state = mhi_cntrl->dev_state;
> +		__entry->dev_ee = dev_ee;
> +		__entry->dev_state = dev_state;
> +	),
> +
> +	TP_printk("%s: local ee: %s state: %s device ee: %s state: %s\n",

"Local EE... State:...Device EE.."

> +		  __get_str(name),
> +		  __print_symbolic(__entry->local_ee, MHI_EE_LIST),
> +		  __print_symbolic(__entry->state, MHI_STATE_LIST),
> +		  __print_symbolic(__entry->dev_ee, MHI_EE_LIST),
> +		  __print_symbolic(__entry->state, MHI_STATE_LIST))
> +);
> +

[...]

> +DECLARE_EVENT_CLASS(mhi_update_channel_state,
> +
> +	TP_PROTO(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan, int state),
> +
> +	TP_ARGS(mhi_cntrl, mhi_chan, state),
> +
> +	TP_STRUCT__entry(
> +		__string(name, mhi_cntrl->mhi_dev->name)
> +		__field(int, ch_num)
> +		__field(int, state)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, mhi_cntrl->mhi_dev->name);
> +		__entry->ch_num = mhi_chan->chan;
> +		__entry->state = state;
> +	),
> +
> +	TP_printk("%s: chan%d: Updating state to: %s\n",
> +		  __get_str(name), __entry->ch_num,
> +		  __print_symbolic(__entry->state, MHI_CH_STATE_TYPE_LIST))

So same trace will get printed for both mhi_channel_command_start() and
mhi_channel_command_end()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

