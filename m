Return-Path: <linux-kernel+bounces-1417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76905814EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D04328719A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8F147F41;
	Fri, 15 Dec 2023 17:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TDeInjso"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D53FB1D;
	Fri, 15 Dec 2023 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702661055;
	bh=FZ8rwK+5wMFJ7/Xt3LcWaD2Ordyss5Gn7grTwtsgb2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TDeInjsoISIC24ItyMMpdPo10dqpCMwc9K9tauatN6aBd7CvQzAUD/6LkrBTiikZu
	 dkCLDPcN/4x3YvWRVa2pTHpKDeW3kiLp0Vl40brNw6szVuScXNUvtaoU3ZadIYejNx
	 2krmdcroELnMC/mwgunIM6duJd2nXXXctah9lc11kFxieM8R29/FtAZn32QU44Umon
	 X3Xj9bBrNLsSzAuAFEyUT2iz7VGNXNBa8q/SXbLQfFkcLBX1cuqWgPTrBsR6/4VvXX
	 PxGBqCnoIqh/5NHcnxjpK3OkMAGYMcnPkMlNOqfi3tn84bb9r3TVGT748TiGMp8zAW
	 pTnDgVQWyfgtA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SsGKp6VLvzGhD;
	Fri, 15 Dec 2023 12:24:14 -0500 (EST)
Message-ID: <fbf8991a-ce83-462c-b87a-b60c6635d223@efficios.com>
Date: Fri, 15 Dec 2023 12:24:14 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add disable-filter-buf option
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
References: <20231215102633.7a24cb77@rorschach.local.home>
 <21936075-3858-446a-9391-a38e8d8968e7@efficios.com>
 <20231215120417.567d5ea4@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231215120417.567d5ea4@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-15 12:04, Steven Rostedt wrote:
> On Fri, 15 Dec 2023 10:53:39 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
[...]
>>
>> So rather than stacking tons of "on/off" switches for filter
>> features, how about you let users express the mechanism they
>> want to use for filtering with a string instead ? e.g.
>>
>> filter-method="temp-buffer"
>> filter-method="ring-buffer"
>> filter-method="input-arguments"
> 
> If I add other ways to filter, it will be a separate file to control
> that, but all options are on/off switches. Even if I add other
> functionality to the way buffers are created, this will still have the
> same functionality to turn the entire thing on or off.

I'll be clearer then: I think this is a bad ABI. In your reply, you justify
this bad ABI by implementation motivations.

I don't care about the implementation, I care about the ABI, and
I feel that your reply is not addressing my concern at all.

Moreover, double-negative boolean options (disable-X=false) are confusing.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


