Return-Path: <linux-kernel+bounces-117781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C44AE88AF84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FCA1C3C8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27518E25;
	Mon, 25 Mar 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AL8Kf1X5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZCxvoj1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AL8Kf1X5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZCxvoj1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49045125D5;
	Mon, 25 Mar 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393970; cv=none; b=s3/HQ/RYFDY+Bmvl7Wh2wKBU6bQuoxfUgSAL1lrCsr6IzBDEsh6VmdpYBIGX5BdZS3JfNh/gYCJyx/jR5adlQiQtjzYOXf7OiB905tQH0vklp2xjTtBV9+fyeK6D6lIikdfDy10bdnkLBesJhKXT8Vi7KQdJzAFXQ6OZnoblvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393970; c=relaxed/simple;
	bh=5YofjHhQd84JC8ExqA0FU+vMotkFNia4E/YVr5/G6U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+YYfBvjaUnYG7xTOMF1w8RVE+HcnDWV+2QqG2za36wWFcOOyWrArDLQ2nUEhBVyPpbBWVKe7BfA0IeU62NXrqHU7YCF4FQZ0OWOBdjuujG44ieTPgceMx8Y8H9sv6Hi9Vi2/y2QU4VYz4k5UWEYkAFMvY0/uXyLi8/E0dxk/3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AL8Kf1X5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZCxvoj1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AL8Kf1X5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZCxvoj1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 86C822227C;
	Mon, 25 Mar 2024 19:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711393966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv6lDzyyCtkE4zay8240/H88oSDu1T9Fy0kgOmNLNOQ=;
	b=AL8Kf1X57IWHbMpzJJmuG99Z6/KwsY1x+bXhLclV1oy7k10IBBtiAJAFPjzAFjePwe9Kkx
	PFA24ilLVUX0o+YnSfk2eK9cpNWdkB3CAnm0mEs/fRQV6owkZ3JixAVTxLg5PeoR5o+bJ6
	P635D7Qg+7gWh59oGBPRDGJUI0qxF/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711393966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv6lDzyyCtkE4zay8240/H88oSDu1T9Fy0kgOmNLNOQ=;
	b=TZCxvoj1/DPH1ruaZ/E1/kJqJjkmAP7wF9adU/aMrvSlDNJXFaJ9Cv+SXIQsLd0hy7RYm8
	u94WDZlBvoE2jKBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711393966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv6lDzyyCtkE4zay8240/H88oSDu1T9Fy0kgOmNLNOQ=;
	b=AL8Kf1X57IWHbMpzJJmuG99Z6/KwsY1x+bXhLclV1oy7k10IBBtiAJAFPjzAFjePwe9Kkx
	PFA24ilLVUX0o+YnSfk2eK9cpNWdkB3CAnm0mEs/fRQV6owkZ3JixAVTxLg5PeoR5o+bJ6
	P635D7Qg+7gWh59oGBPRDGJUI0qxF/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711393966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sv6lDzyyCtkE4zay8240/H88oSDu1T9Fy0kgOmNLNOQ=;
	b=TZCxvoj1/DPH1ruaZ/E1/kJqJjkmAP7wF9adU/aMrvSlDNJXFaJ9Cv+SXIQsLd0hy7RYm8
	u94WDZlBvoE2jKBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D35013A2E;
	Mon, 25 Mar 2024 19:12:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2ruHHq7MAWbRZgAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 25 Mar 2024 19:12:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 36C3CA0812; Mon, 25 Mar 2024 20:12:42 +0100 (CET)
Date: Mon, 25 Mar 2024 20:12:42 +0100
From: Jan Kara <jack@suse.cz>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jan Kara <jack@suse.com>, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] udf: Remove second semicolon
Message-ID: <20240325191242.3r6onuxvk3bqcxzs@quack3>
References: <20240315091949.2430585-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315091949.2430585-1-colin.i.king@gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.81
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[46.17%]
X-Spam-Flag: NO

On Fri 15-03-24 09:19:49, Colin Ian King wrote:
> There is a statement with two semicolons. Remove the second one, it
> is redundant.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/udf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 2217f7ed7a49..ba6b747a3830 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -630,7 +630,7 @@ static int udf_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			if (!uopt->nls_map) {
>  				errorf(fc, "iocharset %s not found",
>  					param->string);
> -				return -EINVAL;;
> +				return -EINVAL;
>  			}
>  		}
>  		break;
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

