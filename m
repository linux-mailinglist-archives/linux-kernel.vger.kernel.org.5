Return-Path: <linux-kernel+bounces-54144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7A84AB74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8DA28930B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F44691;
	Tue,  6 Feb 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aex2GQHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C5YAA1RZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aex2GQHF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C5YAA1RZ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2091361;
	Tue,  6 Feb 2024 01:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182060; cv=none; b=tikYGiTDFREEC1Ev4XYd1MFA+a6dKach7i1gs9OuwqK1plRA3DlRb5IB3lI7SIEXA8oC8Lf62BcLTQ0QpFp9jtTvS6SeSsx7JJ9+Sw3y7/jhf81Uj0IZh1GE2Qkssa/J3tg/FdCtnZt8eLX60bn7Z2SM/hsWCuK3cN2U+nl2ahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182060; c=relaxed/simple;
	bh=F8Hvf1QeiETO7+L1PqIcHzakau86I1STWf/wMtgoTJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAn5OXGUY3yR851qMlKbTgPM/sHO4eT5hMYSR1z+otooFEKqZ2CNpMCEBdPOfFYyUTltTkkA9oWvFLmq8QB5GJHTJrdA4JXep3cdmyMyRIj7xyUCzhMocnG7lg+BulULAOFWpk5mgisqJqDoUkE1IvQhN57y699GBPpXwnIUzOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aex2GQHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C5YAA1RZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aex2GQHF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C5YAA1RZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90AE922124;
	Tue,  6 Feb 2024 01:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707182055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiIFSjMANUa+9UeiEF/545Jd5pXGZvoSBum87AnCT2E=;
	b=aex2GQHFdr90InjB1m0y0FRlXWW8krJ+6UcQ3j+vV0RZdafKAHt2MVJI8tZdpnw3OVAbpD
	oYeInO7pwp4wjZ8vAOWlYmxK2+QOBwM7sorh9RY7ne87Ybu3za0e2Qhp/XN1ruohkJoJxK
	uQlmmdUswax/yL+C2+wn8aMG41kvUIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707182055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiIFSjMANUa+9UeiEF/545Jd5pXGZvoSBum87AnCT2E=;
	b=C5YAA1RZf/zgENhOoR9KJ9cDyTo0p4LoEopNJ5wbHnP9HgXWkJYla7yFVET0TUUN1GBBnq
	mfbAMXBTi3xQXQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707182055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiIFSjMANUa+9UeiEF/545Jd5pXGZvoSBum87AnCT2E=;
	b=aex2GQHFdr90InjB1m0y0FRlXWW8krJ+6UcQ3j+vV0RZdafKAHt2MVJI8tZdpnw3OVAbpD
	oYeInO7pwp4wjZ8vAOWlYmxK2+QOBwM7sorh9RY7ne87Ybu3za0e2Qhp/XN1ruohkJoJxK
	uQlmmdUswax/yL+C2+wn8aMG41kvUIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707182055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UiIFSjMANUa+9UeiEF/545Jd5pXGZvoSBum87AnCT2E=;
	b=C5YAA1RZf/zgENhOoR9KJ9cDyTo0p4LoEopNJ5wbHnP9HgXWkJYla7yFVET0TUUN1GBBnq
	mfbAMXBTi3xQXQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F729132DD;
	Tue,  6 Feb 2024 01:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YexqO+WHwWXrAgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 06 Feb 2024 01:14:13 +0000
Message-ID: <e671344b-259e-44c8-9197-d5b3a76c2459@suse.de>
Date: Tue, 6 Feb 2024 10:14:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "scsi: fcoe: Fix potential deadlock on
 &fip->ctlr_lock"
Content-Language: en-US
To: Lee Duncan <leeman.duncan@gmail.com>, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lee Duncan <lduncan@suse.com>
References: <cover.1706632031.git.lduncan@suse.com>
 <83489c47c973bdf7c47e4bf3acbc57dfca1e5dd7.1706632031.git.lduncan@suse.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <83489c47c973bdf7c47e4bf3acbc57dfca1e5dd7.1706632031.git.lduncan@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 BAYES_HAM(-0.00)[41.51%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.09

On 1/31/24 00:42, Lee Duncan wrote:
> From: Lee Duncan <lduncan@suse.com>
> 
> This reverts commit 1a1975551943f681772720f639ff42fbaa746212
> 
> This commit causes interrupts to be lost for FCoE devices,
> since it changed sping locks from "bh" to "irqsave".
> 
> Instead, a work queue should be used, and will be addressed
> in a separate patch.
> 
> Fixes: 1a1975551943f681772720f639ff42fbaa746212
> Signed-off-by: Lee Duncan <lduncan@suse.com>
> ---
>   drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)
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


