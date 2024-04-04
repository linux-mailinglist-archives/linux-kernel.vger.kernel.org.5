Return-Path: <linux-kernel+bounces-131516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD68988EF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA36F28EB2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1F2128375;
	Thu,  4 Apr 2024 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZnIQx02"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF91272BB;
	Thu,  4 Apr 2024 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237923; cv=none; b=VL4awlCoXmIhuIPJkaOMIM5sFNAfEweXYmpqmZiuYBy0xTVHxgPPSYnr2wpqnozDkz/1yFj2KaVQT13IV58YHy8I15Cu/NLqkkG2cO2NNIY3HGaBikRzSu+b9Y5nFiLNl1d1TECfN3r8KWxdiDcarI5SFo5+vYekI1ndCOKDhfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237923; c=relaxed/simple;
	bh=Ytk+RYNnGOzswIfj2b5w7iQj6urpyLQzMSAFPdEwAfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHQRt95NaSDm0EZBvAtgHo1Q7EU9SfHg7KeaGrGUWXXOum8cTfHCK1SKt9GW8PcZpqMiw+pM0wfY9o4QvXgA+iMBzix3lnezKn39R5jYMBzxK4al17O0HOaUPHfsuhx8EI2TeY/9oLwxa10nrl74dDKAgYEQdi3IghVvKebApzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZnIQx02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE308C433F1;
	Thu,  4 Apr 2024 13:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712237923;
	bh=Ytk+RYNnGOzswIfj2b5w7iQj6urpyLQzMSAFPdEwAfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tZnIQx02l4JDzme/JJPv3tMLIR5sot8N7vN2W3GzHp6bJs4aQAinpCR4YTZgCuDfe
	 83qMi0HLp4xB90u+hHFyWLaaGr51cctA+uHzZW+sgMuM+UwM6zcHymzPFvCO98Vcbl
	 CXKydJtRl3kP+P87AVz1wcIm/BFBJ5sNYLMFksvZ1oIVGAHC6lOoKIhlO84tVUCYww
	 nzgyy4t+tsWmovha0Ewp6tZ/7CXdR7M1p+wp82/BDI1LtPSWz7AlPZEBuUe8BFyXc/
	 kEhdRNCT/55G0WhqhIZXuajUdC9TegXAfvdTKRwnsnlbPdh1t6BZuWN5zeKviMo3XW
	 XWeewjnZ/Z1mA==
Date: Thu, 4 Apr 2024 15:38:40 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
Message-ID: <Zg6tYD-9AFPkOOsW@localhost.localdomain>
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327112902.1184822-3-vschneid@redhat.com>

Le Wed, Mar 27, 2024 at 12:29:02PM +0100, Valentin Schneider a écrit :
> The symbols relating to the CT_STATE part of context_tracking.state are now
> all prefixed with CT_STATE.
> 
> The RCU dynticks counter part of that atomic variable still involves
> symbols with different prefixes, align them all to be prefixed with
> CT_DYNTICKS, as CT_DYNTICKS_MASK already is.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

It used to be that RCU extended quiescent state and dynticks enter/exit
were coupled. But this isn't the case anymore. Nowadays RCU stops watching
some time later after dynticks is entered.

I wonder if we shouldn't take advantage of that cleanup for a meaning that
really reflect that RCU stops watching from there.

Paul what do you think? CT_EQS_IDX ? CT_RCUEQS_IDX? CT_RCUOFF_IDX? ...?

Thanks.

