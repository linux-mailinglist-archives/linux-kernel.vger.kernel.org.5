Return-Path: <linux-kernel+bounces-83577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC536869BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFE71C22C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE914830C;
	Tue, 27 Feb 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qBfsTw1Q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qBfsTw1Q"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC771482E3;
	Tue, 27 Feb 2024 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050420; cv=none; b=Nw4pZnDLxM/ued3Jla4ylvi9CKhe8RNrrI0w6o/p+TPJAosdu0sIjPf5ECMSTKPW2FAKQW8JFXuRUbUkLV1Tkq0rDx+2lN++DLsJ7DizMsa3jvh7+JAHCti4/lC/9AgwSwtoFVymqdO/pLfj8g6dllLc6u8zqpLZESfJjAnxbtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050420; c=relaxed/simple;
	bh=hH5VZDTaPA7gWWcOU5gFYjv9mGjEw76o5Pk8eeaddms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBHrcLDza/b0xWk3YVVjdgCczVUVK8Q4xduuqqVvrovgeTQD6ii+OWTld26G5u3jVcDRAdyM0fkupllgunzT5zyKaGpCzXRnqwd5IhBOJ9nXwt833PrwGgnaPRSmdxD763ATB7sXJgy6mUEg8BGI+jof1qUE67yj0jXAopU7bUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qBfsTw1Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qBfsTw1Q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F61E2273B;
	Tue, 27 Feb 2024 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709050416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+xJjudoH6jIHZHOuTHOKtgzEe1Mf8dOrRQLijDGuVc=;
	b=qBfsTw1Q5zB2ayQcnXO7lPOxCV0yX6aTYYma+wP3KEUgH9JHHO7uwMxxSBSZUFzsvIlq7K
	ax/vWnKzyCjbtPAfk2JyRi5Q2kRYUymCt/D0gWk06QYeCsdxUSv8yAB5IN8wkjY0ylWgaP
	R9IToFgnOtR1ptvGbmzYOyi+cpo5umQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709050416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W+xJjudoH6jIHZHOuTHOKtgzEe1Mf8dOrRQLijDGuVc=;
	b=qBfsTw1Q5zB2ayQcnXO7lPOxCV0yX6aTYYma+wP3KEUgH9JHHO7uwMxxSBSZUFzsvIlq7K
	ax/vWnKzyCjbtPAfk2JyRi5Q2kRYUymCt/D0gWk06QYeCsdxUSv8yAB5IN8wkjY0ylWgaP
	R9IToFgnOtR1ptvGbmzYOyi+cpo5umQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE42F13A65;
	Tue, 27 Feb 2024 16:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oi3FMC8K3mU+WAAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 27 Feb 2024 16:13:35 +0000
Message-ID: <0443c7c2-1c3f-4cf8-940d-88306956832a@suse.com>
Date: Tue, 27 Feb 2024 17:13:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
Cc: Guixiong Wei <guixiongwei@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tony Luck <tony.luck@intel.com>,
 Kristen Carlson Accardi <kristen@linux.intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Guixiong Wei <weiguixiong@bytedance.com>, Jann Horn <jannh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexey Dobriyan <adobriyan@gmail.com>, Chris Wright <chrisw@sous-sol.org>,
 Jeremy Fitzhardinge <jeremy@xensource.com>,
 Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240222171840.work.027-kees@kernel.org>
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240222171840.work.027-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.18 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,infradead.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.91)[subject];
	 FREEMAIL_CC(0.00)[gmail.com,linutronix.de,redhat.com,linux.intel.com,kernel.org,zytor.com,infradead.org,linuxfoundation.org,intel.com,oracle.com,epam.com,bytedance.com,google.com,linux-foundation.org,sous-sol.org,xensource.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.18

On 22.02.24 18:18, Kees Cook wrote:
> When building with CONFIG_XEN_PV=y, .text symbols are emitted into the
> .notes section so that Xen can find the "startup_xen" entry point. This
> information is used prior to booting the kernel, so relocations are not
> useful. In fact, performing relocations against the .notes section means
> that the KASLR base is exposed since /sys/kernel/notes is world-readable.
> 
> To avoid leaking the KASLR base without breaking unprivileged tools that
> are expecting to read /sys/kernel/notes, skip performing relocations in
> the .notes section. The values readable in .notes are then identical to
> those found in System.map.
> 
> Reported-by: Guixiong Wei <guixiongwei@gmail.com>
> Closes: https://lore.kernel.org/all/20240218073501.54555-1-guixiongwei@gmail.com/
> Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
> Fixes: da1a679cde9b ("Add /sys/kernel/notes")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
> Cc: "Jürgen Groß" <jgross@suse.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Guixiong Wei <weiguixiong@bytedance.com>
> Cc: Jann Horn <jannh@google.com>
> ---
>   arch/x86/tools/relocs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index a3bae2b24626..0811fff23b9c 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -733,6 +733,16 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
>   		if (sec->shdr.sh_type != SHT_REL_TYPE) {
>   			continue;
>   		}
> +
> +		/*
> +		 * Do not perform relocations in .notes section; any
> +		 * values there are meant for pre-boot consumption (e.g.
> +		 * startup_xen).
> +		 */
> +		if (strcmp(sec_name(sec->shdr.sh_info), ".notes") == 0) {

Instead of a strcmp(), wouldnt't ...

> +			continue;
> +		}
> +
>   		sec_symtab  = sec->link;
>   		sec_applies = &secs[sec->shdr.sh_info];
>   		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {

.. a test of "sec_applies->shdr.sh_type == SHT_NOTE" work as well?

In the end I'm fine with both variants, so:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen

