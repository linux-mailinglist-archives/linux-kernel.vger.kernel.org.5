Return-Path: <linux-kernel+bounces-48692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39695845FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC2329A70B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9729612FB39;
	Thu,  1 Feb 2024 18:24:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F077428C;
	Thu,  1 Feb 2024 18:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811860; cv=none; b=NdXf5DsrSY4nltDMoNrNxkcaIwbSUpQMvIObtoE/52wmmdiiZ5gG4oInTdALLsnO+D4yQeMFBoLHBTit0Am9JbHibSrth6OcG70CvvF+/9FgXRBEX1cFq0wLE+o7BdcOV5CEy6Rsp7mjjFYmuUCoR866upycYyBDp9bFfin4jpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811860; c=relaxed/simple;
	bh=BOS8IckEOJiSKhIt0o7FujGsBPZmSunw2pR4SkP6f2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT/cnr38ONZRWI7mC4UnMvsVg4OKqkobwjDqkDeSMzQwyywJyfAONwbajCRd50Pbk8ZdMHkI2/eNuUm4otEzDid3bv4fp97U6JPOcHPjbXtXml9zd150KGSihTo9wyVzLGoCLgqBt/+gbcqVbFBnUWgpAX/35nPXwMjjKxtULSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B650BC433C7;
	Thu,  1 Feb 2024 18:24:18 +0000 (UTC)
Date: Thu, 1 Feb 2024 13:24:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing/timerlat: Move hrtimer_init to timerlat_fd
 open()
Message-ID: <20240201132435.5bb019cf@gandalf.local.home>
In-Reply-To: <2024020140-santa-bagful-51d8@gregkh>
References: <7324dd3fc0035658c99b825204a66049389c56e3.1706798888.git.bristot@kernel.org>
	<2024020109-duffel-finally-4f0b@gregkh>
	<05c12163-d348-4615-a9e3-f36787629e0e@kernel.org>
	<2024020122-uncombed-moody-a96d@gregkh>
	<20240201130823.36f1da8d@gandalf.local.home>
	<2024020140-santa-bagful-51d8@gregkh>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Feb 2024 10:12:50 -0800
Greg KH <gregkh@linuxfoundation.org> wrote:

> And cc: stable properly?  thanks!

The script I use automatically did that ;-)

-- Steve

