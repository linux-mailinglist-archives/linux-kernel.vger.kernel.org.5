Return-Path: <linux-kernel+bounces-110057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDA88596F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5061DB23105
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72783CDD;
	Thu, 21 Mar 2024 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eoVNRrd4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LFpWYcGw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eoVNRrd4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LFpWYcGw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B7134CD;
	Thu, 21 Mar 2024 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025536; cv=none; b=JdeWPcEfP4Wx5OOwM82HMlNQk3Sh6gdEpheizuHTntzT6v03X7hmec24TZLXdv7zbM+5Edbo1yZxNBtBXeex9iwvyDvWgHzRujgqG5EECztNbSbjqYvYDBjLS35CBaD5sbbo6sb9VnF8/0UVpqzetH3ObqEgP5saLA+rzlu61Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025536; c=relaxed/simple;
	bh=dFQnHdvjN+PdZaRydPaL5YzOnVbqxPf19LkEFEHeg70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lunPOsCXyrLUmS1tcLQxi2/e3CrfaT5SKzuvP+hRn8NjAtLVOHOApy033g36uVKnqYS/042qnf4WpwhVjrxyXRN2oMiDANYVhP5FT/ywUZfdrDQh4ZQXVo5Nbw0dbQDJL4/F+8gyxHqcHq524iqsZoyUp6msymUV36Taam8CjXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eoVNRrd4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LFpWYcGw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eoVNRrd4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LFpWYcGw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68B5A373B8;
	Thu, 21 Mar 2024 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711025532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diCeKBUDpUeOaEDHZJ+/O8iEUxC3MlV9oxExIu8D4cg=;
	b=eoVNRrd493B4kd4SgEFrTiFnhtXtfXH4QfaHq19hp2F9W/017zepPUlWvUCyv+CLJGFyvf
	TWUNjXNgBHy+5dXd22I1bL4zaAz4oSICy6BMYFHjDoZqXle5J5bQofjK2l6Ibw85p8IZhe
	VakJ63YYdJNzhF3i13AiV6d2L7qZT3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711025532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diCeKBUDpUeOaEDHZJ+/O8iEUxC3MlV9oxExIu8D4cg=;
	b=LFpWYcGwnvQABaHyDr3USzpnLGp/1HpgFX5uqxBY0aD9RiPl1y49qIR7K1wb6LfVALwaQR
	G+bn68nAIntgWPCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711025532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diCeKBUDpUeOaEDHZJ+/O8iEUxC3MlV9oxExIu8D4cg=;
	b=eoVNRrd493B4kd4SgEFrTiFnhtXtfXH4QfaHq19hp2F9W/017zepPUlWvUCyv+CLJGFyvf
	TWUNjXNgBHy+5dXd22I1bL4zaAz4oSICy6BMYFHjDoZqXle5J5bQofjK2l6Ibw85p8IZhe
	VakJ63YYdJNzhF3i13AiV6d2L7qZT3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711025532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=diCeKBUDpUeOaEDHZJ+/O8iEUxC3MlV9oxExIu8D4cg=;
	b=LFpWYcGwnvQABaHyDr3USzpnLGp/1HpgFX5uqxBY0aD9RiPl1y49qIR7K1wb6LfVALwaQR
	G+bn68nAIntgWPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99F1A136AD;
	Thu, 21 Mar 2024 12:52:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ib5vIXst/GXVTgAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Thu, 21 Mar 2024 12:52:11 +0000
Message-ID: <a8174c07-00c9-4a8e-9c2e-c2d759379f09@suse.de>
Date: Thu, 21 Mar 2024 15:52:10 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] flow_dissector: prevent NULL pointer dereference in
 __skb_flow_dissect
Content-Language: en-US
To: Anastasia Belova <abelova@astralinux.ru>,
 "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240321123446.7012-1-abelova@astralinux.ru>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <20240321123446.7012-1-abelova@astralinux.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eoVNRrd4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LFpWYcGw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.68%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[astralinux.ru:email,suse.de:dkim,linuxtesting.org:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.50
X-Rspamd-Queue-Id: 68B5A373B8
X-Spam-Flag: NO



On 3/21/24 15:34, Anastasia Belova wrote:
> skb is an optional parameter, so it may be NULL.
> Add check defore dereference in eth_hdr.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 690e36e726d0 ("net: Allow raw buffers to be passed into the flow dissector.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

As request in the previous email please show the actual data flow that leads to a null pointer
dereference.
Also please read function description:
..
 * @skb: sk_buff to extract the flow from, can be NULL if the rest are specified
..

> ---
>  net/core/flow_dissector.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> index 272f09251343..68a8228ffae3 100644
> --- a/net/core/flow_dissector.c
> +++ b/net/core/flow_dissector.c
> @@ -1139,6 +1139,8 @@ bool __skb_flow_dissect(const struct net *net,
>  
>  	if (dissector_uses_key(flow_dissector,
>  			       FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> +		if (!skb)
> +			goto out_bad;
>  		struct ethhdr *eth = eth_hdr(skb);
>  		struct flow_dissector_key_eth_addrs *key_eth_addrs;
>  

