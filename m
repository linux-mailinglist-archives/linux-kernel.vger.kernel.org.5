Return-Path: <linux-kernel+bounces-48147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE868457F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0FC428DA5C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360A8663B;
	Thu,  1 Feb 2024 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F4cLai+e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SKyiwdm2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F4cLai+e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SKyiwdm2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AE586626
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791423; cv=none; b=NEW2NUED7TtU0wKeZA4B9vU4391eRE4APHsul0dJxoeqDrc8QVCCrTHTLbZEiTHKfk3oN/k7vS73M2SbHHge4/LKNC+wILcWQqofdWKdGtu+DAx5ECk56lcmrLlf00P9C0TXg3LU4/6erK/SgzKhgGN1R2m0340AKO1vyM3+JPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791423; c=relaxed/simple;
	bh=O0T95lAgksWdwaALLxxvRMhPo3WJzFjjIDUWTtb0eCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cui1ad5VngDuqXCEtH1H4n4O9qJwviKNvQcMGPf/fDaA9W5NKJiqocw6urgmyDlffSlEAr1vKgS1ajZ/+mC9ljvMCn3q2/Ha6pijs+XOpfpzVqLmgafiGXuZRuBRFJ2KanK0r5UeiV8OJk6i22lqKWL7O3oObah4YePc3gm1S9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F4cLai+e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SKyiwdm2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F4cLai+e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SKyiwdm2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6953F21224;
	Thu,  1 Feb 2024 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=F4cLai+eLndNDqg8YFCVtTP1zL1i34bjMCADck/SiU4rXF8uzBriaHtDCUXi5Ms4z9zMXm
	bpfCAyNRcLwBRjNOWJgxyog+kkiIZZsyOKCw5Usu1daaQcvlQRjOLoQGMeMdhL5ki62mxv
	NgJnG+E7hss6hpY41S6PDpcroDC7XcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=SKyiwdm27mplhBRTaDbfoJA74KfKPUGFi80nqLEE2z8ZDJjqKVm2Y6jCB+VA9kbgG6RnjL
	SCDxqYI7cszPo5Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706791420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=F4cLai+eLndNDqg8YFCVtTP1zL1i34bjMCADck/SiU4rXF8uzBriaHtDCUXi5Ms4z9zMXm
	bpfCAyNRcLwBRjNOWJgxyog+kkiIZZsyOKCw5Usu1daaQcvlQRjOLoQGMeMdhL5ki62mxv
	NgJnG+E7hss6hpY41S6PDpcroDC7XcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706791420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U1kNDWukdyI8pp9oNjayP1o3C2QHI4EpojSIoHeSw7I=;
	b=SKyiwdm27mplhBRTaDbfoJA74KfKPUGFi80nqLEE2z8ZDJjqKVm2Y6jCB+VA9kbgG6RnjL
	SCDxqYI7cszPo5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7A60139B1;
	Thu,  1 Feb 2024 12:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kBbBJPqRu2XNOAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 01 Feb 2024 12:43:38 +0000
Message-ID: <2abd09d9-eb35-413f-9447-5ecb6e9839ba@suse.de>
Date: Thu, 1 Feb 2024 13:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/12] nvmet-fc: defer cleanup using RCU properly
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240131085112.21668-1-dwagner@suse.de>
 <20240131085112.21668-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240131085112.21668-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F4cLai+e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SKyiwdm2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 6953F21224
X-Spam-Flag: NO

On 1/31/24 09:51, Daniel Wagner wrote:
> When the target executes a disconnect and the host triggers a reconnect
> immediately, the reconnect command still finds an existing association.
> 
> The reconnect crashes later on because nvmet_fc_delete_target_assoc
> blindly removes resources while the reconnect code wants to use it.
> 
> To address this, nvmet_fc_find_target_assoc should not be able to
> lookup an association which is being removed. The association list
> is already under RCU lifetime management, so let's properly use it
> and remove the association from the list and wait for a grace period
> before cleaning up all. This means we also can drop the RCU management
> on the queues, because this is now handled via the association itself.
> 
> A second step split the execution context so that the initial disconnect
> command can complete without running the reconnect code in the same
> context. As usual, this is done by deferring the ->done to a workqueue.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/target/fc.c | 83 ++++++++++++++++++----------------------
>   1 file changed, 37 insertions(+), 46 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


