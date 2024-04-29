Return-Path: <linux-kernel+bounces-162277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2658D8B58F7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E0D1F25E60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AE56B6C;
	Mon, 29 Apr 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UF7z2l4N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tc9ZF9Y6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UF7z2l4N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tc9ZF9Y6"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3910961
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394690; cv=none; b=RL7iy0E/8W2pFOVFiHk2Jf6zx0hV1ElphEuXgEIVdnuodPsTlrPutG8pehzIoPNwnj7l4l72SAAtkr6BQTVOVKT/kES+LjEFBHgBszgvAksxgoCrlYjHVO5U0ylxbH7KJpWVVjbdqlbgN+Y0qRcVlTvqXsEC0XlbhHDWolIg50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394690; c=relaxed/simple;
	bh=66rdI/GBqjiXeIs+U15w20lxYuu2e3aonXQoBWKEXi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhJgIjHUEiAXf/Tl0JdWlH9YxAGShrUGI+fbk8mov+7hwElVcNg0biE5rFaPC0PsbyHBMjNO+8QdrayuWjp91ghM2qhCCvVqv5nUa/4ZRD5KB0qxZTaXcZfsxkoIOc85PO3phyi9D6wLsJnZN4FjX0Qu8i/wRki6RYFZUxI9Zuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UF7z2l4N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tc9ZF9Y6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UF7z2l4N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tc9ZF9Y6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C15661F392;
	Mon, 29 Apr 2024 12:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714394686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTLiGH0LMrBU/hhsuu2ns8jPvm10lUVCaNgVvudddD0=;
	b=UF7z2l4NtotDO7ZgEYQzrr8elVdNG5n3EdQQWST3fm9EIDdwRW0/yn2MIKFg+VCsjDDdC1
	sOT/DgAPhlWiSOa9I3eXL+g+1i85Vbf2eFZdeASUCCWWFz20erUWxWXZjxiJGSu3+F5nLF
	zL/igR7x0ZpjKaGRJkrdr1ujuGOKrTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714394686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTLiGH0LMrBU/hhsuu2ns8jPvm10lUVCaNgVvudddD0=;
	b=tc9ZF9Y6jiUsc9o7HTdClS2470p1Cu9KSUVJSFexz49I7KQb5sbvzALulsVtYknFXacyGZ
	LvPe2NryhkW6n8AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UF7z2l4N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tc9ZF9Y6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714394686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTLiGH0LMrBU/hhsuu2ns8jPvm10lUVCaNgVvudddD0=;
	b=UF7z2l4NtotDO7ZgEYQzrr8elVdNG5n3EdQQWST3fm9EIDdwRW0/yn2MIKFg+VCsjDDdC1
	sOT/DgAPhlWiSOa9I3eXL+g+1i85Vbf2eFZdeASUCCWWFz20erUWxWXZjxiJGSu3+F5nLF
	zL/igR7x0ZpjKaGRJkrdr1ujuGOKrTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714394686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTLiGH0LMrBU/hhsuu2ns8jPvm10lUVCaNgVvudddD0=;
	b=tc9ZF9Y6jiUsc9o7HTdClS2470p1Cu9KSUVJSFexz49I7KQb5sbvzALulsVtYknFXacyGZ
	LvPe2NryhkW6n8AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D16E138A7;
	Mon, 29 Apr 2024 12:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /tEIDD6WL2bDYgAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Mon, 29 Apr 2024 12:44:46 +0000
Date: Mon, 29 Apr 2024 14:44:42 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: dmi: Change size of dmi_ids_string[] to 256
Message-ID: <20240429144442.472aa83c@endymion.delvare>
In-Reply-To: <1677030901-29326-1-git-send-email-yangtiezhu@loongson.cn>
References: <1677030901-29326-1-git-send-email-yangtiezhu@loongson.cn>
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
X-Spam-Flag: NO
X-Spam-Score: -2.43
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C15661F392
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.43 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.92)[86.23%];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

Hi Tiezhu,

Sorry for the very late answer, somehow your messages slipped through
the cracks.

On Wed, 22 Feb 2023 09:55:01 +0800, Tiezhu Yang wrote:
> The current size of dmi_ids_string[] is 128, the BIOS date
> can not be seen if the total string length of system vendor,
> product name, board name, BIOS version and BIOS date is too
> long to over 128, it is better and enough to change size of
> dmi_ids_string[] to 256 for most cases.

In order to convince me that the size of this buffer needs to be
increased, one would have to provide a real world example with valid
DMI data where the output doesn't fit. However...

> Without this patch:
> 
> [    0.000000] DMI: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/202
> 
> With this patch:
> 
> [    0.000000] DMI: Loongson Loongson-3A5000-7A1000-1w-A2101/Loongson-LS3A5000-7A1000-1w-A2101, BIOS vUDK2018-LoongArch-V4.0.05132-beta10 12/13/2022

This example is apparently taken from an engineering sample with rather
"low quality" strings or invalid string indexes. Specifically:
* The product name and the board name are the exact same string.
* Both duplicate the system vendor name ("Loongson").
* The BIOS version includes the architecture name "LoongArch", which
  seems unnecessarily verbose.

So my feeling is that the issue would be better addressed by fixing the
DMI data of your board than increasing the buffer size.

Do you have any production-grade DMI table with proper strings where
the buffer is still not large enough?

-- 
Jean Delvare
SUSE L3 Support

