Return-Path: <linux-kernel+bounces-59933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B184FD82
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71D651C21E69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B211272A4;
	Fri,  9 Feb 2024 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xOQiJ839";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h8ivNr7Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O56OvfeW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3iMP0oPR"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117B2E632;
	Fri,  9 Feb 2024 20:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510256; cv=none; b=tMsTbd8V3BelL9tG3N7N0fyP1wocif2ZS1Rj22cxvEKTKaI/yNp92fiqmu7LHg4k7pWOV2PoZ4w7m69pF3YnxXdJt7pXawW538bhF+d9NGwwLpwCSwtl/0GE3gKVZW7bGmXV3FGS8IrCQ1J4BYWfsC+mBVIO1Nrm0xt2q+Z/ePM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510256; c=relaxed/simple;
	bh=cwZwxNKzRG9xbdcLf08Ui0qeLmTsHZ+4K6jGY+KbmTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFYaQaJgRkU21TnCeFwEUTeSS9KZ1kCzQZyOoaz9gma0a/X9w2/47GbWYEOXPOKKHkJDpiEbbm8DgVO1z4xUtmT2AKbEggFyorTP9N8SW2eO8oMzyb9qZ3HCkXGTKzaBkUFk1aQxKubU11XaDx9UUJRByCUj+evzrunSJjhk3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xOQiJ839; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h8ivNr7Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O56OvfeW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3iMP0oPR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A9C91F82D;
	Fri,  9 Feb 2024 20:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707510253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zQToUzkILW+4W9P7O1nAk21RTzRP9zevwKA9EqPyth8=;
	b=xOQiJ839u/jesxP8nQcxj9+c03uoIGAKQ7vB+ribAlyJTdGoUxni1eZfXaPdmjbKNdfj80
	A0kGFuRwDWV65IHM+iZfHU2wWegB1hYJXBuifohdjZ3UG//AFD7uqSqnprWylcBwZ2K8Hp
	XeCX9t/SfrOHpzh5dmjc6MpjM8a7Azk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707510253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zQToUzkILW+4W9P7O1nAk21RTzRP9zevwKA9EqPyth8=;
	b=h8ivNr7ZNpwNrdSQ69YQv12VWC8FmWOn0coRfIlmdQ8gb6vw8K5nmSaVjbYFa2kYzMB3wt
	P9t03yitaj/4Z2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707510252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zQToUzkILW+4W9P7O1nAk21RTzRP9zevwKA9EqPyth8=;
	b=O56OvfeW4HeEro8+Tymoe1UuaUVZ37KZ4HH5bZ8fW6wOooeXkpXNkpOxiX1HsYtCxf1kkh
	6I1u3VgxKxnrY4aSRsXsyVLHk4MQe0jFdXJ4U30VYGKVHqoU3IsN2lu3pHTMrKrnh5POYq
	eKgBGU1aLuehhBe11TzXZd3TTejFjsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707510252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zQToUzkILW+4W9P7O1nAk21RTzRP9zevwKA9EqPyth8=;
	b=3iMP0oPRPtCKptMfgc/iqaqMyMBN0Ekurg626k/UC9HEqeS19PM5TeR7vECjKNMYKPpkgh
	kCDYXo/4QWifpSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1249139E7;
	Fri,  9 Feb 2024 20:24:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id haeHMeuJxmUUWAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 09 Feb 2024 20:24:11 +0000
Message-ID: <43ed64aa-17b0-4d04-a1f3-a6e13f59a743@suse.de>
Date: Fri, 9 Feb 2024 21:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/ps3: select VIDEO to provide cmdline functions
To: Michael Ellerman <mpe@ellerman.id.au>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20240207161322.8073-1-rdunlap@infradead.org>
 <e0893d21-606e-429e-a554-c9ee60fd0ae4@suse.de> <8734u28bh8.fsf@mail.lhotse>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <8734u28bh8.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -8.29
X-Spamd-Result: default: False [-8.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,ellerman.id.au:email,csgroup.eu:email,suse.de:email,lists.freedesktop.org:email,ozlabs.org:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,csgroup.eu,kernel.org,linux.ibm.com,lists.ozlabs.org,infradead.org,vger.kernel.org,lists.freedesktop.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

Hi

Am 09.02.24 um 06:15 schrieb Michael Ellerman:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> Am 07.02.24 um 17:13 schrieb Randy Dunlap:
>>> When VIDEO is not set, there is a build error. Fix that by selecting
>>> VIDEO for PS3_PS3AV.
>>>
>>> ERROR: modpost: ".video_get_options" [drivers/ps3/ps3av_mod.ko] undefined!
>>>
>>> Fixes: dae7fbf43fd0 ("driver/ps3: Include <video/cmdline.h> for mode parsing")
>>> Fixes: a3b6792e990d ("video/cmdline: Introduce CONFIG_VIDEO for video= parameter")
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
>>> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Geoff Levand <geoff@infradead.org>
>>> Acked-by: Geoff Levand <geoff@infradead.org>
>>> Cc: linux-fbdev@vger.kernel.org
>>> Cc: dri-devel@lists.freedesktop.org
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Can you take it via whatever tree the CONFIG_VIDEO patch is in?

The patch is now in drm-misc-next.

Best regards
Thomas

>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>
> cheers

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


