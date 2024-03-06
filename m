Return-Path: <linux-kernel+bounces-93409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5969C872F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52F4B23810
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5FF5C60B;
	Wed,  6 Mar 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cZh7HqCy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UJo1k+Zp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cZh7HqCy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UJo1k+Zp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE51AAC4;
	Wed,  6 Mar 2024 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709318; cv=none; b=n357VBUDCNQJnjt2zzXePYz7qd//aHj5N4U97tbpAOfRzx3XpvGygl3CEAc5C+ydkDgRyU067ExgO3vy1JLh48ytPZ6U2Z69JirCoqLACCzAR3Y6X+4OIsL5KBqif2t4PJP8FpQt6+pqtafwsyljRqpLjU6ZgqyJwgxp9prPIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709318; c=relaxed/simple;
	bh=cTMrati/2d75PyVw7AR/vtMiVSilJiYFdNTI0db5PHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeRoT/hKwVs5IeQQgCktYggBLG3WUfeEtJXYNPq9wSl+YLejgbdCy0fJHD/paltufKH0S8vX9hwcsZfkXc9Bvr0SeI+X1+k4R6HHZxgQ1kEogMycjPPz+PinYvgX6/17hSPTHoIFGKjs/TB3L+Y0rcXUyXgtiW53VCs+Ynjfrzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZh7HqCy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UJo1k+Zp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cZh7HqCy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UJo1k+Zp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6117C222AB;
	Wed,  6 Mar 2024 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRlOo89EP1cHc9fsgiqoAKMH3juwGr/V2xri8U9cCxU=;
	b=cZh7HqCyO1N8O0XrLzIYgOkZV3Ifg5jQWH3TNiyO7kpUoq81Dz6LPkc14TX8spI1FEZM2o
	tMpUzQZcyw9v/tp/yE9pg+QD451KaeZ4SJUkd77ZNffYkCniFd7Ze2fzqTcJj4Zaq+xH6B
	gvOEPPVVBR5AMzszwec7qAMfQvX21VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRlOo89EP1cHc9fsgiqoAKMH3juwGr/V2xri8U9cCxU=;
	b=UJo1k+ZpCcRUX0AawQjqKlU9P9+njw2LF/AnxJbfhKoxEfCqVkBqZ+gGfCLMTTvwrqTlAe
	f1NW6zCFKabAenBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRlOo89EP1cHc9fsgiqoAKMH3juwGr/V2xri8U9cCxU=;
	b=cZh7HqCyO1N8O0XrLzIYgOkZV3Ifg5jQWH3TNiyO7kpUoq81Dz6LPkc14TX8spI1FEZM2o
	tMpUzQZcyw9v/tp/yE9pg+QD451KaeZ4SJUkd77ZNffYkCniFd7Ze2fzqTcJj4Zaq+xH6B
	gvOEPPVVBR5AMzszwec7qAMfQvX21VI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709315;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRlOo89EP1cHc9fsgiqoAKMH3juwGr/V2xri8U9cCxU=;
	b=UJo1k+ZpCcRUX0AawQjqKlU9P9+njw2LF/AnxJbfhKoxEfCqVkBqZ+gGfCLMTTvwrqTlAe
	f1NW6zCFKabAenBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96C6313A9C;
	Wed,  6 Mar 2024 07:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IF/PHwIY6GWbVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:15:14 +0000
Message-ID: <ea48d3c9-61db-4302-8f72-9e6c5ef92ba0@suse.de>
Date: Wed, 6 Mar 2024 08:15:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] scsi: pm80xx: Add libsas SATA sysfs attributes
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
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jack Wang <jinpu.wang@ionos.com>
References: <20240305235823.3308225-1-ipylypiv@google.com>
 <20240305235823.3308225-4-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-4-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cZh7HqCy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UJo1k+Zp
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.16 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.66)[92.89%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,oracle.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.988];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -5.16
X-Rspamd-Queue-Id: 6117C222AB
X-Spam-Flag: NO

On 3/6/24 00:58, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Acked-by: Jack Wang <jinpu.wang@ionos.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/scsi/pm8001/pm8001_ctl.c  | 5 +++++
>   drivers/scsi/pm8001/pm8001_init.c | 1 +
>   drivers/scsi/pm8001/pm8001_sas.h  | 1 +
>   3 files changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


