Return-Path: <linux-kernel+bounces-725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286FB814531
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2CF1F23B16
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504981A700;
	Fri, 15 Dec 2023 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Oj9f15Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJXfuCHH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239FC1A709
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702635047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLcj+WCoV6v2wxVqrp02AYuWJfk9YmNWkzYMdewgi9A=;
	b=2Oj9f15ZJDGBaAJDH02RVe0CrzsbQ36RZZO2ynhWtUZ4hATEomnuSbe2JmyhzhF8ZhoIlV
	BeBahhECh9XGQvq/O9dQVGeETf6u/hZZX3+AO4vmuV/wgiSzCk9BH796udjmqusG+iRfgK
	1lVB+KLp22BjFnnmDjM4RWH4ipkQSZv/ZQdZLrrBdUOZkHyi+Bc+gbxgHgkhGRFQodIL9q
	gLUtYTeioF03J6hbT8xJBLLvuM+5s8/Gwh3OKadRogprjIVk+b6R728y6b4eAQFEdQkknq
	sTs71ve5MIEIEoINCURrNsYL6P/mszgE+JW7aO1zBHnKPQNGB9v4O1+xr1JXUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702635047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xLcj+WCoV6v2wxVqrp02AYuWJfk9YmNWkzYMdewgi9A=;
	b=NJXfuCHHojqVL90VT014f6niOblxHL1b9ed+iAoKNECyDDguUl60mVgXnojpmtmLj/CbyQ
	cppzVYBR5A69DPAg==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Francesco
 Dolcini <francesco@dolcini.it>, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH printk v3 02/14] printk: Adjust mapping for 32bit seq
 macros
In-Reply-To: <20231215095526.ZA8Q-45e@linutronix.de>
References: <20231214214201.499426-1-john.ogness@linutronix.de>
 <20231214214201.499426-3-john.ogness@linutronix.de>
 <20231215095526.ZA8Q-45e@linutronix.de>
Date: Fri, 15 Dec 2023 11:16:44 +0106
Message-ID: <8734w3hj2z.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2023-12-15, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2023-12-14 22:47:49 [+0106], John Ogness wrote:
>> Note: This change only applies to 32bit architectures. On 64bit
>>       architectures the macros are NOPs.
>
> You lost my authorship.

OK. Thanks for speaking up. (And thanks for doing the heavy lifting
researching the needed change.)

> But serious matter: Is this bug already present in the current printk
> tree or is this code just not used and enabled later? Patch #1 from
> this series moves the sequence around so is this problem introduced in
> the previous patch and fixed here?

No, it is not a bug at this point. As the commit message writes:

"Until now this mapping has been correct for all call sites."

But if the mapping is not changed here, it will become a bug after
applying patch 3 of this series.

John

