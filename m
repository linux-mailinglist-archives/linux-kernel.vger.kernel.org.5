Return-Path: <linux-kernel+bounces-65026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE578546DE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5841C2435A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B12171C8;
	Wed, 14 Feb 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hQ59DxE2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cijv3v90";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hQ59DxE2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cijv3v90"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B279DF
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905458; cv=none; b=DZtfGqNpbH8nsKEVvOQ9i8JeXCmlCSCtktFNSkx8gdoXKwTObYglqRVyLjCdr99nAPMC/xL/FZmyRk8wTz9JmRV2duY0WjnDuc0sINZF+0WEB1tpreDgp811bTi0sC2paaifh2tmm98fP72sUEc3997UpX+hev5939+Qb1zqiiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905458; c=relaxed/simple;
	bh=VbCpi648cWO9vEdIxj6hhE5XdEGDe2VZIK8zfnr0l2I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q5kvuEF4Qjg0KDhE4Z3ALzwDZIFsPu1ZmbY6tubEwgLuxiZ69aWtNbjwJb+P6pHfPEVY4r/MJjAb9/ABwgj2LgweUlmDucQaRzJ0S6aQaGVQ1qiJetZtYDbVlbCCBWOyo6v++BY79iUX2lR4yOiCfEjqGGw3kYJnbzcftJBOEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hQ59DxE2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cijv3v90; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hQ59DxE2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Cijv3v90; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0988A22034;
	Wed, 14 Feb 2024 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707905455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKHS3Tm9mFG5fwX6aOLXFqUCCVUiA1XcZVTlspPHL4k=;
	b=hQ59DxE2eGoDgeAPzrKgnd/lATT0UnlL/VauispDaRmzRcWzrHoupVd/iuLFCcp1bWccOm
	wnRQ9OG0lph7VCAeWQGzfeaCX/KMKNXGjXwh/aA/4BSRpjXMdXADAbkn9RcDHqzCH0yjHo
	4F0S2cuQUl47fVitwZf/lrQtyIB8/ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707905455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKHS3Tm9mFG5fwX6aOLXFqUCCVUiA1XcZVTlspPHL4k=;
	b=Cijv3v90qAXWqCrQVYxQ0HJ75CdM4G/XjXV4BhnxSqAlbNQFxbiNrf1OOnhumuEhyOJGPc
	XSJJM0WOCaUFivCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707905455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKHS3Tm9mFG5fwX6aOLXFqUCCVUiA1XcZVTlspPHL4k=;
	b=hQ59DxE2eGoDgeAPzrKgnd/lATT0UnlL/VauispDaRmzRcWzrHoupVd/iuLFCcp1bWccOm
	wnRQ9OG0lph7VCAeWQGzfeaCX/KMKNXGjXwh/aA/4BSRpjXMdXADAbkn9RcDHqzCH0yjHo
	4F0S2cuQUl47fVitwZf/lrQtyIB8/ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707905455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UKHS3Tm9mFG5fwX6aOLXFqUCCVUiA1XcZVTlspPHL4k=;
	b=Cijv3v90qAXWqCrQVYxQ0HJ75CdM4G/XjXV4BhnxSqAlbNQFxbiNrf1OOnhumuEhyOJGPc
	XSJJM0WOCaUFivCA==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id C1FF44A04EC; Wed, 14 Feb 2024 11:10:54 +0100 (CET)
From: Andreas Schwab <schwab@suse.de>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org,  Palmer Dabbelt <palmer@dabbelt.com>,
  Yunhui Cui <cuiyunhui@bytedance.com>,  =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: use KERN_INFO in do_trap
In-Reply-To: <20240214-exclusion-pluck-fcb6352a8393@spud> (Conor Dooley's
	message of "Wed, 14 Feb 2024 09:19:09 +0000")
References: <mvmh6ic1y75.fsf@suse.de>
	<20240214-exclusion-pluck-fcb6352a8393@spud>
X-Yow: This is a NO-FRILLS flight -- hold th' CANADIAN BACON!!
Date: Wed, 14 Feb 2024 11:10:54 +0100
Message-ID: <mvmttmbz781.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.89 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-1.79)[93.73%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.89

On Feb 14 2024, Conor Dooley wrote:

> On Tue, Feb 13, 2024 at 10:59:58AM +0100, Andreas Schwab wrote:
>> Print the instruction dump with info instead of emergency level like the
>> rest of the output when printing the information for an unhandled signal.
>
> I'm not entirely sure that this is true, __show_regs() prints with
> KERN_DEFAULT, but this certainly is more consistent than it was before.

The first line is printed with pr_info.  Perhaps __show_regs should gain
a level argument.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

