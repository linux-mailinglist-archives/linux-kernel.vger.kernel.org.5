Return-Path: <linux-kernel+bounces-138026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C789EB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27FC1C22F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8F22C853;
	Wed, 10 Apr 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nfG/d/g1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LFSEue8h";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nfG/d/g1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LFSEue8h"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1442936137
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731513; cv=none; b=mbGNsWHu3zMZm1KyZDcyPaTeihF4kzGht5iO9eyQD8Xe9/QKVTq3ZsVf4RzdPZHPYMjzyMKEANrOBP9GYibqurY/BLefLQHh85JhTdEmxj5Gv8Y6K4S3Nm1o6ebicBZH2yh0zqKQi7bpgYNxyt+QjEus+cH6T6EXqNcgmsfjve8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731513; c=relaxed/simple;
	bh=y+iFnjEdO5Qxml/LTmXwx3FR01L/d22PgP/7hXtKirA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClOcVyBD/01iqwKdEAwwYMU5cymoSKXxKxx1MdJcKyuYXWfGI9Bvu9Cq/eXBrnT2DKP/3ekGbCsMIZgru+p1RVsuHPkA+Kd9Y6JYDpZrJH31G5HchfAfhuCqGuZaZsSdHgo1jqNsQSq9U0JwPvJWoltwcxJ9CLJR0q9TCaShXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nfG/d/g1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LFSEue8h; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nfG/d/g1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LFSEue8h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D70234A73;
	Wed, 10 Apr 2024 06:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712731510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDRF7PQtkQCG0aLrhRPc0+FdJgwdvpSo2gz/QwDeYmo=;
	b=nfG/d/g1IATCtAisB5qEBzcsGYW3dM7/64Yp8zHneXioAM8JkovzgnKNSYnjq/c7FSNmku
	WmHa++z9d33cD/T5+lJ2jG9OUifdY/eYvi2yG2OeSXqpSaAebnVqdkBXujP9xLavT7e6jp
	fZMmhx/vuyFDxECNlQ051fXq7n/Dl0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712731510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDRF7PQtkQCG0aLrhRPc0+FdJgwdvpSo2gz/QwDeYmo=;
	b=LFSEue8h+2L8qhf1bbvpsnp1+DzIn42l9HXucMhtQEx5Y4u07eWXyAVqHHdJpzQ0obIAZw
	maDiNFa4Ae/BzeAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nfG/d/g1";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LFSEue8h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712731510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDRF7PQtkQCG0aLrhRPc0+FdJgwdvpSo2gz/QwDeYmo=;
	b=nfG/d/g1IATCtAisB5qEBzcsGYW3dM7/64Yp8zHneXioAM8JkovzgnKNSYnjq/c7FSNmku
	WmHa++z9d33cD/T5+lJ2jG9OUifdY/eYvi2yG2OeSXqpSaAebnVqdkBXujP9xLavT7e6jp
	fZMmhx/vuyFDxECNlQ051fXq7n/Dl0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712731510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iDRF7PQtkQCG0aLrhRPc0+FdJgwdvpSo2gz/QwDeYmo=;
	b=LFSEue8h+2L8qhf1bbvpsnp1+DzIn42l9HXucMhtQEx5Y4u07eWXyAVqHHdJpzQ0obIAZw
	maDiNFa4Ae/BzeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D11D313691;
	Wed, 10 Apr 2024 06:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DCZ6MXU1FmZQHwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 10 Apr 2024 06:45:09 +0000
Message-ID: <7e9bf421-cf8e-49a5-8641-41a6ff9a9ffd@suse.de>
Date: Wed, 10 Apr 2024 08:45:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-7-dwagner@suse.de>
 <f8c84937-a3e6-479b-b6a7-be5affc9a937@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <f8c84937-a3e6-479b-b6a7-be5affc9a937@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2D70234A73
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 4/9/24 22:23, Sagi Grimberg wrote:
> 
> 
> On 09/04/2024 12:35, Daniel Wagner wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> A failure in nvmet_setup_auth() does not mean that the NVMe
>> authentication command failed, so we should rather return a protocol
>> error with a 'failure1' response than an NVMe status.
>>
>> Also update the type used for dhchap_step and dhchap_status to u8 to
>> avoid confusions with nvme status. Furthermore, split dhchap_status and
>> nvme status so we don't accidentally mix these return values.
> 
> What is the implications of this on the host behavior? In other
> words, why is this a part of the series?

This issue came up during testing the series, where we found that the 
target would cause connection failure (ie return the NVMe CQE with a
status code) rather than a protocol error (ie return the NVMe CQE
with a 'good' status, and set the 'failure1' status for DH-CHAP).
And with that a termination of the DH-CHAP protocol, and not
a connection reset.
So not directly related, but required to get the testcase for this
series working.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


