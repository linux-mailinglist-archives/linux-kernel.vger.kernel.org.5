Return-Path: <linux-kernel+bounces-167085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951288BA446
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D071D1F23DCD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B88029CA;
	Fri,  3 May 2024 00:03:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CD7193;
	Fri,  3 May 2024 00:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694609; cv=none; b=TMR2BnOcjrGzdmJX61m6TX+kl8KWh6k1JEd/5isqIwILQbrsNAocqNiX01O1ukkfJ7xy5pp6T0+XnDEPjYBL/bayjiIB5kxlnB9RbMMdo8Le2vR78gPK4VklSbRRElnZywk//hi2+Y2wj/b5nerCbZ3ADmWVHO3s685MUrj/k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694609; c=relaxed/simple;
	bh=G89X7xvSflbKqzRKU6IdOPRcaSykCDlw9e+D/v4AHPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nH2dA3nByIfwN/o7uf2aQgi+d4HOYIkqZX33KE5KGe9n2s28yBSZVFlkAdG5e2sRPgWvW43//iqg5shvuFXrEVkjGs/iE58d97psAH9eYrc0EshzptanFI09KXHXaEfifr13eXdFb59haJuhXHFtYvRr87oPVQUAUUr/K0imkTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CB0C113CC;
	Fri,  3 May 2024 00:03:28 +0000 (UTC)
Date: Thu, 2 May 2024 20:04:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kuba@kernel.org, ast@kernel.org,
 clm@fb.com, mark.rutland@arm.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH resend ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <20240502200414.6f330072@gandalf.local.home>
In-Reply-To: <135a21d0-1622-418a-b49f-8338a4230ff4@paulmck-laptop>
References: <ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop>
	<20240502110501.772941f7fdbc1650a9a3bea4@kernel.org>
	<82ae8a24-f9cf-4730-b0d7-43fb3bca2917@paulmck-laptop>
	<20240502173100.42c8a3f7@gandalf.local.home>
	<135a21d0-1622-418a-b49f-8338a4230ff4@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 May 2024 16:13:59 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Very good, and thank you!
> 
> I will drop it from RCU as soon as it shows up in either -next or in
> mainline.

Sounds good.

I'm currently working on updates to get into -rc7 and plan to add my next
work on top of that (I know, I know, it's probably the latest release I had
for next, but things are still being worked on).

-- Steve

