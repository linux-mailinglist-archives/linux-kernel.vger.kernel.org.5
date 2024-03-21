Return-Path: <linux-kernel+bounces-109977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE71885878
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0741C218FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E0B59151;
	Thu, 21 Mar 2024 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GBGnGY7Y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u3XlXb9O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vhZWhXi5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQK9qFSQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF6E5FB81;
	Thu, 21 Mar 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711021179; cv=none; b=FyUEC4ilJl77qqEZDyTsugaG/dRaIZJz2W05400rSoCp+vfLSpYT2yE5QZU6xwsHAs3vZoxQq4Q0CtpBBHd4o8lQl9jnGR6SbMqe8LwQ8Gwjv98tipxNScImSCE2ahMs3LShtO9jQRvsGpUJh17AaN4ZiMQGKG+1I8URNKdMpkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711021179; c=relaxed/simple;
	bh=vJ791anuvB8t8GIBHGJ8C+s5alJbeJIp7vc6EwMHfHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hx+50jfwboYhQ0vrV0vlCqA33JbNGOdJjwturI2dohw+BnMJNHKAns8Z12argLEUPxfkzmc6PEwa/e/ZsDVQ7H9I8dNLj1Enjtwt9JS1MtxIprKsbvrzmPHUC6y8EJCwdlEUP52/8oAZ/COhDqRIEPoZB+dDalKUizGT20nSTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GBGnGY7Y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u3XlXb9O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vhZWhXi5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQK9qFSQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A7A2372E0;
	Thu, 21 Mar 2024 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711021176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1EI9gkxhBA49ptnSU9hxPOI/RB588le3UPlmmKJ3rY=;
	b=GBGnGY7YmVNzKjUpQrAPaWZrciK0LYPg2kT//oFbBuL8o3U9rgDc0xDj+MkQVOiRMmkYfN
	DA6nFE2BX/BiVXZ8DKn7KObHa4anY/gosL0Ihtr2k1X/hgtjePDni2xfOwaH7gBraUD1XK
	33FxdT0WNbO/G4d3LbBkercelQy0tMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711021176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1EI9gkxhBA49ptnSU9hxPOI/RB588le3UPlmmKJ3rY=;
	b=u3XlXb9OrP1RAIoOVdkUVBEdfPvJVuhGO8+45th6e8EyRQIq0ozIn5aEahlodiSO1uKJcq
	XK0XBkT2OFBeqKAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711021174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1EI9gkxhBA49ptnSU9hxPOI/RB588le3UPlmmKJ3rY=;
	b=vhZWhXi5BW4nPtTRBB7Ua1bTCDfez63fP5zFmO51UtrOn1yJm5t4YjAhkCo1i4MFhpanw6
	nm1i4kZ3vegyxFKzBecv8WBHUO6xMdspH0p6Rb0/hXN2s7RnG5hWgI4QCmd1aCvsFtA2+E
	Py6e7nmShVxWdsAuK98akIVew4T6iac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711021174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1EI9gkxhBA49ptnSU9hxPOI/RB588le3UPlmmKJ3rY=;
	b=hQK9qFSQiirubEaPqhnMpJy6YUSZGkp7w/Ma5/X5Gjg0LY/5PdsjJKX+91nlsaZwH2pPPR
	CDmNjIFK0B+cKBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA95313976;
	Thu, 21 Mar 2024 11:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3AYALnUc/GXJNQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 21 Mar 2024 11:39:33 +0000
Message-ID: <01390102-200d-4d5d-9982-d7f93c8f950b@suse.de>
Date: Thu, 21 Mar 2024 14:39:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, Anastasia Belova <abelova@astralinux.ru>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240320125635.1444-1-abelova@astralinux.ru>
 <Zfrmv4u0tVcYGS5n@nanopsycho>
 <b67f3efb-509e-4280-90f2-729d217c20c7@astralinux.ru>
 <ZfwSmlZ-Ie1dFlue@nanopsycho>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <ZfwSmlZ-Ie1dFlue@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.25
X-Spamd-Result: default: False [-4.25 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.16)[-0.789];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO



On 3/21/24 13:57, Jiri Pirko wrote:
> Thu, Mar 21, 2024 at 10:36:53AM CET, abelova@astralinux.ru wrote:
>>
>>
>> 20/03/24 16:38, Jiri Pirko пишет:
>>> Wed, Mar 20, 2024 at 01:56:35PM CET, abelova@astralinux.ru wrote:
>>>> skb is an optional parameter, so it may be NULL.
>>>> Add check defore dereference in eth_hdr.
>>>>
>>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>> Either drop this line which provides no value, or attach a link to the
>>> actual report.
>>>
>>
>> It is an established practice for our project. You can find 700+ applied
>> patches with similar line:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=linuxtesting.org
> 
> Okay. So would it be possible to attach a link to the actual report?
> 
>>
>>
>>>> Fixes: 67a900cc0436 ("flow_dissector: introduce support for Ethernet addresses")
>>> This looks incorrect. I believe that this is the offending commit:
>>> commit 690e36e726d00d2528bc569809048adf61550d80
>>> Author: David S. Miller <davem@davemloft.net>
>>> Date:   Sat Aug 23 12:13:41 2014 -0700
>>>
>>>      net: Allow raw buffers to be passed into the flow dissector.
>>>
>>
>> Got it.

Looks like it's a static checker, there is no actual bug report or kernel oops/crash 

>>
>>>
>>>> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
>>>> ---
>>>> net/core/flow_dissector.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
>>>> index 272f09251343..05db3a8aa771 100644
>>>> --- a/net/core/flow_dissector.c
>>>> +++ b/net/core/flow_dissector.c
>>>> @@ -1137,7 +1137,7 @@ bool __skb_flow_dissect(const struct net *net,
>>>> 		rcu_read_unlock();
>>>> 	}
>>>>
>>>> -	if (dissector_uses_key(flow_dissector,
>>>> +	if (skb && dissector_uses_key(flow_dissector,
>>>> 			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
>>>> 		struct ethhdr *eth = eth_hdr(skb);
>>>> 		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>>> Looks like FLOW_DISSECT_RET_OUT_BAD should be returned in case the
>>> FLOW_DISSECTOR_KEY_ETH_ADDRS are selected and there is no skb, no?
>>
>> I agree, I'll send the second version.
>>
>> Anastasia Belova
>>
> 

