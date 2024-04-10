Return-Path: <linux-kernel+bounces-138469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A226E89F1AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591762824BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815215B120;
	Wed, 10 Apr 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MWvIQLTw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LcV4U1kh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MWvIQLTw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LcV4U1kh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6829115B101
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712750751; cv=none; b=T0vmofa/YfUy1SZARpEHKhukl55zjM716/3L8J94fjOIqJQiHssANGxS6jsGK/moH9d+oXI79x/tdo0TF6G1/HvQ3dFqfUrsnbEJ5hiwJxzdOIkDRDVHRD7fu9cAFAbKfzbLWcjabOMPNtcFkMMS+grvt6xz/AV4Xd8sW5toMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712750751; c=relaxed/simple;
	bh=IRoQxzWCLqtj/7lhYO8vSucfMlHPAp/f+Ht5jdThyU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWTbhaTC9qeBc4aoc6izd/DPNxdk6DBIGUbCt3rG1/4TKTH0F6PBMjJJ4Ud3VNMECSv4AZPWY0omBFP9Ie+1vZkqCKHUJC+n76gOHxJ8uTjqX5CxTGjovDs9fjZt7I1c0hVHdLnzx6bs7NYvAR+4Vzw6usQ/mOwAuhsgChUDTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MWvIQLTw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LcV4U1kh; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MWvIQLTw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LcV4U1kh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A3FF350AF;
	Wed, 10 Apr 2024 12:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712750747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=MWvIQLTwbXcgNFmRvHLmwIeXh898YX/cEHNWnqllD3GJUwCXNDFoDWltNUogOkQwRQTmQp
	4tLsWFihoU9rnG79zun4pj458HCjHZjAqGoNcmkH1YhkWFE3BviTl9spP9PcaSnRUQHyct
	R/nPE/2O40QqXJ+BU9Z75RZsadwejk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712750747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=LcV4U1khzrJcHGDdKsndPqNQnNpqBGsbCVkr5UDh0rOhPkhLhWt4BV6MpZ92iDSxejYgEI
	8N0vNLoQ5X9VFlAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712750747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=MWvIQLTwbXcgNFmRvHLmwIeXh898YX/cEHNWnqllD3GJUwCXNDFoDWltNUogOkQwRQTmQp
	4tLsWFihoU9rnG79zun4pj458HCjHZjAqGoNcmkH1YhkWFE3BviTl9spP9PcaSnRUQHyct
	R/nPE/2O40QqXJ+BU9Z75RZsadwejk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712750747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgokGGCMRQZ2/pQzN/0fCVBWcbfteqrOIQNsSM08sgQ=;
	b=LcV4U1khzrJcHGDdKsndPqNQnNpqBGsbCVkr5UDh0rOhPkhLhWt4BV6MpZ92iDSxejYgEI
	8N0vNLoQ5X9VFlAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 611D513691;
	Wed, 10 Apr 2024 12:05:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hbs0FJuAFmawdwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Apr 2024 12:05:47 +0000
Message-ID: <03370383-d8d1-4b43-89f4-e9a3985c96e9@suse.de>
Date: Wed, 10 Apr 2024 14:05:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] nvme: authentication error are always
 non-retryable
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-2-dwagner@suse.de>
 <ac48d955-8169-467d-962c-e7f55854ba06@grimberg.me>
 <7jqbhmskuzfvpjlavk7oqefmc72m5j2wj7525c7y2vlsfnaajx@57pfbmfvf4kt>
 <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8c9a980f-4885-479c-9078-7f87dc92175c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email]

On 4/10/24 12:21, Sagi Grimberg wrote:
> 
> 
> On 10/04/2024 9:52, Daniel Wagner wrote:
>> On Tue, Apr 09, 2024 at 11:26:00PM +0300, Sagi Grimberg wrote:
>>>
>>> On 09/04/2024 12:35, Daniel Wagner wrote:
>>>> From: Hannes Reinecke <hare@suse.de>
>>>>
>>>> Any authentication errors which are generated internally are always
>>>> non-retryable, so use negative error codes to ensure they are not
>>>> retried.
>>> The patch title says that any authentication error is not retryable, and
>>> the patch body says "authentication errors which are generated locally
>>> are non-retryable" so which one is it?
>> Forgot to update the commit message. What about:
>>
>>    All authentication errors are non-retryable, so use negative error
>>    codes to ensure they are not retried.
>>
>> ?
> 
> I have a question, what happens if nvmet updated its credentials (by the 
> admin) and in the period until the host got his credentials updated, it
> happens to disconnect/reconnect. It will see an authentication
> error, so it will not retry and remove the controller altogether?
> 
> Sounds like an issue to me.

Usual thing: we cannot differentiate (on the host side) whether the
current PSK is _about_ to be replaced; how should the kernel
know that the admin will replace the PSK in the next minutes?

But that really is an issue with the standard. Currently there is no
way how a target could inform the initiator that the credentials have
been updated.

We would need to define a new status code for this.
In the meantime the safe operations model is to set a lifetime
for each PSK, and ensure that the PSK is updated on both sides
during the lifetime. With that there is a timeframe during which
both PSKs are available (on the target), and the older will expire
automatically once the lifetime limit is reached.

Cheers,

Hannes


