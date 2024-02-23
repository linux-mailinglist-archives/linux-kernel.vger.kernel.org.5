Return-Path: <linux-kernel+bounces-78262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FE8610E5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2005B20CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F97B3E3;
	Fri, 23 Feb 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tauqtti8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jeiub6Yb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tauqtti8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jeiub6Yb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6297AE7E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689542; cv=none; b=L0duK7EXroLZfmVBlhRa4yysksbJyF9uJqXyvnCCK9Px5u51WwTqsXxEoaMtgNwbbthsnI2LOAO1BT/80XFTb2yZWFYq+o0e/Ag2T3xWSFYf88CDaqCWpIRIsUyEOfMdxI99obF96zExNljQ17sjMC1wY69uZb9dUQE9sNyMNl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689542; c=relaxed/simple;
	bh=7vfrNB0uBqzU7Jo9nAc5SQOAi+BT9Affyka2FJIO6s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz6qNZTFh9T17nOFpNy5F6mZE9Op0+llbwW3UbyVFbLGfydb/EoXcUiiOb+rbByGuJHGtcy+ORyiJ7AUHDwgmrEqmAlZ9WiMRjro/7yezSX9Q9qtmFdipXGhUGkbTRr1BO+HDV2YZ2Knq1of2P/tbTY5gEuhIj7fmv3PfP9cKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tauqtti8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jeiub6Yb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tauqtti8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jeiub6Yb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A1991FBF2;
	Fri, 23 Feb 2024 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708689538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKWHi5n5fOcYQOJlh34zxx7zAiKRtlNS/pw+UPmx+jY=;
	b=tauqtti8K90dYZdbldhDtQ7oAONgt8b4Wk9FfOZ4uqfHh0b4fLazFmWEWUpAsmuTp61/Ee
	h2IJCnPfrktbjkDDZWW9xPPDSdY7acUG5SchJlzoiD+IPGguB1aXYpl0hq+XYCFVNJkqse
	H6Xb0vTNdOGemgyccci3puzSnODds4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708689538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKWHi5n5fOcYQOJlh34zxx7zAiKRtlNS/pw+UPmx+jY=;
	b=jeiub6YbE+gcPY8sKD3M2vbc1mNrDahzuTLUiIyJ7ho8v4HIcFg2TuWJAPALk2H7DTB+FF
	J1HlTCj2zXVINSAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708689538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKWHi5n5fOcYQOJlh34zxx7zAiKRtlNS/pw+UPmx+jY=;
	b=tauqtti8K90dYZdbldhDtQ7oAONgt8b4Wk9FfOZ4uqfHh0b4fLazFmWEWUpAsmuTp61/Ee
	h2IJCnPfrktbjkDDZWW9xPPDSdY7acUG5SchJlzoiD+IPGguB1aXYpl0hq+XYCFVNJkqse
	H6Xb0vTNdOGemgyccci3puzSnODds4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708689538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PKWHi5n5fOcYQOJlh34zxx7zAiKRtlNS/pw+UPmx+jY=;
	b=jeiub6YbE+gcPY8sKD3M2vbc1mNrDahzuTLUiIyJ7ho8v4HIcFg2TuWJAPALk2H7DTB+FF
	J1HlTCj2zXVINSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45BF7132C7;
	Fri, 23 Feb 2024 11:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JOmnCIKI2GXRbAAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 23 Feb 2024 11:58:58 +0000
Message-ID: <5d67a55e-e979-4c3c-8dcc-597cb13c7c9d@suse.de>
Date: Fri, 23 Feb 2024 12:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or
 connection is refused
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240221132404.6311-1-dwagner@suse.de>
 <20240221132404.6311-3-dwagner@suse.de>
 <d5b3d5b2-ec27-4057-aa76-63fe17066cfc@suse.de>
 <sqmla42yoidail73xukhxb6uoyayo66pxpdlrhns3v533wm7wy@ppyr7t5gk3u3>
 <609e0031-e97c-466b-8cbd-47755374b117@suse.de>
 <3xhhdconprn3vvkky4yj4iazku4eiqxl6l6rw6z5tivvdjwaby@ts7satqbih7w>
 <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <hxr2hztb64dank3jvbnrlciaebo4k2qkkrg3brhrppizeyelpo@ewupxurl7iqm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

On 2/22/24 18:02, Daniel Wagner wrote:
> On Thu, Feb 22, 2024 at 08:45:04AM +0100, Daniel Wagner wrote:
>> On Thu, Feb 22, 2024 at 07:46:12AM +0100, Hannes Reinecke wrote:
>>> On 2/21/24 17:37, Daniel Wagner wrote:
>>>> On Wed, Feb 21, 2024 at 04:53:44PM +0100, Hannes Reinecke wrote:
>>>> In this case yes, I've tested on top of this patch. This breaks the loop
>>>> where the provided key is invalid or is missing. The loop would happy
>>>> retry until reaching max of retries.
>>>
>>> But that's to be expected, no?
>>
>> Why? If the key is wrong/missing it will be likely wrong/missing the
>> next retry again. So what's the point in retrying?
>>
>>> After all, that's _precisely_ what
>>> NVME_SC_DNR is for;
>>> if you shouldn't retry, that bit is set.
>>> If it's not set, you should.
>>
>> Okay, in this case there is a bug in the auth code somewhere.
> 
> With the change below nvme/041 also passes:
> 
> modified   drivers/nvme/host/fabrics.c
> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>   			dev_warn(ctrl->device,
>   				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>   			goto out_free_data;
>   		}
>   		/* Authentication required */
> @@ -475,7 +475,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   		if (ret) {
>   			dev_warn(ctrl->device,
>   				 "qid 0: authentication setup failed\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>   			goto out_free_data;
>   		}
>   		ret = nvme_auth_wait(ctrl, 0);
> @@ -540,8 +540,9 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   		/* Secure concatenation is not implemented */
>   		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>   			dev_warn(ctrl->device,
> -				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +				 "qid %d: secure concatenation is not supported\n",
> +				 qid);
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>   			goto out_free_data;
>   		}
>   		/* Authentication required */
> @@ -549,7 +550,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
>   		if (ret) {
>   			dev_warn(ctrl->device,
>   				 "qid %d: authentication setup failed\n", qid);
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
>   		} else {
>   			ret = nvme_auth_wait(ctrl, qid);
>   			if (ret)
> 
> Is this what you had in mind?

Which, incidentally, is basically the patch I just posted.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


