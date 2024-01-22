Return-Path: <linux-kernel+bounces-32979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16778362BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCD429952C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE23B199;
	Mon, 22 Jan 2024 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="crZf+19Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVwMn2EH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="crZf+19Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oVwMn2EH"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18B4A32;
	Mon, 22 Jan 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924877; cv=none; b=HYn6Fld/u5VDTOtbXIQSkMxRMXTfcKfuDtzf405/IgjYnYBl8DhVwgcbZ1EXWUKt20bQdJJVS0Fh8d5iR0oevAqhA6YI93OF87LPOcFvINfn5N/p9mTWQPiAfjcvOgGz784VTw/kLz/pKIsZS0OJyX/94oIaYTZJvUHt/D5mADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924877; c=relaxed/simple;
	bh=1VtZtnBWb4cvksXRELD4PkgDoJHhj3TooLPlCa7TUj0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3h2wAKS+hdieVM14OYUY7q5XR0z5RW3YTr11OneibkFMe7Hqz57ohsPjEKqrdF4O6cvtZsciYBLsD5DzyImMkt/7W6kKylr9WDGQ62blXlrhmBf0K1BB9izQ2Fq7pQ6u6Jv90KPh6apMUniAXYh1tQOtd/Rri6kXEZbF25OjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=crZf+19Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVwMn2EH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=crZf+19Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oVwMn2EH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6AD1FBF2;
	Mon, 22 Jan 2024 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705924874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMTRRXWQCFQ+HDsmVj133R1M7Raw2++cnrvtPOKdrR8=;
	b=crZf+19ZMQnOUKvQs5CwJcR8/aITXl8l3kdZm5Ocb1HO8EHROEMb0n5IfUplI7kI9qji3q
	PFrUwXMN+WZaTzomo1SDMqOnFSnjXElzR4uHHv7WkZz+nT9v1lot03ofsjApAgAotiMn3N
	pFoLoXqmLwOTzUhRW4acHTNRNNlKvpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705924874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMTRRXWQCFQ+HDsmVj133R1M7Raw2++cnrvtPOKdrR8=;
	b=oVwMn2EHSXIrGZ/JkxD/yh5MULH4xI9yMHh2MzYg9fACakFIpCnWZxMzDnlh8k8E7PwzXN
	iMju2STgp4DJ5zDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705924874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMTRRXWQCFQ+HDsmVj133R1M7Raw2++cnrvtPOKdrR8=;
	b=crZf+19ZMQnOUKvQs5CwJcR8/aITXl8l3kdZm5Ocb1HO8EHROEMb0n5IfUplI7kI9qji3q
	PFrUwXMN+WZaTzomo1SDMqOnFSnjXElzR4uHHv7WkZz+nT9v1lot03ofsjApAgAotiMn3N
	pFoLoXqmLwOTzUhRW4acHTNRNNlKvpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705924874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qMTRRXWQCFQ+HDsmVj133R1M7Raw2++cnrvtPOKdrR8=;
	b=oVwMn2EHSXIrGZ/JkxD/yh5MULH4xI9yMHh2MzYg9fACakFIpCnWZxMzDnlh8k8E7PwzXN
	iMju2STgp4DJ5zDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF660139A2;
	Mon, 22 Jan 2024 12:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rwHYOAlZrmWKJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Jan 2024 12:01:13 +0000
Date: Mon, 22 Jan 2024 13:01:13 +0100
Message-ID: <87ede9y3ue.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for XMOS XVF3500
In-Reply-To: <b888d958-4eb0-4c1f-ace6-b2b85faa5113@wolfvision.net>
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
	<20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
	<333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
	<96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
	<644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
	<5db4b898-93d5-446f-bfed-b57847f9967a@wolfvision.net>
	<435f502c-1e1b-4d40-8dcc-34487905d69c@linaro.org>
	<b7f76546-9998-43e0-abff-a4e73817dbae@wolfvision.net>
	<47bdc31c-50d2-4d33-9339-5132b6364539@linaro.org>
	<16027339-0a82-4dd1-86aa-19fda6e23f88@wolfvision.net>
	<aeeb0dfb-87e2-4024-9d4a-0b9529477315@linaro.org>
	<b888d958-4eb0-4c1f-ace6-b2b85faa5113@wolfvision.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RL17rwhuxjdu7o3ion8yncd616)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,kernel.org,gmail.com,perex.cz,suse.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue, 16 Jan 2024 08:29:04 +0100,
Javier Carrasco wrote:
> 
> On 15.01.24 21:43, Krzysztof Kozlowski wrote:
> > On 15/01/2024 20:43, Javier Carrasco wrote:
> >> On 15.01.24 19:11, Krzysztof Kozlowski wrote:
> >>> On 15/01/2024 17:24, Javier Carrasco wrote:
> >>>> Do you mean that the XVF3500 should not be represented as a platform
> >>>> device and instead it should turn into an USB device represented as a
> >>>> node of an USB controller? Something like this (Rockchip SoC):
> >>>>
> >>>> &usb_host1_xhci {
> >>>> 	...
> >>>>
> >>>> 	xvf3500 {
> >>>> 		...
> >>>> 	};
> >>>> };
> >>>>
> >>>> Did I get you right or is that not the correct representation? Thank you
> >>>> again.
> >>>
> >>> I believe it should be just like onboard hub. I don't understand why
> >>> onboard hub was limited to hub, because other USB devices also could be
> >>> designed similarly by hardware folks :/
> >>>
> >>> And if we talk about Linux drivers, then your current solution does not
> >>> support suspend/resume and device unbind.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>
> >> Actually this series is an attempt to get rid of a misuse of the
> >> onboard_usb_hub driver by a device that is not a HUB, but requires the
> >> platform-part of that driver for the initialization.
> > 
> > That's just naming issue, isn't it?
> > 
> >>
> >> What would be the best approach to provide support upstream? Should I
> >> turn this driver into a generic USB driver that does what the
> >> platform-part of the onboard HUB does? Or are we willing to accept
> > 
> > No, because you did not solve the problems I mentioned. This is neither
> > accurate hardware description nor proper Linux driver model handling PM
> > and unbind.
> > 
> You mentioned the PM handling twice, but I am not sure what you mean.
> The driver provides callbacks for SIMPLE_DEV_PM_OPS, which I tested in
> freeze and memory power states with positive results. On the other hand,
> I suppose that you insisted for a good reason, so I would be grateful if
> you could show me what I am doing wrong. The macro pattern was taken
> from other devices under sound/, which also check CONFIG_PM_SLEEP,
> but maybe I took a bad example or missed something.

FWIW, the patterns in sound/ are somewhat outdated and need to be
refreshed.  Nowadays one should use DEFINE_SIMPLE_DEV_PM_OPS() instead
(that should work without ifdef).


thanks,

Takashi

