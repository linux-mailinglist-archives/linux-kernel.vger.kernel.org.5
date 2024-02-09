Return-Path: <linux-kernel+bounces-59234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887184F393
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4472288726
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D811F951;
	Fri,  9 Feb 2024 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W20FpOxA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cSRrLAeT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W20FpOxA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cSRrLAeT"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3011CD2E;
	Fri,  9 Feb 2024 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475117; cv=none; b=uHfz+98WvYIMAfG+fKFH7eFw71XRiFe+Mjiweo91gALVSvOMx+qgcmQo1Wp7H2i0VYO17Byqh7842wYlevsGf+tJkxXbMIJemm9PHibS6nZoV9QnYao15RW3eMGcYahrwl13X4kBLdA8CW9XPtYmvUy12RqvHQuKBC8aHB5yhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475117; c=relaxed/simple;
	bh=NLCu0xxeKmLv5966mc08pfon0VtvvF6i/4Pcp3LPTFg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b48UPSjMR7DJLL6ws6YwOeWa/eEorUVdISfPsybrRRWd2PVr0Xnp1/jgMHzEFYJFQQr7/KrpriXwvAbD4CxGdkQZSr3aBMX/gGtwOB+CqCyJUDwen0ID05OIUjqp1iC4EWtNl3dpcyBE4iARdsEt1meQSF8HuAN9dmtixND60pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W20FpOxA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cSRrLAeT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W20FpOxA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cSRrLAeT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C5761F7F9;
	Fri,  9 Feb 2024 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707475114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6Slx034B94xqhyjrIysxXhS3MNMSPMgz7N4W/H2K3M=;
	b=W20FpOxAO1xMci6rvRzFEcMQEkpCDpJb6iQB2JFQZl9M2xZoD7Ekoud+XrYMH/hwMUQ5S9
	vtN8SE+ABQG6t2SnbFze0pQt6Kyt+DDhL/VEPdjPXdNKcV+PANjWDlsPkI61AMQfzhJIGV
	Wn96O8AgqVyuhfQpj6wGfl953BWyqDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707475114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6Slx034B94xqhyjrIysxXhS3MNMSPMgz7N4W/H2K3M=;
	b=cSRrLAeTvFszTG1osmmpvW66rNsm8CWNK/arn5LmCjG4kB6Fe3+fzbmLA+tilmmV9Xit18
	KOtWoSYs+osCqzBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707475114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6Slx034B94xqhyjrIysxXhS3MNMSPMgz7N4W/H2K3M=;
	b=W20FpOxAO1xMci6rvRzFEcMQEkpCDpJb6iQB2JFQZl9M2xZoD7Ekoud+XrYMH/hwMUQ5S9
	vtN8SE+ABQG6t2SnbFze0pQt6Kyt+DDhL/VEPdjPXdNKcV+PANjWDlsPkI61AMQfzhJIGV
	Wn96O8AgqVyuhfQpj6wGfl953BWyqDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707475114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+6Slx034B94xqhyjrIysxXhS3MNMSPMgz7N4W/H2K3M=;
	b=cSRrLAeTvFszTG1osmmpvW66rNsm8CWNK/arn5LmCjG4kB6Fe3+fzbmLA+tilmmV9Xit18
	KOtWoSYs+osCqzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C1F41326D;
	Fri,  9 Feb 2024 10:38:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cSwEFakAxmXkJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 09 Feb 2024 10:38:33 +0000
Date: Fri, 09 Feb 2024 11:38:32 +0100
Message-ID: <87wmrd2a8n.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: <srinivas.kandagatla@linaro.org>,
	<mathias.nyman@intel.com>,
	<perex@perex.cz>,
	<conor+dt@kernel.org>,
	<corbet@lwn.net>,
	<lgirdwood@gmail.com>,
	<andersson@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>,
	<gregkh@linuxfoundation.org>,
	<Thinh.Nguyen@synopsys.com>,
	<broonie@kernel.org>,
	<bgoswami@quicinc.com>,
	<tiwai@suse.com>,
	<robh+dt@kernel.org>,
	<konrad.dybcio@linaro.org>,
	<linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-usb@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>,
	<alsa-devel@alsa-project.org>
Subject: Re: [PATCH v14 41/53] ASoC: Introduce SND kcontrols to select sound card and PCM device
In-Reply-To: <20240208231406.27397-42-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
	<20240208231406.27397-42-quic_wcheng@quicinc.com>
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
X-Spam-Level: *
X-Spam-Score: 1.20
X-Spamd-Result: default: False [1.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[34.56%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[dt];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLjs3ec4aura4kmsd6wxjjm4hg)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linaro.org,intel.com,perex.cz,kernel.org,lwn.net,gmail.com,linuxfoundation.org,synopsys.com,quicinc.com,suse.com,vger.kernel.org,alsa-project.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri, 09 Feb 2024 00:13:54 +0100,
Wesley Cheng wrote:
> 
> Add SND kcontrol to SOC USB, which will allow for userpsace to determine
> which USB card number and PCM device to offload.  This allows for userspace
> to potentially tag an alternate path for a specific USB SND card and PCM
> device.  Previously, control was absent, and the offload path would be
> enabled on the last USB SND device which was connected.  This logic will
> continue to be applicable if no mixer input is received for specific device
> selection.
> 
> An example to configure the offload device using tinymix:
> tinymix -D 0 set 'SNDUSB OFFLD device select' 1 0

As I mentioned in another patch, the control element name should be
more understandable.  The same applied even for ASoC stuff.
The current name is way too cryptic.


thanks,

Takashi

