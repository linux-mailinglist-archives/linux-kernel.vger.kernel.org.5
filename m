Return-Path: <linux-kernel+bounces-124986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42309891E85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6A6288303
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD81AF598;
	Fri, 29 Mar 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TX3tMM4/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MHu6ehBQ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499641509B2;
	Fri, 29 Mar 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716571; cv=none; b=WFNp0eh+Ox+2Ws1hU6lhcjTkBggS84PPHreImeVFYa4RXNNXEzD5rVSAbkdmb6wIh+0ArkDnA/WmPh8j6gTjEd5TiyFPlbdErEzfVvPvGNN5YfN/29s/gCFlaICBWf4PGmlQvWDaAbI1s5XEsL2oDbVrR5Y+nSAwWQjofgS4Fzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716571; c=relaxed/simple;
	bh=nXxhZPz8FVTyUJ4AlqPr2hJ9WUeCgGrDJRtsuIgYtB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDV8sYJYXjrsuuMNpifAbzR8aWW6QmKW2Dmna6/Ity0tNXMGscS2Mdnz/RLkrlnVSDzBzdqC+/ecloGgkPBoH+hSiOWh/QSEJ5gKDM+ZvVSGp7BRGOZv7uU4hzen2VIYCxxioN5tgnk0hxoDIEkYuYtte2fDq9lGJ67Yla+jAlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TX3tMM4/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MHu6ehBQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53A585C557;
	Fri, 29 Mar 2024 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711716562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQhqCkbcA983IXjy9mUlFe9v7QYAyJfImXhl/9lihME=;
	b=TX3tMM4/0DjXLSlOV6rNKv0mTwK6vHbYjCJUJIf+m141IiLAZgrLezUsm9IoMpVSxIqBpb
	Nw2FazFcE/0sfVCBYRf13AFTNNsTwDwJHU5O1lLiHXuXRXmEm0I1bC2psHoEYfnctfojY8
	AJ9qR4vx6Pf4NAWmIu8GiBRQklQxKjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711716562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQhqCkbcA983IXjy9mUlFe9v7QYAyJfImXhl/9lihME=;
	b=MHu6ehBQl41Fw65AwEvYTP7et0t4RxErT1i4Ng+Vbesf8KQTLSDzybkHgFdoaJLo8+9aXE
	IF6K0dNWhL/Su/Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A88D313A89;
	Fri, 29 Mar 2024 12:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZGB1ItC4BmaDRgAAn2gu4w
	(envelope-from <jdelvare@suse.de>); Fri, 29 Mar 2024 12:49:20 +0000
Date: Fri, 29 Mar 2024 13:49:17 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Arnd Bergmann <arnd@arndb.de>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH 05/12] firmware: dmi-id: add a release callback function
Message-ID: <20240329134917.579c3557@endymion.delvare>
In-Reply-To: <20240326145140.3257163-4-arnd@kernel.org>
References: <20240326144741.3094687-1-arnd@kernel.org>
	<20240326145140.3257163-4-arnd@kernel.org>
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
X-Rspamd-Queue-Id: 53A585C557
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_SHORT(-0.19)[-0.945];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_DKIM_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO

Hi Arnd,

On Tue, 26 Mar 2024 15:51:30 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> dmi_class uses kfree() as the .release function, but that now causes
> a warning with clang-16 as it violates control flow integrity (KCFI)
> rules:
> 
> drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>   174 |         .dev_release = (void(*)(struct device *)) kfree,
> 
> Add an explicit function to call kfree() instead.
> 
> Fixes: 4f5c791a850e ("DMI-based module autoloading")

Not sure if this fixes tag is really warranted. As I understand it,
your change only removes a warning but there was no actual bug, right?

> Link: https://lore.kernel.org/lkml/20240213100238.456912-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I sent this before but got no comments for it

I indeed overlooked your initial submission, my bad.

> ---
>  drivers/firmware/dmi-id.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
> index 5f3a3e913d28..d19c78a78ae3 100644
> --- a/drivers/firmware/dmi-id.c
> +++ b/drivers/firmware/dmi-id.c
> @@ -169,9 +169,14 @@ static int dmi_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
>  	return 0;
>  }
>  
> +static void dmi_dev_release(struct device *dev)
> +{
> +	kfree(dev);
> +}
> +
>  static struct class dmi_class = {
>  	.name = "dmi",
> -	.dev_release = (void(*)(struct device *)) kfree,
> +	.dev_release = dmi_dev_release,
>  	.dev_uevent = dmi_dev_uevent,
>  };
>  

Looks good to me, thanks for doing that.

Signed-off-by: Jean Delvare <jdelvare@suse.de>

Will you get this upstream, or do you expect me to take it in my
dmi/for-next branch?

-- 
Jean Delvare
SUSE L3 Support

