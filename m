Return-Path: <linux-kernel+bounces-65259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A632B854A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26561C219D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A145535D4;
	Wed, 14 Feb 2024 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oaT6Cxft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5AXaCrP+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oaT6Cxft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5AXaCrP+"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90724535A9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916610; cv=none; b=BoLfOO4mxX2f3A19ZoeN41oSjfCxR0SFaRi103L54+AI1T5i++e9tQDkywicobS0H+eUWy25PMBsp+otGFXp1+e3TRRsn+FTbs0L9pPkkaURzWtZRTnC75cYVf5GvXKKSIaN2+37L54Mg8+Oirtlsz5GyOkx4VRpsZ5DWkpRZsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916610; c=relaxed/simple;
	bh=nMF7D900qB7XYeTtiEcbn5KoxfgyH96ZarcNfOYj29Y=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDPNSOD5VWXBmhKWxprYcbDAlt2VYigwiqNQlba2/lvQlUo2glDUK24pP2/JJ8HXF2k0go71+w277dpSrYLh8g7BgcY6NYTXGzzfFidzQWnplB3+zxQ2bbgnLLXMG8EOuaUyZ5PT+ahbYmtzBipWTGEgjGcmAbkEB3Ei7y6VefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oaT6Cxft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5AXaCrP+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oaT6Cxft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5AXaCrP+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CC9D21B0C;
	Wed, 14 Feb 2024 13:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707916606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwztXgU1vapEyYEcOwGrqU4Hex/J460ZqBL+bDFz1kI=;
	b=oaT6CxftOQwvmINmAhgBI40ojfcDJMAP9lmDRz1T8z2BqZWd6c933Dz2o7BDNRwxhIUXto
	vs21I1kl6Ui6j3m1ZHLf/hSfA+QgpDi4huIVpr4mAiy3z++3AHVrF5AVHmo/nxGjUcyGrt
	0HyLetW7eCV0Mi3I0LUSBz/zmLyPR6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707916606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwztXgU1vapEyYEcOwGrqU4Hex/J460ZqBL+bDFz1kI=;
	b=5AXaCrP+OYgACcprGvx8kOMuxFzRHPq9PPTDmFsLsi72AX3OPs6O/C+cWsDB2vBUXhK8Je
	0BRQqQ5axkhLPMDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707916606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwztXgU1vapEyYEcOwGrqU4Hex/J460ZqBL+bDFz1kI=;
	b=oaT6CxftOQwvmINmAhgBI40ojfcDJMAP9lmDRz1T8z2BqZWd6c933Dz2o7BDNRwxhIUXto
	vs21I1kl6Ui6j3m1ZHLf/hSfA+QgpDi4huIVpr4mAiy3z++3AHVrF5AVHmo/nxGjUcyGrt
	0HyLetW7eCV0Mi3I0LUSBz/zmLyPR6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707916606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EwztXgU1vapEyYEcOwGrqU4Hex/J460ZqBL+bDFz1kI=;
	b=5AXaCrP+OYgACcprGvx8kOMuxFzRHPq9PPTDmFsLsi72AX3OPs6O/C+cWsDB2vBUXhK8Je
	0BRQqQ5axkhLPMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 365E413A6D;
	Wed, 14 Feb 2024 13:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dlW0Cz69zGWYdgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Feb 2024 13:16:46 +0000
Date: Wed, 14 Feb 2024 14:16:45 +0100
Message-ID: <87v86rgp8i.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"perex@perex.cz"
	<perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Anton
 Yakovlev <Anton.Yakovlev@opensynergy.com>,
	coverity-bot
	<keescook+coverity-bot@chromium.org>,
	Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables" warning.
In-Reply-To: <FR3P281MB2527A0498C3B1E3899087028E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
	<20240213035806-mutt-send-email-mst@kernel.org>
	<FR3P281MB25272BA9CC886E270EEAE380E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
	<20240214062348-mutt-send-email-mst@kernel.org>
	<871q9fi8dw.wl-tiwai@suse.de>
	<FR3P281MB2527A0498C3B1E3899087028E64E2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oaT6Cxft;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5AXaCrP+
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 TAGGED_RCPT(0.00)[coverity-bot];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8CC9D21B0C
X-Spam-Level: 
X-Spam-Score: -4.31
X-Spam-Flag: NO

On Wed, 14 Feb 2024 14:07:40 +0100,
Aiswarya Cyriac wrote:
> 
> 
> On Wed, 14 Feb 2024 12:30:19 +0100,
> Michael S. Tsirkin wrote:
> >>
> >> On Wed, Feb 14, 2024 at 09:08:26AM +0000, Aiswarya Cyriac wrote:
> >> > Hi Michael,
> >> >
> >> > Thank you for reviewing. I have updated my response inline
> >> >
> >> > On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> >> > >> Fix the following warning when building virtio_snd driver.
> >> > >>
> >> > >> "
> >> > >> *** CID 1583619:  Uninitialized variables  (UNINIT)
> >> > >> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> >> > >> 288
> >> > >> 289         break;
> >> > >> 290       }
> >> > >> 291
> >> > >> 292       kfree(tlv);
> >> > >> 293
> >> > >> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> >> > >> vvv     Using uninitialized value "rc".
> >> > >> 294       return rc;
> >> > >> 295     }
> >> > >> 296
> >> > >> 297     /**
> >> > >> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> >> > >> 299      * @snd: VirtIO sound device.
> >> > >> "
> >> > >>
> >> > >> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> >> > >> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> >> > >> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> >> > >> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> >> > >> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> >> >
> >> > >I don't know enough about ALSA to say whether the patch is correct.  But
> >> > >the commit log needs work: please, do not "fix warnings" - analyse the
> >> > >code and explain whether there is a real issue and if yes what is it
> >> > >and how it can trigger. Is an invalid op_flag ever passed?
> >> > >If it's just a coverity false positive it might be ok to
> >> > >work around that but document this.
> >> >
> >> > This warning is caused by the absence of the "default" branch in the
> >> > switch-block, and is a false positive because the kernel calls
> >> > virtsnd_kctl_tlv_op() only with values for op_flag processed in
> >> > this block.
> >>
> >> Well we don't normally have functions validate inputs.
> >> In this case I am not really sure we should bother
> >> with adding dead code. If you really want to, add BUG_ON.
> 
> > Please don't use BUG_ON() in such a case...
> > There is no reason to break the whole operation.
> 
> How about adding a WARN_ON() on default case?

That's better :)


thanks,

Takashi

