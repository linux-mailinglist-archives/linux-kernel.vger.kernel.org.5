Return-Path: <linux-kernel+bounces-62313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D457851E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01441C22F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB15495E0;
	Mon, 12 Feb 2024 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sNnau+QL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fjUwV0tV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sNnau+QL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fjUwV0tV"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C648781;
	Mon, 12 Feb 2024 20:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768420; cv=none; b=JnB5rfDVOK4OnNhxH2GHylnuRGyby1OwmQaMgGLcDflE/ug3Vb5GKBj8EE6j4BTYyqETQg/vowjd8G8bSNnxYAazqVCHSXaMG1kAq3xVuqTTXdBbpAWumwbno9K+B2BZpB3LapEjv6ecTdygwOqvrw5zCz5E9dctoELjW0d6aWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768420; c=relaxed/simple;
	bh=Nt88AUFglM06Jo2ul/GnPEOPNXHRfhtjV787XERwHBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ymqnfw51pTbhvATakzzSAYLjCJMsPARSXkkSjFekq1CQbgJIejorkkZBPQcmHXBRQ8BZT3v5ampcFcc29DEic0cqHwEqrECdwhEFPb9aVSlWnPJO4w3XiIMESqOcRJ9AaTBAHJSzOEV4Ov8dagzKrSqxkpVBSgc3Cs174xupb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sNnau+QL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fjUwV0tV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sNnau+QL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fjUwV0tV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 916361F791;
	Mon, 12 Feb 2024 20:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707768413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvxGnr3h6gtXXF2GHQTlOkQhuNrBkAuMe0u4TbhQtvE=;
	b=sNnau+QLS6x0g0AO/00pxh7CAH8HuLzpX0z1HnqJhx3Z0Y/xf/Bg0fm46D2N6eSbiM7bVV
	VbTy4NHY+bTfPTXxxG4yWJzKF2MemnD5oPCS1Bd/oV31tpD9pfoukiF2gvSQGd0Li+exp4
	fhB6nFFR4PkLQf/b3tB5nlHPjWzPRJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707768413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvxGnr3h6gtXXF2GHQTlOkQhuNrBkAuMe0u4TbhQtvE=;
	b=fjUwV0tVboYnJx9a0rzegEWfn7XR9pDkeIfgaCqmL59PmfSN8h4EtMZWdSeFZIpy5O8O9O
	bvfUhkqFhHbqZeCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707768413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvxGnr3h6gtXXF2GHQTlOkQhuNrBkAuMe0u4TbhQtvE=;
	b=sNnau+QLS6x0g0AO/00pxh7CAH8HuLzpX0z1HnqJhx3Z0Y/xf/Bg0fm46D2N6eSbiM7bVV
	VbTy4NHY+bTfPTXxxG4yWJzKF2MemnD5oPCS1Bd/oV31tpD9pfoukiF2gvSQGd0Li+exp4
	fhB6nFFR4PkLQf/b3tB5nlHPjWzPRJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707768413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvxGnr3h6gtXXF2GHQTlOkQhuNrBkAuMe0u4TbhQtvE=;
	b=fjUwV0tVboYnJx9a0rzegEWfn7XR9pDkeIfgaCqmL59PmfSN8h4EtMZWdSeFZIpy5O8O9O
	bvfUhkqFhHbqZeCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FDC613404;
	Mon, 12 Feb 2024 20:06:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3D3yF1x6ymWIJwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 12 Feb 2024 20:06:52 +0000
Date: Mon, 12 Feb 2024 21:06:46 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Anjelique
 Melendez <quic_amelende@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: qcom-lpg: add QCOM_PBS dependency
Message-ID: <20240212210646.7175bc84@endymion.delvare>
In-Reply-To: <20240212111526.829122-1-arnd@kernel.org>
References: <20240212111526.829122-1-arnd@kernel.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sNnau+QL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fjUwV0tV
X-Spamd-Result: default: False [-2.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 HAS_ORG_HEADER(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 916361F791
X-Spam-Level: 
X-Spam-Score: -2.31
X-Spam-Flag: NO

On Mon, 12 Feb 2024 12:15:02 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The lpg driver fails to link now when the pbs driver is in a loadable module:
> 
> x86_64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `lpg_brightness_set':
> leds-qcom-lpg.c:(.text+0xe7f): undefined reference to `qcom_pbs_trigger_event'
> x86_64-linux-ld: drivers/leds/rgb/leds-qcom-lpg.o: in function `lpg_probe':
> leds-qcom-lpg.c:(.text+0x16a5): undefined reference to `get_pbs_client_device'
> 
> Add a dependency to avoid the broken configuration. Apparently there is still
> a use for lpg with pbs disabled entirely for certain chips, so allow both
> but not LEDS_QCOM_LPG=y with QCOM_PBS=m.
> 
> Fixes: 214110175679 ("leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/leds/rgb/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index e66bd21b9852..eaeafdd5eaae 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -41,6 +41,7 @@ config LEDS_QCOM_LPG
>  	tristate "LED support for Qualcomm LPG"
>  	depends on OF
>  	depends on PWM
> +	depends on QCOM_PBS || !QCOM_PBS
>  	depends on SPMI
>  	help
>  	  This option enables support for the Light Pulse Generator found in a

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

