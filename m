Return-Path: <linux-kernel+bounces-93413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAE8872F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643631F21683
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658C5C60C;
	Wed,  6 Mar 2024 07:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="akGFVTsK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CHrZSVgV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="akGFVTsK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CHrZSVgV"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EC5BACE;
	Wed,  6 Mar 2024 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709474; cv=none; b=CO7g1O6W+dsT0oURD/BHydpUQln9FSt9YZbCGawECgEKXuIJMb+IcpghuPKs74CGwiRXxrKvA76s/WPmM5vS/SsLiAF3PxtHy/wmi4n81iZq0hylDmJhyAZODFIiIWYImTe7ueuyAYbdIC5K50UZ/N8jmxauutAmaXoAK0bTkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709474; c=relaxed/simple;
	bh=T1CttnZSDGmKuWPpromEDnWe206fs9Nwcvgae8axOTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srTubcUG/3FCotCxczOF9g3X7kfq/MPSHJ4rwFvQ9dLC9uPUdGvWdRZrkIdNN63pLmlx4FadPZYmzdNLlImZUkP4Vlq78kUmsHPS2kgBfHLoRJVCMjVRnIYzk0YCxL3q6i0nsQXo7PVf1wA5Ij6s8lVQujlDqAlMyp5TCyD8VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=akGFVTsK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CHrZSVgV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=akGFVTsK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CHrZSVgV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AFF294D855;
	Wed,  6 Mar 2024 07:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0T/kF77pZuuzjSWamLZYWPGh44WSivUZSdo80F+Xlgk=;
	b=akGFVTsK+J63SPHFios6Oh0QQHTZQGKA0SfDYMvt24bT96SlziYQscMDyNFdFifh4L5/eC
	neYrKUrye4kou1eMYnitUs9GhC56jvVaBIOAF7j5wxodxs6dxhCvPhI0cb4951Jpwf6CC7
	uysmZAIS7vx8/uTOuP0hEs2g4J4qooE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0T/kF77pZuuzjSWamLZYWPGh44WSivUZSdo80F+Xlgk=;
	b=CHrZSVgVNZZDyYC+B5gX/8uBLDRv6RSp927AUF/aKFy2VfkP4uwXD/IKhoBNVoMld63Pcc
	A3aq7eyurrW4iFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709709470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0T/kF77pZuuzjSWamLZYWPGh44WSivUZSdo80F+Xlgk=;
	b=akGFVTsK+J63SPHFios6Oh0QQHTZQGKA0SfDYMvt24bT96SlziYQscMDyNFdFifh4L5/eC
	neYrKUrye4kou1eMYnitUs9GhC56jvVaBIOAF7j5wxodxs6dxhCvPhI0cb4951Jpwf6CC7
	uysmZAIS7vx8/uTOuP0hEs2g4J4qooE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709709470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0T/kF77pZuuzjSWamLZYWPGh44WSivUZSdo80F+Xlgk=;
	b=CHrZSVgVNZZDyYC+B5gX/8uBLDRv6RSp927AUF/aKFy2VfkP4uwXD/IKhoBNVoMld63Pcc
	A3aq7eyurrW4iFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFBCF13A9C;
	Wed,  6 Mar 2024 07:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EKaAN50Y6GWbVgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 06 Mar 2024 07:17:49 +0000
Message-ID: <702392fa-72f5-439d-9ffe-fc2caf91afeb@suse.de>
Date: Wed, 6 Mar 2024 08:17:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] scsi: isci: Add libsas SATA sysfs attributes group
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
 <20240305235823.3308225-8-ipylypiv@google.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240305235823.3308225-8-ipylypiv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-1.01)[87.32%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,oracle.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.10

On 3/6/24 00:58, Igor Pylypiv wrote:
> The added sysfs attributes group enables the configuration of NCQ Priority
> feature for HBAs that rely on libsas to manage SATA devices.
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Jason Yan <yanaijie@huawei.com>
> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
> ---
>   drivers/scsi/isci/init.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


