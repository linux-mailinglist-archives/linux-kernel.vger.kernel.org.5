Return-Path: <linux-kernel+bounces-93402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F366872F45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15D161F22892
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D685C5F8;
	Wed,  6 Mar 2024 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YwbY9gqP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FS6jH7WG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AR0fqbZ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+1MZxUs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA775BAF8;
	Wed,  6 Mar 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709096; cv=none; b=cyq2CDrmOolBX9ZMdpY00SIgaJESpHyriFyIsnCar4ScGvYYe+QZJcReeq4ZsJp6E1XyvtUMdhuFn59VuGFdai1rHEkPZYgfYpUez0h+vRas7QSfd51D0J74p+oGvnoMWu40M3iyT+AtcTD33zLUmuLSUN5ah1H5bjMYr+RMlzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709096; c=relaxed/simple;
	bh=YhKrPy/amOquheLL9RdFMgbTUqIlmhJ/77D3H9BnFw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJQabm0xCDuG+u3cmZAzthLqQjKPobBBdRmCoOfTBx5r5woQbn5O3DqAUdrK8KnsttXcwJFXeqzWFKg9Eebqb0Fqz+tEjZUFlCDxwlkcgeOdzojIWjo3uatHpA83TpjUS25Tifjo7VTggn69ydPvrxhX3yndEg+0EiXm5qSPJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YwbY9gqP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FS6jH7WG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AR0fqbZ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+1MZxUs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E9B1166F62;
	Wed,  6 Mar 2024 07:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCM33cwCiRF+38cxXq/6hPmIFbdWfDRcdcEpot4stXM=;
	b=YwbY9gqPgI+FE0NM7enknD/ivY+BYsy42C6uqcby0GLz9oYs0gJ3jRrGze8V0/gMNVqr34
	ZWGJbxM/j8b9dZafXfwnB4XDfv6h+7SN+q9AHQmE3O1fKXDGJloIiPXtUNirbmzZgOq3aU
	4RV6r+4IASdnqfwg7rRkzw7/D3QEH40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCM33cwCiRF+38cxXq/6hPmIFbdWfDRcdcEpot4stXM=;
	b=FS6jH7WGT6px/bHJdmbbh9TDQvCu29rcvcCZfYlqaIaEQQq8CpsV5wsLHmoms7zkzNSCws
	hJ5FWxnsSN6dfFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCM33cwCiRF+38cxXq/6hPmIFbdWfDRcdcEpot4stXM=;
	b=AR0fqbZ99NaUKR/CJngoI2dK1ex1/I+oe0z7D06qmY4/yJyi0tGvY6hMYOKxOxfI48p0iN
	YIGr0Ar7P/6JxjTvLv7NgE69zsic4fCQXNhInXcT0IFWI1IEPhX99RD/3ram4JQUnvOJMQ
	pTlZeaj2SqiCH/A2lynzCgGmcMLNxbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCM33cwCiRF+38cxXq/6hPmIFbdWfDRcdcEpot4stXM=;
	b=g+1MZxUszRYJgrbarQOvRlbdBpM9VM42hQIy/rmJkz40Sj5DkqaGIr6I1Pwkwwpj6FgAL6
	iRei5r30Un1/UFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49FDF13A9C;
	Wed,  6 Mar 2024 07:11:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hfIxECMX6GUIVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:11:31 +0000
Message-ID: <e1a6c678-77a0-480c-8b7a-73e78198fbcd@suse.de>
Date: Wed, 6 Mar 2024 08:11:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] ata: libata-sata: Factor out NCQ Priority
 configuration helpers
Content-Language: en-US
To: Igor Pylypiv <ipylypiv@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Niklas Cassel <cassel@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Jason Yan <yanaijie@huawei.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
 Bart Van Assche <bvanassche@acm.org>
Cc: TJ Adams <tadamsjr@google.com>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240305235823.3308225-1-ipylypiv@google.com>
 <20240305235823.3308225-2-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-2-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.20
X-Spamd-Result: default: False [-2.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.91)[86.12%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.984];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 3/6/24 00:58, Igor Pylypiv wrote:
> Export libata NCQ Priority configuration helpers to be reused
> for libsas managed SATA devices.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/ata/libata-sata.c | 140 +++++++++++++++++++++++++++-----------
>   include/linux/libata.h    |   6 ++
>   2 files changed, 107 insertions(+), 39 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


