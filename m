Return-Path: <linux-kernel+bounces-32968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C163836293
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA601F2912A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1AB3B79D;
	Mon, 22 Jan 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hkVyHtZs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vzaQ4ZjW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wTEmZEoP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qZ+o7gec"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B523B29D;
	Mon, 22 Jan 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924217; cv=none; b=RBZKDZEf0Pn1I0nWZs1/v2hXZ9qSsauonLhS7UDF0PoDzclIY6vwg9cJnfBUTfRZ4r9Il/C06FQ2r22QJGdyo3SW8oNZIr++c6KiAzbVeI81GO/iWTyUEMfSVmRXby6G/FK89drasLALGLzUoG3MsdamXi4Mbew1CgVewq45o94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924217; c=relaxed/simple;
	bh=ZoHlYs9JBv8+jjTA2+gz65BwpiMRWVkIsKYXrGdWIPQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOJAjJ2XGnpwDcI9A6ArsGqfg/yr70aX/t8P/truQ0jG9vHW0v1NfNUopQk7uX7e0jALcusA60j/g174pmKRGVZ3vSjEwj3WJuLcyLjaTMKle6s/qOiGbObKAdxTrp9Ruxrr6ciLKHI4J/YisK+kIXj0MkV32kb5X8DjkJ5PYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hkVyHtZs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vzaQ4ZjW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wTEmZEoP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qZ+o7gec; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 796E91FBB3;
	Mon, 22 Jan 2024 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705924213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MswQKcwjQrmv0UBX4o6XAXUbWeE3MQll8CxGSuZco2g=;
	b=hkVyHtZssdA2zvLJzLu4hBwKYy8HO6REEEBKPKXbO9QNZfEO0IV5TpZUirrjfu+bTKEGgP
	i9CjE0Z4V/qdjfWeQRf1oX/DFz4YCo20Z/NvaFkLWbmniOcapGQ+7F1dDqFgUUQswk1lKj
	C/JU/B/4TvVybqOwjuQLQ0zOaRQx2OY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705924213;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MswQKcwjQrmv0UBX4o6XAXUbWeE3MQll8CxGSuZco2g=;
	b=vzaQ4ZjW82x9QDqelAl+I+af1fIIGNQFIl373qQRLcH5xiuQl8ml9GXZOJo7GCNiVpw2Ia
	HhaK4cN0SyNvdQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705924212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MswQKcwjQrmv0UBX4o6XAXUbWeE3MQll8CxGSuZco2g=;
	b=wTEmZEoP5n1NOhxX/29CA27TsNrLDduDXl2+BygbtZOOiQxufIoUJpRZYWbZvz3+OYLQr9
	UBhh48BztLfO/ixE2SJqeV4zSsH2gJj5F1xlL1pYmfocgFjiryF1BYo9tzjwigFq6aoM33
	ssxVGbkxTP8MYWnOO/xyDLXI4CzOIcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705924212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MswQKcwjQrmv0UBX4o6XAXUbWeE3MQll8CxGSuZco2g=;
	b=qZ+o7gec+gASPm9cxhk3AxKnD9YMrdVHJngJLYN6JwxLribUPNezyUBt79NC2F4pCSpQz2
	g39C5zh8SFqXz+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09748139A2;
	Mon, 22 Jan 2024 11:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hcluOnNWrmUPIgAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 22 Jan 2024 11:50:11 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 4c05b0c9;
	Mon, 22 Jan 2024 11:50:11 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>,  "Eric Biggers"
 <ebiggers@kernel.org>,  <keyrings@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] keys: update key quotas in key_put()
In-Reply-To: <CYIZP2D9FS0N.1XY2F5VX9STEY@seitikki> (Jarkko Sakkinen's message
	of "Fri, 19 Jan 2024 21:10:15 +0000")
References: <2744563.1702303367@warthog.procyon.org.uk>
	<20240115120300.27606-1-lhenriques@suse.de>
	<CYIZP2D9FS0N.1XY2F5VX9STEY@seitikki>
Date: Mon, 22 Jan 2024 11:50:11 +0000
Message-ID: <87il3llh8s.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wTEmZEoP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qZ+o7gec
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[30.16%]
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 796E91FBB3
X-Spam-Flag: NO

"Jarkko Sakkinen" <jarkko@kernel.org> writes:

> On Mon Jan 15, 2024 at 12:03 PM UTC, Luis Henriques wrote:
>> Delaying key quotas update when key's refcount reaches 0 in key_put() has
>> been causing some issues in fscrypt testing.  This patches fixes this te=
st
>                                                 ~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
> 						This commit fixes the test
>
>> flakiness by dealing with the quotas immediately, but leaving all the ot=
her
>> clean-ups to the key garbage collector.  Unfortunately, this means that =
we
>> also need to switch to the irq-version of the spinlock that protects quo=
ta.
>
> The commit message fails to describe the implementation changes.
>
> You have a motivation paragraph but you also need to add implementation
> paragraph, which describes how the code changes reflect the motivation.

Thank you for your feedback, Jarkko.  I'll address your comments in v3.

But before sending another rev, I'll wait a bit more, maybe David also has
some feedback on the implementation.

Cheers,
--=20
Lu=C3=ADs

