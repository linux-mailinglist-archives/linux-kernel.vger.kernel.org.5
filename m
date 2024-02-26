Return-Path: <linux-kernel+bounces-81175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060FF8671AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CD31F26C84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE8C20B38;
	Mon, 26 Feb 2024 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JzW+ZCVs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1f+XLGT7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iMOS3aZ6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4MXVJPs2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C47200CC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708943751; cv=none; b=GTlW8NnCD1vHWMHx9oDNeTKRWaBYr837YILrrGgCxFs6ZT+FyPL6/xUoth15SjxUGJYOO5834xUIv9gA2OUdcZLkhVriYGY+8zKO7PF8T2Kpr+0bUMOvA9eVVWQb7A/thm680EEIpN30LUdgj0VtKyDKMfqr5z+jTRxyR8S4vik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708943751; c=relaxed/simple;
	bh=LqlCLXrB+fXQAIaFWCQIwXwmut2lNFW5Nj+5/ABDjH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/nl+4fU++wXp11EqRIsS6TU7Wj0xYvNEgbtmF4/a3wZ26M39nKgX9vAv3Vs+KGt/zjgLkguWmbe6urwtZynQRzdBAb2s/ghmSvx7PmhPuYyWrH19+GWqxxdX+S6FliHU7fASGAwEyMakPNhY+tMVOK1E+QESzeISFQGyHBZJl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JzW+ZCVs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1f+XLGT7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iMOS3aZ6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4MXVJPs2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1D801F8C4;
	Mon, 26 Feb 2024 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708943748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4dPJyMivSqkDXEmk5JjKaK7fooFIq/w/cp0enRJQ4k=;
	b=JzW+ZCVsHOM+qqiPWdOizcYXhuVKEaB8tX6vY8Cql9t68jEncGf9yEfrHNOIb7CmK5RdIp
	AIOtja+MaeOZag0/NEIU9OJ+5IPkKV8WzhYn7Q4R3uwX5a9oVqkAIotve10Z+x8C6n+8Vx
	zeXSRXkVYN8HIQ55+EalrWbXQI+LNqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708943748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4dPJyMivSqkDXEmk5JjKaK7fooFIq/w/cp0enRJQ4k=;
	b=1f+XLGT7wRRPqQM0nnLoxutRslOKGiV9T0+vsh6CpjxKShADB3q7G8caLjs+d+jZx6HQPG
	twlno35Bj3IUDYDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708943747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4dPJyMivSqkDXEmk5JjKaK7fooFIq/w/cp0enRJQ4k=;
	b=iMOS3aZ6ue7agEzuGvgBdXNF3L8juMYpKLFgCkDvJB5O5vIi61RTF753ZYXWCZm8M42xak
	dRDwwlf3gHWASZwlCMaAPgNx2kUepzF8eR1SqTbAvAcIpZaSrp54Baquafy7m0fBVJN+83
	0mfSQU56unQb1QfEXtG5eQjP7Ptu1V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708943747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4dPJyMivSqkDXEmk5JjKaK7fooFIq/w/cp0enRJQ4k=;
	b=4MXVJPs2b9tPyyF6TbeFHSxWHl/Bsmj/bEUJwLDksL6eQqnbQICVzNVNX23ZpDFgUcye4H
	GkjoNOrWPxB7OqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D510A13A58;
	Mon, 26 Feb 2024 10:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uZhhM4Jp3GWyMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 10:35:46 +0000
Message-ID: <7b7c9ce0-86cf-4f68-a433-3a3a9d09ce2a@suse.cz>
Date: Mon, 26 Feb 2024 11:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] freevxfs: remove SLAB_MEM_SPREAD flag usage
To: Chengming Zhou <chengming.zhou@linux.dev>,
 Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, roman.gushchin@linux.dev,
 Xiongwei.Song@windriver.com, Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134835.829506-1-chengming.zhou@linux.dev>
 <ZdxiqJZY2qSRVvEU@infradead.org>
 <e5709d61-18cf-4c6e-89b0-9615296c645a@linux.dev>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <e5709d61-18cf-4c6e-89b0-9615296c645a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iMOS3aZ6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4MXVJPs2
X-Spamd-Result: default: False [-0.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.01)[45.16%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: F1D801F8C4
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On 2/26/24 11:24, Chengming Zhou wrote:
> On 2024/2/26 18:06, Christoph Hellwig wrote:
>> Please just do a scripted removal after next -rc1 instead of spamming
>> everyone..
>> 
> Do you mean put all diffs into a single patch, send it to all people?
> That is also a choice if it's preferable. Should it will go through
> the slab tree then?

In case that's what Christoph means, we should exclude from that those
subsystems that already took your patches.

> Thanks.


