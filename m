Return-Path: <linux-kernel+bounces-22394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5C8829D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B592862D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAF4BA9A;
	Wed, 10 Jan 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VOpNJaMs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zohjO5UF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VOpNJaMs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zohjO5UF"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4824B5D7;
	Wed, 10 Jan 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 956EE1F8C8;
	Wed, 10 Jan 2024 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohF1BkxPR51gt/062RDnKlx1PvxQU5iha3T4q9YWmlo=;
	b=VOpNJaMsIa+Opr8lBdBPaOVgK+mS8SvChEzLGRjdED2UA5EdGt5R7dWFRTwyi9ONNiqd9x
	8A9YDPVZJD7RdiQkBc9KwyK8vYmukPw825vaw5jYpPHgAzA8lmSbpbWedxTQ8bJRah257L
	d5/raTMsQ+K1aMZhNUvQ8AKWIHPzAg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohF1BkxPR51gt/062RDnKlx1PvxQU5iha3T4q9YWmlo=;
	b=zohjO5UFDmJDIZK/PFcn58KaTTUlFKx6TsVBubvDqc3XmSdBM4sVX/+IADLXlOhilJOPJK
	PVCdYjT1DORFTpCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704899186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohF1BkxPR51gt/062RDnKlx1PvxQU5iha3T4q9YWmlo=;
	b=VOpNJaMsIa+Opr8lBdBPaOVgK+mS8SvChEzLGRjdED2UA5EdGt5R7dWFRTwyi9ONNiqd9x
	8A9YDPVZJD7RdiQkBc9KwyK8vYmukPw825vaw5jYpPHgAzA8lmSbpbWedxTQ8bJRah257L
	d5/raTMsQ+K1aMZhNUvQ8AKWIHPzAg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704899186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ohF1BkxPR51gt/062RDnKlx1PvxQU5iha3T4q9YWmlo=;
	b=zohjO5UFDmJDIZK/PFcn58KaTTUlFKx6TsVBubvDqc3XmSdBM4sVX/+IADLXlOhilJOPJK
	PVCdYjT1DORFTpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7020513786;
	Wed, 10 Jan 2024 15:06:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZXH9GnKynmWESAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 10 Jan 2024 15:06:26 +0000
Message-ID: <14ed69c1-cfd8-4b69-8b8f-fda57d66b361@suse.cz>
Date: Wed, 10 Jan 2024 16:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] mm/slub: replace slub_$params with slab_$params in
 slub.rst
Content-Language: en-US
To: sxwjean@me.com, 42.hyeyoo@gmail.com, cl@linux.com, linux-mm@kvack.org
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 roman.gushchin@linux.dev, corbet@lwn.net, keescook@chromium.org,
 arnd@arndb.de, akpm@linux-foundation.org, gregkh@linuxfoundation.org,
 quic_jjohnson@quicinc.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiongwei Song <xiongwei.song@windriver.com>
References: <20231215034150.108783-1-sxwjean@me.com>
 <20231215034150.108783-4-sxwjean@me.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231215034150.108783-4-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -1.74
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spamd-Result: default: False [-1.74 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,me.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SUBJECT_HAS_CURRENCY(1.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 NEURAL_HAM_LONG(-0.97)[-0.966];
	 R_RATELIMIT(0.00)[to_ip_from(RL8m16cxuawb3bjqy6gedmikd6)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-2.99)[99.93%];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,me.com:email,windriver.com:email];
	 FREEMAIL_TO(0.00)[me.com,gmail.com,linux.com,kvack.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On 12/15/23 04:41, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> We've unified slab parameters with "slab_$params", then we can use
> slab_$params in Documentation/mm/slub.rst.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


