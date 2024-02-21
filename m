Return-Path: <linux-kernel+bounces-75049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8D85E228
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB03D1C2225F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8681AC6;
	Wed, 21 Feb 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XNtWvL40";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NhHE5x0C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XNtWvL40";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NhHE5x0C"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB343AAB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530894; cv=none; b=Q9VBd92koDr2Wfgew7Efd09reogXDsq//WbUz53I9YelnbM9iNijRm5L0KMSu4b2XsNvdHPCTKnhUO0s0sbcA1tsWvvR3zq3U+HUKqERcQrEgbdmj0OZGMMtWgtrOZHjpyelTA2EuR/jvjwl9z/LOAQITvwqJ3nFKmTq/7E5myE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530894; c=relaxed/simple;
	bh=yYK8rjdco7k6wR7fbp001J/0WmDT+IOZd2JC50HKr0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LfKkzl0r+GYZCV+6ADENolsIel/bI8/5t3NjgGSeH1S9ipI+U0baV8a3J2ahj7mDtNI5y49HOLqyT5xOFBfUItnByZlT72hcCXYGRYMk2GTRNBKqHzpMrRKrVYkQn8gtnGRgMMaaLLZZhr15/HMOTKj+4KyrplvIkHXqdUWfVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XNtWvL40; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NhHE5x0C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XNtWvL40; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NhHE5x0C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A9F51FB66;
	Wed, 21 Feb 2024 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=XNtWvL40Iu08zXUOV+Sd+vmATzuaOVs9doAzk7GuDloLhRKMTXXVsR+xJSnBSWwUdPijyF
	Sng8zA0PuuVIBPF+5NvGOD+wqwOtw7P7Zi6vFLGToL9uYW3SGnE/8dlIOIFRbDBnk0IG6k
	pJ4ZIuSJ1yOR+ct+92djhpBiTJQHTrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=NhHE5x0CR69m3vLr7eJZgwAjcfuq2WnLoyfrltcZ1b07lYud/ZPEmbGXG3wSk71QLEMX2w
	kYtQulQM/YzpNfBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708530890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=XNtWvL40Iu08zXUOV+Sd+vmATzuaOVs9doAzk7GuDloLhRKMTXXVsR+xJSnBSWwUdPijyF
	Sng8zA0PuuVIBPF+5NvGOD+wqwOtw7P7Zi6vFLGToL9uYW3SGnE/8dlIOIFRbDBnk0IG6k
	pJ4ZIuSJ1yOR+ct+92djhpBiTJQHTrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708530890;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6c+PIWb1/kLk20NMKkb+j7MqFsNYlIIxImscXImM/9c=;
	b=NhHE5x0CR69m3vLr7eJZgwAjcfuq2WnLoyfrltcZ1b07lYud/ZPEmbGXG3wSk71QLEMX2w
	kYtQulQM/YzpNfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CA2E13A69;
	Wed, 21 Feb 2024 15:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YByTCcgc1mWjFgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 Feb 2024 15:54:48 +0000
Message-ID: <95116d62-b254-4973-ad0e-01dc4dae7359@suse.de>
Date: Wed, 21 Feb 2024 16:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] nvme-fabrics: introduce ref counting for
 nvmf_ctrl_options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-4-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240221132404.6311-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XNtWvL40;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NhHE5x0C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: 4A9F51FB66
X-Spam-Flag: NO

On 2/21/24 14:24, Daniel Wagner wrote:
> The FC transport is offloading the connect attempt to a workqueue. When
> the attempt fails the transport is starting to cleanup resources. It is
> possible for user space to trigger a crash because nvmf_ctrl_options are
> exposed to sysfs.
> 
> This crash wasn't observed with blktests nvme/041 until now because the
> retry loop was usually trying for several times (e.g. with defaults
> 600s) and the test would trigger the cleanup itself. Though we the
> recent change not retrying to use invalid credentials the crash can be
> easily triggered.
> 
> The simplest way to control the life time of nvmf_ctrl_options is by
> using ref counting.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 22 +++++++++++++++++++---
>   drivers/nvme/host/fabrics.h |  6 +++++-
>   drivers/nvme/host/fc.c      | 14 +++++++++-----
>   drivers/nvme/host/rdma.c    | 18 +++++++++++++-----
>   drivers/nvme/host/tcp.c     | 21 ++++++++++++++-------
>   drivers/nvme/target/loop.c  | 19 +++++++++++++------
>   6 files changed, 73 insertions(+), 27 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes

-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


