Return-Path: <linux-kernel+bounces-131520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A148988FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D91281E8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C6E127B7E;
	Thu,  4 Apr 2024 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kqEylmTq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KkNAOZuR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kqEylmTq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KkNAOZuR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B43E17722
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238139; cv=none; b=jZGOANIaQphTCuhrmx+4VQzUvUnMl00RqgR2zgzfTfktkGv4aV9frngqBKyLsGa0+RDFA/rC+UISZwPRXUhde2tFsPenHmQfeh4D23UGHxMpQ25YRYIaoOfeO6pjVIweJOyaX4tTnOBAnyqaacjpLzOFNhbN9zfJXKgiGBa5Wy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238139; c=relaxed/simple;
	bh=qMD/lvlY3DoToWa/F0lmWjc16NjzdoQqwbmEIRR9314=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcFXwQneW+O7OIpnY5eF2f5soPbqlNIXBcOM+i2F4PzoigGYtYHSfBuz+R+AsfWonUuVDtv8/fhEblAHr8XuU2jGsCDkCICyMUYDXveOP415/GYkK9EeuJ6HY1BE02ojOflx1cm7fpQ72XpRDgXDFyVS2XXbJnZzXqlvgj5cZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kqEylmTq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KkNAOZuR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kqEylmTq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KkNAOZuR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id 40D985D9E9;
	Thu,  4 Apr 2024 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712238136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKECyJGr5HtdnaY4tsEoyLq946ISDZRIngiGxLxPkeQ=;
	b=kqEylmTqvUE77JwCy+hG582za952DmmVZ9IFzsBtxTCoEm89d89I3FuVs4D6GbqbUBw9Gx
	/sHNBke+ZcojfIQfncITw5u+dt/ZUEX0rfMOGdOpm7aZTKXLtklfsv0DlCiVq7T2i7wINH
	cT13HaHBGHKuIMVcOsd5+7Gz+jz5ouU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712238136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKECyJGr5HtdnaY4tsEoyLq946ISDZRIngiGxLxPkeQ=;
	b=KkNAOZuR118ii50urefvcvYFK1hYSXzWbOzMJWFmUQTK8w32+r9IzLsXZAAGMiBeDVx6D9
	8bsnRCIPpN7aXdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712238136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKECyJGr5HtdnaY4tsEoyLq946ISDZRIngiGxLxPkeQ=;
	b=kqEylmTqvUE77JwCy+hG582za952DmmVZ9IFzsBtxTCoEm89d89I3FuVs4D6GbqbUBw9Gx
	/sHNBke+ZcojfIQfncITw5u+dt/ZUEX0rfMOGdOpm7aZTKXLtklfsv0DlCiVq7T2i7wINH
	cT13HaHBGHKuIMVcOsd5+7Gz+jz5ouU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712238136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jKECyJGr5HtdnaY4tsEoyLq946ISDZRIngiGxLxPkeQ=;
	b=KkNAOZuR118ii50urefvcvYFK1hYSXzWbOzMJWFmUQTK8w32+r9IzLsXZAAGMiBeDVx6D9
	8bsnRCIPpN7aXdCQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 228F54A0553; Thu,  4 Apr 2024 15:41:46 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Yunhui Cui <cuiyunhui@bytedance.com>,  =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: use KERN_INFO in do_trap
In-Reply-To: <mvmy1aegrhm.fsf@suse.de> (Andreas Schwab's message of "Tue, 19
	Mar 2024 16:40:05 +0100")
References: <mvmy1aegrhm.fsf@suse.de>
X-Yow: All I can think of is a platter of organic PRUNE CRISPS being trampled
 by an army of swarthy, Italian LOUNGE SINGERS...
Date: Thu, 04 Apr 2024 15:41:46 +0200
Message-ID: <mvmcyr5ckit.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -4.14
X-Spam-Level: 
X-Spamd-Result: default: False [-4.14 / 50.00];
	BAYES_HAM(-2.94)[99.75%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

Ping!

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

