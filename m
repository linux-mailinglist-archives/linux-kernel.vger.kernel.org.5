Return-Path: <linux-kernel+bounces-110276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588EC885C75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D6D1C22DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030786250;
	Thu, 21 Mar 2024 15:46:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABD11E879;
	Thu, 21 Mar 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711035970; cv=none; b=NXgmXP2ekBYlyZ0WUjGBmsRdJNWJwkHtmGVOY42Hrb2el9PC7CSg2h3p3UPJfME/h/tdc1uxCPz4/QeFhQhZabQfmdlSAgDe+/Bt7HXrNZQykfyW6HJL+BX/SgHx3lthFz2KAI07OTZUAvqwFR0qOpxZkyT1nbvw19G4F76jbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711035970; c=relaxed/simple;
	bh=eaYFDO2RONWaRlBj2kDQLJYRqxq/wypK3rVS0hwhKqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlnbpRHEhe4ohTVdWvXRdORvMMZOMlcvRxlhY1uuY5oQGIQYAZuFW2i00rV159IShCHLX/wLgDEAGNZrdcdYHh1LkRts8CH5WseLfbbQdgtH1FC0ZeBuu/QP7Zw95Au7U4xXkC6dEM19FKBVqzutVGYMiaO1vF5h/rMjmy36XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A38C433F1;
	Thu, 21 Mar 2024 15:46:09 +0000 (UTC)
Date: Thu, 21 Mar 2024 11:48:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Ye Bin <yebin10@huawei.com>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] tracing/probes: support '%pd' type for print
 struct dentry's name
Message-ID: <20240321114836.2d448dd1@gandalf.local.home>
In-Reply-To: <20240322002805.fbfe11e4f8f02e701d8d0c91@kernel.org>
References: <20240320132924.2802187-1-yebin10@huawei.com>
	<20240320132924.2802187-2-yebin10@huawei.com>
	<20240321101547.1f4e68ab@gandalf.local.home>
	<20240322000759.ec04bca3bb2afdfaef37a545@kernel.org>
	<20240322002805.fbfe11e4f8f02e701d8d0c91@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 00:28:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 22 Mar 2024 00:07:59 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > What would be really useful is if we had a way to expose BTF here. Something like:
> > > 
> > >  "%pB:<struct>:<field>"
> > > 
> > > The "%pB" would mean to look up the struct/field offsets and types via BTF,
> > > and create the appropriate command to find and print it.  
> > 
> > Would you mean casing the pointer to "<struct>"?  
> 
> BTW, for this BTF type casting, I would like to make it more naturally, like
> (<struct> *)$arg1-><field> as same as other BTF args.
> 

Sure. I'm just interested in the functionality. I'll let others come up
with the syntax. ;-)

-- Steve

