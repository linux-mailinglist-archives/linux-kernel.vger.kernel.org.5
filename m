Return-Path: <linux-kernel+bounces-156995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA68B0B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 752041C203F7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B2615D5AD;
	Wed, 24 Apr 2024 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PIYwUILg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xf4MurGk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PIYwUILg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xf4MurGk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD5158DDD;
	Wed, 24 Apr 2024 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966148; cv=none; b=FHCzjS9GKjK+Cd/eVvOl1oyLOGF1gWCBJVSzg86CZ/QaLmN5dQIotMZT96urTN1UIn9h+faueHoSPmKEuY9p9TOHf3R2+xlSVzShceY//8qKbRKNp9RaydvccOPOvQA3dBSsZ9dezpnhyRE/zHCO/ddif+pJ6KlEI0eGluuprYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966148; c=relaxed/simple;
	bh=bNx8k2bgyvRuen8Wg8IeG/ZTMn7ghMosAG2nurMOmkw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1B8TZt+0vw4rIKU1PAmF72FPmVMXqqVfLshHHymE8fYU1TO8ku29g/LggIxut2NrIxXCUCyGTnwOYnI8H5X2D4HEYMAvP4/zdKzUVcwtYdzu0z53pfegmqqVwMgzuq1WyEZMp8nho2DSWFXEyBXi/0ngdExrfULPPoj6uyknRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PIYwUILg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xf4MurGk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PIYwUILg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xf4MurGk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1FC66E58;
	Wed, 24 Apr 2024 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713966144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg2qv+cKjg7lV92iv/LpJqsoqWYIPU+fAiMDC1vNkJ8=;
	b=PIYwUILgn5mj7wcUSy00BMiX9xKR6H24XQQq4ebj+dW+Vl8ajUxzIPATCfc/09/PBKcVCF
	fsWPHHocdGReX2JP8VQnAoML1grkNnCnXsRbDcLtZ5WwWZEp9Din5dB4fWpdHyvE4iBGYM
	j0zL8YxdYIxkDGenRxU3LH7IWwJdzH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713966144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg2qv+cKjg7lV92iv/LpJqsoqWYIPU+fAiMDC1vNkJ8=;
	b=xf4MurGk5Ir4zd5WHE56JnEVwf7EDfCuhghqAkp+ILXhLX91wj+fASNqGMEjEfsSseSOTc
	ZPPRzJf1pglOouDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PIYwUILg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xf4MurGk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713966144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg2qv+cKjg7lV92iv/LpJqsoqWYIPU+fAiMDC1vNkJ8=;
	b=PIYwUILgn5mj7wcUSy00BMiX9xKR6H24XQQq4ebj+dW+Vl8ajUxzIPATCfc/09/PBKcVCF
	fsWPHHocdGReX2JP8VQnAoML1grkNnCnXsRbDcLtZ5WwWZEp9Din5dB4fWpdHyvE4iBGYM
	j0zL8YxdYIxkDGenRxU3LH7IWwJdzH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713966144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hg2qv+cKjg7lV92iv/LpJqsoqWYIPU+fAiMDC1vNkJ8=;
	b=xf4MurGk5Ir4zd5WHE56JnEVwf7EDfCuhghqAkp+ILXhLX91wj+fASNqGMEjEfsSseSOTc
	ZPPRzJf1pglOouDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3803313690;
	Wed, 24 Apr 2024 13:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mMiDDEAMKWb7BgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Apr 2024 13:42:24 +0000
Date: Wed, 24 Apr 2024 15:42:34 +0200
Message-ID: <87jzkmdghh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <87pluedgx5.wl-tiwai@suse.de>
References: <CABXGCsNmEtrN9DK-XmESaPm_1xpXm8A+juE+44Jf6AK5JE0+TQ@mail.gmail.com>
	<874jcl7e83.wl-tiwai@suse.de>
	<CABXGCsMmRFW3EYJ3UvNd-LO7ZTOyoNqjc_3OAmaCDSL=LuxJqg@mail.gmail.com>
	<87v851e2di.wl-tiwai@suse.de>
	<CABXGCsNMBRUaY-V8mhUQKdq+CQW5+eGUWL_YCJWXo0cgh9bGJQ@mail.gmail.com>
	<87h6glt9zc.wl-tiwai@suse.de>
	<CABXGCsMcazRvmiN4XtiHQCE9=dB=M=VsRqB=v+RPmtuhBL29DA@mail.gmail.com>
	<a6f4e20ea2a68f56a7d2c4d76280bca44d6bf421.camel@gmail.com>
	<CABXGCsPdqfXeZUw1ocx8O3NdOEb+h4yQ77+zdNpcwP_4JrYXuQ@mail.gmail.com>
	<CABXGCsMTbmU4CP8CHUqRVXWkGiErFtEVG4COy6RSRWsAuK_-CQ@mail.gmail.com>
	<87pluedgx5.wl-tiwai@suse.de>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,mega.nz:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,perf-with-revert-587d67fd929a-beb45974dd49.data:url,perf-with-revert-587d67fd929a.data:url]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4E1FC66E58
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Wed, 24 Apr 2024 15:33:10 +0200,
Takashi Iwai wrote:
> 
> On Wed, 24 Apr 2024 15:21:26 +0200,
> Mikhail Gavrilov wrote:
> > 
> > On Thu, Apr 18, 2024 at 11:22 AM Mikhail Gavrilov
> > <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > On Tue, Apr 2, 2024 at 12:29 AM <mikhail.v.gavrilov@gmail.com> wrote:
> > > >
> > > > On Mon, 2024-04-01 at 21:50 +0500, Mikhail Gavrilov wrote:
> > > > > On Mon, Apr 1, 2024 at 7:48 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > >
> > > > > > Then it shouldn't be dmix/dsnoop.  You'd better try profiling
> > > > > > what's
> > > > > > going on there.  e.g. try to get perf results with and without the
> > > > > > commit.
> > > > >
> > > > >
> > > > > Here is original perf files:
> > > > > [1] perf-with-revert-587d67fd929a.data -
> > > > > https://mega.nz/file/EpZmXbgL#vEnxuODoB__jM6TwV6XbwC_TWMMqvT7qaWkJU22JY48
> > > > > [2] perf-with-revert-587d67fd929a-beb45974dd49.data -
> > > > > https://mega.nz/file/0lI31CDA#hKsv6vX7t5u-Sx1_p2E7-Y32-z5VFPlW2Y793oM-JRU
> > > > >
> > >
> > > Excuse me. Can you have time to look in my perf files?
> > >
> > 
> > This is a friendly reminder
> 
> Honestly speaking, it's your role to analyze what's going on.
> Such a performance issue is pretty much dependent on the installed
> system, so giving a perf data to me won't help much, unfortunately.

That said, maybe the first thing you can try would be to check who is
actually calling the corresponding function
(snd_timer_close_locked()).  Put a debug print or a tracing hook to
watch out for figuring out.  If the commit was really relevant, it
must be called very frequently and concurrently, and I don't know
really who does it except for dmix/dsnoop.


Takashi

