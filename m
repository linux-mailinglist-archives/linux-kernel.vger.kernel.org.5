Return-Path: <linux-kernel+bounces-96793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B870E876187
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1E6282C58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F5C53E00;
	Fri,  8 Mar 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nLMJVFnG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nLMJVFnG"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B6B535DA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892545; cv=none; b=Tr2Tmz27QnAr8hYqiX710JLTiWgGq6x5u9et9yBVyNFvGLX260Lc2pe7uGlTFYpq6IyEpXSGOMAPkP0NTeYHdRXk6rVOwISluZTt4E8oVaxreomISsBYtZo00FGdOtoS52B+OWyhGMGuC5bb6WL9Y7h91Us1WxMQwJHa77kgajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892545; c=relaxed/simple;
	bh=yhXabpfzkpzb+7zRheAauF8VQZNgOnhOBEVfF2RG96Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lq77vb4fdWMcAeja5D+qsarLOR1ubafHMV+9bh0bR1bPq4/LBMTq/tRBOVP1zLNzKATOa5KL3BdJYCJZN5b4UOeaA/nu1Sbkrdhf0/2e4zuUMRCiNLAyEcI1TIYDwSufZOywWOa4Sssp0AYG02Z++S+wDaBZYfaJ1rScX9dyIbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nLMJVFnG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nLMJVFnG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01E311F8AB;
	Fri,  8 Mar 2024 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709892532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55Z06PGrUc9i/TKwm9cfnCBs3ohsbfk4EWQ5k05PE8o=;
	b=nLMJVFnGlmc93Id7CuLOscQoyGwuGD4BV/jh81gYsf01i+0xe8H2mCqtKM3r0a6cgLiQwH
	8J236MJdQSlhDSUDDhy5Ye45f4krAHvsdrhVHUTjGVjTkV66Ke+tkFCLPlgua2P0sjaj5H
	Y/aM4LsxzNwqOdX83FN+yGeGca6aibg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709892532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55Z06PGrUc9i/TKwm9cfnCBs3ohsbfk4EWQ5k05PE8o=;
	b=nLMJVFnGlmc93Id7CuLOscQoyGwuGD4BV/jh81gYsf01i+0xe8H2mCqtKM3r0a6cgLiQwH
	8J236MJdQSlhDSUDDhy5Ye45f4krAHvsdrhVHUTjGVjTkV66Ke+tkFCLPlgua2P0sjaj5H
	Y/aM4LsxzNwqOdX83FN+yGeGca6aibg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D717A13310;
	Fri,  8 Mar 2024 10:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqnZMrPj6mW4aQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Fri, 08 Mar 2024 10:08:51 +0000
Date: Fri, 8 Mar 2024 11:08:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: cve@kernel.org, linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>
Subject: Re: CVE-2023-52496: mtd: maps: vmu-flash: Fix the (mtd core) switch
 to ref counters
Message-ID: <Zerjs8hlMJOXt0Sv@tiehlicka>
References: <20240229155245.1571576-37-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229155245.1571576-37-lee@kernel.org>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nLMJVFnG
X-Spamd-Result: default: False [-4.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -4.81
X-Rspamd-Queue-Id: 01E311F8AB
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 29-02-24 15:52:56, Lee Jones wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> mtd: maps: vmu-flash: Fix the (mtd core) switch to ref counters
> 
> While switching to ref counters for track mtd devices use, the vmu-flash
> driver was forgotten. The reason for reading the ref counter seems
> debatable, but let's just fix the build for now.

Do we really consider build fixes as CVE? 
-- 
Michal Hocko
SUSE Labs

