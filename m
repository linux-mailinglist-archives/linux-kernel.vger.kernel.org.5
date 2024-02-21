Return-Path: <linux-kernel+bounces-74870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF685DE51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF35B2698B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA097F7F2;
	Wed, 21 Feb 2024 14:09:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A9B69D38;
	Wed, 21 Feb 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524557; cv=none; b=Ps6S/DuRQibbDr5MF2V13//Y3guUp/DdnWduUm5CD0LuyYqtxm4TKs93wxPO+1lpMsTNBMhiYaffItx8fySGesuNdNfIR67C5nW8wxKVsdN/rXLmv9gvXz1aPUsTLvRBwbQdL8mzL2/yfNaSPIt2lLQ5zjMLWQiOhkA1KB0o3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524557; c=relaxed/simple;
	bh=o+Pf9FEYFHEjMXG9WRgtJ1Cj03FyG5XJoFFDXLwWgAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKuoP4nsD02qK9DtvhjInNYNnnl2Sc5F9XBF4VK3cViFiQDbraxGKOpVIY2DwAQA1//oUGag3LB7XGpwppZFOSZhQSKEP2EUpXigc5ZYONzIT3a8CXq2PDls9WNQRVMW3LekoejWCiZKm3hKnQ+tpCtE7SPcPkdTBw7Ryqcqsvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30390C433C7;
	Wed, 21 Feb 2024 14:09:16 +0000 (UTC)
Date: Wed, 21 Feb 2024 09:11:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
 quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
 quic_parass@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Change the trace string for the
 userspace tools mapping
Message-ID: <20240221091103.37497ed0@gandalf.local.home>
In-Reply-To: <20240221061146.GF11693@thinkpad>
References: <20240218-ftrace_string-v1-1-27da85c1f844@quicinc.com>
	<20240221061146.GF11693@thinkpad>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 11:41:46 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> On Sun, Feb 18, 2024 at 02:13:39PM +0530, Krishna chaitanya chundru wrote:
> > User space tools can't map strings if we use directly, as the string
> > address is internal to kernel.
> > 
> > So add trace point strings for the user space tools to map strings
> > properly.
> > 
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>  
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>

Suggested-by: may be more accurate?

-- Steve

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


