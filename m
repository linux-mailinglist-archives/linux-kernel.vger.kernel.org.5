Return-Path: <linux-kernel+bounces-93410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67130872F62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8839E1C25324
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1F15C60A;
	Wed,  6 Mar 2024 07:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1jCV9DN/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YscPzTDA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1jCV9DN/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YscPzTDA"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BC1AAC4;
	Wed,  6 Mar 2024 07:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709370; cv=none; b=a+GmRYNQY7qEjLpUbVyIbzWjRZNGLzEPnIPLAu6TKqh7IE439GUk9sydDP4MnaMyISKf/ZSGvmWqWTXnT3dMETwcsBz10t4OQUdduxfrB+gbPy45zx6HrrFH6IcA25TPksoJ8MY+LElbXyLAaIreNjghTh8RPDbd/07W12PHXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709370; c=relaxed/simple;
	bh=KSRZMV1ryZ88m2zV82ZYm8keyR0sWSF8BLW3x19pKEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtTIYQ2+7jhfR40D5zKCaF4xaK4KA7iDMjpAX/OTyqD17UvkUFryP+yD9kPDjQZpjXSUqQJRhp/QmsiZKjfRMytkp1h/nNi7Hz4BKZiB0aY2BClhreTZqbUEcfOWZOX/axYc4XGsyvzXLo1dI3H61RWm/k/wvcpZzGrJM/emqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1jCV9DN/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YscPzTDA; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1jCV9DN/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YscPzTDA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C6723E958;
	Wed,  6 Mar 2024 07:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AukK/yfzTXcwKpkdGJOsno76STYxsjcNXOImRQt/+c=;
	b=1jCV9DN/fL9lwY1Y9vKzAmwJWc0nTMRjj7ePEqiMKX8gXdX25WYpNwt3OBFg6Tjf+BYrrq
	tkAMoMWU2yeTBegdQy7VXeZMNOQyJ7kRbYHO/PwT/bYCBXhT5Ss6W1tJMA64QMcW9gS2AF
	xpHyhMtizliiZY1PdMVOEAaW2gokw5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AukK/yfzTXcwKpkdGJOsno76STYxsjcNXOImRQt/+c=;
	b=YscPzTDAas7TezNJtZG+AtotseiXE2dGMA6X3xK3MMzAoYura1G55nFGnHYi+A8fAmApOA
	ARuFVQavjdLlv1BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AukK/yfzTXcwKpkdGJOsno76STYxsjcNXOImRQt/+c=;
	b=1jCV9DN/fL9lwY1Y9vKzAmwJWc0nTMRjj7ePEqiMKX8gXdX25WYpNwt3OBFg6Tjf+BYrrq
	tkAMoMWU2yeTBegdQy7VXeZMNOQyJ7kRbYHO/PwT/bYCBXhT5Ss6W1tJMA64QMcW9gS2AF
	xpHyhMtizliiZY1PdMVOEAaW2gokw5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8AukK/yfzTXcwKpkdGJOsno76STYxsjcNXOImRQt/+c=;
	b=YscPzTDAas7TezNJtZG+AtotseiXE2dGMA6X3xK3MMzAoYura1G55nFGnHYi+A8fAmApOA
	ARuFVQavjdLlv1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2355213A9C;
	Wed,  6 Mar 2024 07:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YH5rBjQY6GWbVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:16:04 +0000
Message-ID: <5fbc5e14-fa40-455d-8633-4928aa0a61f6@suse.de>
Date: Wed, 6 Mar 2024 08:16:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] scsi: mvsas: Add libsas SATA sysfs attributes
 group
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
 <20240305235823.3308225-5-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-5-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="1jCV9DN/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YscPzTDA
X-Spamd-Result: default: False [-4.97 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-2.67)[98.54%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,huawei.com:email,oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0C6723E958
X-Spam-Level: 
X-Spam-Score: -4.97
X-Spam-Flag: NO

On 3/6/24 00:58, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/scsi/mvsas/mv_init.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


