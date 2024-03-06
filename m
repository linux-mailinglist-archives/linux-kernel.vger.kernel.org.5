Return-Path: <linux-kernel+bounces-93411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555FC872F66
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69631F22928
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F354B5C615;
	Wed,  6 Mar 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Akrd+OQv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5c0EUpqT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Akrd+OQv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5c0EUpqT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B91AAC4;
	Wed,  6 Mar 2024 07:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709398; cv=none; b=rtBwN5rZYKsImXwXvZs7U202o+/EM+tMyAliKzySwRuBSjLGYqyNjIyT/Fef/XGq/b/tZlUfLm7i9jDdn5Jp6U6cb9G8IDYdsepJS4hmQNPu9vbM6hcHuzCNCkSkMYcHGsDnYg4QlSQEcmHphLDruH4a/K6lfJIuqPWa3y/o6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709398; c=relaxed/simple;
	bh=pCGlr6H1t4CnFqUe4Tn93VN0RWb7bi4B7Qu7pH5fnFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8yhBo3ZFm0JOKPeEdRQr36ekcAJjfok2IcT6/b76YudEB2GAesUf96dAbyr3whwIpFIg8zCK2xTA4En3tQIsI9b86dlyEmRLy8R3mSJtBMN4Lw53opn3mHkj+f5yy2AqWQb3Bo3P+oPw+2EBzhnDk59/vIjSMIFCdr7hlIAfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Akrd+OQv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5c0EUpqT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Akrd+OQv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5c0EUpqT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F18C4D854;
	Wed,  6 Mar 2024 07:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otwJ3uF9QkMI8K72XNVa7IgBoIQnv10uSjDp7p6E6IM=;
	b=Akrd+OQv+tZ3PWk6gK/W9JDvIhmxNb9V3AhyrsG/sXS8+exfDf5yDJ72nVPkYAV5QDdsJZ
	ooDUgDcXfyeLk4Uj9xb4vYyymKic5/SPvfPiVscq6DV3JEOt2r1HMiWz6oEScJ4QTlhF9t
	ZC5k+ARnHK4mAiH7AnLHaQP+C9W0uWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otwJ3uF9QkMI8K72XNVa7IgBoIQnv10uSjDp7p6E6IM=;
	b=5c0EUpqTf0HPlNi8UoW+h2jLty7lGP/wKXEeKV8wSUrjfZtjxcJp39M8+xehbtqZ6gKW6Q
	ffsZX80X7Zd/DPAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otwJ3uF9QkMI8K72XNVa7IgBoIQnv10uSjDp7p6E6IM=;
	b=Akrd+OQv+tZ3PWk6gK/W9JDvIhmxNb9V3AhyrsG/sXS8+exfDf5yDJ72nVPkYAV5QDdsJZ
	ooDUgDcXfyeLk4Uj9xb4vYyymKic5/SPvfPiVscq6DV3JEOt2r1HMiWz6oEScJ4QTlhF9t
	ZC5k+ARnHK4mAiH7AnLHaQP+C9W0uWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otwJ3uF9QkMI8K72XNVa7IgBoIQnv10uSjDp7p6E6IM=;
	b=5c0EUpqTf0HPlNi8UoW+h2jLty7lGP/wKXEeKV8wSUrjfZtjxcJp39M8+xehbtqZ6gKW6Q
	ffsZX80X7Zd/DPAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EC7C13A9C;
	Wed,  6 Mar 2024 07:16:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2P6lFFIY6GWbVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:16:34 +0000
Message-ID: <2613c0e3-399f-4ddf-9f9d-c17bd2bdb15a@suse.de>
Date: Wed, 6 Mar 2024 08:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] scsi: hisi_sas: Add libsas SATA sysfs attributes
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
 <20240305235823.3308225-6-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-6-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.14 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.05)[87.75%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.de:email,oracle.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.14

On 3/6/24 00:58, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 6 ++++++
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 6 ++++++
>   2 files changed, 12 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


