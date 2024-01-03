Return-Path: <linux-kernel+bounces-15584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE42C822E6F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29102B22D68
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0B199DB;
	Wed,  3 Jan 2024 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x+s9G9vl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dV8nlX4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58032199BE
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 3 Jan 2024 14:32:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704288774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4H80CRSGdTzQeWG8J/t1pdYNtj81m92oCtjq1d9Y6I=;
	b=x+s9G9vlT23YV2If0Q8ePIVboaIkqR4jkuV+5rbc9+GY5PRwzMJkFoXKJB/95Sr+O6hqNh
	/a1pELfl+ehipfI8gSgz5B43ddvNpOpWb5F2vY0ps23fnil+N4Ff3cg4GmKD7YpP035C4v
	nc8NzpJeGVrnw6B3dCkdlTv8yHs9Ojy3UTcYMqZ0kvqO9eoX8uc4iYj2Ll627iwj0WPj62
	TVnzJB2jhbG1kob76HRPfsThn7mBHyGgveHdZQUtMcGi9ZSlaqAvevQHkSUUEjjGaY+ryn
	mvzIs+sQyqp6s8jngnsyLB5TpaXQesG7bvHTXl+MRhKqskkOPgfbEl1DvabaDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704288774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4H80CRSGdTzQeWG8J/t1pdYNtj81m92oCtjq1d9Y6I=;
	b=dV8nlX4GLrXk8V9UMdulRsaBys9hysO/YD0zoSYhz8sYXvp0vXQxbOHg6Sw129gRrnZkgn
	I/j6+Nf7tGOiDRCw==
From: Nam Cao <namcao@linutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ryan England <rcengland@gmail.com>, Larry Finger
 <Larry.Finger@lwfinger.net>, Florian Schilhabel
 <florian.c.schilhabel@googlemail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <20240103143253.0d9c7788@namcao>
In-Reply-To: <f9b34a72-42e1-43f6-b03c-5a3d05773862@moroto.mountain>
References: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
	<20231222094735.5554b67a@namcao>
	<f9b34a72-42e1-43f6-b03c-5a3d05773862@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 16:19:45 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> On Fri, Dec 22, 2023 at 09:47:35AM +0100, Nam Cao wrote:
> > On Thu, 21 Dec 2023 20:22:48 +0000 Ryan England <rcengland@gmail.com> wrote:
> > >  static u32 start_drv_threads(struct _adapter *padapter)
> > >  {
> > > -	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
> > > -					  padapter->pnetdev->name);
> > > +	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);  
> > 
> > Your description claims to fix "CHECK: Alignment should match open
> > parenthesis", but this one is already aligned, isn't it?  
> 
> No.  It was not aligned.  There was a space character missing.

Ah right, sorry for the noises.

Best regards,
Nam


