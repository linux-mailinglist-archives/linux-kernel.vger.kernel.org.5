Return-Path: <linux-kernel+bounces-40352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F96F83DEE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F13A1F226D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4331DA3F;
	Fri, 26 Jan 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suoHG8Yj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g9ay6JgM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690141EA71;
	Fri, 26 Jan 2024 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287147; cv=none; b=jaTSnfMjxgU5fACmw06yBGnXO9LuxI6OVch+K2aikmWy60aO+H6b7PZ4T3VKMHoMhLyOJLWZRD00zJZAAWeZseewFTxARLXjm+WxMC5MJVoV8QHG7fVy9UXszN+8QCB+61CD8JMGVg2uqS56I3ZwzZhC9qYMJKeFpcNoFUHDT3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287147; c=relaxed/simple;
	bh=W6zuI3waGCTeb1d5uZ/dpw3FaWqNORW14aFUWEAngEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbDU8NBfFZFzgQHVqlhAKKhxpaQkefHJT1aVjLPl6sDj9U/Wcc1AB/SQNKjK45ke9SUC35btaoQnDhVMuMZbyTz1mj/0c0tZSVN1mobD5yVPMUQChjWV665ccF07r/tZasqQbPCCcheexeTCnJeSsW9Sc2SJkr4qbqQKXLjP7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suoHG8Yj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g9ay6JgM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 26 Jan 2024 17:39:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706287144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INxBiFoIM0vVgBRcOPAgwcpiyMf5guNzuz9/BtuX01s=;
	b=suoHG8Yjrsnyy9fKG2eNlHJPI/WDfVqi3DUPuoIesdsa6HzYh4vh6jVU8Tt5wnHaBWoL3N
	o94wJ+lPdUFpA+ZYlt38LURzyFHZwS5DmimXkZqADr3Y1pWbe3A1sThjDMnaFf/k0QRQ9S
	oWeZe5EyK5E4FLK6ORrSo1iy0yeIdfZ6iSJHkhcEbcAliO5MS0yUlZZg6N1sDRj1opqNkR
	g5johSYKqObBKShbUNkt99xrHwHNK9N+zM+eKRpJAqgvPuRbe9P29gNG00X7pFV7m50O4l
	zuaYPfSVyhD19MC2ty8VFy1m7P+nv3eLFGEBUfjD8odkTAtL4IV5Nl9q8Z1lyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706287144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=INxBiFoIM0vVgBRcOPAgwcpiyMf5guNzuz9/BtuX01s=;
	b=g9ay6JgMiiczzoQX1jwdqetoycDOd41Kr0ZPLAr75ixLUTcCMw0bpbGv5eEs49Sln7xj1/
	W4snYgg6zIXtgqCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Cc: "Chang, Junxiao" <junxiao.chang@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Li, Hao3" <hao3.li@intel.com>, "Li, Lili" <lili.li@intel.com>,
	"Gao, Jianfeng" <jianfeng.gao@intel.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] printk: nbcon: move locked_port flag to struct
 uart_port
Message-ID: <20240126163902.d3SiJco8@linutronix.de>
References: <BN9PR11MB5370AED9C562F9DA75093557EC742@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240123054033.183114-1-junxiao.chang@intel.com>
 <20240123054033.183114-2-junxiao.chang@intel.com>
 <87le8f9i75.fsf@jogness.linutronix.de>
 <20240124100524.ZyAPfPU5@linutronix.de>
 <BN9PR11MB53701E5CF2737908FA9EB532EC7A2@BN9PR11MB5370.namprd11.prod.outlook.com>
 <20240125133523.W7aDeBqt@linutronix.de>
 <87il3gv845.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il3gv845.fsf@jogness.linutronix.de>

On 2024-01-26 09:04:34 [+0106], John Ogness wrote:
> Hi Sebastian,
Hi,

> Please add this one patch to the 6.6-rt and later queues. The 2nd patch
> in this series is not needed.
Okay. I just dropped a v6.8-RT with this included and I am going to poke
Clark regarding v6.6 next week.

> Thanks.
> 
> John

Sebastian

