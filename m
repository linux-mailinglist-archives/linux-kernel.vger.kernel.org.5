Return-Path: <linux-kernel+bounces-44743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB228426D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F3DB26D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4036DD1F;
	Tue, 30 Jan 2024 14:22:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB46DD0D;
	Tue, 30 Jan 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706624562; cv=none; b=WO/TLNpVVf9NloOLyFnBj1CCxq3qQpijCkWvOT9PSMeVhITKDkohqziwKyBNQSyvchHTsVY+24awjldXwiV1d5lDgPxeNtkZ2c2CNfkX9+XucU6G6MArbeDrWxda4jd1pL3dg6cngx/EBaaD3KHhwiL4km1pNDnVCUmXnF8hGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706624562; c=relaxed/simple;
	bh=rcKlKlXS4VbehuZrXGPez5EBI+skpY7MCmwKeAC3sF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBVsqBJLaUlA9WYqpGrZ4YXPDluwwNCddXinyYXJSPDBkfhw9xw4mvgHRdnUzvvyT7yBzCTuyPQCHMTSRI5Uh8EQIibSH4mgU6M7cwgB0IKRDUH5odqmnfGnAfMmNRw/nzaICOvGkKOyL7OVQ0S4SyAcPBonKfJKJT8IUgTgR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F38C433F1;
	Tue, 30 Jan 2024 14:22:40 +0000 (UTC)
Date: Tue, 30 Jan 2024 09:22:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
 quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
 quic_parass@quicinc.com
Subject: Re: [PATCH v9] bus: mhi: host: Add tracing support
Message-ID: <20240130092252.32801387@gandalf.local.home>
In-Reply-To: <20240130081152.GH32821@thinkpad>
References: <20240105-ftrace_support-v9-1-a2dca64cc6ea@quicinc.com>
	<20240130081152.GH32821@thinkpad>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jan 2024 13:41:52 +0530
Manivannan Sadhasivam <mani@kernel.org> wrote:

> So same trace will get printed for both mhi_channel_command_start() and
> mhi_channel_command_end()?

The trace output will also include the tracepoint name. That is, it will
have the same content but will be preceded with:

  mhi_channel_command_start: ...
  mhi_channel_command_end: ...

-- Steve

