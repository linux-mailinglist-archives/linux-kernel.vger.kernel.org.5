Return-Path: <linux-kernel+bounces-148530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6858A8403
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94906285D45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18F13D62C;
	Wed, 17 Apr 2024 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BI19lfjl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZXCQhom";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BI19lfjl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zZXCQhom"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83C13D60D;
	Wed, 17 Apr 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359734; cv=none; b=ubrREVyEcRtmSl2cP+XDRyNMrQ+7v+b6f1r5WjnJRabDPSebkVgDVzPAEtF8j6HMKftyS2HQYS1lDL7j+xBfySZ0/UdeG9mNBKiFmyzy0WJFk7Jamii0UdXWZ2GIZ+s9hDgJyFj920JdHjk31+cgKiRFcFRwT/BulRnBJCNXvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359734; c=relaxed/simple;
	bh=V8LaknUDc4WKs3GqAScyDzmcm1aKXuPfhFm71vCWKqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rmm9BnrXBaYY+5Q5ou3wYsikko8Q/k8UaPYqRZkGANQigyzWOOG2ZcYTWvM25rfDTzJqYwfuMrtTH9aVZ931OIc5X94eNzLG9R3KIH8IWOuRHMw3el8q86Tp/8mI8bi/pBC83xGrxRQXfcEae5LkOhkqSpmzKubV0GjbZFNVC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BI19lfjl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZXCQhom; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BI19lfjl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zZXCQhom; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10FD220963;
	Wed, 17 Apr 2024 13:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713359731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+ZueSFyIMMDx9sGGpZkeYm7eiseTMd18AXayqNCq9Z0=;
	b=BI19lfjljPR09lzYKVJd5psMBQfUdqSe7kL87K+3qA+mKFnnQ80V18mANSWx066H+Loem9
	6V6ocowXVpoD2JwkvIx5aSIpCkJf9yEE/9ayUBs0Yy/eOCa7aMhTWLM8CrmE/CghT5tonk
	oJ7Kmld7oxWT8VkLej1mKwo+UBS2iyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713359731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+ZueSFyIMMDx9sGGpZkeYm7eiseTMd18AXayqNCq9Z0=;
	b=zZXCQhom9Ow2oNsFJOKmw3hjngnBMNqDh8Dg9HN5JBc8b/QZPKn8lmXRHdm1aHjMJxGqlx
	5fFye6ELDhH/6SCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713359731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+ZueSFyIMMDx9sGGpZkeYm7eiseTMd18AXayqNCq9Z0=;
	b=BI19lfjljPR09lzYKVJd5psMBQfUdqSe7kL87K+3qA+mKFnnQ80V18mANSWx066H+Loem9
	6V6ocowXVpoD2JwkvIx5aSIpCkJf9yEE/9ayUBs0Yy/eOCa7aMhTWLM8CrmE/CghT5tonk
	oJ7Kmld7oxWT8VkLej1mKwo+UBS2iyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713359731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+ZueSFyIMMDx9sGGpZkeYm7eiseTMd18AXayqNCq9Z0=;
	b=zZXCQhom9Ow2oNsFJOKmw3hjngnBMNqDh8Dg9HN5JBc8b/QZPKn8lmXRHdm1aHjMJxGqlx
	5fFye6ELDhH/6SCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5E5B1384C;
	Wed, 17 Apr 2024 13:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A8LGN3LLH2ZrLwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Apr 2024 13:15:30 +0000
Message-ID: <1f00032b-71f1-45ed-a8e4-2a7644c73d61@suse.cz>
Date: Wed, 17 Apr 2024 15:15:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Thorsten Leemhuis <linux@leemhuis.info>
Cc: helpdesk@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
 <20240417-lively-zebu-of-tact-efc8f3@lemur>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240417-lively-zebu-of-tact-efc8f3@lemur>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On 4/17/24 2:52 PM, Konstantin Ryabitsev wrote:
> On Wed, Apr 17, 2024 at 09:48:18AM +0200, Thorsten Leemhuis wrote:
>> Hi kernel.org helpdesk!
>> 
>> Could you please create the email alias
>> do-not-apply-to-stable@kernel.org which redirects all mail to /dev/null,
>> just like stable@kernel.org does?
>> 
>> That's an idea GregKH brought up a few days ago here:
>> https://lore.kernel.org/all/2024041123-earthling-primarily-4656@gregkh/
>> 
>> To quote:
>> 
>> > How about:
>> > 	cc: <do-not-apply-to-stable@kernel.org> # Reason goes here, and must be present
>> > 
>> > and we can make that address be routed to /dev/null just like
>> > <stable@kernel.org> is?
> 
> That would make it into actual commits and probably irk maintainers and 
> Linus, no? I also don't really love the idea of overloading email 
> addresses with additional semantics. Using Cc: stable kinda makes sense, 
> even if it's not a real email address (but it could become at some 
> point), but this feels different.
> 
> In general, I feel this information belongs in the patch basement (the 
> place where change-id, base-commit, etc goes). E.g.:
> 
>     stable-autosel: ignore
>     [This fix requires a feature that is only present in mainline]
> 
> This allows passing along structured information that can be parsed by 
> automated tooling without putting it into the commit.

But isn't it the actual commit what the stable tooling parses?

>> There was some discussion about using something shorter, but in the end
>> there was no strong opposition and the thread ended a a few days ago.
> 
> I feel this is a significant change to the workflow, so I would like the 
> workflows list to have another go at this topic. :)
> 
> -K
> 


