Return-Path: <linux-kernel+bounces-16030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F4882373B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AA42840FE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9801DA4C;
	Wed,  3 Jan 2024 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="rJ1zcD3L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C71DA3B;
	Wed,  3 Jan 2024 21:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2D2C58E3;
	Wed,  3 Jan 2024 21:41:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2D2C58E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704318100; bh=eKF2CmSPyx6S7Xfe8czyV0aFSG5CrUi4IDK255IdV5w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rJ1zcD3LIR9pVdIBft2RgJYCw9h1bprmnSunuAvyDACF6Q92DIMhWD00Z0Zc0iYPa
	 Mvftvv4PAMmnX/+TfIgXaw/jHtN3umNU2LL7R8pjByU810/cnG0ukwmBm13b1VIl0r
	 yULYd5DObpAf5KnW4KHjT2kGGoNN4+02Xs+sGW9LWphVIuVhC2YlszDrZgDITchGtl
	 VNTlBYRMf5UqWMWEm0HCkPZEKIUKwzUVCGDfDf+CTm8dBycNhoF7hF8g/uGfN1pHMW
	 1NevBT8PztCsc+kIy1mNCHCt5dkYPkIoH8XLcAIpzwZjjyjtYAZdlWzFdaSCzV+Dw5
	 GmQOgmyypJklg==
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] ring-buffer/Documentation: Add documentation on
 buffer_percent file
In-Reply-To: <20240103162535.6de92d55@gandalf.local.home>
References: <20231226130149.4685c838@gandalf.local.home>
 <87h6ju86fh.fsf@meer.lwn.net> <20240103162535.6de92d55@gandalf.local.home>
Date: Wed, 03 Jan 2024 14:41:39 -0700
Message-ID: <87il4a6qng.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 03 Jan 2024 14:15:30 -0700
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>> >
>> > When the buffer_percent file was added to the kernel, the documentation
>> > should have been updated to document what that file does.
>> >
>> > Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
>> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>> > ---
>> > Changes since v1: https://lore.kernel.org/all/20231226123525.71a6d0fb@gandalf.local.home/
>> >
>> > - Fixed some grammar issues.
>> >
>> >  Documentation/trace/ftrace.rst | 15 +++++++++++++++
>> >  1 file changed, 15 insertions(+)  
>> 
>> Are you planning on shipping this one upstream, or would you like me to
>> pick it up?
>
> I was hoping you can take it, but please take v3.
>
>   https://lore.kernel.org/all/20231229122402.537eb252@gandalf.local.home/

Yep, will do.

Thanks,

jon

