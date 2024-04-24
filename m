Return-Path: <linux-kernel+bounces-156975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A548B0B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AAD5285C07
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04383161B43;
	Wed, 24 Apr 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sop4bmSo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SbWIQVdq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u2m1/OkP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uaNNuVqK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4115E1EA;
	Wed, 24 Apr 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965587; cv=none; b=dGp20zg+yp9/vLANIQK9nBqWsWX79hmD5VHRdZ807KOGtryDE+uaCLvOqVjLxEMRhUWT4I8gOeAUIzkC/nEQVqjP4Jlg4F5N8MmDDtBN1Aks8U/udnuhqwniaZTmG8csLmiga/Vx4EzfSUWwdWVXPYNx5lPsz07cjPPjV7tW4qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965587; c=relaxed/simple;
	bh=xGM3axw9Nc0Vwgmuov6OzoEUptEGR94rSz+AQR+vYRE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFCDlwtx7UM2fV/CN4rh9+J2EXbjP/QfY7AqLut8VaFKfJGg2ZBh77BdSzJOw7z4ByN3ucWpBPB0chS2tZq3R11Q0lh6zKhyyR4/Kfcj90AXv4RdpaP3D1Js6ajtalEpYJA13+RcR+U/gGyB6GQyrh95y0jBkxwHasOVCMPPkk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sop4bmSo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SbWIQVdq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u2m1/OkP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uaNNuVqK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D08FE3F1B7;
	Wed, 24 Apr 2024 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713965581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdLubxRWW70xVO87VipJCEWfzm9tyhsFYLo2KZHWbzg=;
	b=Sop4bmSoZbc2ShOd89HyyEY5loHL+pREPcmGRX1Wd66Q58xwPMCDyq0vfVS2Ids3hact54
	x7zmn/A+XWQqpbFIZV3yU7vp2G0ytsjc2WZrrsMXG4XbWoK0JSnuwYJDnn8LxTRk+XNjkL
	ZEV2OSy6Yy61aDtn+jwpbbBvzKm+18A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713965581;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdLubxRWW70xVO87VipJCEWfzm9tyhsFYLo2KZHWbzg=;
	b=SbWIQVdqVsvD2KudedQW4NE2swGtLFnzXyOK31PNO79MdYMivGFOU6zW5G6dfCtksbo6Pw
	z54Idm7+kWtDokCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713965580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdLubxRWW70xVO87VipJCEWfzm9tyhsFYLo2KZHWbzg=;
	b=u2m1/OkPh/vP4J+9n6ok+Avr+UiraCwW2Y55gBiwUva9aX3oYLfxyeiIwZJJsPMbYBgLmj
	ErqCupipr49A3piAcNjskAoI2VwBal5lk5yYPzw+EL8laAgDapvmPc9m4mr/s7789BzNM1
	yf2fYYhvhh1urLqLZ7zcgKAAGUO6N5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713965580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdLubxRWW70xVO87VipJCEWfzm9tyhsFYLo2KZHWbzg=;
	b=uaNNuVqKh6QKDUjOvpPKDjzxg0WlfrVEXXjCwlTiH0rRffaCXlB4cnpxzwLP+qIGVqmBbA
	270vz6e+tAhwPRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA23313690;
	Wed, 24 Apr 2024 13:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jcKhLAwKKWb+AwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 24 Apr 2024 13:33:00 +0000
Date: Wed, 24 Apr 2024 15:33:10 +0200
Message-ID: <87pluedgx5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
	linux-sound@vger.kernel.org
Subject: Re: regression/bisected/6.9 commit 587d67fd929ad89801bcc429675bda90d53f6592 decrease 30% of gaming performance
In-Reply-To: <CABXGCsMTbmU4CP8CHUqRVXWkGiErFtEVG4COy6RSRWsAuK_-CQ@mail.gmail.com>
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
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]

On Wed, 24 Apr 2024 15:21:26 +0200,
Mikhail Gavrilov wrote:
> 
> On Thu, Apr 18, 2024 at 11:22 AM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > On Tue, Apr 2, 2024 at 12:29 AM <mikhail.v.gavrilov@gmail.com> wrote:
> > >
> > > On Mon, 2024-04-01 at 21:50 +0500, Mikhail Gavrilov wrote:
> > > > On Mon, Apr 1, 2024 at 7:48 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > >
> > > > > Then it shouldn't be dmix/dsnoop.  You'd better try profiling
> > > > > what's
> > > > > going on there.  e.g. try to get perf results with and without the
> > > > > commit.
> > > >
> > > >
> > > > Here is original perf files:
> > > > [1] perf-with-revert-587d67fd929a.data -
> > > > https://mega.nz/file/EpZmXbgL#vEnxuODoB__jM6TwV6XbwC_TWMMqvT7qaWkJU22JY48
> > > > [2] perf-with-revert-587d67fd929a-beb45974dd49.data -
> > > > https://mega.nz/file/0lI31CDA#hKsv6vX7t5u-Sx1_p2E7-Y32-z5VFPlW2Y793oM-JRU
> > > >
> >
> > Excuse me. Can you have time to look in my perf files?
> >
> 
> This is a friendly reminder

Honestly speaking, it's your role to analyze what's going on.
Such a performance issue is pretty much dependent on the installed
system, so giving a perf data to me won't help much, unfortunately.


Takashi

