Return-Path: <linux-kernel+bounces-27312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4129A82EDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67EC71C2262C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168001B819;
	Tue, 16 Jan 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zmQhoFlq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDhEEcC9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zmQhoFlq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DDhEEcC9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5FE1B802;
	Tue, 16 Jan 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8574D220B7;
	Tue, 16 Jan 2024 11:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705404310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSBiH+yTEBlAi/Q9bljW1Nwb7seNsuvRpfrTD+9jL0=;
	b=zmQhoFlqoVmuaBYkdoSdAq7Qd45VGP/PlmSNbgynxgnN+bJj0FGvQ3013Y45Q+Do2IMOTj
	H+ziwDziJXwItL8xysjjdM34McoR8MYVthOlK3qSYbUXTxqvvECAN00uYV/eS9bqEQnggW
	5yYXVAhigUkVQji3fq79Svkuc2AF+Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705404310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSBiH+yTEBlAi/Q9bljW1Nwb7seNsuvRpfrTD+9jL0=;
	b=DDhEEcC92nFbxyWc0SFVtAcfp/p79368CyOriMeR1GG+7vtIS6wm4IuaT8t+1eTFvJ9rnS
	GrWkKMLlknf9MRDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705404310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSBiH+yTEBlAi/Q9bljW1Nwb7seNsuvRpfrTD+9jL0=;
	b=zmQhoFlqoVmuaBYkdoSdAq7Qd45VGP/PlmSNbgynxgnN+bJj0FGvQ3013Y45Q+Do2IMOTj
	H+ziwDziJXwItL8xysjjdM34McoR8MYVthOlK3qSYbUXTxqvvECAN00uYV/eS9bqEQnggW
	5yYXVAhigUkVQji3fq79Svkuc2AF+Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705404310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBSBiH+yTEBlAi/Q9bljW1Nwb7seNsuvRpfrTD+9jL0=;
	b=DDhEEcC92nFbxyWc0SFVtAcfp/p79368CyOriMeR1GG+7vtIS6wm4IuaT8t+1eTFvJ9rnS
	GrWkKMLlknf9MRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07883132FA;
	Tue, 16 Jan 2024 11:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nfMCOpVnpmV4OAAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Tue, 16 Jan 2024 11:25:09 +0000
Message-ID: <9feedeae-b14b-4e2e-b5b7-35f82357ce03@suse.de>
Date: Tue, 16 Jan 2024 14:25:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: add missing rx stats accounting in tun_xdp_act
Content-Language: en-US
To: Yunjian Wang <wangyunjian@huawei.com>, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, kuba@kernel.org, davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xudingke@huawei.com
References: <1705397780-11364-1-git-send-email-wangyunjian@huawei.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <1705397780-11364-1-git-send-email-wangyunjian@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zmQhoFlq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DDhEEcC9
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-0.00)[28.30%];
	 MID_RHS_MATCH_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[huawei.com,gmail.com,redhat.com,kernel.org,davemloft.net];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.20
X-Rspamd-Queue-Id: 8574D220B7
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +



On 1/16/24 12:36, Yunjian Wang wrote:
> There are few places on the receive path where packet receives and packet
> drops were not accounted for. This patch fixes that issue.
You've missed a "Fixes" tag
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/net/tun.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index afa5497f7c35..232e5319ac77 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1626,17 +1626,14 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		       struct xdp_buff *xdp, u32 act)
>  {
>  	int err;
> +	unsigned int datasize = xdp->data_end - xdp->data;
>  
>  	switch (act) {
>  	case XDP_REDIRECT:
>  		err = xdp_do_redirect(tun->dev, xdp, xdp_prog);
> -		if (err)
> -			return err;
>  		break;
>  	case XDP_TX:
>  		err = tun_xdp_tx(tun->dev, xdp);
> -		if (err < 0)
> -			return err;
>  		break;
>  	case XDP_PASS:
>  		break;
> @@ -1651,6 +1648,13 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
>  		break;
>  	}
>  
> +	if (err < 0) {
> +		act = err;
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +	} else if (act == XDP_REDIRECT || act == XDP_TX) {
> +		dev_sw_netstats_rx_add(tun->dev, datasize);
> +	}
> +
>  	return act;
>  }
>  

