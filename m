Return-Path: <linux-kernel+bounces-167494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E3D8BAA62
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818721C22118
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EA414F9E1;
	Fri,  3 May 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UDz22OGC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WlZlfme+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UDz22OGC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WlZlfme+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238E714F9D6
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730196; cv=none; b=liJ8aaXEq5XRM+mCmkBANwtFCyOVM69oncw3LLsOTuRXETXj6Q4QGDcgYpZ0KJkh56L+JEHOyhbMCbyEaBZKZwpvcPBFnA8JrKYvvfL2ccr1voq+PhbkusaYvoLC/ll//4rgM5f/w5sZ7AoD4AaYvtlIAn7IVfd+rGCRyEGD2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730196; c=relaxed/simple;
	bh=8AGEhTMiYOobEPnPXSlOy2Iliwm8S+Fjp0/zZG0xTsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hspv6cC8k92KMzFjd9EozZKbl+mGKbc2rDurcq5JjNKULEaRlCjeH+UQAAslNCGx7PC6xRNIGaTWxTA2iED/IrhcRPDgtq+/QuqJBBUCUY9Nn7nJk5H/n91L9velrfqWz7YGfWyKprlZNScQDAT7yKosDMQz+B18V1XVzZDYYG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UDz22OGC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WlZlfme+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UDz22OGC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WlZlfme+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6701E2007F;
	Fri,  3 May 2024 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714730193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIG9slMCyHLfBKKaW+7Uev1fv1j+U80XAyAPuHSiT3A=;
	b=UDz22OGC/zAQQiaot+jIiQhUWv15+kZz0dTXsGCR10z0H2Yr0WYej5qOp2UFVcwCk+fcmS
	p+IUJGHNc92QP7a6ZauNtvhTrnpEHddSVLdlaDtfUOJa+i1AyIyO6Tnx4W0XQc885UoxPg
	fDjJ7Xz+zT+s5AbP6rYduAvtWiAOyME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714730193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIG9slMCyHLfBKKaW+7Uev1fv1j+U80XAyAPuHSiT3A=;
	b=WlZlfme+eWD7nrt63Ts1gnsV6AUylkCuGW9vm7dt9vnQXmjCZHTx7Ot32eP5YkAmlh9PKm
	AKepehcuwnjMnlBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714730193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIG9slMCyHLfBKKaW+7Uev1fv1j+U80XAyAPuHSiT3A=;
	b=UDz22OGC/zAQQiaot+jIiQhUWv15+kZz0dTXsGCR10z0H2Yr0WYej5qOp2UFVcwCk+fcmS
	p+IUJGHNc92QP7a6ZauNtvhTrnpEHddSVLdlaDtfUOJa+i1AyIyO6Tnx4W0XQc885UoxPg
	fDjJ7Xz+zT+s5AbP6rYduAvtWiAOyME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714730193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XIG9slMCyHLfBKKaW+7Uev1fv1j+U80XAyAPuHSiT3A=;
	b=WlZlfme+eWD7nrt63Ts1gnsV6AUylkCuGW9vm7dt9vnQXmjCZHTx7Ot32eP5YkAmlh9PKm
	AKepehcuwnjMnlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9876139CB;
	Fri,  3 May 2024 09:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AyY7MtC0NGYyOwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Fri, 03 May 2024 09:56:32 +0000
Date: Fri, 3 May 2024 11:56:30 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: dmi: Change size of dmi_ids_string[] to 256
Message-ID: <20240503115630.520b2de2@endymion.delvare>
In-Reply-To: <3283ce46-86d8-ff87-440e-ee9811c9e77a@loongson.cn>
References: <1677030901-29326-1-git-send-email-yangtiezhu@loongson.cn>
	<20240429144442.472aa83c@endymion.delvare>
	<3283ce46-86d8-ff87-440e-ee9811c9e77a@loongson.cn>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-1.41 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	BAYES_HAM(-0.11)[66.09%];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -1.41
X-Spam-Flag: NO

On Tue, 30 Apr 2024 22:49:46 +0800, Tiezhu Yang wrote:
> I did not find the string length of system vendor, product name,
> board name, BIOS version and BIOS date in the spec, I only see
> "There is no limit on the length of each individual text string."
> in "6.1.3 Text strings", so it may be better to increase the size
> to avoid the potential problems in theory at least.

There is indeed no limit to individual string length, nor to the total
length of the string section of a DMI table entry. The only limit is
for the overall table, and that theoretical limit is 4 GB. This isn't a
reasonable size for dmi_ids_string[].

This is the reason why the size of dmi_ids_string[] is based on
real-world samples and I will only increase it if a production-grade
product has strings which do not fit within the current limit.

Note that nothing really bad will happen when the strings do not fit,
they will be simply clipped to the buffer size, and the same data can
be retrieved from sysfs or using the dmidecode user-space tool. So
there's no compelling reason to increase the buffer size in advance.

-- 
Jean Delvare
SUSE L3 Support

