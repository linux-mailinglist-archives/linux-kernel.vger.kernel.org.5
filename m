Return-Path: <linux-kernel+bounces-80911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2E8866DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ADDB1C2377D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D0F481BD;
	Mon, 26 Feb 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oX1QNv/s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kVXS+5AQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pa6N4nXt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6T2U4WS+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465F45C15;
	Mon, 26 Feb 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936339; cv=none; b=WD/SFskRfwW6zw50edJl/B15bIR5KEpzZFxYe/JuCybtO4jEyuPgSi3fmbN+Xmud5gsQIm4RweXpFbxmsKT/50rZaEhdr9uar6COB1MfRFH/G60iHfaGmOxUZLI2COx9BhUBlU6GU/EiH8/ZjZ0Vfs/7+G24MNfeSsIw8tjWQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936339; c=relaxed/simple;
	bh=T0a3wdRVtsycBiIf77BP4SMHFUGD0zsy5Ek93RlMHcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkT/b8E9BAHzQef22R5eTTogXjNGszN0YKvJ7sCEZu/XuJD2KlgK0IF2GKnpEEc+N3BDPtlWltwoLmk3/g5ptGjU+XQhvAYsHR9/0vxUpdoGopYd9UtAhh4cRgFtEwI6EHLbEkE07Y04F4kOhk0nhKqlTR2DIj1I9lCX1uJLLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oX1QNv/s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kVXS+5AQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pa6N4nXt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6T2U4WS+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C980B1F911;
	Mon, 26 Feb 2024 08:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708936333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyXqqDQ2t8ePG++k2k0I3bejH0Ru+OjYUizfw98W8JI=;
	b=oX1QNv/s+OMiW+SxXCMZIsDsHvnifJyIx5BVVRWnaN/4Vy3m2JkCiClnoWtfB54mFDHiaB
	BJohmwiZsnOD9bUIldBaAOsyhx301u07w9ncLstXd5ufsFSNyRp2w46HnGs2pXSgreKcEy
	ks6L8h/VQdR8vFG0UyuEnMNWuDrgqw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708936333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyXqqDQ2t8ePG++k2k0I3bejH0Ru+OjYUizfw98W8JI=;
	b=kVXS+5AQywkgJ9EDUzh2zOQHBdvctwRgUTTG2JxyfvrOdGUIvQU3FtdJrmZNZlviJlpZVF
	iqfeoQRO6tTs4VBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708936332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyXqqDQ2t8ePG++k2k0I3bejH0Ru+OjYUizfw98W8JI=;
	b=Pa6N4nXtUw4v1BPnCvq1WsAST1pWYpiXckWmtHPaXoJgOBieI3Vp5AYTkF+HYuHXlYOfBY
	U8F0SsCn/NE2yEO2UyOaPz/WCLAsxjyOSsA64eGVCK6TbICAXFZZZ99H/LYAUOxXJ1acrK
	NHmw34aaYu3llC/PTZaNswdFxoXFfJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708936332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyXqqDQ2t8ePG++k2k0I3bejH0Ru+OjYUizfw98W8JI=;
	b=6T2U4WS+HjgY1KoJJdHz5U6Uvzn3CX5ln+t5kEcZF0/4srMecPsI83y3UtOUCb+MXqfjwG
	CRTFw/hq+Np9EFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1F5E13A58;
	Mon, 26 Feb 2024 08:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkcYK4xM3GVOEgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 26 Feb 2024 08:32:12 +0000
Message-ID: <cb1e2218-9a50-4c42-8a46-a35193208442@suse.cz>
Date: Mon, 26 Feb 2024 09:32:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ceph: remove SLAB_MEM_SPREAD flag usage
To: Xiubo Li <xiubli@redhat.com>, Chengming Zhou <chengming.zhou@linux.dev>,
 idryomov@gmail.com, jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240224134715.829225-1-chengming.zhou@linux.dev>
 <b6083c49-5240-40e3-a028-bb1ba63ccdd7@redhat.com>
 <d91e3235-395a-4e63-8ace-c14dfaf0a4fd@linux.dev>
 <35df81f5-feac-4373-87a3-d3a27ba9c9d4@redhat.com>
 <82c2553f-822e-40c2-9bf8-433689b3669d@linux.dev>
 <69589d2f-978d-4d14-9e5f-6bd6b3a43062@redhat.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <69589d2f-978d-4d14-9e5f-6bd6b3a43062@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Pa6N4nXt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6T2U4WS+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FREEMAIL_TO(0.00)[redhat.com,linux.dev,gmail.com,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: C980B1F911
X-Spam-Flag: NO

On 2/26/24 05:54, Xiubo Li wrote:
> 
> On 2/26/24 12:30, Chengming Zhou wrote:
>> On 2024/2/26 12:23, Xiubo Li wrote:
>>> On 2/26/24 10:42, Chengming Zhou wrote:
>>>> On 2024/2/26 09:43, Xiubo Li wrote:
>>>>> Hi Chengming,
>>>>>
>>>>> Thanks for your patch.
>>>>>
>>>>> BTW, could you share the link of the relevant patches to mark this a no-op ?
>>>> Update changelog to make it clearer:
>>>>
>>>> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>>>> removed as of v6.8-rc1, so it became a dead flag. And the series[1]
>>>> went on to mark it obsolete to avoid confusion for users. Here we
>>>> can just remove all its users, which has no functional change.
>>>>
>>>> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
>>> Thanks for your quick feedback.
>>>
>>> BTW, I couldn't find this change in Linus' tree in the master and even the v6.8-rc1 tag, please see https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/slab.h?h=master.
>>>
>>> Did I miss something ? Or has this patch been merged ?
>> You're right, this patch hasn't been merged. But it's already a dead flag as of v6.8-rc1.
>>
>> Update changelog to make it clearer:
>>
>> The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
>> removed as of v6.8-rc1, so it became a dead flag since the commit
>> 16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
>> series[1] went on to mark it obsolete to avoid confusion for users.
>> Here we can just remove all its users, which has no functional change.
>>
>> [1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/
>>
>> Does this look clearer to you? I can improve it if there is still confusion.
> 
> Yeah, much clearer, thanks!
> 
> Maybe we should just wait for the [1] to get merged first ?

It's really not necessary to wait, [1] just makes it explicit but the flag
is really effectively dead since v6.8-rc1 because nothing acts on it.


